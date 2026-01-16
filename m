Return-Path: <netdev+bounces-250379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EB1D29E93
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5EF63004ED9
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13A4314B6E;
	Fri, 16 Jan 2026 02:09:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793DA2FFF8C;
	Fri, 16 Jan 2026 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768529359; cv=none; b=RW6OxLT4oBio+ZjWgqssr7fths5g8B47xxXXiKGe44UfQHQs1aEZ7Zjl2DM9be9h+H3o+c+L+f+Ct0JovPRpECbFhDfsNGUrygBTmOuKqmi36CLCtmWR5BrT/7u7ClmbOA4gz5vQjv9w/HVFIsLYkXYUpXDaQOY1lGzFGQVIEfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768529359; c=relaxed/simple;
	bh=plYdEJhyUK9bK3WO6kWX+zQQh5c4Lb5V0fZI8Dx3FZw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=ZK3EG3422psuyHxHHR24IBUR0hxWC01flJBQCKOm396m1270z3MOFbxYlU7CrUdMKgYbRJ4IQr/hXbrDqXZZktBtPqqHxCbLHLDol69hNqkoAhqqWjBXLVasfNaqW6gr7zwRSvb/PcMMWqS7SGHcx4pOO3qy05swqM3Bug/Hffw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 16 Jan
 2026 10:09:15 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 16 Jan 2026 10:09:15 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Subject: [PATCH net-next v2 00/15] net: ftgmac100: Various probe cleanups
Date: Fri, 16 Jan 2026 10:09:11 +0800
Message-ID: <20260116-ftgmac-cleanup-v2-0-81f41f01f2a8@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMedaWkC/12NywqDMBBFf0Vm3SnJ+CB01f8oLpI40UCNkqRiE
 f+9wWWXh8M994DE0XOCR3VA5M0nv4QCdKvATjqMjH4oDCSolSQUujzO2qJ9sw6fFUkYotq4plM
 SymiN7Px+BV8QOGPgPUNfzORTXuL3etrk5Uu0E1K0/9FNokDTKW50PShn+KnTyjxkttPdLjP05
 3n+AAX8EN27AAAA
X-Change-ID: 20251208-ftgmac-cleanup-20b223bf4681
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768529355; l=2007;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=plYdEJhyUK9bK3WO6kWX+zQQh5c4Lb5V0fZI8Dx3FZw=;
 b=/UK3aHTZvrmlMTZGpHO3To2wcYCnL2r1BPTHJLN7jXOIuyvdYTIVrc1Z02w9Lwhhcy3SZ9VLY
 QJNnIs86TbVCYo0a8VinYTWz9dZGOlY0VUP+1fGeMW2O0I1vsqAfgQr
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

The probe function of the ftgmac100 is rather complex, due to the way
it has evolved over time, dealing with poor DT descriptions, and new
variants of the MAC.

Make use of DT match data to identify the MAC variant, rather than
looking at the compatible string all the time.

Make use of devm_ calls to simplify cleanup. This indirectly fixes
inconsistent goto label names.

Always probe the MDIO bus, when it exists. This simplifies the logic a
bit.

Move code into helpers to simply probe.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
Changes in v2:
- Add net-next prefix.
- [08/15] Updated commit message.
- [04/15] Deleted {}.
- Link to v1: https://lore.kernel.org/r/20260105-ftgmac-cleanup-v1-0-b68e4a3d8fbe@aspeedtech.com

---
Andrew Lunn (15):
      net: ftgmac100: List all compatibles
      net: ftgmac100: Add match data containing MAC ID
      net: ftgmac100: Replace all of_device_is_compatible()
      net: ftgmac100: Use devm_alloc_etherdev()
      net: ftgmac100: Use devm_request_memory_region/devm_ioremap
      net: ftgmac100: Use devm_clk_get_enabled
      net: ftgmac100: Simplify error handling for ftgmac100_initial_mac
      net: ftgmac100: Move NCSI probe code into a helper
      net: ftgmac100: Always register the MDIO bus when it exists
      net: ftgmac100: Simplify legacy MDIO setup
      net: ftgmac100: Move DT probe into a helper
      net: ftgmac100: Remove redundant PHY_POLL
      net: ftgmac100: Simplify error handling for ftgmac100_setup_mdio
      net: ftgmac100: Simplify condition on HW arbitration
      net: ftgmac100: Fix wrong netif_napi_del in release

 drivers/net/ethernet/faraday/ftgmac100.c | 305 +++++++++++++++++--------------
 1 file changed, 170 insertions(+), 135 deletions(-)
---
base-commit: d4596891e72cbf155d61798a81ce9d36b69bfaf4
change-id: 20251208-ftgmac-cleanup-20b223bf4681

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>


