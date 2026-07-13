Return-Path: <netdev+bounces-307001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9fiPGCZXVGphkwMAu9opvQ
	(envelope-from <netdev+bounces-307001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 05:10:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5231746DBA
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 05:10:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qQIOpN3h;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307001-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307001-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0B1D300D9FE
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 03:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A8937755A;
	Mon, 13 Jul 2026 03:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E065B3659EE
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 03:10:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783912228; cv=pass; b=U2tjTMOmRu4ndwQVWqB7L75dvges6YO0JctX+1EhIh8/K9iT/FC38iihwF2oxKwsIMFBnmaMepyDHTS6etuNakfluRUvGs21HasSgMhWys2Pg+X7KkV/QBGtxLDanrxdkEXO+ksb9v+F4OlBiCwSprAgyN51bJZiRVoN2zLdvWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783912228; c=relaxed/simple;
	bh=snbQm3CdmGNBpMwSTg0euodzn2P+zqYJrnjlEEblrKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sajyXotJVV3ZtDsWoTAOMwiNl7h4XPe8jHUsQI1cx6LNEIspoqmfhmO6qDZsFz2DXzICrpzlaUjGxW+8jzlSq/kxgV8qQVTPo3su0R3aPk6cIQ5ExuxoTstvbDcPusLoD9tlt9BeHBK6oGpbeJx1LdGdvDMOAMz27HW7CwAoNMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQIOpN3h; arc=pass smtp.client-ip=209.85.218.47
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so314571466b.3
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 20:10:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783912225; cv=none;
        d=google.com; s=arc-20260327;
        b=WEu6FoNSddiE0ml1T4Q6kA1qsciAY07mMX2GMmu+2LAJ0TH7wBciHAr2F+ztQ2WIJZ
         1qL2+f3cmQD4pUPNRKLcARTndTN2dxzuOK+S50hUoMrXuwRS/wmUEnmBH2hoTH+1tCUZ
         spcjZZ/jGh0WRTA9lLuW0oOU9QsH5KiVg8Q6ihZR6NSxXGsQKnxzEGMtHd111q03GN4b
         i6z3rV64f6C0RaUzJYQMsahuqPNddTY86TFbUn1G0AMA6fsLVLAuGrHdO6npkBYGMxrb
         5Pr9vgLbvqtNY0SHJQoZp4j+NdmAhQqkspjRFSZgYGeZ+RN8flANS2P5ONcyeIv9Snxx
         fFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=snbQm3CdmGNBpMwSTg0euodzn2P+zqYJrnjlEEblrKw=;
        fh=q1FOxyidBAft5Eynazo/02r7J+Z7ny5g1Da1/U8dYVk=;
        b=dH4LYvJyZPZoWHUm6ywfq2nn7glxav/lYZ+uioGOqKjJnPlJT+YJye6CuzhtSDuAq3
         wVWIpf9ozFEzfAgRky21gQUWvsfU0+Roc91NeNizsnTzFIphv4V3L6iq9tBbkAMlwcNq
         4/Fz+375eyuWuhNmMJYbmBqpN4e6uy4nhGZ1xkMWM4RmFecUIDgVbRiq38/6g6wfvugC
         6QPwUhlyOm4yoyAjv1FZiwhhtdIIBbt11pA1YOb5QltDz2B+O3VG9KlQ31RduhQi/V6u
         OBIE4WIknp5dk0Y2vWSAt93FlY1SlZ2ikV/bVYXHhABNpm94H8e1BMAPYlSIiYOg0mZv
         LXkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783912225; x=1784517025; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=snbQm3CdmGNBpMwSTg0euodzn2P+zqYJrnjlEEblrKw=;
        b=qQIOpN3hm5ph5vr/p5B+kRdd32XXu1Xwez28v/pNX9vcDcrjZMToco8LwN+LdLZtBY
         dc/PZzutHteVy7zQFvn/nzrGERhw5z379vmPXH2hKg80L8CA3Vy+EOklI37dPkgZLS7b
         bH9uKixehRsxaGsehRQD6VA81/dP/hk5aWqvzFihww9/fmkYcLdoFHdFFChI4siIK0tf
         m2txI1brnKgO1BFhhNfLft0fx/Nu7JrTNVldeRer+Bo9oXgTGzJzn99q1RcNUgn10Utz
         RmJCPkherz84rn1Ffm9wlI6OE9oB50FQuVUAzzPP1Svce2xj4Eji2bSYjGGOp/sSJV3V
         h3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783912225; x=1784517025;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=snbQm3CdmGNBpMwSTg0euodzn2P+zqYJrnjlEEblrKw=;
        b=R/8pYYFhHPKC65EAe0cidE/RNP7PFKhZAvNGikyuTWSWzhv1sbZHdlEqdeVqJINVZi
         g7Q2tV7imt3SJ/vwAgwaojkrTCsDxW/4z5Szwqle+phsxOypa2JQHL3hfjDRx1ijRuyo
         3aRHgu5QFirKKkRkXZvpuYTpIEltz54bq9PNlmlPgEb5L+zc7FIE35csuWulObk4AMaK
         FLqCTejSfV74xsQMj+3UOe8VnAN/zd2bui0POVjGuUjlPksnKTTY7T+X3YraWx4scQYM
         asGzGRiVNRQffGiJDhaEVcyGxKFdBNhyTeDdfQaTAS4x4056VdQYmP9lWEALzcrZlxPZ
         8mzg==
X-Forwarded-Encrypted: i=1; AHgh+RqTM7y9QiF1LPuNccd5peDyu96PiobrX+VWCthWYNLrgOKbZPhCGjNZsmRHMQoyjxMfaD6S+B8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCJkv0F5/ShCbVL12087IZK+ntSVrgSlzUrGrSA8ULzGDK1p+k
	eGBOjwOUYFbD6qNRcO3UsdeYUi0LS6Z9aaYO0sb6jq+HlmPwzqRCp6tiO/iy5p6KJGRsukLLY2y
	RhE2/ztrBG39rjDvobToBIQenkfm5lao=
X-Gm-Gg: AfdE7cnMbh+SbQpA+9tsfuY1C+WNe1Y5UIjU1iGsippbLdvxwv4th31EK1SJC7IU30e
	8IerEu2XYFQHsBKoX50AnNeKJZISgKIiE9zqPUv4zqUjd1n8+Uk69VGdzD2jtw7/YsuhDQaiP5Y
	atCAtJViuTVXQ0zBl0o4fcIgFF6qvT1AGsS8LfZaM8+H76nKzCOREbjpvPCjwhq43mABR121Zb8
	KfpFoZYKImd0EGIdZo6Lq3x2p8Bvszws1NzChD9RermvoBfUkbQIG7Htf5C3g7jL+zBexg=
X-Received: by 2002:a17:906:c149:b0:c12:9b2d:67de with SMTP id
 a640c23a62f3a-c161f388078mr261421866b.61.1783912225130; Sun, 12 Jul 2026
 20:10:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709063012.33160-1-running910@gmail.com> <ak9_wZz054a6JMb5@orbyte.nwl.cc>
In-Reply-To: <ak9_wZz054a6JMb5@orbyte.nwl.cc>
From: Zhixing Chen <running910@gmail.com>
Date: Mon, 13 Jul 2026 11:10:13 +0800
X-Gm-Features: AUfX_mwxGXvwgTE6oy5EXU__Jfy1OQZvXPr-yq7oHlr7ByZwFljnkmdYU_NfKlc
Message-ID: <CAMyuFdWjGnoQvE4owtnwANTiaxbq=dtvFri9+vQbPhTEL2aWgA@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: ip6tables: set hotdrop for malformed
 extension header matches
To: Phil Sutter <phil@nwl.cc>
Cc: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-307001-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:phil@nwl.cc,m:fw@strlen.de,m:pablo@netfilter.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[running910@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[running910@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5231746DBA

Hi Phil,

Thanks a lot for the review.

> There is another candidate for hotdrop in there, e.g. the "Packet
> smaller than it's length field" check in line 76. Or is this a
> legitimate non-match?

This should already be covered in the current nf/net tree by the previous
IPv6 extension header hotdrop fix, but I will double-check the base before
sending v2.

> Given the many common blocks, maybe introduce a 'hotdrop' goto label to
> jump to instead of break/return?

That makes sense to me for the repeated hbh error paths. I will look at
the flow again and use a hotdrop label where it keeps the code clearer.

> I think the 'srh->segments_left > srh->first_segment' case is also a
> candidate:

I will revisit this one and check it against RFC8200/RFC8754. My current
understanding is that this looks more like malformed input than a normal
rule mismatch, so I will account for it in v2 if the check fits cleanly.

Thanks,
Zhixing

