Return-Path: <netdev+bounces-165748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7787FA3346C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F092163376
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77B16F2F2;
	Thu, 13 Feb 2025 01:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xo+GBfy4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB74786323
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 01:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409206; cv=none; b=Vo+yEx3bgOXTjE9GtBmiRFkaI9ahv3Hu7dsE10Gi9m0A2bSyNbgJwmM+GxWAoH6JE2WDamKTMTIJJN884KhFk2xYeWMM0/WAvD7rHaKkc4gCBrjr67ZacKMoZuqyvX4piEkqHrRiGV8Ddh5FLc7iP1w9kmxEBVWC91ozypK7N5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409206; c=relaxed/simple;
	bh=gZi25y/tMtvr3cHF33QDViNTKtenRh9WwOy/0Mqckh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Db5+mkmceIWWEfg7uewVAqQmbWcvjJCKqiLENpJdwUjBvMssnZsjcqVpJfUTX+Y+8fS5usLgZfwo4PsyRJnKF6daRXbXRorozmsGI0+qdQEC3TTd6wa7IuChuF4OIWBc+wj30AixBRBJI5ku88+Yev8eNsx4IGHfG281rU2B/CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Xo+GBfy4; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7270003d9c8so140750a34.2
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 17:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739409204; x=1740014004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IkuehVl4EfVbUu5J0rlaP5uW/lcuFcGyq5FgIlIQIJc=;
        b=Xo+GBfy4xaxGwdcLunbnPp67jJtuyCpE/aTjI0bbdip9/0mw0wEwamsEwV2gFks/9V
         pvM+dr+tyltCgOmzX5LHIyT3GJQAiQXxGVkGRGYOKWuhdOpwWJ0y7Kdy9j5uG6luResG
         aW6Cdzls2E2FYlTgS44SyA1LIfZf/s8rJFpaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739409204; x=1740014004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IkuehVl4EfVbUu5J0rlaP5uW/lcuFcGyq5FgIlIQIJc=;
        b=sOJZW+Xe7yx0BGmcKR2/m2dpje6oohnCsbTFVZlXBH7/M0Yg0ZiW+U5NF0IbbqvVdG
         MR1Ozd2cdJRjZ6rUXk9dGmc398G+OjP/U8EesVfxesKm0IZ1jJk8sFKDSCrqyCjerktu
         21hihtRR/3L9XdFG6UWfUgUTYRqeOxyY9esFnrG6Okq8/kW2Kb6ziVmQoXax7KEDUhDF
         LGeS0DTpRjc7P1bR88UzaUvOe3+FEpKQGbumE//ClRMw/KbU0HCryR9nthhRMBIx2H6Y
         bLuOuKXe/TlGbXbbmeksJAExXm9T/EOgtTRYsCFe7x0FwDAm0DChp8g1KhvY2dZl7cLw
         vVwQ==
X-Gm-Message-State: AOJu0YzeNDn+1a3CDlehb18gRFCWgX+fINWzaKNO73MYsELHkDcyaGgt
	MgUfr+gjj7iC8FDoGy16WLkCISNRX0Ww+aEkMYW47okAXPkTtz7vz4cAaQAzoQ==
X-Gm-Gg: ASbGnctEwVybZoA0oFfD5aGn+dFw5HeQ0IOonz2x1qERNgkoIw7lb1TgJ1oifRlkoka
	rVhYjKhA1yqXczy1zFz8lvpKj6e01BjDXCcs6m5Eo5CDd4JcuWb0VLN/JhT1Y9XALvLJL8lKuOw
	y9KLetyG1dXEf85jPC2afHrMYAoqxqpiA7e5IUZwLL2jjEw2MVkw4QFq61k7T5Lq4P8s+lF14NK
	G2lkBGHh53t8Aj736WOxgsTExzuRYl3ElsA+vg5zRxvHZuUK5zZQon5LsXUzPg96XGKdNbrtGTk
	FaaO2YH1n1iZkNFBYpthw1Dq1XbWlE2Qvuu+b1cPpPvuJOF1BcyV1rx53XQQKJ3ZjNI=
X-Google-Smtp-Source: AGHT+IGGMNP7IhLFwUuu++yEcDoLcvw+h3mFTleWI+Tr1EAParUJrPZwO8FTtvuZNWB+K4lTNOf/Zg==
X-Received: by 2002:a05:6830:2585:b0:71d:f361:5cfb with SMTP id 46e09a7af769-726f1c36ee6mr3875702a34.5.1739409203803;
        Wed, 12 Feb 2025 17:13:23 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727001cdb70sm195967a34.13.2025.02.12.17.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 17:13:22 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	michal.swiatkowski@linux.intel.com,
	helgaas@kernel.org,
	horms@kernel.org
Subject: [PATCH net-next v5 00/11] bnxt_en: Add NPAR 1.2 and TPH support
Date: Wed, 12 Feb 2025 17:12:28 -0800
Message-ID: <20250213011240.1640031-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch adds NPAR 1.2 support.  Patches 2 to 11 add TPH
(TLP Processing Hints) support.  These TPH driver patches are new
revisions originally posted as part of the TPH PCI patch series.
Additional driver refactoring has been done so that we can free
and allocate RX completion ring and the TX rings if the channel is
a combined channel.  We also add napi_disable() and napi_enable()
during queue_stop() and queue_start() respectively, and reset for
error handling in queue_start().

v5:
Split bnxt_hwrm_tx_ring_free() refactoring from patch #9 into a new patch
Remove reset counters increment
Add comments that ring alloc should not fail in this code path
Add comments about napi_disable()

v4:
Fix NPAR typo in patch #1 and improve the description of NPAR

https://lore.kernel.org/netdev/20250208202916.1391614-1-michael.chan@broadcom.com/

v3:
Fix build bot warning in patch #9
Add MODULE_IMPORT_NS("NETDEV_INTERNAL") to patch #10
Optimize ring operations when TPH is not enabled in patch #8 and #9

https://lore.kernel.org/netdev/20250204004609.1107078-1-michael.chan@broadcom.com/

v2:
Major change is error handling in patch #9.

https://lore.kernel.org/netdev/20250116192343.34535-1-michael.chan@broadcom.com/

v1: 
https://lore.kernel.org/netdev/20250113063927.4017173-1-michael.chan@broadcom.com/

Discussion about adding napi_disable()/napi_enable():

https://lore.kernel.org/netdev/5336d624-8d8b-40a6-b732-b020e4a119a2@davidwei.uk/#t

Previous driver series fixing rtnl_lock and empty release function:

https://lore.kernel.org/netdev/20241115200412.1340286-1-wei.huang2@amd.com/

v5 of the PCI series using netdev_rx_queue_restart():

https://lore.kernel.org/netdev/20240916205103.3882081-5-wei.huang2@amd.com/

v1 of the PCI series using open/close:

https://lore.kernel.org/netdev/20240509162741.1937586-9-wei.huang2@amd.com/

Manoj Panicker (1):
  bnxt_en: Add TPH support in BNXT driver

Michael Chan (6):
  bnxt_en: Set NPAR 1.2 support when registering with firmware
  bnxt_en: Refactor completion ring allocation logic for P5_PLUS chips
  bnxt_en: Refactor TX ring allocation logic
  bnxt_en: Refactor RX/RX AGG ring parameters setup for P5_PLUS
  bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings
  bnxt_en: Refactor TX ring free logic

Somnath Kotur (4):
  bnxt_en: Refactor completion ring free routine
  bnxt_en: Refactor bnxt_free_tx_rings() to free per TX ring
  bnxt_en: Reallocate RX completion ring for TPH support
  bnxt_en: Extend queue stop/start for TX rings

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 554 ++++++++++++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |   8 +
 2 files changed, 416 insertions(+), 146 deletions(-)

-- 
2.30.1


