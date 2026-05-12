Return-Path: <netdev+bounces-287006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KkpB0LoAmpEyQEAu9opvQ
	(envelope-from <netdev+bounces-287006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:43:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CFE51CE4E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5396730A3E7F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F18D49550F;
	Tue, 12 May 2026 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E5AwiwDA"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE5C30DEB8
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575076; cv=none; b=nR53S2WDikyBROcVsZyzmrdjzAcl0JNzGBjsZdzp7iGJPFf8gACe+S1RfqmN3O4r9HK50tA52Pxvabf4RcojkX6Z2U9wUI4RU9koB9s9fDXWo3Y7F2ZFY4G5x7bw4OKChHST1Jh3PiU+c2Fcml8VkZfVGngv4RcxF6+G+8TSsvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575076; c=relaxed/simple;
	bh=Z2cAAIkr6iMWfJpguX929CHX4z3mxExtUL7mVN9afKM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=Hf4h2h8etrA5FwLCZZgxbUun2dL2cHFbDPfjJQ4HsYtQh/s2MklDyrJZr9LT8WXWpd1MAc9u0G29h+sMHhxkps48tc2HVE1xd+P+pyMeuKEfhzhTIxPq5dFyRJsbnP+gI0/FOzzKzeNMKoc6C7FGYbu6s/fLRrId0izwjaiEp6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=E5AwiwDA; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260512083751euoutp02adb5e865a0d8c40fa0716e7d6a2b7b78~uxJrBYWjP1153011530euoutp02R
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:37:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260512083751euoutp02adb5e865a0d8c40fa0716e7d6a2b7b78~uxJrBYWjP1153011530euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1778575071;
	bh=P+WzoEiF7scbrcGL30MDai0Mqm4NhhCQaJizIZE8db0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E5AwiwDAMGB7RSWPZLRxM0BZ9Y+v/VfoAWWo3XaYvlObtQLlmKj3fqIOltyNjcqOx
	 Z2w8Fa9Zr9D/vp1R0er3vkWyoCH7L+QCLp3aJW+1wWWVZLwBW9iQkPdMvA/UEH/K89
	 dPbxNW3Ls3pFdGTg91Bt0omKwgJJ8d8w2Xv9eVAA=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260512083751eucas1p293e684cc51c2fef348703824f0efe447~uxJqqzJvr1439714397eucas1p2d;
	Tue, 12 May 2026 08:37:51 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260512083750eusmtip138caf2d0ef97dcdc9ce9f285e0bfe8bd~uxJqGshoK3069330693eusmtip1j;
	Tue, 12 May 2026 08:37:50 +0000 (GMT)
Date: Tue, 12 May 2026 10:37:50 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, k.domagalski@samsung.com,
	k.tegowski@samsung.com
Subject: Re: [PATCH net-next 1/3] net/stmmac/dwxgmac: Modify DMA functions
 for future hardware
Message-ID: <agLm3rvbVp4MpHT7@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5b94f49e-5f1a-40fb-af34-f4a9d4738502@lunn.ch>
X-CMS-MailID: 20260512083751eucas1p293e684cc51c2fef348703824f0efe447
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="-----ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_1f670_"
X-RootMTR: 20260511165431eucas1p1450bdea6486a72257f6463d5f40abc50
X-EPHeader: CA
X-CMS-RootMailID: 20260511165431eucas1p1450bdea6486a72257f6463d5f40abc50
References: <20260511165416.3093015-1-j.raczynski@samsung.com>
	<CGME20260511165431eucas1p1450bdea6486a72257f6463d5f40abc50@eucas1p1.samsung.com>
	<20260511165416.3093015-2-j.raczynski@samsung.com>
	<5b94f49e-5f1a-40fb-af34-f4a9d4738502@lunn.ch>
X-Rspamd-Queue-Id: 72CFE51CE4E
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
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,samsung.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287006-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[AMDC4622.eu.corp.samsungelectronics.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:dkim]
X-Rspamd-Action: no action

-------ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_1f670_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, May 11, 2026 at 08:02:14PM +0200, Andrew Lunn wrote:
> > +	/* Newer XGMAC hardware does support up to 16 MTL/DMA queues but
> > +	 * only 8 traffic class queues. Redirect these, but this is error in
> > +	 * configuration.
> > +	 */
> 
> If this is an error in configuration why not return -EINVAL when the
> configuration is requested?
> 
> 	Andrew
> 
Because is generally would not change a thing and would probably cause more
problems.

Parent function of stmmac_set_dma_operation_mode() -> stmmac_dma_tx_mode()
does not have any error handling. So we end up in situation where
tx_queues_to_use from DTS is still at its value, so we still have situation
where amount of DMA/MTL queueus is higher than number of TC's.

So then in case of XGMAC 3.20a/3.40a, we would have 8 DMA/MTL queues that
have assigned TC and 8 that don't. I cannot speak for older/other XGMAC if
there were ever a case like that where number of DMA/MTL != number of TC's.

So we will get many unusable MTL queues, eg. NAPI does use tx_queues_to_use in
its initialization, these queues will still be visible in system and can
be sent to. Leaving them unconfigured will very much likely lead to
'Tx queue timeout' and endless loop of interface restart via
stmmac_reset_subtask().

I think it is just simplier to leave warning that configuration is wrong,
handling error would be quite big change to make.

BR
Jakub Raczynski

-------ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_1f670_
Content-Type: text/plain; charset="utf-8"


-------ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_1f670_--

