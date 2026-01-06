Return-Path: <netdev+bounces-247347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25796CF8211
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 12:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E2C630B0894
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 11:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF85333737;
	Tue,  6 Jan 2026 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTeR5D6p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uHI825VJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7C0332ED8
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699667; cv=none; b=N6b2RcF9DXc4++Rvviuvd/KXgwNfkf5bVcarsrfXsfHZhqK32VSsJRS1TuLippIgYZpRajAX2bzN8l7BTYcl7UNoviFxi2YDXOYKyeQmMs9vALzaJn55Ay7bCpMhso97KpPJ0tyHlTfjQI7r6mlXYBp00ABuiWphATlu0A31QXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699667; c=relaxed/simple;
	bh=YqExRHV40/gsBsdef5AH4nev+mbECdaVPz6aukj58Ts=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=vECD6GCVgWSxhU6rNvsIA9Xflvls2ycfJlf9NGXwKsauaj8aFpNTEYkrT+Hrccmm0nhDoxQcmFYVScrtJKG1opjlpTFLyrxdKI8hqD98X4rJEQk9d0mtcy7xIUeKh38i/E6Kc0yK4p6Jl//SC1CAOAbeQNA2LAgDzbuOokP11fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hTeR5D6p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uHI825VJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767699663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pZWlNkkO0n9yVY4xFn+ub+kByruEzCdu/5otM2kzl2s=;
	b=hTeR5D6pTR7AwS0003sFMuhE6NNcuaabXCKx9qSjHnaJJjdH6Xdpa21o3hRfYk9pWcza2z
	YoDSjzOmPudxaMyiFIXrmEFmhV0LM6YHw8Lrvp2mkrTAV9nsIOLcjuUHTDNNrVakm4WDMJ
	fIa74dY0p5XojHb1AiWpWlEkFZP4A4A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-vCDFeYYCNjqW6L4_nmce_Q-1; Tue, 06 Jan 2026 06:41:02 -0500
X-MC-Unique: vCDFeYYCNjqW6L4_nmce_Q-1
X-Mimecast-MFC-AGG-ID: vCDFeYYCNjqW6L4_nmce_Q_1767699661
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b8395caeb26so126899066b.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 03:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767699661; x=1768304461; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pZWlNkkO0n9yVY4xFn+ub+kByruEzCdu/5otM2kzl2s=;
        b=uHI825VJDNLNN1wumAyaZa94eYri8pKwVlKm0RhKEt+Wa6v+63ywxNcpNk+Wmm9JzS
         nacoLWH3SI3evesibdfe4Ak8b6d484J15b5adle/OwCcKkEIlgsKAdqqxL7BX16+5s9r
         PN/hEWTMgamZLLtyVC9svJvfDm4BRIKTLHREpWz4yULUSTbqKTJ6X8H5u5BaRF8leCjz
         fDGfEge3yY+JPZ6Jpv1G5GpTMHPSnp+YjYRkXVkLv6DIUXLIq3rgcbXcAXG1gRQ6/wFi
         WQkTtlcvuT83ADAIImrCkLYeqmRC/6MzoWLmQt50nYaQsOvNJK4csXQcmshqC/09beZc
         os8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699661; x=1768304461;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZWlNkkO0n9yVY4xFn+ub+kByruEzCdu/5otM2kzl2s=;
        b=AXdWv2Rc9A/TNuJHoLNzTqFAIYhBwx2gBISDiQw/DFyVzCYsL8YdlWEK+v46QQbC5R
         G9/ci1KvDQiaouboYNzjDPEB5QnF5TuBc54FiEDus6SHTMzsrfcnCVfuKB2fWwXQ+yKP
         rNMCg152EknyEX2x/2vjAbHYBY809rGOxNgaEdZPg9oXEhCSYOL8eL8+kLBm/XOY9Ncf
         7JdL+niJZuGl5iio8suICQZL579+2lvY1krRZX5VB42PiO2b+0TFW0+3B8Vg9oHC/HJ/
         4/UzY48Mb46GQFej9doio6hc+6rgxnWCjlm7jXGasRq1yaD9Ot2CK1pngj4stx+HYzP7
         TC/g==
X-Forwarded-Encrypted: i=1; AJvYcCUsj8M9P0CJbkbEdYsaHeJYA7Row+pUhijt94KWrCycLW2u5dZelzukjGvJ/WAKilneiT5W7ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0et+OW7HtO72hBhGihm+HTtgcehG2VlIEcPB/yMTGiKFlCJNK
	fHBxyBa3CtvWZd/8c1pHiHjmb8KEaQSMVW15YO0wQxmh6xLiwgg16ytjBCd0VBiv5WXsuGYyPsz
	VGKy4AvDbt/UfPjGTFhUXhC4yOP7Dc8hqLuppTMprJ6vosUVQbGNo8K6GHQ==
X-Gm-Gg: AY/fxX4WzPTVGLH9hYo+YaOR0bWCJJ9Kucly1e3QK3FgBMijt+Ximl7Fb04KmcQuojZ
	XWTeodJtz3l3vMV5ToXF+f5H6pqY5Lv48EGdrh/D0FgJIDE6KzCZDGNKJ4xc163/NK0/nvMm4Sp
	mQFcGmPAaL2H1YJ8VeOVxycAMwgjEYqzFYAwU66o0mAV9gf1U4kQRve9ukclOFknRTs+QL00sBP
	4F3Ys6/RJLXv3znuqwIh5JctED9PJPqsLFgNv98pRjnHRoH9KL0B4nSTeA2XbsY/mWAq6WwVaiL
	DMqfq4h9S1GkAzuo3ogBdl+ck9y/FOa5yTQhBvoeQDs2/R3wyAqiHyWjQCo0KcwB19GFRpEO594
	b/fk4WxyXSoO1R765w0et7AJuJG1lgiOwGw==
X-Received: by 2002:a17:907:2da6:b0:b2b:3481:93c8 with SMTP id a640c23a62f3a-b8426a721fdmr254461866b.19.1767699660799;
        Tue, 06 Jan 2026 03:41:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG84dM2UbyxKeGPMg2mgLwullZrJG1K6ilHte+bW3twi+D5DlhzPWphkNla6phTEwHL0SIdQQ==
X-Received: by 2002:a17:907:2da6:b0:b2b:3481:93c8 with SMTP id a640c23a62f3a-b8426a721fdmr254458166b.19.1767699660261;
        Tue, 06 Jan 2026 03:41:00 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4cfe76sm202719566b.40.2026.01.06.03.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:40:59 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A6DAA407FCC; Tue, 06 Jan 2026 12:40:58 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v6 0/6] Multi-queue aware sch_cake
Date: Tue, 06 Jan 2026 12:40:51 +0100
Message-Id: <20260106-mq-cake-sub-qdisc-v6-0-ee2e06b1eb1a@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMP0XGkC/3XNwUrEMBAG4FdZcjYymSbZxpMg+ABexUOamdgg2
 7pNLStL391YUVdajz///N+cReYhcRY3u7MYeEo59V0J9monQuu7Z5aJShYIaMABysNRBv/CMr8
 18kgpBxkoQmMcYWQjyu514JhOi/koOh5lx6dRPJWmTXnsh/fl2cP93XLwBaPegCclQerKgwVSS
 qG/HZhaP16H/rB4k/ohSv0v4TFGRb7RdR1XBF4S+y0CC4GaHHsCvW/ciqguiAq2iKoQJlobjK4
 5UFgR+pdAUFuE/iSAqEKlvAp2RZhvwoICs0WYQtTeucZRA4b/EvM8fwD76w95DQIAAA==
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

A patch to iproute2 to make it aware of the cake_mq qdisc were submitted
separately with a previous patch version:

https://lore.kernel.org/r/20260105162902.1432940-1-toke@redhat.com

---
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
 include/net/sch_priv.h                             |  27 +
 include/uapi/linux/pkt_sched.h                     |   1 +
 net/sched/sch_cake.c                               | 514 ++++++++++++++-----
 net/sched/sch_mq.c                                 |  71 ++-
 .../tc-testing/tc-tests/qdiscs/cake_mq.json        | 559 +++++++++++++++++++++
 6 files changed, 1017 insertions(+), 158 deletions(-)
---
base-commit: c303e8b86d9dbd6868f5216272973292f7f3b7f1
change-id: 20250902-mq-cake-sub-qdisc-cdf0b59d2fe5


