Return-Path: <netdev+bounces-186585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ABCA9FD55
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 00:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E5516CD65
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 22:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C28210184;
	Mon, 28 Apr 2025 22:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="enwb0laS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8623B176ADB
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 22:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881181; cv=none; b=sP9cRo7HzBCfSbwiqQi8D7TXtnpHBKbE/Fb2aVrliyVN2WcGDFATnMzF6qPnFqadlI27cPyF7ORs4nbY1a/vwX2N/fLUMeBV62Zav8p/K+6n3WNHgWGvFWjTdn4jWxU3WRAwPh0o2Im3Xi49X4MImzEC7BnpsiYR1yU1IoMzxTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881181; c=relaxed/simple;
	bh=FgxtLkG+rhFZwRgqaoW1YR9oxC3CU+ZarO1GG+Bcz1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uXRcdtviel1GaEjY9t/CH97uzkjuw5PXCNFQ9Wt7Mdg4y5aiSTv1PJBXaa7GyTffq5MPHJ8fdmB95hT03RuMvZpc8wuBZWogxVzTvvXX5o37SU7y694rpNZnI+UHXDW32GFw5yoTBFLe0/G9ME+koqcUP2i4CeqmWXofCi+vq/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=enwb0laS; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736ab1c43c4so5370175b3a.1
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 15:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745881179; x=1746485979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mzK2Qb3+3JaY/gBWatr5bDOYU2FkssrSNhXD/N3PxSE=;
        b=enwb0laS93ghSAkrnpDybA9FuPbop8VHh3QXLDFEhYqn8/LeBxOfaH5YOFDZ3HwRQq
         FzBHHGOGUWZbD5fm9AbaQ5FNfrqg5XfeHQPC1UL4gGiRLst90I6Yq9XyOIJneAX5fprK
         I2iJsMHwbvqWq5GdoiIBq9diuW6QTqv1L+scE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745881179; x=1746485979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzK2Qb3+3JaY/gBWatr5bDOYU2FkssrSNhXD/N3PxSE=;
        b=CKdDgp3MSAo2V/P2zArT47o0iF5YKp6kLvdBaEp+ZB+WD7FDtB/UCvxbqjcX+BmbB6
         hiyIvSUuFwde4uCpiTfdXRVZkc13C/zNL5PbLSb1oI7W6gtPFTSurNm+0NnXuBYlESXb
         4+NRSXpFG27WhZdjkmAi8M/8XWzfOu3iX3cWCjW51sl0e6fMG2xcbnjdm/cG18R2SqGf
         rGRaNs+DoghtTws/0uKm16ZS6eXtckjUu6qwPka2WFasxLo+R1aHo64CG/MXzoZqj3Ke
         dDIUh/o9h2C8B5KD+fXcKp7YrFohMrvKbxGyb8ViEzZ/L0TXOjHE77wyJsSZ3AAAALxN
         /GRw==
X-Gm-Message-State: AOJu0YybfbSBoNcFbilhc5TJqa13RmbBLsJiIAb6P5a27PLTEvQeBw13
	yMkJHzAzWP1f97P5D1v/+Qrjz+ghvFRwrHhfI1zlj4L6czCyMOnYdjqnl9o4fXqGwgyCAr2aRes
	=
X-Gm-Gg: ASbGncuqDkTuKkexTiCHT3CJ+2iSys3IDhON/J+ePnKv+C2s2ajk5q4nbg6LbJ4tKG2
	CKYYfe5/kfkyBZiM41gKi196SwXAi/t9E69G7JIs8e6Xl2wceQh6tS6nzWYVnh/IfrvoFHfVvKp
	uab6IiAeq2noorKBBk4WrLBi1vkFfLMbRbMB8H1l8h/6xIcNVvNkzJfZayXgRMKxUUoNTY1iz2O
	VXzqtkH/BkkbtRBtMkzuYtNcDly+DHHuKTFaCU+RMid53vK6UMyGd+wLFavSK3sW9MNwPi3APVz
	/MPV5SkjuTLGtSceMVDPC2P20EDjQE1IoV4G4kyMcQjCSjLxh+vVIloZCOpsa51DrOHspX9dxGC
	iFwqO0HULOLK67/wm
X-Google-Smtp-Source: AGHT+IEyw5WO4/V3DckCgmUA+XBEAG2BDnZPcObDIhMlCb8sKImkvV8ejTKI5HQrL/BqFWqTZkozAg==
X-Received: by 2002:a05:6a20:2d13:b0:1f5:679a:226c with SMTP id adf61e73a8af0-2046a3eec77mr13081171637.5.1745881178760;
        Mon, 28 Apr 2025 15:59:38 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25aca4e8sm8534344b3a.162.2025.04.28.15.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 15:59:38 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net 0/8] bnxt_en: Misc. bug fixes
Date: Mon, 28 Apr 2025 15:58:55 -0700
Message-ID: <20250428225903.1867675-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a bug in the driver initialization path, MSIX
setup sequencing issue in the FW error and AER paths, a missing
skb_mark_for_recycle() in the VLAN error path, some ethtool coredump
fixes, an ethtool selftest fix, and an ethtool register dump byte order
fix.

Kalesh AP (1):
  bnxt_en: Fix ethtool selftest output in one of the failure cases

Kashyap Desai (2):
  bnxt_en: call pci_alloc_irq_vectors() after bnxt_reserve_rings()
  bnxt_en: delay pci_alloc_irq_vectors() in the AER path

Michael Chan (1):
  bnxt_en: Fix ethtool -d byte order for 32-bit values

Shravya KN (1):
  bnxt_en: Fix error handling path in bnxt_init_chip()

Shruti Parab (2):
  bnxt_en: Fix coredump logic to free allocated buffer
  bnxt_en: Fix out-of-bound memcpy() during ethtool -w

Somnath Kotur (1):
  bnxt_en: Add missing skb_mark_for_recycle() in bnxt_rx_vlan()

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 28 +++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 .../ethernet/broadcom/bnxt/bnxt_coredump.c    | 20 +++++++---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 40 +++++++++++++++----
 4 files changed, 65 insertions(+), 24 deletions(-)

-- 
2.30.1


