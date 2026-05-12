Return-Path: <netdev+bounces-287227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BbfOBsFTA2pD4wEAu9opvQ
	(envelope-from <netdev+bounces-287227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:22:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8466952494C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BA50310EEF2
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051CE3C5837;
	Tue, 12 May 2026 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZQ5JGPIG"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25DE3B813E
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601422; cv=none; b=bq91hwxys3eVagkzssmSUiAy1ecq2D7zx8NRN2syACeV6HHnnvBsJVtK5BIopLWt1Z7Xqm9UCNswPw5OyajokkLzwrtJjXmarjR87DT92MaKtWJOmOGKYpvjkA6E4tPuERMc02AbCjsLBDnF/RD4QDp+8PGH/9ihyyg0uOjX9SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601422; c=relaxed/simple;
	bh=0A8ujuwZhwUSwQz/7Fru337wsMfwbPWrmpXwx2mJG1w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=LXvfgcwObT3pA9fetmAk+MiN/dPRV7DDi+HhRJMAPECKzS80iNE8o51CIvuACCWgdqFVn4uWfzaq0i8e3e5fOag6ADYN5cQdWJMe/EQdCGGDQRFobnn1jcE5WVdqq3Swdo/UFVcubLQ3L9b7Pmt2eC2GtXzk3+s0nxRxrjUqZ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZQ5JGPIG; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260512155658euoutp01c8fa74157d24f2c8a4b4695c639e16f2~u3JEhHjOY1679816798euoutp01O
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 15:56:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260512155658euoutp01c8fa74157d24f2c8a4b4695c639e16f2~u3JEhHjOY1679816798euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1778601418;
	bh=0hNBJ5LoXCfpt68Eq4dVcp5kNQdV/oZ0qooMLKlDCTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZQ5JGPIGm9mtUFOkx+uRt+bYxXwb8Alq13uHLof0ps9ie9jJEio0BqgSJQ+W4XG2x
	 K1tinNMFNGfu/QmSZf2et4smu+upgNkAC1K9UzBhcW9rmUnGELupxbzbzXOwLnzB4Q
	 6aOctMHwjd66gt0wiO6rciY6zIJPXoAZ0Gw62IzI=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260512155658eucas1p24d903367780fdaa3f31e81ebe5257cfe~u3JES3hBr1922719227eucas1p2z;
	Tue, 12 May 2026 15:56:58 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260512155657eusmtip2e2e5b170fe9f177396cf1f14d948827b~u3JDxiSaA1044510445eusmtip2K;
	Tue, 12 May 2026 15:56:57 +0000 (GMT)
Date: Tue, 12 May 2026 17:56:53 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: muhammad.nazim.amirul.nazle.asmade@altera.com, netdev@vger.kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: stmmac: Use interrupt mode INTM=1 for
 per channel irq
Message-ID: <agNNxTXeHq+4V/kB@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260511180842.0a547a25@kernel.org>
X-CMS-MailID: 20260512155658eucas1p24d903367780fdaa3f31e81ebe5257cfe
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----peYM.qn2Q3Y4BVPtHiU-d89xQHYyd0GEhBng.MjRSgXq9KTQ=_27a54_"
X-RootMTR: 20260512155658eucas1p24d903367780fdaa3f31e81ebe5257cfe
X-EPHeader: CA
X-CMS-RootMailID: 20260512155658eucas1p24d903367780fdaa3f31e81ebe5257cfe
References: <20260507070125.11886-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
	<20260511180842.0a547a25@kernel.org>
	<CGME20260512155658eucas1p24d903367780fdaa3f31e81ebe5257cfe@eucas1p2.samsung.com>
X-Rspamd-Queue-Id: 8466952494C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	TAGGED_FROM(0.00)[bounces-287227-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

------peYM.qn2Q3Y4BVPtHiU-d89xQHYyd0GEhBng.MjRSgXq9KTQ=_27a54_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, May 11, 2026 at 06:08:42PM -0700, Jakub Kicinski wrote:
> On Thu,  7 May 2026 00:01:25 -0700
> muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> > - Wire up multi_irq_en via STMMAC_FLAG_MULTI_IRQ_EN in stmmac_main.c
> >   so the feature is reachable by platform drivers.
> 
> Okay, but where is a platform driver which uses it _today_ ?
> We need an upstream platform that uses this new bit submitted
> as part of the same series.
> 
> If I'm completely off, and this new code somehow gets triggered
> with upstream platforms - please improve the commit message.
> -- 
> pw-bot: cr
>
Please allow me to attach question to this response, but is this patch enough?

In stmmac code there is handler stmmac_request_irq() which deals with
stmmac_request_irq_multi_msi() and single() aka shared IRQ.
If INTM is enabled, does it really do anything if there is no handler within
stmmac_request_irq() that would process all different IRQs, depending how
is it wired on specific hardware? Or rather, shouldn't there be new function
to call request_irq() per DMA channel for that?

There is e9ee910218ffd that reverted basically whole support for above,
so I think this change is not sufficient.

Please correct me if I am wrong. Thank you.

BR
Jakub Raczynski

------peYM.qn2Q3Y4BVPtHiU-d89xQHYyd0GEhBng.MjRSgXq9KTQ=_27a54_
Content-Type: text/plain; charset="utf-8"


------peYM.qn2Q3Y4BVPtHiU-d89xQHYyd0GEhBng.MjRSgXq9KTQ=_27a54_--

