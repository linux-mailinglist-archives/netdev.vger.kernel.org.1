Return-Path: <netdev+bounces-111271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76601930761
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 23:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5B52827F3
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 21:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8DA16191E;
	Sat, 13 Jul 2024 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkuQ5Jve"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0344B15ECFA;
	Sat, 13 Jul 2024 21:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720905402; cv=none; b=rUX8j3aTYc1JXJxpFCH271FXBJf2Mcdiwy71CTNVCi17DN8r+My/kPIsYOdRO+jtbrBBEWulQPvU3jdlU/ve5iZg6ZTO2tuzg/TooSLssZrWPowC3GQIu4RE8C0Wkn68d6qBtqnBQTybkBMr8hd4tVJMP+vDJyG5zekVm3Herqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720905402; c=relaxed/simple;
	bh=fUfSPcdNsrdJPBPsaK3Oou2+Ti6ATKt63rAVCWV73tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oClaXQxA4G+79aHtq8WYxYBuMcER0wsuFNRPuzAUHXCd96EksQ3Kn/HZcDTVvB27Xu7bZoVDjJX4qbErpY6Jnob3nXBGEiocXD81JAPm6uqVCt8Z436QBogbWKU/+24JIzAvDZO5Sa8TP0Okag5sblaek1+Ix7Br70N0RSMMjww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkuQ5Jve; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58d24201934so4954778a12.0;
        Sat, 13 Jul 2024 14:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720905399; x=1721510199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRfb4y5sl/KSemPX8lureXbQcjhUqye5u9tLj5bkvCs=;
        b=jkuQ5Jveh2TXy0KHO3Xm4QU1RG2hI4flZfEGXRT3f44KoaFqTD3f1Ru4QnXwpQTuig
         XzjCtN061RrCiIn6SG03/rrNaoh8GYrUqS5BunF6NEzRmdhA6eFDHqn+bkeqF4m4QZNl
         70TzbwuJFSnXcYqQjP2l5tCf4fO0ZyJjAIKjM9eaxzojy8TFVj5F8PIhWUwnUHjGcKOo
         obudX+UFD2w4FlVXhUu44ZP0FftJvpE7ml4VOd3dYGplbS+wBTHuPvZ6bLSxujZr5emg
         p7dc/hoSjtHeRXNZvy9Mjf8/KR7Wfs+qr5p0CI+ieX2/wPXk4n301ayJf+byj/0zJciA
         twtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720905399; x=1721510199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRfb4y5sl/KSemPX8lureXbQcjhUqye5u9tLj5bkvCs=;
        b=R7lKJ+WKDCsllfJ4jaNU9tYg9cUsKmNmBOXs04d8HZ/ll2t2rVZmup3PLsffCKZYKG
         QzDLJiQfQIAjV+lZ8wIqJK/kj3fgebxbmqJ+LO82cL/MgA47RfzeTgXwxTd2RO6GG73H
         fjCruxwLLEKqVbnMJmxP5qOJ1q2BDHSByNyAiDa77l4sTcSkRH10IIhThrubr51cP0QJ
         XuNn2WNZ52xVQK1i1t3my3cZMPa2wWqrOBC+zhBoqBweORU0Yn82CY94xkYFAs/9tNwh
         1xP+jB7qbN31E+uf4Sv/jfKR5y/jwS5iOy65995zYJ43JphCoCKHvWhz7xd+VPfjeY2p
         FuiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhyPiXX8Ne4rhj81p2j1Xsrw6FvMswgH73EFwZzU11Q1Ug9QyXVH6Cv5sVAiHnNYnI8JrCGd7058cWfaDjCeVNhHU5tz4TeX5/0dbl
X-Gm-Message-State: AOJu0Yw8E6tbMfAoKjpRFlb5R8jHgvBSoFGRFHl0axwHY2c0NXtN4qKX
	KFu38fIP32pokMDBTQFQTIYBD71qZMLSttlYPQq56Cr7cb3wOKV9590LtKmn
X-Google-Smtp-Source: AGHT+IG1E63eMrRdSu/T42SNHu4t1jg/7+kEWDYDEGyazOHlEP1Y9fVVkXbN4wFiGlDWrpnFhUY1kA==
X-Received: by 2002:a50:9fe6:0:b0:58b:5610:945c with SMTP id 4fb4d7f45d1cf-599605ca710mr4987491a12.17.1720905398792;
        Sat, 13 Jul 2024 14:16:38 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b255253b6sm1187286a12.41.2024.07.13.14.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 14:16:38 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
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
Subject: [PATCH net-next v4 03/12] net: dsa: tag_sja1105: absorb logic for not overwriting precise info into dsa_8021q_rcv()
Date: Sat, 13 Jul 2024 23:16:09 +0200
Message-Id: <20240713211620.1125910-4-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713211620.1125910-1-paweldembicki@gmail.com>
References: <20240713211620.1125910-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vladimir Oltean <vladimir.oltean@nxp.com>

In both sja1105_rcv() and sja1110_rcv(), we may have precise source port
information coming from parallel hardware mechanisms, in addition to the
tag_8021q header.

Only sja1105_rcv() has extra logic to not overwrite that precise info
with what's present in the VLAN tag. This is because sja1110_rcv() gets
by, by having a reversed set of checks when assigning skb->dev. When the
source port is imprecise (vbid >=1), source_port and switch_id will be
set to zeroes by dsa_8021q_rcv(), which might be problematic. But by
checking for vbid >= 1 first, sja1110_rcv() fends that off.

We would like to make more code common between sja1105_rcv() and
sja1110_rcv(), and for that, we need to make sure that sja1110_rcv()
also goes through the precise source port preservation logic.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Tested-by: Vladimir Oltean <olteanv@gmail.com>
---
v4:
  - resend only
v3:
  - added 'Reviewed-by' and 'Tested-by' only
v2,v1:
  - resend only
---
Before patch series split:
https://patchwork.kernel.org/project/netdevbpf/list/?series=841034&state=%2A&archive=both
v8, v7, v6:
  - resend only
v5:
  - add missing SoB
v4:
  - introduced patch
---
 net/dsa/tag_8021q.c   | 32 +++++++++++++++++++++++++++++---
 net/dsa/tag_sja1105.c | 23 +++--------------------
 2 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/net/dsa/tag_8021q.c b/net/dsa/tag_8021q.c
index 71b26ae6db39..3cb0293793a5 100644
--- a/net/dsa/tag_8021q.c
+++ b/net/dsa/tag_8021q.c
@@ -497,9 +497,21 @@ struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit,
 }
 EXPORT_SYMBOL_GPL(dsa_tag_8021q_find_port_by_vbid);
 
+/**
+ * dsa_8021q_rcv - Decode source information from tag_8021q header
+ * @skb: RX socket buffer
+ * @source_port: pointer to storage for precise source port information.
+ *	If this is known already from outside tag_8021q, the pre-initialized
+ *	value is preserved. If not known, pass -1.
+ * @switch_id: similar to source_port.
+ * @vbid: pointer to storage for imprecise bridge ID. Must be pre-initialized
+ *	with -1. If a positive value is returned, the source_port and switch_id
+ *	are invalid.
+ */
 void dsa_8021q_rcv(struct sk_buff *skb, int *source_port, int *switch_id,
 		   int *vbid)
 {
+	int tmp_source_port, tmp_switch_id, tmp_vbid;
 	u16 vid, tci;
 
 	if (skb_vlan_tag_present(skb)) {
@@ -513,11 +525,25 @@ void dsa_8021q_rcv(struct sk_buff *skb, int *source_port, int *switch_id,
 
 	vid = tci & VLAN_VID_MASK;
 
-	*source_port = dsa_8021q_rx_source_port(vid);
-	*switch_id = dsa_8021q_rx_switch_id(vid);
+	tmp_source_port = dsa_8021q_rx_source_port(vid);
+	tmp_switch_id = dsa_8021q_rx_switch_id(vid);
+	tmp_vbid = dsa_tag_8021q_rx_vbid(vid);
+
+	/* Precise source port information is unknown when receiving from a
+	 * VLAN-unaware bridging domain, and tmp_source_port and tmp_switch_id
+	 * are zeroes in this case.
+	 *
+	 * Preserve the source information from hardware-specific mechanisms,
+	 * if available. This allows us to not overwrite a valid source port
+	 * and switch ID with less precise values.
+	 */
+	if (tmp_vbid == 0 && *source_port == -1)
+		*source_port = tmp_source_port;
+	if (tmp_vbid == 0 && *switch_id == -1)
+		*switch_id = tmp_switch_id;
 
 	if (vbid)
-		*vbid = dsa_tag_8021q_rx_vbid(vid);
+		*vbid = tmp_vbid;
 
 	skb->priority = (tci & VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
 }
diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index 1aba1d05c27a..48886d4b7e3e 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -524,30 +524,13 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 	/* Normal data plane traffic and link-local frames are tagged with
 	 * a tag_8021q VLAN which we have to strip
 	 */
-	if (sja1105_skb_has_tag_8021q(skb)) {
-		int tmp_source_port = -1, tmp_switch_id = -1;
-
-		sja1105_vlan_rcv(skb, &tmp_source_port, &tmp_switch_id, &vbid,
-				 &vid);
-		/* Preserve the source information from the INCL_SRCPT option,
-		 * if available. This allows us to not overwrite a valid source
-		 * port and switch ID with zeroes when receiving link-local
-		 * frames from a VLAN-unaware bridged port (non-zero vbid) or a
-		 * VLAN-aware bridged port (non-zero vid). Furthermore, the
-		 * tag_8021q source port information is only of trust when the
-		 * vbid is 0 (precise port). Otherwise, tmp_source_port and
-		 * tmp_switch_id will be zeroes.
-		 */
-		if (vbid == 0 && source_port == -1)
-			source_port = tmp_source_port;
-		if (vbid == 0 && switch_id == -1)
-			switch_id = tmp_switch_id;
-	} else if (source_port == -1 && switch_id == -1) {
+	if (sja1105_skb_has_tag_8021q(skb))
+		sja1105_vlan_rcv(skb, &source_port, &switch_id, &vbid, &vid);
+	else if (source_port == -1 && switch_id == -1)
 		/* Packets with no source information have no chance of
 		 * getting accepted, drop them straight away.
 		 */
 		return NULL;
-	}
 
 	if (source_port != -1 && switch_id != -1)
 		skb->dev = dsa_conduit_find_user(netdev, switch_id, source_port);
-- 
2.34.1


