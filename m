Return-Path: <netdev+bounces-149382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2122A9E55B6
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 13:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D12288579
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A197C217673;
	Thu,  5 Dec 2024 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="HmNEKWo+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14E01FA179
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733402518; cv=none; b=qeUnyadGU8Oc7ISUAWXd5jrcFZJ9YbXfeIcXGIrhTGoo5iAXor1w/JpvK0gvxgnAwPE8GV+0BkyR6t6VywGPKKKn7dqrViO+u/fAWvlE1Rn80gEmcM/bvG8dDdJ4Ug/EPnPE85ivKAs/No4+4jK9L6ogqxoriFSK+Ps3kTPSaOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733402518; c=relaxed/simple;
	bh=BNhaJs6CiOdZd+7hAJ8eeOI6tdwXFJAOWkrm+D4bzV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGy548qINRXVpfrKbo/b2DopS1R4vQ+od9GrwTg0TzHHokbWKDwzCTDWrkoYPqrxSz940+7nNMsNSAjZccFmyW5VIxfdRzxuqhNMf0lZtRhGuH6ZVnEVQE+atc707hC1KicylWLlA3t8azB1Fpw/pROZqMjxglh4AJ95AQ+UvNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=HmNEKWo+; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7f46d5d1ad5so711350a12.3
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 04:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1733402516; x=1734007316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aXJhFe+Fkc/ZHmNrbnqLxgMJow0Ch+8KNQzyLfTpLs=;
        b=HmNEKWo+EdjSk0dtYIpNarQupiSGgwdrWKROQ5ZEBnS0YLtSF96qtkRiBxOIsjzOuK
         tYE4QfJCrKuPMAVmUYOOymVzBxvgj6dJYmuYSA/X/fq8FAevyjlWS2pjR/PrlOlyYrAB
         /LwQ5K21hH8weL+0LCs15Cxhhg0/ZneuLU/SDda44xVJW54nMREJbArY+4l4qP6g36dM
         qyivVHXJqCrngscjjzLoLBxvRW5mI/TgOvg+5HmVWYwrWkhFFgGl08tGGkeIZ5CO4/6P
         njK2SYODDxhm3FgKm3nw7q9mEXfSVIbxAZpwhCYQTuELuy1pJT44Xyr/BbdmOD2E4JsO
         GvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733402516; x=1734007316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5aXJhFe+Fkc/ZHmNrbnqLxgMJow0Ch+8KNQzyLfTpLs=;
        b=gNKp8OY5dAiO3KKr6ZIkg0zq/KsQ+0vosv1ETA/PIjJe3NgverVlFf+7X7aMHOUojF
         ExPV/KSE0eZHN0Tm/J5oWDVt4WCBE8U5PDqhhk4x4JcyKOEAN6M59DCBS8dTOFY60E1l
         HWyzWrNmb8z9kQeKFM2R9KG3YFKv+CRrhPELgn4YvzI1ERvccU6JM0Cal3mzZq0tthnC
         ThM2iG2GvftaQFl8MZaZz4gy1uOj80VEy+TuKCw1Ojw5Qsnsw/N7glBVZBGWkCV8YIiG
         CisCuE91TTWc4IlGnK6fp2OLTp4zjNTAPoQZQ36+4Uvemd4S07jirPrehHFJHf/+Ivu6
         8aSg==
X-Forwarded-Encrypted: i=1; AJvYcCWz9l5tvSzoaIXexjvNKCO5uur5aSQiibK3Shlunhm5qb7Gdp6unDTKsYy6SYmzD3/8tNg/htg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMuC+3BSLgwK8VY4WLoQPojWnyA1tAcLoM+hYkPy3KTWvRRB8R
	qOYXK1KswfaBYH5dy2yLikAEktROP20pPk629DDHo+Dl90tdNotzNK8/owvCaX3fKIXbnAQmiNE
	IIO//HCUCcwpV2pDVrzjrcmFUkLkfKUvRkSDS
X-Gm-Gg: ASbGncuptxnAWw4BmTrY73bRhEe+FvnFgJBKSdd/GJU2PXZhzmAuF9D11hopbCcbbCq
	JDzZHKTdkhZuklQ/lUha7fYnZ0MxFtg==
X-Google-Smtp-Source: AGHT+IGqHv0JpW1eJ6ICz/Zq+CmhpbP7WfJ0Fq5xRXEXEvAlm2Uah35cYl+he1CTRKKIgdO3vKSemVHwsH4GkWq7XxM=
X-Received: by 2002:a17:90b:33cd:b0:2ee:9d49:3ae6 with SMTP id
 98e67ed59e1d1-2ef011fb9d8mr14429048a91.10.1733402516128; Thu, 05 Dec 2024
 04:41:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204171950.89829-1-edumazet@google.com> <875xny9wbx.fsf@toke.dk>
In-Reply-To: <875xny9wbx.fsf@toke.dk>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 5 Dec 2024 07:41:45 -0500
Message-ID: <CAM0EoMksqZLU9yu7x3kaueK5OPEjHKQgvYi_kDvMjD4OEknaqQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] net_sched: sch_fq: add three drop_reason
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Victor Nogueira <victor@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 6:57=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> Eric Dumazet <edumazet@google.com> writes:
>
> > Add three new drop_reason, more precise than generic QDISC_DROP:
> >
> > "tc -s qd" show aggregate counters, it might be more useful
> > to use drop_reason infrastructure for bug hunting.
> >
> > 1) SKB_DROP_REASON_FQ_BAND_LIMIT
> >    Whenever a packet is added while its band limit is hit.
> >    Corresponding value in "tc -s qd" is bandX_drops XXXX
> >
> > 2) SKB_DROP_REASON_FQ_HORIZON_LIMIT
> >    Whenever a packet has a timestamp too far in the future.
> >    Corresponding value in "tc -s qd" is horizon_drops XXXX
> >
> > 3) SKB_DROP_REASON_FQ_FLOW_LIMIT
> >    Whenever a flow has reached its limit.
> >    Corresponding value in "tc -s qd" is flows_plimit XXXX
> >
> > Tested:
> > tc qd replace dev eth1 root fq flow_limit 10 limit 100000
> > perf record -a -e skb:kfree_skb sleep 1; perf script
> >
> >       udp_stream   12329 [004]   216.929492: skb:kfree_skb: skbaddr=3D0=
xffff888eabe17e00 rx_sk=3D(nil) protocol=3D34525 location=3D__dev_queue_xmi=
t+0x9d9 reason: FQ_FLOW_LIMIT
> >       udp_stream   12385 [006]   216.929593: skb:kfree_skb: skbaddr=3D0=
xffff888ef8827f00 rx_sk=3D(nil) protocol=3D34525 location=3D__dev_queue_xmi=
t+0x9d9 reason: FQ_FLOW_LIMIT
> >       udp_stream   12389 [005]   216.929871: skb:kfree_skb: skbaddr=3D0=
xffff888ecb9ba500 rx_sk=3D(nil) protocol=3D34525 location=3D__dev_queue_xmi=
t+0x9d9 reason: FQ_FLOW_LIMIT
> >       udp_stream   12316 [009]   216.930398: skb:kfree_skb: skbaddr=3D0=
xffff888eca286b00 rx_sk=3D(nil) protocol=3D34525 location=3D__dev_queue_xmi=
t+0x9d9 reason: FQ_FLOW_LIMIT
> >       udp_stream   12400 [008]   216.930490: skb:kfree_skb: skbaddr=3D0=
xffff888eabf93d00 rx_sk=3D(nil) protocol=3D34525 location=3D__dev_queue_xmi=
t+0x9d9 reason: FQ_FLOW_LIMIT
> >
> > tc qd replace dev eth1 root fq flow_limit 100 limit 10000
> > perf record -a -e skb:kfree_skb sleep 1; perf script
> >
> >       udp_stream   18074 [001]  1058.318040: skb:kfree_skb: skbaddr=3D0=
xffffa23c881fc000 rx_sk=3D(nil) protocol=3D34525 location=3D__dev_queue_xmi=
t+0x9d9 reason: FQ_BAND_LIMIT
> >       udp_stream   18126 [005]  1058.320651: skb:kfree_skb: skbaddr=3D0=
xffffa23c6aad4000 rx_sk=3D(nil) protocol=3D34525 location=3D__dev_queue_xmi=
t+0x9d9 reason: FQ_BAND_LIMIT
> >       udp_stream   18118 [006]  1058.321065: skb:kfree_skb: skbaddr=3D0=
xffffa23df0d48a00 rx_sk=3D(nil) protocol=3D34525 location=3D__dev_queue_xmi=
t+0x9d9 reason: FQ_BAND_LIMIT
> >       udp_stream   18074 [001]  1058.321126: skb:kfree_skb: skbaddr=3D0=
xffffa23c881ffa00 rx_sk=3D(nil) protocol=3D34525 location=3D__dev_queue_xmi=
t+0x9d9 reason: FQ_BAND_LIMIT
> >       udp_stream   15815 [003]  1058.321224: skb:kfree_skb: skbaddr=3D0=
xffffa23c9835db00 rx_sk=3D(nil) protocol=3D34525 location=3D__dev_queue_xmi=
t+0x9d9 reason: FQ_BAND_LIMIT
> >
> > tc -s -d qd sh dev eth1
> > qdisc fq 8023: root refcnt 257 limit 10000p flow_limit 100p buckets 102=
4 orphan_mask 1023
> >  bands 3 priomap 1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1 weights 589824 196608 =
65536 quantum 18Kb
> >  initial_quantum 92120b low_rate_threshold 550Kbit refill_delay 40ms
> >  timer_slack 10us horizon 10s horizon_drop
> >  Sent 492439603330 bytes 336953991 pkt (dropped 61724094, overlimits 0 =
requeues 4463)
> >  backlog 14611228b 9995p requeues 4463
> >   flows 2965 (inactive 1151 throttled 0) band0_pkts 0 band1_pkts 9993 b=
and2_pkts 0
> >   gc 6347 highprio 0 fastpath 30 throttled 5 latency 2.32us flows_plimi=
t 7403693
> >  band1_drops 54320401
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Nice to see qdisc-specific drop reasons - guess I should look at this
> for sch_cake as well!
>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

