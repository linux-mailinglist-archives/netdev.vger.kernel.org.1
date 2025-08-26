Return-Path: <netdev+bounces-217058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 413E8B3735A
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 21:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1E91BA3EBE
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 19:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2937327990E;
	Tue, 26 Aug 2025 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNwt/QfC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CEB30CDB3
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756237505; cv=none; b=jyqiGVBwHnJOCTDPpk+IZ26MtwtJlIZ+dVwUFPhR6HbKR0cRSubbK28z3Soc6fIvOCOCYmsZIkASk1ubJV6dHgcs2yhQIBli16jozkB/CWegUT1gu8wYI4bwuocmLRcywTRykb+Df8MG/rvg12JCVa2RiNQnd6IfuKJIFfnPVzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756237505; c=relaxed/simple;
	bh=cGq3baF23b7KFQHe/j+S/OlCa9nvFGN0nDpO1pYH75k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lTWTk3OYxRzWdkJ04mRO2wjuDbrWcpV0rvClzwbr/iAj0jgVmw4cLJCc6cGv7RrmWYHk4/ytwgsN6+gHtS+4+WUQ08N0Lp9Dqo7zgCMa1cO/VoNC0eY/bZWXnJyqT8qjNEsJ5maZUKgWKZVX3aDj7Ls9bHXjKctRCvv27cZwUfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNwt/QfC; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e434a0118so7022272b3a.0
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 12:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756237503; x=1756842303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ed26NsHLte1J6cF5VVGSOXkENQRTvkF22V8TMzSHhD8=;
        b=UNwt/QfCg7Ht6j0b16aELyQ/Xwj8k88FlecMsZpytSfDUZoB9AYa/fADXxZIJ0TYkc
         ZxCypaNSYOOr1qMJyUckoyr9ZmuWWWwPWrOEdsaHNE41A52sDLBD2uLe9S6ym7nM3jvw
         ZRgsBWAeRKEo+vDFNvsxSuHgLphjadUydoizXe5DHzpDlqi5yvbR8m3rM2DUGjzcfKwW
         gEOLh+WsGYwEsVWKII/8CD75mWKp2JzqNYjhPYIS6ab+6fxbLN5No0zzymA6v16ATwAX
         YtHgWBncACoe9HePc5mMVAq0n6jz5pOxBVpbBdMI/7nA/ZgGiBuOfpKi8+SDfrSFP+Nl
         IF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756237503; x=1756842303;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ed26NsHLte1J6cF5VVGSOXkENQRTvkF22V8TMzSHhD8=;
        b=sLrFNEhHBSklCgX0AYzBgvD4K7LkdxaBDOvQlHSe4ZTV0QdxNf0vSdeFzp9gbsrJXe
         aemc9rgmg1K/IgAM4v92B89yiuzKHwHNOjDKX+d2zp4iW70i5puqjG1Mp8H7wfB7X8qZ
         A5MiaB4LHfPdzYF+JhExtCw1kA4w9qciayxZXxjzAsDqUu1Zk7qcfxsj3FeCRFvP50jr
         WPEVGcNF0D3Gei5YgGcM5B9SyYyXR27COuB9BFQjWv/lKOCj4Vc5KK1q5su2jXvti2wH
         JwET/4ZpFVy65dgXJgoMbPnCQws8aKgYC5Fxc31mh/r2rcdtTGKugYo3eZRSCbB1VkBm
         dAJg==
X-Gm-Message-State: AOJu0YyBXUPXFGvxDN3VHfaN3NN/NHtkniOvukPspHDZ1ggUkl9ekbq+
	tZ0h/Oe8IXVuWdeUdCITLa9eVm80zjpB91MsquPXaDSUu0czCPliAOcF
X-Gm-Gg: ASbGncvZg68w8dIelSLIqeLyMzbZ3357DdhkxpYyGGX9zdB2Vs7pqtPy90BrN+5PRwR
	ZFO3HQBpM9MRwamM8YF6wXqEeA3+Wc77mMtnptGhE01jf88v88b/HFraY/W5d5eQPOPXV3Rg4EM
	xNkejwbMaEGmLCqCuZgBw77oFhO4MzvSjVIcFbLJiUj4dlfLB1nqhWZtt6Nyky+Q3UgG/meauBY
	446MNNIz2iRIPdwPQ3NcXXhgQwg04gkPmhNS5d/yFPV7t9hJbmlrDgqdsZyNv4UDw1G2dgI4W2f
	cT5tHHQ6cM7oQFvZiA9mlaV5bNosR0TJonAAJS1ZSLlKSacelw21fP2SuBQvx7pUrRrMfGHLH56
	V9rvWOYLop3EsMma2B5r7UloXnQm+u7QgtGS/QDUlxL8PAwXJpQ2auL+8uYSiXkKVSy4=
X-Google-Smtp-Source: AGHT+IEQqj6zOGqwnaLFHkm1EEOywGQKc0Cwgw3u/FlkzrAWQ6V3k8DEQnXhkoeQTZ8hg8MrWtlOwQ==
X-Received: by 2002:a05:6a00:2ea3:b0:771:e3d7:4320 with SMTP id d2e1a72fcca58-771e3d752b9mr9607619b3a.19.1756237502646;
        Tue, 26 Aug 2025 12:45:02 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401af6b2sm11141855b3a.56.2025.08.26.12.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 12:45:02 -0700 (PDT)
Subject: [net-next PATCH 3/4] fbnic: Add logic to repopulate RPC TCAM if BMC
 enables channel
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 pabeni@redhat.com, davem@davemloft.net
Date: Tue, 26 Aug 2025 12:45:01 -0700
Message-ID: 
 <175623750101.2246365.8518307324797058580.stgit@ahduyck-xeon-server.home.arpa>
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

The BMC itself can decide to abandon a link and move onto another link in
the event of things such as a link flap. As a result the driver may load
with the BMC not present, and then needs to update things to support the
BMC being present while the link is up and the NIC is passing traffic.

To support this we add support to the watchdog to reinitialize the RPC to
support adding the BMC unicast, multicast, and multicast promiscuous
filters while the link is up and the NIC owns the link.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c  |    3 +++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h  |    5 +++--
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c |    2 ++
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c |   19 ++++++++++++-------
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h |    1 +
 5 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 0c55be7d2547..c7d255a095f0 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -653,6 +653,9 @@ static int fbnic_fw_parse_cap_resp(void *opaque, struct fbnic_tlv_msg **results)
 	fbd->fw_cap.anti_rollback_version =
 		fta_get_uint(results, FBNIC_FW_CAP_RESP_ANTI_ROLLBACK_VERSION);
 
+	/* Always assume we need a BMC reinit */
+	fbd->fw_cap.need_bmc_tcam_reinit = true;
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index fde331696fdd..e9a2bf489944 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -51,8 +51,9 @@ struct fbnic_fw_cap {
 	} stored;
 	u8	active_slot;
 	u8	bmc_mac_addr[4][ETH_ALEN];
-	u8	bmc_present	: 1;
-	u8	all_multi	: 1;
+	u8	bmc_present		: 1;
+	u8	need_bmc_tcam_reinit	: 1;
+	u8	all_multi		: 1;
 	u8	link_speed;
 	u8	link_fec;
 	u32	anti_rollback_version;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 06645183be08..1221a06961b0 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -206,6 +206,8 @@ static void fbnic_service_task(struct work_struct *work)
 
 	fbnic_health_check(fbd);
 
+	fbnic_bmc_rpc_check(fbd);
+
 	if (netif_carrier_ok(fbd->netdev))
 		fbnic_napi_depletion_check(fbd->netdev);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index d5badaced6c3..d821625d602c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -6,6 +6,7 @@
 #include <net/ipv6.h>
 
 #include "fbnic.h"
+#include "fbnic_fw.h"
 #include "fbnic_netdev.h"
 #include "fbnic_rpc.h"
 
@@ -131,12 +132,9 @@ void fbnic_bmc_rpc_all_multi_config(struct fbnic_dev *fbd,
 		else
 			clear_bit(FBNIC_MAC_ADDR_T_ALLMULTI,
 				  mac_addr->act_tcam);
-	} else if (!test_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam) &&
-		   !is_zero_ether_addr(mac_addr->mask.addr8) &&
-		   mac_addr->state == FBNIC_TCAM_S_VALID) {
-		clear_bit(FBNIC_MAC_ADDR_T_ALLMULTI, mac_addr->act_tcam);
-		clear_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam);
-		mac_addr->state = FBNIC_TCAM_S_DELETE;
+	} else {
+		__fbnic_xc_unsync(mac_addr, FBNIC_MAC_ADDR_T_BMC);
+		__fbnic_xc_unsync(mac_addr, FBNIC_MAC_ADDR_T_ALLMULTI);
 	}
 
 	/* We have to add a special handler for multicast as the
@@ -238,8 +236,15 @@ void fbnic_bmc_rpc_init(struct fbnic_dev *fbd)
 		act_tcam->mask.tcam[j] = 0xffff;
 
 	act_tcam->state = FBNIC_TCAM_S_UPDATE;
+}
 
-	fbnic_bmc_rpc_all_multi_config(fbd, false);
+void fbnic_bmc_rpc_check(struct fbnic_dev *fbd)
+{
+	if (fbd->fw_cap.need_bmc_tcam_reinit) {
+		fbnic_bmc_rpc_init(fbd);
+		__fbnic_set_rx_mode(fbd);
+		fbd->fw_cap.need_bmc_tcam_reinit = false;
+	}
 }
 
 #define FBNIC_ACT1_INIT(_l4, _udp, _ip, _v6)		\
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
index d9db7781a49b..3d4925b2ac75 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
@@ -184,6 +184,7 @@ struct fbnic_net;
 
 void fbnic_bmc_rpc_init(struct fbnic_dev *fbd);
 void fbnic_bmc_rpc_all_multi_config(struct fbnic_dev *fbd, bool enable_host);
+void fbnic_bmc_rpc_check(struct fbnic_dev *fbd);
 
 void fbnic_reset_indir_tbl(struct fbnic_net *fbn);
 void fbnic_rss_key_fill(u32 *buffer);



