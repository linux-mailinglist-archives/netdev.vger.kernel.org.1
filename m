Return-Path: <netdev+bounces-254476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJvuGhqFemmk7QEAu9opvQ
	(envelope-from <netdev+bounces-254476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:52:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 571EEA942D
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96DF1300A8C5
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF6333C191;
	Wed, 28 Jan 2026 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcbGtuUP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72BB33B6D0
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769637144; cv=none; b=bfisrKZZxlZVOJFMMEwu/qfGI9vtCAGDaGHe0TXBxyI6t0UzotJrvAOokf+ljv4HpFGdpIR91QUt7Udfcafb4KVCUybfOMjCynxRi453uf/HAVaFQKrD7xiqihfIw8UuQy7AzyNpd9UebyIHqKfR2zWwNuYJCZf/zq/5h38IkIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769637144; c=relaxed/simple;
	bh=WIqyFR60WtQvFjGxnMQyotcdEzYgUqTwZe+r3///1LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shLluhGl4yJ+VKlBVrLubPT9XuieLTqeFxggK/XBWKJrUN9V68RBDyD2kYGsFmt6bodAYvW1zF4ESjfCNdvAZYfAhKdoxt6sxl6AFBZS6GYHymCkcgmZg2t8eOIEuW4B6Po6jo0U+HibWz1+1584+dDTLgu/pCpUewq97fPQwWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcbGtuUP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0ac29fca1so1681675ad.2
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 13:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769637140; x=1770241940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMbe85OGEE7zlHitn1goifPts6HC3d5wce34lH15J58=;
        b=kcbGtuUPWwYezukvZUuZW2C59amJ8sE/yRCt5nvymKBN4VmWW1yAh3WBZ9IgdVXf9B
         3Y47Ex4Nn2diXaRvcFbg+EuXCO/JryD03SiozPjekuTdcbfwBN6pKeb7Lc6b8G9okvW3
         /LNdE6ceE4dwFbWJigYYn5b8e1rydNYd7/sTk1mQpmDBkJYticwoWUoJVtDsdmHCqujG
         s63Z8WG8tTu45aaR1tRPTOhXg6fyobM/Nz2ZcYOSQmIccKr8N9zBWYP4tM3ZGl1EYppr
         cAJsaFTC/RejaJ1AAS4cJQkP2AV0LpJCtaO64q16Z6rl0drR84VIGqa8A4xDdk0qkNUC
         W5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769637140; x=1770241940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KMbe85OGEE7zlHitn1goifPts6HC3d5wce34lH15J58=;
        b=Ftg83xCVt2Qju+ck3VKqVwgAtPEWW5Pld3CEG5S8rWCqb6ERMc/MdQttPvHz0kjOw7
         rMSeD4u4X33gCRvai0loijfXCwwM+WVsoV7hykUof5DNB4hbw5mje0Eege3wosfILFkI
         IOT1qwJBMMJiwh+pjPhbpfor7UCLm4PF+io18lU1IOeUqkwQbj+8fnm44+PkIAJDX7Lr
         s89CrZuEsgp+Y6O+fUrG29M1sb86y7RQ9Xm+odWWz7N153meqStkuqUmC8b1pInPBoUA
         cc3a873FRtZEXo2XGBXm0tGhMBCwVDtel+mG+emiE6UptW+ZTEFb0fERnicA0knLKxCN
         w0rg==
X-Gm-Message-State: AOJu0YwVomzH48snmcxFbyXiCo6glvHgkDLaindup+YDL+32SAllZtA+
	QouH6ZtvOISII9yogLLGc6T1i0Vo7pmCwB90a4iaG/COT7YaSWM9JOBRl6qwa9mv
X-Gm-Gg: AZuq6aJ+bU9TdwX5nbtbRilFR2s8Cu+nbtXksJrgsDdvEXFRhOkEVHKoW7/GUpzZT6p
	Ne/xMkvDV3yXMY6bQk7P5AZguGQfaYvvoCs4rxB2l7X8q2cZDBhvi9NJQuSvpIf/7jUBGG94lIc
	54AdwL9ieehIxsZ7QuYeJ7W8MCi5XGAwPyKY5A4zf4pNQx/k6+GN/HjwEHU/SB2RlIk/Vczj4Re
	H8OCqk0P17c+MAoU+RHfDOfLzZIxxOJ2kEjyofQaUL77lieOTaR9OhpGkw5Paap7iZLiIPpO6rb
	LSdfgPOsFG3bQkP8NmIoHVcTsvNn5jhCmQbH3NxZxNRFxjqXn4lJu7iqnjBUxy32XGrvgsIU1mO
	jfiTPIMWBZDUKQnlVvaY19ihVn8ygee63GFKU3UVNrF6NnjKW/+X8PmXW5PsmoOxw9ybr9YqqL6
	disUp/PzT5rQhOGNiYhD8WkpPHIjxWWhvavB8=
X-Received: by 2002:a17:902:d4c8:b0:2a7:d5c0:c659 with SMTP id d9443c01a7336-2a870d40ab5mr65015505ad.5.1769637140072;
        Wed, 28 Jan 2026 13:52:20 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2a09:bac1:7680:d30::4:384])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e4317sm31576155ad.85.2026.01.28.13.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 13:52:19 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 2/4] net: dsa: yt921x: Refactor VLAN awareness setting
Date: Thu, 29 Jan 2026 05:51:54 +0800
Message-ID: <20260128215202.2244266-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128215202.2244266-1-mmyangfl@gmail.com>
References: <20260128215202.2244266-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254476-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 571EEA942D
X-Rspamd-Action: no action

Create a helper function to centralize the logic for enabling and
disabling VLAN awareness on a port.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index a4b346ddf8dd..ef9048b904ab 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -1768,6 +1768,18 @@ yt921x_dsa_port_mdb_add(struct dsa_switch *ds, int port,
 	return res;
 }
 
+static int
+yt921x_vlan_aware_set(struct yt921x_priv *priv, int port, bool vlan_aware)
+{
+	u32 ctrl;
+
+	if (!vlan_aware)
+		ctrl = 0;
+	else
+		ctrl = YT921X_PORT_IGR_TPIDn_CTAG(0);
+	return yt921x_reg_write(priv, YT921X_PORTn_IGR_TPID(port), ctrl);
+}
+
 static int
 yt921x_port_set_pvid(struct yt921x_priv *priv, int port, u16 vid)
 {
@@ -1817,14 +1829,7 @@ yt921x_vlan_filtering(struct yt921x_priv *priv, int port, bool vlan_filtering)
 	if (res)
 		return res;
 
-	/* Turn on / off VLAN awareness */
-	mask = YT921X_PORT_IGR_TPIDn_CTAG_M;
-	if (!vlan_filtering)
-		ctrl = 0;
-	else
-		ctrl = YT921X_PORT_IGR_TPIDn_CTAG(0);
-	res = yt921x_reg_update_bits(priv, YT921X_PORTn_IGR_TPID(port),
-				     mask, ctrl);
+	res = yt921x_vlan_aware_set(priv, port, vlan_filtering);
 	if (res)
 		return res;
 
@@ -2021,8 +2026,7 @@ static int yt921x_userport_standalone(struct yt921x_priv *priv, int port)
 		return res;
 
 	/* Turn off VLAN awareness */
-	mask = YT921X_PORT_IGR_TPIDn_CTAG_M;
-	res = yt921x_reg_clear_bits(priv, YT921X_PORTn_IGR_TPID(port), mask);
+	res = yt921x_vlan_aware_set(priv, port, false);
 	if (res)
 		return res;
 
-- 
2.51.0


