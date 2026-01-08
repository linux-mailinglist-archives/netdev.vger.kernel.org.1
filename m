Return-Path: <netdev+bounces-248182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 185F1D0535B
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 18:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 348933258F35
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8352DF3EA;
	Thu,  8 Jan 2026 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvb9MbgX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZnmUW5JS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D998D2E0901
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891484; cv=none; b=sbZAfVlvFH5Rv9SyxILEC9C6HRuDEDFCk3LpqYr5BvqCpFUUO71G5ZZawgCvjcfbEa9JwfD+k/3IAFpyOi3bIoBTdDmlmfalqPHUkppe1/Iyk68DTvL/0E3/yBvi9lm2FqBidTA3j1bNbusC1cIuy7K9fYzsRz+IRUXzqzyaNqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891484; c=relaxed/simple;
	bh=2kkh1HTmGOanA54h30MjycXWgO8nn18K7F0xkeq1RXU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sNYVItQYMB+r6CCq12U4/+Ti0Dl1gHZHEYmBYCmhyW7AljXz19qLWS10F0PEByCqypG77EzwzSshhn8OinuvjAhA7NW1ire2BsDzqfujirvdHULjvHp4r7kiq0PPJn8J4DL9sUqfD6mOD0vweHYBoSctsZ6pYJlTj328oNExg2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gvb9MbgX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZnmUW5JS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767891477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FjS4feJSaN6kOmYKqAI8LPvPwfc7zrDjsTbRox8HRnQ=;
	b=gvb9MbgX5lqd24OOwyRz8OPeIb6Tut3FcqAk2f2vZhhjxyz8ucdEq8ZEI88kuvH6ZSE8nL
	hX0Q9qdnSxT7BpqRiA7D4dUXxqdw3b1agWmsdduTEncY5i3wkremO+yuCcU/y52PQnzRQg
	y8WFAbBFINX5di1PPVvaKGOraHFL7n4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-uovK53Y-N0q7m2IpvjxGZg-1; Thu, 08 Jan 2026 11:57:56 -0500
X-MC-Unique: uovK53Y-N0q7m2IpvjxGZg-1
X-Mimecast-MFC-AGG-ID: uovK53Y-N0q7m2IpvjxGZg_1767891475
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b801784f406so424048666b.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 08:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767891474; x=1768496274; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FjS4feJSaN6kOmYKqAI8LPvPwfc7zrDjsTbRox8HRnQ=;
        b=ZnmUW5JSIa8Zu6Y6dfgtuusJQ7qOKrcGeMOIQ7RTM3i129VNUAOubiLnmuYkfHv7y4
         sfxTy0Xg8CZOD03hBHTxfK+mL/9PbiMj2dBtO2nU5P3Yop8NtSWQZ2cbIJq9li3G4LR5
         DvWpP/8eN+FNhZjoaWJNg1XLbmCiDzqal+WM7cxPcR2cbovECq3W1BCBnLwqOixWmj9A
         itvIEtcQXAGhkxpYBxSAZOzFhzcDHLpFHYRI8q/NXguMMEqI0XYguUPQH9SXk06qgOj/
         Lm9W8kZrOnnD7OK6XtkBl+bYJYHmmF3kkaNfcrHAHK6nJB9wPVTPtIyVIG+vH+ecR8Dv
         kCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767891474; x=1768496274;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjS4feJSaN6kOmYKqAI8LPvPwfc7zrDjsTbRox8HRnQ=;
        b=Yuv0EmAvJMBPjiQMS0qAOBN92w757/h3cxCw2qcdVWQ/0bPIbXfkgUgnZce38HjPUb
         bLLVk7cFPBgwlECAEPF7f1NhkKdOggRLE3fcSzFhLttUfRWCt1Gbpm20ZKC0zK62dPFZ
         lV1IsFOOG0P0TinhjE4EJy9+X1xRfgVdbkLaxKrxpxxn3faDYgTA/HriPe4a59xeWIkY
         vq5o4t8dXMK/OE1SqyVYcilwBe3lQpUrZ9u9cXGPkA1GA1zFcF2o4p5F1wSF0BHoflSD
         8qn2/4hhrtWNM47ll05vF4towO3NevVVL9gvE6rqLKJ5sCYG9hNfFw2kE9k27UFg1Rcn
         gVqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTYFLkInWVhvzoDJfNZFNaO6nPZIxHzKico7t9GVqUyMQLAXQ+Ga8tyAaf6immW9hJVvkBIq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXDbKrSTHYiOc29CBFwatZCrg1OVXpmtGzV1mc/7S9Xjo4O/V0
	xiefP641KSNmRn6f/1EkQIXN6rPaOHOLMWZcnKdSom9D0m4m/9FADD4Gt6iQ6m/eSGn8K7AM6rp
	avq99pu/7eX+qBgE5ocNlWgTOkxyOKyYVd9CsufdmVLhr3bKhAarlgp8GvkfUvrhM0w==
X-Gm-Gg: AY/fxX7u8PVCGgFNy0Ucv3tP2LKAB6jhLmq2q9TwdlnP5qvWQSxy9QC/tewzkrLCOwt
	0Hiqhf2vWkhFHF8fARYzDbEvNk932KQopZ4F8cwMmha88BWfXhKBsdWyWfKfom7QiSDmzUxFn5C
	C2xD49OhwsSSf/eyCU6NVTfdlKHBPxcyVHY7l6CYmE5LBES1dQyZIuUP/WkEdVHHxmY2V3Oi/DC
	Yz5rmL1Eox/yBvJQiZfPdQ16Noy41AeirXrqNe/XMbJXEnjBk6PabRqLPU8pKPyRic6crU12H6G
	HJVHKzhxcjEP9AZfgXBM/Ba5PhUzuyAoT5M+Uh7ZXe+i5Xb+NPBfkfdy3YvytQICvwgAg2HXXW6
	cS0M3c5yFpCbRznANKaeKzI4doKOYIqaDHA==
X-Received: by 2002:a17:907:2d88:b0:b7a:1be1:984 with SMTP id a640c23a62f3a-b84453f2266mr608595666b.64.1767891474324;
        Thu, 08 Jan 2026 08:57:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFWJVAHTUWbZTy1KF6VR+6h/Us1UzmfRaGVZweCOKnOEbb1/ZVYwDxcy96zyzkUcNJkGt4QQ==
X-Received: by 2002:a17:907:2d88:b0:b7a:1be1:984 with SMTP id a640c23a62f3a-b84453f2266mr608593666b.64.1767891473839;
        Thu, 08 Jan 2026 08:57:53 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4d029bsm869145066b.41.2026.01.08.08.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 08:57:53 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C38E64083B9; Thu, 08 Jan 2026 17:57:52 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v7 0/6] Multi-queue aware sch_cake
Date: Thu, 08 Jan 2026 17:56:02 +0100
Message-Id: <20260108-mq-cake-sub-qdisc-v7-0-4eb645f0419c@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKLhX2kC/3XRwU7DMAwG4FeZcibIdpOs4YSExANwRRyS2GERW
 sfaMg1Ne3dCETDUcvz1258PPqlB+iKDulmdVC+HMpRdV8P6aqXSJnTPogvXrAjIggfS271O4UX
 08Bb1nsuQdOIM0XqmLFbVvddecjlO5qPqZNSdHEf1VJtNGcZd/z4de7i/mwa+YDIL8AE1aNMEc
 MCISOG2F96E8TrttpN3wB+i1v8SgXJGDtG0bZ4RdEmslwiqBBn2EhjMOvoZ0VwQDSwRTSVsdi5
 Z00riNCPML0GAS4T5JIC5IcSAyc0I+004QLBLhK1EG7yPniNYmRPuknBLhKuECAm4iBLx70fO5
 /MHcmeJO1ACAAA=
X-Change-ID: 20250902-mq-cake-sub-qdisc-cdf0b59d2fe5
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 Victor Nogueira <victor@mojatatu.com>
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

Doing things this way simplifies user configuration by centralising
all configuration through the cake_mq qdisc (which also serves as an
obvious way of opting into the multi-queue aware behaviour). The cake_mq
qdisc takes all the same configuration parameters as the cake qdisc.

An earlier version of this work was presented at this year's Netdevconf:
https://netdevconf.info/0x19/sessions/talk/mq-cake-scaling-software-rate-limiting-across-cpu-cores.html

The patch series is structured as follows:

- Patch 1 exports the mq qdisc functions for reuse.

- Patch 2 factors out the sch_cake configuration variables into a
  separate struct that can be shared between instances.

- Patch 3 adds the basic cake_mq qdisc, reusing the exported mq code

- Patch 4 adds configuration sharing across the cake instances installed
  under cake_mq

- Patch 5 adds the shared shaper state that enables the multi-core rate
  shaping

- Patch 6 adds selftests for cake_mq

A patch to iproute2 to make it aware of the cake_mq qdisc were submitted
separately with a previous patch version:

https://lore.kernel.org/r/20260105162902.1432940-1-toke@redhat.com

---
Changes in v7:
- Use kzalloc() instead of kvcalloc(1, ...)
- Add missing SoB to last patch
- Add new include/linux/sch_priv.h header file to MAINTAINERS entry for TC
- Link to v6: https://lore.kernel.org/r/20260106-mq-cake-sub-qdisc-v6-0-ee2e06b1eb1a@redhat.com

Changes in v6:
- Add missing teardown command in last selftest
- Link to v5: https://lore.kernel.org/r/20260105-mq-cake-sub-qdisc-v5-0-8a99b9db05e6@redhat.com

Changes in v5:
- Disallow using autorate-ingress with cake_mq
- Lock each child in cake_mq_change() instead of the parent
- Move mq exports into its own header file and export them with EXPORT_SYMBOL_NS_GPL
- Add selftests
- Link to v4: https://lore.kernel.org/r/20251201-mq-cake-sub-qdisc-v4-0-50dd3211a1c6@redhat.com

Changes in v4:
- A bunch of bot nits:
 - Fix null pointer deref in cake_destroy()
 - Unwind qdisc registration on failure
 - Use rcu_dereference() instead of rtnl_dereference() in data path
 - Use WRITE_ONCE() for q->last_active
 - Store num_active_qs to stats value after computing it
- Link to v3: https://lore.kernel.org/r/20251130-mq-cake-sub-qdisc-v3-0-5f66c548ecdc@redhat.com

Changes in v3:
- Export the functions from sch_mq and reuse them instead of copy-pasting
- Dropped Jamal's reviewed-by on the patches that changed due to the above
- Fixed a crash if cake_mq_init is called with a NULL opt parameter
- Link to v2: https://lore.kernel.org/r/20251127-mq-cake-sub-qdisc-v2-0-24d9ead047b9@redhat.com

Changes in v2:
- Rebase on top of net-next, incorporating Eric's changes
- Link to v1: https://lore.kernel.org/r/20251124-mq-cake-sub-qdisc-v1-0-a2ff1dab488f@redhat.com

Changes in v1 (since RFC):
- Drop the sync_time parameter for now and always use the 200 us value.
  We are planning to explore auto-configuration of the sync time, so
  this is to avoid committing to a UAPI. If needed, a parameter can be
  added back later.
- Keep the tc yaml spec in sync with the new stats member
- Rebase on net-next
- Link to RFC: https://lore.kernel.org/r/20250924-mq-cake-sub-qdisc-v1-0-43a060d1112a@redhat.com

---
Jonas Köppeler (2):
      net/sched: sch_cake: share shaper state across sub-instances of cake_mq
      selftests/tc-testing: add selftests for cake_mq qdisc

Toke Høiland-Jørgensen (4):
      net/sched: Export mq functions for reuse
      net/sched: sch_cake: Factor out config variables into separate struct
      net/sched: sch_cake: Add cake_mq qdisc for using cake on mq devices
      net/sched: sch_cake: Share config across cake_mq sub-qdiscs

 Documentation/netlink/specs/tc.yaml                |   3 +
 MAINTAINERS                                        |   1 +
 include/net/sch_priv.h                             |  27 +
 include/uapi/linux/pkt_sched.h                     |   1 +
 net/sched/sch_cake.c                               | 514 ++++++++++++++-----
 net/sched/sch_mq.c                                 |  71 ++-
 .../tc-testing/tc-tests/qdiscs/cake_mq.json        | 559 +++++++++++++++++++++
 7 files changed, 1018 insertions(+), 158 deletions(-)
---
base-commit: 76de4e1594b7dfacba549e9db60585811f45dbe5
change-id: 20250902-mq-cake-sub-qdisc-cdf0b59d2fe5


