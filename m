Return-Path: <netdev+bounces-266928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP5nNudfsmlmMAAAu9opvQ
	(envelope-from <netdev+bounces-266928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 07:40:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0DB26DFE9
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 07:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 831903093244
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 06:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4638A39EF02;
	Thu, 12 Mar 2026 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="YpeqQxRZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654F538C40D
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 06:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773297417; cv=none; b=ljkaFc6nwT+tNktVmsfBzNxMa9/YBdtEvGIsOmwyq+5h7/dhuDBvF1q39xKSGN3qp7wQaN/W+Zr0ejlaoEsNWNQ4DmlulfBwEzaMPqcDxBmXbvMrWUDiLxRxMaG1h7hnNceW0Qk5Kb5/0saQdo2v49irL5G8zYybZ7SNro9cn2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773297417; c=relaxed/simple;
	bh=OeXeDMD6HirRqZTISbCpNb0ZIAgYnt7jVAhUMhiP3yo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eC306flxwihSvLXWXGKfU63aS8pLIzN5+rgWhGGDS5BoVqfGBPZfmauTEqLBKuPjr9J/2wl0qzRRVWj5/6mpnfHythhWbLLxG5+uRU0U9QpmZZCWBLZZ0C5rR4Xp+TH/iQGsMImrFXtcughIyde+T19AHkFWx3gHfk2AZ+M5BDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=YpeqQxRZ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 7B11D20799;
	Thu, 12 Mar 2026 07:27:10 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KyymKwPJ0iCP; Thu, 12 Mar 2026 07:27:10 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E26402064C;
	Thu, 12 Mar 2026 07:27:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E26402064C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1773296829;
	bh=qCMrG6R9wEgYocFLXELTgCv1qgm6eoLjiHswNf5w1Wo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=YpeqQxRZionh1zy32zOhz1ZvCAuO9b423vS6nACI6CJ/4qlz2NWFACZKt3MlqOMEY
	 8LdOuJ9P3q6G0E6aC6mWIX6J9gHOZgZZV0QRRI7lc8kvDaRkd1QBgykINqaKaprbT1
	 ZC/d/dRxe2Fy4zphJYIp6Br3axHoG3Ifs6WmuBFz3j78C89zRHzTHWh05JU/sWapXt
	 24oBbNqKUIISNLVc2BlUwrtGuxnguRJw21TYjqbFNZwdvcHNtTTEABd6jG7M5c/Pr4
	 WPMxQgg2YY6cNg3Ph2OzoMAJd/xgBAUw8B3H1txQ/7y4ayOr24FCPvs0rmQ9H06rPT
	 0QuhPskMgcZig==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 07:27:09 +0100
Received: (nullmailer pid 2329501 invoked by uid 1000);
	Thu, 12 Mar 2026 06:27:08 -0000
Date: Thu, 12 Mar 2026 07:27:08 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: Leon Romanovsky <leon@kernel.org>, Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>, <netdev@vger.kernel.org>, Herbert Xu
	<herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec-next 01/10] xfrm: state: fix sparse warnings on
 xfrm_state_hold_rcu
Message-ID: <abJcvFX-pbZ4WZry@secunet.com>
References: <cover.1773051558.git.sd@queasysnail.net>
 <7388df7238672a92be0e4048f0225e6db294e736.1773051558.git.sd@queasysnail.net>
 <20260310103135.GB12611@unreal>
 <abABg6aO9twGIk7F@krikkit>
 <20260310182012.GF12611@unreal>
 <abBv6zR4Qq_lrzuC@strlen.de>
 <20260310194500.GO12611@unreal>
 <abB12Ae769OivuYB@strlen.de>
 <20260310201021.GP12611@unreal>
 <abCQGh5Ce9uDbOo9@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abCQGh5Ce9uDbOo9@krikkit>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266928-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4E0DB26DFE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 10, 2026 at 10:41:46PM +0100, Sabrina Dubroca wrote:
> 
> > Yes, this is possible scenario and this is what is worth to document.
> 
> 
> We could add something like:
> 
> /* Take a reference to @x, when we know the state has a refcount >= 1.
>  * In this case, we can avoid refcount_inc_not_zero and the error
>  * handling it requires.
>  * In contexts where concurrent state deletion is possible and we
>  * don't already hold a reference to that state, xfrm_state_hold_rcu
>  * must be used.
>  */
> 
> Though it may not make much sense to refer to xfrm_state_hold_rcu
> (implemented in net/xfrm/xfrm_state.c) from include/net/xfrm.h.
> 
> And if we consider the hashtables to be private to
> net/xfrm/xfrm_state.c, nothing outside of it should ever see a state
> with refcount=0, since they will only ever see states that already
> have one reference held by whatever gave them the pointer.
> 
> So maybe it's more xfrm_state_hold_rcu that needs a mention of
> "concurrent state deletion could bring the refcount to 0 while we're
> doing the lookup"? I don't know, for me it's pretty obvious with the
> _rcu suffix that RCU -> unlocked -> could be deleted in parallel.
> 
> 
> We also have __xfrm_state_put, the commit message that introduced it
> states:
> 
>     We often just do an atomic_dec(&x->refcnt) on an xfrm_state object
>     because we know there is more than 1 reference remaining and thus
>     we can elide the heavier xfrm_state_put() call.
> 
> so we could add:
> 
> /* Drop a reference to @x, when we know there is more than 1 reference remaining.
>  * In this case, we can avoid refcount_dec_and_test and just decrement refcnt.
>  */
> 
> but maybe someone has a better suggestion.

I plan to take this series as is. If you feel we need a comment,
just add it with a followup patch.

