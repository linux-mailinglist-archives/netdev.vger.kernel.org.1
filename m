Return-Path: <netdev+bounces-110416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC43992C41E
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 21:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B01281728
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB5F18004F;
	Tue,  9 Jul 2024 19:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nH0icW5z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12D77F7C7
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 19:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720554718; cv=none; b=VImpddYwVKdvF70JtTmmHYV3weZp/mpH+25eHqkocpHMhtzKzVGnFoZBsQlO8TdIVIuQ1AlFdUmtnHfz9BK14+jA4qBZzDZTLwUL5OOOO25aKrhQVC3f18UEdJGknLdOAxNbSdYsmmEr5Z24JnwS4mbYxBxaNxBLqHfGN3cRzg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720554718; c=relaxed/simple;
	bh=NcaSZUV2BugWwHTqoMoJRdD9itT4juIBud11fIhkJRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jqqzly5mUVAfxXVDfM4lPLMzGPYCMUrtFA3OY2pQ8KvUBYK2sBliFtGL+OuGI3nDIMoCoHWtEfR/KnBMN9GxqIpIAYvdIjcbRo5wVbJwglYAiSVx9rB/ZGZsWN/qp+tUz7f+Ex345Z656ow/pMA30gHzmvQcQKV9KIpVonW/qcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nH0icW5z; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso3183a12.0
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 12:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720554715; x=1721159515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftdEbrPvGCpsyD5WpkITmSYG7ZwgEqZiinbCJxdnov0=;
        b=nH0icW5zBieDJpD2O4wY91r6E3gHpqC001ILEvnsOZH4IiiYFBtJyXMG5yWWr6tULe
         GMSp2JAtrHOW99Y63pKvEib/vVyqjjRk5BafBRN9rd+F7opb3JoKT7fSP7D0J3cXq0cZ
         LEdOXrzSjNT8lGjbBo7qd2+OgqxX+AMb3Ht/ldhU8PE5GN2a5mwweAa6LYUqcROKZxLz
         Ew++WC9yTlJNrS4NdLlRcSAhUOnW3jio1Pp0KZDniVtJk30Cxgq+Yl5VF5VH2E+PX1Ug
         hwzh0nqrW83REO4OKrLVbp+0tpl4s89QLJIeN5Ak55akT1zajRCwjF8X+oyu2qLspXMj
         QlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720554715; x=1721159515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftdEbrPvGCpsyD5WpkITmSYG7ZwgEqZiinbCJxdnov0=;
        b=v/AH0JgeGAWXkNoLQmzBYhP2//yXwjQAunJl6jBMTdV8U1chMjDOrV7wswe7EV4AkC
         LhFBZHLigLd2CCcVnGea6Ag+wcSDKFTQDKDCibwj5KrmIZf+rAHJ2JEjglCcqkWXHXvT
         xcNKcf1AdF0B4uyJCa42Abv8f8E483bhh+g+K0dnKDpfH03T9ksMUUO6BSPLOxUqeMF8
         JVexFpFPqPzWfeyLSVr/vfksI6c6iH4OhcIlR/Tm3Hh+SDVF8cmWT8M39aXYXOdzFXXA
         fKxg74aL/nq9G4gBcpfW8TRFn8ZWc4qIWEPZ4D/2q0ZOi6KlLA8Lek0d3aC5xBUH64Cu
         g/bA==
X-Forwarded-Encrypted: i=1; AJvYcCUWbc15HlyLhjoOWechtdpjNHAyeVw0LphWGTFvIIRfFjNCWSU5s9ijJv+qu2+ys/UCvGEHCwkILP7X7EUU3qF+gBHeGTjk
X-Gm-Message-State: AOJu0Yzz0C5PVBnQm0BKonfciMGTZrHWHfM+BBckKd8rc5GZPb8gL5f6
	3m4NazTVHcH2Q5/hTexc5AYGc3dcUScKDFsXm6FDEXTe+ybiukQvUPoYn22GR2/05i/qllYD4od
	fg6FdxhilUPuGFJzkwFUhGcuDskV+Mx8yafSH
X-Google-Smtp-Source: AGHT+IH8SBwyTI7Sca1TyLS6MWrD2TpylnSyPyp9Ud1+JYTC31cg+k/ANT3aKoQU39Oxxa16daJYzayF/PTpIA5oiWI=
X-Received: by 2002:a50:d4d5:0:b0:57c:b712:47b5 with SMTP id
 4fb4d7f45d1cf-596d4daf804mr45862a12.4.1720554714993; Tue, 09 Jul 2024
 12:51:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709191356.24010-1-kuniyu@amazon.com>
In-Reply-To: <20240709191356.24010-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Jul 2024 12:51:41 -0700
Message-ID: <CANn89i+pijHpmoKNXm+d+Acs=RVp_wMTKJKhR89R2FOEFaYv-w@mail.gmail.com>
Subject: Re: [PATCH v2 net] udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	David Ahern <dsahern@kernel.org>, Joe Stringer <joe@wand.net.nz>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 12:14=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> syzkaller triggered the warning [0] in udp_v4_early_demux().
>
> In udp_v[46]_early_demux() and sk_lookup(), we do not touch the refcount
> of the looked-up sk and use sock_pfree() as skb->destructor, so we check
> SOCK_RCU_FREE to ensure that the sk is safe to access during the RCU grac=
e
> period.
>
> Currently, SOCK_RCU_FREE is flagged for a bound socket after being put
> into the hash table.  Moreover, the SOCK_RCU_FREE check is done too early
> in udp_v[46]_early_demux() and sk_lookup(), so there could be a small rac=
e
> window:
>
>   CPU1                                 CPU2
>   ----                                 ----
>   udp_v4_early_demux()                 udp_lib_get_port()
>   |                                    |- hlist_add_head_rcu()
>   |- sk =3D __udp4_lib_demux_lookup()    |
>   |- DEBUG_NET_WARN_ON_ONCE(sk_is_refcounted(sk));
>                                        `- sock_set_flag(sk, SOCK_RCU_FREE=
)
>
> We had the same bug in TCP and fixed it in commit 871019b22d1b ("net:
> set SOCK_RCU_FREE before inserting socket into hashtable").
>
> Let's apply the same fix for UDP.
>
>

> Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

