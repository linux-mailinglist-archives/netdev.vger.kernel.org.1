Return-Path: <netdev+bounces-195821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A100CAD25C2
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 20:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627FC189145C
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 18:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8AC21CC71;
	Mon,  9 Jun 2025 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gMGUj3rU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D10218EA7
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494435; cv=none; b=NXW8bxauoxevKZDza0ciCd53boYI1b2E631NB9wKCrEw45UMMy/u05Zjp8beS9cx0P/jMbL0Vj8mMf5AAyYdCB4mM+SQuxK0cYVVWZPiuG6nW2ny845hShww9xsu62uZu0zr5HtTlbsxr87raFuK7avVwEkRco9yr0b7LFq2sho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494435; c=relaxed/simple;
	bh=/EbOyE74/+xw2Qe4YNOTD1aW+YnWxBSIZWc7XSYciJY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WOO1Cb1rj0OpJidk+Wn3RLDAMt1W/bFillWUJCHku0Z2xxRe/yyspjZt1Aeeq1jc34N5Vnagyge8/5T9plATEFouVK2jjWq1NifhMqygB1zaevqEFvBdRJVVpbPYkWzOdhOfMj0K5TctpEp4RP3RZyk9M576edKDI3kxXVFWijs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gMGUj3rU; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b1442e039eeso2911319a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 11:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749494433; x=1750099233; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SgtR2Rm6au1768qjFPYDCyyBz8a8l6s1CM89uXuSWKg=;
        b=gMGUj3rUoh7I/a+VPuYDekq1PQ78cn3GUJWF8EsaviFFtEbCRDrPqwyz53zjlIMcej
         ifcQ17d2pzoMrwZAGhIe26Q3/EAE+9vGzN7psTIXkVzNzhyqakWD00gqEx1IK0ux1x1C
         mVpq8aA8cQb7IP3punapzduwEdr8Fpa6qmMhQQEoV77zMzLBhNTE0b9I/dW2erMsaKuv
         UYSeEpj8kxAbOgJPh8cesYNDH7fZ9Im1zutVaNsJ9WhoR6aZatT/+b26+Y8epq/cbo2O
         KvtnjeCKP/5ysCXPPin7yjyfdPIiz4xZW5eleoXtMgaSchdVi3RLOXDmjBJwb/KGpGEB
         y23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749494433; x=1750099233;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SgtR2Rm6au1768qjFPYDCyyBz8a8l6s1CM89uXuSWKg=;
        b=wpAHg15PHuHKVlRzMfHGyx9LGyqAjN1ChoYY6Y9jG4u7+//IvpJ2D58rwKpTYm7a9G
         5+Km9qOFicve5OdfcwIp3YJhy+2HhHGOectLRGDYJgR9amu7+2NIAJkwzUTPLNGrPIan
         oqKkAKPw1RaacuedoMUUqn/9BNRh7Mutszya8N00BLAO5J0dCblBaCQxzTKiqlx13gn+
         NUA3FPgSRYbIFbyw/RzFodhlwlZjIgRx/XcDlf4gqPFKI3nWlhZyK0vO8j/H8VmM3hK4
         NwyYEs4TKXPsyXGhdUQzGO+MHXrHZtHPmZOriBsLSEjjHAibSVVi7dDpRcd1djWWh+FA
         yqag==
X-Gm-Message-State: AOJu0YyMhGriI2rszNmxqsYZjEGwMY0uBNpTibC9JZa9RpWMFru/H+zh
	El9B0xIz11TAi+ETykrWU0ltEdYIZXYJ+Z2y0e/l73UbZTzF5C3p0uYmCYeh70pIzaiaf99++Zh
	ItUkYFWPTxrEL+zzLvRerWK/P7p5EvZmqRhpD3trws0xYyYVsNe5JnaiToePbzKwW23TVnNtyso
	CSwjRkoctuWXPp1GGQcCxeQGcgcjs8GkuTAt2rXAtXaqpP93JzNuQ3FH8AH94s/Kk=
X-Google-Smtp-Source: AGHT+IFPskpgTl0cIwyUttrMFfUNbuj7x+gYDt0OPiPmqkyT4EZiUO0QJFiINDVHNpNFNNY/Q8gJNxnk3S0HzabBdg==
X-Received: from pfiv6.prod.google.com ([2002:aa7:99c6:0:b0:73c:6d5:ce4c])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:1604:b0:1f5:6b36:f57a with SMTP id adf61e73a8af0-21ee2618e34mr18363183637.39.1749494433253;
 Mon, 09 Jun 2025 11:40:33 -0700 (PDT)
Date: Mon,  9 Jun 2025 18:40:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250609184029.2634345-1-hramamurthy@google.com>
Subject: [PATCH net-next v4 0/8] gve: Add Rx HW timestamping support
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
 drivers/net/ethernet/google/gve/gve.h         |  29 ++++
 drivers/net/ethernet/google/gve/gve_adminq.c  |  98 +++++++++++--
 drivers/net/ethernet/google/gve/gve_adminq.h  |  28 ++++
 .../net/ethernet/google/gve/gve_desc_dqo.h    |   3 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |  23 ++-
 drivers/net/ethernet/google/gve/gve_main.c    |  47 ++++++
 drivers/net/ethernet/google/gve/gve_ptp.c     | 137 ++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  26 ++++
 10 files changed, 380 insertions(+), 16 deletions(-)
 create mode 100644 drivers/net/ethernet/google/gve/gve_ptp.c

-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


