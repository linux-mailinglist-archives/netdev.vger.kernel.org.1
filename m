Return-Path: <netdev+bounces-134655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE3C99AB65
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226D51F237E2
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7EE1D0F64;
	Fri, 11 Oct 2024 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MumBV+Rl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F121D12EF
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672359; cv=none; b=qiw8AztZF82TijbEB6motP6YJgT2rg/3QSwS0uubYKbKvTQGI4hrfLLfM2kxehRHfyy8AsogZpEQWShO73QGU+VYzhqZEzLIrZ4GdrhpbfZzdpYle/W3sN19dADtQxcW21lVZSQOo062IvEO0AHJmMe6HqSZp5a4cu4bWdg+Lco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672359; c=relaxed/simple;
	bh=8bCROnq391qhvbK6vLiYM25EQ9c1S2j14ZF+/SPGKz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VFW34b6G0l9EL1RBjhwYBtaJsjoqinfcTUYQBHrsP3ZIKjGyZoqr7tw/eOpUa7sCXw4g28EOoxnXvaoWr+mFfB806cAQbbysGAqWLmIDCJQooJN641cDxImrdjoaLzchQShFkyrR9zbwUIaPCXWTM0FvW4BeP9sucp0veY45pPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MumBV+Rl; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea1b850d5cso980590a12.1
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 11:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728672357; x=1729277157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N45oz9QM8Oj1BURj2520V1UATs/lARHOECpxZOQBaPI=;
        b=MumBV+RlrIczHiJd8TUxAQ3B8w0PJDuA/57fxbJilnn9IbDvbdNHQCNYCfXGb91Otw
         tw6ROiidCvLRPb8/97S94Avr8DDCOdkB/en+jgJUFXuMJpf940kcZL+Y+wj2Y7nHu7Aj
         wxd66UCI6NwDOBseFMQcsEDcczTtdjLQkdCRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672357; x=1729277157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N45oz9QM8Oj1BURj2520V1UATs/lARHOECpxZOQBaPI=;
        b=eGIoWJkNnatSM2KpsKwSysFxugkQ7iRW4nH+Kl2Ko1USTpIJD0E6yyvjNUPOuiaMrz
         bd/B1cf4q4AFZWpc5r5nbsudAIp3gw1+hee1qr2s3OQ778la76pD02mGzU86hLST7GCe
         aLq5hKit+25KZh1FUvrSWo5Qzl5pb1bcNdW6J/mw4NNnwgl/eyxV1cXuM1evjRoSm5SN
         ob27eWS7Ax7Tquft6uhB+t5JRrdnQgsBJCH9clKLkcMCSpqNhTCyoediqUO6CIde9s5i
         Y/kp/cIxmq2A/WpIqprCJ5W7GKOI4pyIXwTHC57OktkCukuwnQmFaBvrgnxjn6Z6Pi/C
         zUVA==
X-Gm-Message-State: AOJu0Ywbp3YnBiNfZSuX6WXKRUHwEP2a5g0gCeuo+kpbH99f2A6LoDBC
	97Fq2TXZCYckj2F/tUT0jRP9mk4e0zLlcwKmBMgjRpeWuzlyrDwG1ilfm0n/ckuTI643vVAyZm8
	Lc6QfS1fS50M8IsfHqNcc1k8B0PDjRDG69lK60pJ58NKvsrQkjtV3KFua4rb/iRvJnzitJmi18q
	3Lf+GuaneV5aLGk7EO/APgaVqStFJfSLZbTp8=
X-Google-Smtp-Source: AGHT+IFCPoOYnokvNQ/2QoiFXULBQEDHRLHivUxnHE1zewct7LR//wwx5wrmKun/pN8nw2xNKOpV+A==
X-Received: by 2002:a17:90a:2f21:b0:2e2:8299:2701 with SMTP id 98e67ed59e1d1-2e3152eb849mr492826a91.20.1728672356576;
        Fri, 11 Oct 2024 11:45:56 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e30d848e1csm687625a91.42.2024.10.11.11.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:45:56 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v6 4/9] netdev-genl: Dump gro_flush_timeout
Date: Fri, 11 Oct 2024 18:44:59 +0000
Message-Id: <20241011184527.16393-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241011184527.16393-1-jdamato@fastly.com>
References: <20241011184527.16393-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support dumping gro_flush_timeout for a NAPI ID.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/netdev.yaml | 9 +++++++++
 include/uapi/linux/netdev.h             | 1 +
 net/core/netdev-genl.c                  | 6 ++++++
 tools/include/uapi/linux/netdev.h       | 1 +
 4 files changed, 17 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 585e87ec3c16..7b47454c51dd 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -255,6 +255,14 @@ attribute-sets:
         type: u32
         checks:
           max: s32-max
+      -
+        name: gro-flush-timeout
+        doc: The timeout, in nanoseconds, of when to trigger the NAPI watchdog
+             timer which schedules NAPI processing. Additionally, a non-zero
+             value will also prevent GRO from flushing recent super-frames at
+             the end of a NAPI cycle. This may add receive latency in exchange
+             for reducing the number of frames processed by the network stack.
+        type: uint
   -
     name: queue
     attributes:
@@ -644,6 +652,7 @@ operations:
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
index f98e5d1d0d21..ac19f2e6cfbe 100644
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


