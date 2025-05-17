Return-Path: <netdev+bounces-191229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D88C3ABA721
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 02:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A5E1C00477
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C584B1E6E;
	Sat, 17 May 2025 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hW9hNQQV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617D91367
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 00:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440682; cv=none; b=opy3d2SPob6s3EnzW33Xl16dIy6cldOPlpMet/M8ZxM+oJoDiUwE85FBL9LER6oW10Fqph/fTMsXDjnO9edvs6D0BoQyek0kZ39KFSKNq3ag9IxqyHrY79do1mlAz42j2Zo1sKI4i/BGP/+w6LOzwRGYpDba6pqwUXHBi7RDZ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440682; c=relaxed/simple;
	bh=1RFUOast+R3cv/fy13QpOewKb0K6kDlwUPWBD6mAkV0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aY0iwW49vUPwPqEAEMT64YIqe7IHGe5Vkl/tY+V1iPg8TswL5keMM16k14Vk2HLueY2mRXmv+BKQttTLbilZWtR7WSeBFedzKx2bGVcfkuR136AxICMGpWY1s3VmKQvq602yQhua7HZgDXVzLOTvoR8kgSc5xyK5rlOJyjtIgTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hW9hNQQV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7395d07a3dcso2010879b3a.3
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 17:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747440679; x=1748045479; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VVYJbfVpyDKzFCTr5wd6WD4Y02rO0zmMsUqgsnkrKzM=;
        b=hW9hNQQVXkvQOLWm9mNHpQIQg5Ss+UzTP2yeW8iilMl+FHRBOzTAWC08cHex7wwDJJ
         bBWakn+eDTTkl6v4Imt4zD6t67EXqoYJPf52vw8ud6BAmG9DxCihwh9FC7lIesL0n5nd
         e2Xj2pO36EPkHQk/8TyXKQyUncgX1J2Zc2b6ZTnx4NroGqESyK241veJ4xQmh8/t+jhN
         ESjU9CaHs8AF5ejUfqLJ3BtsmJ+cQ1LnmB9lVedEMhoE/yIAjYLIynXC3TsQHW4niYBE
         s99F6tlQQeiyPxee2hhldoQ5ntGnghVavayy8gyRz8GGBxMJpZmkI2Acd5A9sJ8UpEiB
         chew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747440679; x=1748045479;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VVYJbfVpyDKzFCTr5wd6WD4Y02rO0zmMsUqgsnkrKzM=;
        b=uusqv2A05TrakBcEvaQrXNNh6YXhC/DEWLp1UBrOThZVLYB0JfY63I7reQkwC4Hznc
         GDFIni3QrfZtH5vosCojgoQbJ2F0u5c/e6Z9mOY1Q6/GE0FqWF+iWtCZd2s6NZM1VvY5
         KvWOq8IJ8MRwZ1v+HC7JE3SuIAnTlmo/BOwfeXNXLFBh3AVG/Qok19wbgfRuX1r2GrTp
         K2+4xdBFner9YbJ97UXr9O9dXnp/rtWg4aKl2obSqLxKj8X/CVdvNuA11OEyhaSh6I8E
         UkGcWJyjnvF4+T477aKiRbwJxiKcsHzyhohmx2KC2FRtkhydDrCW0+xCBOYfK5uTv3BF
         Ea0w==
X-Gm-Message-State: AOJu0YzoK3waX9Yxy6VpV9XEBzf15uAY3KzUnhO7ViuHTCO9wVIj9yGQ
	IGrkOkVutGnc91OmT4sXtargC9WSHNM966PI84uBwQN+n1wEx+pzF3B87AGF7i25JfSU9Fg1xpY
	pbxB30BDlQZkVmwnvb8zWuBVhzzopXIhc7P1DPOtgmZ1MeZ6m52Q7CF2Pou3pPjeqj06ek1mELU
	aMihcMHGfYYxS0+jNLBh+y3j56YWHIgVJXImYIsLwrDYbMthIgZVnk3cY+nazNchU=
X-Google-Smtp-Source: AGHT+IE6P/4q+EAWyk4SLxkpbBjM99VYUZwbRdfI+NCSxau1KzLvi2tKfaROimcPlJAc2WWg5XSBSznoEcavVQc0qg==
X-Received: from pffv23.prod.google.com ([2002:aa7:8097:0:b0:742:a335:1e37])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:2d4b:b0:215:e818:9fda with SMTP id adf61e73a8af0-216219d3991mr7936600637.27.1747440679548;
 Fri, 16 May 2025 17:11:19 -0700 (PDT)
Date: Sat, 17 May 2025 00:11:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250517001110.183077-1-hramamurthy@google.com>
Subject: [PATCH net-next v2 0/8] gve: Add Rx HW timestamping support
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
the nic.

Changes:
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
  gve: Add support for SIOC[GS]HWTSTAMP IOCTLs
  gve: Advertise support for rx hardware timestamping

Kevin Yang (1):
  gve: Add support to query the nic clock

Ziwei Xiao (1):
  gve: Add adminq lock for queues creation and destruction

 drivers/net/ethernet/google/Kconfig           |   1 +
 drivers/net/ethernet/google/gve/Makefile      |   4 +-
 drivers/net/ethernet/google/gve/gve.h         |  29 ++++
 drivers/net/ethernet/google/gve/gve_adminq.c  |  98 +++++++++++--
 drivers/net/ethernet/google/gve/gve_adminq.h  |  26 ++++
 .../net/ethernet/google/gve/gve_desc_dqo.h    |   3 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |  23 ++-
 drivers/net/ethernet/google/gve/gve_main.c    |  47 +++++++
 drivers/net/ethernet/google/gve/gve_ptp.c     | 132 ++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  26 ++++
 10 files changed, 373 insertions(+), 16 deletions(-)
 create mode 100644 drivers/net/ethernet/google/gve/gve_ptp.c

-- 
2.49.0.1112.g889b7c5bd8-goog


