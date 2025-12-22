Return-Path: <netdev+bounces-245742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B77FCD6CC5
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 18:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43CD23013390
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 17:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D31322B68;
	Mon, 22 Dec 2025 17:19:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6B52C2349
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766423948; cv=none; b=D4bO9IYWCe5niRIcfIyDsBEjQW794ifmJekdAYSOpEdUzkAXVJ9hwQ2RQfzojdXr0LemwDmycXbR2DIm52iYkUFZWBJ1cUtXay9RIvxQtCbpUmMLIYeZ75+7zUVCkn9yNXfMtHBVAj2Iw6rDGrztAU3+chMsRdbU6WGujz/UxM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766423948; c=relaxed/simple;
	bh=gDHcVBesdJ+KunYJqvKRQ0vvFy1npOXd0mzBeC82qN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V7NRRRtax81pYMNMvIUvOBN2nezgeQj7mkHuzTQ0xwbRfdHgiFVT3O8nr+u9uiXMC1yAS1318vwDQaIq4BitggPo4IvKUwX/hLbducMTSdctKl+pzdma878HNG2WEmJeHrd4LU69Um8CdxyqfCscPr/Ek4qj8B5B+Y1ytO+YpVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-65d132240acso1824901eaf.1
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 09:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766423945; x=1767028745;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNOGBZBt88jv4v0AtYq0+nFJt47TAA0rfIE++XFuplg=;
        b=Tgkv1wjBV8XfA9E2gwyNddqrKBz9tU0Pq0cCSZ6mI3r4VpxPXk6WkzTEmu8+Z5iV4B
         mJ6EwWUOwO7NLj/51/L2/wETbQwswL8iuZvRp601LbkzxaCYp2w0Ayp9UgF18l1xxE4l
         V39Yzj4SRzid0j+Wp6eJ5Q4X9oon76YNl2qYlpjzP8DX3TOushW5yWSDQcmmrfSv49IM
         VwxKdlkqak0Nqi8PN3KV4ey/Hu0b5ijEF1cRuNdmBaTreD97Goai6gut/7JJRZKOdo5G
         5tYdFPyJNxItQYTDrainQj2fu+RZORFreYD0soYbYBnITBguI9UnyhkTyiFKgFpnqwPG
         AwhA==
X-Gm-Message-State: AOJu0YwXonhLSockQurCOrfNYocpWCEaUGrL2zXteInVAHVBXAEKBPXm
	+grO9/3a6IflOIhuPpy7eTalVP/9spBwcnLB5I5Q+v4LSdLHbCzcXz6udwk4nA==
X-Gm-Gg: AY/fxX769v8PmWY6LX4ygfN5AEtQ1QS5vH9rTArNnrVPwqlRkdE0qSXB5P4hQmVhrvL
	de6bYYwWRHkvLSCabW/lLWaYQIo6VZMGYxlLxTHqCmhqZEMy5Z6ICRn+/FFwsTjGaompNCh1vJ2
	VyVzh8TbjDHic0Vq9rVRSodRDyJ7Xx6ZaUcPTXDp3tp3yFUkc79j3zluhmVNLeXQnFnN1L5gwRj
	ruk9tuTXwepGswU7qHOrVQj841SrGMKKnBuyM+ciWgxH0b3nl441OjCOwlEtVLw7lydVXfwdExP
	SDMZQyx4k1JghhutFqJ6cLuXG/qLi3rJ3XU0S9AVV2DCMeboNm6/+hsW/8sRyvk36CmIfIZKzY9
	KRV/D/JvmfUtry9DR/n/9mApXUrM9wUGSoAuS/BcHoGiE918lk1pP1QGZX3dqjoFN/BOauLoAZq
	emLaBo+irJgm9Q
X-Google-Smtp-Source: AGHT+IF8yxdw6xh070ezMfkl08boNT6UWoJhqLuGRUSRtE7GfnCzCdk8aKuj3NOsHR8zpn69CG0PQA==
X-Received: by 2002:a05:6820:2d4c:b0:659:9a49:907c with SMTP id 006d021491bc7-65d0eafd622mr3326688eaf.71.1766423945506;
        Mon, 22 Dec 2025 09:19:05 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:6::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65d0f69b9e9sm7014544eaf.12.2025.12.22.09.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 09:19:05 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 22 Dec 2025 09:16:27 -0800
Subject: [PATCH net-next] net: gve: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-gxring_google-v1-1-35e7467e5c1a@debian.org>
X-B4-Tracking: v=1; b=H4sIAOt8SWkC/yXMQQrCMBAF0KuEv27ATjGBXEVENJ3GEZlIEiVQe
 veirh+8FZWLcEUwKwp/pEpWBDMOBvF+1cRWZgQDOtBxJCKbehFNl5RzerKdXfQuTp4W7zAYvAo
 v0n/fCcrNKveG81/q+/bg2L4dtm0H1DxUk3sAAAA=
X-Change-ID: 20251222-gxring_google-d6c76c372f76
To: Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1973; i=leitao@debian.org;
 h=from:subject:message-id; bh=gDHcVBesdJ+KunYJqvKRQ0vvFy1npOXd0mzBeC82qN8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpSX2IZFhqVD9O0mvVv4YHFlsGb2ofvH01xfbSn
 uKFnwcWhvmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaUl9iAAKCRA1o5Of/Hh3
 bcSeD/9f7TDE/HG7QSVew332yEkSsmeze9zDzatyqLLVG//q1NTD62fkJxvQvfmWoE9V+bbVXP3
 peSrtt9BiHGUVrCOzxo4nLiDwljCn09IGXce9uT8VUQsFTuXRMOc6409/OZ6SRGAC59cACoOvdy
 UgeS8HoyDwAfWqePeIALtlT2QOzyKymPdeyciE527uc7OsQmlB9oU8yiqmAtKn8IRj+CyMJ9zpO
 JSxBCZPsTwN6N64wPKvGp2PgcVA8kn9xBXhlBGcNT1BV+OyN7/tto3nYzDxgBH4MHZ0Bx9oVBvW
 EutxmaE1XRY9eBGzIShl7oOgXV1g8NmfRCZvflPlMGQYJb0AvGxOW6pk/gKgAeRGEcfy2e1C4v/
 dGaZN3x3FwCO2rodpksibbumaaCNruTs9Qv9pensbqy5vfw2VCdGoTcBFJIwbfUur49Tcqrb9Rz
 EwADLfrpTDRpJYSOJ19ZBDGAyyZSaIWLdLDarlkJwmov3pOVpMFUJcxhZBnqgj7PWZ6fyT+x5CC
 xY2ZVBgR9s8n3aQTmnGMrRtEmRdSeeOH3czCsLtGzF5Dup9uRt3xZkGPnc9XZV+wES7fOoOoHaZ
 /8C1CNpiwVGsFrsybw0iAaCwtfaVNwedUaJU/mvjPR7tGJi13GteoAhXvnyzmkFQ/pWnbIdgBjX
 xjSC7k/CsjaKgTA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Convert the Google Virtual Ethernet (GVE) driver to use the new
.get_rx_ring_count ethtool operation instead of handling
ETHTOOL_GRXRINGS in .get_rxnfc. This simplifies the code by moving the
ring count query to a dedicated callback.

The new callback provides the same functionality in a more direct way,
following the ongoing ethtool API modernization.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
PS: This was compile-tested only.
---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 52500ae8348e..9ed1d4529427 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -815,15 +815,19 @@ static int gve_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 	return err;
 }
 
+static u32 gve_get_rx_ring_count(struct net_device *netdev)
+{
+	struct gve_priv *priv = netdev_priv(netdev);
+
+	return priv->rx_cfg.num_queues;
+}
+
 static int gve_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd, u32 *rule_locs)
 {
 	struct gve_priv *priv = netdev_priv(netdev);
 	int err = 0;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = priv->rx_cfg.num_queues;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		if (!priv->max_flow_rules)
 			return -EOPNOTSUPP;
@@ -966,6 +970,7 @@ const struct ethtool_ops gve_ethtool_ops = {
 	.get_channels = gve_get_channels,
 	.set_rxnfc = gve_set_rxnfc,
 	.get_rxnfc = gve_get_rxnfc,
+	.get_rx_ring_count = gve_get_rx_ring_count,
 	.get_rxfh_indir_size = gve_get_rxfh_indir_size,
 	.get_rxfh_key_size = gve_get_rxfh_key_size,
 	.get_rxfh = gve_get_rxfh,

---
base-commit: 7b8e9264f55a9c320f398e337d215e68cca50131
change-id: 20251222-gxring_google-d6c76c372f76

Best regards,
--  
Breno Leitao <leitao@debian.org>


