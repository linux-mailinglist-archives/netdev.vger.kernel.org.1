Return-Path: <netdev+bounces-282396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iM/ZIy0K8mlXnAEAu9opvQ
	(envelope-from <netdev+bounces-282396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:39:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 000E7494FBC
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A09F430179D4
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 13:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37F93FD15D;
	Wed, 29 Apr 2026 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQ4Byc7h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AC53E1D1B;
	Wed, 29 Apr 2026 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469867; cv=none; b=bm4bhHTuie+6u+G+HOj7gxof7iVf2qPwOts2EIu3xG/VPOfbD8J3X9VmZ5RVYcpzILzLGioQ4Y+7sBMA2oKk+mL1QBGR4f0wY4GJr4ZcQR7o5sXnC/6H2CP+Zb16wLJSmiQQuzA+kJBDhn+dZY6Ky5UjgRAU0SYzlsSC7dyEzDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469867; c=relaxed/simple;
	bh=r3/HfxpR1X8NHyDwS440OBhOvPcMyYHsrYvctOYR5cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8xcSEQI0gwafPVR5TolqhQeGqILEipkZU741LM5PhU8U3YRtee4YuhkRth8neo/cgLDAJWqFu7Xbg9LeTF4OU6Yzh53EwrOA4J9L33zGRE/iQO7LbQj/VDFOml5lV41qoRjwDhqh5lvsfqGqWcaHEMZtgB39h9blMnKHn7XrDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQ4Byc7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B94C19425;
	Wed, 29 Apr 2026 13:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777469867;
	bh=r3/HfxpR1X8NHyDwS440OBhOvPcMyYHsrYvctOYR5cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQ4Byc7hIU8/nsslh5edyDHZY5/f89eiKOox0Yu8ym9CXfa03dSXjX4epESeeo7g3
	 HR1oHVdGnEfieWQMHoTTETT3kAquKv7wSlgcDDiRlykVKZPS5cFYAfKtO/FzXk1YvL
	 WtEXUbopLBZBFD4CwbmIE74Zd5UeSRdklpZhBvign9dxK7PxSyA6ZPYaRzLlqdG26g
	 gTjtCyKgbUIN6uzIMwWi10Cx6DYdeRXNAsyCSPQSc3pTuV3/BUNRgE9ZSRR9rc8ofQ
	 wwz8dwvTbf/hqELP+PtR5B5D97U8mXQZD3liUuegHGDVaDy1QPm1tgqIuA51Dxo/sF
	 WbzeUCGqUjjww==
Date: Wed, 29 Apr 2026 14:37:42 +0100
From: Lee Jones <lee@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] nfc: llcp: fix use-after-free in llcp_sock_release()
Message-ID: <20260429133742.GE1806155@google.com>
References: <20260429132218.3548644-1-lee@kernel.org>
 <CANn89iL_o4dJ-zgjGzA=gGXiVF1P0TTz74LJNuy2zrgbxB5S0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iL_o4dJ-zgjGzA=gGXiVF1P0TTz74LJNuy2zrgbxB5S0Q@mail.gmail.com>
X-Rspamd-Queue-Id: 000E7494FBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282396-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On Wed, 29 Apr 2026, Eric Dumazet wrote:

> On Wed, Apr 29, 2026 at 6:22 AM Lee Jones <lee@kernel.org> wrote:
> >
> > llcp_sock_release() unconditionally unlinks the socket from the local
> > sockets list.  However, if the socket is still in connecting state, it
> > is on the connecting list.
> >
> > Fix this by checking the socket state and unlinking from the correct list.
> >
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >  net/nfc/llcp_sock.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
> > index f1be1e84f6653..feab29fc62f44 100644
> > --- a/net/nfc/llcp_sock.c
> > +++ b/net/nfc/llcp_sock.c
> > @@ -633,6 +633,8 @@ static int llcp_sock_release(struct socket *sock)
> >
> >         if (sock->type == SOCK_RAW)
> >                 nfc_llcp_sock_unlink(&local->raw_sockets, sk);
> > +       else if (sk->sk_state == LLCP_CONNECTING)
> > +               nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
> >         else
> >                 nfc_llcp_sock_unlink(&local->sockets, sk);
> >
> > --
> > 2.54.0.545.g6539524ca2-goog
> >
> 
> Why are you sending this patch a second time?

Because I am a dunce and forgot to clear out my send cache before
sending a related but different patch.

> You forgot to add a Fixes: tag, as requested for all networking patches.

No problem.  Please ignore both of these and I'll follow-up with a
coherent set with `Fixes:` tags applied.

-- 
Lee Jones

