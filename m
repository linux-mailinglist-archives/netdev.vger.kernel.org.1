Return-Path: <netdev+bounces-247203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A76CF5C0D
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 23:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D824130621F4
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 21:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7F5311C07;
	Mon,  5 Jan 2026 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OIwHbCp7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DCF311596
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767650350; cv=none; b=qxlRdiAOdVagi8f3qvno2qY98t1I4rJE/xyYVpbVtVUPNsVQeVxHPpM/Ey5k8vPVECjYC1hIfsIRYjk5x2wR5bDPiLPNqI/53bOk6tUeFiUZt4nYWFBS7D7+ycIZVjkHmKIdyriUZDp/5putdwbakNme1BjcbeVd6w2QRb6PCy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767650350; c=relaxed/simple;
	bh=2y6gvPUMZB1F5XkwVOQy8T/OgBObbkJ6uopiQXNdcnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oH8Z9U9BjC4HMhL3xaxTbJ5b2NBN+Cz6NotVkvDmnvxGUCyGfAZcx6yNSyiHddun8h59Kx4z3vp9DXjZdinDIMlzazY/KHzCy5NkJPq/DyZa1E3nzlI8rMoolqCu2f6uqqZ/Y+NQD4YvE3KE2FU2WDbRf7KLcB0diwQGeMB2GF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OIwHbCp7; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a09a3bd9c5so3006905ad.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 13:59:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767650348; x=1768255148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SW2yzsILS2lBVvFYQ0YHd6KbrHKMGYAHLWnLBaGChE=;
        b=nKAyUsnYyNMOAyBWnGv/L7cXEhFYKhQNBu/w1PCu2zYtebjVz/+odW/cgDQjMR8ETY
         i+Pa1VpEPgiUzbDjxBh30vSL1OGZPxLKaAgp/5+LzepkdEVBCHr9FCREEubKV4myeE0k
         W72bK0dtrbZmIZ7QWE0RfPHDazYjFJBlGUcaf5nle/NY9vWpEltGAWEN22H9TXMHV6IK
         SoCSOfQmaYq9ZIIVnqb3+m1TOg8rh1yU7f3KezaDhwmXkKB3Tp6YjjeUwCfEakkFkTcu
         kZguSa+RwwuLlVjAqZ9ijtFEfBIfHB8CLD2LK9kK4YxVPS6+0WpvU7KwtXb1uYllvHdK
         Bveg==
X-Gm-Message-State: AOJu0YzDb/VUQddbAla9mrYywTaAXnyNNPZjzaqeXSa1CX5w/cofCbiC
	nbRaEWaGSiMYIMbMfb7tAmx9CJuQhS1qc63dtM3dlN8vkBf4NCnFhSVwRh2VXYW7QQEuSmDVav+
	v8OpmPIvqmsthcZhVTvBkwyFIvLtGmurP69SPjFZcOl1aCUT0ZMWpJqjOTiFOFkCdL09UTU9RdL
	BJfO/9W1vOmLpxiHTcpC6Wmu1bB1ttTkh9uV2QgPyHTxfAErP/8eyFMU1+5/6RM1VHJLUsdIXSW
	XNDSYy9xz0=
X-Gm-Gg: AY/fxX7NWtY4fYBAZddz3CmVMGZX/K0p/nj/XgIcNqna6vcS4nKeVvTkYhXIGFlmNXo
	i8hZlci5ZbTkwYFS4CIMynVM20XnsTnGEN3h2qASyXmVQ7rbTbJyjj78V+/EpLM58XklWHw97eP
	xdAQbUozsFx7J/a9us8btj/5f6uzXfzJ3XgDskp/0iR6G4EW3Ut27JhczxRxErNBIvqvj2ho3j8
	NCkBe4sMhYEkoYRXnrGE62XclCl8PMB12Oo9Wsjqk5lD7FFPJVh7PQJ+xGoV//8b85a6QdSh5NN
	7Ka69lF8iRXwRm9LdfbKFHvD4mODe1GjSB4O1KZNKTcBoW+IQRSGW0YVoshFb6RHYub/70LKU+g
	goZCs92YvFY+SjbF8/nge2eBus7HxO9tXyPjWJy/fsJEWs+phvE54Wo5A+ifVeu15VGxlQVcc/B
	CBTWKMFDqnltP/yclfpKp4XQ+s89NAnbu/9N5Kl6i+0Yt9oK0=
X-Google-Smtp-Source: AGHT+IHUMrdm0TdlYbncAGaldutS0wzsliYzR8Ozfs46p6As4gNN3muBi0G+8NYnABf80i9VREyD43U0KTrC
X-Received: by 2002:a17:902:da88:b0:295:1e50:e7cb with SMTP id d9443c01a7336-2a3e2d88fccmr10628575ad.23.1767650348044;
        Mon, 05 Jan 2026 13:59:08 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3cc4ab4sm427245ad.44.2026.01.05.13.59.07
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jan 2026 13:59:08 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f4d60d1fbdso19040431cf.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 13:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767650347; x=1768255147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8SW2yzsILS2lBVvFYQ0YHd6KbrHKMGYAHLWnLBaGChE=;
        b=OIwHbCp7rtNADDcE08LLhW2mZd9fSGXMiTk/UlRFZxk59xUC8inn9zUiyjTEMClB5D
         5JWamHT7R8b4CaeIGVAq8cuQuX4LVlirTkMmgiKdnD1QKBscxPf+R9JE8f9c1LD3AU17
         G7xRXN8B0ZegDwT4nXnofoj4MilgZgH3jSz64=
X-Received: by 2002:a05:622a:2b46:b0:4ee:1857:2673 with SMTP id d75a77b69052e-4ffa77581d2mr14150051cf.35.1767650346868;
        Mon, 05 Jan 2026 13:59:06 -0800 (PST)
X-Received: by 2002:a05:622a:2b46:b0:4ee:1857:2673 with SMTP id d75a77b69052e-4ffa77581d2mr14149881cf.35.1767650346487;
        Mon, 05 Jan 2026 13:59:06 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8d38e12sm1882051cf.3.2026.01.05.13.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:59:05 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 0/6] bnxt_en: Updates for net-next
Date: Mon,  5 Jan 2026 13:58:27 -0800
Message-ID: <20260105215833.46125-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This patchset updates the driver with a FW interface update to support
FEC stats histogram and NVRAM defragmentation.  Patch #2 adds PTP
cross timestamps [1].  Patch #3 adds FEC histogram stats.  Patch #4 adds
NVRAM defragmentation support that prevents FW update failure when NVRAM
is fragmented.  Patch #5 improves RSS distribution accuracy when certain
number of rings is in use.  The last patch adds ethtool
.get_link_ext_state() support.

[1] v1 posted earlier:
https://lore.kernel.org/netdev/20251126215648.1885936-8-michael.chan@broadcom.com/

Michael Chan (4):
  bnxt_en: Update FW interface to 1.10.3.151
  bnxt_en: Add support for FEC bin histograms
  bnxt_en: Use a larger RSS indirection table on P5_PLUS chips
  bnxt_en: Implement ethtool_ops -> get_link_ext_state()

Pavan Chebbi (2):
  bnxt_en: Add PTP .getcrosststamp() interface to get device/host times
  bnxt_en: Defrag the NVRAM region when resizing UPDATE region fails

 drivers/infiniband/hw/bnxt_re/main.c          |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  41 ++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   6 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 104 ++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c |  47 +++++
 include/linux/bnxt/hsi.h                      | 167 ++++++++++++++++--
 6 files changed, 347 insertions(+), 22 deletions(-)

-- 
2.51.0


