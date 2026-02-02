Return-Path: <netdev+bounces-255806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDj3JhpygGkw8QIAu9opvQ
	(envelope-from <netdev+bounces-255806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 10:44:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 187C8CA3ED
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 10:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CE683002E43
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 09:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9362D836D;
	Mon,  2 Feb 2026 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="HuSaPAfk"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6041DF987
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770025496; cv=none; b=sJdjlHUWJTR6tqBa9W31U9I2clIh0stWcN20Iz+hHyQkruGPGW4DlU/qmNVLDC0gC/YIxZaKp2cV6bRxP6ZFhmcYgzh/4VF36orzVx921VYojTpef+dxZmpunsrbfmf26LyRhSCN5mPJ6d8qAB6X5CdcSLs5+ap+yoNmmG2fjmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770025496; c=relaxed/simple;
	bh=gHHIjAzRY/u/956j/yU7dogymyJfxap9e8VqtCo++o0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuYlYYabdz79dh0Cc2MeXBBmFheQ/jso9k/8OwCpQa+D4/QVQeu6Pvp9X6Ij4ATejP/pziAIBm/QTcaJeiK8m0icvwaSrpwB+53Zkz6zVKPeeUYueLxGsHLzaNCW5udNWj2L8TaVHo9UVOg0IWSYrnjtDYM17bCDdaj50zR/RwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=HuSaPAfk; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 58E8920539;
	Mon,  2 Feb 2026 10:44:45 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NitvhfW6o6px; Mon,  2 Feb 2026 10:44:44 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 9C45C207AC;
	Mon,  2 Feb 2026 10:44:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 9C45C207AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1770025484;
	bh=lrpU+NshVLPt9NIOaJ1IfKNBf7Tqt1CauPGpJAm3LHQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=HuSaPAfkKKARmnU3s5ZM0YzD/guofpo5edhGiy9b9mTtxQ2K5IJyvMbhgtLbybUMo
	 82cTitAXtYLTJHPsWAIky+2KiktVhJR6GCZbEyckV5Xd4vXs30pD1oCU+Q9dlJ9S6p
	 OKFcwug4kpRggAs5Pjke0XGj1tf+mAqgsFkvx/uEHnq4w2XBZQQ3A9nD+c18xhDvlh
	 Qts9EVPL+pK/uVdX/ECPDWWMjPuiCw6UGLPXxHL5nJ6M3TtX5ikA00vcfRqwgusRRJ
	 WAnOW1rmGtZGWpVf4Hrg5bmvO70NpnvRv/zmicHzODK4T3fS/TjFTN+ssAzW4unuF7
	 /w7DPXZxTLkOA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 10:44:43 +0100
Received: (nullmailer pid 1571467 invoked by uid 1000);
	Mon, 02 Feb 2026 09:44:43 -0000
Date: Mon, 2 Feb 2026 10:44:43 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Yan Yan <evitayan@google.com>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
	<antony.antony@secunet.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saakashkumar@marvell.com>,
	<akamluddin@marvell.com>, Nathan Harold <nharold@google.com>,
	<greg@kroah.com>
Subject: Re: [REGRESSION] Discussion on "xfrm: Duplicate SPI Handling"
Message-ID: <aYByCz-DWi2VZMy-@secunet.com>
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
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255806-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,secunet.com:mid,secunet.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 187C8CA3ED
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 04:43:06PM +0800, Yan Yan wrote:
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
> before direction or selectors are finalized, the allocator must remain
> permissive (at least in our current design).
> This also aligns with a concern Herbert Xu raised during the initial
> review regarding compatibility:
> >    "It's also dangerous to unilaterally do this since existing deployments
> >    could rely on the old behaviour. You'd need to add a toggle for
> >    compatibility."

Indeed, it was...

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

When reading RFC 4301, I'd interpret this as 'The SA
must indicate whether it is unicast or multicast'.

> 
> – There is a "Longest Match" mandate which makes SPI uniqueness unnecessary:
> >    "For each inbound, IPsec-protected packet, an implementation MUST
> >    conduct its search of the SAD such that it finds the entry that
> >    matches the 'longest' SA identifier. In this context, if two or more
> >    SAD entries match based on the SPI value, then the entry that also
> >    matches based on destination address... is the 'longest' match."

This is meant for multicast SAs, we don't support multicast SAs.

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

That was how RFC 2401 did it:

A security association is uniquely identified by a triple consisting
of a Security Parameter Index (SPI), an IP Destination Address, and a
security protocol (AH or ESP) identifier.

That was obsoleted by RFC RFC 4301 saying the SPI alone identifies
the SA for unicast traffic.

Unfortunately our implementation is somewhat between RFC 2401
and RFC 4301. There was no clear cut to support both versions.

Maybe it is time to do this now and implement RFC 4301
with a toggle to fallback to RFC 2401. This would avoid
these kind of problems in the future, at least.

> As Antony suggested, this change may cater to SPI-only hardware
> indexing. If that is the case, we are concerned about applying such
> hardware-specific limits to the software stack, especially if the
> behavior is not opt-in, as it appears to require an overly-narrow
> reading of the RFC 4301.
> 
> Given these concerns, would it be possible to discuss a revert or,
> alternatively, could further context be provided regarding the
> specific real-world problem this commit was intended to address? Once
> the underlying issue is clearly defined, we can work together to find
> a backward-compatible solution that satisfies all requirements.

Here we end up with the question about the default behaviour,
should the default be RFC 4301 or RFC 2401?

