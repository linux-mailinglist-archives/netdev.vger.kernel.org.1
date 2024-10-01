Return-Path: <netdev+bounces-131096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B02998C9A6
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 01:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7BA1F23BA5
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165911E1308;
	Tue,  1 Oct 2024 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="t+8yrxtO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882A41E1313
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 23:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727826833; cv=none; b=igYC7SW/Lw0C95kHWr+d6Zt1wRyId74WFjFPzeAtPfAFlpn9bfvL07cp4JXvtL05ZvFZMHn04lPLZFxCtU++U4sJj/pdGowvpyjydLOQlVKObFWAPd10cFnK0RAK+iIrPKKYw7GD+XB14UBuDm2Zsz8YNmB949MtXQMTBcvhaTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727826833; c=relaxed/simple;
	bh=A4ctw+2b8yq0sCbFcjdY3SVzbWEsxT2TUGSyUg6wK0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RNEy+WG6VM9i1wb8YihS8jbLZgkIQTpLx8GqMzJsf6n8846ROb48an8IchxoFQsY6gHcGuegKgjP8BR8xDharCERze5zGBEiIFgldvpDWuEQVmcov5VTL4YmdBmS0aYI6EMt0bGLGd53J3CCTM1e9KnNE6xVXpQOIhhtObRQyl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=t+8yrxtO; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e18293a5efso350903a91.3
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 16:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727826830; x=1728431630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQII9ub/bVtxy0ntEn1HGx1uSFXeUqoutb/T7bvVeMk=;
        b=t+8yrxtO5Y8sW0RctPlO9mtJZCzMt8sLCn93CwLonDirnK/LcLh0yewHcD32G4/20s
         UHIc1iOguDL8aU7jso/NpAc7q7JRoF5gySmeAX+zZrICQA03tySjU4xNWdTZuevRceF3
         VVFrLuP7rexiDWxJFJyFFPI6ybijM2u/uWxiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727826830; x=1728431630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQII9ub/bVtxy0ntEn1HGx1uSFXeUqoutb/T7bvVeMk=;
        b=W2l7dufAr44VU9kTEDZ+tlukGYGWZZ45SU1J9QXLDgGCfXSmA40jc2vGW2XCeDF2be
         5GBOcKUdzMnIgIyWZx5iC0lnqSjfCbSpZMdAYRyGMqzbiIrecB20WZBKXObpFc0mxdLO
         Jk4E/W5eLrJXJyaEZKdIx9kwK49JOy++2S/mh9g2gjmSD8LoIVcgcaZxd/DQxPECLMlE
         GoCPNBOqMAxWfv3XhFPDV+PkqfVtsI3MaXEjsu+PypKzXZ/9mpcpjNwOOS6IcLwUsvi9
         wpPETG2PP/L7lZ49jbH75T+pGTp1UHejTl4jmDiCyZFZec9PD7vBX4FiIM6FEHEZR3Lj
         PJXQ==
X-Gm-Message-State: AOJu0YyvQP8jBEijH2++Ci/RFQOSD2eI+9ZlKuv2Ix5qurdCQJwBIGNN
	hyU2Ta+uuGNItclevk8C2rBK0VQ9Zvjx5FGkRzhhvUPsAI+/5vaLZ0bYdSXICkdVmvi4SRAR9qj
	AczLyp9cmeCXHZBs5MWb+Z2/VXzCXp+iRM5/9JNl6eCUPFiK7hbKY/2S+0ojhUYic/0jG1rlZD2
	dl+0Z8syhL1s2iqGa2Rb3OyZzR9f8oBLkBLfA=
X-Google-Smtp-Source: AGHT+IH6y8TLEoNcS3CIY1eRqDcl6J9ZIkBmPCtlp4ki4860wF8VxL5+YVU+aQ3guijKYC2ciYrGKQ==
X-Received: by 2002:a17:90a:f192:b0:2e0:59af:b998 with SMTP id 98e67ed59e1d1-2e184943fdfmr1601328a91.39.1727826830385;
        Tue, 01 Oct 2024 16:53:50 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f89e973sm213130a91.29.2024.10.01.16.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 16:53:50 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	Joe Damato <jdamato@fastly.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v4 4/9] netdev-genl: Dump gro_flush_timeout
Date: Tue,  1 Oct 2024 23:52:35 +0000
Message-Id: <20241001235302.57609-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001235302.57609-1-jdamato@fastly.com>
References: <20241001235302.57609-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support dumping gro_flush_timeout for a NAPI ID.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 Documentation/netlink/specs/netdev.yaml | 6 ++++++
 include/uapi/linux/netdev.h             | 1 +
 net/core/netdev-genl.c                  | 6 ++++++
 tools/include/uapi/linux/netdev.h       | 1 +
 4 files changed, 14 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 585e87ec3c16..bf13613eaa0d 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -255,6 +255,11 @@ attribute-sets:
         type: u32
         checks:
           max: s32-max
+      -
+        name: gro-flush-timeout
+        doc: The timeout, in nanoseconds, of when to trigger the NAPI
+             watchdog timer and schedule NAPI processing.
+        type: uint
   -
     name: queue
     attributes:
@@ -644,6 +649,7 @@ operations:
             - irq
             - pid
             - defer-hard-irqs
+            - gro-flush-timeout
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 13dc0b027e86..cacd33359c76 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -123,6 +123,7 @@ enum {
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
+	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index de9bd76f43f8..64e5e4cee60d 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -161,6 +161,7 @@ static int
 netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			const struct genl_info *info)
 {
+	unsigned long gro_flush_timeout;
 	u32 napi_defer_hard_irqs;
 	void *hdr;
 	pid_t pid;
@@ -195,6 +196,11 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			napi_defer_hard_irqs))
 		goto nla_put_failure;
 
+	gro_flush_timeout = napi_get_gro_flush_timeout(napi);
+	if (nla_put_uint(rsp, NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
+			 gro_flush_timeout))
+		goto nla_put_failure;
+
 	genlmsg_end(rsp, hdr);
 
 	return 0;
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 13dc0b027e86..cacd33359c76 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -123,6 +123,7 @@ enum {
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
+	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
-- 
2.25.1


