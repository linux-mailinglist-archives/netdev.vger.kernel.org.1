Return-Path: <netdev+bounces-116398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749BD94A52C
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 12:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2821A1F224A3
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 10:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2EC1D3641;
	Wed,  7 Aug 2024 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0eyPeDv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033013A267;
	Wed,  7 Aug 2024 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723025503; cv=none; b=blqTRfJV+bKZsM/hRBkbQTm7LNRT+w41KSdK6ntXE4sOpcLBqs2SV3VPw/tv5ets7Hk6fR9P+cORaTP6cZBnvhFFTGSqH2QF9AwFfxkfXn/S+vniPXzxkNe8hW32RODnAkH5iOEZxwMWCPprmuDhsjkhNYcrq+0ys5Wa651QAxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723025503; c=relaxed/simple;
	bh=veUbiv8qCal4E3RokmCcyjVyL8LTrG+dgLC5DGzo4VA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQ79RSQrjyfBtBHKabXoy+nxlnecKIJCUzdhuwNRGp4/dNuyiKdVUQw+NzZK01KhxpoTIoSXxVBLQtvr84VKORNtqBfkqDqzc6XdLklS5sb96EsfNLwmnrOr5LLzhI7nbbhHsns6q5uVyIW1nWtIqotSPqX/XscKyF+y4SxNwd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0eyPeDv; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7a18ba4143bso1136650a12.2;
        Wed, 07 Aug 2024 03:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723025501; x=1723630301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s0dwJOC2ZWNngEJesupegftfLNs6Uf6v6IZl3J0jAqg=;
        b=E0eyPeDv8YwXP8lFVe4nmgzHzRNlMub9Z4KXvL1y5feRM90YSH8PkGrDylfTyzER/V
         etlFL8Q5oxRWY4k8ZYD/9jGtft0TSgz9FG1gkqpWbXMDQo/5ZoO8Ovmw4SzCbRK0nXB6
         qn3qrS6v9aLUsqNsEBrlQbgoMZPRrmLnCIkf6f1efj+83FYDiNlMG6WqH52v4tAwHObJ
         T1jJnrK4nd1xuoPcOD+JSZRt6ghDUWwIue/wM/4iqnfDXcWBJ/PVYvpFLivJvPfF4xrb
         WjQxrE41JQcHg9kUCCJzICa4MPdEMShZgrwEZQgxVYFZuokRSHtGFIxNY9d2u6P96EPJ
         O9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723025501; x=1723630301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0dwJOC2ZWNngEJesupegftfLNs6Uf6v6IZl3J0jAqg=;
        b=D/nr/qFztdkzI0EJV9vGvudUR0mkaimthvqbA5VOIW0WpfWhMYSxgCPuYh/noVSLmB
         7b484EauiJtxAzuoL3B7PpC+3yaZK6//Pz6OR3q7BtLOCjJPh2pzkbF+enn/y3nJcyOM
         iOBnAxHt6QX1WItc/2CKszg7zA+FsHAV0NQ3sjO+XeiMDcNSAI8I87IA5MFz3yIOSHZ8
         oXaR2xcOpf+GWxwW6HP6LsLZTL7cOwgTfVqc7HPygUtkAaJ/Aq4bUeprzjIfgYErHl/F
         RldaDGN27SF32h+L51NRxA/Hfki4IbKAvtOh96wy/bpKTAKS/9pvQmINYG4basX8d5It
         VgfA==
X-Forwarded-Encrypted: i=1; AJvYcCWjc4lfjsiu24VI5n4ov9AeXWbfzjAe039fp5AMgCthOpOOc1knCUyWypbPF6F5Pbbzo4Qb6N0N3JsbSdCd+8clTli60+AkxkANpKaJ
X-Gm-Message-State: AOJu0Yw9Rq0gK/kOEMSXivLOOWnbF1ZWGfyRvVcE5LUQWKkvu0rREfSY
	R7Uke41dAcL/i5cXtUYhKjPZfnfvYFrgJiOw7773R0mwRWNZrM3FnMWXm4rJQBE=
X-Google-Smtp-Source: AGHT+IEGUFhUEV3Rj5VIDIAC+w7BtmGng4ZDZ+GC+6FOtAVZQXJdnt7pCzK280DlwW6gCAZDp8cXKQ==
X-Received: by 2002:a17:90a:8a12:b0:2c9:e24d:bbaa with SMTP id 98e67ed59e1d1-2cff9526da4mr18320765a91.27.1723025501174;
        Wed, 07 Aug 2024 03:11:41 -0700 (PDT)
Received: from localhost.localdomain ([218.150.196.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3b34c1bsm1141175a91.39.2024.08.07.03.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 03:11:40 -0700 (PDT)
From: Moon Yeounsu <yyyynoom@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Moon Yeounsu <yyyynoom@gmail.com>
Subject: [PATCH v3] net: ethernet: use ip_hdrlen() instead of bit shift
Date: Wed,  7 Aug 2024 19:07:21 +0900
Message-ID: <20240807100721.101498-1-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`ip_hdr(skb)->ihl << 2` is the same as `ip_hdrlen(skb)`
Therefore, we should use a well-defined function not a bit shift
to find the header length.

It also compresses two lines to a single line.

Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
---
v1: use ip_hdrlen() instead of bit shift
Reference: https://lore.kernel.org/all/20240802054421.5428-1-yyyynoom@gmail.com/

v2: remove unnecessary parentheses
- Remove extra () [Christophe Jaillet, Simon Horman]
- Break long lines [Simon Horman]
Reference: https://lore.kernel.org/all/20240803022949.28229-1-yyyynoom@gmail.com/

v3: create a standalone patch
- Start with a new thread
- Include the change logs,
- Create a standalone patch [Christophe Jaillet]

 drivers/net/ethernet/jme.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index b06e24562973..d8be0e4dcb07 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -946,15 +946,13 @@ jme_udpsum(struct sk_buff *skb)
 	if (skb->protocol != htons(ETH_P_IP))
 		return csum;
 	skb_set_network_header(skb, ETH_HLEN);
-	if ((ip_hdr(skb)->protocol != IPPROTO_UDP) ||
-	    (skb->len < (ETH_HLEN +
-			(ip_hdr(skb)->ihl << 2) +
-			sizeof(struct udphdr)))) {
+
+	if (ip_hdr(skb)->protocol != IPPROTO_UDP ||
+	    skb->len < (ETH_HLEN + ip_hdrlen(skb) + sizeof(struct udphdr))) {
 		skb_reset_network_header(skb);
 		return csum;
 	}
-	skb_set_transport_header(skb,
-			ETH_HLEN + (ip_hdr(skb)->ihl << 2));
+	skb_set_transport_header(skb, ETH_HLEN + ip_hdrlen(skb));
 	csum = udp_hdr(skb)->check;
 	skb_reset_transport_header(skb);
 	skb_reset_network_header(skb);
-- 
2.45.2


