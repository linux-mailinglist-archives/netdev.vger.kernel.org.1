Return-Path: <netdev+bounces-220379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E71B45AE3
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 16:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BFE33B6249
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 14:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22712148850;
	Fri,  5 Sep 2025 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UJiu6OXI"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B12572633;
	Fri,  5 Sep 2025 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083670; cv=none; b=qbmx8aOWRBeCgVgk5lw4BycGUufqrOAYg1XqUvpKHXGtmmkUJPD8Wu+zSndQAc0u+0SRbEt6m7ZP6CU9E2R8lUfCUh5ExOn0NjvMVjd+KR79Fa73UpUms80H9/ZGzOkTMY+wTdeHzurwqfRyjYUfyuAdlCzTMXew87InxktqhI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083670; c=relaxed/simple;
	bh=h1Xy4bqc15Ds0H/78OXHDsavq2SGfz2eRcUEAtt4oE4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fOuTF/HgPa518kFcU828MH9RIbW1h/C27xB0ee0GkwOol0zMvqGlLVXqFTuQ5vL4pRW/A4iaOB8xB8odviXk2J8n6V3r7JYJAB9xpYbTz9iTxmwjp9ynKYABED0PA1chXnIDB9FrYc8/xSJ7BcpXVaiDnZuz27kRGqyvaHhk8x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UJiu6OXI; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=h1Xy4bqc15Ds0H/78OXHDsavq2SGfz2eRcUEAtt4oE4=;
	b=UJiu6OXI5AavtPzhLN1Kofo1z4/mjuDuf8f7hXpPPIysJw60p5fGC4jQ18d9fB
	9HdqadTKVX6zEPdg5aw8/QpApbldKNF2eDviQnDYpxrYQFpAo14BFtnkzkv2Am4o
	s2sjeNfYSWFXasTPdeO9CH7j8CfaQVrQ+A3DIpWsF2/NU=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCn3+7r97poi7SDBw--.26819S2;
	Fri, 05 Sep 2025 22:47:09 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: kerneljasonxing@gmail.com,
	willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	ferenc@fejes.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 2/2] net: af_packet: Use hrtimer to do the retire operation
Date: Fri,  5 Sep 2025 22:47:07 +0800
Message-Id: <20250905144707.2271747-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCn3+7r97poi7SDBw--.26819S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw1xJr4kGFyftF48uw43Awb_yoWDKFc_ur
	4qkwn7Aa1DJ3W8Ka12ga1aywn2qrWUGF1jq3W8XwnxK3WrJ3ykC3ZY9FZa9FW8Gw1fWrZx
	Cws5JrW7A34I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbknY7UUUUU==
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbibh+-Cmi6gnFuvgABs0

On Fri, Sep 5, 2025 at 14:45 +0800 Jason Xing <kerneljasonxing@gmail.com> wrote:

> BTW, I have to emphasize that after this patch, the hrtimer will run
> periodically and unconditionally. As far as I know, it's not possible
> to run hundreds and thousands packet sockets in production, so it
> might not be a huge problem. Or else, numerous timers are likely to
> cause spikes/jitters, especially when timeout is very small (which can
> be 1ms timeout for HZ=1000 system). It would be great if you state the
> possible side effects in the next version.

The original logic actually involves an unconditional restart in the timer's
callback. You might be suggesting that if packets come in particularly fast,
the original logic would reset the timeout when opening a new block in
tpacket_rcv, so the timeout does not expire immediately. However, if packets
arrive very quickly, it will also lead to frequent timeout resets, which can
waste CPU resources.
I will emphasize in the comments that the current hrtimer expiration logic
is unconditional and periodic.


Thanks
Xin Zhao


