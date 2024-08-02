Return-Path: <netdev+bounces-115224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065249457C0
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 07:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B032C1F24FBF
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 05:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C54A3D97A;
	Fri,  2 Aug 2024 05:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pnc92zuq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061672D047;
	Fri,  2 Aug 2024 05:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722577564; cv=none; b=cLSrAJuX1VLvrcDdKHYaOWv2T3PIVAT+Pxdl6lsOZfWQdQ0T6vm6u2NwYIHfVkD1SgbxPtGFyEcNQ7kqesIfBslknp8HBjO4D/dSlUYIkJW780w0DBlmj7jjL/zD3EZoEFEMbALoqb14a2LbnytuN6TAUqqNIFXGDQFNfdjvtXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722577564; c=relaxed/simple;
	bh=XQhjo188Vyx5MKMr+apYuqo6be4mNnMoNB6pZjn6VPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=omKC1KaQ6xZ77gawcLEOP9MKG5KLy6Bb2hltIXO8KpYYWm7NFrOBujB5DHM8kH8V4UDpCrRc5hbr/cSFdSANAyJIxA+o8H/rE7M4hhHt1LX5wRzOEhNPC2piHMQyAybB9EbKr45iC/mX4B5kKpwMb3xsQbmaifNGaiQukbgnIQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pnc92zuq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc569440e1so69645625ad.3;
        Thu, 01 Aug 2024 22:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722577562; x=1723182362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5bG1c+VFaEOvvUxyv+bCQnVb/VVzVXFx36kqHv00YTA=;
        b=Pnc92zuq47zsFHw5Y2VYsfpDMVvgoY0fYx5itSp3Y3rdc2n8ujdNpAbxQL9BKn2zeo
         aLiQHWeECexIVgPs3ShRu69kefM5jjquWsxpSEpgHUF8snnJMjy19o+A7a+CUBvAS7Ci
         ekTZcy0wTZWxo8fbp21sUfCQF1tdhkZHjXq7t2uzmHlsCkNYL4wQZCWQ6DRUJPZq1Vft
         b1wtp4M8QP4ZabCLiFErwI+dnhbld8rBAcmpBBopnhUsE05VzC0LIiD2mOF88XkGnIvZ
         fmH7NMlTN9yjR7YdYpuyYEELb4hZWNoOo6f1UIpmuqLXJEsp0W2j8mpe/pKZg/R4hZUB
         Cd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722577562; x=1723182362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5bG1c+VFaEOvvUxyv+bCQnVb/VVzVXFx36kqHv00YTA=;
        b=tPWZ+kpF2VX95TwtPfcG/tpvQ8VI+an2eBMhqHuEcA6HDC739GD9WS1pziqriI0B77
         yqSQPfDt+fhdaUvvDoICsjd//2HIJ50kkIz3nHpZCOo1mlTp+pYwc/lPQALbwtUjYCjO
         wK5wfu+i+rz30sle/UK+ySBdO5xEoEPTyc6ps2cIwWf0l9JO2xK5WZPpOsvuPSMIvln5
         k2b4uF18/nAKzqwZhOY4NgLf7WdfqR8rOlDL3OrrZfkHTE+g8cSqqsH4E/c9NmMdsFM3
         wp7axVk9e1t2JamCt9sV5cFRsYm6MGY+xEsflyt4QO2f/NheJpUqqASNwdqfmc8gWsC+
         mPzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwiCMBl0a9uuV6q1DXd4PVOgAuuCoCNvqdf+mgMrKBn4Fqqg1Iwm0jHVIoqpfu+LEgWWXG5M+0J0RdTd6uhn5ym2vUPkmNJ+VnSE6j
X-Gm-Message-State: AOJu0Yy5oXRltc/178X4q4DBQEEk6i6O5Yrzg8JquPcaROa+KyU+f6s+
	o1IvFJ4h85WSB9wln/Cw9twfzeiIh2eo7UzIkbHr68q8S3Wq5X1z
X-Google-Smtp-Source: AGHT+IGba0YUoAJZO/cZtgwZ2axTAToxS/thDxJxHx4Sn++qh2s6M9BRnED/uwun4wL27cljzgIf0Q==
X-Received: by 2002:a17:903:2445:b0:1fd:91b1:7897 with SMTP id d9443c01a7336-1ff574a7ac9mr34361965ad.65.1722577562253;
        Thu, 01 Aug 2024 22:46:02 -0700 (PDT)
Received: from localhost.localdomain ([218.150.196.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59176cbcsm8462535ad.205.2024.08.01.22.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 22:46:01 -0700 (PDT)
From: Moon Yeounsu <yyyynoom@gmail.com>
To: cooldavid@cooldavid.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Moon Yeounsu <yyyynoom@gmail.com>
Subject: [PATCH] net: ethernet: use ip_hdrlen() instead of bit shift
Date: Fri,  2 Aug 2024 14:44:21 +0900
Message-ID: <20240802054421.5428-1-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`ip_hdr(skb)->ihl << 2` are the same as `ip_hdrlen(skb)`
Therefore, we should use a well-defined function not a bit shift
to find the header length.

It also compress two lines at a single line.

Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
---
 drivers/net/ethernet/jme.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index b06e24562973..83b185c995df 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -946,15 +946,13 @@ jme_udpsum(struct sk_buff *skb)
 	if (skb->protocol != htons(ETH_P_IP))
 		return csum;
 	skb_set_network_header(skb, ETH_HLEN);
+
 	if ((ip_hdr(skb)->protocol != IPPROTO_UDP) ||
-	    (skb->len < (ETH_HLEN +
-			(ip_hdr(skb)->ihl << 2) +
-			sizeof(struct udphdr)))) {
+	    (skb->len < (ETH_HLEN + (ip_hdrlen(skb)) + sizeof(struct udphdr)))) {
 		skb_reset_network_header(skb);
 		return csum;
 	}
-	skb_set_transport_header(skb,
-			ETH_HLEN + (ip_hdr(skb)->ihl << 2));
+	skb_set_transport_header(skb, ETH_HLEN + (ip_hdrlen(skb)));
 	csum = udp_hdr(skb)->check;
 	skb_reset_transport_header(skb);
 	skb_reset_network_header(skb);
-- 
2.45.2


