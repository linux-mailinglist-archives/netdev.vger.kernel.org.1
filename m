Return-Path: <netdev+bounces-250729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C68CBD3904D
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 19:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31708300C5D7
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 18:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFD7296BB8;
	Sat, 17 Jan 2026 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ij1z2ER"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3368F20DD51
	for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768673831; cv=pass; b=lrN+HQFRtaZM2OzNkTbhUdsG/ASBbdxl3XPGhbLxXJkz7Cu3xnSI3YRCU4BgFafaJ4cqSkXgdHTDmIO+VF3D3ZMfyB2OUz8SFWZOajmg75Og9my1e5m5QTXecEartblQvuamhJ8IJkDCV3AKLmr+2hJgLxB7cMOwxv69gqXRmP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768673831; c=relaxed/simple;
	bh=DkBL8p4LSX9iwgJKKk/p5hjolUh9G0K9MLuUEg04KQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulB4sRdcRoU7TjKyxVg/RaISn1CPMQ3Ak/n4mpDrLSik1XmgS6jsBcMbdbKtXWX5c534K385l2csQ+ip/RZLGnYkGSxR+T/05KKv4+SPAjIaawp6NefOxrfFSIRnhvoi11inVieWwoa4Th8nwV0yHJKJc6ij1Hu997QxsyKZZ5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ij1z2ER; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-501502318b1so26863861cf.3
        for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 10:17:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768673829; cv=none;
        d=google.com; s=arc-20240605;
        b=CWU03QbYcTmNHFSOaSZL5CzbUJg6pJj14GYXWUcAsoi3PZJ9sOmP3y+z/AD4jMXaJF
         FeD1uO6olhkagCrrJkZOUw51ZCss99LOD6K3oZPCSNC64qCNq1jax7wBHiTh3/dbJfa/
         yPvyjOkH0RTWcAb6Z8qUXIU4OpUqGG0aArfCmVfKToRvsuvWf21zCjPtI3zqjSXkD9ot
         FkE99arXF1E/dC/oC1+nmQ62TLmgzLUk04DSL26CSHH+lMNByRmDvsu47IH8CspH10dG
         7/SucX3BJ8LErNk48dTFGn/OxWjBJRWYIgRoOlj/wviMSv19cIAVF5VDy0asnOSWpXhG
         OxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tkpVIgRReVtqw0unqsRQlnSoWBvLqoFy8FwT1IcBpu0=;
        fh=WrimfCXIfk3MCzlX1gfNG70Ec3PpgtdLc2AUej2FQF0=;
        b=j1mpx6e6YILv+keSLuETmvgVjp+8/UG6rWYVidb8dEaoQi+3mZYSKx060+nbFRp56/
         RRuyjJ4Wy7h7Xselv/JFy/aFOyA4mAR1az0plgQS2rK8ShUedPqXfk1kxUn3K41vfQnb
         SP+MQn/5Wcahiiv8729rTguWHU0ivIxYnk33lJiGK7dh504TJ8KlOFWxUWJlN6vqUsli
         H3NDf5wAlPzpqarmyf05zrEJyNQmujj75S6mbf7Hf9TRMymLLjaPw6nwsDMziZR980Wz
         Pe2eJSuIEtDf2qm0JfprmyppKFzHtOpICxqnvk3GFsSjYVIv0K3QtDihT73Xvy/oGdii
         MM8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768673829; x=1769278629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkpVIgRReVtqw0unqsRQlnSoWBvLqoFy8FwT1IcBpu0=;
        b=3ij1z2ERD/ABJTiurVvDxD6vHUWzyHQcpQoFl/T4Ub7nPFtFmp4NqkNYc0icZqBQdd
         T1JsI3zPzcNqn29WR11Ry945e+F3MRxndjnMjfK860sHX2+rW6Uf+bx0MVjTRl2RJhxN
         En8c0t6YcywqaUAqKxrINSpE7x+EyYEQCg73GMiJnvlqLtNIIs5wvH5yUOQ1DLD5Cz9q
         j/Ec4uIMWsmoDBfBLp5sRSiUKpzHYLfRwGPSUA4stgK9N5l8Bpz0ybyRaA4A0UElPwWg
         GqPy+gXT4Zc7oTlWfD7kznevXYGoiTta6DnFNq/qdwwbw250aZ4Hj78w7MvrjXOd2A4N
         khiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768673829; x=1769278629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tkpVIgRReVtqw0unqsRQlnSoWBvLqoFy8FwT1IcBpu0=;
        b=AdGLi4tsO5X0Dy59KSx5mXYfI/0BgAnENAU+UEesfsRwi9zqXBDLoF6GGezn9gAOB7
         dNw6qW+/AF7xm7gXzbvbLr7Fl5w9AcoMdIMMNKU8727uJI30sqGGw588JDeS1zQsdvNF
         DsAVkai0dZFYK89lGUGW1jUTWxfu0R56ia82GU/6aV8DkJv3ugh8R1TQRKHOA4STCI9H
         HlFCmZ9VoQi8PrK9n2KbCuHnQBX7kthXcM18CFchOR38NjW74vxKFxtnGTWQnsG+765m
         SbmkAYNx2NIpTHYrvsyKgn3+e6naiIJXhEEDbrlU8sVB8IIQQQ4dihhhRD1C48bhTI7W
         DEJA==
X-Forwarded-Encrypted: i=1; AJvYcCWCH8rFSps6NIgAwu9oBF6MCHBcuRSTvfq+mfH86JFmnf7Hj6jxNV/XX4hab/B6pwCXiZ8Npng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTuzWNuaO7pt8mUU1+aTwnNkeP4CT2vp3BRtf1BuSJ1koc0gSC
	3ckzLWTewubHDs1PabmKHUrWU5MsU/2atI50KUuxLY4sviG5mChwO+jVFUFThe8NPmk3DRNgF/d
	eAl6QSiK4sCEMnmPDe3/bkiKJYu8TUyypuhX4cF7A
X-Gm-Gg: AY/fxX7SVttb14aegQp/JEysxxa9sAkYW35s1eIPYBkPUuSu5tN2rUY1Fuk6Fx3xrVT
	ks4zw3M0fOBPvzbKvIFFuygXHaCKOE4ncj4yGpcm+Z6C/4wHqiepQa8DFUrKlenDTcDqU/nI+dK
	6hoQUIXLdx3Ilsm06hHR1yMdLrrcnuNO77HtOyjPP4ed+i8jP1EXXZb3nUc/mnGBkmNdPUsd7IR
	iSdAFNKf797sx/my/msPbRCl4xyjlFKrebI/DxvjRPWtNEFDAIelK5t3E+N+LbGJF/XIOGr
X-Received: by 2002:a05:622a:164d:b0:4ee:1e63:a4e0 with SMTP id
 d75a77b69052e-502a175ab08mr101954021cf.74.1768673828683; Sat, 17 Jan 2026
 10:17:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260117164255.785751-1-kuba@kernel.org>
In-Reply-To: <20260117164255.785751-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 17 Jan 2026 19:16:57 +0100
X-Gm-Features: AZwV_QhXwRd2jVL1OjXkPaWK3G_nuSDi1O3lbFLnO7vzktXWvkRcuBAYH3tSQp4
Message-ID: <CANn89iKmuoXJtw4WZ0MRZE3WE-a-VtfTiWamSzXX0dx8pUcRqg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: try to defer / return acked skbs to
 originating CPU
To: Jakub Kicinski <kuba@kernel.org>
Cc: kuniyu@google.com, ncardwell@google.com, netdev@vger.kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 17, 2026 at 5:43=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Running a memcache-like workload under production(ish) load
> on a 300 thread AMD machine we see ~3% of CPU time spent
> in kmem_cache_free() via tcp_ack(), freeing skbs from rtx queue.
> This workloads pins workers away from softirq CPU so
> the Tx skbs are pretty much always allocated on a different
> CPU than where the ACKs arrive. Try to use the defer skb free
> queue to return the skbs back to where they came from.
> This results in a ~4% performance improvement for the workload.
>

This probably makes sense when RFS is not used.
Here, RFS gives us ~40% performance improvement for typical RPC workloads,
so I never took a look at this side :)

Have you tested what happens for bulk sends ?
sendmsg() allocates skbs and push them to transmit queue,
but ACK can decide to split TSO packets, and the new allocation is done
on the softirq CPU (assuming RFS is not used)

Perhaps tso_fragment()/tcp_fragment() could copy the source
skb->alloc_cpu to (new)buff->alloc_cpu.

Also, if workers are away from softirq, they will only process the
defer queue in large patches, after receiving an trigger_rx_softirq()
IPI.
Any idea of skb_defer_free_flush() latency when dealing with batches
of ~64 big TSO packets ?



> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/net/tcp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index ef0fee58fde8..e290651da508 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -332,7 +332,7 @@ static inline void tcp_wmem_free_skb(struct sock *sk,=
 struct sk_buff *skb)
>                 sk_mem_uncharge(sk, skb->truesize);
>         else
>                 sk_mem_uncharge(sk, SKB_TRUESIZE(skb_end_offset(skb)));
> -       __kfree_skb(skb);
> +       skb_attempt_defer_free(skb);
>  }
>
>  void sk_forced_mem_schedule(struct sock *sk, int size);
> --
> 2.52.0
>

