Return-Path: <netdev+bounces-133422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDAA995DC2
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 04:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805A41F2101E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAEE13635F;
	Wed,  9 Oct 2024 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDrbA/wN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A4856742;
	Wed,  9 Oct 2024 02:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728440962; cv=none; b=gCpkPD42utRmeEX8STcep/bL/aT/jHot5OshW36ySHAcETnQkFdWH3YK2eLEzzz2hKbSjFbDX49qFjLtCP1V24NXHMkbsVTITeH5U5gOXF8fIPACReb3nRvNWF9efCnJNNSPDeicoiDiwgj1lnJM0ja/wOCxpPR3TtXytTYaeB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728440962; c=relaxed/simple;
	bh=xmSEGfXWYYnrxahV/hxdM2xvbpsGMckUIHbpupwQeoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FmWReJfodha3AVwTp7UOF06Hb4eiOE1yZWHr0EBskZ2bHeHp457eDKxkd4J0gAJd5jeXiqWLZ//caBREn3uuet1qQFK9q6q0UNqu6owIjC6GQSFPB1qYokXgejkI4DoHPPbwTZXCL1zgBcciVtXDyzmXR66OeQzY2EwiTpgbCQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDrbA/wN; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2e18856feb4so5343155a91.3;
        Tue, 08 Oct 2024 19:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728440959; x=1729045759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLQPPQHkux9UrJBZUqB+t1LpH9/HisAt/+hbWRBu/OA=;
        b=SDrbA/wN4FIEXJGX674ScIsyiTEoLvxdNtLNID5u4+dlqxnrC+2BjVfFQ6TJy7LItt
         Dk33ul/RrUcRGAe2enug8ezZiZGh4S/khBCWClDjP7tpqXOEMZT7l4BBkLtbxHi83EQA
         GE+WY+Dy7VkbOB8gUWN4oeqMvZHLsQv83TQh3SsmoFI0KqiTcXAOvSBBje6XACKMKTIE
         pzOGXWdSG67aMQs3hjynxR7INYZ4Wot9JAtLAPTOeDbb64eEjjiHInIA/vxm3pfm4vIU
         jjOY58VrkuRfQyGMkpawSYg4bONt84JzSj/U9vd1g9i0sQ4E73urUR1eaK8xz92kDJZp
         GWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728440959; x=1729045759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLQPPQHkux9UrJBZUqB+t1LpH9/HisAt/+hbWRBu/OA=;
        b=ZQaKEWsrwseODEUhChdKOx0pgxalRFbe4K9tZhpScSZ9wnYv2fYcJjYrUjK53k7Gkn
         h+ZyqMsPAsSl6nT5DIDZx6X3k2ay/sYkNsAOQe4RFiAq8gteGHUAwNUB0tH4pc4CgJBx
         T72NIBtPkBMSbJpldl1s15dRBhnLtmJuem4VqU6QGKZZD+/TsQO0lOt04jjZcERYjz81
         1DvkRG94KpHNcPWrvIKliW53Sz5sVa3F//SJ3mZHPS1oTxKy6zxv2c8NpKOOc5JzHN3S
         Hgo5hmJGMQIa5htFVyZ6c/xrgn/84ORB7aFXxW+JEv97jV/oDhGnQjOvonSdUJROLKUE
         RuDg==
X-Forwarded-Encrypted: i=1; AJvYcCUqzDTLyMGY/0WHPrSXhh0c/IkmGXyscJrYWDFrummDxb8HfpQOH1i0ICnGmD6fxtx0hbSgBXlJ@vger.kernel.org, AJvYcCVrcs66fbpqr5wvse2e2i0n4Wv+zkxOpMw/CbbAcDvgIMnd3u7oaSllQTCyj+nEWRDgJmdGMHwhrDES8O0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmd0bLFfaQRVJr7XcYZSiUQQAMVP3NYf2OwGWCwx+etx8VMV36
	stzL0OltQvTQTIS1Wuzt8kZWMqjf3CaosSaEeYRSS22Bx3WA8Hmic305DpTt
X-Google-Smtp-Source: AGHT+IFGXx9KEdhqXaWUZrRrow8SwRSDmZCT0Rqj4gq4A+htJhjF0rD5ZbLLId6II6j/zYD5kQKaKg==
X-Received: by 2002:a17:90a:f696:b0:2e2:9a3e:68e1 with SMTP id 98e67ed59e1d1-2e2a246725bmr1078216a91.22.1728440959484;
        Tue, 08 Oct 2024 19:29:19 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5706e8bsm336202a91.18.2024.10.08.19.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 19:29:19 -0700 (PDT)
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
	netdev@vger.kernel.org,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v7 02/12] net: tunnel: add pskb_inet_may_pull_reason() helper
Date: Wed,  9 Oct 2024 10:28:20 +0800
Message-Id: <20241009022830.83949-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241009022830.83949-1-dongml2@chinatelecom.cn>
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the function pskb_inet_may_pull_reason() and make
pskb_inet_may_pull a simple inline call to it. The drop reasons of it just
come from pskb_may_pull_reason().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 include/net/ip_tunnels.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 6194fbb564c6..7fc2f7bf837a 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -439,7 +439,8 @@ int ip_tunnel_encap_del_ops(const struct ip_tunnel_encap_ops *op,
 int ip_tunnel_encap_setup(struct ip_tunnel *t,
 			  struct ip_tunnel_encap *ipencap);
 
-static inline bool pskb_inet_may_pull(struct sk_buff *skb)
+static inline enum skb_drop_reason
+pskb_inet_may_pull_reason(struct sk_buff *skb)
 {
 	int nhlen;
 
@@ -456,7 +457,12 @@ static inline bool pskb_inet_may_pull(struct sk_buff *skb)
 		nhlen = 0;
 	}
 
-	return pskb_network_may_pull(skb, nhlen);
+	return pskb_network_may_pull_reason(skb, nhlen);
+}
+
+static inline bool pskb_inet_may_pull(struct sk_buff *skb)
+{
+	return pskb_inet_may_pull_reason(skb) == SKB_NOT_DROPPED_YET;
 }
 
 /* Variant of pskb_inet_may_pull().
-- 
2.39.5


