Return-Path: <netdev+bounces-214444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE16B298F3
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 07:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0514E6280
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 05:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B21C26D4E2;
	Mon, 18 Aug 2025 05:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BzWKWW/p"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12294232369;
	Mon, 18 Aug 2025 05:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755495536; cv=none; b=Vw30iVIXF2VjqMgDK1jDT4/OSBEhQz9zn7foGEBQWMWkYdoriZVjCYzU08jtM+tDDKxcrrDQdi6uvsm6vNsyD+/ebVwCy0ofthEu+mYiikLo84Z35FpPfA3cukffysBoJhuj3oB2HMrHJBcHAUYYCCnJywYEJftPskK0VVn933s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755495536; c=relaxed/simple;
	bh=WXkskIoUMTcih3XN5uZjpg3i50lBSE5iYL5oWoSArRk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hZzPWOpl3WAB0V2Ee/XtBAytynhkA/xuuq5846IxwLHz1V6tzgosRqj5j3yNK5B9NuSMI5Rr7hsKa5tcsHo6iqLVV7Q+bAC34v+mmhGXp9Ot3qXcol5bZYmsa3XBQjzhfiAjXp8OLmlHyIV7zIFBBvQNRcGNPHkOWvHNxdnE7J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BzWKWW/p; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=6x
	QBO8BmLfIhv1bH3fnhD/r9YrTwsHkZZb2dWVwWJaU=; b=BzWKWW/p4PyrxpKAQL
	0JA2D4mj6A1lv0B/qNNmz1ffIo7sL+2hVqb/VNPPW+lrlxJRBbw2+sqlE331jwbV
	jVB4JD6wUZIw/AeZ5dJzxJ/RRfQgAg2St/EoJQvie22S9xrL/EIxVLPoKKTFBg16
	OnQL3Ij6fn/1W2PAXExvreNkw=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCXlVBDvKJoSGHACA--.42003S2;
	Mon, 18 Aug 2025 13:38:13 +0800 (CST)
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
Date: Mon, 18 Aug 2025 13:38:11 +0800
Message-Id: <20250818053811.181754-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXlVBDvKJoSGHACA--.42003S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF17Ww1xKFyUXr1fAw1UWrg_yoWkZwbE9r
	yDZF1DWws0ganxGF43Gw47XrWfta1UJw1UJ3yUCwn2g34DuFWDCFs5WryF9Fn5JanFkFnI
	kr4fJr42yw13WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbBc_3UUUUU==
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiRwStCmiitxl+TwAAsx

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


Dear Willem,

I have adjusted the logic in the recently sent v4 version by adding a boolean variable start
to distinguish whether it is the case of prb_open_block. If it is prb_open_block, I use
hrtimer_start to (re)start the timer; otherwise, I use hrtimer_set_expires to update the
expiration time. Additionally, I have added comments explaining this branch selection before
the _prb_refresh_rx_retire_blk_timer function.

I apologize for sending three PATCH v4 emails in a row. In the first email, I forgot to include
the link to v3. In the second email, there were no blank lines between v4 and v3.
Therefore, you can just refer to the latest v4 version in the third PATCH v4 email.


Thanks
Xin Zhao


