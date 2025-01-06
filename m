Return-Path: <netdev+bounces-155373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8CCA0209D
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 09:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2BF3A3120
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 08:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398B21D86CE;
	Mon,  6 Jan 2025 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x1ElYxSL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490701D7E4A
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736151891; cv=none; b=hFQOcyXh7gaK4RFxbY/c4k6wCMikJwo2yeQj1pposqDp+nbTXC4hMVCVCx/A1tkJIQFsodsxFYg4eoc4Gbo1zO1E3/E31OnEcDiEN2syrZnqnAuniawRCJ69bQuUgQt5+JDWI9ENoBEHo9aD+Q+949c7b1lsQ4vC8WSAocFycRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736151891; c=relaxed/simple;
	bh=mRpwazyZRVZTVcDMGYQXmqPZtajO2mdhtuOpxotH7+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdmUXudi+xM+7pN9r61LPv1afAykQq+nCd6qbP7PSuPW+QReNdXeCEs/7jKsR19UcIMSIEvgUrMfkvIZQM8RKBXkRVOuTv6LWeGkUaZhJjHkdWUNTZD1HeNrPHQ+27vuD/JuZWM8K39xlWt3iGz3/bV91/7ojra4jA7N9v8X1hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x1ElYxSL; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d932eac638so2795167a12.1
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 00:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736151888; x=1736756688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbZO3lFNTHHbW9lxaEAxssjwvIxzJN7H42aUiYjZ5HY=;
        b=x1ElYxSLENaBjX+/TficKfGfSNkNdo+z6o4IJFbPCXAuoMwXgKy1f9w7WJX+14KV3b
         GQzwmV3jJckeh3kKRr4SGLfwwfSkLP7TorZilOgG6mM2IQ7A9PRU2r9rh5WA/T2HO7kV
         Tvtn6Wv6Vq/jIU1Ra1uYDuk2R8n540ws834lUGl/GYKhNARdzAyn3obY7x2Ia7okghlb
         MeKbVZ6XhjUAgTGbYvNq21AEEgtSHPAiiuceAUtYRmaz4VwQaJW8ZTROWm14jD21Ms33
         oU+Ks7/trQBaJfwzUj/gloZxY83pbxhAq/K/oBo0mnkJpRnUz9IJFQFQThZcXPbmMDai
         NGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736151888; x=1736756688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbZO3lFNTHHbW9lxaEAxssjwvIxzJN7H42aUiYjZ5HY=;
        b=rex8vhSO6A3l0zNmMBeOAK5X1ptqpgEaAxnOEyaD+D4x7HXSxmbrpkNtKPOCaA19An
         S2xmWpro4NiPEITVKBwPg0prZ8MdGqEHN8WPBvdqBjcNPpFT+kNuqOQ4jiqlTn0buZ8y
         cW0g9tZOxHVeV4BdQYpK1+yAGeVz9GfpGLSHANGaEuw9EQVKJOe3BU6md+sQHlXA/2qN
         nMsnxBS2yKHRHdbyef4KDR83ttpwS8GgWpvv51+19JAfvbqUXoHvCMqx7FEVy+PcVPZf
         PDSlbzZwAoI4CsYtD3lCUwU6AvzpnCK9hwNuKpOVBIwM9AIS3CAhVPK73ulgfxkqdXiy
         Uoig==
X-Gm-Message-State: AOJu0Yxw+BfFYmKtsMaYxJq0wyGnGhK1QiFzbwk/5/Wu3KWRvLiheuH6
	gA3kJp7v6MXflsM/w5h7ZbGZx6Sdm4ABa1Kn4r13gN2NLNARX+P1xXv0qTMaWTE9XbQXZIa0sFF
	Z8LvOs5jAP1nhCJRSDktUIfmx5tUwWsDC6cPB
X-Gm-Gg: ASbGnctret338Rg4Z3IjhHizWp8JcQ/ikKqX5SUSgzfQzIPZoy3IjA+ZlLDA8AU60xt
	WMkERkAh6xOY6dbaGw0tBFa+ea+DfjotCcATeXQ==
X-Google-Smtp-Source: AGHT+IHRr8ENF6kbeeiTVz3dRzmoIBN6AAU3f55oKyvRR/EdXxRZiVW/D3iIuLQnpCU/KY8HBxvVGXXOoR9BVTFo/Vc=
X-Received: by 2002:a05:6402:524b:b0:5d0:bf27:ef8a with SMTP id
 4fb4d7f45d1cf-5d81de48bd1mr49018605a12.26.1736151887382; Mon, 06 Jan 2025
 00:24:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <408334417.4436448.1736139157134.ref@mail.yahoo.com> <408334417.4436448.1736139157134@mail.yahoo.com>
In-Reply-To: <408334417.4436448.1736139157134@mail.yahoo.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 6 Jan 2025 09:24:35 +0100
Message-ID: <CANn89iLzo0Wk7p=dtUQ4Q2-pCAsjSxXZw71ngNTw6NZbEEvoDA@mail.gmail.com>
Subject: Re: [PATCH net] tcp_cubic: Fix for bug in HyStart implementation in
 the Linux kernel
To: Mahdi Arghavani <ma.arghavani@yahoo.com>, Neal Cardwell <ncardwell@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Haibo Zhang <haibo.zhang@otago.ac.nz>, 
	David Eyers <david.eyers@otago.ac.nz>, Abbas Arghavani <abbas.arghavani@mdu.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 5:53=E2=80=AFAM Mahdi Arghavani <ma.arghavani@yahoo.=
com> wrote:
>
> Hi,
>
> While refining the source code for our project (SUSS), I discovered a bug=
 in the implementation of HyStart in the Linux kernel, starting from versio=
n v5.15.6. The issue, caused by incorrect marking of round starts, results =
in inaccurate measurement of the length of each ACK train. Since HyStart re=
lies on the length of ACK trains as one of two key criteria to stop exponen=
tial cwnd growth during Slow-Start, this inaccuracy renders the criterion i=
neffective, potentially degrading TCP performance.
>

Hi Mahdi

netdev@ mailing list does not accept HTML messages.

Am I right to say you are referring to

commit 8165a96f6b7122f25bf809aecf06f17b0ec37b58
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Nov 23 12:25:35 2021 -0800

    tcp_cubic: fix spurious Hystart ACK train detections for
not-cwnd-limited flows

    [ Upstream commit 4e1fddc98d2585ddd4792b5e44433dcee7ece001 ]



> Issue Description: The problem arises because the hystart_reset function =
is not called upon receiving the first ACK (when cwnd=3Diw=3D10, see the at=
tached figure). Instead, its invocation is delayed until the condition cwnd=
 >=3D hystart_low_window is satisfied. In each round, this delay causes:
>
> 1) A postponed marking of the start of a new round.
>
> 2) An incorrect update of ca->end_seq, leading to incorrect marking of th=
e subsequent round.
>
> As a result, the ACK train length is underestimated, which adversely affe=
cts HyStart=E2=80=99s first criterion for stopping cwnd exponential growth.
>
> Proposed Solution: Below is a tested patch that addresses the issue by en=
suring hystart_reset is triggered appropriately:
>



Please provide a packetdrill test, this will be the most efficient way
to demonstrate the issue.

In general, ACK trains detection is not useful in modern networks,
because of TSO and GRO.

Reference : https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3Dede656e8465839530c3287c7f54adf75dc2b9563

Note that we are still waiting for an HyStart++ implementation for linux,
you may be interested in working on it.

Thank you.

>
>
> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
>
> index 5dbed91c6178..78d9cf493ace 100644
>
> --- a/net/ipv4/tcp_cubic.c
>
> +++ b/net/ipv4/tcp_cubic.c
>
> @@ -392,6 +392,9 @@ static void hystart_update(struct sock *sk, u32 delay=
)
>
>         if (after(tp->snd_una, ca->end_seq))
>
>                 bictcp_hystart_reset(sk);
>
>
>
> +       if (tcp_snd_cwnd(tp) < hystart_low_window)
>
> +               return;
>
> +
>
>         if (hystart_detect & HYSTART_ACK_TRAIN) {
>
>                 u32 now =3D bictcp_clock_us(sk);
>
>
>
> @@ -468,8 +471,7 @@ __bpf_kfunc static void cubictcp_acked(struct sock *s=
k, const struct ack_sample
>
>                 ca->delay_min =3D delay;
>
>
>
>         /* hystart triggers when cwnd is larger than some threshold */
>
> -       if (!ca->found && tcp_in_slow_start(tp) && hystart &&
>
> -           tcp_snd_cwnd(tp) >=3D hystart_low_window)
>
> +       if (!ca->found && tcp_in_slow_start(tp) && hystart)
>
>                 hystart_update(sk, delay);
>
>  }
>
> Best wishes,
> Mahdi Arghavani

