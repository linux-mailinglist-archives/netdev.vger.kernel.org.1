Return-Path: <netdev+bounces-129804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A40D09864B5
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 18:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0C57B22C4F
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 16:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12236F30E;
	Wed, 25 Sep 2024 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="f1iH8eqz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C00A4CDEC
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281264; cv=none; b=UR1l9hPLwu5zhkNQ0lZnoYIuGBl7EuBH+N1f31y6jEM/0XhunQXVZps0ibaVA25HEZbKHpKEAKC9bGkV3HB+TNAmUF1/7ujiv3ojzthaumjfELnpM1e34+lAZ0w6EUfTPvnBaiXto7AYvi8jVpZt2q9dYtmrFrBpGjtp1jI9GVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281264; c=relaxed/simple;
	bh=dKt1w+hORDTSGCSREIgcSOY/polV8gNEtej77pHHn2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sn3bXcr64q/EIdWxO6ylB628dDneXdhWUjbBISCYd2Z6V6SIh8Mu8PTogSfHEcvMAjk//5gXVpiHvwtLHhX9fgZ7ZfvsJHLldmgQcv8G2sJ0jL6Cts9M63X1ihrF+JeoP2CdaCSgla/cmWZYUlkbh9Ql/5BPOkOgqwiHicfXAQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=f1iH8eqz; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a1a4870713so52575ab.0
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 09:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727281262; x=1727886062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds+S/MZetPsKWvU7c9jTLdR0Y2FRO8ABAdvsJaaWkZs=;
        b=f1iH8eqz8uwKPz/wo7iN42SiE9QiMFRwos6IQL3zvPqDWEUKQ+IjrTCCUH/g1WyStQ
         USdpmwzvOoy6U6jvsOgvxTTofOpLqva6ndpi5YN/C65VPpOr2cUoYkYBTMtyYeQgDP7F
         zTq7eV1W52mtPHbgFYePJ6Q4oYpSaXDYUW/ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727281262; x=1727886062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ds+S/MZetPsKWvU7c9jTLdR0Y2FRO8ABAdvsJaaWkZs=;
        b=NXjj1yKeAlqG8DyPsTBT30dhQtI2D4UuAfWJUfW/+vZxu5Z8hk7piw0w0xt6n5fHnr
         b8Al13wJCSXGYfNIhXtbxG94/sojqZL1QyH3b42laHE8NHmOw/avWDNXiNtceJe5W5yo
         vFsnA4r8s17ogFSWqZFKjW8lWTl0uOpwMRDECqbKdB5H9rE2GtCenmtrVO36A47EGYgT
         X4Ti8ZkjeHrqe6SsWbH7fy22UIvRS+O2HoRIYJwlOnmvBi+kOanGfFRjx9rIej5tBKan
         OOD7cFXutadXq2MgsHaKJV9+nANXF9uCKihhoa8X/OiGnGptIVi/YVVBPMJe3Vn4nz3D
         P3Lw==
X-Gm-Message-State: AOJu0Yx5HpsGbeeuArmhWq2MQyq0nHXAg+9VJwz9BjfxuSOi3vhoLUpC
	Hd3LUH5RbrJ4lKWELAiln0SvGaw8lMmS+tJ+38ATKOgklQi1paPECOC+mYOmn1AkP73IsZVELuO
	gN7o+v2XJL67AjqMDn1L5rbFV36eWZnIdXcRRD/j8oOIbr7Ehw3abMXJLyej3K12AMwV8ogTMm9
	EsJiHUaRC1ecVZGmbJJaIGwbCTgNVvlr+gmE4=
X-Google-Smtp-Source: AGHT+IFaxcC34k7ddgcU2fJhDTtJSAWSQ1OP73ZVmq50xBFAa2+XpiHScPN2QaIUpK0YEokOuADvrA==
X-Received: by 2002:a05:6e02:188c:b0:3a0:8d2f:2914 with SMTP id e9e14a558f8ab-3a26d7f0e76mr36241535ab.23.1727281261959;
        Wed, 25 Sep 2024 09:21:01 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c73341sm2948433a12.72.2024.09.25.09.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 09:21:01 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v2 2/2] tg3: Link queues to NAPIs
Date: Wed, 25 Sep 2024 16:20:48 +0000
Message-Id: <20240925162048.16208-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240925162048.16208-1-jdamato@fastly.com>
References: <20240925162048.16208-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link queues to NAPIs using the netdev-genl API so this information is
queryable.

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump queue-get --json='{"ifindex": 2}'

[{'id': 0, 'ifindex': 2, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 146, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 147, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 148, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 145, 'type': 'tx'}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index ddf0bb65c929..f78d7e8c40b2 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7395,18 +7395,34 @@ static int tg3_poll(struct napi_struct *napi, int budget)
 
 static void tg3_napi_disable(struct tg3 *tp)
 {
+	struct tg3_napi *tnapi;
 	int i;
 
-	for (i = tp->irq_cnt - 1; i >= 0; i--)
-		napi_disable(&tp->napi[i].napi);
+	ASSERT_RTNL();
+	for (i = tp->irq_cnt - 1; i >= 0; i--) {
+		tnapi = &tp->napi[i];
+		if (tnapi->tx_buffers)
+			netif_queue_set_napi(tp->dev, i, NETDEV_QUEUE_TYPE_TX, NULL);
+		else if (tnapi->rx_rcb)
+			netif_queue_set_napi(tp->dev, i, NETDEV_QUEUE_TYPE_RX, NULL);
+		napi_disable(&tnapi->napi);
+	}
 }
 
 static void tg3_napi_enable(struct tg3 *tp)
 {
+	struct tg3_napi *tnapi;
 	int i;
 
-	for (i = 0; i < tp->irq_cnt; i++)
-		napi_enable(&tp->napi[i].napi);
+	ASSERT_RTNL();
+	for (i = 0; i < tp->irq_cnt; i++) {
+		tnapi = &tp->napi[i];
+		napi_enable(&tnapi->napi);
+		if (tnapi->tx_buffers)
+			netif_queue_set_napi(tp->dev, i, NETDEV_QUEUE_TYPE_TX, &tnapi->napi);
+		else if (tnapi->rx_rcb)
+			netif_queue_set_napi(tp->dev, i, NETDEV_QUEUE_TYPE_RX, &tnapi->napi);
+	}
 }
 
 static void tg3_napi_init(struct tg3 *tp)
-- 
2.25.1


