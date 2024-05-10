Return-Path: <netdev+bounces-95450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A808C24C3
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D16A1F25883
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564B512FF9F;
	Fri, 10 May 2024 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIUxkZBI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C3B15491
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343917; cv=none; b=mAq8edRoZyHWPQBXsWnsEY5m93wdl9O3RE4NQkjSbyOISfVAaP5P520qhmI3kXxQ/F7mQTpZjt8xRBtWZdnU5VWKqpscVDl/BTSjl4vg9IxQv9TDW3uuMZmLcAIv7/Okc3o9zJqmIVRVgZj1Fq3NNV8z94GD1jYKU0RoEvB2HbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343917; c=relaxed/simple;
	bh=eFIuyMNsLA6X4/v7gxs8rGdBPEoWfAe1S56NltpROuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KBfq7WBxkfMJvTpNIBVbPckb0rn68pGPfE9K/LtjuH2Fy/18KPlbL1JFLod2Tl6xWtV7UVZWAV2mDRrHuq+KNG1xReO8coXW84E5OFoDfrkjB6R8zX43r+9ZzFYxv8ZRut/uoa3A8wcZMyM2ps/WUHkyK6NadxGhd/iRJyis1+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIUxkZBI; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36c7ee71ebaso8410955ab.2
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 05:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715343915; x=1715948715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyB/KgVUIo82Ok1tiI/arZVWzblSnbVI0Sc+QvPXRmE=;
        b=gIUxkZBI7Ws8y8BFrhh/sYXidd3PPIf9XhVYCphApxivo+CNWfKLFqyBwruMd4m860
         68a8kLCh8pFbrI/mckJBa94NGdOxNcS9VTfnHfmCPY4GUoyBl3pBCNRT96nrkMT2AVtn
         JAMBUqpe8iXe7AMWRNP73dOj1xlX9Y9U+qAR/gUoisdcFSz0prDuFa8oL6lj7SLakNgL
         7oSBXzOfGr6ytKfxQwA9JK8WVAR0q/4RzfjBdF8b9/OqtUmanOxWEA3yXdD/PBCmd9CV
         W4CYn2Ov+bfh+EcCxaduHR1NUM/CMKwHvSFbn40iU/0jKH8Wd4GL6uW8yPoXKoSTyYKv
         T9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715343915; x=1715948715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyB/KgVUIo82Ok1tiI/arZVWzblSnbVI0Sc+QvPXRmE=;
        b=Nq8NsQHkXrVsXiO32cT6T3X0Xgdf/Z9oOYWee2rNetBJ4xo+ANl2NDd0zJznOM+5W/
         av6V4ZABOgK7eBj8JuB0r6rqiXmk5Tj3Fbjsv8iRYJAJb+E+BvxhXs1RUHy8ZsvBMsbn
         4TjM4/FRcyWPmSMbtAr5T3Reiom61W2S4jRizaKbB0rs/2SnwX4pbBP74pSqZJqxvUpX
         p/sVcBheewZZxZbWZmdPgtF90m1YRrvdevBS7haMFZSFq2VE/5vEiHJrxEoaAMG2Cmsw
         p+Ddc5OSJ2XYiMe4qPzfF2/TWdTY256aKoMrLZ5RFr6sOZ6yMApHB5j8EX5eD4A//QD7
         aTXA==
X-Gm-Message-State: AOJu0YzqCWZyzMscb6k1HjDZmgVpJzfJlwuwnkew3yz2pPVMUzrq/Nzj
	dtd32Ce/RAU1By1xBg8TsSSQosdHM/vR4BSG8qnetRgDwtA74EF4
X-Google-Smtp-Source: AGHT+IGoqVWTpDjcFGBWrJ2aj4db58ldT/33H8t3QUVLkLBNZYH4K+Jhiamtaa5eelZpHw6ZosP4/A==
X-Received: by 2002:a05:6e02:1a0a:b0:36c:5143:73d6 with SMTP id e9e14a558f8ab-36cc14aa150mr29798275ab.16.1715343914823;
        Fri, 10 May 2024 05:25:14 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340b57f362sm2943530a12.30.2024.05.10.05.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:25:14 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 2/5] tcp: rstreason: fully support in tcp_ack()
Date: Fri, 10 May 2024 20:24:59 +0800
Message-Id: <20240510122502.27850-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240510122502.27850-1-kerneljasonxing@gmail.com>
References: <20240510122502.27850-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Based on the existing skb drop reason, updating the rstreason map can
help us finish the rstreason job in this function.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/rstreason.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/net/rstreason.h b/include/net/rstreason.h
index f87814a60205..69404c14f45d 100644
--- a/include/net/rstreason.h
+++ b/include/net/rstreason.h
@@ -10,6 +10,8 @@
 	FN(NO_SOCKET)			\
 	FN(TCP_INVALID_ACK_SEQUENCE)	\
 	FN(TCP_RFC7323_PAWS)		\
+	FN(TCP_TOO_OLD_ACK)		\
+	FN(TCP_ACK_UNSENT_DATA)		\
 	FN(MPTCP_RST_EUNSPEC)		\
 	FN(MPTCP_RST_EMPTCP)		\
 	FN(MPTCP_RST_ERESOURCE)		\
@@ -50,6 +52,13 @@ enum sk_rst_reason {
 	 * LINUX_MIB_PAWSESTABREJECTED, LINUX_MIB_PAWSACTIVEREJECTED
 	 */
 	SK_RST_REASON_TCP_RFC7323_PAWS,
+	/** @SK_RST_REASON_TCP_TOO_OLD_ACK: TCP ACK is too old */
+	SK_RST_REASON_TCP_TOO_OLD_ACK,
+	/**
+	 * @SK_RST_REASON_TCP_ACK_UNSENT_DATA: TCP ACK for data we haven't
+	 * sent yet
+	 */
+	SK_RST_REASON_TCP_ACK_UNSENT_DATA,
 
 	/* Copy from include/uapi/linux/mptcp.h.
 	 * These reset fields will not be changed since they adhere to
@@ -130,6 +139,10 @@ sk_rst_convert_drop_reason(enum skb_drop_reason reason)
 		return SK_RST_REASON_TCP_INVALID_ACK_SEQUENCE;
 	case SKB_DROP_REASON_TCP_RFC7323_PAWS:
 		return SK_RST_REASON_TCP_RFC7323_PAWS;
+	case SKB_DROP_REASON_TCP_TOO_OLD_ACK:
+		return SK_RST_REASON_TCP_TOO_OLD_ACK;
+	case SKB_DROP_REASON_TCP_ACK_UNSENT_DATA:
+		return SK_RST_REASON_TCP_ACK_UNSENT_DATA;
 	default:
 		/* If we don't have our own corresponding reason */
 		return SK_RST_REASON_NOT_SPECIFIED;
-- 
2.37.3


