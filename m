Return-Path: <netdev+bounces-105047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDEC90F7D9
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8CA1C21550
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846AB15FD16;
	Wed, 19 Jun 2024 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPemwdjc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA65815FCEC;
	Wed, 19 Jun 2024 20:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718830392; cv=none; b=WyhalJ3z1k3kKzhWf7rMqllf2IX8hO9D13RXm8NlRbJzkpw0YvLLgMAFtUxfzbXpn0b1QgIflP4IxLK1E8tXTLxDcYsw57xfhAexxorirRwSYpA6eUQGr+slu6hywulPq/7wXT6Sv285uVZG7POQbXBlurwJYNtptGOKMM8qxKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718830392; c=relaxed/simple;
	bh=iTPUZBfzCkf+/yuz61S0/ak3LQhmxuEphI3zfk9SP8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KN6cE3qbpe01T0NU0kqjIK577igrlqSilnwkhjKRK61SQwA/FBH02eEJde9XsV4XDZXIyu22AHMxsuNayag7pSCXrl8bvKvEQsV3CqiLzILZJBREm5FImdFu52FGmdfvHK3ZyTxtOFmEUCD2+Pu/BmDJUml+ssnh665XJnt3+pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPemwdjc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57c75464e77so147375a12.0;
        Wed, 19 Jun 2024 13:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718830389; x=1719435189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWx0XDgfTJDWdwyFJFi3h8iE4GYO3m+A/XE9UQ+TAnU=;
        b=KPemwdjcvtNJahPqrbomJrCQgo2ns7g1X1ajNfTbBi9FG6A3iKkG8V1jHm1ZACuzts
         /Ecf1h2WEU36h/D+kUcW91AsotkCVOTAz8tQmecwcLZ1l87C7Phm2PjCw0ix1VrYieHP
         adyZKhmJHcfyD7/+pErduINDEGhCAAXNSMDsrL2jJxUEtHJ7R9fYCsbomGNFDb1M2SOi
         guDuqEpjKaSwc1mVk/oGhEiK673mTCoVG9biXek3aYqTAKeQ1qYeYTE8kOikLvI9eKdk
         fekTSEAUbe4r0UgB9sBHG3FdLbwuiIiNFPmI/rhiH9fHxvDrjMkC4l/ShwuhcdZRunJM
         xRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718830389; x=1719435189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWx0XDgfTJDWdwyFJFi3h8iE4GYO3m+A/XE9UQ+TAnU=;
        b=DKkhRMFc/cn0Aw0z23MgL3U7rtwIl9NJDJLUmlg4L+bhdOOjRi4O7IUjHkQbp82dzM
         D5habnnUrXUbJ+JhZH13YUCzKEfl0DlD905vMQPg+0Ut3mvr33Tqki5Ny8jpGYzZjKl9
         XKRQD/4RZhyi7WhhE3Xi3o2vJoBOuB8fTQ0PdHsHRHF0PUSMfYNq4NF4Z0ABRlbjdvPm
         8T6nz5Icuj2tBlE7qt6+9nlnZZU+m1Wk0GEItHfy8GTT2FYPAhuQCSA0oGMMkP9tQSAy
         JWQb0FvqQWeFKI1W7goMJysGAioa+0ynm6zhrNmK8VJCJee2V4trtjasfQS07JjXcFdh
         ICRw==
X-Forwarded-Encrypted: i=1; AJvYcCWxs0zu8qIl+VvQPqQkIfYWtUnVcU8FJSbteuJLb4RcUZV4pM1dhMnbNEBfwRMXj7SPjtnyNFLwSoBk5KCDxNzg54Up2GZl8hVbNLqL
X-Gm-Message-State: AOJu0YzbKlPHXpn5/48KgPThvUTNq7c3hsEQQpjXuH5dxruJ/ry4rji8
	VjWiqYPRmh3Qu3GfvBKI9P9Qu7Wb3LMTOYOk8gWdHfhS4Jo1uSmHgNM4AdsCh78=
X-Google-Smtp-Source: AGHT+IHkcNqTwVs1xK3fomQvnLszU2EYpoiBI8YRcweEGr5vS8cX9cqhyTHuN+P8X73D1Jub9goHtQ==
X-Received: by 2002:a17:907:c209:b0:a6f:467d:19ec with SMTP id a640c23a62f3a-a6fab613cafmr261868466b.18.1718830388764;
        Wed, 19 Jun 2024 13:53:08 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db5b2fsm697329566b.47.2024.06.19.13.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 13:53:08 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 10/12] net: dsa: prepare 'dsa_tag_8021q_bridge_join' for standalone use
Date: Wed, 19 Jun 2024 22:52:16 +0200
Message-Id: <20240619205220.965844-11-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205220.965844-1-paweldembicki@gmail.com>
References: <20240619205220.965844-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'dsa_tag_8021q_bridge_join' could be used as a generic implementation
of the 'ds->ops->port_bridge_join()' function. However, it is necessary
to synchronize their arguments.

This patch also moves the 'tx_fwd_offload' flag configuration line into
'dsa_tag_8021q_bridge_join' body. Currently, every (sja1105) driver sets
it, and the future vsc73xx implementation will also need it for
simplification.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v2:
  - resend only
v1:
  - introduce patch
---
 drivers/net/dsa/sja1105/sja1105_main.c | 5 ++---
 include/linux/dsa/8021q.h              | 3 ++-
 net/dsa/tag_8021q.c                    | 5 ++++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 0c55a29d7dd3..c7282ce3d11c 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2133,14 +2133,13 @@ static int sja1105_bridge_join(struct dsa_switch *ds, int port,
 	if (rc)
 		return rc;
 
-	rc = dsa_tag_8021q_bridge_join(ds, port, bridge);
+	rc = dsa_tag_8021q_bridge_join(ds, port, bridge, tx_fwd_offload,
+				       extack);
 	if (rc) {
 		sja1105_bridge_member(ds, port, bridge, false);
 		return rc;
 	}
 
-	*tx_fwd_offload = true;
-
 	return 0;
 }
 
diff --git a/include/linux/dsa/8021q.h b/include/linux/dsa/8021q.h
index 1dda2a13b832..d13aabdeb4b2 100644
--- a/include/linux/dsa/8021q.h
+++ b/include/linux/dsa/8021q.h
@@ -18,7 +18,8 @@ int dsa_tag_8021q_register(struct dsa_switch *ds, __be16 proto);
 void dsa_tag_8021q_unregister(struct dsa_switch *ds);
 
 int dsa_tag_8021q_bridge_join(struct dsa_switch *ds, int port,
-			      struct dsa_bridge bridge);
+			      struct dsa_bridge bridge, bool *tx_fwd_offload,
+			      struct netlink_ext_ack *extack);
 
 void dsa_tag_8021q_bridge_leave(struct dsa_switch *ds, int port,
 				struct dsa_bridge bridge);
diff --git a/net/dsa/tag_8021q.c b/net/dsa/tag_8021q.c
index 454d36c84671..81ac14603fb0 100644
--- a/net/dsa/tag_8021q.c
+++ b/net/dsa/tag_8021q.c
@@ -286,7 +286,8 @@ int dsa_switch_tag_8021q_vlan_del(struct dsa_switch *ds,
  * be used for VLAN-unaware bridging.
  */
 int dsa_tag_8021q_bridge_join(struct dsa_switch *ds, int port,
-			      struct dsa_bridge bridge)
+			      struct dsa_bridge bridge, bool *tx_fwd_offload,
+			      struct netlink_ext_ack *extack)
 {
 	struct dsa_port *dp = dsa_to_port(ds, port);
 	u16 standalone_vid, bridge_vid;
@@ -304,6 +305,8 @@ int dsa_tag_8021q_bridge_join(struct dsa_switch *ds, int port,
 
 	dsa_port_tag_8021q_vlan_del(dp, standalone_vid, false);
 
+	*tx_fwd_offload = true;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dsa_tag_8021q_bridge_join);
-- 
2.34.1


