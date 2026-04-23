Return-Path: <netdev+bounces-280675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPq3CAfj6WlQmgIAu9opvQ
	(envelope-from <netdev+bounces-280675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:14:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFD944F1EC
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9A943006144
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816843E0220;
	Thu, 23 Apr 2026 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="N00BaMEH"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE6136828B
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776935312; cv=none; b=Wah8UkwN94a+i44ry7eNLBzJyegceSw+y1jGYhG0xPDi6XW6lz5x2VzAtPczeI+tUbW2EExCKXuhj3oAbqFemLv5KyOaXxBcCcSsvdFXa7RxX4qqKhKdhRxAkbdIIhhMwIBKMMqHo5u+VkH6irMG848rSIL5cYjIIBYfSAoU2l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776935312; c=relaxed/simple;
	bh=r3kHVrluazrYYrDklNG/TrMUVX5CgIch3zRJ/KB1h5c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=ShFJHfwv/bQqqHYQoPLy2kHYxBTWq4LxTxIhveuMJ4xZoi6DKg0mH9FWVrPu82q/MeyDrXMHnERj3uHILz9mv/SUIKWxjF/YhPsJEAzvAoOUtUE9mr1IPKG09NLrGKgApNb8PSPMXgn1ID9My6iJg9lOsI1ek0L+n4vRIp3lr7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=N00BaMEH; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260423090828euoutp0259df7df0f145fec0fbda84364beda319~o8T_w3gEZ0539505395euoutp02I
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 09:08:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260423090828euoutp0259df7df0f145fec0fbda84364beda319~o8T_w3gEZ0539505395euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776935308;
	bh=wDBCWCKH25r3rzgbP56Jfhz7Hk9W93MZ0Xv826+RJBw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N00BaMEHjfQ8ysK/zJO0guD2i953Z2z8NHQqo5I2qmfPJrM9w5C539OBF6OFyef5E
	 d6TnEiVWxfHYQ1ztF5WqbkkDa+A9KMVyzjkS7a+cfGkfgsl2w76a+RPB/bAFiYHo9Z
	 Ehn/Js6B/jr+nyAGlWIYhnM403tgH2ym0Wv/R1m0=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260423090828eucas1p204606b1be37253296ac938bad852e8f4~o8T_JYoD82360223602eucas1p2l;
	Thu, 23 Apr 2026 09:08:28 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260423090827eusmtip2f7824fdaa66107f46994835bd820dac6~o8T9sjupi0699706997eusmtip2L;
	Thu, 23 Apr 2026 09:08:27 +0000 (GMT)
Date: Thu, 23 Apr 2026 11:08:24 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, andrew+netdev@lunn.ch, kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] net/stmmac: Fix typos: 'tx_undeflow_irq' ->
 'tx_underflow_irq'
Message-ID: <aenhiHCZge2dMBFw@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <52b06f0a-8283-4903-9d8a-2bbdf637dd5d@lunn.ch>
X-CMS-MailID: 20260423090828eucas1p204606b1be37253296ac938bad852e8f4
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----hExaTKD8pSV4C1.mHO0xNjZioIzStKhMnOXfyxqZoi0.l2l2=_2e513_"
X-RootMTR: 20260421115052eucas1p103281c5b25719a44c0875d6b0860bfa6
X-EPHeader: CA
X-CMS-RootMailID: 20260421115052eucas1p103281c5b25719a44c0875d6b0860bfa6
References: <CGME20260421115052eucas1p103281c5b25719a44c0875d6b0860bfa6@eucas1p1.samsung.com>
	<20260421115008.2690541-1-j.raczynski@samsung.com>
	<7eb9e4d4-909c-4203-833d-bd8b664fdfbc@lunn.ch>
	<aeiJ3zr4WJAm1UCk@AMDC4622.eu.corp.samsungelectronics.net>
	<f1d51362-ca8f-481a-b9c1-400ab6422686@lunn.ch>
	<aejYCYObZyFPpLat@AMDC4622.eu.corp.samsungelectronics.net>
	<52b06f0a-8283-4903-9d8a-2bbdf637dd5d@lunn.ch>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280675-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:dkim]
X-Rspamd-Queue-Id: 6EFD944F1EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

------hExaTKD8pSV4C1.mHO0xNjZioIzStKhMnOXfyxqZoi0.l2l2=_2e513_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Apr 22, 2026 at 06:15:20PM +0200, Andrew Lunn wrote:
> On Wed, Apr 22, 2026 at 04:15:37PM +0200, Jakub Raczynski wrote:
> > On Wed, Apr 22, 2026 at 02:47:38PM +0200, Andrew Lunn wrote:
> > > > I don't see anything wrong with it?
> > > > - naming is correct, same as stmmac_extra_stats from common.h, as it
> > > >   wouldn't compile otherwise
> > > > - string length is ok, as max name length is ETH_GSTRING_LEN=32 and it is
> > > >   not close
> > > > - ethtool just polls data from driver and in my tests it is ok
> > > > - all instances of 'undeflow' are changed
> > > > - 'underflow' semantic is ok, 'undeflow' is just not correct
> > > > 
> > > > Please correct me if I am wrong, but imo no issues with this patch.
> > > 
> > > ABI
> > > 
> > > This name is published as part of the kAPI. You are changing its
> > > name. User space could be looking for this name, even thought it has a
> > > typo in it.
> > > 
> > >      Andrew
> > >
> > I don't think it is? This part of extra stats (struct stmmac_extra_stats) and
> > is not part of standard ABI from
> > Documentation/ABI/testing/sysfs-class-net-statistics
> > nor is mentioned in
> > Documentation/networking/device_drivers/ethernet/stmicro/stmmac.rst
> > 
> > These extra stats are specific to stmmac driver and most of these are more
> > than standard
> > https://www.kernel.org/doc/html/v7.0/networking/statistics.html#c.rtnl_link_stats64
> > This name does not exist outside stmmac driver, so while some application may
> > expect this (stmmac specific app), question is should this typo stick?
> 
> 47dd7a540b8a0 drivers/net/stmmac/stmmac_ethtool.c                  (Giuseppe Cavallaro      2009-10-14 15:13:45 -0700   81)     STMMAC_STAT(tx_undeflow_irq),
> 
> It has been exposed to user space for 17 years. In that time, there
> could well be stmmac specific apps using it.
> 
> Just because it is not documented as ABI does not make it not ABI.
> 
>      Andrew
>

Sure, up to you whether NAK or ACK this change.

IMO this name is specific to stmmac and should not be part of any app,
as monitoring tools should be more universal. When monitoring interface this
field will show some other way, via dropped packets and then you would use
driver specific fields for debugging.

Problem is, quick search on github shows this change propagated through
hundreds of Linux forks or different RTOS. But no public app using this found,
at least C app (but well, I didn't browse everything for obvious reasons).
Funny how typo will live everywhere and not be fixed.
So this change would make it differ from all the forks/RTOS'es that will
probably never fix this. So thats the downside.

Question is whether this should then remain that way forever?
And was it really part of some ABI if no one noticed?

Regards
Jakub Raczynski

------hExaTKD8pSV4C1.mHO0xNjZioIzStKhMnOXfyxqZoi0.l2l2=_2e513_
Content-Type: text/plain; charset="utf-8"


------hExaTKD8pSV4C1.mHO0xNjZioIzStKhMnOXfyxqZoi0.l2l2=_2e513_--

