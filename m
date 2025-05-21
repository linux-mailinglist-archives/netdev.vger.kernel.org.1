Return-Path: <netdev+bounces-192206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D44EABEEB1
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 10:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73BD6189073F
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C11F238C36;
	Wed, 21 May 2025 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBa2lXpS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEFA23817A
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747817824; cv=none; b=GfLPNlDBUlfFMrU5aaxST5a+3qEkFjELWlgMrrmBVedzAVDzlRggi5m2u8WUQmkQN6sqD8M7tjxds7wrV3edeUM4THNCLGkgS0WheN+d7qh6T24Cz/AEdTA1WsFiETeX8JdtwnUHxLxUPfZn29M1I0Ml7xDXOflp+Af/N0uSaPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747817824; c=relaxed/simple;
	bh=XSVAWIQJLeLQ+EnAe2fX432Jiet3EaT40S7A2jVLi7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WlFYEONoL14kutsksJnQOy+Ai29I59VYbYSj1wbGc5LZUIOm3T8lLiZ8MBhTAYiVhkiem15MeAtkhx5k4MlEhW3iDRkC0oBIT580vzEgfD1ezo4hLZIGKrchRMVQ54G4giukLyVw2RP5elrAa5UlkjXZLZW/JkzxbuPyle9MABM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QBa2lXpS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747817822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z5ISw/s/gG2J/o4w18hQ658TJ8AN+hELaWEkOZaX4Ho=;
	b=QBa2lXpSSJ8PDZLP/mjP4CtpyyBjXEQo0SjOsE5BvlKpUdHnwnt1b8GPUtM6hAM1697xB3
	a+Vi+r34slAghzucIS9SyoH8owOjBRjFuOqWO/5VEwCZI0yBw4qZUDMHQvoTOMEeFvDjjB
	6CFKQA6LImBFQL5iO0sHRNYW1ym6LMM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-WaRczTu4PaKu-yRC56_lAA-1; Wed, 21 May 2025 04:56:58 -0400
X-MC-Unique: WaRczTu4PaKu-yRC56_lAA-1
X-Mimecast-MFC-AGG-ID: WaRczTu4PaKu-yRC56_lAA_1747817818
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6f8e7b78eebso35157186d6.2
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 01:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747817818; x=1748422618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5ISw/s/gG2J/o4w18hQ658TJ8AN+hELaWEkOZaX4Ho=;
        b=cf5/Unw0785WLuOxum08Zw2cyXCQFySXkQM4iZiQWNW9h4syTAincrfy2DYHAur7Sa
         hhcolvMoT8p9mkh8KK0fCdtwanAflGC4WtfgBZuA19MeIhAtU4kL+sIG8fOzCvdBoF2G
         HSX2hQArYMqhiGGEyaiAeJuddCqGkcMtm4e5iyy3MCMp8pBEMhoiYjIrcF2Ghalpj/+t
         igCN0auAF5xnm9oK59xI0b8lFpjIDq7DxxQsD5mny2rjsHqOXIMpP7mup9Rp1a9uzD/t
         1z7HDGwvLn2TBbnIxyFCTeVAc7aYf4xoR/lSwR+g/JXIg/C7duwtESAINGbkpgIDM7hy
         g6zA==
X-Forwarded-Encrypted: i=1; AJvYcCVCb/LGkdXYlxoaIQu/dqvU+PjyxkBGfR7eKpRexI9rUK9VEIRIji7XzgryJBJD4ZqUiQ8xR+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh/kBAN4MOrRbA3TGn61xtujAV/G5/0OY3Om0HELmAFPjaz3DT
	0z/PUvKTBDFaroN+oiWI3zn9s7XGGVcY643wy1uhfTtzM4MhLgCC7qSU7tiq1y+/t0zCPHMX4oJ
	xi43wZ5cLMb2zbWvReOV0A07nvYuGun238GygTWnIMmp9BA6dtYEnqcJxTR1yZcvH/zGy4474Ci
	hdIgeOTQK3otUf7d2GvpMA0Rl9ZcDOvOWP
X-Gm-Gg: ASbGnctRuqFx9ue4N1MxQadfo0OvBhP+rpvvdsUdQ1X+KMxZrpo57jjGm6JtBIFibNH
	Tf0d6XBAGSmRF41AZO65gbmxPI8QtxaefBCLi6DqusTdI/fD+0+q7UHzHhSZXNHfquaE=
X-Received: by 2002:a05:6214:2681:b0:6f8:8df1:648 with SMTP id 6a1803df08f44-6f8b2c37a19mr343338766d6.7.1747817818407;
        Wed, 21 May 2025 01:56:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaO4WTOV6fJAlmH9DP3inkXOYir+cNPdLYhrMs4mbVZjO2ZBdSoayKvQmU0Z4z5PR9AxBgDQglVFmrFM7Wvjg=
X-Received: by 2002:a05:6214:2681:b0:6f8:8df1:648 with SMTP id
 6a1803df08f44-6f8b2c37a19mr343338606d6.7.1747817818106; Wed, 21 May 2025
 01:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1747253032-663457-1-git-send-email-tariqt@nvidia.com>
 <CAADnVQLSMvk3uuzTCjqQKXs6hbZH9-_XeYo2Uvu2uHAiYrnkog@mail.gmail.com>
 <dcb3053f-6588-4c87-be42-a172dacb1828@gmail.com> <09377c1a-dac5-487d-9fc1-d973b20b04dd@kernel.org>
In-Reply-To: <09377c1a-dac5-487d-9fc1-d973b20b04dd@kernel.org>
From: Samuel Dobron <sdobron@redhat.com>
Date: Wed, 21 May 2025 10:56:47 +0200
X-Gm-Features: AX0GCFu5dfswcCWTTkSyc0z9SXYg_lElASwlqEtz7krxELOPksJgTCJdKDQl7-M
Message-ID: <CA+h3auNLbmQFXrN1A5Ashek4UiMGa_j+EHaFFp-d74kGZvyjsA@mail.gmail.com>
Subject: Re: [PATCH net-next] net/mlx5e: Reuse per-RQ XDP buffer to avoid
 stack zeroing overhead
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Network Development <netdev@vger.kernel.org>, 
	linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, 
	Sebastiano Miano <mianosebastiano@gmail.com>, Benjamin Poirier <bpoirier@redhat.com>, 
	Toke Hoiland Jorgensen <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hey,
I ran tests just on stack zeroing kernel.

> The XDP_TX number are actually lower than I expected.
> Hmm... I wonder if we regressed here(?)

The absolute numbers look more or less the same,
so I would say no. The first results we have for TX is from
6.13.0-0.rc1.20241202gite70140ba0d2b.14.eln144
comparing it to 6.15.0-0.rc5.250509g9c69f8884904.47.eln148
there is actually 1% improvement. But that might be a
random fluctuation (numbers are based on 1 iteration).
We don't have data for earlier kernels...

However, for TX I get better results:

XDP_TX: DPA, swap macs:
- baseline: 9.75 Mpps
- patched 10.78 Mpps (+10%)

Maybe just different test configuration? We use xdp-bench
in dpa mode+swapping macs.

XDP_DROP:
> >>> Stack zeroing enabled:
> >>> - XDP_DROP:
> >>>      * baseline:                     24.32 Mpps
> >>>      * baseline + per-RQ allocation: 32.27 Mpps (+32.7%)

Same results on my side:
- baseline 16.6 Mpps
- patched  24.6 Mpps (+32.5%)

Seems to be fixed :)

Sam.


