Return-Path: <netdev+bounces-149367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2369E54B4
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D03280FB3
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750C82144D5;
	Thu,  5 Dec 2024 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbjbQzdX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB0A2144B4
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 11:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399834; cv=none; b=ZheHoCS9EJBxzw5PKKQ7SltEMVUI7sghd3XK4X4DRg3QhxthHKXQFr0M29YDtoTDfX2RSCmXkJUiUmXkBL1EpgFRQbYSEPT46BwJUl/yL0aTF1vow7oT3owXnC45neYCr1n5AXKV1g1q1QMs90leSJI3KK+4LUnTviyScRvBxoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399834; c=relaxed/simple;
	bh=mg40j4X5TnbWjK+sjSu/jGP++SDTtzAyZtPML+K4zmU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=siVEg4QrJG6maK7xMm6pTMCq5mpOmhsT6xkiY0in4OTQ6RMRqtcY+tzYd3vHgRjgAe8SjCPVrULe1qYDVxvH0FbAjWhJQpX8LngMAg/bVDhA9hpfuqmp6Ph4/CQaWn9Jt3pMboiEEktEteDGxlQUI84uUAd69DRRbis/cbCwZo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cbjbQzdX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733399831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFla3Qp3r/yekTBfZAp241Q7XHwJ4BzRNOU/5NbAnDk=;
	b=cbjbQzdXRKJ0tuFppT5SvvkDfcZPuemf5aOWiqXLAcu/RuQ2gLRhiGlYff/9eK8rY+++6i
	8gGJf4Lvj42AillVGfRxMzUyvPFx6twPiKRYNxCVEkkmKfcqfbsHCVz+B7mRIVkJIGStBr
	MKzy4ibIi7x3lgU/yfNTOlwqhCu6ufU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-pnczsjM3O8-O8_U5_6Jv4g-1; Thu, 05 Dec 2024 06:57:10 -0500
X-MC-Unique: pnczsjM3O8-O8_U5_6Jv4g-1
X-Mimecast-MFC-AGG-ID: pnczsjM3O8-O8_U5_6Jv4g
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa62da5ef1fso33056366b.1
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 03:57:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733399829; x=1734004629;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFla3Qp3r/yekTBfZAp241Q7XHwJ4BzRNOU/5NbAnDk=;
        b=d/oPGpL9ujJGm9urbBlSMHMhyp/1UgEy/CooFC83XS0q/Jj+SYpVEOhz8fnlqak7rx
         8O3r6Lll/ovD8+QGM21ncDQE2LUZa9e1/KJ3DUnXHEfuP1u3y7HhOferMWygw/eefJw9
         z/S0WtnxQ6uklStDr9vAnmpaXhbtIOEJypyUFwuoLNN+gXNFSKHYjAqrodC/+5VQ+u3F
         3Bjeu79M9s16MUAxx+VyHrYR5RoznDGO3qLanX8bsrSlg94zuMe+iWq9fooaLWSmN7GN
         bF5wLHJQSfxZXlAdDnf34Te6k9tgz7lQdG/ycDCbi9sVOgXdZl2XwVVt9iHIk7QNQ4dD
         r6lg==
X-Forwarded-Encrypted: i=1; AJvYcCXePLKt1+Tdcigs+uw8LZjpv1X2b3g6sS00EjpZKkSAgpYsj5V/WewusXfpy1qk/R+UzptvoK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrhi9EAiCtGVxUcB2/TmMxGoXAml/04VO0f1cuBfcpnzB1bqdr
	ogxYKkPVAqdTe/n4Pvj4/pL4ottVadmnwtgsAbvq4+ylfe03zbi9Wn8cRksXGjYoE9Zt8sF0jUD
	46zuw7/p9y1KxlnjCPpwY6WxlKmtIYe+guPz5Q4iBK4++hYCIrHb5Bg==
X-Gm-Gg: ASbGncuAijrEfaPcU5k0X/BS3xTJR/Yip2y1PRz/Abt/Pj1RBhq155RUxrcOdb+0+4w
	oIP8EYgzHWi/iHpTP4GHKZ6wC9YY4CZbvWJdWhjbM+67dWtD20zFSV9q37j2uWxq7IO92ZsD+Ih
	wc8dlhCXI+mdMrOujKa7aokTZofybu44rksjFHxq1aSYXP1Rcbg7Xj3Re+BjoJdjtdxNJkHCeCh
	Jx2MIrKi9oPJVC7F+k2u60VnBHxuesG9Vsf7VxYf1//fWoboCM=
X-Received: by 2002:a05:6402:43ce:b0:5d0:d2b1:6831 with SMTP id 4fb4d7f45d1cf-5d124fe39a8mr2834080a12.14.1733399828877;
        Thu, 05 Dec 2024 03:57:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBUtKfu2Gj8DSijA4odCWN4m7pia29+Whb/yJALIPckyWB9oODk8B3pfpb9GFkT4RXDFyVsw==
X-Received: by 2002:a05:6402:43ce:b0:5d0:d2b1:6831 with SMTP id 4fb4d7f45d1cf-5d124fe39a8mr2834053a12.14.1733399828500;
        Thu, 05 Dec 2024 03:57:08 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c74c3d5sm703807a12.52.2024.12.05.03.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 03:57:07 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C05DF16BD2D0; Thu, 05 Dec 2024 12:57:06 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira
 <victor@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 net-next] net_sched: sch_fq: add three drop_reason
In-Reply-To: <20241204171950.89829-1-edumazet@google.com>
References: <20241204171950.89829-1-edumazet@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 05 Dec 2024 12:57:06 +0100
Message-ID: <875xny9wbx.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> Add three new drop_reason, more precise than generic QDISC_DROP:
>
> "tc -s qd" show aggregate counters, it might be more useful
> to use drop_reason infrastructure for bug hunting.
>
> 1) SKB_DROP_REASON_FQ_BAND_LIMIT
>    Whenever a packet is added while its band limit is hit.
>    Corresponding value in "tc -s qd" is bandX_drops XXXX
>
> 2) SKB_DROP_REASON_FQ_HORIZON_LIMIT
>    Whenever a packet has a timestamp too far in the future.
>    Corresponding value in "tc -s qd" is horizon_drops XXXX
>
> 3) SKB_DROP_REASON_FQ_FLOW_LIMIT
>    Whenever a flow has reached its limit.
>    Corresponding value in "tc -s qd" is flows_plimit XXXX
>
> Tested:
> tc qd replace dev eth1 root fq flow_limit 10 limit 100000
> perf record -a -e skb:kfree_skb sleep 1; perf script
>
>       udp_stream   12329 [004]   216.929492: skb:kfree_skb: skbaddr=3D0xf=
fff888eabe17e00 rx_sk=3D(nil) protocol=3D34525 location=3D__dev_queue_xmit+=
0x9d9 reason: FQ_FLOW_LIMIT
>       udp_stream   12385 [006]   216.929593: skb:kfree_skb: skbaddr=3D0xf=
fff888ef8827f00 rx_sk=3D(nil) protocol=3D34525 location=3D__dev_queue_xmit+=
0x9d9 reason: FQ_FLOW_LIMIT
>       udp_stream   12389 [005]   216.929871: skb:kfree_skb: skbaddr=3D0xf=
fff888ecb9ba500 rx_sk=3D(nil) protocol=3D34525 location=3D__dev_queue_xmit+=
0x9d9 reason: FQ_FLOW_LIMIT
>       udp_stream   12316 [009]   216.930398: skb:kfree_skb: skbaddr=3D0xf=
fff888eca286b00 rx_sk=3D(nil) protocol=3D34525 location=3D__dev_queue_xmit+=
0x9d9 reason: FQ_FLOW_LIMIT
>       udp_stream   12400 [008]   216.930490: skb:kfree_skb: skbaddr=3D0xf=
fff888eabf93d00 rx_sk=3D(nil) protocol=3D34525 location=3D__dev_queue_xmit+=
0x9d9 reason: FQ_FLOW_LIMIT
>
> tc qd replace dev eth1 root fq flow_limit 100 limit 10000
> perf record -a -e skb:kfree_skb sleep 1; perf script
>
>       udp_stream   18074 [001]  1058.318040: skb:kfree_skb: skbaddr=3D0xf=
fffa23c881fc000 rx_sk=3D(nil) protocol=3D34525 location=3D__dev_queue_xmit+=
0x9d9 reason: FQ_BAND_LIMIT
>       udp_stream   18126 [005]  1058.320651: skb:kfree_skb: skbaddr=3D0xf=
fffa23c6aad4000 rx_sk=3D(nil) protocol=3D34525 location=3D__dev_queue_xmit+=
0x9d9 reason: FQ_BAND_LIMIT
>       udp_stream   18118 [006]  1058.321065: skb:kfree_skb: skbaddr=3D0xf=
fffa23df0d48a00 rx_sk=3D(nil) protocol=3D34525 location=3D__dev_queue_xmit+=
0x9d9 reason: FQ_BAND_LIMIT
>       udp_stream   18074 [001]  1058.321126: skb:kfree_skb: skbaddr=3D0xf=
fffa23c881ffa00 rx_sk=3D(nil) protocol=3D34525 location=3D__dev_queue_xmit+=
0x9d9 reason: FQ_BAND_LIMIT
>       udp_stream   15815 [003]  1058.321224: skb:kfree_skb: skbaddr=3D0xf=
fffa23c9835db00 rx_sk=3D(nil) protocol=3D34525 location=3D__dev_queue_xmit+=
0x9d9 reason: FQ_BAND_LIMIT
>
> tc -s -d qd sh dev eth1
> qdisc fq 8023: root refcnt 257 limit 10000p flow_limit 100p buckets 1024 =
orphan_mask 1023
>  bands 3 priomap 1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1 weights 589824 196608 65=
536 quantum 18Kb
>  initial_quantum 92120b low_rate_threshold 550Kbit refill_delay 40ms
>  timer_slack 10us horizon 10s horizon_drop
>  Sent 492439603330 bytes 336953991 pkt (dropped 61724094, overlimits 0 re=
queues 4463)
>  backlog 14611228b 9995p requeues 4463
>   flows 2965 (inactive 1151 throttled 0) band0_pkts 0 band1_pkts 9993 ban=
d2_pkts 0
>   gc 6347 highprio 0 fastpath 30 throttled 5 latency 2.32us flows_plimit =
7403693
>  band1_drops 54320401
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Nice to see qdisc-specific drop reasons - guess I should look at this
for sch_cake as well!

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


