Return-Path: <netdev+bounces-118158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA19C950C8E
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 20:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BF2BB20CC1
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 18:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62EF1A3BA1;
	Tue, 13 Aug 2024 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sxTAsF0i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FE442A91
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 18:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575345; cv=none; b=J8Do0C+TrpQhXQdF3NkgzRC2dAlhOh/oNm/iE+2xsE+l0nwuUT0XvdOiKlO5EhlMdKhK/AmOIHQVwDrAN8ZOS87MMuVfy6LZ08pKnNQOZi6EWV45Yr8DOwZ3Lo/r/gq34q9yzMqQrr5e0PNgQF6zp0RTX+74g9GmgcGlbvh7N0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575345; c=relaxed/simple;
	bh=dqsBTSQ9khfrXMfQttSXuKliRUqVETWvlpnk/XR+qh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZaZZxlFkFt0hrjRayTabFIbnLHivgoygHnLtSLzh+6SF3TFxXwhmDxN8oQFFvQAuG+vXa0n4ldL89rdM/hmCi3njNrST1jhAtnk5FXVH4l3qoH3rOR02EX1EcYT8+mavGhgoTogBbj1IdktODnW/EDxhC/2WpUi2A6ALem184o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sxTAsF0i; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5d5eec95a74so3621938eaf.1
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 11:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723575343; x=1724180143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3sd/boSZ5KG955JwYRppb/EgjCFXaoDOcJgequGPbI=;
        b=sxTAsF0iDCimVJjnbY0NP1xEvW4lXECNCs/BEVSLxKRX6TmDNdVGd0FzufsqZFLMCR
         hT3TxD62lX6SsYOhAWb82YBRokYQDSebSiI24DhnJrKekUUBVuTLAfUzXZtMJXBgvgKC
         dqWesJ/0K2RwkhuiPpG/P/HpQ+rfPV7Rb9HquSIMp2k46k/l7ja0Z0xBdFpNcK8LHHBZ
         ge2dhQDApUnbyyWbFJRD6M/Va0u9+4FvkJylv44rMOSAcZ1tfwC5QzrgQN5ZvmW3imnd
         mpmWGDDS2tB/IewYQ06RiODH6+aIbYPlA7qVX1QfLq9au4jwtzdD6rNTo5d4iNB4wijk
         E9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723575343; x=1724180143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3sd/boSZ5KG955JwYRppb/EgjCFXaoDOcJgequGPbI=;
        b=BY/8lBeILmRI1wmYFyeGyg1O+DODISn6hd/9bhel8KKLnkPdl8Suhp2+I2UuHP013e
         VrC/CdJgmjCGzoQc9deaWW82oNCCD0bCGWavu2iahmpXqR7xCsy3IcERASIsH7WLYoEc
         HNk8zOwRqL4XaBsIwFeRsQt906q1oXdcLht+ZF13MhFX44wV9151yeN9et1xvZqpEl9M
         d20NtxAQzSx6inv9DBKjA/XwDzR3CfD+CaphMJu+TLtXcyf7nfSpW/amvqmERAy7USQ7
         N1RYL43BG0JhqcBM/2bk75lza8fTLNaDWe79LaRujrqmWuU1lI0JayYbNdCGSrjOy+nj
         nuTQ==
X-Gm-Message-State: AOJu0YwfJ1EHApgTXMqglt6IvcweAHfqsfF/rNW8s9T6sTFz2GjMdbeQ
	9xHFRWCw21TBbdVMOEtmd858zT74Q0MS4KclCTQVfNV5NxHHOoWBFq/Mimov93VTSMylb52NzQ4
	5RrWnhT5o9uG4ld6ApMxhYLLMDj2705CpzWLe
X-Google-Smtp-Source: AGHT+IFXYU4lIPN1krfB4AkjgIx5tdHebP8YTyFLvQSRtzINcYEjp+5KMNnHgz3y1IZveBQwTPrGc4twsNKudKNIHPs=
X-Received: by 2002:a05:6820:810:b0:5d5:c805:acae with SMTP id
 006d021491bc7-5da7c763224mr664942eaf.5.1723575343049; Tue, 13 Aug 2024
 11:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812145633.52911-1-jdamato@fastly.com> <20240812145633.52911-4-jdamato@fastly.com>
In-Reply-To: <20240812145633.52911-4-jdamato@fastly.com>
From: Shailend Chand <shailend@google.com>
Date: Tue, 13 Aug 2024 11:55:31 -0700
Message-ID: <CANLc=av2PUaXQ5KVPQGppOdD5neHUtUgioqOO4fA=+Qb594Z4w@mail.gmail.com>
Subject: Re: [RFC net-next 3/6] gve: Use napi_affinity_no_change
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 7:57=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Use napi_affinity_no_change instead of gve's internal implementation,
> simplifying and centralizing the logic.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  drivers/net/ethernet/google/gve/gve_main.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 661566db68c8..ad5e85b8c6a5 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -298,18 +298,6 @@ static irqreturn_t gve_intr_dqo(int irq, void *arg)
>         return IRQ_HANDLED;
>  }
>
> -static int gve_is_napi_on_home_cpu(struct gve_priv *priv, u32 irq)
> -{
> -       int cpu_curr =3D smp_processor_id();
> -       const struct cpumask *aff_mask;
> -
> -       aff_mask =3D irq_get_effective_affinity_mask(irq);
> -       if (unlikely(!aff_mask))
> -               return 1;
> -
> -       return cpumask_test_cpu(cpu_curr, aff_mask);
> -}
> -
>  int gve_napi_poll(struct napi_struct *napi, int budget)
>  {
>         struct gve_notify_block *block;
> @@ -383,7 +371,7 @@ int gve_napi_poll_dqo(struct napi_struct *napi, int b=
udget)
>                 /* Reschedule by returning budget only if already on the =
correct
>                  * cpu.
>                  */
> -               if (likely(gve_is_napi_on_home_cpu(priv, block->irq)))
> +               if (likely(napi_affinity_no_change(block->irq)))

Nice to centralize this code! Evolving this to cache the affinity mask
like the other drivers would probably also require a means to update
the cache when the affinity changes.

>                         return budget;
>
>                 /* If not on the cpu with which this queue's irq has affi=
nity
> --
> 2.25.1
>

