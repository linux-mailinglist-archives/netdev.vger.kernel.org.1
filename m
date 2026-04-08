Return-Path: <netdev+bounces-276715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJQNDhHK1mkLIQgAu9opvQ
	(envelope-from <netdev+bounces-276715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 23:35:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A39983C41DF
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 23:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 136BC302B76C
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 21:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A7A3537DE;
	Wed,  8 Apr 2026 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lzFEWp8j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8276E331215
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775684108; cv=pass; b=J+J6hr4nkVQCLIFTNjrfJRiZVEVHBX35dAV6St2AfxJ18wqwi8GVB4VwFQi+aZ4Ea6tYsGWpOR0kB8ha7uUt7Z3N6h4mZx1SwQmeazTBCtKVI9y5T6txtcmMIpxfhgd3R4FF3CNgTgWxpYx5rstIcvdY093zls4KXp+TqaMqxvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775684108; c=relaxed/simple;
	bh=HFq2LoxBVj4fckpeZUc4HGnlttc2e083r4DQV3Ut4DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Shb3Ua1yhfXtPUfhIcFuT3eASZ0TdBn8RUpPokPm9G2jQGpkwr87ddwt05TAiGR0E8OyoP3aMA4x7sUSNMBLlVMDJ9TfuWgMv1lrywm1f8ULCzmkPvJRFBSDF9XwOHj7hvzZqg204g7aGV9uGv0AgHyT0/TtRGr3QI5d0SLs134=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lzFEWp8j; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66baa7fdfd3so1489a12.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 14:35:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775684106; cv=none;
        d=google.com; s=arc-20240605;
        b=BOKprdQmuzEwiJ5pfNCFmGdH6lVo9VQMSADFQ9WsoKt5NATsEbBEzs/O8Iw2uC2yT3
         nyxnc/1hMCpTxn8pMQpEFFp3+d+fWOZCRLAi1C8Q9Qgg8gpm6M+HxlcXE/sDRNTV1Cvz
         6ywyEMliR0BxCFgI1PBxRKNuztW31Pb3A2cNue2IGhQYvLV8St5uqy4dEr0nPIldKJl5
         6/fouWRAAtd//R3YiT2CwCGTJugOwaaZQqvymLHt6tz+9uLtJykwGNpJQrqRz7v62s6O
         cP0NmZWEgQ+Zvkuz3nF3JtvNGVjrPg22uH4ZIzvxG9CF+VW4blRm8YsUDHhffEEpA8SX
         8yEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HFq2LoxBVj4fckpeZUc4HGnlttc2e083r4DQV3Ut4DI=;
        fh=qUq4Q9f6yczDdrr4Hw3R4bhThgC25HkVgyQM/lk3sx4=;
        b=cs9e4zHQJRZGTzGzjYsX2JgIA9+Z1+UaPDJymtb1KnnT499ixLuD/tSFc5QjIDxlsC
         dd0xUBfwmSJqeypTa8mx2dsHpX1sUJ1v3Xrw7f2qKnbNuykLI2YTdTTWHCoy+SjQQsco
         PTtRrBv8rASmHTVjGvvPb1r9N0SZIoPmUuXZhR2vXvQyAKv5CRZ38uYOrC3xFvuGl/f1
         GeQOKgYzPayrM/6nwhIaZAuZ4S42OHBjtpUMjKWBP7F6JrDvA2R+5P6HQl0QoHl3MCe3
         XfDSClHRXrIPvNL5M8An93dLp94VnAvvaJ/PiA2qcI+yZVmbaX/cVNs86J661/0rAQGA
         UeXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775684106; x=1776288906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFq2LoxBVj4fckpeZUc4HGnlttc2e083r4DQV3Ut4DI=;
        b=lzFEWp8jO1N++zFtfzyvee59gdgavzp7u/E73QKnHdJEhELkeAW4jAmAg1T+Zac7bn
         3mc01W9T9TidyFKHnzVEe7G6A2+OPwNQ9fdEcSdzOjpNuK3XQ9fdJKNY9N8LBUHTRT7M
         29BVzz0iBLkwM15m02I9ZlyuhCmuRWrLCG9a8knHBBBid1M12lxU71Bg65cKxgsYfGE/
         IvOnRfr6a4MXY85vy/avl55Ulfu9Ufu3ulxXX+DqXAJWc5k2maPsgwFt6Z+h0c6ZfK9a
         MLQU7ll0bNGLT9L6fKEjf7r12UMG/qzdYfK5KQ7K7s82FNa5puoH+9rinrojKUMP9O4y
         Ls+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775684106; x=1776288906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HFq2LoxBVj4fckpeZUc4HGnlttc2e083r4DQV3Ut4DI=;
        b=h19Ted17Ob+Nnhj7pSyeSFwGAapoM4eRCkabpeanjQwqyUfX4rkQTSJaMlKRo2GJ6W
         2aKXcBMtSl9JGtLmKCdjACiC6gaqJXLOTClT5c0ZaG0qREr5tdrXakKBJfj1OWH6IY9q
         tUZjR0Oqxmsoo1KgY7vwNRkLXBPpFLP6U8EX4j/EO7PIs0TIM4rnj96hEy26uk3ztswH
         8+0sTJcTw+0+IDhPfSog7a3C4LMckW90eiHPf9im7juaUaYZu8aFG+32Z/Ryd53YiNuT
         ny2BVoNdWgZJR8ml1ua5fiW2vyhxEFtdSCAEGkFaXMgqCbwMsKk8KfBCyncYWvk519Ti
         pcjA==
X-Forwarded-Encrypted: i=1; AJvYcCXjgwQiUSpbllQoZxgUT5MDrU++XzxpoxX/GZjApZJrXV9dFjPWjWeUf9d48SvE7Eu/cwarDfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnAGSRF0gLhzzGaVEdfpjUWArKceWi5Wq/UxH8meYVx/9CC2YF
	LeQKwmgOoVrphyfjoOMSKWdM0CKRYp+Kn6HPyF9uXnjuYkOusQm9GuWWEnlgcTteDzqTaFg+zN3
	3pao3dFlfm5P2Lur/xsuMiH5upwTOU6EpsGViTPrA
X-Gm-Gg: AeBDieuX19KgfYV9qIDQeU0+hCqqU492MufoAuQm7wh1Kera/OjFxRl1D1GXAQujdaG
	ZWxaj8D/22I0X1gbE9tP6w+Wdzcqah+NrUmN+h2CX+9eN6ZstQSQXvOqNZUY7Oj+hsVnrkHLtzO
	eJVLla/RM6zIuVICcZc64GVVvFzyBk5czvuV++q1AMM4c2dQX7d+LwiVjDeNo7Nb4ZB+nnvqtVa
	L+0jaS9a3N4Gt5kP77+YELWgwiMrmmJ05YA5iGc/+152z1ghzIrWiwR01PhEpizHkoIAlPMe+MP
	9Vr5TOMBzlPn3sZUqpQCpOwIHfR0t+wscvOVByJj5B5GWdvaHVIUFuKtJYjPya8i6C3r
X-Received: by 2002:aa7:da52:0:b0:66b:d36f:f83e with SMTP id
 4fb4d7f45d1cf-67010c6751cmr14364a12.8.1775684105411; Wed, 08 Apr 2026
 14:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
 <utlz3oebjyd4lqp5pd4qdbth2kywxo4hrlrnwcxsx3br76fwfg@vy3tx5f3lv32>
 <CANkEMgn80UM7+mymVm21Q8yszgVeh029tvO+kHqmLGmf-2MU5g@mail.gmail.com> <iuhx4kkkftjx52y5qo7w7p6rbxqakq2eu74r66xaepd2p2khjh@kdhljd2c2bpm>
In-Reply-To: <iuhx4kkkftjx52y5qo7w7p6rbxqakq2eu74r66xaepd2p2khjh@kdhljd2c2bpm>
From: Marc Harvey <marcharvey@google.com>
Date: Wed, 8 Apr 2026 14:34:53 -0700
X-Gm-Features: AQROBzBxW_aF-2JywzqnQs0o_tGwjHDgVWPLHOtNwUoj9mMSKYAB7APUMV3drE0
Message-ID: <CANkEMgmEsYvx8OqCMc2BEdz_UuiJ7EE=hurV7whpN61nNGq8_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v5 00/10] Decouple receive and transmit
 enablement in team driver
To: Jiri Pirko <jiri@resnulli.us>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276715-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: A39983C41DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 2:00=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
> Wed, Apr 08, 2026 at 02:12:35AM +0200, marcharvey@google.com wrote:
> >On Tue, Apr 7, 2026 at 4:55=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wro=
te:
> >>
> >> Looks fine to me now. Do you have libteam/teamd counterpart?
> >
> >I don't see a need for this to be used in any of the teamd runners.
>
> Why do you need this then?

Initially, we plan to use a non-teamd userspace component for teaming
control due to several non-standard requirements, such as
synchronization with unrelated software. It is probably worth
converting the teamd lacp runner to independent control at some point,
because according to the spec: "It is recommended that the independent
control state diagram be implemented in preference to the coupled
control state diagram."

