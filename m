Return-Path: <netdev+bounces-118466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97950951B5E
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 15:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB461C21D8B
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710891B1411;
	Wed, 14 Aug 2024 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UjqDilPx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF63A1109
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640811; cv=none; b=sKrRORrd0wpmlrn63JmGa6q9+X8+2S7/p66PJ8AGoFzDMdv37fiOBYIStlRuIHrVt2gEer1VwuYtDDSIIhx9D/8s9HkGeKvnkWqUeDL91Ak6VMguED2tyQAc6wu6AlD4jby9G00zSns43YbH+M5ie9seMRM4dbNdRhkhBFH1fVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640811; c=relaxed/simple;
	bh=c0Z0S1anIl0K69+F6MOi89jUgaugq+mo8EhGncANIoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDAV6TaQQW8C0CxCNxeCuFE2L3rCocrJc5A4NW9I4JqxxvGLMiBq/Ia1BSdzmRMFGBEs3dZzdT1LkHrpPk1nb5RtwxdXwTsBprLXHYX53wfI+ANwyspCLDq+bMeXUOLiP2BUCt2062EWUv6HzNDqjB67G00XIalKiG3EqjEivrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UjqDilPx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-710bdddb95cso3989763b3a.3
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 06:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723640809; x=1724245609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BMdfpqrY5tm8/jK+EFC7SH1Yd5hnsxPDDCueoCM2z4=;
        b=UjqDilPx11O2wPo+JNejKrj9guhcbKuSbVJ/Y+DLXScZkx7tvPpUDjEZNMRuPI1gXQ
         tJcoFu/wqpBt8IgDX1Z5rpxSdZWvg/YCFXHfTG5+g//nu4s+HlnLSZmnlFHSasIeENoy
         Q2I0HiWYC7h5kRWEb1sv2fKNxs4y7XReZjo0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723640809; x=1724245609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BMdfpqrY5tm8/jK+EFC7SH1Yd5hnsxPDDCueoCM2z4=;
        b=PGOPPyrGUrpKhV45e6Y/n5HGkrtRsnI2XhZhmoWP/rFGRh15YY6yL9nAFclONrsSYh
         q+8TqaiTlecGf0SDkSNxG4xbYg6aOh7b4gdOpeg7QpeVBMiH9r14FVG/VcIwM1sEFfKO
         okKZuz/fhQgirynGD6r1F7aNfamBlSyI5MlRcYh+yHg8w6Bd9DybFZeO1OMMp3ZXYSlg
         GkoOPL4OFY51/5FVXi7DxE4jnpwQgOTSW9ocFquw4uxqZ2LteFEDvpFj0KASX+q9dWWS
         2rxrODCsge76s0CfMvBgRfFStG8/S5FNx5/NVNDAbeoLxUFlkImo1cN8+mXVqHThe02J
         sBKg==
X-Gm-Message-State: AOJu0Yxk1hvlH0wEMrBf7nVtZPDeHK9ga6zWrWQc0JqAZ95S/KtEUSsS
	XtxJwuWMit7LfwRDuTouDwbfgNBJpD/J0qXHOG1SmC7kO5XH4u7n2BKfpON9h2CQ50xFqyksoNQ
	mKDOJCTpKfO5Y8N2kaKl9qXl6YKFxZUdDSQXgh570nf0eizzfRn0k7hDq/a45Ib18JFruegbM26
	mPS3I3ekmGdt+51qqMlN5Bjc2gkz50MZsT3bMYtrfjwyX5oaI6
X-Google-Smtp-Source: AGHT+IGnVjhFwurCHNbjYjv51rVCX+lKZITY0tBAUZPAueDe48jrzk6cUutpKf5mx8ECVu//RzDXIw==
X-Received: by 2002:a05:6a00:4607:b0:70d:1dcf:e2b4 with SMTP id d2e1a72fcca58-712670f76edmr3403413b3a.1.1723640808453;
        Wed, 14 Aug 2024 06:06:48 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-711841effe9sm4904543b3a.31.2024.08.14.06.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 06:06:47 -0700 (PDT)
From: Boris Sukholitko <boris.sukholitko@broadcom.com>
To: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: Ilya Lifshits <ilya.lifshits@broadcom.com>
Subject: [PATCH net-next v2 3/6] skb: export skb_vlan_flush
Date: Wed, 14 Aug 2024 16:06:15 +0300
Message-ID: <20240814130618.2885431-4-boris.sukholitko@broadcom.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240814130618.2885431-1-boris.sukholitko@broadcom.com>
References: <20240814130618.2885431-1-boris.sukholitko@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make skb_vlan_flush callable by other customers of skbuff.

Signed-off-by: Boris Sukholitko <boris.sukholitko@broadcom.com>
---
 include/linux/skbuff.h | 1 +
 net/core/skbuff.c      | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index cf8f6ce06742..5a9f06691c80 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4054,6 +4054,7 @@ int skb_ensure_writable(struct sk_buff *skb, unsigned int write_len);
 int skb_ensure_writable_head_tail(struct sk_buff *skb, struct net_device *dev);
 int __skb_vlan_pop(struct sk_buff *skb, u16 *vlan_tci);
 int skb_vlan_pop(struct sk_buff *skb);
+int skb_vlan_flush(struct sk_buff *skb);
 int skb_vlan_push(struct sk_buff *skb, __be16 vlan_proto, u16 vlan_tci);
 int skb_eth_pop(struct sk_buff *skb);
 int skb_eth_push(struct sk_buff *skb, const unsigned char *dst,
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 1bd817c8ddc8..e28b2c8b717d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6220,7 +6220,7 @@ int skb_vlan_pop(struct sk_buff *skb)
 }
 EXPORT_SYMBOL(skb_vlan_pop);
 
-static int skb_vlan_flush(struct sk_buff *skb)
+int skb_vlan_flush(struct sk_buff *skb)
 {
 	int offset = skb->data - skb_mac_header(skb);
 	int err;
@@ -6241,6 +6241,7 @@ static int skb_vlan_flush(struct sk_buff *skb)
 	skb_postpush_rcsum(skb, skb->data + (2 * ETH_ALEN), VLAN_HLEN);
 	return 0;
 }
+EXPORT_SYMBOL(skb_vlan_flush);
 
 /* Push a vlan tag either into hwaccel or into payload (if hwaccel tag present).
  * Expects skb->data at mac header.
-- 
2.42.0


