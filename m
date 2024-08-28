Return-Path: <netdev+bounces-122724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E81962502
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639C4281934
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 10:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC1C16A37C;
	Wed, 28 Aug 2024 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApmTtTCy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D7F16C6B5
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841200; cv=none; b=G/fw9IeRbO6JMC+YPQd9jys726W1t+u2T4XiUDodbML66DeqqD+njjNoT+KOBqP4Tx5hb4Twjn3bZ01gx8cvr3CXRILiPWN3DXfdyAinH0t7597dobUIlQsyYDxLIL14+j2dm3Hwf/JbyP4ch6mzm5JLFfGGBsNkm7lCh263M1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841200; c=relaxed/simple;
	bh=3HbmtqVFcODeXE3G34ocVPAEW6flRYhn/scAA7N9xLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiMqDBqwzXETPF3l5jZET70DaJx1SBRBPVJTgG/BOoqbxM0pGj/9PmqDISdIM2f1MOC98qrFOc4V2CNOGySTcyokWfaSLFQYHZbTZHeEVxxA7fS+oIq02AMlLEa9KMOVJ0KNuT6DPWjH+Up2GlbAjHFbqKU8m2mWeuARrqvZXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApmTtTCy; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-204f52fe74dso7510765ad.1
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 03:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724841198; x=1725445998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13kCqpXieHBRS9c9vlRFrwDqk66N5epm1Ti3AnVC+XE=;
        b=ApmTtTCyQC7CoABspZMUopIyT8imrgJjnituF9KzhXPfmMQZi8epZTnvoV0TjZeFjG
         zniHBqvgyza+cGqJ3vYfXEOmnYuJyw9vDUewumDD1bVQzwKX9RfV09KBc3eqGyZLQ+mY
         w1xyn8opEVapeo+iKOsSeLsCLCdmWVRrtwaUOYHnPzg+alOnj26riFktYFoF69vVyx7f
         UM0jGWWwVkWE1+gjZEuFjEktabbKDAnhHa+XsJ3znSi2v+jJab2ol2WH0GF5MNFMH55I
         wLGJxzhYAIA7fhRgNcNAl1o5ihhelKdFlJ8SodQkLMx+XC2n0T13Iq+zb30rxswlQ62j
         GrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724841198; x=1725445998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13kCqpXieHBRS9c9vlRFrwDqk66N5epm1Ti3AnVC+XE=;
        b=S6wfAtwBho0gwvCAoVn4+Pr0VRyWUNKr7XXSvsTruFdOkjkAmwlSNju5qLKGcA6WNQ
         rbjSZwdojln7zH/GsQwiB90HqMsbfG5Sc24YwEWEw/3cwyP2OEnomkVG4trhfxNRNqM7
         8et5F0iPLpMIAPN+ciFAGDrihSmP7cT3hKF1dRlhbezWeLs8oH5eBaDL+saYDofIl4jg
         EhoYK/q7/0NDw1BsmyT5UQts5S0Na0OeufkIrr0FAjZzx7R7MD9TBM+4un8HcQ0HGxvT
         zoF2scVHj4935PVogKpkUu8Ox6CiCruVsk6xIqoArM6I6Nvk9rpQIUHwf8eiUuWXoRWt
         34AA==
X-Gm-Message-State: AOJu0YxORjAKuiIAH4zCw435a4V+6Vu6haorHRe91tiq0c5oMjtxN9Ja
	S8M9XJdO7WdrXOpNy6TKDQbe1PSjvaDp0CLTobYGMCPHWG+CNRMXewS63Ti6dsJ22g==
X-Google-Smtp-Source: AGHT+IFyCL6oPmY5Dp099alQe2RXskyeA6EpmoEO608urHo67ZDuOqO9PeKbus4F+s9AcaGFhfZZCw==
X-Received: by 2002:a17:902:f790:b0:1fd:6bfa:f59 with SMTP id d9443c01a7336-204f9b7cbbbmr21478935ad.19.1724841197737;
        Wed, 28 Aug 2024 03:33:17 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855ddaeesm96298835ad.124.2024.08.28.03.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 03:33:17 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jay Vosburgh <jv@jvosburgh.net>
Subject: [PATCHv5 net-next 3/3] bonding: support xfrm state update
Date: Wed, 28 Aug 2024 18:32:54 +0800
Message-ID: <20240828103254.2359215-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240828103254.2359215-1-liuhangbin@gmail.com>
References: <20240828103254.2359215-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch add xfrm statistics update for bonding IPsec offload.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Acked-by: Jay Vosburgh <jv@jvosburgh.net>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index c0a20b834c87..042d7627bdc6 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -672,11 +672,36 @@ static void bond_advance_esn_state(struct xfrm_state *xs)
 	rcu_read_unlock();
 }
 
+/**
+ * bond_xfrm_update_stats - Update xfrm state
+ * @xs: pointer to transformer state struct
+ **/
+static void bond_xfrm_update_stats(struct xfrm_state *xs)
+{
+	struct net_device *real_dev;
+
+	rcu_read_lock();
+	real_dev = bond_ipsec_dev(xs);
+	if (!real_dev)
+		goto out;
+
+	if (!real_dev->xfrmdev_ops ||
+	    !real_dev->xfrmdev_ops->xdo_dev_state_update_stats) {
+		pr_warn_ratelimited("%s: %s doesn't support xdo_dev_state_update_stats\n", __func__, real_dev->name);
+		goto out;
+	}
+
+	real_dev->xfrmdev_ops->xdo_dev_state_update_stats(xs);
+out:
+	rcu_read_unlock();
+}
+
 static const struct xfrmdev_ops bond_xfrmdev_ops = {
 	.xdo_dev_state_add = bond_ipsec_add_sa,
 	.xdo_dev_state_delete = bond_ipsec_del_sa,
 	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
 	.xdo_dev_state_advance_esn = bond_advance_esn_state,
+	.xdo_dev_state_update_stats = bond_xfrm_update_stats,
 };
 #endif /* CONFIG_XFRM_OFFLOAD */
 
-- 
2.45.0


