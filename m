Return-Path: <netdev+bounces-255882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMNqGF+0gGl3AgMAu9opvQ
	(envelope-from <netdev+bounces-255882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 15:27:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE24DCD568
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 15:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3F7D30185BB
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 14:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E102D2493;
	Mon,  2 Feb 2026 14:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ppNC/Xa5"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4359C1A76DE
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042459; cv=none; b=mYYtkDIWlgxM3YiDgnW2RVIIuHXMAwGY6HS5oVlGFDN6yXkWskXlo0YMieAvwuwM09PqrRiSwXGjxtx210Ba7b+FkzEJg0dNK9HYQl+FDk/ouQYsGgRkiM486WTW5DFQX81mmkCtg33adZiUBaTYhN/zFKt12Ky2m1pDCcrQATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042459; c=relaxed/simple;
	bh=+R4++M8FUTG1DIxvU5O6fXt+ps/irZYihVg1KCToE6M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMgKesbowzyxtiDiIv4pJaMCGmgJ10JP49GqKV7n3Kl9WTJk6Rlu/7/gUJsttYm4N0ylKpZcG/5JNL+1JguDzHEb6L8qE+EUQ8NR5c9CfgVxEMZXMf4QvIxNekkG9M8ZhNk7yDGVszjHvkF/I+Xl77fJZw0bVTLNOqK5tN+g8lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ppNC/Xa5; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 3CE45201E2;
	Mon,  2 Feb 2026 15:27:34 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MQSt0OA811MK; Mon,  2 Feb 2026 15:27:33 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 3871F201A1;
	Mon,  2 Feb 2026 15:27:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 3871F201A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1770042453;
	bh=K4RY8oKI9qwfYPI3CVBDF4ISYDibmHkncYTTzUEs0PA=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=ppNC/Xa5vz1xnSD6lcj6JS7V9Lezp58YMU9R1H8FzbcifpVDG2s90QPg0L3K+iBZ7
	 Hm4ewws7Peo4ON8A3D7pe6W4JHBkHNRjHbhKhSBBTox6EYZzQMKM7ME8IOVf/7nPzY
	 9GXWNyPJjonob7LS+ymespHBhv3aQPRy2v/c/f0+4p/NocLMVdTKaNTQgq2eUbFh0u
	 33q4Zkxvtts5Ay4uBinZHMezKNePxsRHyXmFvzBrOh5Fa29Gl6hwID9QbnDzMgiFrc
	 LCrgF3dl6U914qtazX95VSxZUx5rjfzecaTpMIVW88k4QWGdGPCxkgozma0YlPW3nx
	 zTXhWAFytZqTQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 15:27:32 +0100
Date: Mon, 2 Feb 2026 15:27:06 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Yan Yan <evitayan@google.com>
CC: <netdev@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, <antony.antony@secunet.com>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<saakashkumar@marvell.com>, <akamluddin@marvell.com>, Nathan Harold
	<nharold@google.com>, <greg@kroah.com>
Subject: Re: [REGRESSION] Discussion on "xfrm: Duplicate SPI Handling"
Message-ID: <aYC0OvkVPkOnVU-i@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <CADHa2dChQ=4UVY5X5Ad=jryGRCBPQ37Z_Sw60-6h6h_EcUFG9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADHa2dChQ=4UVY5X5Ad=jryGRCBPQ37Z_Sw60-6h6h_EcUFG9g@mail.gmail.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-02.secunet.de
 (10.32.0.172)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255882-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:replyto,secunet.com:dkim,moon.secunet.de:mid];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[antony.antony@secunet.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CE24DCD568
X-Rspamd-Action: no action

Hi Yan,

On Wed, Jan 28, 2026 at 16:43:06 +0800, Yan Yan wrote:
> Hi all,
> 
> I am writing because unfortunately commit: 94f39804d891 ("xfrm:
> Duplicate SPI Handling") has caused a regression in the Android OS, so
> we would like to gain some context to help determine next steps. The
> issue is caused by the new requirement for global SPI uniqueness
> during allocation. Based on our review of RFC 4301 and the previous
> review history, we would like to highlight a few concerns:
> 
> 1. Regression on Android:
> This change breaks production behavior in Android, which uses
> XFRM_MSG_ALLOCSPI to create larval SAs for both directions. Since RFC
> 4301 allows duplicate outbound SPIs, and larval SAs are often created

To clarify, how are larval outbound SAs created in Android?
Are they created with zero or non-zero SPIs? Multiple zero SPIs (acquire states) are allowed. However, I guess there is no user API for managing these acquire states. Only the kernel can create them and handle expiration or deletion via SA updates with acq_req?

A user API (UAPI) for creating and deleting acquire states might be a possible solution.

I haven’t been able to consistently reproduce the issue Marvell reported,
but I suspect the bug could also affect outbound SAs with non-zero SPIs.
Also when one peer is behind NAT. 

I wonder wouldn't duplicate SPI when behind NAT cause issues for output SAs? 
Because the triplet is SPI, Protocol, Daddr. There is  no dport in it.

> before direction or selectors are finalized, the allocator must remain
> permissive (at least in our current design).
> This also aligns with a concern Herbert Xu raised during the initial
> review regarding compatibility:
> >    "It's also dangerous to unilaterally do this since existing deployments
> >    could rely on the old behaviour. You'd need to add a toggle for
> >    compatibility."
> 
> 2. Inbound SPI uniqueness should not be a hard requirement:
> The justification for enforcing global SPI uniqueness often cites the
> statement in RFC 4301, Section 4.1, that for unicast traffic, the SPI
> "by itself suffices to specify an SA." However, we don’t think this
> means inbound SPI uniqueness is a hard requirement because of the two
> following reasons:
> 
> – Another statement implies that SPI uniqueness is just an
> implementation choice:
> >    "Each entry in the SA Database (SAD) MUST
> >    indicate whether the SA lookup makes use of the destination IP address, or the
> >    destination and source IP addresses, in addition to the SPI."
> 
> – There is a "Longest Match" mandate which makes SPI uniqueness unnecessary:
> >    "For each inbound, IPsec-protected packet, an implementation MUST
> >    conduct its search of the SAD such that it finds the entry that
> >    matches the 'longest' SA identifier. In this context, if two or more
> >    SAD entries match based on the SPI value, then the entry that also
> >    matches based on destination address... is the 'longest' match."
> 
> 3. Further clarification on the specific problem being addressed would
> be helpful. The "real-world" problem this commit intends to fix
> remains unclear. The patch mentions:
> >    "This behavior causes inconsistencies during SPI lookups for inbound packets.
> >    Since the lookup may return an arbitrary SA among those with the same SPI,
> >    packet processing can fail, resulting in packet drops."
> 
> However, Linux kernel lookups using the triplet (SPI, Protocol, Daddr)
> are deterministic. The lookup will not return an "arbitrary" SA
> because the destination address is used to disambiguate the state.
> 
> As Antony suggested, this change may cater to SPI-only hardware
> indexing. If that is the case, we are concerned about applying such
> hardware-specific limits to the software stack, especially if the
> behavior is not opt-in, as it appears to require an overly-narrow
> reading of the RFC 4301. 

I agree with your suggestion that making the behavior opt-in. 
I would prefer the Default : to allow duplicate.

> Given these concerns, would it be possible to discuss a revert or,
> alternatively, could further context be provided regarding the
> specific real-world problem this commit was intended to address? Once
> the underlying issue is clearly defined, we can work together to find
> a backward-compatible solution that satisfies all requirements.
> 
> Review threads are attached for easy reference:
> https://lore.kernel.org/netdev/aDQhZ_ikHEt_pLn_@gondor.apana.org.au/T/#r45c1786651ce5af730f757aca7438474d494a323
> https://lore.kernel.org/netdev/20250616100621.837472-1-saakashkumar@marvell.com/T/#u

-antony

