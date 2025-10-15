Return-Path: <netdev+bounces-229445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7276BDC58F
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 05:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3FAA3351E2B
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 03:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E6C271A71;
	Wed, 15 Oct 2025 03:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RdSVyHs2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB1C24BD04
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 03:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760499160; cv=none; b=KJuz+BJELZ03cjRgFwQZBHJTSt9cT41ahGvg9BBMd66khLevrWNHU22NOv6rw5XVeyFof7m2zOB2mwNoLhj6BVKj93FtxvJuTztJCo5FSo30oVIJkQDslme3lTFu0jlWAXVDyalcldfJh+WKBe+4GSnE1NaelEiJ8R3zdzV6rIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760499160; c=relaxed/simple;
	bh=Pz6nngEdfPUUO5xvQ/zWhuJRUfr2ha7g58JGlqumYAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlmWnsK1hSrP/WZzCiLaJDb9WUnl8EyCJdMVOHPzlKGY6HaffmcYDdt9Byb6GWu/pVOLF1dlaNzfGB2ph4mmnLCAuW2OlVTiGCnEYaz21Dn41XDoifN+kHyJiECWpgD6H5PAuMSWvHpJ6NlSHaf6D8w7rXv51tEIJsyRQOibjjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RdSVyHs2; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso3898283a12.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 20:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760499157; x=1761103957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hn+FugEl89PAJ/jo6uI9O6Ew3xgKbFJ9DgRqOoYyfr4=;
        b=RdSVyHs2cq04HykmFrwHmNZaZxPbsqK18wFfIJIJIg8HAEoqdSkTc4O1obMF8NcpIh
         EnRB+Unk4z0xIlhg+rR1rc9B8HanPEUNQ/JMYOhBQtUFpRJisW57vAglmEFBbK5+zuh8
         uuber3ChszA4srA9CQkcqMOqc/7hQPuLAgl8qzj96zTehMQFso4jmonAGh26o/U+yKXH
         3DhM0z7l9/rLrPt2Qr9cr97BeVTFmtb/S2ZUpQOtDftiVohmQ2uqJyHW49wtRk2srx1w
         VJiOn9AYIO0r7teJvke2xZO32nC3s/IL7xFQQW3UKrPn7DIwh/hva9B3w4SjUaCXg5cC
         L6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760499157; x=1761103957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hn+FugEl89PAJ/jo6uI9O6Ew3xgKbFJ9DgRqOoYyfr4=;
        b=h/knbH/N7jIx1X4z2UiY+IChDoYdR4HoENbEDYRq+5KpfNMUzawixTRxgFjpmR6aTD
         JVf2lvsPT2I5qHC5zYFQDEdrFS2+jpZ/s3popT2eYIPRJinzmWrC4B8QXeO8SF2DXvCx
         xyQPnmR2brSg0enaLRGfgU5Q91/Gg16G3BDLladVYnC3dCVIO6L5f3/QtrIA+b8g0I9w
         ZVCj2DRYgrPl7zC4RLv2/V03S3CRCyuzconuYMXlfqFAwwlVHO0DV62YMXetVb8hvpqK
         ivP80RAU1K3Nq0r3CrKpXcnQtn/0wQ1iVqNMbiY946gS9vDKy7jt/pC0kmk6q/+E3gME
         Gu9g==
X-Forwarded-Encrypted: i=1; AJvYcCX5ppRtwDYxnQmyeXMCV+i4l7th2sIUhRKsqwGo/qA5p0iwpX+AczYEw0tYrKKd3jvj6nebu1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9s3lNuLXK+GAei78o0eh+heCLL+5LPlG+I3ce3hvhYam/wUhE
	HzmHsT9+9YY96g67PLaz4DvKO0a7dOcl7pdnLH0+7TPLcvaHLDIFYG/gT5w7LX/mLNlRvh1ChGF
	OVLETvJXkgLxixN893kVWWf4BwNr0QzoXVnJECPc5
X-Gm-Gg: ASbGncsB79VRPT77IVQuxW20VxQ4c//T29Gu8gFhG18tYuGuLXMbxADbSLyxBbNAlLF
	0HloqckgvDJdnmKbRnNh7K+FkJK3QOyE5dsUQ8zarr5zKzxRr4xWDSxO4pGsdKwOCKfJN4rVT6D
	uSw8/gtnPxm4xQ9+ytVQgzbgNM2BoJZKLpG0NzrUJgMwnO6K8U14RGGUOdTSG1zrJfMiM/1xsb0
	6uhsXjFsVl4ICQOap9QzqkRf7ZMoQOztcyRex7GwGjN7aJX+YSyR/M4jmVO+BxP7Spk639CyGc=
X-Google-Smtp-Source: AGHT+IG0/+UHUfYVfe7gRzeMwx4QZHQVm5sQlY3riYJh0Y38oTn1O05miGuUVfmHNrFj2veLWx2PQIsyGzpLa3wuuIs=
X-Received: by 2002:a17:903:faf:b0:26a:ac66:ef3f with SMTP id
 d9443c01a7336-290272161e2mr295799995ad.8.1760499156996; Tue, 14 Oct 2025
 20:32:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013152234.842065-1-edumazet@google.com> <20251013152234.842065-3-edumazet@google.com>
In-Reply-To: <20251013152234.842065-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 14 Oct 2025 20:32:25 -0700
X-Gm-Features: AS18NWBtP2RQHHMuPg30YnQuCZigRkdvFm_88ergQQq-MpB95X7VjIF90A633ek
Message-ID: <CAAVpQUC+7GWuGxZa4=3k3XCNSuLddpZbhoeEmmpWe930jpycWA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 2/4] net: control skb->ooo_okay from skb_set_owner_w()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 8:22=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> 15 years after Tom Herbert added skb->ooo_okay, only TCP transport
> benefits from it.
>
> We can support other transports directly from skb_set_owner_w().
>
> If no other TX packet for this socket is in a host queue (qdisc, NIC queu=
e)
> there is no risk of self-inflicted reordering, we can set skb->ooo_okay.
>
> This allows netdev_pick_tx() to choose a TX queue based on XPS settings,
> instead of reusing the queue chosen at the time the first packet was sent
> for connected sockets.
>
> Tested:
>   500 concurrent UDP_RR connected UDP flows, host with 32 TX queues,
>   512 cpus, XPS setup.
>
>   super_netperf 500 -t UDP_RR -H <host> -l 1000 -- -r 100,100 -Nn &
>
> This patch saves between 10% and 20% of cycles, depending on how
> process scheduler migrates threads among cpus.
>
> Using following bpftrace script, we can see the effect on Qdisc/NIC tx qu=
eues
> being better used (less cache line misses).
>
> bpftrace -e '
> k:__dev_queue_xmit { @start[cpu] =3D nsecs; }
> kr:__dev_queue_xmit {
>  if (@start[cpu]) {
>     $delay =3D nsecs - @start[cpu];
>     delete(@start[cpu]);
>     @__dev_queue_xmit_ns =3D hist($delay);
>  }
> }
> END { clear(@start); }'
>
> Before:
> @__dev_queue_xmit_ns:
> [128, 256)             6 |                                               =
     |
> [256, 512)        116283 |                                               =
     |
> [512, 1K)        1888205 |@@@@@@@@@@@                                    =
     |
> [1K, 2K)         8106167 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@    |
> [2K, 4K)         8699293 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
> [4K, 8K)         2600676 |@@@@@@@@@@@@@@@                                =
     |
> [8K, 16K)         721688 |@@@@                                           =
     |
> [16K, 32K)        122995 |                                               =
     |
> [32K, 64K)         10639 |                                               =
     |
> [64K, 128K)          119 |                                               =
     |
> [128K, 256K)           1 |                                               =
     |
>
> After:
> @__dev_queue_xmit_ns:
> [128, 256)             3 |                                               =
     |
> [256, 512)        651112 |@@                                             =
     |
> [512, 1K)        8109938 |@@@@@@@@@@@@@@@@@@@@@@@@@@                     =
     |
> [1K, 2K)        16081031 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
> [2K, 4K)         2411692 |@@@@@@@                                        =
     |
> [4K, 8K)           98994 |                                               =
     |
> [8K, 16K)           1536 |                                               =
     |
> [16K, 32K)           587 |                                               =
     |
> [32K, 64K)             2 |                                               =
     |
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Neal Cardwell <ncardwell@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

