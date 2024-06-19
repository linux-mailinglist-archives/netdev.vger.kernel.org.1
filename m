Return-Path: <netdev+bounces-105042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2C890F7CF
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20484B24696
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB2115CD4B;
	Wed, 19 Jun 2024 20:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIxsyE+Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D33915B978;
	Wed, 19 Jun 2024 20:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718830375; cv=none; b=BesVILhcZcU3JqDoS6KDZuh1ydw3OWYAjw/qyBLRRgqYMkPO5G65brOvxrIen75K4swhbUX8QyNU59kigApb+cKcTMnPkPWS3Gxw/STrHZykXtge1Ne9vR3a6UCqcdjItukRKcUKE8Z6m6NX2UsHlkG8jrE45aZE7vPrEihw8Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718830375; c=relaxed/simple;
	bh=ryzr94jiDbxvn1UKYpCLAYrAd531lJHs0V4GlGi65kk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eofmm+05xAhS/rzB0R7pjRcdbQrrHTXehoXGA6Zgnw4qBkFHL6iuXw3jwqtw7PsXqPNx/Qr17FTQrZ8VZqxJR3NxYgepta1iVbEY0/zVaTlBPpxGFV/1Svjags1X/NUyHyub0+ifXfIMCXfw9AVuanFr48TQcB3Qn2gvKg1pQiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIxsyE+Y; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6f11a2d18aso16842666b.2;
        Wed, 19 Jun 2024 13:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718830372; x=1719435172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wM5Kz967B75V49PINKNVd0bROuq9raZP9aOqhcpiMs0=;
        b=dIxsyE+Y6S91TaIGBy9BPmE5+QuHGhPScdDc1ultG/VabY8JktTCDNr4fXNdk3+IfT
         qqhKLRvB0Qu0IsvTzzXXNml7u2iWj+BdRfNMq9ertpthYxL2ahc8MTC8l2zVBuqNEMZG
         4d8RfCJv2g4qDJ4P2KhOgmJwQzPjD2j/gkVV1gfEiaxhMmPAsNOiJaAn7B8DZRw6zd2U
         kyB31oiPRQyq7IA8FJsSxn+Qq5eYj6IEpAojV7PPi8wH4Cs2/L+NZHqLgZ5I3aFTp1zD
         Vdt6SOXVt5ogbQj2gI+A44jkF9LMjHrdrvjaTM2jrREAFKDKHf/LAEL0yuTpf1tKg1T9
         jycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718830372; x=1719435172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wM5Kz967B75V49PINKNVd0bROuq9raZP9aOqhcpiMs0=;
        b=PQS6kr3AZajtAXvNAsNB27/aGLgdifpw0GIBECLMKgcpjop+8p2uKczPHBne+6xl3f
         vOFR2zUn2WAu88QLBPbgZvmsWrykY3BU2WMf6KJZqG9Hn5vR7BOkLENFwlN6y610EcqX
         GGzljQNxrHQYyckJTR2+unuAcdwBWFQlWkH4+t8nLqaecmNte8kXOnByC1+Tculql3KZ
         8QtEEQrE1LFgFJhfW+XF5BOkOy/EIhPhDiE7yYjtUZ1MmmKe7+fHCGggybxD1MUifNK6
         PxYmwCxUaeOHY9BWTnJ4SOsozCjxmJNO/2JD5L7JlB1TD8qimh3L7H8V/U2JV6a5Hy7Z
         8tcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo4iEC0Kv53PxCbTLPn3TrbCbWSCIYiJ3XWUyfnXjsyrekJ3yesH6RnNeVpU2U5Cl2BwRnQ67uQwUrQntKq3b/xv7cxIfNEa4s4+tO
X-Gm-Message-State: AOJu0YyNepLMmQwvWGh4Zp9e4dHuJHCDFK1riaTQ8gzH+9E5BMHldSBn
	BaUPrm5xxtTAVUgKrYciBqobxGfZzRofnWJBPKJROrXbN/5WB824LZHzTKdmsx4=
X-Google-Smtp-Source: AGHT+IHTEln6tcijpMeQtzxrgdrOn6ihLv/cWdGfFQ0E+Pa7cJJ89T7t6a+fwmAvjwcubeRCFwm+GA==
X-Received: by 2002:a17:907:31ca:b0:a6f:49b1:dec5 with SMTP id a640c23a62f3a-a6fab643faamr231874466b.46.1718830371954;
        Wed, 19 Jun 2024 13:52:51 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db5b2fsm697329566b.47.2024.06.19.13.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 13:52:51 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 05/12] net: dsa: tag_sja1105: prefer precise source port info on SJA1110 too
Date: Wed, 19 Jun 2024 22:52:11 +0200
Message-Id: <20240619205220.965844-6-paweldembicki@gmail.com>
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

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Now that dsa_8021q_rcv() handles better the case where we don't
overwrite the precise source information if it comes from an external
(non-tag_8021q) source, we can now unify the call sequence between
sja1105_rcv() and sja1110_rcv().

This is a preparatory change for creating a higher-level wrapper for the
entire sequence which will live in tag_8021q.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v2, v1:
  - resend only
---
Before patch series split:
https://patchwork.kernel.org/project/netdevbpf/list/?series=841034&state=%2A&archive=both
v8,v7,v6,v5:
  - resend only
v4:
  - introduce patch and replace 'slave' with 'conduit' after rebase
---
 net/dsa/tag_sja1105.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index 7639ccb94d35..35a6346549f2 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -652,12 +652,12 @@ static struct sk_buff *sja1110_rcv(struct sk_buff *skb,
 	if (likely(sja1105_skb_has_tag_8021q(skb)))
 		dsa_8021q_rcv(skb, &source_port, &switch_id, &vbid, &vid);
 
-	if (vbid >= 1)
+	if (source_port != -1 && switch_id != -1)
+		skb->dev = dsa_conduit_find_user(netdev, switch_id, source_port);
+	else if (vbid >= 1)
 		skb->dev = dsa_tag_8021q_find_port_by_vbid(netdev, vbid);
-	else if (source_port == -1 || switch_id == -1)
-		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
 	else
-		skb->dev = dsa_conduit_find_user(netdev, switch_id, source_port);
+		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
 	if (!skb->dev) {
 		netdev_warn(netdev, "Couldn't decode source port\n");
 		return NULL;
-- 
2.34.1


