Return-Path: <netdev+bounces-253324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LV0HaYGd2lGawEAu9opvQ
	(envelope-from <netdev+bounces-253324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:16:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D749B8467D
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 07:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69EC4300822A
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 06:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FC826D4DF;
	Mon, 26 Jan 2026 06:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqZdU/DI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087C0264614
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 06:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769408119; cv=none; b=MmzFuCctfnjvgYS/sphtG2AFMU9GpeU/+KfpsSHVkdoHt4SMnkGZlW8fZ4dDhUJHk5FkoGz4X2nFJmSpdTeEpBu3bQGojyLUup73DXmiRIu4Irs8bQi5BkH9l2tI1HplEKnBQ2yLUgXgnNFuunAguF1IKfhD/gvmMwiLRGNsLAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769408119; c=relaxed/simple;
	bh=eK9IEQxX6bPuQTZmqf3fBzqSi3lRKs7tjHBkjQMOx5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+hXuXZEd4cWXRjdFQgss3mYJMzJUGu4AZS6SIfgHgU4xfcSkguXKDf6shFInwh1QIq+U3iyWiZPC6h3o6O9gToLyIN1fU8rlR0+H0GpW6gLj/q3H68afZeGDA10Rsqv7vSsOqMSjgQgsHza10YsmS2xn6Q3VfM0jwkvfRZOlto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqZdU/DI; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a0ac29fca1so31097215ad.2
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769408117; x=1770012917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1BtHozxghZJqgMzo9JEMTRARSx5nNU/9Ls9XrihPew=;
        b=QqZdU/DIoAP32fY2NRBhsdfz0TayJ1RcDDiy4CmVKklVPK9M78lCRZcp82GNyzym2M
         2zwCuwr5PSst3QfKHcjXGNZ+YjGSwnmEww5Ha+snvGV3j4tO0noncCrS1HtrkHh6S/Gu
         tNwWb5t57VU2O0cEzW8uxUVR8MbbbUbxJBH8IhIGYcu4vWf+VnaOg2H6BaAkxLcDchP+
         Puc2KWBZmz1uLU3KC7QQODZ/4CEfnHP0wgiW34bwofI/ktVoqAaVzauLBdlwcD97eNoz
         UG4hSQoCnFDaMY8cp6CV4MuWMA0oliqOExme/Qv7WUvAawHl6kTlvrLnJqFX2P/mapN8
         Cb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769408117; x=1770012917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p1BtHozxghZJqgMzo9JEMTRARSx5nNU/9Ls9XrihPew=;
        b=I4SSbJ25wVvzMbLyQ/neSXd8L0qt8yNXN72QWHN51wal0O4U0UrdRY0AZ15zdHpWL6
         pOq8vJwMXUDpuF2E2+y3YG96mc0YyUbO/3hYF9oXivfEBnqRJhIsJzLm7UjwqKq9i7gS
         8py1O5E2jmvqZm8Np4xHT7jKOAlKO895/L6embmIzAe752j6PT+SqU/Li+TcNm01R610
         pHT+Ls55I/J0KxpV4BZr7cfuJLE2308aiRDlXhS6kPM1EjA2W5qYK6fFYer9o+OSYC7N
         T6Hulixnqe60i4MJu2QW1teQyMZawFs9baregKwRa7wcaV6G5P0Kz9igM0hx/HD/vDHe
         ObdQ==
X-Gm-Message-State: AOJu0Yx0g4lJ3bKuZWIUr8kVncTPihGzoXXx8XCQxi7eGB+Q2dkhN9y5
	1xx7XBhmDFpM4Nh7Tv2LcgE1KO6ghHX/7IXlHphFAILBI15IuWEUPBkaF9XzxbO2
X-Gm-Gg: AZuq6aLaC5bQMQW2oLEdAfZtO1xpBUYuhDqDzNiHIY0rn3k9D31tdwpy8FP6OMK/iDv
	dNVaTe9cbjUoWmJZFOLtZ66+nO9j3eN+0pj0RkB9u8u9YgZRKYAzXMGtPwumH3Euyer/+xrHxq2
	fD/IGOM3okjQ0Siem8jtRt5Qkwu0C2AnJUD74HXyzvzIJVoXj2AeK9nJyAtrfFMcgPbijhk9Zff
	zidVDs+UUIoLYJXlbxw/TDgmz+8Y+9Cw+G5vD0P5DbPJP5+jOdfwv7uBkdxbTFTQ66ZP5VlxKi2
	gwS0CD+TbMy9VBmbQHaUyJ5udExppPPCbkstczw6LQw6toTXwnVb/krhm+vYfclOfsIATNszYp/
	QDLFzBKyDi5cnrRLe1vsTWZmEfS2PRixmlbudS2bVANteql0ON/k4xmO7EVsTEfIyovXaX9D3c2
	c/YWV64hf8bpuHj7QC+Jg3A64dngUGK8JiG1W4BK4NkkGxikvOWb51EuTAZg7l+wJn
X-Received: by 2002:a17:902:d58b:b0:2a1:e19:ff0 with SMTP id d9443c01a7336-2a8452b2031mr32575335ad.39.1769408117209;
        Sun, 25 Jan 2026 22:15:17 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802ede745sm79477325ad.44.2026.01.25.22.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 22:15:16 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] net: dsa: sync dsa_mall_policer_tc_entry with FLOW_ACTION_POLICE
Date: Mon, 26 Jan 2026 14:13:29 +0800
Message-ID: <20260126061340.757543-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126061340.757543-1-mmyangfl@gmail.com>
References: <20260126061340.757543-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,bootlin.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253324-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D749B8467D
X-Rspamd-Action: no action

New options were introduced to FLOW_ACTION_POLICE
after struct dsa_mall_policer_tc_entry was added. The following commands
will succeed on DSA ports:

  tc qdisc add dev lan1 handle ffff: ingress
  tc filter add dev lan1 ingress matchall skip_sw action police \
    pkts_rate 80000 pkts_burst 100 mtu 1000 conform-exceed ok

resulting 1. burst_pkt, rate_pkt_ps, etc. being ignored; 2. burst and
rate_bytes_per_sec set to 0 without any error.

Instead of making decisions for drivers, extend struct
dsa_mall_policer_tc_entry to all options for FLOW_ACTION_POLICE in favor
of full functionalities, such as packet rate mode.

Drivers must reject unsupported combinations.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 include/net/dsa.h | 11 +++++++++++
 net/dsa/user.c    |  7 +++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 6b2b5ed64ea4..4c177b168ec8 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -21,6 +21,7 @@
 #include <linux/phylink.h>
 #include <net/devlink.h>
 #include <net/switchdev.h>
+#include <net/flow_offload.h>
 
 struct dsa_8021q_context;
 struct tc_action;
@@ -220,6 +221,16 @@ struct dsa_mall_mirror_tc_entry {
 struct dsa_mall_policer_tc_entry {
 	u32 burst;
 	u64 rate_bytes_per_sec;
+	u64 peakrate_bytes_ps;
+	u32 avrate;
+	u16 overhead;
+	u64 burst_pkt;
+	u64 rate_pkt_ps;
+	u32 mtu;
+	struct {
+		enum flow_action_id act_id;
+		u32 extval;
+	} exceed, notexceed;
 };
 
 /* TC matchall entry */
diff --git a/net/dsa/user.c b/net/dsa/user.c
index f59d66f0975d..4c9cff629d5c 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1497,8 +1497,11 @@ dsa_user_add_cls_matchall_police(struct net_device *dev,
 	mall_tc_entry->cookie = cls->cookie;
 	mall_tc_entry->type = DSA_PORT_MALL_POLICER;
 	policer = &mall_tc_entry->policer;
-	policer->rate_bytes_per_sec = act->police.rate_bytes_ps;
-	policer->burst = act->police.burst;
+	/* so sad, flow_offload.h did not export the type of act->police, and
+	 * it's a nightmare to copy it field by field
+	 */
+	static_assert(sizeof(act->police) == sizeof(*policer));
+	memcpy(policer, &act->police, sizeof(*policer));
 
 	err = ds->ops->port_policer_add(ds, dp->index, policer);
 	if (err) {
-- 
2.51.0


