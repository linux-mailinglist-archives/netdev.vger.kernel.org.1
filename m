Return-Path: <netdev+bounces-250209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD200D2503A
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8ADF230504E0
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C0530E824;
	Thu, 15 Jan 2026 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofCPYWcR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE11D2ECD39
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768488033; cv=none; b=OC/caDQjmxAfGx1h7HbzMktOFxZZQXt6bIgSiv3DZzNoE8npjLCw5IWTzQ1ziqFCaj9FALNr1hFbCPd5PrN2rqeoI+T3nCuuPglnBJNr9ikH3c2NUudT/M7AeMS0JIbqvPCiLLlI6iUzB/HSGqfUg4WiRFhU4QwMlGQolRcgphU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768488033; c=relaxed/simple;
	bh=bg9+1InGoek0RAw+SSIDDOo/nDZj5525j5AiNZYVQUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CW+ZzPyo6A1Dv1kaiNXMpEaYmwJFHKjnqTrsR7ot8RX3SbuP4wBEyE6wFU69obAXRsPB1MMq/9LZBrcSyFo4rhDWErZTnzVrV9t3R3rs8THTIPnVz7hfRHFxCFRJ+OSeTFx6YRQYU2UYhxQiaMfb9rGp+MWxrPE9HWe4x/KPSx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ofCPYWcR; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5029901389dso4905261cf.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 06:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768488029; x=1769092829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W67l+qWJf4i/uzrZs13/VAgBMKdkcy4ybsbPGITcYBU=;
        b=ofCPYWcRo5ssWSkAN1VuxEhrTas1KLKgT2q7czjR63cfEhs14jeEs0PW2ZEIjNKXCn
         MgoKRi/OWlUIRdMWrRTa1FWJZloISH+KHiIR3OKbFgoVPumuNXGUOQldvWrrdRKYDA9e
         KDatQ1joPAJRvD7ZPhT8OAf2kNNdRUJCPmiGvYFm/XmvUkG3IxeGXdmokOjumEgVnJ9T
         B0wGqd6vWB+bAmlQ4YBjwthQkFh2uWaRpH+NK8SzykVrmm2dxA0dar76swUNU4ugGYnA
         eip8XC6psd4CS8Ast30eYGdFKkMoH/yurHZPOjKov+VmvhWtbY6yzLTjxIElW6a/Bjh/
         I2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768488029; x=1769092829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W67l+qWJf4i/uzrZs13/VAgBMKdkcy4ybsbPGITcYBU=;
        b=d01gj9I6s0dOwOmmP4CPPmFIkAhgcyja8ugd1BIP2BenNXA1Z/4LaiS6jpBIb9Q6T3
         NPa8MmDenKm7eSGQ5XuVSkSC5pQdjoxnU6e258XBM82k9WrAdd+vzfh2OkR1JP0+Dt31
         QXaoiEPKvRDSJffxZ5jcHwfPHepHhQ/fhZ/YXHXxYAq4TSgJtovEGg7H457RATGNkgpg
         v4sThXtZ3JIp93kNEJJ66Izs4ks/svDh1usECFuZax3TVmJMjvK7ifyyWC7XzMAQ3dLC
         O2fwpNmPW0TwsJQTnn6fONjz3HaoCW5fOcASE+80dyItjQ+VMv+Hg7gDe+c3haG5e77V
         COhA==
X-Forwarded-Encrypted: i=1; AJvYcCVwK42qW6/peXn3uSFcMuDBAwKy0BVo2lFSz9zfI+H1zpHYeQOjIFWGWdiV2PYZu1NeHbSf1OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcsTubh+mbWvomoczGmfIvU/EqYq9ccfggOcKm+u8u7kQKrhFt
	FLDHG5JN6g8tb0Ivd/OCPk36NEtdND4iaCJsnWEsOQNxykUv5LvUJCKua224ufhxRkBQ4qdDC3i
	L+Whfkje4BihK7yOm2S9LtW9YjK9JyAM/qL/G+NXB
X-Gm-Gg: AY/fxX7Ut/zKJmvdTgt+W8iF/O1YP3HR/4ycsWK3b7Ts/ANm0Rhr5nspQpdb3MtfR6u
	mCLu/Qx1bVcPOsqmaWRQJIw3Smi+UBLu49HaAeDZVsDfs8pOgMiDmYdwAWOLZFBE9w3oLFof+WW
	Bje6HSNTN+X+w0CFSRHg4CvjUFU+xjh0k6ugz6dikCMswtHijD4uINdYAsy1hzZYNmd8oNmO54w
	WMU/FQtseHEdKOX8efKiMs1vojYmMB5dCDp/blN3BjohK8o1E4VCBmwTxKmja/pKHYAgqGZNAqj
	/d4Tlw==
X-Received: by 2002:ac8:74c9:0:b0:501:50c4:a9fb with SMTP id
 d75a77b69052e-50150c4ac4bmr47283611cf.80.1768488028278; Thu, 15 Jan 2026
 06:40:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115033237.1545400-1-kuba@kernel.org> <20260115051221.68054-1-fushuai.wang@linux.dev>
 <CANn89iKfuXjqKsn+xB6bpGOaqM7pN4ZcRJ=2KJg4WY76ArYXhQ@mail.gmail.com> <CAHmME9quqMVzD5zSEKvOFOYj3QLANAo2iYeqWQ1toV0C7gJXTg@mail.gmail.com>
In-Reply-To: <CAHmME9quqMVzD5zSEKvOFOYj3QLANAo2iYeqWQ1toV0C7gJXTg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 15 Jan 2026 15:40:17 +0100
X-Gm-Features: AZwV_QhUjToNAgS38h20mRwxrxdb2GylWDqbb5JI3WCn-MPbxbSmB7DRusOwq7M
Message-ID: <CANn89iKmNSPjsTBwN3166cKyipJbH64ZPE0O6i2AMh7vyKXS=w@mail.gmail.com>
Subject: Re: [PATCH net-next v3] wireguard: allowedips: Use kfree_rcu()
 instead of call_rcu()
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Fushuai Wang <fushuai.wang@linux.dev>, kuba@kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, vadim.fedorenko@linux.dev, wangfushuai@baidu.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 3:33=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com=
> wrote:
>
> Hi Eric,
>
> On Thu, Jan 15, 2026 at 10:15=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> > > > The existing cleanup path is:
> > > >   wg_allowedips_slab_uninit() -> rcu_barrier() -> kmem_cache_destro=
y()
> > > >
> > > > With kfree_rcu(), this sequence could destroy the slab cache while
> > > > kfree_rcu_work() still has pending frees queued. The proper barrier=
 for
> > > > kfree_rcu() is kvfree_rcu_barrier() which also calls flush_rcu_work=
()
> > > > on all pending batches.
> > >
> > > We do not need to add an explict kvfree_rcu_barrier(), becasue the co=
mmit
> > > 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_de=
stroy()")
> > > already does it.
> >
> > It was doing it, but got replaced recently with a plain rcu_barrier()
> >
> > commit 0f35040de59371ad542b915d7b91176c9910dadc
> > Author: Harry Yoo <harry.yoo@oracle.com>
> > Date:   Mon Dec 8 00:41:47 2025 +0900
> >
> >     mm/slab: introduce kvfree_rcu_barrier_on_cache() for cache destruct=
ion
> >
> > We would like explicit +2 from mm _and_ rcu experts on this wireguard p=
atch.
>
> I'll take this through the wireguard tree.
>
> But just a question on your comment, "It was doing it, but got
> replaced recently with a plain rcu_barrier()". Are you suggesting I
> need a kvfree_rcu_barrier() instead? The latest net-next has a
> kvfree_rcu_barrier_on_cache() called from kmem_cache_destroy()
> still... But are you suggesting I add this anyway?
>
> diff --git a/drivers/net/wireguard/allowedips.c
> b/drivers/net/wireguard/allowedips.c
> index 5ece9acad64d..aee39a0303b0 100644
> --- a/drivers/net/wireguard/allowedips.c
> +++ b/drivers/net/wireguard/allowedips.c
> @@ -417,7 +417,7 @@ int __init wg_allowedips_slab_init(void)
>
>  void wg_allowedips_slab_uninit(void)
>  {
> - rcu_barrier();
> + kvfree_rcu_barrier();

It seems kmem_cache_destroy() should take care of needed barriers,
at least this is what is claimed. An rcu_barrier() or kvfree_rcu_barrier()
should not be needed in wg_allowedips_slab_uninit() ?

Probably boring/distracting, I do not expect anyone needing to unload
this module in a loop and expect this to be ultra fast ?

>   kmem_cache_destroy(node_cache);
>  }
>
> Let me know.
>
> Thanks,
> Jason

