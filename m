Return-Path: <netdev+bounces-236210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7579DC39C3A
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 10:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C633F18C4360
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 09:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7BF30B51B;
	Thu,  6 Nov 2025 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SALyi/uf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90E2299A87
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762420418; cv=none; b=dKP4hanYyjJJG/BHX844wuHRYo/m20BsasJydD2m7/dDTTAAqGaGleEf+EKXWFnsBA/iS1UTQdl3064Eq4cKI0hyP8vjVKfyndPLpNF6uoT5n2U+fJ2nUAY+CCHEOd9w7lqaI3rxRZafhrpn51Xuy67ERoz1ZZBR92sQZmVXl/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762420418; c=relaxed/simple;
	bh=05CyHfqnjYJqZR61RwW1qveeRW4SrJeLPOk3mLp6P4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ER3ENmRsH9oXTJSzRS8Iv+dxoW9Sjwp+HKzSp7i5DyWsJhkpIqV2vIbzLdwTFirZ3bi47aXY9cZ+JY1/b3KlB+f5NwfyKgBzrzAXAu4DS12BQScNrYRtfm3SpqaIPJGhxZy/zTJ/JAf0Fba5OtwoA7mvOQD3G5HEfIrAeicKfSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SALyi/uf; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ecef02647eso6458211cf.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 01:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762420415; x=1763025215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XvYDS0s8HRf3GHhJbINZn6eNtiASUVgrE6x8RuZyYI=;
        b=SALyi/ufQrSFDDTa0c8MbxVUkiRQPb5465RQOaD+VywT7o7Bo6hwynUpiKM5AZAsF4
         p+eNBZsxIqWKgwhPuCl7I6/qcotTx9buPxmX801iTHnc0aMngSZ6uFsJFPXALqeUNsZk
         T/Czm/YyfTwCIffM7x9nnb3alNUxqKfp7jtmFA4pjAbNYd7q0QEQztBxc92xdSlKFj3r
         sZYOttp4xvcR1PR9YCETNVR9DMZ7sOwGq3to6+PgY9OJW9RyCw9f5wcCUIFEjhacXAAn
         RJMhhIPCopujzELUewzrS0uaAJKi20TUFS1pbsoBb6VpelCdDE78bXMfJrqkHVrmAvPU
         cCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762420415; x=1763025215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XvYDS0s8HRf3GHhJbINZn6eNtiASUVgrE6x8RuZyYI=;
        b=d+8Wbzd0guLHYplNqqCm5HgHW9xvEu7gTo9n47wGI8T176r7eXp2/sGHhVj7c2tUd/
         3aWcr1uVdH6BjcNt42T5MmJQj6EGh/xzz16Ysd/JUjkwNwISNWPBAE6Zy8EYhfP+loS+
         sxqrvQwFZpi0ciZjMBOW/8ZnCtTvlYjT/sJMWiimIxBeqtZLl/HqobTI05hhXQYDk7Ql
         VucfRigRpZ65FaqKzp5D3o88Hxjs9k86kN9aTavftd6outloQ5N450vKg9/1d6Kw/gmT
         ogj5W8+n38JUIJRX7gMFPGFAyAIyazwa7ADH8QjgCsXUsafm2hCyscCDQn0yzrrjkX8v
         3Psg==
X-Forwarded-Encrypted: i=1; AJvYcCW8eJUm3hd2s+CbhP70V3T9dV4YCBPxmQZcAwxiKdWRybSdyEYY8L6yZx2AWeqwunTSWQggkIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuWO0n02BgmP83bHlzYnhi/IR9VV6/qgU0OW8lNiE+v3aJDBt8
	FqpZ+R1uKQa0rr2f9bEM0xmcMp6/EnqH1h4lJyCdcFaFNvVepvwXts4+oUWy6ss+5K6hDGJ3Cuz
	KqyZ7JM5h9I1o9Fe6deuXJ3XFzKSPV57wzbYu4B6dLghOzhzrCCfuQLXcBwE=
X-Gm-Gg: ASbGncsBKzdaLLAhll8LgdCbrwy7sGmMiWqtfByPeUXXMW/JxyB95UBK9boas3QMJFl
	QhkgNpRoWbu4zh8NTWsW8xXlfxJO+1eGs15YCfgWpshxJgbI9zUI3KaLvPvxIFXy1i+YLMfvfPo
	9a1whtTmRajhUcjyfg++lugBw8eqqxf/D2nIL4JnrT42tRTth2QZufoTxBsd0NxSy1T6XVMA2Jl
	4UfPsTMcp9f97ejy4LNYnrLj5lCB/DPzuHKRqegRNUFifQUWbbpNDUTFn6B8+I0EQnLf5s=
X-Google-Smtp-Source: AGHT+IH4EfLcyrlo7T0A4gOsFD5tVeGAXB8FCRDxwEvwlmxZrSXHnwnEwHslHIgJhxCM/0witZLIxwzaZc2bISi+fPQ=
X-Received: by 2002:a05:622a:1b91:b0:4ec:f452:4eb9 with SMTP id
 d75a77b69052e-4ed72354991mr62528421cf.9.1762420415137; Thu, 06 Nov 2025
 01:13:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106085500.2438951-1-edumazet@google.com> <8ef591e6-9b05-4c7b-8d75-82ced4dd2f31@redhat.com>
In-Reply-To: <8ef591e6-9b05-4c7b-8d75-82ced4dd2f31@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Nov 2025 01:13:24 -0800
X-Gm-Features: AWmQ_bleoWdDDU-4SmBNAtwwbQSLSSImALNCycXuxOrxMmm-w8gA7GRSr8p6Ah0
Message-ID: <CANn89iJwTydUJG4docxfc0soY98BU7=g-nh+ZAvRi6qD5Bt_Ow@mail.gmail.com>
Subject: Re: [PATCH net-next] net: add prefetch() in skb_defer_free_flush()
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 1:05=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 11/6/25 9:55 AM, Eric Dumazet wrote:
> > skb_defer_free_flush() is becoming more important these days.
> >
> > Add a prefetch operation to reduce latency a bit on some
> > platforms like AMD EPYC 7B12.
> >
> > On more recent cpus, a stall happens when reading skb_shinfo().
> > Avoiding it will require a more elaborate strategy.
>
> For my education, how do you catch such stalls? looking for specific
> perf events? Or just based on cycles spent in a given function/chunk of
> code?

In this case, I was focusing on a NIC driver handling both RX and TX
from a single cpu.

I am using "perf record -g -C one_of_the_hot_cpu sleep 5; perf report
--no-children"

I am working on an issue with napi_complete_skb() which has no NUMA awarene=
ss.

With the following WIP series, I can push 115 Mpps UDP packets
(instead of 80Mpps) on IDPF.
I need more tests before pushing it for review, but the prefetch()
from skb_defer_free_flush()
is a no-brainer.


git diff d24e4780d5783b8eecd33aab03bd4efd24703c65..
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5b4bc8b1c7d5674c19b64f8b15685d74632048fe..7ac5f8aa1235a55db02b40b5a0f=
51bb3fa53fa03
100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1149,11 +1149,10 @@ void skb_release_head_state(struct sk_buff *skb)
                                skb);

 #endif
+               skb->destructor =3D NULL;
        }
-#if IS_ENABLED(CONFIG_NF_CONNTRACK)
-       nf_conntrack_put(skb_nfct(skb));
-#endif
-       skb_ext_put(skb);
+       nf_reset_ct(skb);
+       skb_ext_reset(skb);
 }

 /* Free everything but the sk_buff shell. */
@@ -1477,6 +1476,11 @@ void napi_consume_skb(struct sk_buff *skb, int budge=
t)

        DEBUG_NET_WARN_ON_ONCE(!in_softirq());

+       if (skb->alloc_cpu !=3D smp_processor_id() && !skb_shared(skb)) {
+               skb_release_head_state(skb);
+               return skb_attempt_defer_free(skb);
+       }
+
        if (!skb_unref(skb))
                return;



commit df7dacc619117ebab7ea330ccc6390618f04dff3
Author: Eric Dumazet <edumazet@google.com>
Date:   Wed Nov 5 17:02:20 2025 +0000

    net: fix napi_consume_skb() with alien skbs

    There is a lack of NUMA awareness and more generally lack
    of slab caches affinity on TX completion path.

    Modern drivers are using napi_consume_skb(), hoping to cache sk_buff
    in per-cpu caches so that they can be recycled in RX path.

    Only allow this if the skb was allocated on the same cpu,
    otherwise use skb_attempt_defer_free() so that the skb
    is freed on the original cpu.

    This removes contention on SLUB spinlocks and data structures.

    After this patch, I get 40% improvement for an UDP tx workload
    on an AMD EPYC 9B45 (IDPF 200Gbit NIC with 32 TX queues).

    80 Mpps -> 115 Mpps.

    Signed-off-by: Eric Dumazet <edumazet@google.com>

commit 42593ad5f2bed6abd3a6cce3483e2980b114cbd9
Author: Eric Dumazet <edumazet@google.com>
Date:   Wed Nov 5 16:50:29 2025 +0000

    net: allow skb_release_head_state() to be called multiple times

    Currently, only skb dst is cleared (thanks to skb_dst_drop())

    Make sure skb->destructor, conntrack and extensions are cleared.

    Signed-off-by: Eric Dumazet <edumazet@google.com>

