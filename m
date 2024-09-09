Return-Path: <netdev+bounces-126540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C880A971C04
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 16:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DAB1F238CA
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 14:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA501BA869;
	Mon,  9 Sep 2024 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZECbhG/N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E4417837E;
	Mon,  9 Sep 2024 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890426; cv=none; b=dCKNGc9YV0lYvDav1W9XdkTxoR9omlc+tbTTwpAORL5qo2nWJL5gzqek7al0nX0KB7W6ZkRy7zBJKMpDD4CqFBn+ssoctPJaDvzEO5fViwM+sYaBTfNkeGKQkqDuH0khWvh3TPmS9c35aglWs7wejbJyBDaX1YJMDd7RAFmzGTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890426; c=relaxed/simple;
	bh=gNnTh3LDR404ka1WYkhWiCpwzdp+4c52j69G32URQw8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sdPYP5rkuoz3ixVPqSopc25ELIZsKfv4IInJeQZbM3DJWO2FKoxLLHgVJoDs441CrRLT1ijOeRuhZx3N7ZKoof9XLbP72A2KfxbDh4fU7F37dCBf+ZtYrq/OAy+sqTWIX1RRy89s0b7MQ2cj+c1dn63apPVwvM+M3u1l3LxCyWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZECbhG/N; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so20379065e9.0;
        Mon, 09 Sep 2024 07:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725890423; x=1726495223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oUU8OesX2mRNuKc6ApWuC7lB5t5F5qw1rMRsMoepUzI=;
        b=ZECbhG/NwGbY4zL9QlvwqeiEEdAUlWrajvvkp2YePsl7lbeGHeJKqEk+UX3KwSlVW5
         1MqPGEdurh4ypDJMeGI5xDK2GL7HW2VGhWN2sBn2jEOt4pb4qNzYkFlv4sFTNhyfKF2L
         0frW9jK153Vf6+vl8Vb1Kz7hmZkeAO65PiPWnX6XBgexixbSColOI8wwXM0zNYAP0IrO
         u1KW704TebLIzQENVF27tuW4m/Va632Mq/uu4MuusLpMsozIVlrA56M+rS5dzt3a32vB
         Q7uIaPkRSCIpAoi5Uew7FL6RFjGEvk40IIzCR0ZqiH/5ymSKnEvHHEDg9xj2ANhVNNiS
         TiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725890423; x=1726495223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUU8OesX2mRNuKc6ApWuC7lB5t5F5qw1rMRsMoepUzI=;
        b=INNs4gInZvHFmoLuoRWUSYJzLBM3KrzuApw8I2t8+ZC2dKWBcoBpQbIZr9CEZ+pAAc
         nf3cfGeZQpiLYg89cyyllyzwsV58LvefiSxic3UfB5VaXqCzga8cwU2I63SZ3ssGB0oc
         NfbYNFofhtejXRQPivF8skJ9lzctQKU1NJ2tTzX/tyNeKpIixK0E9uz5R7CjMUxff746
         sQEVMeu8XPJm9HeucFxSboxtzfaLzFY/q3Mp5mIxnR3PzfvXumUKBvIziFy8ZbEC196I
         KpcbmmZVQPK3P7o0h1mFN1LM+PNu/7KZtv2Kb2+zeaFBEc5Fin2XkdIj6tX7w7/8Z1Jr
         uZmg==
X-Forwarded-Encrypted: i=1; AJvYcCV9kUAdHfeho70aG2YfWNBGYcqo2YBnsZSRUGeaT0KO/TX3hB0y4M/wjxmYudyYBUhMQ3MTyVccr4VueMM=@vger.kernel.org, AJvYcCXx++BPQPNc/s6y4+2j73WnimsREBVBbpuM0LIyErbHj7EMoDxuPacYa78MtngqQGhkjujCellh@vger.kernel.org
X-Gm-Message-State: AOJu0YzNzn5QJsezbsWoCsY8xU7z7mg69k4td5S+FiEhYszpdeTHWGds
	GPg9dpNnZI30zWTrCRVdMPlG1tzrzm06f7Su7YztbBUgD9y2yfS1
X-Google-Smtp-Source: AGHT+IEbnLVlRBkcSRuNlfSSwfwARQeoDY1+UfMGncemGENczAtqCu1y2uoRqpDMrd8K+NOj4+HXkg==
X-Received: by 2002:a05:600c:54e7:b0:42c:acb0:ddb6 with SMTP id 5b1f17b1804b1-42cacb0e00bmr60323505e9.9.1725890422761;
        Mon, 09 Sep 2024 07:00:22 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cadda5a07sm81807995e9.0.2024.09.09.07.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 07:00:22 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] r8169: Fix spelling mistake: "tx_underun" -> "tx_underrun"
Date: Mon,  9 Sep 2024 15:00:21 +0100
Message-Id: <20240909140021.64884-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in the struct field tx_underun, rename
it to tx_underrun.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 3cb1c4f5c91a..45ac8befba29 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -578,7 +578,7 @@ struct rtl8169_counters {
 	__le64	rx_broadcast;
 	__le32	rx_multicast;
 	__le16	tx_aborted;
-	__le16	tx_underun;
+	__le16	tx_underrun;
 };
 
 struct rtl8169_tc_offsets {
@@ -1843,7 +1843,7 @@ static void rtl8169_get_ethtool_stats(struct net_device *dev,
 	data[9] = le64_to_cpu(counters->rx_broadcast);
 	data[10] = le32_to_cpu(counters->rx_multicast);
 	data[11] = le16_to_cpu(counters->tx_aborted);
-	data[12] = le16_to_cpu(counters->tx_underun);
+	data[12] = le16_to_cpu(counters->tx_underrun);
 }
 
 static void rtl8169_get_strings(struct net_device *dev, u32 stringset, u8 *data)
-- 
2.39.2


