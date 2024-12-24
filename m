Return-Path: <netdev+bounces-154147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975F79FBA64
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 09:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190CC164880
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 08:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7778E17B502;
	Tue, 24 Dec 2024 08:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jDVbPfh7"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3EE8C1F;
	Tue, 24 Dec 2024 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735027576; cv=none; b=KlD7lX51dN+kP5nYfm/9RDJ3ZfyS9tbo4+pKZJ9cjFGpTMT4JHhFhWO4Yi/V/yLXzy49Alm6TQ7MGWiBciaQc6ZPtc6JO204IB9ANiGMOwp9Ov0ppuDbl7flG8Fo3FQqc4XBg1NBBcpXLa/CPTjoJ1hXuU2MDcjZWCMTN9tlhXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735027576; c=relaxed/simple;
	bh=/+xGxWn+p0197JAsrDSurq5Fnv+bQM76vSAHr0rdtUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aFUAxrCR2vYX9veB108lkkuuRHhPWtB2iABNWlF6xq1GYipYTlAiHZJvUoeZ0CW34L3GaNMTQeXAvmdfB7s+xG5tj7cm6aZBfU04BxjlgCpf9htnCihsUtn4LnbBMuvidvkWNl8LPBTk4Bi6NWoI7ZAPQyac3yM38tKvto+J8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jDVbPfh7; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=glvX/
	AB4xBfbkPMXgdvhLDl4VeWwCOyTyaDey7aXuKU=; b=jDVbPfh7NGm4EVEfUrz7I
	cVJ0dgMVf8d92M9U/rgmnXLna7bJQzr1PXL5q8t/arbWoWgHAEL5WxPPgUrV0jQa
	87YuIrDKxL6PJZtzsJojpLWcXT8K/RNrW7SI5Cb/TtkGBpLKo4IpAaSE7UNje5hr
	Fb5+d03ppjtW4Gp1+ZvKf0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3n9tMa2pnrr9XBQ--.5962S2;
	Tue, 24 Dec 2024 16:05:34 +0800 (CST)
From: PeilinHe <peilinhe2020@163.com>
To: olteanv@gmail.com
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	fan.yu9@zte.com.cn,
	he.peilin@zte.com.cn,
	jiang.kun2@zte.com.cn,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	qiu.yutan@zte.com.cn,
	tu.qiang35@zte.com.cn,
	wang.yaxin@zte.com.cn,
	xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn,
	ye.xingchen@zte.com.cn,
	zhang.yunkai@zte.com.cn
Subject: Re: Re: [PATCH linux next] net:dsa:fix the dsa_ptr null pointer dereference
Date: Tue, 24 Dec 2024 08:05:32 +0000
Message-Id: <20241224080532.3958498-1-peilinhe2020@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241220112738.7maahbhxi2fnaven@skbuf>
References: <20241220112738.7maahbhxi2fnaven@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n9tMa2pnrr9XBQ--.5962S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyDArWxWryrKr1UtF48Xrb_yoW5JFW3pa
	1rJ3ZFkrWDGFnrKw4fWw4xAa4rZwsYk3y5CF1rKry8u3y5XFyxtryIga1a9a4Duw4Fgay2
	qrW5XFykC3ykA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRAWrAUUUUU=
X-CM-SenderInfo: xshlzxhqkhjiisq6il2tof0z/1tbiVgS-sWdqZcCSoQAAsH

>Thank you for the patch.
>
>There are many process problems with it however.
>
>The most glaring one is that you are examining a crash from kernel 5.4
>but patching linux-next, without having apparently also tested linux-next.
>It appears that you just made a static analysis which may result in
>incorrect conclusions. When submitting patches upstream you always have
>to test on the latest version and understand afterwards what is missing
>and needs to be backported in the particular stable version you are using.
>
>In particular here, dsa_switch_shutdown() now has this:
>
>	dsa_switch_for_each_user_port(dp, ds) {
>		conduit = dsa_port_to_conduit(dp);
>		user_dev = dp->user;
>
>		netif_device_detach(user_dev);
>		~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>		netdev_upper_dev_unlink(conduit, user_dev);
>	}
>
>After netif_device_detach() is called, my expectation is that
>ethnl_ops_begin() sees that netif_device_present() is false, so it
>returns -ENODEV and does not proceed further to call into the device's
>ethtool ops. So that eliminates the premise for the crash.
>
>Secondly, linux-next is not a kernel tree that accepts patches, it is
>just for integration. For netdev, we have net.git for bug fixes and
>net-next.git for new features. You have to target your patch to net.git
>by using "[PATCH net v1]".
>
>If the problem does not exist in net.git but exists in stable kernels,
>you have to identify which patches are missing, adapt them if necessary,
>and then send them to stable@vger.kernel.org, with netdev and the other
>maintainers also CCed, and with a subject prefix along the lines of
>"[PATCH stable 5.4]". Generally, backporting patches manually to stable
>is rarely needed, so if that needs to happen, please use the space under
>the "---" marker (this is discarded when applying the patch in git) to
>explain to maintainers why (what conflicted, if it simply appears to
>have been missed, etc).
>
>There are other things to be aware of in Documentation/process/, I just
>summarized to you what I considered most relevant here.

Thank you for your feedback.
First, I apologize for an error in my previous commit description. 
The kernel version that experienced the panic was actually 5.15.
Second, netif_device_present() does indeed prevent the null pointer 
dereference of dsa_ptr.
Finally, this issue still persists in the 5.15 stable release, 
therefore, following your suggestion, I will submit the relevant 
patch to the 5.15 stable branch.


