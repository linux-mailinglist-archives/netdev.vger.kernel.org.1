Return-Path: <netdev+bounces-214383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 322E4B29399
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 16:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52133B87C8
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 14:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6942AD00;
	Sun, 17 Aug 2025 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LaL3aKri"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3497F1114;
	Sun, 17 Aug 2025 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755442091; cv=none; b=mTak7NgHBATGQEpBj9Qi5pskX2bDlFO25PnL8nVQlEFIf02hWw/1ZhBWrtrQstcIG3WegWNZK7wRqDJohPowv1C84d6YWYXY4yuqxubGbdK1VEAVWOvy1gUr8GHryAXbRopGLo0W1XNP+aUT0J407bv9VxCEj1ELbcxndROV8Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755442091; c=relaxed/simple;
	bh=QnrFYLFxC489JtiUIGnXfu7Ko851gVF5JuO/DK2Mgh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U8B4ppwcSiqH9hZfiVX1Jjb5egqNRS9yaa+CGlhfWdbEps5zEL9DmTHh5GL5Hax3y236K/UPAZsG3+JPuwEeIRAQViBxyPFdvk5XElzmEvkrUD4BWhqVLQnseU+bGa1Pki+JHV9TII9Dgya0k4jhScblTMzRJ5gRR38ZLNg7nz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LaL3aKri; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=HH
	yS6OUYKPjh1c54sIKQnhRGQUzMfOCmTqIpdFYyv9Q=; b=LaL3aKriSWDpQ075sw
	CJ87RRTGL0DoSAnMib7XibfFocXAr7BU3hDVyI5lJRBCmdiOpLBt9EZBhnH47L45
	8IEasAvLyHC/z1MAdj8+VQJDrWzp2aBq/jAFlsZ+jSUmdQ39t/U+v1LeU5NMIX4O
	zqXmHjDxs3zl6eQMB88A3lDe0=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wA3nI9t66Folth8Cg--.4857S2;
	Sun, 17 Aug 2025 22:47:10 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	ferenc@fejes.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: af_packet: Use hrtimer to do the retire operation
Date: Sun, 17 Aug 2025 22:47:09 +0800
Message-Id: <20250817144709.3599024-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3nI9t66Folth8Cg--.4857S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF17Ww1xKFyUGFWxurWruFg_yoWfAFg_C3
	4qvF1xGwn8JayrKa1akFs8Xryagw4qkay5G3yrt3sFg3s8XFW7Grs3WryfCFyxCa17Kr9x
	GF4DJ3y7AwnrWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbyEEUUUUUU==
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbibg+sCmih3ircJQAAsD

On Sun, 2025-08-17 at 21:28 +0800, Willem wrote:

> Here we cannot use hrtimer_add_expires for the same reason you gave in
> the second version of the patch:
> 
> > Additionally, I think we cannot avoid using ktime_get, as the retire
> > timeout for each block is not fixed. When there are a lot of network packets,
> > a block can retire quickly, and if we do not re-fetch the time, the timeout
> > duration may be set incorrectly.
> 
> Is that right?
> 
> Otherwise patch LGTM.


I'll think about whether there's a better way to implement the logic.

Additionally, regarding the previous email where you mentioned replacing retire_blk_tov
with the interval_ktime field, do we still need to make that change?
I noticed you didn't respond to my latest patch that replaces retire_blk_tov with
interval_ktime, and I'm wondering if we should make that change.
So we remain the retire_blk_tov field?


Thanks
Xin Zhao


