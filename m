Return-Path: <netdev+bounces-304096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S4MQBHg9RmpeMgsAu9opvQ
	(envelope-from <netdev+bounces-304096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:29:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A9B6F5EAB
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:29:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=YBujIPJo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304096-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304096-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=samsung.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F084A3019FF3
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 10:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AFF3998B2;
	Thu,  2 Jul 2026 10:17:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F6528CF6F
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 10:17:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987476; cv=none; b=bAeaNVwAK5zy2pecQytpZjtIYt1JFNxojcc2AnZMTYM+ZjP+KXK2OMaipEmGnyc1/910XK0X2Cov2ld9C8hxvs59Yk76D42kPiXCQO7TE0ukDs3odAUX2VmlZHNsY5vbwMtgxAT021RRdHgXHiF06JDp/DYI0lmItkPGLD1W6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987476; c=relaxed/simple;
	bh=X1iC97eUSPuQXlgakRjY9VBk8mEq2sDcNORENhgPlGI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=lrNuQy5rfFsEN3eZhPxrBdaKpqSlHiDYOnhkRx3Ku4DJIl22xv1Trki/jdJshAVnsDl22Ee+iM/szQz9Qkj8yQQ5ouZqnWtQdu+eGKSdnmnkB8WgW1HJnNWP5sr4y4aKYDvDhnM6wyHPFq8COFGQR0cP2ta8h7rMCeI+d3yVRKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YBujIPJo; arc=none smtp.client-ip=210.118.77.11
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260702101745euoutp01542527eebcaca2f1ae64bc61543ead05~_cacvMCij1739417394euoutp01l
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 10:17:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260702101745euoutp01542527eebcaca2f1ae64bc61543ead05~_cacvMCij1739417394euoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1782987465;
	bh=kwG2TG20wXUcOw/yFt5rURuaMwy9sdR9dNRrfe6/MxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YBujIPJoOWWQV9lakUl5Yk2UFjFCSqs0V6M+3JqW8IQLMrQGLoq5d70t75iPQ3Aey
	 vrJHGejGVXxDkSzpbdh3pm04wtZD9PtB90EsaAs3rzz1RhHbXBtR52GanTbxDN9g20
	 Z/ShITQ3yCJ+IjLMcqRdkRoqiSM5jESMUpxIy2WU=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260702101744eucas1p1a97532a37be582391eeeb673254ef2dc~_cacYvQ9j1877718777eucas1p1U;
	Thu,  2 Jul 2026 10:17:44 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260702101744eusmtip2cd23e3f0ea6009b91f26dbe1d232c91f~_cabz5FjD1223012230eusmtip2w;
	Thu,  2 Jul 2026 10:17:44 +0000 (GMT)
Date: Thu, 2 Jul 2026 12:17:40 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, linux-kernel@vger.kernel.org,
	k.tegowski@samsung.com, k.domagalski@samsung.com, Yashwant Varur
	<yashwant.v@samsung.com>
Subject: Re: [PATCH net] net/stmmac: Set Rx queue page_pool to NULL when
 freeing DMA resources
Message-ID: <akY6xLKAnpxwAct4@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1e4cedb5-fc16-4007-9a11-8c819f2c5731@bootlin.com>
X-CMS-MailID: 20260702101744eucas1p1a97532a37be582391eeeb673254ef2dc
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_100cf9_"
X-RootMTR: 20260630101157eucas1p1b1cef0db9381391bdd9400f1d255ce49
X-EPHeader: CA
X-CMS-RootMailID: 20260630101157eucas1p1b1cef0db9381391bdd9400f1d255ce49
References: <CGME20260630101157eucas1p1b1cef0db9381391bdd9400f1d255ce49@eucas1p1.samsung.com>
	<20260630100953.747868-1-j.raczynski@samsung.com>
	<1e4cedb5-fc16-4007-9a11-8c819f2c5731@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[samsung.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304096-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:linux-kernel@vger.kernel.org,m:k.tegowski@samsung.com,m:k.domagalski@samsung.com,m:yashwant.v@samsung.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,samsung.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,bootlin.com:email,samsung.com:dkim,samsung.com:from_mime,AMDC4622.eu.corp.samsungelectronics.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76A9B6F5EAB

------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_100cf9_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Jul 02, 2026 at 11:24:41AM +0200, Maxime Chevallier wrote:
> >  
> >  	kfree(rx_q->buf_pool);
> > -	if (rx_q->page_pool)
> > +	if (rx_q->page_pool) {
> >  		page_pool_destroy(rx_q->page_pool);
> > +		rx_q->page_pool = NULL;
> > +	}
> 
> page_pool_destroy can be passed NULL, as you're fixing this I think you might as well
> drop the if(rx_q->page_pool) at the same time :) I agree with the change otherwise.
> 
> with that changed,
> 
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> Maxime
>

Agreed, will send V2 soon.

BR
Jakub Raczynski 

------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_100cf9_
Content-Type: text/plain; charset="utf-8"


------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_100cf9_--

