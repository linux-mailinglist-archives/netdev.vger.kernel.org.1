Return-Path: <netdev+bounces-196728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3566CAD6148
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 23:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763E9173669
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 21:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AF524503C;
	Wed, 11 Jun 2025 21:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="es1BCsef"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF11E23E336;
	Wed, 11 Jun 2025 21:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677261; cv=none; b=eZBx6ihXk9ryckS+Vqs9QO+3r7Pl3lZn4/XUksOIQyCIPb6sSyKmMZJcEpj9h1jDUvgNGZ/UUCOx2isEqLz6wh0R/ekgni6hcgshIaIT+BBn9cC2p+e+ibCn42xmY6FLp7SCFrzBajSL802RyuSIzEwA5ceG+TzpTdJvY9Wi+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677261; c=relaxed/simple;
	bh=w/qE2pwetIGNkIlmcH5nt44JyP/Q8xHENA6U8HkjNTA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t1wXsc55mjK73gjiJ2qxy2nIzxjWu/KOE+BZ7vNib5pehsbEE/dgszOxuZLqjj3IRtOCgqdtFoHQhXKbP59bm3U4O+s7qXQOimyxYrRvMOGa5j4rmsMLA/ib+yBroMDwA4iPMKAuXCQ2pepeZNmGdT8AJgNW9c0mDXmXYWHzA3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=es1BCsef; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id F0489C004E6C;
	Wed, 11 Jun 2025 14:27:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com F0489C004E6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1749677252;
	bh=w/qE2pwetIGNkIlmcH5nt44JyP/Q8xHENA6U8HkjNTA=;
	h=From:To:Cc:Subject:Date:From;
	b=es1BCsefq9/JOnotMXE2D1FfgIzV+L6z9S2gfBXJsO+/0nlylS5OhABg0tn32U8se
	 qKGRlGKf7XLyEOQogNGj0AQTNJfIwM8lEpczQlojhc9QRHBq3rf7PD0DNS1GR3TDvX
	 qPxaDZ5+84SiBAV95ggZ7MnwkxQGF/g+K9KKKsDk=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id CB6F91800051E;
	Wed, 11 Jun 2025 14:27:31 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Justin Chen <justin.chen@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM ASP 2.0 ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2 0/2] net: bcmasp: add support for GRO
Date: Wed, 11 Jun 2025 14:27:28 -0700
Message-Id: <20250611212730.252342-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two patches add support for GRO software interrupt coalescing,
kudos to Zak for doing this on bcmgenet first.

before:

00:03:31     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal
%guest   %idle
00:03:32     all    0.00    0.00    1.51    0.00    0.50    7.29    0.00 0.00   90.70

after:

00:02:35     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal
%guest   %idle
00:02:36     all    0.25    0.00    1.26    0.00    0.50    7.29    0.00 0.00   90.70

Changes in v2:

- corrected net_device variable in the scope

Florian Fainelli (2):
  net: bcmasp: Utilize napi_complete_done() return value
  net: bcmasp: enable GRO software interrupt coalescing by default

 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1


