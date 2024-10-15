Return-Path: <netdev+bounces-135804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0B899F3F9
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4972837DF
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFE21F9ED1;
	Tue, 15 Oct 2024 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZDPfHu9B"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C704F1F9413;
	Tue, 15 Oct 2024 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729013109; cv=none; b=DuUsh9FXuDbd1beUQlH4l9GEaQ/MM/l/LwVnrO+B9wcJLDzChrawNYBfsSpRpbAibVjNeuwZzcVPVrFJmjP9VgSoyGB+N/mw9uOHnQTu+QuFzVIAHIZHWX/czewcQHKJ7f1T8EpzLIuAvzuFygSoEUjxfzePzpWczhQGzWwOWOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729013109; c=relaxed/simple;
	bh=I3GxsPSJ6xEG1yqrXsDlovT1d9QrEwW6pK+s5+J/rF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nkp3MDCx/KsXTIJb+14aO3zuDjv/MlOLxDNU/OLh1Inpa0yuGzK1QU0kGHbZyIauRZ9PoxeEK9RBgxyI03O0UScGfN1xMRjYemfNqFR5Ad2R+aStxUCekoRtyjKGaHw6Y8m3SUWkQ62SansDaqa8WrSywPQITtPJFMwmZhWPv6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZDPfHu9B; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id CBC03C0003E8;
	Tue, 15 Oct 2024 10:25:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com CBC03C0003E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1729013100;
	bh=I3GxsPSJ6xEG1yqrXsDlovT1d9QrEwW6pK+s5+J/rF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZDPfHu9BEb4bVAzL7Hz9cxfuD/FVZ8ycgA4/+XsyJsn/eu0EhSe8y/nDQKG3NqUMA
	 vcl39PwkgAp9H6MXqWUKHN+IgXIwiOv3JJ75UVZPzgvIgehyINJKZPra7f8ak+Yxic
	 9AWDaY0OMIclnq2gppQEzt7LnA+KDe8gzFE8ntvE=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 6967418041CACA;
	Tue, 15 Oct 2024 10:25:00 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:)
Subject: [PATCH 1/2] net: systemport: Remove unused txchk accessors
Date: Tue, 15 Oct 2024 10:24:57 -0700
Message-ID: <20241015172458.673241-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241015172458.673241-1-florian.fainelli@broadcom.com>
References: <20241015172458.673241-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vladimir reported the following warning with clang-16 and W=1:

warning: unused function 'txchk_readl' [-Wunused-function]
BCM_SYSPORT_IO_MACRO(txchk, SYS_PORT_TXCHK_OFFSET);
note: expanded from macro 'BCM_SYSPORT_IO_MACRO'

warning: unused function 'txchk_writel' [-Wunused-function]
note: expanded from macro 'BCM_SYSPORT_IO_MACRO'

warning: unused function 'tbuf_readl' [-Wunused-function]
BCM_SYSPORT_IO_MACRO(tbuf, SYS_PORT_TBUF_OFFSET);
note: expanded from macro 'BCM_SYSPORT_IO_MACRO'

warning: unused function 'tbuf_writel' [-Wunused-function]
note: expanded from macro 'BCM_SYSPORT_IO_MACRO'

The TXCHK block is not being accessed, remove the IO macros used to
access this block. No functional impact.

Reported-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 9332a9390f0d..05c83cb3871c 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -46,7 +46,6 @@ BCM_SYSPORT_IO_MACRO(umac, SYS_PORT_UMAC_OFFSET);
 BCM_SYSPORT_IO_MACRO(gib, SYS_PORT_GIB_OFFSET);
 BCM_SYSPORT_IO_MACRO(tdma, SYS_PORT_TDMA_OFFSET);
 BCM_SYSPORT_IO_MACRO(rxchk, SYS_PORT_RXCHK_OFFSET);
-BCM_SYSPORT_IO_MACRO(txchk, SYS_PORT_TXCHK_OFFSET);
 BCM_SYSPORT_IO_MACRO(rbuf, SYS_PORT_RBUF_OFFSET);
 BCM_SYSPORT_IO_MACRO(tbuf, SYS_PORT_TBUF_OFFSET);
 BCM_SYSPORT_IO_MACRO(topctrl, SYS_PORT_TOPCTRL_OFFSET);
-- 
2.43.0


