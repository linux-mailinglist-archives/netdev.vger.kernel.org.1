Return-Path: <netdev+bounces-183322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EF9A9059D
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313AF464375
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6672C219A79;
	Wed, 16 Apr 2025 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R83jD2XH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10481FCFEE
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811911; cv=none; b=ZvWy+B4PgMfb2RU7TdaervfIWUms9jGd3DqSiJf7q4/HzXa2zr/5czjvWXjHU8hWXxI3oVs6+Snix7Yku//bnmpSviVAd0Sai3Gpyab7p+EBGGqSbaWzZYFgLqbLOmy+ZIQR9KiOSO8+CSZfCEp31HVjuxRO7y9xJ74NdMQrRGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811911; c=relaxed/simple;
	bh=8EM9BruECeiQqpmSu5JthfQXoLeNBFmHqAhot8Jq1Xs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fB8yX811JFTE5VGXEdMwsFZUoCtS71DY90mLGURmNf9fnepIuZLbPUZAzI30oFid329MV8J27ip+O3DryBj7anoffle1S3dGAsPV5d3+NLBwpJe1NLr6yMAWB2jZltouAWwZUaevDS+fVBQS0TbBcroVl+J2YUszI/9v7tGUc7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R83jD2XH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744811908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1N10mZ+kpKiQYbX+sNKEw8ESo27Q4EehsQAThfgN6Kc=;
	b=R83jD2XH/vF/LWCJIPb8Nv1BXQCJPM+aQX4LtgwJoSX/scr+8rkNJoi3WHc2hk58BQkiDK
	KZnjb6kzLo2HHxCZ+bt5stVsWL+Epn9a4vbdJzJarY9MTsXmra777lifDQtKfaAPED9Qpf
	vLHYwhOpmJB9d2898tXY1XUH9De2KJw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-8In7otUmMkm92a4_fp-0uw-1; Wed, 16 Apr 2025 09:58:27 -0400
X-MC-Unique: 8In7otUmMkm92a4_fp-0uw-1
X-Mimecast-MFC-AGG-ID: 8In7otUmMkm92a4_fp-0uw_1744811906
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac31adc55e4so546467966b.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 06:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744811906; x=1745416706;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1N10mZ+kpKiQYbX+sNKEw8ESo27Q4EehsQAThfgN6Kc=;
        b=sGdEIKeF96Ogarzr+u1F97sF2vL5qoEh9PLW2KrlVuq2SjVaVOgAc91MJcVMDM3kuh
         7j+TUMdxdDY/nDE1EtNCvW0qS+uqhV71KsTnuSxLyRCLGrm1Se5cMzt66nV0ILKZs8LT
         hyQ0povMnOf1gPt/NcczB3P6yMpAZ9xZY7qYnesxA4SWZ8HoBdycFG8yxS/io3TVgp4l
         TJlebE/U7diHdUiAPsWK6BNKXJyI8JBY6CvmwF0dIBNWR9fS9xusPXQN7i2oek9AAhWs
         7P29KlYLg9S1/BZaNMvlJJZOYAN7ZM3A4Bnmq6wXWaGMB8DkjtI6tj8cF0XLByD7JR61
         Wbjw==
X-Gm-Message-State: AOJu0Yxn7ZgFl2GBYZoKcDpGYJk8qXTznZ3+kZnTeJK2SEcmgJ1kZYi7
	jCP3r6A8jfbDqbBFLX98mQbBq97FnLzJG6YoTUCF4tI+S74sCxrD8s2FhzCGje40cFlBod1td6/
	+Je5OPX1ome/E9kvCBeAf7IFy6zc6PcoUG4tkbnB85IOEiTXi7pyCSQ==
X-Gm-Gg: ASbGnctn85v0M/SQ9YIY97AvEmHhT3Tc86E4U3PN7RKIDCqAmsfYToUSUmPq894u+a9
	ssjpVKEnopTsu3paJjJj+OACFUmKh0BLJgozMl8ve3vPep4urFC1jSc6/P3BaQQ2lmVt5atStBr
	x7QsMx5gBsTyvZKMVVHZ+lV2XvBIPv1ZmhZErQ4hC8vTtPt0YS3+SJn7GbZkhu7a1hhbKcP/0S4
	VZE1024EbKCaP3w8Hv0sNbs7UlrgbB/mjOn5kphJj3wdHDP2NKoL8a5iz6kRuHKkC9/UzCmJ+e1
	uoJjaySn/BJtMvpUuN2M8QVUAKxdKO1QI48m
X-Received: by 2002:a17:907:9494:b0:acb:349d:f909 with SMTP id a640c23a62f3a-acb42a50028mr161011466b.31.1744811906204;
        Wed, 16 Apr 2025 06:58:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzy9DzmjmdBXDssMZ4LwJxwTRh/bRvt8RWJJn9qTge4GJkEWLxrIw1aLgJPYwpUtVRtYJYQA==
X-Received: by 2002:a17:907:9494:b0:acb:349d:f909 with SMTP id a640c23a62f3a-acb42a50028mr161009266b.31.1744811905828;
        Wed, 16 Apr 2025 06:58:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb3d128583sm136615866b.98.2025.04.16.06.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 06:58:25 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 31E07199293F; Wed, 16 Apr 2025 15:58:24 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, tom@herbertland.com, Eric
 Dumazet <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, dsahern@kernel.org,
 makita.toshiaki@lab.ntt.co.jp, kernel-team@cloudflare.com, phil@nwl.cc
Subject: Re: [PATCH net-next V4 2/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
In-Reply-To: <20250416063813.75fb83dc@kernel.org>
References: <174472463778.274639.12670590457453196991.stgit@firesoul>
 <174472470529.274639.17026526070544068280.stgit@firesoul>
 <20250416063813.75fb83dc@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 16 Apr 2025 15:58:24 +0200
Message-ID: <87r01si4xr.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 15 Apr 2025 15:45:05 +0200 Jesper Dangaard Brouer wrote:
>> In production, we're seeing TX drops on veth devices when the ptr_ring
>> fills up. This can occur when NAPI mode is enabled, though it's
>> relatively rare. However, with threaded NAPI - which we use in
>> production - the drops become significantly more frequent.
>
> It splats:
>
> [ 5319.025772][ C1] dump_stack_lvl (lib/dump_stack.c:123) 
> [ 5319.025786][ C1] lockdep_rcu_suspicious (kernel/locking/lockdep.c:6866) 
> [ 5319.025797][ C1] veth_xdp_rcv (drivers/net/veth.c:907 (discriminator 9)) 
> [ 5319.025850][ C1] veth_poll (drivers/net/veth.c:977)

I believe the way to silence this one is to use:

rcu_dereference_check(priv->peer, rcu_read_lock_bh_held());

instead of just rcu_dereference()

-Toke


