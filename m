Return-Path: <netdev+bounces-242211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC68EC8D8E2
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 261C64E5D07
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 09:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F4A329C4A;
	Thu, 27 Nov 2025 09:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmA5OWiJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVTvFOrx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FCC324B27
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764235866; cv=none; b=XyYRfwr9SAYd/dRdkBrcX2R/BaAyFQCLHEm1wSjHVopG6J27LKQNmoVI2NB+wV5MuZE4mv0nk/EVADz51nx9yvKBFlq1Sxl9QM/FDwbbH4Q3StN653EmVf66KjpyI0gcSEve6TRGnXL4961cvOuVr0Itp3KSSaD/qaoK2CeQKo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764235866; c=relaxed/simple;
	bh=SoK0mN/1Rz8m3zAXsa1O8OZoBKDy93kst2eL8y6Wrps=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UYRPPKka5MAMnAlDMMmbl7CN3C/joMzVXTHcV/fKA4vrlbQWHHbo53FjdYrxpf8wN6HtxCeynhXiS7EkdVnszNNEpkQTrm/bukPk26UbPEKdLrO4Ri2h7MWU7T3rsTHpiL6H/NsS038bJPNXOos5wLNPvAif+BRBm8w6W+aMuS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GmA5OWiJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVTvFOrx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764235863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E60FusnjaWKyDTcqd2Ucw8i35mzOSjUwjHju705sQz8=;
	b=GmA5OWiJwYbfCQahpiVoLWGC3faPUf0itDsiJUHGNXwYQc6U13pCHb9M9DRxQy1bUxqzjg
	VdkcPGTmJ5ZMs/NigRsd3geFR3CI6Mogu7zdduUWZzaH2ZXHBAUWak5cgsmQibX0awj7iB
	EbE4Dza1VlkT81OSkCDbcgbROIKwv5o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-GvVjbkuXP-KcEvUR9wCxGQ-1; Thu, 27 Nov 2025 04:31:01 -0500
X-MC-Unique: GvVjbkuXP-KcEvUR9wCxGQ-1
X-Mimecast-MFC-AGG-ID: GvVjbkuXP-KcEvUR9wCxGQ_1764235860
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b70b21e6cdbso146353666b.1
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 01:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764235860; x=1764840660; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E60FusnjaWKyDTcqd2Ucw8i35mzOSjUwjHju705sQz8=;
        b=eVTvFOrxw6vWPc2yQ6PcIEaK56U/KuubpUa22LyLEpHq6wKvcEk0iQxQdc+XE8yESO
         5WMugTCxpEQK5PdhGG/WCjlTgsaewoHTgkCtfXMOl1R/Ik/eA7lGXp4i+CDJcAj4wOTw
         sJJWV8AhgXDu2clLaLljoes59aIqK8pk3+OVeMSrWYjZxQ8vr9TzDWtuOS8qLoNaF2VP
         NTwLtFrCbHiSj5YjmnCUe+l/Quvaa3fU9BuOIJZ4xsULderS1UJDAvw+ArmzlLZgVgld
         KaZme8Iqh4wTPRl+98bQ1gVVzqwzcHktuIjZHQnMSHuBmxOKhLz6p/eADOxzItDxVO2E
         lXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764235860; x=1764840660;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E60FusnjaWKyDTcqd2Ucw8i35mzOSjUwjHju705sQz8=;
        b=uUVM6JKth35IihAbjp34UVqGoI2qkaafOTp4NwviShYBCpjyU6pgruOigUOa6ITSAt
         EsT14jbrO2+66Uq79kV0i8C8YkJl0G3/o5fR+dOLFQsTz9LJgsUB578jENmL5VmrYC5A
         kLL0jPXKmtrn7eEkZ4lGRZmsKzHhesNE5zgikQNAwXI01cQsF9+0j+h12uzdvqLoQiis
         xyvbO9/HNOSXCsf+6LT032xfBoZolK9IaJPApadEVCi8XjuUoojCLO3S96i9rp38ZD/a
         q57Mha7tl75a48nXvyW2RWCJYzqZNdrgANupkDB9mhZuT53GuRRWlBE09OswEoHPvRbK
         tvMA==
X-Forwarded-Encrypted: i=1; AJvYcCWqoXIYDqNiIbiDhkAlb1SVjExjRrfWXEo3OFCRUViEhvslc4XDoODI6/HOqfY1Bk9BStc0tl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrmy1g2yaDbMhabvU9zjivgQrKc5L/mdl/mCTBLm1dpi9GGe36
	ggZAY4PHiOy105fhZ9+N/4WPPZrOm8Sb545OeynOeG+Bj+gddUsr+jxTe49bp1H/z6BTVsaLjRV
	VNR7ZV5RVCb2ZPg1AaZrhfJxAaG26da1azFXizUJxUdiO8Lii1as6VF6QNg==
X-Gm-Gg: ASbGncuK5a3564vBPAM8MruTDkGqPiLnpIu21Xv6PCLVCdcwzxZzhAVSnIHORvb4rhO
	TN2s/8zHx99gY+0Lku6edcKY1cKl1E80Vl6I/YqZd49AvEhbK+v2rLIXdtolUWpbEoD79P7cEB5
	CTJ31Y0BE+6OJvw1fTMSddz1wQuDcEub7XhKWeOjRBu4fvn7P8h2YIPRelUUpcEC9g/jonbualZ
	27B+M6gvtxVc6CA+0YGmR0d2pEJ30r7WfXxDp+5R0kkOIevzivD0Y5GeIbQaZkZC2qBrP86poLZ
	PteHLtwPWTNvKWIT9mS4IFaR/SDiV8z6SlI3xXR5+H5uqtORK7nAphxhCj3wciK0a0Os0sYIN1L
	KbJRNxOrfcjaCYQBBexnzczLDzsJYDgG3lA==
X-Received: by 2002:a17:907:3da4:b0:b70:aebe:2ef7 with SMTP id a640c23a62f3a-b765728545fmr3170283966b.14.1764235860288;
        Thu, 27 Nov 2025 01:31:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3sUvqhruznd5pnch2PwROt4cOlY0ITalJQcsHWtNSDozz8sbyEsacuL0sZIlWxjjx48+meQ==
X-Received: by 2002:a17:907:3da4:b0:b70:aebe:2ef7 with SMTP id a640c23a62f3a-b765728545fmr3170280466b.14.1764235859822;
        Thu, 27 Nov 2025 01:30:59 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59aecbdsm105044266b.38.2025.11.27.01.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 01:30:58 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4076A3956FF; Thu, 27 Nov 2025 10:30:57 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v2 0/4] Multi-queue aware sch_cake
Date: Thu, 27 Nov 2025 10:30:50 +0100
Message-Id: <20251127-mq-cake-sub-qdisc-v2-0-24d9ead047b9@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEoaKGkC/3XNQQrCMBAF0KuUrB1JxlZaV4LgAdyKizSZ2CBNb
 RJLpfTuhgqCoMvPn/9mYoG8pcB22cQ8DTbYzqWAq4ypRrorgdUpM+RY8IojtD0oeSMIjxp6bYM
 CpQ2vi0qjoYKl3d2TseNinpmjCI7GyC6paWyInX8uz07Hw3LwhjH/AQ8COOQbybdcCyFQ7j3pR
 sa16trFG8SHSPVfQqIxQss6L0vzRczz/AL4H//WAQEAAA==
X-Change-ID: 20250902-mq-cake-sub-qdisc-cdf0b59d2fe5
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.3

This series adds a multi-queue aware variant of the sch_cake scheduler,
called 'cake_mq'. Using this makes it possible to scale the rate shaper
of sch_cake across multiple CPUs, while still enforcing a single global
rate on the interface.

The approach taken in this patch series is to implement a separate qdisc
called 'cake_mq', which is based on the existing 'mq' qdisc, but differs
in a couple of aspects:

- It will always install a cake instance on each hardware queue (instead
  of using the default qdisc for each queue like 'mq' does).

- The cake instances on the queues will share their configuration, which
  can only be modified through the parent cake_mq instance.

Doing things this way does incur a bit of code duplication (reusing the
'mq' qdisc code), but it simplifies user configuration by centralising
all configuration through the cake_mq qdisc (which also serves as an
obvious way of opting into the multi-queue aware behaviour). The cake_mq
qdisc takes all the same configuration parameters as the cake qdisc.

An earlier version of this work was presented at this year's Netdevconf:
https://netdevconf.info/0x19/sessions/talk/mq-cake-scaling-software-rate-limiting-across-cpu-cores.html

The patch series is structured as follows:

- Patch 1 factors out the sch_cake configuration variables into a
  separate struct that can be shared between instances.

- Patch 2 adds the basic cake_mq qdisc, based on the mq code

- Patch 3 adds configuration sharing across the cake instances installed
  under cake_mq

- Patch 4 adds the shared shaper state that enables the multi-core rate
  shaping

A patch to iproute2 to make it aware of the cake_mq qdisc is included as
a separate patch as part of this series.

---
Changes since RFC:

- Drop the sync_time parameter for now and always use the 200 us value.
  We are planning to explore auto-configuration of the sync time, so
  this is to avoid committing to a UAPI. If needed, a parameter can be
  added back later.
- Keep the tc yaml spec in sync with the new stats member
- Rebase on net-next
- Link to RFC: https://lore.kernel.org/r/20250924-mq-cake-sub-qdisc-v1-0-43a060d1112a@redhat.com

---
Changes in v2:
- Rebase on top of net-next, incorporating Eric's changes
- Link to v1: https://lore.kernel.org/r/20251124-mq-cake-sub-qdisc-v1-0-a2ff1dab488f@redhat.com

---
Jonas Köppeler (1):
      net/sched: sch_cake: share shaper state across sub-instances of cake_mq

Toke Høiland-Jørgensen (3):
      net/sched: sch_cake: Factor out config variables into separate struct
      net/sched: sch_cake: Add cake_mq qdisc for using cake on mq devices
      net/sched: sch_cake: Share config across cake_mq sub-qdiscs

 Documentation/netlink/specs/tc.yaml |   3 +
 include/uapi/linux/pkt_sched.h      |   1 +
 net/sched/sch_cake.c                | 623 ++++++++++++++++++++++++++++--------
 3 files changed, 502 insertions(+), 125 deletions(-)
---
base-commit: f93505f35745637b6d94efe8effa97ef26819784
change-id: 20250902-mq-cake-sub-qdisc-cdf0b59d2fe5


