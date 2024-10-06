Return-Path: <netdev+bounces-132470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B025991CCB
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 08:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12C21F21EB1
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 06:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C7616F0CA;
	Sun,  6 Oct 2024 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ahd5gSLj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCF5249F9;
	Sun,  6 Oct 2024 06:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728197813; cv=none; b=m8Af9weNRho9ZL7Q6vEQMXI2Zh3BFI1h12mnGFcbswDATidux51Ix9I9tUtC6ewdv7B5+E2GNekxjp2tgORRqPzF2yHhYH/680Enf+FXmuXuA/hJIEVyRYE3NIYJIqn3A/aymtJcUnTnmFvDUFKC4SJSaENijKL52GwfhlqKb1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728197813; c=relaxed/simple;
	bh=qDSFVKxj5P9OuUbcZh8vXPtfp9NKaBMFgSQrL48vbZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WU9GcMggjvNkOlyy3nmkfZ/xIrAJbqcgd838yE8DMk1YQ9hhtG/cVJiZspzB0+vcQR4O1TgyAdvey8HjW/VapRkm4voJHsqn+/7QRFLUAyYJ/Z77CQpGOAWKz6xzhc3edexMiL1m2mWKFfNTVN9jKjX/maU0bG2ZTHku0//PIb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ahd5gSLj; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-20bc506347dso28369205ad.0;
        Sat, 05 Oct 2024 23:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728197811; x=1728802611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLvKfqnfSpZ28mnT6KrdGxzwf8Ry3wsHVE17xRaKj5k=;
        b=Ahd5gSLjX00Oaqcr7ENOrtJlSH1EyXW/VYXcBDLY71pbkkDEwTXjKK31ZKnOqAvVGp
         hQee2KDjGj7MJ/yMeEGCk/6GhX+xRSQSZvNwvBbl/FrB0JR0nVJwmVqHdrrwk7Ipx4Ol
         PtjWgS7Uy84UU6rtfutP7j5ZwYxlBpnnfwIFQS465h94gOf1kQK4JIk4YUj3l9Cv5nL4
         cOqJV+SVt0lqVDgUDpST6d989KAMQDfO1zFvGH+VDKZ0g3fQmnYBv1PJZGa92HErin43
         lJcBuXpQeWTz7V+NEHh6ZhHEVhir8SIa+cd3XRp3VyWJL76G7pFcfxo+DO/uDaXg4cQl
         cq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728197811; x=1728802611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLvKfqnfSpZ28mnT6KrdGxzwf8Ry3wsHVE17xRaKj5k=;
        b=kpciUd4cAQAe5Z7E32kE7VQJgqQa3abXWSPUTn3BQaDIaWug6+J37wAx5682XAkhl0
         hHPzZx/JDgMuh7XHy+9K4Gm5lQBFqis6162JMBOzQtemJtOenobu7L8xmMqNoOGctnDW
         qSDFAf6LwOlrJLuqPDu394jaXJ46UCuS0DDM2002vqdwHWJxGljZmFgR0+LIGOd/2eNd
         8di4oFhjRLVW4B5RDWncv3qJDJXNrpw16vq2czOz/BFty7/wxJcUfnagZL5EuTqOzlHD
         KICOxBX0GhI9QwycNC7PCzl7L7s1HY5XllLRq8lqpghTWCoNOBylMMu3CDUE7t64DO31
         hbJw==
X-Forwarded-Encrypted: i=1; AJvYcCUiv3S3iQHcLIAsp9f4JSh4QMPOwhiZDpzIKrzysVb1IPOVJjFWfli18sNSlJXY1/Y2QY3xQlXR@vger.kernel.org, AJvYcCVTWps3F1pvbsN/tCm0ueUK+2Haoky+8W53hJK/fNBq1HpU6r0hGw4RJqVGaO6zKc43GfjUQ4qRvVxPsuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywigvq35W1Uvaf55xWesgYIoKzprdBZEs8dWIe+qCHoMRHdXtuU
	Ce7uXIHqPTkvJtEETjHq2TsriWKRbg7Aj2HDv/3LUhEYK72Z8VYK
X-Google-Smtp-Source: AGHT+IHVKesG+DMOV41EUd8YEt3kAqz8ZB6LgjCBY0UV2GF5BPA+76bBUjOlDhdYJGijMVnlHpkh/Q==
X-Received: by 2002:a17:902:d505:b0:20b:5b16:b16b with SMTP id d9443c01a7336-20bfe4962d8mr129075365ad.36.1728197811266;
        Sat, 05 Oct 2024 23:56:51 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138af813sm21749865ad.9.2024.10.05.23.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 23:56:50 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v5 01/12] net: skb: add pskb_network_may_pull_reason() helper
Date: Sun,  6 Oct 2024 14:56:05 +0800
Message-Id: <20241006065616.2563243-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
References: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the function pskb_network_may_pull_reason() and make
pskb_network_may_pull() a simple inline call to it. The drop reasons of
it just come from pskb_may_pull_reason.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 include/linux/skbuff.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 39f1d16f3628..48f1e0fa2a13 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3130,9 +3130,15 @@ static inline int skb_inner_network_offset(const struct sk_buff *skb)
 	return skb_inner_network_header(skb) - skb->data;
 }
 
+static inline enum skb_drop_reason
+pskb_network_may_pull_reason(struct sk_buff *skb, unsigned int len)
+{
+	return pskb_may_pull_reason(skb, skb_network_offset(skb) + len);
+}
+
 static inline int pskb_network_may_pull(struct sk_buff *skb, unsigned int len)
 {
-	return pskb_may_pull(skb, skb_network_offset(skb) + len);
+	return pskb_network_may_pull_reason(skb, len) == SKB_NOT_DROPPED_YET;
 }
 
 /*
-- 
2.39.5


