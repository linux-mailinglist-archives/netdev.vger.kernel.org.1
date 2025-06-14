Return-Path: <netdev+bounces-197673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2712AD98E3
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 02:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E079C189E850
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 00:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44BD1853;
	Sat, 14 Jun 2025 00:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nr3RSDqV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A6B195
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 00:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749859680; cv=none; b=X4sLbU+qdP8P/dMvCvMCSEAEohDSbhGkxou49ddvj0zJR3SZSHkBTeIn338EPGxWA6z2FYtb4kdhAo3YOi9fpb56fecD2UVuk9UvkDkBXgm2hxogVMJE+2OPF2I4FuQN1Axh7lpnU61dLJoYB0bW2hFMK9r6q1HyNjDUKoCuAYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749859680; c=relaxed/simple;
	bh=u6Wwj2JrD1CSaXYTMcPrahKnTuDnLOLwD5Z2r1esUAE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GvfQezkqL9m7fmbrL9KGSdNKfJNAdUk0J8/GkOeMQw0NHLhZXUOd0/wP8KUC97e9p938A2lagOgRNiSONO1KWgMXn4r8+o5MVJHxCREGtsILTnvoyTn2B2L07svWQ2aHtrrYF1m+fSXrnyU+MVaI5tsGk03toBhzDqWLiWJlrYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nr3RSDqV; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742c03c0272so3063843b3a.1
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 17:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749859677; x=1750464477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4vcr762WDbQ0QddIFaRoGKd26pOHCsd0x4SxrXrcg7k=;
        b=nr3RSDqV4K6tXcnX0RNBpsv4DUgV2b3gHgVQzv8OwXQOz/vLKg65SYl2KsRzMMKQ2N
         Dorbrs0fGXjRs/cKIg+RiKOPMa5omTdd7CQgq1O1sGywekFZV3NVH41alqvd2uRzXbeA
         G5oFSr3QxVr1Cih4NXlANqJ2EzA1W/l23daEE2pv8uXZYH73stSnsKapoIvgzrD9lUzt
         vT6iMQph9z/fKFpYrTROci93uDAclzQtfbde2N8VL+xtiDrowJL7XVNpUGW/xMmaMs/A
         lS5dhArNqlubL934heE7OsfhuOYYzPmKQyIvvvpRunKS4Ldjihn3ihSxLWc+LpwXgcMf
         QARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749859677; x=1750464477;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4vcr762WDbQ0QddIFaRoGKd26pOHCsd0x4SxrXrcg7k=;
        b=dnj5hNoTgce3nNwLEKTUW5s2gkKz7u1eNYoubwUjE6/+COqJJE5dX3Mv+T/bECgxq6
         kgh0dW4usAkA8DTrXbyRw6SzCl3Tm335yuHJ5AYVWbQUGOx6U3KK6b7JR/LVQklN7K6Y
         4EokiMaIQn5itXsfTOnLp71Ns4sE4YxhK8UjWzvS7gCPCuRzQaenBT123tdGKXqA3u04
         7oGWT2l72GoE5CKTvuzQVpfyOTvA3LXP0GvV+tZA2G3fqUACimf1Z+GaHo+D4Nqe1w4Z
         plbp0yz2NFvGYIH1cLJBE1dWD1WsmhR0Rr89gFw1TzeOaOIUwLhM9KR4xRyLhRzR/gxU
         MoGA==
X-Gm-Message-State: AOJu0YwAX58NH4eLn4v9bcZWoTRlaPjtsZMlllM+LFqKPnYmrf1x0LFR
	B25aRwqpG6qLZddn7gcZkcKmV5jLASESCasaP3mJJ6YhYiWu2BXJblIVuyl6xZr3STPFS2MeC01
	km3eFPTfYioQuMFLLT72dYxriAHx5HLxsQnJeZfo6x2UJ6p7DJNxWePt7lXbPRdVdWLutPYnVLT
	vahwtDVTOpJCAEvB3rkE38Oi3Mf36f4cVcREGq2YTalwkir/+zu+uCMOp88FZrlwg=
X-Google-Smtp-Source: AGHT+IFRYaranCcE6ufQrSNi60jc40HksifDXkGaYHchGn0qT+3VPnWQFV4JY9HULJlA54H/6IvlzoNjnB5oAyCmRg==
X-Received: from pgbbo11.prod.google.com ([2002:a05:6a02:38b:b0:b2f:6681:1f1e])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:4392:b0:21c:faa4:9abb with SMTP id adf61e73a8af0-21fbd5568a4mr1757891637.20.1749859677580;
 Fri, 13 Jun 2025 17:07:57 -0700 (PDT)
Date: Sat, 14 Jun 2025 00:07:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250614000754.164827-1-hramamurthy@google.com>
Subject: [PATCH net-next v5 0/8] gve: Add Rx HW timestamping support
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com, 
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com, 
	shailend@google.com, linux@treblig.org, thostet@google.com, 
	jfraker@google.com, richardcochran@gmail.com, jdamato@fastly.com, 
	vadim.fedorenko@linux.dev, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ziwei Xiao <ziweixiao@google.com>

This patch series add the support of Rx HW timestamping, which sends
adminq commands periodically to the device for clock synchronization with
the NIC.

The ability to read the PHC from user space will be added in the
future patch series when adding the actual PTP support. For this patch
series, it's adding the initial ptp to utilize the ptp_schedule_worker
to schedule the work of syncing the NIC clock.

Changes:
v5:
  - Change to register PTP when initializing the driver and keep it
    alive until destroying the driver. (Jakub Kicinski)
  - Utilize ptp_cancel_worker_sync instead of unregistering the PHC
    every time when rx timestamping is disabled. (Jakub Kicinski)
  - Add gve_clock_nic_ts_read before the ptp_schedule_worker to do
    the first refresh. (Jakub Kicinski)
  - Add the phc_index info into the gve_get_ts_info. (Jakub Kicinski)
v4:
  - release the ptp in the error path of gve_init_clock (Jakub Kicinski)
  - add two more reserved fields in gve_nic_ts_report, anticipating
    upcoming use, to align size expectations with the device from the
    start (team internal review, Shachar Raindel)
v3:
  - change the last_read to be u64 on patch 6/8 (Vadim Fedorenko)
  - update the title and commit message of patch 7/8 to show it's adding
    support for ndo functions instead of ioctls (Jakub Kicinski)
  - Utilize extack for error logging instead of dev_err (Jakub Kicinski)
v2:
  - add initial PTP device support to utilize the ptp's aux_work to
    schedule sending adminq commands periodically (Jakub Kicinski,
    Vadim Fedorenko)
  - add adminq lock patch into this patch series instead of sending out
    to net since it's only needed to resolve the conflicts between the
    upcoming PTP aux_work and the queue creation/destruction adminq
    commands (Jakub Kicinski)
  - add the missing READ_ONCE (Joe Damato)

Harshitha Ramamurthy (1):
  gve: Add initial PTP device support

John Fraker (5):
  gve: Add device option for nic clock synchronization
  gve: Add adminq command to report nic timestamp
  gve: Add rx hardware timestamp expansion
  gve: Implement ndo_hwtstamp_get/set for RX timestamping
  gve: Advertise support for rx hardware timestamping

Kevin Yang (1):
  gve: Add support to query the nic clock

Ziwei Xiao (1):
  gve: Add adminq lock for queues creation and destruction

 drivers/net/ethernet/google/Kconfig           |   1 +
 drivers/net/ethernet/google/gve/Makefile      |   4 +-
 drivers/net/ethernet/google/gve/gve.h         |  35 +++++
 drivers/net/ethernet/google/gve/gve_adminq.c  |  98 ++++++++++--
 drivers/net/ethernet/google/gve/gve_adminq.h  |  28 ++++
 .../net/ethernet/google/gve/gve_desc_dqo.h    |   3 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |  26 +++-
 drivers/net/ethernet/google/gve/gve_main.c    |  53 ++++++-
 drivers/net/ethernet/google/gve/gve_ptp.c     | 139 ++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  26 ++++
 10 files changed, 396 insertions(+), 17 deletions(-)
 create mode 100644 drivers/net/ethernet/google/gve/gve_ptp.c

-- 
2.50.0.rc1.591.g9c95f17f64-goog


