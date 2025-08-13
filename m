Return-Path: <netdev+bounces-213438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCBAB24FE6
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 18:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D5E166B73
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 16:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D11288C37;
	Wed, 13 Aug 2025 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CQO1HDkB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AA0286D62
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102565; cv=none; b=cgbzuGDiiP+gTYZ+3shpzGuKLJll3PiarENXB9mr4W3I0NFC7JRfjBoEa02e8riGh2URm75gIO7R2xoNVDLRMACIDcPUSkH7YuJgWgTmmFqaB3u03ZpOqNUExR6lr6CN7A8j7WT464GMXUkNROr+yMEZRR6SlMK8njtXCkywjc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102565; c=relaxed/simple;
	bh=bYaQ7xlrKxCuwQtNn2omZ7BjgvDcPYjR2TMWck0VGQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fk6QukbjkaIXTZJ+RmH+5mfoT3x6A2Dk0KYPoPMil8l3gVplI46WnkcPPjJDFFFIzyrUvrH0PjU6O2JlEja3zAobLhnaHl/S8Rj42che3vubBj8B9MCRyiSfyEqqN20iObDQ2ptN7ajTTYthUI6T6ekKW2adf0rggAHqDRLA7u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CQO1HDkB; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b1fd59851baso4674543a12.0
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 09:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755102563; x=1755707363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LhDh0bK+gQwaFqeot2nkbIRJyYLX52+XKHM1mxR51Ak=;
        b=CQO1HDkBKZSsuTtj99voFysofUPnuHmD2TgOKkdW++4ySpL8r940YD2/Ryqi9HhTrU
         rqP6svTg2EWjK4gOnYtb6STrxP60RO+GMsRmuZzLFrPrQHvePSfShOSyEtvhFwfRqclW
         0Kq1oOjzgu4DI5b63cyHmHOd5Vg6gZSDwIWaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755102563; x=1755707363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhDh0bK+gQwaFqeot2nkbIRJyYLX52+XKHM1mxR51Ak=;
        b=ENtUjIThKQCRz2GDbkkjAz68b5/OjHB8NpWYdHIxum+7uY2rIhtfziwWjW9SP/gJAU
         kS7hBvRBYke0OPJqdxWBFqNb4r+IQTnnPBX0WxcRzUWzMT5k+SeECfWZy4ewsUcyPpU2
         QdTUjIKymOxTq9oj9+gcyrCjvB4ifueS9YAVo1ECaYwtcYbISI3/WNSg2UkalTYDssC8
         O+ojYKlXbfQ92vHaMx0w74kPUJT/ipNcT2h0ugDx4V/pDLdvRq6o9MV8/UCwkAydpIHG
         bjsSKkaa2VHQI2KR+oW4DngWaCjViUOe+TCMktaHw8Blkx2wGumLSc8hfc0v6nvDL0kS
         h/Dw==
X-Gm-Message-State: AOJu0Yy14Djz0WGdyHWceVip9/HrhKhl3jgcESfZn7+BQqmlo7koZRLf
	349WsGNs2u/82nWvTEc+DcYwHHGsPNflARYwl5M1IISIxBlmqQGjdqsmRoKBKPEHgA==
X-Gm-Gg: ASbGnct2aMdS6swZZpAO9Knj77djFvRPIaNVkTVbgMQVifW65CQTLpxq/i1r1NCZGH/
	eM0E0JA7oK31/l7B723EUPp59tsvl+aEGraybn881UFROK15IHz9bO4iAJfj77NPebVwLA3c+ZK
	jMJXa8gE9Sj0TjZhtUHwAcBwmiZ7QCH4Ba9c5b7g68utqsf6Mr0GH5Gdo9gXiDqmsUYu+5M5kNX
	BJV2uGayo88eDcfBefaS5C+hS5kW1Q/vvacW3F9PYTmnQdXJlrN8HdCP2vGZLMqZCiVoEJsJmwA
	2TPG+/qRZE6r9zj5MKAg+EXIOqKyg3Y7AMhXvS7GQu4H/8tEoARVpb9Hdc2EFsIDWk6xBE7mmq/
	/NegZa9nJ+uIPAzWFzwi+MH+KCq2yeZgnSxVznOmxcCz5sg2L0OM/hkRu3/T4viWiGzjqeDxoUf
	xLJnGzYsD9CgN+2yZlBEukdEe56g==
X-Google-Smtp-Source: AGHT+IHaS6kzgD2z3CPm/bEpl6Q8l6D7g2epnpf64XF+XoK4p8+KLJvuUjbFUmkBdlSH0iEurBAjzQ==
X-Received: by 2002:a17:903:2f85:b0:240:4d5b:29b4 with SMTP id d9443c01a7336-2430cf2af9fmr57123965ad.0.1755102563267;
        Wed, 13 Aug 2025 09:29:23 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0f7bfsm329311915ad.41.2025.08.13.09.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:29:22 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [net-next 0/9] Add more functionality to BNGE
Date: Wed, 13 Aug 2025 21:55:54 +0000
Message-ID: <20250813215603.76526-1-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch series adds the infrastructure to make the netdevice
functional. It allocates data structures for core resources,
followed by their initialisation and registration with the firmware.
The core resources include the RX, TX, AGG, CMPL, and NQ rings,
as well as the VNIC. RX/TX functionality will be introduced in the
next patch series to keep this one at a reviewable size.

Thanks,

Bhargava Marreddy (9):
  bng_en: Add initial support for RX and TX rings
  bng_en: Add initial support for CP and NQ rings
  bng_en: Introduce VNIC
  bng_en: Initialise core resources
  bng_en: Allocate packet buffers
  bng_en: Allocate stat contexts
  bng_en: Register rings with the firmware
  bng_en: Register default VNIC
  bng_en: Configure default VNIC

 drivers/net/ethernet/broadcom/Kconfig         |    1 +
 drivers/net/ethernet/broadcom/bnge/bnge.h     |    7 +
 .../net/ethernet/broadcom/bnge/bnge_core.c    |   16 +
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  483 ++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   23 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 2175 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  290 ++-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |    4 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |    1 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |   58 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   22 +
 11 files changed, 3076 insertions(+), 4 deletions(-)

-- 
2.47.3


