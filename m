Return-Path: <netdev+bounces-305294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CfXbJyieTGqTnAEAu9opvQ
	(envelope-from <netdev+bounces-305294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:35:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF49E718037
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:35:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=hh9w8gNB;
	dmarc=pass (policy=none) header.from=secunet.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305294-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305294-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B00D3052657
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 06:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E153A874B;
	Tue,  7 Jul 2026 06:33:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9703A7F68
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 06:33:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406016; cv=none; b=eRbObpFpvCEjbrjtLOy37PnMw4j66Ue9ncpCFF1HAn5/ljq3TBUcpWlcsipdQBQsBSVoD8P/mbU5mksA+Gx7N4eacm7nthrVQtBMKH2f1NIBi0JEdkKPgKkSqkNDFkYhwbToEiZLSY2J/3CcuadkWSbUtxDFIrQoSnGWfYds9cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406016; c=relaxed/simple;
	bh=LTaZo7xiJI7PG/QkjSigqpowQ19h+Gp4nRTtgbOtFP8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvO5bo/w+/aTV2WgX1jsQd+kkPpxY1ioNqtMZt84L8DS1XAA4YzB53qdJ8WxqO7KriY0Rt1X4BzqrvwO1K7Be+/IjJFHYyrEEy/yIhO+zSm7xoncPtSk94cqjYKggjwlPd4PApVMrh2chDcGfWQHWYNblIhv72+lt7HWXuQ0Db4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=hh9w8gNB; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 91DDF206B0;
	Tue,  7 Jul 2026 08:33:32 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CWoD1VysXoNq; Tue,  7 Jul 2026 08:33:31 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D1AE6201A7;
	Tue,  7 Jul 2026 08:33:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D1AE6201A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1783406011;
	bh=WylePPAXz7l9u8Pv3lcPwoPAgQZ3Cev7Xz7Ss312FPs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=hh9w8gNBI2sT3/BIkVE/hbCemg2Ghaa0R+4SczPJvMrpk4ctpU6oOxvdqBGoi07sH
	 LzhStTHgYYHrmaUfK0ahgDMO06+Hp+gseMAsfdb7AoEXOkQBAgKzucYqmdrEJFX9U9
	 2Pmf255rOam+D4D8mvvJL+Qsh8q/OIEVjgcYgivxTOnDK7NMQzxvxxCssKtl3iIieD
	 84OAxTirtVJlV+cExGJoPH44NKql2BdXdvBBsusuhoostRMTOauuAf6x2WGrcWX950
	 pPwuP8wtERsADFnRo4uerR5ZY2wWHDc8l7ugfXEZAJzUxnol7gTExY4YW97vDBVp2K
	 z1wdgyxT0eusA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 08:33:31 +0200
Received: (nullmailer pid 204090 invoked by uid 1000);
	Tue, 07 Jul 2026 06:33:30 -0000
Date: Tue, 7 Jul 2026 08:33:30 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Chen YanJun <635381823cyj@gmail.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <moomichen@tencent.com>
Subject: Re: [PATCH v2] xfrm: iptfs: propagate SKBFL_SHARED_FRAG in
 iptfs_skb_add_frags()
Message-ID: <akyduulhu_rs_HXU@secunet.com>
References: <20260701033152.29222-1-635381823cyj@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260701033152.29222-1-635381823cyj@gmail.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:635381823cyj@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:moomichen@tencent.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305294-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:from_mime,secunet.com:dkim,secunet.com:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF49E718037

On Wed, Jul 01, 2026 at 11:31:52AM +0800, Chen YanJun wrote:
> From: Chen YanJun <moomichen@tencent.com>
> 
> When iptfs_skb_add_frags() copies frag references from the source
> frag walk into a new SKB, it increments the page reference count via
> __skb_frag_ref() but does not propagate SKBFL_SHARED_FRAG to the
> destination SKB's skb_shinfo->flags.
> 
> If the source SKB carries shared frags (e.g. from a page-pool backed
> receive path), the new inner SKB will appear to ESP as having privately
> owned frags.  A subsequent esp_input() call for a nested transport-mode
> SA then takes the no-COW fast path and decrypts in place, writing over
> pages that are still referenced by the outer IPTFS SKB.  This causes
> kernel-visible memory corruption and can trigger a panic.
> 
> All other frag-transfer helpers in the kernel (skb_try_coalesce,
> skb_gro_receive, __pskb_copy_fclone, skb_shift, skb_segment) correctly
> propagate SKBFL_SHARED_FRAG; align iptfs_skb_add_frags() with this
> convention by setting the flag inside the loop immediately after
> __skb_frag_ref() and nr_frags++, so every exit path that attaches a frag
> unconditionally propagates SKBFL_SHARED_FRAG.
> 
> Fixes: 5f2b6a909574 ("xfrm: iptfs: add skb-fragment sharing code")
> Signed-off-by: Chen YanJun <moomichen@tencent.com>

Applied, thanks Chen!

