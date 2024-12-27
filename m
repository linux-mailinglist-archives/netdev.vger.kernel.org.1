Return-Path: <netdev+bounces-154322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81ABE9FCFCC
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 04:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A193A050C
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 03:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F073398A;
	Fri, 27 Dec 2024 03:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="NhuWExsY"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4700250276
	for <netdev@vger.kernel.org>; Fri, 27 Dec 2024 03:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735269349; cv=none; b=LTniKN/4bo5P6ucaeWRTpUHOoKy3Fhj8nxDjxo+1JZWNPTSn0h5gru1LEnPhpuy/e9bmRPA3K38cTjjHzY86oYWH6y47K+S/h+hYqfh7h0O0oePLswf8dE9WRaUJxZ5ZUCfaJVe3XouUX0Xqk1YcGRuiKx+nONSAQIlDIRJ7YY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735269349; c=relaxed/simple;
	bh=QzqODc2yYFu5IqkEV2LuefBllbBxuQeUrTCk6sDnI/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mrXOTwXN8mX5DMck+VGrI5MetWyP04rqAZ5kcwlXrIhsiZkBfwwNBLYTBCUjdF72LZ+vpE/GWZhHpFlP6gprez6MZLJMxFK4+OyRxUSVQBwnD/tol6pUv+ilySEJp2RnyhtDg4DMF6HCXLlnJwkBOzk5uTCxhltJWopJ04teyrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=NhuWExsY; arc=none smtp.client-ip=173.37.142.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2543; q=dns/txt; s=iport;
  t=1735269348; x=1736478948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lnjinSy/aS7zRu5fiK4HVq2lup4kqm6HcWbCh/R+te4=;
  b=NhuWExsY0On5H6kGlA6cvjI5PbmbrZ1gY2G8IzSon3DpkOlqTIROeCrF
   +TgodpeB1mDNiMHnh6HwGccukP9iV6GI0BTLr9AK6UEps1Mhd5ZGfoeQV
   Pb0QCS4lrV0wNcrYHrQROukYj7UAQMHnSRij5wU6+MbiWIGR7QHEJ9yKP
   s=;
X-CSE-ConnectionGUID: 3VyCpJEyQbeO5vIHBFVGDQ==
X-CSE-MsgGUID: MS0+egy1TDSuU+E47eBJSQ==
X-IPAS-Result: =?us-ascii?q?A0ANAABSG25nj4v/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBhBlDSIxyX6cNFIERA1YPAQEBD0QEAQGFBwKKbgImNAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwUUAQEBAQEBOQUOO4YIhlsCAQMnC?=
 =?us-ascii?q?wE0EhBRKysHEoMBgmUDrw2BeTOBAd4zgW2BSAGFaodfcIR3JxuBSUSCUIE+b?=
 =?us-ascii?q?4QqZoV3BIkVnnVIgSEDWSwBVRMNCgsHBYE5OgMiDAsMCxQcFQKBHoEBARQGF?=
 =?us-ascii?q?QSBC0U9gkppSTcCDQI2giAkWIJNhReEYYRXgklVgnuCF3yBHYIlQAMLGA1IE?=
 =?us-ascii?q?Sw3Bg4bBj5uB5xkRoNzAYEOfKc0oQOEJIFjn2MaM6pSmHwioztphGaBZzqBW?=
 =?us-ascii?q?zMaCBsVgyJSGQ+OKgMNCbYSJTI8AgcLAQEDCZE3AQE?=
IronPort-Data: A9a23:Zcxhu6PcSmK8rBrvrR1Bl8FynXyQoLVcMsEvi/4bfWQNrUojhWBSm
 mMfX2/TM6yDYmLwfd11a9u+8UgAsJPTx9diTHM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFjmE+0/F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WlnlV
 e/a+ZWFZAb/gWEsawr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj665QHWouH6AJw+x6JjxQ1
 NwyBg4iQinW0opawJrjIgVtrt4oIM+uOMYUvWttiGmDS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2M0PXwsYDUXUrsTIJA5nOGkj33yWzZZs1mS46Ew5gA/ySQtiOK9bICKJoPiqcN9u33A5
 W/J7j3FLioHCZ+ylWWI2FCXv7qa9c/8cNlPTOLjrKECbEeo7mAaFhATfVeyv/S8jkmwR5RZJ
 lB80icisK075kG3Ztb6WBK8rTiPuRt0c9lNGeQS6wyXzKfQpQGDCQAsRzhNctE598k7WTAny
 HeNgtXvQzdv2JWNQHiQ8La8tz6+OSEJa2QFYEcsSwYZ79T9iJ88gwiJTdt5FqOxyNrvFlnNL
 yuitiMygfAXyMUMzaj+pQqBiDO3rZ+PRQkwjunKYo67xlhHdaW9RaG50FLWyqteDaazYGeuk
 EFRzqBy89syJZ2KkSWMRsAEE7eo++uJPVXgbbhHQcJJG9OFpSLLQGxA3AySMnuFJSrtRNMIX
 KMxkV4LjHOwFCL2BUOSX25XI5hwpUQHPY+5Ps04lvIUPvBMmPavpUmCn3K40WH3i1QLmqoiI
 5qdesvEJS9FUvk9l2XmFrxMjOdDKsUCKYX7G8mTI/OPjOr2WZJpYe1eWLdzRrljtfrf8V+9H
 yh3apTWlEk3vBLCjtn/qtNLcgtQchDX9Lj9qtdccaaYMxF6FWQ6Q/7XyvVJRmCWt/o9qws8x
 VnkAhUw4AOm3RXvcFzWAlg9M+mHdcgk8hoG0dkEYQ3AN44LPd33tP93mlpeVeVPydGPOtYvE
 KBfJ57RX6gQItkFkhxEBaTAQEVZXEzDrWqz0+CNMFDTo7YIq9T1x+LZ
IronPort-HdrOrdr: A9a23:KQLnia1xNi3quwob5JPRIAqjBLUkLtp133Aq2lEZdPWaSKOlfq
 eV7ZMmPHDP6Qr5NEtMpTnEAtjjfZq+z+8Q3WBuB9eftWDd0QPCRr2Kr7GSpgEIcBeRygcy78
 tdmtBFeb7N5ZwQt7eC3OF+eOxQpuW6zA==
X-Talos-CUID: =?us-ascii?q?9a23=3Az4rSAmseWa4yx+XfqIlAibQ06It+TGz21FX9Mna?=
 =?us-ascii?q?yBEE0Vpy1Y3Gu149dxp8=3D?=
X-Talos-MUID: 9a23:YHi3/AgiZUUOmlwErj8u28MpEfwwoKmhGRkxva4bhoqpaXN9ERWmtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,268,1728950400"; 
   d="scan'208";a="402842747"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by alln-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 27 Dec 2024 03:14:34 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTP id 2D0A51800022C;
	Fri, 27 Dec 2024 03:14:34 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id C831920F2008; Thu, 26 Dec 2024 19:14:33 -0800 (PST)
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
Subject: [PATCH net-next v2 5/5] enic: Obtain the Link speed only after the link comes up
Date: Thu, 26 Dec 2024 19:14:10 -0800
Message-Id: <20241227031410.25607-6-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20241227031410.25607-1-johndale@cisco.com>
References: <20241227031410.25607-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-02.cisco.com

The link speed that is used to index the table of minimum RX adaptive
coalescing values is incorrect because the link speed was being checked
before the link was up. Change the adaptive RX coalescing setup function
to run after the Link comes up.

There could be a minor bandwidth impact when adaptive interrupts were
enabled. The low end of the adaptive interrupt range was being set to 0
for all packets instead of 3us for packets less the 1000 bytes and 6us
for larger packet for link speeds greater

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 5bfd89749237..7c2bfe4b7997 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -84,6 +84,8 @@ MODULE_AUTHOR("Scott Feldman <scofeldm@cisco.com>");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, enic_id_table);
 
+static void enic_set_rx_coal_setting(struct enic *enic);
+
 #define ENIC_MAX_COALESCE_TIMERS		10
 /*  Interrupt moderation table, which will be used to decide the
  *  coalescing timer values
@@ -109,7 +111,7 @@ static struct enic_intr_mod_table mod_table[ENIC_MAX_COALESCE_TIMERS + 1] = {
 static struct enic_intr_mod_range mod_range[ENIC_MAX_LINK_SPEEDS] = {
 	{0,  0}, /* 0  - 4  Gbps */
 	{0,  3}, /* 4  - 10 Gbps */
-	{3,  6}, /* 10 - 40 Gbps */
+	{3,  6}, /* 10+ Gbps */
 };
 
 static void enic_init_affinity_hint(struct enic *enic)
@@ -436,6 +438,7 @@ static void enic_link_check(struct enic *enic)
 	if (link_status && !carrier_ok) {
 		netdev_info(enic->netdev, "Link UP\n");
 		netif_carrier_on(enic->netdev);
+		enic_set_rx_coal_setting(enic);
 	} else if (!link_status && carrier_ok) {
 		netdev_info(enic->netdev, "Link DOWN\n");
 		netif_carrier_off(enic->netdev);
@@ -3016,7 +3019,6 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	timer_setup(&enic->notify_timer, enic_notify_timer, 0);
 
 	enic_rfs_flw_tbl_init(enic);
-	enic_set_rx_coal_setting(enic);
 	INIT_WORK(&enic->reset, enic_reset);
 	INIT_WORK(&enic->tx_hang_reset, enic_tx_hang_reset);
 	INIT_WORK(&enic->change_mtu_work, enic_change_mtu_work);
-- 
2.35.2


