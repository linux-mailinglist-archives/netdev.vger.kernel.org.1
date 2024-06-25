Return-Path: <netdev+bounces-106393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5122E916136
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1287D283864
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 08:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72313149018;
	Tue, 25 Jun 2024 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="IjAIMraZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42385148857
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304183; cv=none; b=KwfTUDBF0uLGy2fKwwW0QeV//RUO/V6ReDDGVIvz/ls9a/8hY9ZdArQpZhr5/4Khx6O8H6mB3T4zhb/PsLn0IOuXQqgZBsoB8zTQRopV8K4CLwtAs+kfbwd3E2YmNJqsAjpJYOD7SJJfO7yillBrSVqe78ad7Uytx2zsAexB1Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304183; c=relaxed/simple;
	bh=AnmKil8+NfynUTaFHzWfLAaLMrrcYuTWsIEWkLL1vfI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qW/zq2yqW3ffyjBzOnE7lDZcIpGCY32OL82KhTJsnexjJJei4flfqbmSNogNqkOZSuChnl0FajA3noRSyUrwY7B+VBoProVBtlFktHc/cQ8AhJaF+jTH5Ck6vktGYSf+LCEsDkVmxQmEeagThswUB8FPFNvjXBscda+TGEudcUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=IjAIMraZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fa2782a8ccso15532425ad.2
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1719304180; x=1719908980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EHm6jSq3YRWEu2BqkiF85SjfiXnv03zfze5ShEkImQ8=;
        b=IjAIMraZEV2mZ83rYmfj5XNXOgKcRoa/Yepk2YVAfrKjq35C0miTcUBO2eHRpXnimj
         IIT4Wk6DrAio9Y+15WwC8o3sxaPgQr7JG12ZyIfS0X06E1GZavus5mzuXsBkiImLZ/tv
         2XiAiQDnc6NgzyjvVkg/29jT1YLxcviMEWDcFyVTc36QGFOng83l1rkB4MwroRTj16sj
         pffht+JRrZ/JNfH9JGTAbCl54O3FkZlkS37ht7lZxu8pv19PcDUWJpLcK17CyASG8gdN
         8VpORHrrWtedqmFAoL98zSgkKLTL5U3mzHyQu/4z9PeiJ0tULR0l/I6gT70kWtve66xP
         431g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719304180; x=1719908980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EHm6jSq3YRWEu2BqkiF85SjfiXnv03zfze5ShEkImQ8=;
        b=T0Q29LIFcGNivzE0YWCX3RHtJy+TFxCsP7VuJxPPlJlVtcVGP+yERCMLa+0uSvVqTm
         jvm/5+ZPt59g2FFRTmXMOLB1Y6GYD73w2a81n4Ka7HlgNWd8/vyYA4MUrnC7rhroxW6a
         Ad9PaITO8BNXkn+NpV5DPd4TSjmPPJwWOQI/ROei2djGFMYjhIs2kcC1KUBFGZdiWKzv
         jsqQy4AukGqj8xAMCBDvocOEPcsGWkBAdeVNL31dHnT7d1iHQH+QYXgx2/pOWy33KcyS
         uNHMBmmDyIrEJODCAS01LHr2hlnaf0o52WBu0F6qLh5yYT7h2n9YXpd8I9DcLE8rsTmK
         AhEg==
X-Gm-Message-State: AOJu0Ywo9j35qJqV9LwrFSZm4H14J/FIBQEygQyrPCwH3tN5EOywY9Sm
	DKx4Dm6dkzlYqleexmElSOvPhLxBkZeL6CCqgHHUDzy7u65gwPLmXDKaje03eJ0=
X-Google-Smtp-Source: AGHT+IEuUm/k18cKpsPHmSMA/4F5q07QPsr1++pGXwTWN6paEYO6DEUJj/D6ppjMr7SThqV4w9G47g==
X-Received: by 2002:a17:902:f685:b0:1fa:12a5:a4f9 with SMTP id d9443c01a7336-1fa23f15c1dmr85226395ad.47.1719304179756;
        Tue, 25 Jun 2024 01:29:39 -0700 (PDT)
Received: from echken.smartx.com (vps-bd302c4a.vps.ovh.ca. [15.235.142.94])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fa2b011112sm41628545ad.121.2024.06.25.01.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 01:29:39 -0700 (PDT)
From: echken <chengcheng.luo@smartx.com>
To: pshelar@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	echken <chengcheng.luo@smartx.com>
Subject: [PATCH 1/2] Add GSO UDP Offloading feature to OVS Internal Port
Date: Tue, 25 Jun 2024 08:29:24 +0000
Message-Id: <20240625082924.775877-1-chengcheng.luo@smartx.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OVS internal port does not support UDP fragmentation offloading,
resulting in large packets sent through the OVS internal port to OVS
being prematurely fragmented. This increases the total number of packets
processed in the path from the vport to the OVS bridge output port,
affecting transmission efficiency.

Signed-off-by: echken <chengcheng.luo@smartx.com>
---
 net/openvswitch/vport-internal_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index 74c88a6baa43..c5a72c4dc6fd 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -110,7 +110,8 @@ static void do_setup(struct net_device *netdev)
 
 	netdev->features = NETIF_F_LLTX | NETIF_F_SG | NETIF_F_FRAGLIST |
 			   NETIF_F_HIGHDMA | NETIF_F_HW_CSUM |
-			   NETIF_F_GSO_SOFTWARE | NETIF_F_GSO_ENCAP_ALL;
+			   NETIF_F_GSO_SOFTWARE | NETIF_F_GSO_ENCAP_ALL |
+			   NETIF_F_GSO_UDP | NETIF_F_GSO_UDP_L4;
 
 	netdev->vlan_features = netdev->features;
 	netdev->hw_enc_features = netdev->features;
-- 
2.34.1


