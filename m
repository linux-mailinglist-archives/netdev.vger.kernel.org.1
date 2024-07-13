Return-Path: <netdev+bounces-111273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A5E930765
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 23:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449FB1F20FB8
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 21:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A57417108A;
	Sat, 13 Jul 2024 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtVxNcHd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D5F16FF5C;
	Sat, 13 Jul 2024 21:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720905410; cv=none; b=VqysXalizgZFkl8xBeKF2teRizQTkL09+9iaZHm68Du27h8Sn7PMF49QZHvuKors74vppRpUkyDyayUhO22nkyzVv8PQ5gi8HTxLVpFiciKhxH7mZ+zhgNzFeZKRm8cHhmzRItw+Q5yoJQddGjyaE/jmhWulGBqp++jjosdAGSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720905410; c=relaxed/simple;
	bh=1Z4gr/Jj9kbO75/oOpjkcW1jhK1ubnFYwCOhvxkRdpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z6GPtqtKhVgK4HspuglKz+1NpQqI2Xz3cSFbS7rcH65YPCBAS6u6D7BRjzQPabB7wuJa/ec27cbQ+lwEPgCAhU94Eyx3C1BiRPU8l7mzHYFnGwKlgM15bbP2iR3BEJVmFcJIE6H3i3NTdZQaJIrssuW/XiBnUVWH5ERlJ4i4+C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtVxNcHd; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52ea2b6a9f5so3271141e87.0;
        Sat, 13 Jul 2024 14:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720905406; x=1721510206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODG/xvZduNgRrLBGgVVlf8RXaZ1jjbM+7Wl+c5CBHqw=;
        b=gtVxNcHdntgEwkg9AZpolfeoiJKM/dIZ9op+GnBA1Sted779YReuaBjnOogskTb3TV
         M1TMDwElK6KM/AV6BhYHPASrAoAXTDtH1dGnwmVm95lLzuIgGpR/yDwz81BBMDtKWH63
         AKxMqREe5+3+l7tSidT5gF9x9fcV96+Ediij9EiNrUkYT50c29AqzdquAP9ldQfS6Jw7
         5dYvcyqZjVg9ZR/qYq1PZK9Pu+USgolQsfLThjpHN7HB4mOLoqNXhL7XOSSqGxIQh53J
         MZSkoTI72Iw+4WPUyYgwgHSRm8QA9QchxUiiZIx09MlYvfoGuRhnf5ZFmR+0SQx/ZdXn
         cyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720905406; x=1721510206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODG/xvZduNgRrLBGgVVlf8RXaZ1jjbM+7Wl+c5CBHqw=;
        b=c87g9GxZFEQ4BqJFIXX1m/+L78rqYtSTSXfnOA3FNPhchNtrorQ1PfAZMt+AQ6EeOx
         jzzuarDFlLi6FscGJOdhj8ayK1cKtfGCY6xq4iIY9thYzg9J5mJhOur4QyXLwHnhwf9Z
         YijNTjhvSNH+v0ZRxRguXAcfV9ZTIp45uADt58sufaYmdb6nOG1Ynw/QPh/Li9o9r4tO
         DCM+pT7NXChM7rOyjVvWDSNaMhWaN0hH7pbrQUAD/fxya68NOCLQkLlUHnNIHacbnPOR
         Jw8WpCYQquoLJKnoxw0keUQ9Fj2tjugaou+2BCl2+kzbPdrXjcdDUmFjB9TAnmrb7NrC
         eahA==
X-Forwarded-Encrypted: i=1; AJvYcCXoTsPp+OlT2baUO/NLY0+xRS0Lmc+SI6gx16+fOKRotEHGevM98JpqG8UWV4baYYL0vZaLViYqEhJkWV+jVs7UGBX1fyu5dg8+TLr7
X-Gm-Message-State: AOJu0YxeS/6RLhv9rhwkxn7h7JY2qg62Dnmt+uRYTDcO69moFRvOUJFV
	R8X2+ng6vuY5wc1cc2qFwru0vKYPyzm8UOPZ/nQorQh55Gkj2tcM60O4H4Kv
X-Google-Smtp-Source: AGHT+IHukxbZQxJmkD+Q1WRBCs8RgTcfmR83T8CGhOSNey12AVF6rQIqhavKzYG9D0/g/lP6s2VSBw==
X-Received: by 2002:a05:6512:3b8c:b0:52c:6461:e913 with SMTP id 2adb3069b0e04-52eb999623amr10737553e87.16.1720905406093;
        Sat, 13 Jul 2024 14:16:46 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b255253b6sm1187286a12.41.2024.07.13.14.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 14:16:45 -0700 (PDT)
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
Subject: [PATCH net-next v4 05/12] net: dsa: tag_sja1105: prefer precise source port info on SJA1110 too
Date: Sat, 13 Jul 2024 23:16:11 +0200
Message-Id: <20240713211620.1125910-6-paweldembicki@gmail.com>
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

Now that dsa_8021q_rcv() handles better the case where we don't
overwrite the precise source information if it comes from an external
(non-tag_8021q) source, we can now unify the call sequence between
sja1105_rcv() and sja1110_rcv().

This is a preparatory change for creating a higher-level wrapper for the
entire sequence which will live in tag_8021q.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
v4:
  - resend only
v3:
  - added 'Reviewed-by' only
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


