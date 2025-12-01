Return-Path: <netdev+bounces-242931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21C4C9688D
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 11:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA2F3A3DFA
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 10:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063203043A1;
	Mon,  1 Dec 2025 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzhnaOjK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKvfLeac"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2034F30217C
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583240; cv=none; b=qvZylMchi7y/m0pfypR8LtJRsCRAUBEq+6WcfQTK0Kofozi+OJ9a8OsDxjP+Z9XlAF84jh6iI+ndk9ywjcB9kRQvztZwKLQMHPRUK2Z9/LxlAWCI3+vP6fs+KkYjmGINPHHUewBpjzqipS9W8Ld5VnGoUoDFfDG4e554hysb6hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583240; c=relaxed/simple;
	bh=cOpEGymbvmQHpCvWIgZPpw4Gloz3bKUlw4mt8JqOdCY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TvgKAzUO9gSx/EEH0nyAUvxbmvBdWXyEWzFPP1FOk5ke/es2xdVQ/jSow1Jffw8QVPrxJu5wrm30jdIRZcs6htXCztiyyeEDQVIx3gACPhWht53Q2pUyfIwFStvm7LIkBLRWI12zig2MJmb7ih1L2ZMH0GNphV7fB294iDTiEFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SzhnaOjK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKvfLeac; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764583238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xPcAtXmqkcV2OwW35f2TUENlJezHZj6qDhp1D2vi8Cc=;
	b=SzhnaOjK+GY8VAOXQ+zKas6Foq/eyiKPpUfrnQAlB7WiV+ZtgMpnW8AWyYIc4ekVNTTdNc
	+aZURsE77oSUbG3BWANCMJMywL/z9cxxIV+sVjFeHr1GCK8BQ4R612PJcTLjRcOYFZjJLJ
	ToAwSzDf4AaAyM5mXzSqeP5YOhYbZW4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-aXffxzwnNteDQ-EUATLzSw-1; Mon, 01 Dec 2025 05:00:36 -0500
X-MC-Unique: aXffxzwnNteDQ-EUATLzSw-1
X-Mimecast-MFC-AGG-ID: aXffxzwnNteDQ-EUATLzSw_1764583235
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b70caafad59so393862466b.0
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 02:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764583235; x=1765188035; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xPcAtXmqkcV2OwW35f2TUENlJezHZj6qDhp1D2vi8Cc=;
        b=aKvfLeac3fHki0JNgv3QGUFwV9pdkM8tg9ElnIz8cqh7B9pBWUzYVJTTBEogLHOWKa
         3Zxdgf1+WVTF89dQ1ZE45auL1WYirTRRKNWmB5J4fHasxp6JunXM9CHhEXMrzU0tP0qh
         LkUYlwJJxG3S0Q9FZbJdu2yGc72zJC0NfwTSRmh30E/7wbdkkshLEw87VeWmTrz0DRbX
         S/khHWnZ8krebOu3EObhb6zos1RsAC8RX5I5aV4A6UExJjyz7QyBNAnr8xeC+KzSuG4S
         F9mMPqHc6zV4Zbpz+p02HKQ8maKDgNQqekbg0j9GawNDAxFvdGhU+5TOBFy9EJiGFiAw
         ptXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764583235; x=1765188035;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPcAtXmqkcV2OwW35f2TUENlJezHZj6qDhp1D2vi8Cc=;
        b=B0lUanMoPZzbPFMKtHIaDbnHMBqGYcMz+kF1FuSmJFr6IM7J/oABZkeyi8pkbCBDlv
         6WJ4u1xbaz/SuR9r7X2/QsdRpv8arz3eiLOc2k940zTX7JCxb6yMI1BNOlPW6xZbkS02
         tkgRSoraGA+1O2ZGp9Z8Dtyq9A3WlL/bmmBJ9JnA4NWh37SmAK7qEtFxT1/QDFAP/Ptz
         mHRS7mRkf1A2c60afwJFQn6BV+cMR4+0aTzkj3+qXDuETGHm4UKdWhF3qMVd5KXPBiBU
         6PeCLLsqXzs3lg18NYa/5l15Cg+tx7IpiLGQe2Ngzf+A0lXtjKCQckGVeS3s8D0xWGui
         zIQA==
X-Forwarded-Encrypted: i=1; AJvYcCWsINJqAytB64yNVsumzzdduxdAODP1OGaF71aqAtVzn4VgMTZJL7lOLFcktf60oIktyHKynkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2wyuFx6W6DwFxxtg/VJSbgVV6nfwk2sYKZlqGYpYp369OuVSH
	L0G76xqpKVDxnDKxuHyi/tqOpS06QR3aV5agBrNdWF2M16T7uzupBEKjz8j0isxrPmzU/Lps6cl
	czHUTAM7P3qqcqXF5XKiJJDv2yhRqlvO1ryeyW5rrgQBVeawo3OUGYcaSHQ==
X-Gm-Gg: ASbGncub+lS9893EaF/6AU5zSmousLn//1gbs3lmHL85vAJ67BbPi4oyVXnsglC+i6k
	RqUOhIsbMShreV53D2XzzEtiZO5t4VWddGUA8F953G7U8YqOMyfrgmy/JFSDTAwECL19oq22vHh
	WKY0H83lx9hrzYxhozCG1SKdI0Qsgc9SSfST+fQkWLXCZYsQ1QFgJfivyA3IJpZxonUl4MUNg3L
	lLYcdg8Ta9GjA/LNlnsZwbwxicDgv2T+AUcIKVvJVzccfn/X3UYOvivULL1oP6l1F9CRSh9kA6A
	j/q2+kxMFZtHVX4JipyU0q/3FQ4E9xL3mmkUKobvpGQ9j8whbYqadQNvBeH+LPkjQszrJ/BN7Nh
	FgXk2vpoxjWoerRJ3NRFJC6cY2SkaP6syrw==
X-Received: by 2002:a17:907:948e:b0:b76:6aca:f1f3 with SMTP id a640c23a62f3a-b7671589e26mr4283871166b.19.1764583235292;
        Mon, 01 Dec 2025 02:00:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmT8/ucDX1Qh3CKdD8iaTBPlS1ARFHW2GBYJb7svm5iT+aEQnVTVZYTPPAQOJCRS6udU6r2g==
X-Received: by 2002:a17:907:948e:b0:b76:6aca:f1f3 with SMTP id a640c23a62f3a-b7671589e26mr4283857766b.19.1764583233293;
        Mon, 01 Dec 2025 02:00:33 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a25fcasm1175298266b.61.2025.12.01.02.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:00:29 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 99FD1395D51; Mon, 01 Dec 2025 11:00:28 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v4 0/5] Multi-queue aware sch_cake
Date: Mon, 01 Dec 2025 11:00:18 +0100
Message-Id: <20251201-mq-cake-sub-qdisc-v4-0-50dd3211a1c6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADJnLWkC/3XNwUrEMBAG4FdZcnZkMk26rSdB8AG8ioc0M7Fh2
 dZNallZ+u6GCrKy9fjzz//NRWVJUbJ62F1UkjnmOA4lmLud8r0b3gUil6wIyWKLBMcTeHcQyJ8
 dnDhmD54DdrZlCmJV2X0kCfG8mq9qkAkGOU/qrTR9zNOYvtZnL89P68EPTGYDnjUgmMphjay1J
 veYhHs33fvxuHqz/iVK/S/hKATNrjNNE24Iuib2WwQVggy34hjNvmtviOqKqHCLqAphQ117axr
 x7P8Qy7J8AzxyU4GHAQAA
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

A selftest, and a patch to iproute2 to make it aware of the cake_mq
qdisc, will be submitted separately.

---
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
Jonas Köppeler (1):
      net/sched: sch_cake: share shaper state across sub-instances of cake_mq

Toke Høiland-Jørgensen (4):
      net/sched: Export mq functions for reuse
      net/sched: sch_cake: Factor out config variables into separate struct
      net/sched: sch_cake: Add cake_mq qdisc for using cake on mq devices
      net/sched: sch_cake: Share config across cake_mq sub-qdiscs

 Documentation/netlink/specs/tc.yaml |   3 +
 include/net/sch_generic.h           |  19 ++
 include/uapi/linux/pkt_sched.h      |   1 +
 net/sched/sch_cake.c                | 485 ++++++++++++++++++++++++++----------
 net/sched/sch_mq.c                  |  69 +++--
 5 files changed, 431 insertions(+), 146 deletions(-)
---
base-commit: 0177f0f07886e54e12c6f18fa58f63e63ddd3c58
change-id: 20250902-mq-cake-sub-qdisc-cdf0b59d2fe5


