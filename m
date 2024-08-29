Return-Path: <netdev+bounces-123284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9A996460C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F8E9B21054
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 13:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D7D1AF4E3;
	Thu, 29 Aug 2024 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="dIx6Sn/I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BCC1AED50
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937200; cv=none; b=S6bnM2Xt6fPQeUT3gHxP7iEZm4Ux354rGzTpapR9IK0SJGEfBew6EW1R53D3cAQQs50ROPTBLgPLxpgDxo/bOEpmiG2sO/6d2SD9kZviSTl/KyCe2QUqyQSM2fhKm8FhtgQa8bfgY8wpZJRJLOiem5LFuBMAbD34xeSyJFfxEIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937200; c=relaxed/simple;
	bh=LY6teNijKykhT8LcLXhvWcqr0xTJvW1UGMeUYMcjQ5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RnyGg/jA+Z7sg1sewbZleXu/CrBtqc34CtHwvfzJb2e/m0Wg6lmoTKluIgwhD2UXvCFUPNBBEr7l11FRiQ2vzMENvR98ie41AQa88TOtaOeYJBCJiDtFAPdMyV3gRgYgUyf1yEPtTaxStfEVEnFuVJamPYNnMebj0GSbVQwWVPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=dIx6Sn/I; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-201d5af11a4so5487835ad.3
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 06:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1724937198; x=1725541998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgl23lpxXcxLJcPC+/6yHZPVWll0h2Oag84ZBhf9v4w=;
        b=dIx6Sn/I1y8uzjLXHRiKDU9nP8K3m7jBDQcKXN4C55BOskW0tECAZqzBsXiKKW5PsQ
         fHGjaQbmkrNTAVtQ0Q3nCsdk+8WnigIdl+cPjgpnkQPL7t4IG/OzcID41xMuVF6huTjS
         HqoR+ZqaPndr3FlnUMX3ldOiLdmP34qq79vWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724937198; x=1725541998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgl23lpxXcxLJcPC+/6yHZPVWll0h2Oag84ZBhf9v4w=;
        b=iwNN3vWwhWnoHQJk0jsWodWcf+RccLMwjiIxWjd+s5Mc26cmZuSWsJlEhoJC3Hf2Hp
         iK6AbVWTApKBum0yeQAk/UPzYUaAjyr7v0M6kB/HLOBiUJ83jd2/n6AhNQIYqY9jTr/V
         3RSqO4Nquz1gvHn2C3FkKWkoaTATlpanvD7JDfxvOnC5mEpyGjksr06Tsx4BZ9WCnOij
         4nt8+lmBXEngskGU8CjUxpQ1ViKHURE7cbpAMaMfbVzf2QqipXK0EbukHb6lkrpuOfQX
         kAx51Y8IsJOyiInz/UmP5HR8ymd1IJk4jfn2Og3ec98h0ViVxK4z743UaBnrfjwOiluj
         5mJw==
X-Gm-Message-State: AOJu0YwaAlnOO3KmhGk8IQzyW/vPcImjx0/JWs9ktB9pAlPMe5c/hLUV
	lOdSUI5Pa8xb8EHiI6xC78v/1tDn8LJNNyYFvZoN3IKz5js4A60YEfFki5Sq6+18YPbV8TEAN8l
	72kFG8z2x31oyvvSWphkso6Y6czheRnYczZPa+XIhron/ZXGBEMOYo6WeMaWxABegZD+1FGlCZY
	HYs2bhbzSbdSmX8GYTzuvP+Kzn5sGv/wKG3riUag==
X-Google-Smtp-Source: AGHT+IEai9uG2TpaQ3GILW0DtKC65AC9xQAh8DUHKEnc/3a9ZsdmyX3Zn9R455FKvzhgMm7/6Ry8RQ==
X-Received: by 2002:a17:902:e851:b0:202:3dcf:8c38 with SMTP id d9443c01a7336-2050c453f85mr29456225ad.44.1724937194835;
        Thu, 29 Aug 2024 06:13:14 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b13c9sm10991065ad.62.2024.08.29.06.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 06:13:13 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 4/5] netdev-genl: Dump gro_flush_timeout
Date: Thu, 29 Aug 2024 13:12:00 +0000
Message-Id: <20240829131214.169977-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240829131214.169977-1-jdamato@fastly.com>
References: <20240829131214.169977-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support dumping gro_flush_timeout for a NAPI ID.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Martin Karsten <mkarsten@uwaterloo.ca>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 Documentation/netlink/specs/netdev.yaml | 6 ++++++
 include/uapi/linux/netdev.h             | 1 +
 net/core/netdev-genl.c                  | 6 ++++++
 tools/include/uapi/linux/netdev.h       | 1 +
 4 files changed, 14 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index ee4f99fd4574..290894962ac4 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -249,6 +249,11 @@ attribute-sets:
         doc: The number of consecutive empty polls before IRQ deferral ends
              and hardware IRQs are re-enabled.
         type: s32
+      -
+        name: gro-flush-timeout
+        doc: The timeout, in nanoseconds, of when to trigger the NAPI
+             watchdog timer and schedule NAPI processing.
+        type: u64
   -
     name: queue
     attributes:
@@ -599,6 +604,7 @@ operations:
             - irq
             - pid
             - defer-hard-irqs
+            - gro-flush-timeout
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 43bb1aad9611..b088a34e9254 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -122,6 +122,7 @@ enum {
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
+	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 79b14ad6f4bb..2eee95d05fe0 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -161,6 +161,7 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			const struct genl_info *info)
 {
 	int napi_defer_hard_irqs;
+	unsigned long gro_flush_timeout;
 	void *hdr;
 	pid_t pid;
 
@@ -193,6 +194,11 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 	if (nla_put_s32(rsp, NETDEV_A_NAPI_DEFER_HARD_IRQS, napi_defer_hard_irqs))
 		goto nla_put_failure;
 
+	gro_flush_timeout = napi_get_gro_flush_timeout(napi);
+	if (nla_put_u64_64bit(rsp, NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
+			      gro_flush_timeout, NETDEV_A_DEV_PAD))
+		goto nla_put_failure;
+
 	genlmsg_end(rsp, hdr);
 
 	return 0;
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 43bb1aad9611..b088a34e9254 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -122,6 +122,7 @@ enum {
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
+	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
-- 
2.25.1


