Return-Path: <netdev+bounces-154850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B2FA0012D
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 23:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB8BA7A0209
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 22:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DFE1BD9D0;
	Thu,  2 Jan 2025 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="BslARpji"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-7.cisco.com (alln-iport-7.cisco.com [173.37.142.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AFD1BC061
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735856723; cv=none; b=EniYzsxhyYfi0m7zFDM7UIGFaoc0aQqSSS+DJpZxV4FiKUEj0RWaUydWZXdiiAofWraqvpGckW05capaWfHB+EXHi7TtSc9QlR0FV4w2pGgVfbfd05JYat+LHCyCnEnmNqhCjypx7RFjrhZWBHCGddTtOpvrP7BkCqtHrDsaHGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735856723; c=relaxed/simple;
	bh=sxejFR5oGiv981yybUMwx7IqKQVho/C4w6jgM26IJhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NIddydESJKcbum1k2/cfj+bo1mmAjnvs3dHPdi+HcHzVbFNa4soduwEMaoGniN9JQYsBWKJNM49iSUi9KBuV7iONgUtb5GEOh6ITGiOlbtKLiKROX9Q+A52Yh0/8t2oJj2fqFQhfCXUDts1ONAug6sDp7CrxKeWHIE+SsD32FdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=BslARpji; arc=none smtp.client-ip=173.37.142.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2081; q=dns/txt; s=iport;
  t=1735856722; x=1737066322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZLWmcQoB0ABX1fRY/f/6eKbAMldZ+eTNImtMgciXJMs=;
  b=BslARpjifuzu433GgRl+pzdjrMPlIbyz9PhqJoOZWRcTwsPz3Gqb+diA
   hJIr1LP9oa+Logp+dXejYqemfgqM5BufUXIjcUGFyc9BW/5D/25D+cn/g
   cUaGAAFhpGBOoS+QFbJVSmdy8nN1UkMw5Ci5OPzzVw/lED9QFeGUQoP5s
   0=;
X-CSE-ConnectionGUID: OSCgkXGbQ3y7gr3s+/ljPQ==
X-CSE-MsgGUID: JjCLjELMSP667d8+YnWqWg==
X-IPAS-Result: =?us-ascii?q?A0ANAADxEHdnj4sQJK1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBhBlDSIxyX6cNFIERA1YPAQEBD0QEAQGFBwKKbwImNAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwUUAQEBAQEBOQVJhgiGWwIBAycLA?=
 =?us-ascii?q?TQSEFErKwcSgwGCZQOzFoF5M4EB3jOBbYFIAYVqh19whHcnG4FJRIJQgT5vh?=
 =?us-ascii?q?CpmhXcEiQidV0iBIQNZLAFVEw0KCwcFgTk6AyILCwwLFBwVAoEagQEBFAYVB?=
 =?us-ascii?q?IELRT2CSGlJNwINAjaCICRYgiuEXYRHhFaCSVWCSIIXfIEagipAAwsYDUgRL?=
 =?us-ascii?q?DcGDhsGPm4Hm3k8g20BgQ41RzWmf6EDhCSBY59jGjOqUph8IqQkhGaBZzqBW?=
 =?us-ascii?q?zMaCBsVgyJSGQ+OLQ0JsHIlMjwCBwsBAQMJkVYBAQ?=
IronPort-Data: A9a23:yjPywavA/IP0f+ue/xpMXTisCOfnVLNeMUV32f8akzHdYApBsoF/q
 tZmKT2Da66JZWT8KtxxOdjgpksBvJ7RxoBrQQVu+XpnQy8QgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav656yEhjclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuGYjdJ5xYuajhJs/vb8ks01BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIw3d1cDmJ+2
 vYhcyFSYQrYnKHxxLCDc7w57igjBJGD0II3s3Vky3TdSP0hW52GG/+M7t5D1zB2jcdLdRrcT
 5NGMnw0MlKZPVsWYQZ/5JEWxI9EglH9dD1epFuRqII84nPYy0p6172F3N/9JoTUFZoIwxfDz
 o7A10b7KTUYGfi68gLbrC2g1qz+mxziZ41HQdVU8dYx3QXMnTZMYPEMbnO3qOe0j2ayUsxSL
 kgT9DZoq6UunGSmQsT4Vg+1vFaLuRkTX9cWGOo/gCmO16DdywWUHG4JSnhGctNOnMYwSSYny
 RyPks/lCCJHtKCTTzSW9t+8tTq4NC4UBXUPaS8NUU0O5NyLiIc+kh7CUP59H6OvyN74Azf9x
 3aNtidWulkIpccP06P++RXMhCih48CTCAU0/Q7QGGmi62uVebJJeaSP0nPU7sZvJr/CXwaOp
 iMf2I+a7tg3WMTleDO2fM0BG7Sg5vCgOTLagEJyE5RJy9hL0yD4FWy3yG8iTHqFIvo5lSnVj
 Fg/UD69BaO/3lP3NMebgKroV6zGKJQM8/y+CJg4ifIVOfBMmPevpn0GWKJp9zmFfLIQua8+I
 4yHVs2nEGwXD69qpBLvGLxAjuJ1nXxllDyJLXwe8/hB+efPDJJyYepUWGZikshjt8toXS2Mq
 Y8GbJrQo/mheLChPnePmWLsEbz6BSNmXc+t8ZM/mh+rKQt9E2ZpEO7K3b4kYMRkma8T/tokD
 VnjMnK0PGHX3CWdQS3TMygLQOq2Df5X8ylhVQRyZgnA5pTWSdr0hEvpX8dsJeF/nAGipNYoJ
 8Q4lzKoW60eGmmeqm1HPfEQbuVKLXyWuO5HBAL9CBBXQnKqb1ahFgPMFuc3yBQzMw==
IronPort-HdrOrdr: A9a23:cDMWOqCkLhsLhbHlHemr55DYdb4zR+YMi2TDGXofdfUzSL3+qy
 nAppUmPHPP5Qr5HUtQ++xoW5PwJU80i6QU3WB5B97LN2PbUSmTXeRfBODZrQEIdReTygck79
 YCT0C7Y+eAdGSTSq3BkW+FL+o=
X-Talos-CUID: 9a23:ZuEtU2M4lU5iBu5DfxJM+00kNcocKWyCw22LOAz/DWRRcejA
X-Talos-MUID: 9a23:61hjoQWsAst/Z2fq/B3urxVgGeNN2JzwVh8BwdY3vfadCiMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,286,1728950400"; 
   d="scan'208";a="406875593"
Received: from alln-l-core-02.cisco.com ([173.36.16.139])
  by alln-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 02 Jan 2025 22:25:12 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by alln-l-core-02.cisco.com (Postfix) with ESMTP id 8802118000150;
	Thu,  2 Jan 2025 22:25:12 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 3BC4D20F2009; Thu,  2 Jan 2025 14:25:12 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: benve@cisco.com,
	satishkh@cisco.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: John Daley <johndale@cisco.com>,
	Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next v4 6/6] enic: Obtain the Link speed only after the link comes up
Date: Thu,  2 Jan 2025 14:24:27 -0800
Message-Id: <20250102222427.28370-7-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20250102222427.28370-1-johndale@cisco.com>
References: <20250102222427.28370-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: alln-l-core-02.cisco.com

The link speed is obtained in the RX adaptive coalescing function. It
was being called at probe time when the link may not be up. Change the
call to run after the Link comes up.

The impact of not getting the correct link speed was that the low end of
the adaptive interrupt range was always being set to 0 which could have
caused a slight increase in the number of RX interrupts.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 21cbd7ed7bda..12678bcf96a6 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -109,7 +109,7 @@ static struct enic_intr_mod_table mod_table[ENIC_MAX_COALESCE_TIMERS + 1] = {
 static struct enic_intr_mod_range mod_range[ENIC_MAX_LINK_SPEEDS] = {
 	{0,  0}, /* 0  - 4  Gbps */
 	{0,  3}, /* 4  - 10 Gbps */
-	{3,  6}, /* 10 - 40 Gbps */
+	{3,  6}, /* 10+ Gbps */
 };
 
 static void enic_init_affinity_hint(struct enic *enic)
@@ -466,6 +466,7 @@ static void enic_link_check(struct enic *enic)
 	if (link_status && !carrier_ok) {
 		netdev_info(enic->netdev, "Link UP\n");
 		netif_carrier_on(enic->netdev);
+		enic_set_rx_coal_setting(enic);
 	} else if (!link_status && carrier_ok) {
 		netdev_info(enic->netdev, "Link DOWN\n");
 		netif_carrier_off(enic->netdev);
@@ -3016,7 +3017,6 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	timer_setup(&enic->notify_timer, enic_notify_timer, 0);
 
 	enic_rfs_flw_tbl_init(enic);
-	enic_set_rx_coal_setting(enic);
 	INIT_WORK(&enic->reset, enic_reset);
 	INIT_WORK(&enic->tx_hang_reset, enic_tx_hang_reset);
 	INIT_WORK(&enic->change_mtu_work, enic_change_mtu_work);
-- 
2.35.2


