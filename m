Return-Path: <netdev+bounces-217056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EBDB37358
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 21:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C164D4E2DB2
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 19:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBC430CDA5;
	Tue, 26 Aug 2025 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfHHObu+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1136E30CDB0
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756237491; cv=none; b=gL7W0R4JgCrTbwgZ6ROJPdGktzKUdwRgkAfoNkgC3MqyJYWhRcpSaIpFGjOmWBk3SJvMGFyQqO06ybSE4/bd+gUaRJzVXK8A1aRdwLHg0iPEG39vqKaG+jJqUmsmmpza18a9KIhvMZpCcd0P2CSHHSWOynoNRdRciWvDYCITJUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756237491; c=relaxed/simple;
	bh=GmDwa12rAe06S4TWASqpPuotKrqpkbnlNwhUqqnBUQ8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kG581Tvbj4nolHjjypc6EEw9pozrigSQogPPYP3+w56znNRZ/u+9B/VChukBcskZStmsObYSxIW5b7zhayZzq4FpflIxoaC9FHKGWBkHKZdCzFwRGZ2dCkAsytLY0yuFEcG5+LmyqwQ2qLHVYSFjvfsbkn44JSeZLI1y6RgofHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfHHObu+; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3276f46c1caso7021a91.1
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 12:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756237489; x=1756842289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tWVsVAxPPY4+LglRvD9uUMDb8HqUEBDw0txmTE1f7gU=;
        b=UfHHObu++0fiRkH0ZJSdoqk6DFScILGvE8ijGAX5PkdSYt+NdWBSrgyYsHJtvLPLvN
         JFwnBbY7oQGkfGIScFltKMb4QlfQntHQARWe6WbuByvRJC2TwtS2glmrt6yhmlwarT8U
         qJNs4MY25DYTQ3vTwdN0n1eRZgwW1S5z14/kekvxVK6EkYlFZD2OHTr50/rkVsZUrumz
         kWHleS8MfMIICINwLMuPtSfeeAhhNbpl8FEA+evXF57MBdqMYjOicJkgWAlifq4UKgpa
         He7CiUEwgpnzwj+0c4x2W9o9w8YNlPNQf7pBo0zA21Wxpo3fGiNwHAbcZdJnvKXRBfRW
         sVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756237489; x=1756842289;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tWVsVAxPPY4+LglRvD9uUMDb8HqUEBDw0txmTE1f7gU=;
        b=XrzNSXGnDfe7RJubMS5U0rtpmcNpYlQbTiPdzw8RJhIcJ1bQPHb+FIgaHleggSJGNy
         WDrzymzg5btMmxFrzoxIbkZoRX+if+OS2fD0eT0WL9aKOk/1gnSLhLeeEbAfINsLYSA7
         OPZcyxf4g5qNySuRiUZ+49aJQE8hjVJqM/LVV3aURKQOqGfhE9HM/XJywPm6qNn3v4Q3
         ST51fERjWYWvS2XuS1yW+RiNnyyzGStBmUzZi2gJ4UJUIqx0Y4WfOgpzZjtDDQrrjajc
         DZF5GqUTTATJL1iCTkdL6GHvImLxgKX+CBJDN+sP1CSQf/EPA54E8G4udlA8J03jxOpL
         11CQ==
X-Gm-Message-State: AOJu0Yzez1gPwG1BEffQDhSO8GZSPL+vLfWKqDJskGqSDMK7jHicyGRs
	hFkrZQcE2JnmRbNxdRABHEX1Q1eEMwd17fW2nh8Vq8luM1IsLIYSVos9
X-Gm-Gg: ASbGncsqPveVMLs3SjNOh8lhk4ddzqXmIfD5opezsaeUNAcu3MrJG3N9NUpadWgbpuB
	Ube7UKTvw8GKyjA9kUWo0tKYCBR+RnlY3vlaiv2pnflhX9joY/WFUqErkWHBvA5PGQNkiw3l82Z
	6Y+v9papS2KaMB0AMuOzc2Pi241L6mLKWgl8K8LYpx2BbK8bH5lWhN51xMVNAVza9NwZaWzJTCE
	b/WpTuLkR7l6OMgouud7n1yZzSAY4oYjpCZS3iBKjbByBh0yA+9sZRrq1q3D6Y27ijRTgSJQPTK
	7eUKZA+ZOt40bbconjBXiJ3mUqHnVhzfqlCOUkdQoyQLvaCzEQweAJlPtfyHI5GDUBZJQN0z4JH
	OmGMNrjPIAMyKeC9NyhfHIWEO7ToSr+R7cKiJAqRxTaFuegwoIaUke5kIK5Ac22EUILA=
X-Google-Smtp-Source: AGHT+IHzafFexTco6p+snlfUfBcAxLkApUmeYZk9+3tqnIElhMIaiKrZ+b0shuqW2fbDOCIO/metPg==
X-Received: by 2002:a17:90b:5647:b0:324:e74a:117c with SMTP id 98e67ed59e1d1-3275085dceamr3947912a91.13.1756237489182;
        Tue, 26 Aug 2025 12:44:49 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb891cc9sm9917309a12.10.2025.08.26.12.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 12:44:48 -0700 (PDT)
Subject: [net-next PATCH 1/4] fbnic: Move promisc_sync out of netdev code and
 into RPC path
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 pabeni@redhat.com, davem@davemloft.net
Date: Tue, 26 Aug 2025 12:44:47 -0700
Message-ID: 
 <175623748769.2246365.2130394904175851458.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <175623715978.2246365.7798520806218461199.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <175623715978.2246365.7798520806218461199.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

In order for us to support the BMC possibly connecting, disconnecting, and
then reconnecting we need to be able to support entities outside of just
the NIC setting up promiscuous mode as the BMC can use a multicast
promiscuous setup.

To support that we should move the promisc_sync code out of the netdev and
into the RPC section of the driver so that it is reachable from more paths.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |   45 +-----------------------
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c    |   44 +++++++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h    |    3 ++
 3 files changed, 49 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index b8b684ad376b..c75c849a9cb2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -220,49 +220,8 @@ void __fbnic_set_rx_mode(struct net_device *netdev)
 	uc_promisc |= !!(netdev->flags & IFF_PROMISC);
 	mc_promisc |= !!(netdev->flags & IFF_ALLMULTI) || uc_promisc;
 
-	/* Populate last TCAM entry with promiscuous entry and 0/1 bit mask */
-	mac_addr = &fbd->mac_addr[FBNIC_RPC_TCAM_MACDA_PROMISC_IDX];
-	if (uc_promisc) {
-		if (!is_zero_ether_addr(mac_addr->value.addr8) ||
-		    mac_addr->state != FBNIC_TCAM_S_VALID) {
-			eth_zero_addr(mac_addr->value.addr8);
-			eth_broadcast_addr(mac_addr->mask.addr8);
-			clear_bit(FBNIC_MAC_ADDR_T_ALLMULTI,
-				  mac_addr->act_tcam);
-			set_bit(FBNIC_MAC_ADDR_T_PROMISC,
-				mac_addr->act_tcam);
-			mac_addr->state = FBNIC_TCAM_S_ADD;
-		}
-	} else if (mc_promisc &&
-		   (!fbnic_bmc_present(fbd) || !fbd->fw_cap.all_multi)) {
-		/* We have to add a special handler for multicast as the
-		 * BMC may have an all-multi rule already in place. As such
-		 * adding a rule ourselves won't do any good so we will have
-		 * to modify the rules for the ALL MULTI below if the BMC
-		 * already has the rule in place.
-		 */
-		if (!is_multicast_ether_addr(mac_addr->value.addr8) ||
-		    mac_addr->state != FBNIC_TCAM_S_VALID) {
-			eth_zero_addr(mac_addr->value.addr8);
-			eth_broadcast_addr(mac_addr->mask.addr8);
-			mac_addr->value.addr8[0] ^= 1;
-			mac_addr->mask.addr8[0] ^= 1;
-			set_bit(FBNIC_MAC_ADDR_T_ALLMULTI,
-				mac_addr->act_tcam);
-			clear_bit(FBNIC_MAC_ADDR_T_PROMISC,
-				  mac_addr->act_tcam);
-			mac_addr->state = FBNIC_TCAM_S_ADD;
-		}
-	} else if (mac_addr->state == FBNIC_TCAM_S_VALID) {
-		if (test_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam)) {
-			clear_bit(FBNIC_MAC_ADDR_T_ALLMULTI,
-				  mac_addr->act_tcam);
-			clear_bit(FBNIC_MAC_ADDR_T_PROMISC,
-				  mac_addr->act_tcam);
-		} else {
-			mac_addr->state = FBNIC_TCAM_S_DELETE;
-		}
-	}
+	/* Update the promiscuous rules */
+	fbnic_promisc_sync(fbd, uc_promisc, mc_promisc);
 
 	/* Add rules for BMC all multicast if it is enabled */
 	fbnic_bmc_rpc_all_multi_config(fbd, mc_promisc);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index a4dc1024c0c2..d5badaced6c3 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -454,6 +454,50 @@ int __fbnic_xc_unsync(struct fbnic_mac_addr *mac_addr, unsigned int tcam_idx)
 	return 0;
 }
 
+void fbnic_promisc_sync(struct fbnic_dev *fbd,
+			bool uc_promisc, bool mc_promisc)
+{
+	struct fbnic_mac_addr *mac_addr;
+
+	/* Populate last TCAM entry with promiscuous entry and 0/1 bit mask */
+	mac_addr = &fbd->mac_addr[FBNIC_RPC_TCAM_MACDA_PROMISC_IDX];
+	if (uc_promisc) {
+		if (!is_zero_ether_addr(mac_addr->value.addr8) ||
+		    mac_addr->state != FBNIC_TCAM_S_VALID) {
+			eth_zero_addr(mac_addr->value.addr8);
+			eth_broadcast_addr(mac_addr->mask.addr8);
+			clear_bit(FBNIC_MAC_ADDR_T_ALLMULTI,
+				  mac_addr->act_tcam);
+			set_bit(FBNIC_MAC_ADDR_T_PROMISC,
+				mac_addr->act_tcam);
+			mac_addr->state = FBNIC_TCAM_S_ADD;
+		}
+	} else if (mc_promisc &&
+		   (!fbnic_bmc_present(fbd) || !fbd->fw_cap.all_multi)) {
+		/* We have to add a special handler for multicast as the
+		 * BMC may have an all-multi rule already in place. As such
+		 * adding a rule ourselves won't do any good so we will have
+		 * to modify the rules for the ALL MULTI below if the BMC
+		 * already has the rule in place.
+		 */
+		if (!is_multicast_ether_addr(mac_addr->value.addr8) ||
+		    mac_addr->state != FBNIC_TCAM_S_VALID) {
+			eth_zero_addr(mac_addr->value.addr8);
+			eth_broadcast_addr(mac_addr->mask.addr8);
+			mac_addr->value.addr8[0] ^= 1;
+			mac_addr->mask.addr8[0] ^= 1;
+			set_bit(FBNIC_MAC_ADDR_T_ALLMULTI,
+				mac_addr->act_tcam);
+			clear_bit(FBNIC_MAC_ADDR_T_PROMISC,
+				  mac_addr->act_tcam);
+			mac_addr->state = FBNIC_TCAM_S_ADD;
+		}
+	} else if (mac_addr->state == FBNIC_TCAM_S_VALID) {
+		__fbnic_xc_unsync(mac_addr, FBNIC_MAC_ADDR_T_ALLMULTI);
+		__fbnic_xc_unsync(mac_addr, FBNIC_MAC_ADDR_T_PROMISC);
+	}
+}
+
 void fbnic_sift_macda(struct fbnic_dev *fbd)
 {
 	int dest, src;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
index 6892414195c3..d9db7781a49b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
@@ -201,6 +201,9 @@ struct fbnic_mac_addr *__fbnic_mc_sync(struct fbnic_dev *fbd,
 void fbnic_sift_macda(struct fbnic_dev *fbd);
 void fbnic_write_macda(struct fbnic_dev *fbd);
 
+void fbnic_promisc_sync(struct fbnic_dev *fbd,
+			bool uc_promisc, bool mc_promisc);
+
 struct fbnic_ip_addr *__fbnic_ip4_sync(struct fbnic_dev *fbd,
 				       struct fbnic_ip_addr *ip_addr,
 				       const struct in_addr *addr,



