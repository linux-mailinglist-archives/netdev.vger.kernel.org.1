Return-Path: <netdev+bounces-113136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D9293CCAF
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 04:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C706C282D85
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 02:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB39D208C4;
	Fri, 26 Jul 2024 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLw3n2c8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2CC1BC49
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721960497; cv=none; b=YbVHo7dXLVjzWpMgDg6ylPrRn0dRg/HNfXpamsXT1eFXRdtTzmTKq78QBV6YVXo/BoTrmddArEVkeQUDmll4y9dzS+LBbQHX3d/8WD4Nf8MwDfYuNP0nouSfmNlqGwPFsenqNlOIc8wa8vpxL+fhLqmiAHApV3IfZB0boZFV7Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721960497; c=relaxed/simple;
	bh=9pPNleW41JbaEoT5d7ZdvPpk9ik8QLyyrEts7kTbW5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBw0IQENdRfZoeevwCvp0yUbJ0a7yT9ZxiaVwj2aFTSbv8GY7G7pAK/vf4ECjjnVzG8F3COZPYwImzM2uRxBuLQPCrLzsJDAxBMkeOdqdEBGVAppXb+nR5Wn1+TQaZWzcBwDhR1p8flJthcYXKpIaWoff/gyb6SpZUux3gqroik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KLw3n2c8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721960495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cD9M07/PagDrXP2ta/1b1JQMk5bjY/PWuJ+NKQsHVrI=;
	b=KLw3n2c8MjAvd9hMVm6MHYVRzK8xTerC2tXMXrQBPqTPjDgo9/M8S8woepkOxXGwjAi5Y0
	HXmZPzCH9RfnWsemNEi4hN5JSeJhJUD8gr6z7rrkP8WufTtWVC059DDXeTV4SNIb0t/66V
	k1rrPSpDiBh5gfwvvvRUDmRGz4a/7OI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-t1xj1VevPOG09w3AQ2DpZQ-1; Thu, 25 Jul 2024 22:21:29 -0400
X-MC-Unique: t1xj1VevPOG09w3AQ2DpZQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cb696be198so569611a91.3
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 19:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721960488; x=1722565288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cD9M07/PagDrXP2ta/1b1JQMk5bjY/PWuJ+NKQsHVrI=;
        b=wV/DZgRxIXcjH0PHQLYkiSJfEF/RN3jPChgy66ia1G88YILYmnhlW5NMV+vJMAQwA8
         wuUu/Zp00SNb1Y4PVDMwQ3HZr1G77KIvnmNb2qJv1ao5AiuOM5CmYJWwF1tYV8o/2dm7
         kGcfnMCYmHlxu4u7rikMp7Av7BA7EXlFixWeMGBlBchKTECelQym0P6MrgtzzJZjtvzR
         9N1JYK7Ze52lCf+hM0PDBdscl5HYDftMoCdVX2Tjd82Om+5b/czR0yN1y/h6lpi19L2r
         zi3VoIucPvcFe8yTb2Hv00jRkVir6Wpqa9kvynYDVz4QBLfGJ4AKT0Hvfs0nybgDZIV0
         P0KA==
X-Forwarded-Encrypted: i=1; AJvYcCV3WeLIUSzIdLtd3GcvVZBceRLXpNwN7fdhw/IrPb73WiH/Xvch+pIdntQW965uUVlzx92DHEx54AjMx0D/Ozol0I2t7/K2
X-Gm-Message-State: AOJu0Yyup83aGXAJ5mnPs0JGH0DJ2vH7yiC8scddsb4quBofnDT/a8iN
	oh7ebu6/zkUSFwb61mzYbYa0cvNsbuwMUGyLCvWf5XUORnlOtrPIoKJ4zApCOIvA60CuUzlLdcI
	5YJpM21vBq+eg9TicT/e6JXkmtbugee5R3OKFrNtalMeTR1gQuOhEqQZ0IQUpw6sCj3zTIdJVkO
	8VuuQCA/DV23oG39DX3LqdK7g9fozC
X-Received: by 2002:a17:90a:e50e:b0:2c4:aae7:e27 with SMTP id 98e67ed59e1d1-2cf2ea0f4e6mr4277358a91.23.1721960488163;
        Thu, 25 Jul 2024 19:21:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0mJhruNRcMlENqGhBASXD6O3mnsHAgEZxCXB60xz9QTVgQMj2Rq6goVxIFQ40Heya4tJ4Y2caqJ4tY1oGqOI=
X-Received: by 2002:a17:90a:e50e:b0:2c4:aae7:e27 with SMTP id
 98e67ed59e1d1-2cf2ea0f4e6mr4277333a91.23.1721960487690; Thu, 25 Jul 2024
 19:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009d1d0a061d91b803@google.com> <20240725214049.2439-1-aha310510@gmail.com>
In-Reply-To: <20240725214049.2439-1-aha310510@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Jul 2024 10:21:16 +0800
Message-ID: <CACGkMEv2DZhp71-QdckH+9ycerdNd7+F5vFyq3g=qquEsm9rHw@mail.gmail.com>
Subject: Re: [PATCH net] tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()
To: Jeongjun Park <aha310510@gmail.com>
Cc: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	willemdebruijn.kernel@gmail.com, bigeasy@linutronix.de, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 5:41=E2=80=AFAM Jeongjun Park <aha310510@gmail.com>=
 wrote:
>
> There are cases where do_xdp_generic returns bpf_net_context without
> clearing it. This causes various memory corruptions, so the missing
> bpf_net_ctx_clear must be added.
>
> Reported-by: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com
> Fixes: fecef4cd42c6 ("tun: Assign missing bpf_net_context.")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

(Looks like the do_xdp_generic() needs some tweak for example we can
merge the two paths for XDP_DROP at least).

Thanks

> ---
>  net/core/dev.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 6ea1d20676fb..751d9b70e6ad 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5150,6 +5150,7 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, struc=
t sk_buff **pskb)
>                         bpf_net_ctx_clear(bpf_net_ctx);
>                         return XDP_DROP;
>                 }
> +               bpf_net_ctx_clear(bpf_net_ctx);
>         }
>         return XDP_PASS;
>  out_redir:
> --
>


