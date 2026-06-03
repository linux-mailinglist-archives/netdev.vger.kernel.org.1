Return-Path: <netdev+bounces-294846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9yFjMsBeIGou2AAAu9opvQ
	(envelope-from <netdev+bounces-294846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:05:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2490E63A074
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 19:05:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=1wt.eu header.s=mail header.b=vspKi0oq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294846-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294846-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=1wt.eu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 839F5300F157
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 17:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477663E9C08;
	Wed,  3 Jun 2026 17:03:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEEA3D9678
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 17:03:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506201; cv=none; b=NXX3PxaSM+nT/DUbTk24Wusz0n5hJz/TDVL8e5Z9JbmK6hPDwF9d/2FJlToXcMFCl0CSz2p8NfJTOrrJb6A5XIGuI5auUICvIZ3EaEG199fWRYtfEd1KhdB0E2D7INRFwXGvY1yDSsbZ1EnhFY7tVr3d9jpsIRxrz9PhfxB1pGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506201; c=relaxed/simple;
	bh=QZ8/KA1hAX7PyJ1g+oLKtus6CunG8F0BvLPZu5S97io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4+Fq/xS3xIBDudBMBqbfdUPbU/8lWBlsIInueXNo+MnYxnwyyAEu+EeZVfFufoiwzU+BjFu8qyT1XtzIv1zvfD2qcMaGn/Nu1SGnh41BYNSuezb/w7CN63brBJDGLDYDlh/T9UHxhZw9ZPWW5p83e9e92El0Wzd79bBF0gtYLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=vspKi0oq; arc=none smtp.client-ip=51.159.59.229
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1780505726; bh=4rfqiqOyEFqhvnLoLgHUWx8RVt4JanLC9I7DxCRu254=;
	h=From:Message-ID:From;
	b=vspKi0oq1T+SKD7OkXFlvk69yzZ9Vm/lLGEst/6DOIkOAlF6brqhhQZkQW7Gg0l/U
	 OV2Fq5fQG/+Mxw6h/q/LcJW3UF90ClonfB0ZMETM2v+yBDPiZ0Ft1ZSGWSBMhDnW6N
	 pTZq7z8zrsSu6Hd9/EkvQ36JmyttpTm9I0UN0eR4=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id AD740C0AE5;
	Wed, 03 Jun 2026 18:55:26 +0200 (CEST)
Date: Wed, 3 Jun 2026 18:55:26 +0200
From: Willy Tarreau <w@1wt.eu>
To: David Laight <david.laight.linux@gmail.com>
Cc: Doruk Tan Ozturk <doruk@0sec.ai>, oe-linux-nfc@lists.linux.dev,
        david+nfc@ixit.cz, netdev@vger.kernel.org
Subject: Re: [PATCH] nfc: llcp: fix integer underflow and missing bounds
 checks in TLV parsing
Message-ID: <aiBcfsXn0BhBi5ae@1wt.eu>
References: <20260525202427.67768-1-doruk@0sec.ai>
 <20260602135610.5f79ed10@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602135610.5f79ed10@pumpkin>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1wt.eu,none];
	R_DKIM_ALLOW(-0.20)[1wt.eu:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:doruk@0sec.ai,m:oe-linux-nfc@lists.linux.dev,m:david+nfc@ixit.cz,m:netdev@vger.kernel.org,m:davidlaightlinux@gmail.com,m:david@ixit.cz,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294846-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[w@1wt.eu,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w@1wt.eu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[1wt.eu:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,nfc];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0sec.ai:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2490E63A074

On Tue, Jun 02, 2026 at 01:58:55PM +0100, David Laight wrote:
> On Mon, 25 May 2026 22:24:27 +0200
> Doruk Tan Ozturk <doruk@0sec.ai> wrote:
> 
> > Multiple out-of-bounds read vulnerabilities exist in the NFC LLCP TLV
> > parsers:
> > 
> > 1. In nfc_llcp_recv_snl(), when an SDREQ TLV has length == 0,
> >    service_name_len = length - 1 underflows to SIZE_MAX (size_t is
> >    unsigned). The subsequent strncmp() and nfc_llcp_sock_from_sn()
> >    calls then read unbounded kernel heap memory.
> > 
> > 2. All LLCP TLV parsing loops (nfc_llcp_recv_snl, nfc_llcp_connect_sn,
> >    nfc_llcp_parse_gb_tlv, nfc_llcp_parse_connection_tlv) read tlv[0]
> >    and tlv[1] without first verifying that at least 2 bytes remain in
> >    the buffer.
> > 
> > A nearby malicious NFC device can trigger these without authentication --
> > LLCP link activation happens automatically after NFC-DEP.
> > 
> > Fix by adding a minimum length check before the subtraction in the
> > SDREQ case, and adding bounds validation at the top of each TLV loop
> > iteration.
> 
> Why not fix it properly so that it doesn't read beyond the end of the skb.
> 1) Change offset and tlv_len to be 32bit - no point trying to do 16bit mathx.
> 2) Worry about non-linear skb - perhaps just process skb_header_len() bytes.
> 3) Allow for very short frames.
> 4) Don't read beyond the end of the skb data.
> 
> Something like:
> 	tlv = skb->data + LLCP_HEADER_SIZE;
> 	tlv_end = skb_tail_pointer(skb);
> 	for (; tlv + 2 < tlv_end; tlv += 2 + length) {
> 		type = tlv[0];
> 		length = tlv[1];
> 		if (tlv + 2 + length > tlv_end)
> 			break;
> 
> Then as well as the check for length >= 1 in SDREQ (even 1 doesn't make sense),
> the SDRES path is missing a check for length >= 2.

[ just moved sec@k.o to Bcc since this is public discussion, please
  don't re-add it ]

Thanks,
Willy

