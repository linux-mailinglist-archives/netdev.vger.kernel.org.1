Return-Path: <netdev+bounces-247036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF6ECF3A80
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 13:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9493E31A53FA
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD7F2A1AA;
	Mon,  5 Jan 2026 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Am3cTtOl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9K4ceqM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6033A1E72
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767617500; cv=none; b=DkCVH0E8+KJ+zqa3EFb+bviNTC6q5nAQRmlaAr7uSpHW/kR7b2yVNAXeSySrNiQVC/M5qnU7nSCju/0W910NW1+k9GJnbgZFR7Lbt02VaSNEj8R/mLda9qnh/2rF4ci0jcssZPfnFF5LzIm5wuP22gqVky3ARjQtAzoObtw5VJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767617500; c=relaxed/simple;
	bh=CfYJPpmLiHgDewB0386a6fS+TJoZfSOhGJwLKTfRoMI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qJwMwoHvvfkOSbW3YLVuFnxRg9V2NUxessdUmy3u9jFjVeXxmc0aBWjEXhTR0dbp7C7pD7tfznpIRR+bb1Z9/cAD9twMbBb9s0ZIngg8FhgIhJvZdzdItkxmbLBIpSBUJJS3aNDGTIvUDhA25VXy7juWeUD8DTwU5gfbUYSDrXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Am3cTtOl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9K4ceqM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767617496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2f+IxNsBv6GF8BavhEiE3pDkZUej2rfCK4D7VugLdIA=;
	b=Am3cTtOlKeKmlh01wiLIPXagnWwJyDd1N3t9xRBlsLpZNA7NeT3DaCHmEiffBgf8EB9lc8
	pQC1XxS3cm610zzZqII52MGm2SVOUKNmuFaMBl/YN1R0cTq+AXxV8v214SJTwGV6p55lr1
	gLFAIb5mp0ZVJEemLXl5uiMx8Vt49Do=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-X7ZaScaxMv-Db9bqjy5SwQ-1; Mon, 05 Jan 2026 07:51:35 -0500
X-MC-Unique: X7ZaScaxMv-Db9bqjy5SwQ-1
X-Mimecast-MFC-AGG-ID: X7ZaScaxMv-Db9bqjy5SwQ_1767617494
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b7ff8a27466so1509596166b.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 04:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767617494; x=1768222294; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2f+IxNsBv6GF8BavhEiE3pDkZUej2rfCK4D7VugLdIA=;
        b=g9K4ceqMpwTfQujFYFUqfKVnHnQg8P5wfrZGfyPxrAxF3RTXcmRsKneDDrjRqQHKgi
         UdOAv+L/O0hfcWwS9TwH/W2xdgjUuEwi9oZBEimYg6OfF1uYRS/77S+FfZSu7iOryAYE
         nzc/fs8CEXQnfH13wCdSl7aNXcZqiL0hXAWaQJ7CDL3w6mzBGk8pSIXCaA9dmWuURWnL
         UD8U7tD2R2Dw/wH2mKpO8Kj4ykxfcfV+JW/zSyvSbf/ulneel9C6Jg6/1zXF9R14B9r5
         k9CJ1csfX0MaQIajCEhvCctVGIrCd5B7P8qPCi3RXvPxCxKywyRgKB4CIKNQyB+mmrM3
         FAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767617494; x=1768222294;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2f+IxNsBv6GF8BavhEiE3pDkZUej2rfCK4D7VugLdIA=;
        b=HDa22RpfNZjgBP059MB1C6Rr9GKZ2vN/Z3YrrawmOLhZUR3VQNh79lheZb6xzHsaim
         P88e9lTKIs3jluqRsCkgNcz2uE/hXl31huXRtGJdDchwjIixRa+zr5SdrI6cLDBFMBtw
         hAZPcFXcVJ/SnxN+j5OLWbIirHOhukF6aWATWtKYxv2W3YNFeGp6AiNHs5yxyT5TMlu2
         1rtE/K7E5qr/rYEOb01zs2i2QYaYRaLvcK0S7KkFvDg91c82e7oSfDJ91CzxXPLPjte3
         tj48/wELr4HNKWCx1JITW6bwgE+eZxBPGVDcJJ6t5vs05r//ktlY9QW6DBQo+UkC2ndM
         ihYw==
X-Forwarded-Encrypted: i=1; AJvYcCX/NTL0Hkskvzluch2nQQEaBAa7aFpNT1grTPCtb6xNe25o860yaj6WxQIzRJ1f0gr+U1ikeC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTpflt0wSzqCd6vdB/weHvAGPETR7bsvnMbd5Meqk73QGlZXqx
	4k+IkzQcim8ArpDyfupn5m708gHMOA9zjMMEg4CXyoi41kZguJD5iJQaeWKEWQrqaIduHsUYEQ3
	a5/WEUqvCnFXhjP1Rl9Q/jIlhMkEIdCfZDPcc45W2z3a55dh6d/RZVkF+1w==
X-Gm-Gg: AY/fxX5CtKGSGpGrYJ4Xp3PSey8UXZBF5M8E9PUbC0tLQHv7euPxkm8cy4OD9o8f+6R
	9UuC9TxYMlOJjhouYweIPlu4Zs0jwFd5NeKBsfEwbtTMOXekeQUUJEAxPXJ/qg+Xz7LOPXBVf3x
	wohVFR6soS6gi1ceG51izfOpRVpn5PZqYMCxeTetCLoFAUI00sIOAZkZ+8gyXGnwInm/337sY93
	ipKOhslfHIuTVQ30ZIlKdTWfZUlZUx8LHTYU7E4yjI2NIlHKid2X3+Ogn1IE6r5q2Ux83kzEuNv
	NM3Pnun3eOyV4tbqoogHk/0GJtgVctqxRL9VclXOgLi/BoxgX7aR9MAPU8jCpjADmPlJxBGyPRO
	kfoCYvVbvQviYBnXAXNpyShPpOUNeGJIymg==
X-Received: by 2002:a17:907:6d22:b0:b76:5b73:75fb with SMTP id a640c23a62f3a-b8036ecdbfcmr4716230166b.9.1767617494331;
        Mon, 05 Jan 2026 04:51:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGQaDgovpm3y4b84zzxWCz5fqFjPqL08nJtmfqDzDLr+2uiepGtSoWowtpBmQT2d7vIE4WOg==
X-Received: by 2002:a17:907:6d22:b0:b76:5b73:75fb with SMTP id a640c23a62f3a-b8036ecdbfcmr4716227266b.9.1767617493818;
        Mon, 05 Jan 2026 04:51:33 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b838d3f12f6sm2330257466b.62.2026.01.05.04.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:51:33 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 44692407E8D; Mon, 05 Jan 2026 13:51:32 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v5 0/6] Multi-queue aware sch_cake
Date: Mon, 05 Jan 2026 13:50:25 +0100
Message-Id: <20260105-mq-cake-sub-qdisc-v5-0-8a99b9db05e6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJGzW2kC/3XNwUrEMBAG4FdZcjYymSTd1pMg+ABexUOamdiwb
 OsmtawsfXdjBV1pPf78839zEZlT5CzudheReIo5Dn0J9mYnfOf6V5aRShYIaKEBlMeT9O7AMr+
 38kQxe+kpQGsbwsBWlN1b4hDPi/kseh5lz+dRvJSmi3kc0sfy7OnxYTn4htFswJOSII12UAEpp
 dDdJ6bOjbd+OC7epH6IUv9LOAxBkWtNXYcVgdfEfovAQqChhh2B2bfNitBXhIYtQhfChqry1tT
 sya8I80sgqC3CfBFApFEpp3z1h5jn+RO9coU/ygEAAA==
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

A patch to iproute2 to make it aware of the cake_mq qdisc will be
submitted separately.

---
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
 include/net/sch_priv.h                             |  27 +
 include/uapi/linux/pkt_sched.h                     |   1 +
 net/sched/sch_cake.c                               | 514 ++++++++++++++-----
 net/sched/sch_mq.c                                 |  71 ++-
 .../tc-testing/tc-tests/qdiscs/cake_mq.json        | 557 +++++++++++++++++++++
 6 files changed, 1015 insertions(+), 158 deletions(-)
---
base-commit: c303e8b86d9dbd6868f5216272973292f7f3b7f1
change-id: 20250902-mq-cake-sub-qdisc-cdf0b59d2fe5


