Return-Path: <netdev+bounces-238447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68096C590DF
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95BD34F25C8
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085A835C19D;
	Thu, 13 Nov 2025 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRHYAMTP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF9F35C19B
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051632; cv=none; b=e5upIy+3d8gOJwQSiVAmy0eVwQsL60wG/AiiBav+pYbO+2qzbI59mvziEdKRG6YjOxGu713yrVWjxb0O9UhbLggxvA/SwnuoY+9yEcA0XDfSiSry0HPpquAjbl8SaH6uQMaLvZ5AgIvJQB99V6z3qYblOKbW67kms51sdDEu4Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051632; c=relaxed/simple;
	bh=7leYNXo1PDbOZQ2gAgGBsoiZa4y0u9rMWMBHESb2mJA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTwo3WhKYSSucCQlCop9ox7Ph7X+Wg8cFJvMDODS9+qHzJdVoUhBEQbX6H7m+kJEA69f8ktGE9u6zR1KGchEC3b+dh0Lspu56JkmSOrBxrKwvPoB/+haEJgBDzZEXsmVsk4OCd1s3YqvQixCSLyPRJuw3QK8Z2RyvzBeCj+zFGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRHYAMTP; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so1205519b3a.3
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 08:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763051631; x=1763656431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GIjPMBWcXrHpzcycCBxtvnjtYSxYnrX3oqg5pRXkRd4=;
        b=dRHYAMTP09d45Kh/dlGAa17+hkbH57Xd0ukKcUatYmqKqOLcuB2j80YmjI4XPBwM1c
         lFgyZGBFdQWeFDUlcWUE3mvalhRzkGMLjtIEEjbS9WG0Bmou6LuP7ncC30AiR7a7wJ2e
         01XHKwX5xEsbxO2QlwX6G05OqgcB9jEwY7EBiM0fdhQzRcNTg/od4EnwaIVEAEyq4HJ1
         MO1YhZycIm+0PjsPDGeyJLM3rOuReFjOcsKCtylkYPSOk3yloNc2SOTrw8H84EdVftvw
         wIrGbA4Q0ii4Eo+Q9qwWnkjP5J3IztEUui7kPpPGOA/Z2kQTVswQ/+M7be8N8DsoEtXj
         G5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051631; x=1763656431;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIjPMBWcXrHpzcycCBxtvnjtYSxYnrX3oqg5pRXkRd4=;
        b=cFcVXhspKfBorxJokpB5SWLAPZp2UhcY8HdRSFB/6in0zSsQrUlNNPFp7HYtoxsQ7g
         wOSAwFwNUr3iBA5rP+g4zhl2YSgC6ZkAu5l15jrwtJ2//tajrMeAt1qqg6JYNwvvaEVU
         rwMo/dfjQXn2uj3wyCkRPblCRYLSgDOKgQ8LoaInM39hiyw2Gj2iupBlhlMgLAvoa5t8
         w3HsScoN5JYZNS/W7L1Vq6eN5hMCe1bx3R44e7Ci/SFv1CmPE1ddZVS6vBufw35tBcZ3
         SGTwOahW1mB+QkAlbUUPOigKWyJ0Jg880Xk5R545JJtHdfJSnWlOV0bI2FzFgSvlow5D
         y9Zg==
X-Gm-Message-State: AOJu0YztIC/yotX1C/rwZSfuqxUyOEpgBSkX6GC2t4pwzWRlNoeDFe4n
	JU7m2dUIdzcVBfByG5IkIV7kvfdTi/leXGcBRDNOPWH4NipyVALtGep9
X-Gm-Gg: ASbGncsVRy2qYa6psvQo00i9jdUb+/IjTYRkiqi6e/PCUPiD0Im8l61A2yE22pYkHL0
	+ZP/WiBs7Q5Rs9CpZ4tTNED2gipaDjypyq3CqePstMelvBQcKlLuu/PC2PiG5VFWGSZa6GtUcea
	5jgi0SN2kN97t8NOeqfaoqKJd7m7f3HFQ7VEVHaSSM0VjtOJnqb7pU2ePRq+P+qjmlFhZRDQ09u
	IIa3U6+se/kK/3LRlWouI92D9RxwckXhMveBI/leuKzoZyOSa/S7jkPwd34CHqwmeB6RuQ7AUFQ
	XptyMBA8zWvl/aXfKJFiSq1iNJ5m7ZSW/7zUr5phjWPPWjdkvwzi7L508Ib0QrRJnVzzrEmtrTf
	vGsD+NXYiab40zltJHveDgOpELdyzzYzpfSO2muZvlThTg6V91ohoTBttlgcJQXaPHIU4geEipP
	ZMgvMf6HVcC3BaOn5IRhVZZ/kcBL7dlBHMCUp+d7p82UtO
X-Google-Smtp-Source: AGHT+IHfgDSgckoyUdkyuotGOgq9IyS/TCGR4agvVV5GvAaoDztGVB+oMl9ffx8O9WJxg5qsx+otiQ==
X-Received: by 2002:a05:6a20:2591:b0:2e8:1c23:5c2d with SMTP id adf61e73a8af0-35ba24a00a2mr243565637.50.1763051630586;
        Thu, 13 Nov 2025 08:33:50 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924aeda22sm2818318b3a.2.2025.11.13.08.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:33:50 -0800 (PST)
Subject: [net-next PATCH v4 08/10] fbnic: Cleanup handling for link down event
 statistics
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Thu, 13 Nov 2025 08:33:49 -0800
Message-ID: 
 <176305162922.3573217.2243233145202197114.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176305128544.3573217.7529629511881918177.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176305128544.3573217.7529629511881918177.stgit@ahduyck-xeon-server.home.arpa>
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

The code for handling link down event tracking wasn't working in the
existing code. Specifically we should be tracking unexpected link down
events, not expected ones.

To do this tracking we can use the pmd_state variable and track cases where
we transition from send_data to initialize in the interrupt. These should
be the cases where we would be seeing unexpected link down events.

In addition we have cases where the PCS will reset following the training
due to errors generated while the PMD was training. This will result in a
PCS reset which will flap the link. To avoid counting this link flap as the
NIC has yet to report link up we will only record the link event if the
netif_carrier was already reporeted as present.

In order for the stat to have any value we have to display it so this
change adds logic to display it as a part of the ethtool stats.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c |    9 +++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c     |   13 ++++++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |    2 --
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 95fac020eb93..693ebdf38705 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1863,6 +1863,14 @@ fbnic_get_rmon_stats(struct net_device *netdev,
 	*ranges = fbnic_rmon_ranges;
 }
 
+static void fbnic_get_link_ext_stats(struct net_device *netdev,
+				     struct ethtool_link_ext_stats *stats)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	stats->link_down_events = fbn->link_down_events;
+}
+
 static const struct ethtool_ops fbnic_ethtool_ops = {
 	.cap_link_lanes_supported	= true,
 	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS |
@@ -1874,6 +1882,7 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_regs_len			= fbnic_get_regs_len,
 	.get_regs			= fbnic_get_regs,
 	.get_link			= ethtool_op_get_link,
+	.get_link_ext_stats		= fbnic_get_link_ext_stats,
 	.get_coalesce			= fbnic_get_coalesce,
 	.set_coalesce			= fbnic_set_coalesce,
 	.get_ringparam			= fbnic_get_ringparam,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
index 9b068b82f30a..73dd10b7a1a8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -122,6 +122,7 @@ static irqreturn_t fbnic_mac_msix_intr(int __always_unused irq, void *data)
 {
 	struct fbnic_dev *fbd = data;
 	struct fbnic_net *fbn;
+	u64 link_down_event;
 
 	if (fbd->mac->get_link_event(fbd) == FBNIC_LINK_EVENT_NONE) {
 		fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(0),
@@ -129,11 +130,21 @@ static irqreturn_t fbnic_mac_msix_intr(int __always_unused irq, void *data)
 		return IRQ_HANDLED;
 	}
 
+	/* If the link is up this would be a loss event */
+	link_down_event = (fbd->pmd_state == FBNIC_PMD_SEND_DATA) ? 1 : 0;
+
 	fbn = netdev_priv(fbd->netdev);
 
 	/* Record link down events */
-	if (!fbd->mac->get_link(fbd, fbn->aui, fbn->fec))
+	if (!fbd->mac->get_link(fbd, fbn->aui, fbn->fec)) {
+		/* Do not count link down events if the PCS has yet to
+		 * acknowledge the link. This allows for the flushing out
+		 * PCS errors generated during link training.
+		 */
+		if (netif_carrier_ok(fbd->netdev))
+			fbn->link_down_events += link_down_event;
 		phylink_pcs_change(&fbn->phylink_pcs, false);
+	}
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index 27e4073d9898..592e9642a418 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -203,8 +203,6 @@ fbnic_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
 	struct fbnic_dev *fbd = fbn->fbd;
 
 	fbd->mac->link_down(fbd);
-
-	fbn->link_down_events++;
 }
 
 static void



