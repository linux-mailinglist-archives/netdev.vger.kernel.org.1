Return-Path: <netdev+bounces-174923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1F8A61545
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 16:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E467B7AD8BF
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 15:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C890D20012B;
	Fri, 14 Mar 2025 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcyzSwVf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD331FE450;
	Fri, 14 Mar 2025 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741967415; cv=none; b=LJVkeqKqjfWKpuC+as5wD+IV7yDwGdUJA3srzZx/wx1gScwb2LjGil7Y4E74i+nm5/LfiObyBVmWocC0+9iMpre7tAIs4JpXlTKd96ccdU+Ea5i+r5dNd60l8KvSM4+q5SRJFiajv2wmcastD43CSK/5V9mXneatJJI+dSwut40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741967415; c=relaxed/simple;
	bh=yd6hd/BIcy+u7PxvBdVNuloLY1tbTq52bYWAIn5DalA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IwKZtIhdr+nF+OWivSOsd4VA+Rov38PZKaKTHW9I6eOiHrNVudBXWecvGXDs4T1Vdia4sh7JD/i/1Fixmk1sXZa6837If+sBsoEr5JGbfmk21Vt+PX5/USrFSwrbnZgBWlQXncllltO85HjZjmg8qNbd4ZhyZHuCKamPneNbnrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcyzSwVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CDFC4CEE3;
	Fri, 14 Mar 2025 15:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741967415;
	bh=yd6hd/BIcy+u7PxvBdVNuloLY1tbTq52bYWAIn5DalA=;
	h=From:To:Cc:Subject:Date:From;
	b=RcyzSwVfNUARNiBeEW1oLINmdQnOb3bKeLpd+DiRptcO3R8BSB2uMDYYrxqcBdSEz
	 9hSbhEUg2dCFoKOQPs3NXhS2EJAfQMxXZcMgKGWCi8MtSEP0cNpi4HUN7jCLYRggNj
	 xVr5Vz6GH995FIValA497TwC9j1ZpcLqH7Ud0tZhK35Ysa+zIHMp4yE8FCzaWVBDwf
	 o4qBSg2eQdF4HxTGUhGqPumQQpU7mf4np2DK9Qf6aoot/HTyhihVga1isV4UdKQCWe
	 sJsqzB67HopEghFtRaFz2C3mBJnqqxdZqB5XDEYlm6d5gRTbrwU/mDrfZ0Q1fDQh4w
	 FG19YajDekBdg==
From: Arnd Bergmann <arnd@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: airoha: fix CONFIG_DEBUG_FS check
Date: Fri, 14 Mar 2025 16:49:59 +0100
Message-Id: <20250314155009.4114308-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The #if check causes a build failure when CONFIG_DEBUG_FS is turned
off:

In file included from drivers/net/ethernet/airoha/airoha_eth.c:17:
drivers/net/ethernet/airoha/airoha_eth.h:543:5: error: "CONFIG_DEBUG_FS" is not defined, evaluates to 0 [-Werror=undef]
  543 | #if CONFIG_DEBUG_FS
      |     ^~~~~~~~~~~~~~~

Replace it with the correct #ifdef.

Fixes: 3fe15c640f38 ("net: airoha: Introduce PPE debugfs support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/airoha/airoha_eth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index f66b9b736b94..60690b685710 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -540,7 +540,7 @@ void airoha_ppe_deinit(struct airoha_eth *eth);
 struct airoha_foe_entry *airoha_ppe_foe_get_entry(struct airoha_ppe *ppe,
 						  u32 hash);
 
-#if CONFIG_DEBUG_FS
+#ifdef CONFIG_DEBUG_FS
 int airoha_ppe_debugfs_init(struct airoha_ppe *ppe);
 #else
 static inline int airoha_ppe_debugfs_init(struct airoha_ppe *ppe)
-- 
2.39.5


