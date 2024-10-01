Return-Path: <netdev+bounces-130899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5709298BE8B
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9F71B25B30
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B070C1C9DF0;
	Tue,  1 Oct 2024 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WWZgOMiD"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A991C57AB;
	Tue,  1 Oct 2024 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790716; cv=none; b=KfSPXluPM0uL0dxMoBCqdeif7aFLM/7vATnpo48BQfou9BuY6MMORdIPjFTnZQ33HX9s5pDwKkOXfWzG9Y3+mpLmzkzmaFadTgBenVIi/BHsmNzC0IOK5du8z41Q4IvlR2JyQZI3DY4Ey/viGyKZQV4MJHi4NzYraVs/UyN2i+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790716; c=relaxed/simple;
	bh=IQNwJFI8TvMFVZPm7mnfUOkdmc9DC93Mfp8/gqo+RIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=A+LDCSn1cbZ2nE2GLQgvR+UQEBeHXGsd2W2+6QQukRZon8teh0wYix7DKTCTHJKcuRtlPN9h8U5G6+qHRFGKWVxaUOesCZuzZojWFRrAG14RC9oGfmcC97sNwx/QPsVQNajQQoRpsArUJZAfu79zjrm6qy357aS5I74iB8Bm7a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WWZgOMiD; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727790714; x=1759326714;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=IQNwJFI8TvMFVZPm7mnfUOkdmc9DC93Mfp8/gqo+RIA=;
  b=WWZgOMiDZGqcy9aPewUrNFY17snR9XHMsz0OvcHKXjFhEi9gCvTqNiqA
   VOnVWXmbZQioKi4OW1ODYJVyqeHHRJG82YRdfYoU1BneDXdO+Ig/lIjju
   SX/uq8oPTMF5XFdeEaOvLJxuIRvMMldmVl6nyiJc7PySJy9Y7O+gXpqdY
   F+em+xcL6hTJmI8cWGeWMqa4/2Y6V9bRndPuqBEe5HRyxdt7wBVUdNML9
   Ntzwyq5U0dFgqcC4VUc8b3kpHm5xq2qcFMkDQwR8Pq86b43WP6oRQJt2m
   TYnanwHl6C+MO/QxaJoWFONpJT/LGp01wl4qi8cqNuJu4bKgyL2IhebIi
   g==;
X-CSE-ConnectionGUID: PEtbMb/SSnq9y/Yd81naGA==
X-CSE-MsgGUID: D4z/zEJoRtS4sikhG2sAAg==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="199893172"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 06:51:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 06:51:38 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 06:51:35 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Tue, 1 Oct 2024 15:50:42 +0200
Subject: [PATCH net-next 12/15] net: sparx5: ops out function for setting
 the port mux
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241001-b4-sparx5-lan969x-switch-driver-v1-12-8c6896fdce66@microchip.com>
References: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
In-Reply-To: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lars Povlsen <lars.povlsen@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
	<jensemil.schulzostergaard@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>, <horms@kernel.org>,
	<justinstitt@google.com>, <gal@nvidia.com>, <aakash.r.menon@gmail.com>,
	<jacob.e.keller@intel.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

Port muxing is configured based on the supported port modes. As these
modes can differ on Sparx5 and lan969x we ops out the port muxing
function.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c | 1 +
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h | 6 ++++++
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c | 7 +++----
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 0d8cb9a3ed1f..bcdce23b735f 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -986,6 +986,7 @@ static const struct sparx5_ops sparx5_ops = {
 	.get_port_dev_bit        = &sparx5_port_dev_mapping,
 	.get_hsch_max_group_rate = &sparx5_get_hsch_max_group_rate,
 	.get_sdlb_group          = &sparx5_get_sdlb_group,
+	.set_port_mux            = &sparx5_port_mux_set,
 };
 
 static const struct sparx5_match_data sparx5_desc = {
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 99174aef88f8..6fe840dbaf98 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -269,6 +269,8 @@ struct sparx5_ops {
 	u32  (*get_port_dev_bit)(struct sparx5 *sparx5, int port);
 	u32  (*get_hsch_max_group_rate)(int grp);
 	struct sparx5_sdlb_group *(*get_sdlb_group)(int idx);
+	int (*set_port_mux)(struct sparx5 *sparx5, struct sparx5_port *port,
+			    struct sparx5_port_config *conf);
 };
 
 struct sparx5_main_io_resource {
@@ -490,6 +492,10 @@ int sparx5_pool_get(struct sparx5_pool_entry *pool, int size, u32 *id);
 int sparx5_pool_get_with_idx(struct sparx5_pool_entry *pool, int size, u32 idx,
 			     u32 *id);
 
+/* sparx5_port.c */
+int sparx5_port_mux_set(struct sparx5 *sparx5, struct sparx5_port *port,
+			struct sparx5_port_config *conf);
+
 /* sparx5_sdlb.c */
 #define SPX5_SDLB_PUP_TOKEN_DISABLE 0x1FFF
 #define SPX5_SDLB_PUP_TOKEN_MAX (SPX5_SDLB_PUP_TOKEN_DISABLE - 1)
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index 49ff94db0e63..0dc2201fe653 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -516,9 +516,8 @@ static int sparx5_port_fifo_sz(struct sparx5 *sparx5,
 /* Configure port muxing:
  * QSGMII:     4x2G5 devices
  */
-static int sparx5_port_mux_set(struct sparx5 *sparx5,
-			       struct sparx5_port *port,
-			       struct sparx5_port_config *conf)
+int sparx5_port_mux_set(struct sparx5 *sparx5, struct sparx5_port *port,
+			struct sparx5_port_config *conf)
 {
 	u32 portno = port->portno;
 	u32 inst;
@@ -1039,7 +1038,7 @@ int sparx5_port_init(struct sparx5 *sparx5,
 	pcsinst = spx5_inst_get(sparx5, pcs, pix);
 
 	/* Set the mux port mode  */
-	err = sparx5_port_mux_set(sparx5, port, conf);
+	err = ops->set_port_mux(sparx5, port, conf);
 	if (err)
 		return err;
 

-- 
2.34.1


