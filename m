Return-Path: <netdev+bounces-88537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91E68A79D7
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 02:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E231C20934
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 00:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BB337B;
	Wed, 17 Apr 2024 00:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs1jfUg8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C41365
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 00:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713313619; cv=none; b=epKlq7IVP3xerNkvmYpZkvevp0YcauqlFXikzESEQq8hXT9zcaWY5hkisA0LrQpMX4N/XJcDkgtLpb+38wzenXhKZDicjJDQpwmzg2P3807NEHzY33VWxpssPzEHIrN6y4tcteSTpRvw/dxGkN9BA0S0pOjfJk4wBB3ddonhMOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713313619; c=relaxed/simple;
	bh=P9DFS1sM0cp+Hub8bqQSXJViTLMjM5hMEYqzQnANOi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nb009PJ9IHJw2hfE0NSOSKwk1PB2zXx0NzCEsQAqV6qGuD+1/WcRBM4KB2X8JZlp/74fm4EpTNdXzr3HvPwW1C78LP4Myb5eJNryQBLXRj2a/75I3YnajIrqFIQT+A1Zoyeoo1X7btyt3DrAd6UEs3COHsbQQl3VmGTUBN9ixzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xs1jfUg8; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5557e3ebcaso11033266b.1
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 17:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713313616; x=1713918416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxmNLiA6wbPNVXDbVzh4od5XCJygABpMjV5thETmo8Q=;
        b=Xs1jfUg89EEdTNTl4HnSdgxCqLcJGcuZR/4nVJ4gevIPOMtsSRUy7Mg9mQPM/g8Txr
         QNIsdi4PcNp0fcjAH57aStxPnRwKN1p5QoS9+Jn2zruhx9GxRrVsHyS2Vmu1Pya0XJ8D
         ZSAbym0rcQgYAOUF8Zo6HeAlN9AvyrMbU7e0B9uWCJxc/uTmp/rVp5BTZ9ITgZ9fyHf+
         oH8CWUSJyMIbpI/oqo9vUsHG+1/5tkV843n76IzvRbboH9VQ5Myl5sMvTIcEPpw+2TA1
         nACibtiZhuDTe0D747oUR6cnrCbAfdCHcK0hG0Y4P2aRQld2OGeaga76ObRa5mQi4gby
         Py/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713313616; x=1713918416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxmNLiA6wbPNVXDbVzh4od5XCJygABpMjV5thETmo8Q=;
        b=tdvgSQYXvVpE5bNDAGiMjbIGo8kM8MVm+EXooH62rfNDqz/vsrPwARlj57wR/kr/DF
         5qm24Na2fWzRTHBK94ncGi//oyja0MZR2wSDQciRZMiNpa++g88n3DXuRTk8nLIR6yz2
         em8qv9N10epYPPlO//hmfqvF6Qrg5rl4Znl9rdUuNImDWPpj8ekj+MsquH273n3jbBQC
         4OE2eg65ZMl40fXKisE0AgGFe4PgUa/pOOc1okvX4VKysHklbkBAjmAFZYXuvLFF5uMM
         nG+EFmoeVNDzIczGkX9YoQqOBxnEKZO0WLoLCslfXq8f8flbJksXphTgu0WaE/LhfoWs
         dRIw==
X-Gm-Message-State: AOJu0YwoPld1llHeTGJi3GOKQYxe90b/1whe/Z7vTpcx+p7amrXfKmhZ
	nBYWDz2CbPPuOFVN3xTE4RLKfP1uBEJJs5YZr64p8qtyPuoQ5w/jmyuys3oaWu9/T75TxrjdnGx
	5YGxU2TFNsHYcE9tSlkgP4w5e/F8=
X-Google-Smtp-Source: AGHT+IGcbvpFqtwrEODmlFZLVFDhQEKTj0S/yGYFjc84mvRvkKEEjAinZ2tSwpyzpAhaxBzwrH0yQuD9qfg43yH/F1k=
X-Received: by 2002:a17:907:985:b0:a51:b49e:473e with SMTP id
 bf5-20020a170907098500b00a51b49e473emr3520682ejc.19.1713313615373; Tue, 16
 Apr 2024 17:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416074232.23525-1-kerneljasonxing@gmail.com> <20240416074232.23525-2-kerneljasonxing@gmail.com>
In-Reply-To: <20240416074232.23525-2-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 17 Apr 2024 08:26:18 +0800
Message-ID: <CAL+tcoD19X_ijKsLQu3cWaLsk8saeEAqQ8MWiJstDMJuWvbNfQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: rps: protect last_qtail with
 rps_input_queue_tail_save() helper
To: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, horms@kernel.org
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 3:42=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Only one left place should be proctected locklessly. This patch made it.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/core/dev.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 854a3a28a8d8..cd97eeae8218 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4501,7 +4501,7 @@ set_rps_cpu(struct net_device *dev, struct sk_buff =
*skb,
>                 struct netdev_rx_queue *rxqueue;
>                 struct rps_dev_flow_table *flow_table;
>                 struct rps_dev_flow *old_rflow;
> -               u32 flow_id;
> +               u32 flow_id, head;
>                 u16 rxq_index;
>                 int rc;
>
> @@ -4529,8 +4529,8 @@ set_rps_cpu(struct net_device *dev, struct sk_buff =
*skb,
>                         old_rflow->filter =3D RPS_NO_FILTER;
>         out:
>  #endif
> -               rflow->last_qtail =3D
> -                       READ_ONCE(per_cpu(softnet_data, next_cpu).input_q=
ueue_head);
> +               head =3D READ_ONCE(per_cpu(softnet_data, next_cpu).input_=
queue_head);
> +               rps_input_queue_tail_save(rflow->last_qtail, head);

I made a mistake. I should pass &rflow->last_qtail actually. Will update it=
.

>         }
>
>         rflow->cpu =3D next_cpu;
> --
> 2.37.3
>

