Return-Path: <netdev+bounces-259340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOejGej+lWkDYAIAu9opvQ
	(envelope-from <netdev+bounces-259340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:03:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A9F1587E1
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 794CA300576E
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 18:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4024346797;
	Wed, 18 Feb 2026 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kcYEeTwE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568A0344DBC
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771437787; cv=pass; b=SMXEAtzNLreE9FB2yEUItfb7ICWPCgHBWLGUcGB7wNwm73GRni/jPgq9SOVC/J7lee2XvKzjaUiC/4AvV+DzEv1fTCTyrlDYvgNFF9ZFXjycI7GBbhxsvRJCU9I/pexVephgkh7+dlWtJcuv7GSmVRmePkX/Rgk+5UpCcd61dOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771437787; c=relaxed/simple;
	bh=mRGlLzcyBU2hMT/t/1/OrHyiZLvyFfBvs+g40nVkdfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIAD13QfKeH7eZ8/PH5tWx+YhFYe2aN2yixIDP+H/sDC/i7kGykCY7ffaKrJPd3XEuzBe+iRPtPFW3zjIOPx0sd9GQ/YITNdk4fsHTBRhxm6zYCsDMQQJwIuk4xU5MsZVshO+y+XAYLHUyRyXsI2WWimqIiue4yxPNZ3TGkNZ2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kcYEeTwE; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506a321cc53so114791cf.3
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 10:03:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771437785; cv=none;
        d=google.com; s=arc-20240605;
        b=cEFrzJ4D46XWSf1rfvNnB3Mw477WbzU+o81gd/3FVnCvvfbF2CUhjxLNtSUNnDJp0s
         ouw7YBAd25M80xNuxnSTYt4Th/Ne2H5/YCcUh+0Xb6fJeWjfIwSWeg7gPDqw3qVT1TNl
         8mdKvGc55uERa3q460WS9/OdFpYUTcbGSZMwt2RmlHEobtaglrybJ+0l7kLjQWbNzOdX
         Og5ylj1WtX0rNK2puAHBSJ/ozjpDnQO4ZczvLXqW7xkxkXEczptE2oCVhm0LoBjpTp50
         4jomtCvdDDNPnEfjHs/gwV9TnpSFbZxygqqoExnzNdesxrA5ABhjD4O0td5adRBfucvW
         lpNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mRGlLzcyBU2hMT/t/1/OrHyiZLvyFfBvs+g40nVkdfE=;
        fh=uIkjex7smlvq0LxKXRdB12u4+7+4l9do7yDfnQUtdNM=;
        b=T9PkP1Xchd+OZHb5/WNH5wB+apzu1li4BPIM6QW6yIX7wskutMH0yPtkPjAfw6XPiR
         h9NwatXzqq7oMb++wjKkwVBv8qkE+MmaEbFLoBq3Kdd06RJt5ymNpGMaEBvkT8gdQBdr
         gIIAnlLb7KbA/BrRhlAyaiSwUZXQRNgqWcYYU4yLDwdJWCGNEfwWuV7dKCsMkG3M/RR5
         dRE0E+2KLTP6Z2h/lcWBawdrMy4SO5MYxj8QEScciPmksPnuLzfDDkS3bm+YghflNxJl
         hy6WzoAGMCmW4v6fbQ3vrqXUWer/tG3Bc60pOYPCpbIJcb9r87lpzzM5JSqGHWyTZbd7
         U/tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771437785; x=1772042585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRGlLzcyBU2hMT/t/1/OrHyiZLvyFfBvs+g40nVkdfE=;
        b=kcYEeTwEtklb+cSwo1j/UX5kIvJoJOO3Dhpsg660hGjm4ehw+bJWDHjVx7Bq0zMHbW
         MnotCPuM15LPPZqRjhIy0c+AN20HMT7KI80x7gFGBegV1MWFjGdrNnmv4dZE3FOb1pUG
         eEoha5+7UZr1rCDAOntt/I7t0AR6bWz3qR9tzskXInpdQWlCes/JwRP+bWR3oHVSJbTz
         K0niB/w58Lmu1/uIzbajjCvXNtkryT0/O5CkfZD+eFBIgiMPbjfyccjLP6gwdW+ub9lR
         RDjBXMFqpzK1aoJxaY21XKgT89Et2uy+y9DkVICi0IA6F+x3FMNYD2kh0G/meA8P76Kj
         djNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771437785; x=1772042585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mRGlLzcyBU2hMT/t/1/OrHyiZLvyFfBvs+g40nVkdfE=;
        b=Lj3KzeND3yrBDYJFBY3gjZQbXKLJ7DPOuw34PnXPSTi0PRMfFyaFdHw1RLmbRPrLnE
         kEPb9xYUQkh4uL3vyL72aD0Xs6yP/scJriLJyl0x76ceOUtgA4qrF3hWMjVsWLtXS9N+
         /JJhVHqe0RkpbHpJl3WS13ssjx8oVL7rplfD0fR3UMRzimejEjy+zP5yYM0ydD55gvdw
         99UuyXproOhtTNuK90EFKetxFp1CEhx+sgs2KJZ/Zg5NduICWy/f2vmPelKcanrRTmmm
         h2618zWilB7/BGvh/ZCECmK/fvLMcKmYiaiY2V4qrXdb1Qxa+f291qQGYOLmV63QR3ME
         CZ/w==
X-Forwarded-Encrypted: i=1; AJvYcCWmdi//258KDSm3xkLWaZJWcvxaPahhx0Ln6VrNDxoK2V8yrtIZYJhFJtLVEHnVGSsW2e2C7Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGDECQGJKNsWnb/P+EhFJrTiYXvAE25oBxdkIX0fw5ZPMMizpF
	jOFl6N+G39UScGGqQ+4/X3m5OuOOlvL4vKaJ2j05hTm3iQ0exa5krJAlIu2K+j7PRCwewpFbQZU
	Aw0PB1Au/shRzpzWB1aIJrSJgjOrgS6zdk35Nc2et
X-Gm-Gg: AZuq6aI87uIWlnEkbyj8taGFpaxHzNmjf+d5qazUrerbzJScOZNLNhE6ipyCw6zyt5t
	efdl0avCfEBy6D7b8FGw4mtSRQrfN0MTJOp2Xa8oY655lUlSAVQdHWhlyK8KwHaXw9j/WDtqdkA
	1ZKqVr/ehaJugOU1Ab+mNAbLOHrDRlxc1zmBNQO5UGSUJp7O1ynfLXz98np1sHKNy2PGuIzhbea
	4TCrLqpVrwonRZUxerUU+SINviSsfl4FEk4ubc4JsY3xqduibBVgRakIb8apxQNvOJzB6FnmtJC
	8CX/gk/q
X-Received: by 2002:ac8:7dc5:0:b0:4ee:1e95:af68 with SMTP id
 d75a77b69052e-506a6a5bb0dmr253127521cf.36.1771437784484; Wed, 18 Feb 2026
 10:03:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218141337.999945-1-edumazet@google.com> <24fb96ca-042c-46ce-93cd-a6c2ce710795@gmail.com>
In-Reply-To: <24fb96ca-042c-46ce-93cd-a6c2ce710795@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 18 Feb 2026 19:02:53 +0100
X-Gm-Features: AaiRm50uUB20ht8FRsoBazB_7jBPYk_S8JpaqMK0SnyH5l5xnn965lhqfYSVdzs
Message-ID: <CANn89iJ2Ox2-Wfxggv0_v9-1EC2hS6nH_fY8Sq2O1yS2Hun7yA@mail.gmail.com>
Subject: Re: [PATCH net] psp: use sk->sk_hash in psp_write_headers()
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Raed Salem <raeds@nvidia.com>, 
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259340-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,nvidia.com,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C7A9F1587E1
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 6:55=E2=80=AFPM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
>

> Thanks. The PSP spec suggests in multiple places the that udp sport be a
> hash derived from "inner header fields", so sk->sk_hash fits that
> description better than sk->sk_txhash regardless of RSS use/abuse
> categorization.
>
> It occurs to me now that fc724515741a ("psp: provide encapsulation
> helper for drivers") also has a bug of unused udp sport parameter. I can
> send a fix for that later, unless you want to remove that as well.

I saw this sport parameter, and thought this was there for a future
patch you had in mind.

No big deal.

>
> Reviewed-By: Daniel Zahka <daniel.zahka@gmail.com>

Thanks !

