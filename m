Return-Path: <netdev+bounces-95225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23038C1B40
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F06D1C20C42
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD2913C3F4;
	Fri, 10 May 2024 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KjySGI9x"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9BC13BAE2
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299886; cv=none; b=Oipmwpc12eyyMd5ywbpfTeGXea+hIgnGKLx6pU5pirbiS7M3P1s+LWz4g1qK448HmXfrYz03cOlyMwMPk5iVKH2UgtoZjpEqqeYYTtrTWHL5S7DRCjoZvw4cJpzcY26ZCOGTft2AWs/+xnbL3KHP3KPd5wZma0jW4z8ceX1KH68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299886; c=relaxed/simple;
	bh=chyNa1uFVKbt4AA8a+7DGkvXTJ2CYHEPezpwZXD45PI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=urEm/3AfPbJqDpz82F14QMagIUDM5UnAmcTWMPjbSe+EQtwO4P9s9cSiuAC54GayuKQiMzW9iiAx6hv1uIxlgBXKz9jNGIJ6y1NWzAd6gfR1WlhiTas7NOF9DfL0WhZN85cJyz+gi/OU3i8M8mgmGUjJ2PKpjghva8i8h2QQk1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KjySGI9x; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 7C6A3C0000D8;
	Thu,  9 May 2024 17:03:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 7C6A3C0000D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1715299414;
	bh=chyNa1uFVKbt4AA8a+7DGkvXTJ2CYHEPezpwZXD45PI=;
	h=From:To:Cc:Subject:Date:From;
	b=KjySGI9xgTSc7tTopZcE/1Hx42LyXxmJrNgW1vPis3ukLhPEf6mSyHzL0QaiYadtA
	 nxEppxLPMY/6VKGvf9tzBan2JpFxEo1AbFUWm01mQZrlx/7TnIdq+4xO8Zjiikkzcx
	 vsOaW5YBFYllCsciAHzoiboUdfC1BaV7Py3rf8NE=
Received: from lvnvdd6494.lvn.broadcom.net (lvnvdd6494.lvn.broadcom.net [10.36.237.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 99D2D18041CAC4;
	Thu,  9 May 2024 17:03:32 -0700 (PDT)
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
To: netdev@vger.kernel.org
Cc: jitendra.vegiraju@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH, net-next, 0/2] net: stmmac: support for BCM8958x SoC
Date: Thu,  9 May 2024 17:03:29 -0700
Message-Id: <20240510000331.154486-1-jitendra.vegiraju@broadcom.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchseries adds PCI driver support for Broadcom BCM8958x SoC devices.
BCM8958x core functionality is similar to existing dwxgmac2 implementation.
However, there are minor conflicting differences in dma operations.

This driver will utilize dwxgmac2 core functions as much possible and
implement alternative functions wherever functionality differs.

Jitendra Vegiraju (2):
  Export dma_ops for reuse in glue drivers.
  PCI driver for BCM8958X SoC

 MAINTAINERS                                   |   7 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-brcm.c  | 657 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  62 ++
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 149 ++--
 6 files changed, 826 insertions(+), 61 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c

-- 
2.25.1


