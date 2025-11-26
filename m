Return-Path: <netdev+bounces-241772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 50376C880AE
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 05:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A6B17353C2A
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50F53112D3;
	Wed, 26 Nov 2025 04:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wq8STw7I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA811D6187
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 04:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764130870; cv=none; b=R+NDFYVbEEFK7oLMy2r+UocEJxCNG0Av+bcGaVyMqs0mcSBpRjxkdKYy/qqqinKm+hJmZbGWxcLLjMUH/GB1qhilI/35TIDgz+NpDW1JWl/hhOiq/dKpvBLmlTlddIgHLp41dNX1vre2LbO1QUcJtWl4A0bZyjPZG9/Wib3DVno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764130870; c=relaxed/simple;
	bh=BkFlPk3+5nub7BZCjBNabDJurWqy94KOOmIC0GDOFag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCHjwEFJJst5EfPVb7eZbP+V7bqDri4uVOkIqZZStdOcE6a8vun2KOAc2//7SO2s9auTP2QLDa/XLOmbqaqJEiiQ5UceUYdu6C9QxRM6RzF3rFq33exFKnkyqBKnal8MIcwPM/gGNpfySJ9nktagY8gHBKgwdEXlwlIgnt8pVtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wq8STw7I; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88244d1559eso5432106d6.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 20:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764130867; x=1764735667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0WQSgW99+CubhdNpwBhumDm/WkmkjO1MJpCA99Mtzw=;
        b=wq8STw7IyUGWcGrc7dw3Gva1AS9pA2QBZhFX9gr/KZSVZVFOR5fJovp1KAggojgETd
         vQNr/alcRgVbDzGzRMtHkmD4hjKnJBt4tVxpInqaKcHJfQV8dwaCZEuWp++PCXBEqrBU
         orq24O9sLQrPYa51CQVJfsRc/AqW28bo4o/qInpsBUECxq7zr6BI8qwMhRfzTemaQ4d4
         Z0PsX2hW9mKsT131+wTT/hQxfCbzAcf7wEd/+kKrsYt0VSgaGic0Ln58gb1MwnP91Vzj
         pMM2jKLu4SNefx6nmZK5Z9bSirqb/9G4yPQ1jfjqiNsiJrcX+zxyoGto8r5va/m7YX/6
         Ed4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764130867; x=1764735667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v0WQSgW99+CubhdNpwBhumDm/WkmkjO1MJpCA99Mtzw=;
        b=hWxO0kZpfYjt9dR4ug2nbTus71G2TtKs72Grdwg+TaJynvBWXHIxYvKKAVFscRQ/mW
         1ieGmxaY3CYXIOTpSo65W2S2u9ZuOWeGxcGwQ9syJGVmFzUG1rDhgLdURoePr7pVYcO5
         jkeRjbVP1yNakzK3KCCAnV0QKahVL0NRJg/OQqYekuhaAgFUgvhdTHhUlpn+bmO71nRN
         lr4tv1ap2kcmZpeDciRolvVmgGTLIbzNn094/kQkYvokE7pV1dF4VdYKoBvKvo3zl5eg
         8hHgZskL4YLO5WIfbieF4eh1FrRDFEOv556balhPSNl7cwsDv7k3Jz3aQ/wW6QLbW8YT
         u1nw==
X-Forwarded-Encrypted: i=1; AJvYcCWtlmbYdLn5shkKbT7WdQ1uVHBYiSqoReIvZXQU83sVobsI9uBvZRMhIGIA2G09noljCK4wF04=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwPOMMGO+0tKNraO4exa5zwEarXUkGQ/Qh5I+OJ8b14auz4/Un
	zyb1/hMqjBRmlFWZLyGXRD9/lVfXhTnV+fXfLRXG9MelzDiqwoEe0IHC4TFTZwJa5xK238v+nE7
	vvTn7A/TZ426cuS+I7VJXYlJBHKbM2V9jLchbO8PL
X-Gm-Gg: ASbGncvrUDriW7KRBnbbREKWaaS9+By3RtdVVBa0wdNBzWa+/gZ2nPds+lR8OFVqjjd
	pKaGRDO3cgGhtF4UsSC1MH1BFrwsSyl47rRM1wGSpwkwDfzAdeXdGQMhoicTMVpfaZDTuTH1OcH
	z6py3pEnxfMhH/k2qTt8t2jVekWgRx3jGeLkgJaN5bvC5kgohm7uFfXW1zVim0RHAIrWgu1ofSF
	5b1x1JrjOdvT1TgCGPdJaupvVBEH9Ayrsm1WD1qJk7uaiu2QjSP4vybhlvOvGFm7BvAww==
X-Google-Smtp-Source: AGHT+IFleJTwznfh7QMv/AG0SGTuwrxVYkRp6eELQGLLc5UcBUyDg99Mf3CPsqqX8gWPb5Hu4F4A9V54ZvoAbPtY+Wg=
X-Received: by 2002:a05:6214:2404:b0:880:5883:4d24 with SMTP id
 6a1803df08f44-8847c45daf6mr255046516d6.9.1764130866514; Tue, 25 Nov 2025
 20:21:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125223312.1246891-1-pablo@netfilter.org> <20251125223312.1246891-3-pablo@netfilter.org>
In-Reply-To: <20251125223312.1246891-3-pablo@netfilter.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Nov 2025 20:20:55 -0800
X-Gm-Features: AWmQ_bl80ip7OhaAsTg46og0aFXG3CVUfPmo7hC2YvkaKQmGy5gAFvzr6Ttk86k
Message-ID: <CANn89i+pLDYSCfz9Yq7MPw5+zS+k9VfL4EXZWxztDGbiL==-Gw@mail.gmail.com>
Subject: Re: [PATCH net-next 02/16] netfilter: flowtable: consolidate xmit path
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, fw@strlen.de, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 2:33=E2=80=AFPM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
>
> Use dev_queue_xmit() for the XMIT_NEIGH case. Store the interface index
> of the real device behind the vlan/pppoe device, this introduces  an
> extra lookup for the real device in the xmit path because rt->dst.dev
> provides the vlan/pppoe device.
>
> XMIT_NEIGH now looks more similar to XMIT_DIRECT but the check for stale
> dst and the neighbour lookup still remain in place which is convenient
> to deal with network topology changes.
>
> Note that nft_flow_route() needs to relax the check for _XMIT_NEIGH so
> the existing basic xfrm offload (which only works in one direction) does
> not break.
>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  include/net/netfilter/nf_flow_table.h |  1 +
>  net/netfilter/nf_flow_table_core.c    |  1 +
>  net/netfilter/nf_flow_table_ip.c      | 87 ++++++++++++++++-----------
>  net/netfilter/nf_flow_table_path.c    |  7 +--
>  4 files changed, 57 insertions(+), 39 deletions(-)
>
> diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilte=
r/nf_flow_table.h
> index e9f72d2558e9..efede742106c 100644
> --- a/include/net/netfilter/nf_flow_table.h
> +++ b/include/net/netfilter/nf_flow_table.h
> @@ -140,6 +140,7 @@ struct flow_offload_tuple {
>         u16                             mtu;
>         union {
>                 struct {
> +                       u32             ifidx;

This ifidx should be moved after dst_cache, to avoid adding one hole
for 64bit arches.

(No need to resend the whole series, this can be fixed later in a
stand alone patch)

>                         struct dst_entry *dst_cache;
>                         u32             dst_cookie;
>                 };

