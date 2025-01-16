Return-Path: <netdev+bounces-158956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2238A13F83
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26DA71619AE
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41881DE884;
	Thu, 16 Jan 2025 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFljLtnv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250F48632B;
	Thu, 16 Jan 2025 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737045099; cv=none; b=d/xxXGor+fKsI0weNJBIwQWtxcsW8i+vavBzJTZx+8v3UzOYpKEzmhrFrXCLx+csw+DmlKGPKfWbH6mG7NcqOJ54QEztt5Zpq4xKLw3oQN/JAuUGE4//XH0+UAq186WhXPkDBMkbGm2d0hYzhyBolBXEEki3klaY8hE7tWYrtfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737045099; c=relaxed/simple;
	bh=c/pB9MvUB5Rcm/tw9gT1SXD7fMVGER9S8EYn1QfX+kM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iEH4aWxqDPw1y958aKEH16lyr14MDqRDQdfp+2lLobce4Lg7vmYlW9/scoEFOZOub4I1L1a6oPdMHV3QnO8IWsWkIyls6gc83osv/8CmcJkY7j0FVzhCIeFGMLHjlLDB/JMtTkcJuMUS9Muq3SwGRg3cWXGZmgTAi8kMFgdBm9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFljLtnv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21628b3fe7dso21570615ad.3;
        Thu, 16 Jan 2025 08:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737045097; x=1737649897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ARDjCcRGT03WV/jJzISRYsEH/PAIJYg2xIBjnV8W+gg=;
        b=dFljLtnvjHyckCYYo9LWtg6hGpZ2mFBLbK979gyAd77+LfW18nv+KzPJUTNA6aZwRX
         UZvHOo6Fg8OasHH5z6YiVp0DjvyaFMjszuP5fj5BQGdYO9D8VG76pAhDBE4u0aJECNUn
         ITiA26lBOGV6kQ+1x7oOLbyUHti0pBNADEyH+x6pGYZOWhAp896/Dn2u9+40lemNL65b
         G/SrbB+Mb15bAihJBuUpEmqM9smcvDSQom7y7i2ZR7btm+oT5UTju1lS/sAv5Jj6E+T7
         PqP5l0KYJ/CVa/6u/DJFP6HMwyHx6yb+zMpXeO0PrSWyDz7DunwFNorzum13t242TcAV
         bAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737045097; x=1737649897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ARDjCcRGT03WV/jJzISRYsEH/PAIJYg2xIBjnV8W+gg=;
        b=QGpDkdR3qSfosoxwgyF0yjqsVSm6BpY0G7QZ905muaOs1EIa6gmcAflD8BqxggSjFr
         tPoFWwEPr0/Gie31/tiHsdIfhYHzOKU2ryKgBQVOfBKxMNoXXFYzrTIQpbYDPNhAV6ne
         38C4Tja1f7lv5BR0VKVHs6oWy1rBetq0Bfd4J4KPaPc271lqURAuR7E2+rCsOiQzdDqk
         PSegCn3lpAZHs5xkgd596+8i1gPGkbELk2qilqP6yG05eejjJNKsjZ2KHX01R2IekXdV
         Sbf/ACnFZK6JKGYuLdLal7T/9FwCrRUX+tvVegyO9HGpVbd5YE2In/h+BI8gsbpRx3yY
         n/9w==
X-Forwarded-Encrypted: i=1; AJvYcCUHJuEHLjWx5qcZT47COAkV1EoODqLSiwNmZ2+ZCUTj9lsEz2UQlKKJOGMO9OEt8dT6AqMpnmDj@vger.kernel.org, AJvYcCUolDfbXzFtuQoAIMH7byIf2BRoLJTupdkZ4VgJ7uN/UFhGeEnkrk+xAJJ59AwGx7Y5OmUpwNdF/1dxXEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyDsMlMdGHAKkBo/DcLqYZajoIHX74L4J+5gS2w9/IVjL8iHXD
	R5CR6y7R6caC5pP7oFvIWpsqD9VE5zNMIM/oDrAqu/94hUy6PWVs
X-Gm-Gg: ASbGnctWFS6gt1ZpUEF6vyK8ofOKqMuesEVWajsw8cV7PwPuS2ZCs2RduJ7OBBmqOMr
	KSaOW9hVhMCzwxzx8zMCO0EDE3zkargYu5ggSUUQzCgZNunVs5RuL5T0NjgIckiiLjAjDdAxT+r
	2F5BxO9p79y8EVJj2tfadvlJ7KcKsZwwMXHN9GPSxK1koP83p+iu/cUvkS3ycqBpl2WMg2jI0Po
	FNYmZ37gQ2t6r9lORYwW+UKvDQ2L+oZcB0CrzOC/LcBhNYQ/5YzuZl2eN28lloY3jzqc2KMdmDr
	WL0BSg==
X-Google-Smtp-Source: AGHT+IHstWMd+CWUx3IaPktREduKNzy4NF5JqEL4Gn7RlChbOWkHBGTUy2DrCBCQC9bznntdLIzaZQ==
X-Received: by 2002:a17:903:1cf:b0:21a:8300:b9d5 with SMTP id d9443c01a7336-21a83f4cd36mr543199275ad.23.1737045095907;
        Thu, 16 Jan 2025 08:31:35 -0800 (PST)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d406cb5sm2205315ad.246.2025.01.16.08.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 08:31:35 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: bh74.an@samsung.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net-next] net: sxgbe: change conditional statement from if to switch
Date: Fri, 17 Jan 2025 01:03:14 +0900
Message-ID: <20250116160314.23873-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the if conditional statement in sxgbe_rx_ctxt_wbstatus() to a switch
conditional statement to improve readability, and also add processing for
cases where all conditions are not satisfied.

Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 .../net/ethernet/samsung/sxgbe/sxgbe_desc.c   | 43 +++++++++++++------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_desc.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_desc.c
index b33ebf2dca47..5e69ab8a4b90 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_desc.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_desc.c
@@ -421,31 +421,48 @@ static void sxgbe_rx_ctxt_wbstatus(struct sxgbe_rx_ctxt_desc *p,
 	if (p->tstamp_dropped)
 		x->timestamp_dropped++;
 
-	/* ptp */
-	if (p->ptp_msgtype == RX_NO_PTP)
+	/* PTP Msg type */
+	switch (p->ptp_msgtype) {
+	case RX_NO_PTP:
 		x->rx_msg_type_no_ptp++;
-	else if (p->ptp_msgtype == RX_PTP_SYNC)
+		break;
+	case RX_PTP_SYNC:
 		x->rx_ptp_type_sync++;
-	else if (p->ptp_msgtype == RX_PTP_FOLLOW_UP)
+		break;
+	case RX_PTP_FOLLOW_UP:
 		x->rx_ptp_type_follow_up++;
-	else if (p->ptp_msgtype == RX_PTP_DELAY_REQ)
+		break;
+	case RX_PTP_DELAY_REQ:
 		x->rx_ptp_type_delay_req++;
-	else if (p->ptp_msgtype == RX_PTP_DELAY_RESP)
+		break;
+	case RX_PTP_DELAY_RESP:
 		x->rx_ptp_type_delay_resp++;
-	else if (p->ptp_msgtype == RX_PTP_PDELAY_REQ)
+		break;
+	case RX_PTP_PDELAY_REQ:
 		x->rx_ptp_type_pdelay_req++;
-	else if (p->ptp_msgtype == RX_PTP_PDELAY_RESP)
+		break;
+	case RX_PTP_PDELAY_RESP:
 		x->rx_ptp_type_pdelay_resp++;
-	else if (p->ptp_msgtype == RX_PTP_PDELAY_FOLLOW_UP)
+		break;
+	case RX_PTP_PDELAY_FOLLOW_UP:
 		x->rx_ptp_type_pdelay_follow_up++;
-	else if (p->ptp_msgtype == RX_PTP_ANNOUNCE)
+		break;
+	case RX_PTP_ANNOUNCE:
 		x->rx_ptp_announce++;
-	else if (p->ptp_msgtype == RX_PTP_MGMT)
+		break;
+	case RX_PTP_MGMT:
 		x->rx_ptp_mgmt++;
-	else if (p->ptp_msgtype == RX_PTP_SIGNAL)
+		break;
+	case RX_PTP_SIGNAL:
 		x->rx_ptp_signal++;
-	else if (p->ptp_msgtype == RX_PTP_RESV_MSG)
+		break;
+	case RX_PTP_RESV_MSG:
 		x->rx_ptp_resv_msg_type++;
+		break;
+	default:
+		pr_err("Invalid PTP Message type\n");
+		break;
+	}
 }
 
 /* Get rx timestamp status */
--

