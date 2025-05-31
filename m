Return-Path: <netdev+bounces-194472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ABEAC99AA
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 08:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C60F3B847B
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 06:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B501222F77B;
	Sat, 31 May 2025 06:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkXxnmBQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45A979C0;
	Sat, 31 May 2025 06:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748674005; cv=none; b=cOuri3djImWIZZnu0FpnUkBIAOGVkdjL+QEdSUskNE4SBhxSeQLUHlStD9PSKMfMQUzY9Spsph6jL7Hg9f4UttTKCpyzxne7Bce93rL7773DODxSZHIOKMKrY/zj8giDbVZHMUdJTNnV4i88nG5vUHmkWltWjMJ9VqIiJZSGSoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748674005; c=relaxed/simple;
	bh=uY3ybQBRlyKlkk5YyiDoD/dFx1qg3hOhVp7GVoN1+zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZffU4x8uFJa4hvfQGEcw3n/ZOGtu1Jcr/wp7C8I9xq1fkyTK+Q/SjHrdR0BuFcgLlL8xioBFk54XWBXfk386Re2W/mGUPyH3PCT5EE8KntDUR1qXGqeiZj/Eehz2Q1lPDwtM4YpeLWVuzS51ua0/cdHVAZ7P3fAe6UTyX3Y2564=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkXxnmBQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-450caff6336so15238535e9.3;
        Fri, 30 May 2025 23:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748674001; x=1749278801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qmGcbU9HcKIOJQ6ijcuImiKtiHIykIXxgbnKg5TgaU=;
        b=YkXxnmBQ1yNxkGvcN3YjJeGsoVn4fvs3Hmf9PfZzm4x12mahLdmVZEpDvKiEvSbH1C
         wM3UuwBwwMJE7pdZM7n12R+AlY/QNztEjXQ9IG+M8VoOSniW7g7Wu+J7YtvnkSbPQxJg
         BD+3dmjRqivqPfYbGw18792WdcGv1wzg8f2ysQMGS4yCWjH6EbI6Q+iFtMFrUQGMlMWu
         bASbwzumzRPYNlLtD2FxfiR2e/pbK04WkZnN9eK6QgRO6LL8t3L6qvkGXoDfQA3C5S7x
         HxqqlIZnk/wiY/27yuvqMJ3lMiEy94bfESLTV2kTKiWn1qPxZlWvE+/M9bdHpV80gyDk
         hqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748674001; x=1749278801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qmGcbU9HcKIOJQ6ijcuImiKtiHIykIXxgbnKg5TgaU=;
        b=UjrSr6HDkUDAseKwSl8r9LnfuD3pAdkavxXM/xwi8F3GMPDJbOu84sviWcyS6Ia/od
         ubpZFmUrpFe2R3hxTXgfyeBZ61hxr88cR7B1jy+WtfU+r3YIhHy/bRm5xwOX2MJJYOsP
         iocFOO/QQ2btV/zUTeKzmA/6V1AZxfWJh6mF71bRDn9INgQZNUOy7EFaAsFLT7M/HDrT
         iamytwC+FoozGxnwTot4RC+e2MWcPm8Qcpq3fnxmkBrr/ycA8LZFpwhRKzDLz2zNm19p
         Sg9Zu6TRFguAW3kusT4VBBAJc0ijox0vn3KNL/PiBQPLPMyd2rA1v9cve1zDK/ziRrVg
         SmcA==
X-Forwarded-Encrypted: i=1; AJvYcCX5HOu4/3w6DRCSkD5WdUTu7P27k05sz6WtqhJtvj3W04NNTAd7XAMSi975jC3A+3ttfuqGycyw@vger.kernel.org, AJvYcCXQbo2OfdPaBJBJdJQzUAjM1c5bdd57Zf0dIA6Z8vHGo9q6jxzAiCTEchnBv+LhpXPFn7zPC4lQQCq2qZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh4Qw6oLJ8v8AQjWoLt+eoDjx6ntIBZpTuYRY8hh4BvVKnCeiU
	4LqG/nNRJDnFC82jOyddh5VTZFCdg9wwnd6BWeZNrl61kLqdvt2eb+1Y
X-Gm-Gg: ASbGncsCcvtTKzBGxpUcbyLGmc5x0u8wYd+/z8yCpKLRK20moBt27PY57tb6USYprVK
	ybUVa/IyAM8nzIKxpMPVBPVroarBWlYPETaPgqaz/opiLS6/MqG2quRUedBFfJc7ykdDr0zxGFO
	KuTgnTbCm2Q1ZV+ooVbdY9kJXoevscwINt3vCVGtwWAqYAQtGbvandzQ6plttjB3xiySFEzG90S
	NrWo+EChXvTxPwlxPSjFePOqkzl1yQA3j1uwhK9stFgCepZA99oyk75mNfQGt0AuslRpphHF73y
	zRQn3Iy6zaurPAGs+EwPPS5jeiTbebq/gvesjGUAAuarL0Jg+81PaxgsVbl50KDULUS+vcvx5LF
	A7GOfLrjpf9RcJo+EbgPMtO5/JoONkn3iOvIkmq93j/EpZDq4G/7z
X-Google-Smtp-Source: AGHT+IGm2RIO894xIrZL1ImnI/rl19zaqbhBC9Z1CCUaJW1vgrDUw+yK0HxwjEq5Tu7chXhyqfLGeQ==
X-Received: by 2002:a05:600c:198e:b0:440:6a79:6df0 with SMTP id 5b1f17b1804b1-450d8874cb4mr35938815e9.22.1748674000874;
        Fri, 30 May 2025 23:46:40 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1200-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1200::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000e9asm38324765e9.21.2025.05.30.23.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 23:46:40 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [RFC PATCH 1/3] net: dsa: tag_brcm: legacy: reorganize functions
Date: Sat, 31 May 2025 08:46:33 +0200
Message-Id: <20250531064635.119740-2-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250531064635.119740-1-noltari@gmail.com>
References: <20250531064635.119740-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move brcm_leg_tag_rcv() definition to top.
This function is going to be shared between two different tags.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 net/dsa/tag_brcm.c | 64 +++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
index fe75821623a4..9f4b0bcd95cd 100644
--- a/net/dsa/tag_brcm.c
+++ b/net/dsa/tag_brcm.c
@@ -213,6 +213,38 @@ MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_BRCM, BRCM_NAME);
 #endif
 
 #if IS_ENABLED(CONFIG_NET_DSA_TAG_BRCM_LEGACY)
+static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
+					struct net_device *dev)
+{
+	int len = BRCM_LEG_TAG_LEN;
+	int source_port;
+	u8 *brcm_tag;
+
+	if (unlikely(!pskb_may_pull(skb, BRCM_LEG_TAG_LEN + VLAN_HLEN)))
+		return NULL;
+
+	brcm_tag = dsa_etype_header_pos_rx(skb);
+
+	source_port = brcm_tag[5] & BRCM_LEG_PORT_ID;
+
+	skb->dev = dsa_conduit_find_user(dev, 0, source_port);
+	if (!skb->dev)
+		return NULL;
+
+	/* VLAN tag is added by BCM63xx internal switch */
+	if (netdev_uses_dsa(skb->dev))
+		len += VLAN_HLEN;
+
+	/* Remove Broadcom tag and update checksum */
+	skb_pull_rcsum(skb, len);
+
+	dsa_default_offload_fwd_mark(skb);
+
+	dsa_strip_etype_header(skb, len);
+
+	return skb;
+}
+
 static struct sk_buff *brcm_leg_tag_xmit(struct sk_buff *skb,
 					 struct net_device *dev)
 {
@@ -250,38 +282,6 @@ static struct sk_buff *brcm_leg_tag_xmit(struct sk_buff *skb,
 	return skb;
 }
 
-static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
-					struct net_device *dev)
-{
-	int len = BRCM_LEG_TAG_LEN;
-	int source_port;
-	u8 *brcm_tag;
-
-	if (unlikely(!pskb_may_pull(skb, BRCM_LEG_TAG_LEN + VLAN_HLEN)))
-		return NULL;
-
-	brcm_tag = dsa_etype_header_pos_rx(skb);
-
-	source_port = brcm_tag[5] & BRCM_LEG_PORT_ID;
-
-	skb->dev = dsa_conduit_find_user(dev, 0, source_port);
-	if (!skb->dev)
-		return NULL;
-
-	/* VLAN tag is added by BCM63xx internal switch */
-	if (netdev_uses_dsa(skb->dev))
-		len += VLAN_HLEN;
-
-	/* Remove Broadcom tag and update checksum */
-	skb_pull_rcsum(skb, len);
-
-	dsa_default_offload_fwd_mark(skb);
-
-	dsa_strip_etype_header(skb, len);
-
-	return skb;
-}
-
 static const struct dsa_device_ops brcm_legacy_netdev_ops = {
 	.name = BRCM_LEGACY_NAME,
 	.proto = DSA_TAG_PROTO_BRCM_LEGACY,
-- 
2.39.5


