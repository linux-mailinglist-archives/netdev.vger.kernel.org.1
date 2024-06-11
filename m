Return-Path: <netdev+bounces-102692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B38904543
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 21:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8521F2731B
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 19:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4466F155332;
	Tue, 11 Jun 2024 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Be8b50Xk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA45155323;
	Tue, 11 Jun 2024 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718135470; cv=none; b=I+mrRV7UJvntjj2xLKDBv6sXs0P3XLODqTLhjam9ILwKCA7h7juITzkNsUOt4whxAAF70+imNPszPP5ArE5MWjDiHKS/LQVV03fjOw4qB8DM5Zu8NYAz8E9wgdr3jE+ZTcGAY7JG/eKdqPD0kpSZaeNoSiMVBz4sCVosvr0jyMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718135470; c=relaxed/simple;
	bh=EGzLIr8J6g5Pc6ruWwM3htFjv6loaPRNQh8Kypboh6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tQrgl7Gt1gQqYrq2NhmmSEgFEsX+fsnSeMoolRL0cSCdU97nEjO4Jfx6O1Slm3CgbIdcxOhwRrJKKTBIl7bpC5d3zF7XL1WKXo2n+A87giyBsZ0GWfBbaZPY6FqsC1IIc3fTfAs3yCUJY9Bn8ygfaxKBrUKgcot+2ZYFuINAMzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Be8b50Xk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-579fa270e53so2388785a12.3;
        Tue, 11 Jun 2024 12:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718135466; x=1718740266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmBOyhIK8bj8E+oMmNWfuKWO1MxxTZyTVSN1v/d4NYg=;
        b=Be8b50XkTUAV4taCda1QRqM20DddGyoIp2qoskBC8Ux+2nZGC7WdHN4o4vKIZFpZPp
         r9DiBj/FuBjq/KD+0nHoa4mYRYGfsXoy0t8vzxAlH35UXZ0p7Vgws18X42Uit/nHscG7
         fV18gJmDJCr1p7j9eedkuBi5EfN/6gUuz9gjSEn1okBtqOKK3qqXPeYhRJ1x78cOTzWI
         HnqX5WSOEaLgIK2wDPyXknRXTFYqXCLHE12EMOcBuv31TgVtKHcBYcBWdJKtigW09bC+
         pdYx8dkax3b86R9OYr/ZfsL8jRLn88RfB5keBY3PqOyIR8RHiYADTYZyyp0q+9chGhue
         sB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718135466; x=1718740266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmBOyhIK8bj8E+oMmNWfuKWO1MxxTZyTVSN1v/d4NYg=;
        b=QOJdxOYzyEfNlThNHkw2MOfCWSNRspVbqREx+KK6XxP14CcwPrPwt3HzbB3Id0me4n
         GGDe4MWSvAKPO1dupte7EQYfygvMaiJmhWqJ1KbgsqMCt2NNc6iwB7YCjsaky96U2tVd
         nrK/H57Mpm2yiYfQ1XrEJpWJdULCy7hGsSlhbSiXPby2ZV/4XPPsAZKrt60RK1ECQSv5
         e0kKUhm8Vdhig6xeUEnkI5YOytndHK3Af55LHlEb/6Cjk5fQ89lKrlsjpWIatrbe+DIC
         vLjs+REFt8xnLAaS41dmHzdKJPox4QAKdKPfd8ofw0LLtycKnUctqFS2De2ZOWa+vC/C
         OoFg==
X-Forwarded-Encrypted: i=1; AJvYcCVy+TPlwswXjm6Iqywmb8WfaszO/kyp2AKHXv8GbVKUingHy6o6R2ZmvPDIqf5z5i3CA8rsfZiytBhy5l5PDcY6GAGFVehbVA3oQcNg
X-Gm-Message-State: AOJu0Yyxnc0wWZTn8V/fJia1KNsiZ4Z9iuY4wzvPXuY4ZWa3/r0jJ1X6
	cHVzUxR/RnmgSH9gWTbWqJFIi+L8sBEtNQ4v+zSQP3//BQhTz8uwbcABsojlO+Q=
X-Google-Smtp-Source: AGHT+IHnebIc1CaYifooFoLoGqBbMHHopBtBX0svSF49Bbk+C9xlpxnhWcIF5LENXspq1VVQeHyCPA==
X-Received: by 2002:a50:9b03:0:b0:57c:6f67:b173 with SMTP id 4fb4d7f45d1cf-57c6f67b45emr7243745a12.2.1718135466302;
        Tue, 11 Jun 2024 12:51:06 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c7650b371sm5286737a12.76.2024.06.11.12.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 12:51:05 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 03/12] net: dsa: tag_sja1105: absorb logic for not overwriting precise info into dsa_8021q_rcv()
Date: Tue, 11 Jun 2024 21:49:55 +0200
Message-Id: <20240611195007.486919-4-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611195007.486919-1-paweldembicki@gmail.com>
References: <20240611195007.486919-1-paweldembicki@gmail.com>
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
---
v1:
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


