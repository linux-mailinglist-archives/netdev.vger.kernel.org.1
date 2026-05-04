Return-Path: <netdev+bounces-283790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFreKeZ4+GmgvgIAu9opvQ
	(envelope-from <netdev+bounces-283790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:45:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3C74BBEAE
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7321301D95F
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 10:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696A43A6F0C;
	Mon,  4 May 2026 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ojyvViIX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18303A6B89
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777891528; cv=none; b=Bny4aeTbmv4WC46m32WpXQGbygYpR2FfzSbZA+qbpEP2/pAH24/sU9tKfpOsDdx3/29NUsn2R9LEURj4iYwAFQUtu3LXY3ZZ3Ls1a9OPCJzOl7gbu2rFoqYJUG6Fe8wztARfIRsX4DIvHIE3JDsGRhKqv3eVPgFqTPzcxc1yJtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777891528; c=relaxed/simple;
	bh=9v4I0rrhjr02/PfB8x9dXyidG3msYuPLuRZKE3wmILQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CiBiMMOnn3wa5sgRkGAV7uWMTlhE0eabKhhUic91nxb+pHj9ugVFg8yk5JdaD7MJh981b8/rT35Y/7RRim7mA5BjLL9gmDUY9yDLhdNdWh/NYZ+it2yywURPpcfyoOdnjA5VOTfBEdB7pZzA2vsZUM8r8Yba/JDpHRQQ1YFdbCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ojyvViIX; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-4470d6d2a4fso4394081f8f.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 03:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777891524; x=1778496324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9v4I0rrhjr02/PfB8x9dXyidG3msYuPLuRZKE3wmILQ=;
        b=ojyvViIXfccBVR3KvSvCPXt9CocsRP0LR2fFVrxJk+TnqLHouXTKuInwVByMmT54O5
         zf6Od+TLhHw5oJRiDYE7sBWOP0R1QqWwU3E1gd/gN/IyIsrQ509Ng1CfdiyQJFnR7Tit
         g3tqCzQS4qwMoy8yEfg8LZnBXSUylhspzLi4b/CMuuDbpmrjY38nD3pW7GakUh0O+wWo
         fiodNWKJ66/59IAR0cCSIR2TQywgwh+vhsGO104OqdL/gOv6/wzu7111nMpZ4Jv2Q2uJ
         hbZzlsw8+9Zy6BHO3E3Gh9qCL6N5LuH9AC3z28dhgv/QRIQ/8fgOsU0oVX8lGx6X5hHL
         cJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777891524; x=1778496324;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9v4I0rrhjr02/PfB8x9dXyidG3msYuPLuRZKE3wmILQ=;
        b=G3F27xwzqm82RkUZiWAFIBE0eY1k3Ifr9v78BYkNo6N5yJB6fKMaPn4RL1UQGR0FQe
         y6vL1356Uhcmk1hcoc1GBXik8fRlQnoA4MIDC1bY1qJPrYD0zbmCxxf8WdYU7aQSXoAS
         b2KeH4+DW7yrWLAEAmLyrF3jgklUijb1NX+8dOxnOryo0QEQXU0lLGxyMWI2QZWHXw8h
         Prrf9Kdtl2hXMyGW7HzduFjXAruNh2UAiQTM40W3cltVKZUb3WDXr5iBzPNlhNIVphGu
         5OGyqX0TC1w8DuEvfZaTXpjNk/pdrnijOqEGNOFCGH1IbybW9Jy/V22j41Q1cRlKIjil
         4W4g==
X-Forwarded-Encrypted: i=1; AFNElJ9oFUdP/zWmSpB73K6O6fr1TMG6kGOvDvEWbpC1LTEmCtAjWcA0hpHnr94WqpWpJllpXBpxHjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjzxwB8kSeScfiLSPAw1n+7YDNZUY897o6gSNuL4O/cuOyeEHN
	4DPsfkOpIwuee9GhalZTz0xKYceHNKciZ6Kzm36gFpYwzQ8YIdawMJRQCdFfnRaP+LNiDXQhzsY
	2iudx7g2OeqUAs3QAVQ==
X-Received: from wmxb3-n1.prod.google.com ([2002:a05:600d:8443:10b0:485:3aa2:da59])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3f14:b0:488:f453:b976 with SMTP id 5b1f17b1804b1-48a98675809mr164982575e9.27.1777891524379;
 Mon, 04 May 2026 03:45:24 -0700 (PDT)
Date: Mon, 4 May 2026 10:45:22 +0000
In-Reply-To: <CANn89iLkG7EMgmixYtOCBEFQQiBXy+-CdvTHx+EfpXF96GXyNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504-genlmsg-return-v1-1-093f3ba970af@google.com> <CANn89iLkG7EMgmixYtOCBEFQQiBXy+-CdvTHx+EfpXF96GXyNQ@mail.gmail.com>
Message-ID: <afh4wpShm4kKrDgi@google.com>
Subject: Re: [PATCH] genetlink: free the skb on 'group >= family->n_mcgrps'
From: Alice Ryhl <aliceryhl@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Matthew Maurer <mmaurer@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3A3C74BBEAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283790-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:email]

On Mon, May 04, 2026 at 03:20:25AM -0700, Eric Dumazet wrote:
> On Mon, May 4, 2026 at 2:17=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
> >
> > These methods generally consume ownership of the provided skb, so even
> > if an error path is encountered, the skb is freed. This is because the
> > very first thing they do after some initial setup is to unconditionally
> > consume the skb via consume_skb(skb). Any subsequent errors lead to the
> > core netlink layer freeing the skb.
> >
> > However, there is one check that occurs before ownership is passed,
> > which is the check for the group index. So if this error condition is
> > encountered, then the skb is leaked. This error condition is generally
> > considered a violation of the netlink API, so it's not expected to occu=
r
> > under normal circumstances. For the same reason, no callers check for
> > this error condition, and no callers need to be adjusted. However, we
> > should still follow the same ownership semantics of the rest of the
> > function. Thus, free the skb in this codepath.
> >
> > Assisted-by: Antigravity:gemini
> > Suggested-by: Andrew Lunn <andrew@lunn.ch>
> > Suggested-by: Matthew Maurer <mmaurer@google.com>
> > Link: https://lore.kernel.org/r/845b36ba-7b3a-41f2-acb2-b284f253e2ca@lu=
nn.ch
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>=20
> 1) This looks like a fix meant for net tree ?
>=20
> 2) We require a Fixes: tag for bug fixes.
>=20
> For more details I highly recommend reading at least the tl;dr part of:
>=20
> Documentation/process/maintainer-netdev.rst

Sorry I forgot that the net subsystem has special rules.

I do not believe any callers actually excercise this codepath, but I
will add a Fixes: tag and indicate 'net' tree for the next version in a
few days.

Alice

