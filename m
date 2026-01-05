Return-Path: <netdev+bounces-247146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 940CACF5064
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 18:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46797303ADF9
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 17:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1596028B40E;
	Mon,  5 Jan 2026 17:32:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5DD3A1E6D
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767634352; cv=none; b=tu3+5RRlm1KvpRpo2tKb+ZgKZNE8Jle0e+xATwnarFnmMqL5mvvAy3Y2MftETQpiNvPltXR3NBRS/Gn07XQBVGWTHhX1G4BP0nEy2X7BE0QfP+/p9n3ThfjEsT/5ltetnbUNBVAYAOty1cYD9yVO4lFmuCnH3eFm5F7cRtRKvtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767634352; c=relaxed/simple;
	bh=8yzIbly2UHl0Vwgg2DStQ1FhnXDhQDu3dGxqofhkSFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P2uqg5Um3EbNdtEoIU7G5F9vwLCICDnu/NyJhJGiKPE+VQG/hxWo8yj+bVXyoxSbtrzSbzemX3dkPZab/N59lv3vccTbtUbSmIcwL/9VEcoB5xRFTDNAVhGIoZFIjhNNSdPMcMSicwsrq2yyw6ZcApmyMWbpVtYxFC8xOQXiAh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-450ac3ed719so127513b6e.0
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 09:32:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767634349; x=1768239149;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYn6FjhQfhPL6f3Mik1cXFaG5Y4p44xKisVF9XySoVI=;
        b=QVdYOUiWU7vVKbE8VFqOYkkKPWv+dhiruR9QpZiBJ8acl5mBxXlkQyfloEvzbXS1ff
         MvmQpML6H7EP4hJNKUzgm1liCxFjXdjrsqeey72sH2J4/AHKngumXBFZmZvrFJPRkSih
         As0Pj3fW4zGS7Zm6deJaZot/W+G1BjcZlBb1Wj8vzN+KVx1b3PR/E81A/gO4qJWFDD2K
         C8WH2YRyfAdUkEwRHTDmEts0tdZJ/ILCwwN7kX/MrqNx2Lwc2Hi/u9EYWRmyLM+d0T+V
         3O/4h+2yOR1Z2LVk/fln7vew3NGsxpBCwlVXaaLpYU++84nfxOt5E5L5eQbc8Bry9E7a
         fTPw==
X-Gm-Message-State: AOJu0YznFtFPd+nifz6IAgJ4rCoqWqdzH5j3RRMm+l8AA/TgRxvcQKhv
	9aT1ZmIvrmnSfaw6UFAdRcVZxm8Jqtn0oN+zJfrOqKLGe99NMGkGdL6t
X-Gm-Gg: AY/fxX41LYrAd7PcsYukYyaNhez5SDgPV+muUcqDdPYjPK6GCMxTZNd0/Jp9Dmq4zPg
	b3GgynK9otbzaxhqUQTW6qfxQorJnKiREDl5qK4oXWXaenySMm9i+n1EZS69rZoNJAMivWMqCT/
	MbfF//nOXf3Bi8dv1lAxuCTz4Z+9h2ccs0GLk1In5rzFy/NtnXR4eLK+H4I9QzGCF6Wn1CQr42T
	Ik668xDn46L8gUg3ufSjOh+nXzx0m5xitsKcoVEtpDWQblXFqrQXczTVmZR6BWPw/DHNBlhcRAd
	pQ2iShnlORwIkju14Bri6YlwTpZdNWhB9Kb+oaDHBMzxpTQF3sKbpY8M1vWkfLgvFq2+1zJAEnt
	5WkVvuiJrt3e6J/hc0hrJ/gihBQQUa/dRxUVGIsNHJR2ENAjBgKszjciBVhKAphUT3dmXg0p6jk
	cOdjOjMjh+mRPXLg==
X-Google-Smtp-Source: AGHT+IGnxAvyyWGzRjwRWd5adqZT7uyXgQqZ23sNU7XJr4BVlfP4hWXh4Fn1hQ9ZN1IGVOYSZ4a0YA==
X-Received: by 2002:a05:6820:a206:b0:65e:f7e6:438c with SMTP id 006d021491bc7-65ef7e644e7mr6709338eaf.36.1767626930632;
        Mon, 05 Jan 2026 07:28:50 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:74::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65d0f4cd66csm28337512eaf.7.2026.01.05.07.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 07:28:50 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 05 Jan 2026 07:28:26 -0800
Subject: [PATCH net-next v2] net: gve: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-gxring_google-v2-1-e7cfe924d429@debian.org>
X-B4-Tracking: v=1; b=H4sIAJrYW2kC/3WNQQ6CMBBFr9LMmho7SJuw8h6GGChDGWNa09YGQ
 7i7Adeu//vvrZAoMiVoxQqRCicOHlqBlQA7996R5BFaAXjGRiGidEtk7+4uBPckOWprtK0NTkZ
 DJeAVaeLl8N3AU5aelgzdb0nv4UE277qdnTnlED9Huqjj8adSlFSybshctKHGqv460sC9P4Xoo
 Nu27QtmZDTUxwAAAA==
X-Change-ID: 20251222-gxring_google-d6c76c372f76
To: Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, nktgrg@google.com, 
 willemb@google.com, kernel-team@meta.com, 
 Subbaraya Sundeep <sbhatta@marvell.com>, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2190; i=leitao@debian.org;
 h=from:subject:message-id; bh=8yzIbly2UHl0Vwgg2DStQ1FhnXDhQDu3dGxqofhkSFo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpW9ixZxdc7/8scJyq2CQOUP11l0fWhZ4Ijr3HT
 5lQQRKZlXCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaVvYsQAKCRA1o5Of/Hh3
 bceAD/9Lvn0dJj7gHor5Q6ht4H8wDYa/rVl37+wtqh5U7k+m+PcKID3aAnEUr8mU1yDvWo3xuK5
 mK7It0A9OAVCZvYGwVbUeMpMjBBomBknPqvDa1kN1LcPdx1g/y2mZT1RgG5RxOnDb/Fgdx4t3E8
 JDmwCfaCWVZnvvAt8U7UmEywHaraBM0GN8bUHfnwjAE8np43ECLpSkYAK5vglK0RNpr+q6Z+gE7
 Fjm0tVgf0WNBvNtq6l4X3hviJAD8Ab9HZKGzmiiorGUx4vhW6MjF5fdBjM/8XkLebF/2z/RlA96
 tIXdwACkL8en3oUkiNcJqH73S8yenknfibwtEafBgNxAIBtvKJpi3CyLZL+eL+3682Iw+h2GiTB
 Rjf3nrnF1qaNHWJduBHfrIfcj732/TKswWcbv6Z7kCZg7oajLmp/HMDHd5hwGfU06lbvLG0V6zw
 kxWc/x2tUw/OnGt73iSvVIPs6WxliQykNuUiCu6SVrcGDXjSZeOkh4Ft11h8gevqRvyGltalkeJ
 Kpvs9tAtSC7+qMeocLpVy8LBIqBEI5bUv2DCF0TmcSZIdvKldLCFohbjr0PZyFoSAXoRITQUFEu
 GvUaqFh08efPo04n7vt1LEMn4MxfzBcBzCFg4H73T9rufkjrJ+WCpaj5uGn+5NMuEnV+GESBHRn
 /d4lPY9+WyLHpJw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Convert the Google Virtual Ethernet (GVE) driver to use the new
.get_rx_ring_count ethtool operation instead of handling
ETHTOOL_GRXRINGS in .get_rxnfc. This simplifies the code by moving the
ring count query to a dedicated callback.

The new callback provides the same functionality in a more direct way,
following the ongoing ethtool API modernization.

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Added the reviewed-by tags
- Link to v1: https://patch.msgid.link/20251222-gxring_google-v1-1-35e7467e5c1a@debian.org
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
base-commit: c303e8b86d9dbd6868f5216272973292f7f3b7f1
change-id: 20251222-gxring_google-d6c76c372f76

Best regards,
--  
Breno Leitao <leitao@debian.org>


