Return-Path: <netdev+bounces-192893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F81AC18BA
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 01:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DF3A4642D
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 23:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768EA2D1925;
	Thu, 22 May 2025 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8KnPzm9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F3B23C4F1
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 23:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747958264; cv=none; b=RnXKaPvpu1N41AK45hzQDS1PSoVuS3rV3SbpSmAhTLB3xH4Vjrwy6cB6hz8OkqCi47Qxn809tnr9DvE9AXbn7XjrVsLzWpu23icMOouPbk4Cdj58UGgeNmgjAojv0caB4VEEdhLsFu16i2j3+u2+mkcBYa7dKhFfQzq/yKWA9es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747958264; c=relaxed/simple;
	bh=+N4Q7/Fx9GrtcgTHahPABpkNsBT9qTCA29g7DhXDB24=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=buHOlPWaae91t/qoqXE9AXJQpeH5ZEFKJv88LWwYNzGmluC/UKTL/vF6ODwmJDHm2WroTniCAY7Ppwk0z8hpUGFyWTCDklAHpO2k+zN+t8X183MSyzcVKTeRxAytNTO9Lr5G9zn5bs2dffk+9jKkr6NvKRa14M4itm8uWrcq0B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W8KnPzm9; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74292762324so6779761b3a.0
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 16:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747958261; x=1748563061; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E695lb6mnZG2Azxgeb2zoRXaKZzc2rWePmDYZ8LrO3g=;
        b=W8KnPzm9p7zx9DSOfS2rTmV6DFBOh2W80EosrupNPMlNx/FV80eH+iYyB+yIPv+SOX
         FqMhydJqO4kicWdCT8TDfSnWCwNn+mOW2WTTkCVGqNVzGJnjFruYz4ZDPqc5YlscyXLl
         HPVOwKeHnhTNXlHk23o9PgNV68UiuQmeqk1V+seO8XkIYMbOnh995oq+cInAbU+IMOg1
         WmBG5TmQ6S6YGDOuAf7Xz80TYou8lSz4i7+0IU46m66rtIJbM5D5JRDqtNZd8UfrWmwr
         oZF3HLp2kwBYe/girh8uCnM11/kg1y376z8cB996RgfYadNh2T6hv0HI3z7i8gCRnrLx
         GBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747958261; x=1748563061;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E695lb6mnZG2Azxgeb2zoRXaKZzc2rWePmDYZ8LrO3g=;
        b=bW/M3DufvN7+NIB871Y2W6SFQT8oNweKvOlRkTsqoaNbpJ1eBCNNIxw1bdWTfpJGlB
         MtLFsxUJoS87+uWoLsqtt/7qNUblVt8kTuZRJOYkk9dD2XJTj7qeOnpMwic9urruAiWD
         z1FGbvdVgiJ6FioCpMzXUaUNLr6GmPHNrF0Cd62Ly7vgH87fzpn04jG/V+gklFF2I9yT
         7I5w408JFcLR31Ne357/ybNxIgCu0/TNX35Tygde7WVRLV05OPS1R7Dd3puqtQ64qivi
         WOnXuiP+3Gw/O4iE0yaGkBXkGE1Dm+EgjJnra9SkZQPVYVhb/TLZssnIyvvpHx3wd8W6
         iKvw==
X-Gm-Message-State: AOJu0Yyg04aM+5IBf9CW18OqSSxH0aYkHI6c5VajBqagtyFZOzES2QO2
	FW0IfCJ2r14R88sMOd6b1BICtVaEjG0Wl5I+xgH13wB33UG422AZcs66UqtnU38V13Cjh+JWTCH
	B3jCu36nT3wYouhH4Si+y9hxUezospAKqHO9f0rwgpa5o6MEnrIvQESrNA1TDqbGtS7DsZzArh5
	9229Ld+REwTTHzUbM4ZrD0LaqmVS+zuK/OusnmD7Byrx8jTZV0sPMyirL921NASbs=
X-Google-Smtp-Source: AGHT+IFg3AqzfCowzRgk/1BxZBoVCFnad1BcDRGhv6GqoVuBPz9n6dzqgqi1FQGJMI89AZX695orPjg9TaHpIpsWUg==
X-Received: from pfbic8.prod.google.com ([2002:a05:6a00:8a08:b0:736:86e0:8dee])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:9455:b0:73d:ff02:8d83 with SMTP id d2e1a72fcca58-742a9786a85mr39674567b3a.3.1747958260570;
 Thu, 22 May 2025 16:57:40 -0700 (PDT)
Date: Thu, 22 May 2025 23:57:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250522235737.1925605-1-hramamurthy@google.com>
Subject: [PATCH net-next v3 0/8] gve: Add Rx HW timestamping support
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
2.49.0.1143.g0be31eac6b-goog


