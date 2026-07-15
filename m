Return-Path: <netdev+bounces-307725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4nJPHGVeV2opKgEAu9opvQ
	(envelope-from <netdev+bounces-307725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 12:18:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3D575CDFA
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 12:18:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=Ni7SGsFz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307725-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307725-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 644C5308A279
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FDD43C7AC;
	Wed, 15 Jul 2026 10:14:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6ED3EAC9B;
	Wed, 15 Jul 2026 10:13:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110440; cv=none; b=KBvbU1tMYna0wzLbpEz3MDzaV38+d+G+GKidKVqdlacgOGh3wr4Ug8lM/e+HrRU+8kMWiru7rdvJddshlcW2wCVtyITODwmqxarCOQUjkU2ywH89rdtlJNTXZhHq9HEjKOYzadJYmY6iBqjnvBowFjsAUIOdsMAnaFMkJkijCEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110440; c=relaxed/simple;
	bh=dznAcgeibEjN5/Xb9OznAx0ywgJh5zCe/GLG45FruNY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCFqjzta9QoKKmoGg4s9645mO0Wljw2xYJ5o5U0/N++vaf9rSTp49XU+VGG/sz5soQ5rp3j2liTHeonxX8sLYdJoYHSA45cunFBDqccFzc0yNsla/aWBjxQqIPYoeq82vaZtQ1qndbOg6JMrx3YP0e+i/5530wHuQD/z3c65MRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Ni7SGsFz; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 9C69720684;
	Wed, 15 Jul 2026 12:13:56 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6iOoDMKxnsTn; Wed, 15 Jul 2026 12:13:56 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 0FCF9205CF;
	Wed, 15 Jul 2026 12:13:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 0FCF9205CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1784110436;
	bh=uAguo58+adgfuGry8xKS5mrXnN+Rcg5dlUr4HpI7O0c=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Ni7SGsFzlXhvFvjTsMhMq386z5nh3x6YWZu+daTART1IaMVJpXApqDNgP0wYQP5R3
	 AVXkLry6JsEGHIw0yNOTkQLCiwhYLhyOnHabh3KpAxyilwnR/rfWeDEJp2QEFFqOzA
	 xvRY1/2oqEayXa4EHbsMAoJa0W5TyqUr7bgaUvg5vzzjTY25SHV6AbYgIuNBusOrn7
	 pE1JJU8HwEDujT0RSN2YF+x56T2BdhnymJe/zXc+dwAXlJDwONCRgw9YRTcTSn+DX/
	 t/LgSdtEmZcgyy/6ilYbU/NoWiJsRE9OEMNkFH6MD2LK9Z1SjHCkMwmvC2xYUfU6DX
	 Nf1v8r8/JsMcA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 15 Jul
 2026 12:13:55 +0200
Received: (nullmailer pid 699512 invoked by uid 1000);
	Wed, 15 Jul 2026 10:13:54 -0000
Date: Wed, 15 Jul 2026 12:13:54 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Maher Azzouzi <maherazz04@gmail.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <w@1wt.eu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] esp: do not unref managed frag pages in
 esp_ssg_unref()
Message-ID: <alddYsnyQXXU2E1I@secunet.com>
References: <20260712170530.9807-1-maherazz04@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260712170530.9807-1-maherazz04@gmail.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307725-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:maherazz04@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:w@1wt.eu,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA3D575CDFA

On Sun, Jul 12, 2026 at 06:05:30PM +0100, Maher Azzouzi wrote:
> esp_ssg_unref() releases the page references held on the source
> scatterlist after the AEAD operation completes.  It calls
> skb_page_unref() on every frag page for an out-of-place transform
> (req->src != req->dst), and in the error path of esp_output_tail()
> (already_unref == true) on the request's own scatterlist.
> 
> This is wrong when the skb carries managed frags
> (SKBFL_MANAGED_FRAG_REFS).  Managed frags are owned by a zerocopy ubuf
> and the skb does not hold a per-frag page reference; io_uring SEND_ZC
> with a registered buffer attaches the bvec pages this way via
> io_sg_from_iter().  The rest of the stack honours this invariant:
> skb_release_data() skips the per-frag unref when SKBFL_MANAGED_FRAG_REFS
> is set, and skb_zcopy_managed() is the guard used at the other unref
> sites.
> 
> esp_ssg_unref() is missing that guard, so for a managed-frag skb it
> drops a page reference the skb never acquired.  This can underflow the
> page reference count and free a page that is still in use.
> 
> Guard the function with skb_zcopy_managed() so both unref paths are
> skipped for managed-frag skbs, matching skb_release_data().
> 
> Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
> Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
> Signed-off-by: Maher Azzouzi <maherazz04@gmail.com>

Applied to the ipsec tree, thanks a lot!

