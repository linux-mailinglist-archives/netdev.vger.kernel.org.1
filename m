Return-Path: <netdev+bounces-233436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B4AC133A3
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 08:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116FF1AA1E4F
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 07:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E181246327;
	Tue, 28 Oct 2025 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pA/iDKW5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED78E1F4CBE
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 07:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761635013; cv=none; b=p62O3AIptBzbpDg1xvvlZoBo58YMrZBBiZMReO3xwKUdNWOWkkQeSjaGZFso6VcCTb6AATH6YyN9SqlLAq4KQQ/8X2P0APrWuFqIopBkKEzubeyJv5sFpxZRtsFb1Utv539hz7xPOpdEYc5wu8l+Z5Udfa6DTLDC6iSmgeSYXX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761635013; c=relaxed/simple;
	bh=f/sKuslpmf3fk1XYBbHWDMbHl3Vl3oMGTbfRnbNTy9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHs//MJ6TIBx/S1TrBRGOrvnW1agc8ZVmt26dgEx7Em7ZFmubo9iZi85OO4ycjTKM7oziK2Ik/zEraVA0OQOSdKcwLAFeZM5/JS4Qz4tGqdtzX18RO5yef2u3vSO6HVNBEPN+UjAL+f58bAJWKQa7zu8DkHYLuNVT471kg3oaOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pA/iDKW5; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ecf2244f58so18701791cf.3
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 00:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761635011; x=1762239811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvmp1lHtbh3bnz0nes4BO1/VXqITzfXXxzeBTSW6DFU=;
        b=pA/iDKW5urku1gafC62BeGtqbPICaspZO2FOlH+Mtvqqftm/JKoDjovacPEGXsywGa
         f2YWL8eewpYUVUfzVUNmf9Qfm95vc/j3ousija4U+r7O44Np85maUiozuUaClBBzwqxM
         CePPvifM+B6wCbane4WV/ArBGkbM3olOnsSFSWklc32UUawBQQgauCWoYzTq511Qckl8
         +Pk5BTybNGPoyiIN7jtDbcbQgTrqrbWwgVu0o/q5EXL0OKK5OMd6aMglr4RRGPnm6Q7O
         7hLZ0SG7PnslceqQw87kQIYVwLp62Ilauph/khpy9ubZvbEALRQ/K/hYT+BMWdaRFXLR
         d2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761635011; x=1762239811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvmp1lHtbh3bnz0nes4BO1/VXqITzfXXxzeBTSW6DFU=;
        b=eIicCtpsygMmf+8t3F9Kyjfal8eZSYzBKkDkxYtXOQPx1sKJavLUxtrsEDpy3gkEq8
         +/EgqD2EkWtOPTvorRDf9wuOD6EZcQQoG+KODavRKXjYr09z3NX6Ms4lruZnBa2A04F9
         hsjq9hmy2l0u/iSolbO5dLvWWTMy+bY/Kks5ECVjmLnY2fGqj+JnYpYMLLR9hHUilDZA
         xlkoFFkXZD7MindFtnT6SdDtkCxEAdxBv7rHOZD9EaM5BwcZG7KsTPY1oDaAfar32MDP
         QCSp9wNhuEbIEp3aHCPESTBMak39lB+HPng1wUqfrTuZcu2snZ0JY0ffM+HclTuvSIRE
         Mblg==
X-Gm-Message-State: AOJu0YwOorhpwZof/eJawbXX8bGK7VsyUGs3/ic8tNALnGgrHQ+Up5bj
	7enm0rVMfFIfPyuimTftVLJU6/go+JntpfnqkhbcRInjot3PTJG6Rw4uh1OOBlxUGZydPBuZP/o
	TgioT2v4XPR/23bHI3AG6JXZ62WG3bwQzAPEMabCc
X-Gm-Gg: ASbGncuwDFfflrwbvu8/COwMKt01Nu6RCf1J+LUnTRL/K0JOMTeVr5ZpbxkG+T4mrEJ
	L/ZtKwIcyikuLmzD83WI1TEfRGJKYNlt7pt40RaCUZ//WGWZoCoV98hl7VjGULQZtiq6MYsaYrC
	ImTiGt/i5OckSd2F/pk7OsseX+dXRi/MdrfA+TRpUh3mGN27mSFx9wtA4tZQrxMK6ibXGMm+f7Y
	dCysic8KD8Rib+bJmdmwDsv4jMqYqH7Mx40/dIsr2qLjmvFOombtX4iWaek
X-Google-Smtp-Source: AGHT+IFMUQgOQqhTMTlUlY4gfFhn1M1OApov16YaB19N5a2ow7vK8V1gO1RrV0bEvq5b+25wbKo6s5vNqxDxo0icjqE=
X-Received: by 2002:a05:622a:830f:b0:4d3:3ecd:efd0 with SMTP id
 d75a77b69052e-4ed08b52267mr22114951cf.6.1761635010468; Tue, 28 Oct 2025
 00:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028060714.2970818-1-shivajikant@google.com>
In-Reply-To: <20251028060714.2970818-1-shivajikant@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Oct 2025 00:03:19 -0700
X-Gm-Features: AWmQ_bkKOQgIvDKsyO6H01q0moV62dzXpNbKrAkEuEZA-Krvy9D3Kp26XcmtURE
Message-ID: <CANn89iL5nN6ZX+gJpEBXRiSdadaHvSPPDQ3QnUArBi1fnB0ddg@mail.gmail.com>
Subject: Re: [PATCH] net: devmem: Remove dst (ENODEV) check in net_devmem_get_binding
To: Shivaji Kant <shivajikant@google.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Pavel Begunkov <asml.silence@gmail.com>, Pranjal Shrivastava <praan@google.com>, 
	Vedant Mathur <vedantmathur@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 11:07=E2=80=AFPM Shivaji Kant <shivajikant@google.c=
om> wrote:
>
> The Devmem TX binding lookup function, performs a strict
> check against the socket's destination cache (`dst`) to
> ensure the bound `dmabuf_id` corresponds to the correct
> network device (`dst->dev->ifindex =3D=3D binding->dev->ifindex`).
>
> However, this check incorrectly fails and returns `-ENODEV`
> if the socket's route cache entry (`dst`) is merely missing
> or expired (`dst =3D=3D NULL`). This scenario is observed during
> network events, such as when flow steering rules are deleted,
> leading to a temporary route cache invalidation.
>
> The parent caller, `tcp_sendmsg_locked()`, is already
> responsible for acquiring or validating the route (`dst_entry`).
> If `dst` is `NULL`, `tcp_sendmsg_locked()` will correctly
> derive the route before transmission.
>
> This patch removes the `dst` validation from
> `net_devmem_get_binding()`. The function now only validates
> the existence of the binding and its TX vector, relying on the
> calling context for device/route correctness. This allows
> temporary route cache misses to be handled gracefully by the
> TCP/IP stack without ENODEV error on the Devmem TX path.
>
> Reported-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Vedant Mathur <vedantmathur@google.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Signed-off-by: Shivaji Kant <shivajikant@google.com>
> ---
>  net/core/devmem.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>

Patch looks good, but the title should be improved a bit.

"Remove dst (ENODEV) check in net_devmem_get_binding"

It is not about removing the check, more about refreshing the dst if necess=
ary ?

Please wait ~24 hours before sending an updated version, to  give time
for other reviewers to chime in.

Thanks !

