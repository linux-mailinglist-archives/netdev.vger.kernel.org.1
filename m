Return-Path: <netdev+bounces-130728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FFB98B5A7
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4EE1C2149D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 07:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1791E1BD51C;
	Tue,  1 Oct 2024 07:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/wtiZN0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A458C21373;
	Tue,  1 Oct 2024 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768087; cv=none; b=OTtkxr85Aom2Uq3yZ8Jou2NRywG7JzpG7OSS4V+MQsGmjhBYpr4ApJP2MtJ6xRC6hnBjOcEgg9GcM1by3J2500uk9elulyawr+q3Wz5Ly9m+/+802/IxfXgbKgjNaD2MHSyBJtDGeHks8KR7kY8jdeNMtIAsHvN9ddChfDJRmK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768087; c=relaxed/simple;
	bh=JBRdn6lcWQQqA+78Zj5tgLu0QHhEr7otA+mjf1g+Jaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HMWk341Z1MUE6TwpAS3IFe8QkbEJMkP+4acNVIJRTJ74qHSHa0PVrHXUFPSAfftnl4dBDI0VHRcYAjteQoDzyAn4o1+T0T/HvanLWu9fyyqHy7pw7Re6YW1nstFLEkFakxon3Yc2vjwkd4Zu3XxeWERnNv3X6Txwwc81aZJvK1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/wtiZN0; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-20b93887decso14230035ad.3;
        Tue, 01 Oct 2024 00:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727768085; x=1728372885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmrCBAr6gJsJ0RdHov3Wc0QJ/uFtz7BMKr05A4sbzbQ=;
        b=l/wtiZN0LRjMSiBTMx4y1yZHlcaqmEOAopWJpvhq4z2rOoa//4EgjptV+5b5Bf2NS7
         Fo8BY4t0QpLq8DTfrFPeDWfiwhuOGFdSA6E+qz0QjXrRjKbfo4DFONjNxbaPE2mrg6MG
         i0rmTtNLYO3+IfsX5EmlF9xyE6Mj7+Cz/uqAXKTSNPzDCsNU5x2hz7l1gC5kfuVt5I30
         1K+HSj6Q8C3SqCR7LAHMOmMF8UgzQKORgm1f+Du5J0TB0X2b9xmkAdSUUE76G0d3JBVf
         zUAVVRiUqJMGHbIBCBVxW044aMFJMzBhhjvhzgr6U2YwVU4O4QH6HdWRz7JzIsokH/fc
         OCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727768085; x=1728372885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmrCBAr6gJsJ0RdHov3Wc0QJ/uFtz7BMKr05A4sbzbQ=;
        b=cu0kEv2U4Q63MQtCh7y76QKMzJn5yYha/QH0vqQbruJVWBVqmQfnUTG+sZ2FBe8VsW
         jJTkP4PLY94Um7mqpr90EdWnS2If/KxhATSpT+sR+i0P8jpe5ODqgStrWiKPz3RYryQ5
         7pJBlY5lqnkcWZWe6ad/mfrV5+vr18LCLgT16Cqek87hhG9jYrLeFePI89BhidCW7mYU
         /bESwXk04IZw1iz18VOtnDP/cbruCPs+5L1kRoYsIKEzktNFKZ7Z30erDpq9VH4vfqMs
         3cooNJRZfT+/2YdZNpR4tpLfj+/QykT/ZUJRoc52BD5lUh4scFZbZQ+9KUZsTXfU5N2Q
         V/Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWj/Ce+EJrlEXD8+UoSJKqrG7ulJXa54TrfVM3nExAberYLO4kR2ym26DV97YJgstgbzy31r7CIf9Q8/Es=@vger.kernel.org, AJvYcCXHTt+5rC8yIIdNwPYSmGTx3udzXY0Fh2j48/92mL555dIaoAhdQ/0bd67NHunZi3aZXtL4l5VN@vger.kernel.org
X-Gm-Message-State: AOJu0YyGSl2Zwj+Im1Y2S3GEaCUICxW0SVTxWn9naVuV91/71l2NPf7j
	2AD9m4FmcIoztwxRPbhGrzOLHY1CH04J1HNp4C93oACvd029R1Gj
X-Google-Smtp-Source: AGHT+IGv0H5OKHw0O2/rvRLwE3zCutemhqxw8UYFTNkB9h/GTuSbwTLlFZvbx2VM6a0B4fo3awml3w==
X-Received: by 2002:a17:902:ef51:b0:205:4e15:54c8 with SMTP id d9443c01a7336-20b37bd5230mr190110535ad.61.1727768084855;
        Tue, 01 Oct 2024 00:34:44 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37da2667sm64545575ad.102.2024.10.01.00.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:34:44 -0700 (PDT)
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
Subject: [PATCH net-next v4 01/12] net: skb: add pskb_network_may_pull_reason() helper
Date: Tue,  1 Oct 2024 15:32:14 +0800
Message-Id: <20241001073225.807419-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241001073225.807419-1-dongml2@chinatelecom.cn>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
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


