Return-Path: <netdev+bounces-131094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F7D98C9A2
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 01:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D639E1F24717
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5411F1E008D;
	Tue,  1 Oct 2024 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="r3rpdxy5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CB21E0B73
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 23:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727826822; cv=none; b=Lv4+OPAM+jeb4zIfgmJ21+e1tQWpsaxJVZAr/XUJIiMNGWLiFD1Pmy2LLWBoOnfkTVluBtYD82bBiary1D5xXYy1og/FVpnN22TE/c2LKl/6HWrhqctFgxPAsG4QKcV4Mkx1UQZ3MycdMDn6N5oEzjACUnwefPFM491Q+4CTigE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727826822; c=relaxed/simple;
	bh=kAEG1Am3qGuk35HDrwWkcGYK2JXUX2VXmCklQAjtsYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c0RL9zL2xLwJz3YfqngQYWqro95tLsbJ7srT+i81QynG0ZBCVnq5SLBGRZmpNUy4OaC0NCUc6jNQqFXclW5gXbyf3zbJi9tCsmxjZsijW63MQZnTfq0t222+rj42deLBv3byY6OM15rsWyqPJaP06Zo+UdRHzeR9PPjCu3eDewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=r3rpdxy5; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e0a950e2f2so4879074a91.2
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 16:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727826820; x=1728431620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrVj7Azlfps/B75TfmvK6tL6oA2kiOEMADlEWkkR0JI=;
        b=r3rpdxy5WzAxFcJJNI43O4TieaDRF5ppGwabok26WN7D165h0VUvprqM1u/+kzxc/V
         PrHwNvIoP5AYQxvoZy3DxIhzJ+6d8E2tYO2OJXjrJIRcOEpd+/21vFp6XOcokj4DDW5Q
         Q/Smmc6mp97ZI4r1MMKK3VQNOHIlsyNBPJkCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727826820; x=1728431620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrVj7Azlfps/B75TfmvK6tL6oA2kiOEMADlEWkkR0JI=;
        b=YAkhIbcSeiGv8rA8bp8/qcooWIl8LXnaTbEjir5+Fl6epJsUzKxffPvPcLISeJyp/a
         WUhawDNovrOrXy9zxt4/yxewUMSMw2Wm+9Szr9VwfpcTgZT2X8y2wGsYPihvNESasHfF
         hc2RTkeJS8KYVNcR+ZCxiLyAQ5OBeGUHa02yLTtOFILhBrnN+jyNFarwb7wspEjVy3Jl
         gjMwTFsWUZJXJydAHwzGC5tZn3g6BDc4D5gTJvis5RKXKz2wzq72PTLwEqAZ+ZFWFawy
         FFmcbD8v61h0Np8dSJeN+gMKHYx503XTNbEYUaqVaLz8CkI2gjnb5B11nBUrm7j/dF8+
         SMBw==
X-Gm-Message-State: AOJu0YzJ+GqIEsxLGlvcMRv+U+J7v8wokfC3lnzSdoRBP4N90BgG8+OZ
	qq+yFE4VDi28sKn9KYkpCuZ1o7nuag84QvR+WvQ31kdif6Ts6lGY8Gy7Y7VZ0owN5QN5Rhk3pkw
	UKo9NYw5ldcc/FBjeB1X0Th5do6mwOIKs8m8rUBUo7FXHfP42hH4YEGAoJdM2sfRAsA3I1JPYdJ
	AAy48gufgU2Dg3724iqRo2yIIUUMAhFGfkuJQ=
X-Google-Smtp-Source: AGHT+IGpgJ1rgzHrxwtT40rOkt57kYCh2EC90ybm6qKtAfpKHRyK6AeHjlpVi+lwyDuEEFYJtQbb5w==
X-Received: by 2002:a17:90a:8c18:b0:2d3:cd27:c480 with SMTP id 98e67ed59e1d1-2e1849e437bmr1829345a91.33.1727826819796;
        Tue, 01 Oct 2024 16:53:39 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f89e973sm213130a91.29.2024.10.01.16.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 16:53:39 -0700 (PDT)
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
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v4 2/9] netdev-genl: Dump napi_defer_hard_irqs
Date: Tue,  1 Oct 2024 23:52:33 +0000
Message-Id: <20241001235302.57609-3-jdamato@fastly.com>
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

Support dumping defer_hard_irqs for a NAPI ID.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 Documentation/netlink/specs/netdev.yaml | 8 ++++++++
 include/uapi/linux/netdev.h             | 1 +
 net/core/netdev-genl.c                  | 6 ++++++
 tools/include/uapi/linux/netdev.h       | 1 +
 4 files changed, 16 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 08412c279297..585e87ec3c16 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -248,6 +248,13 @@ attribute-sets:
              threaded mode. If NAPI is not in threaded mode (i.e. uses normal
              softirq context), the attribute will be absent.
         type: u32
+      -
+        name: defer-hard-irqs
+        doc: The number of consecutive empty polls before IRQ deferral ends
+             and hardware IRQs are re-enabled.
+        type: u32
+        checks:
+          max: s32-max
   -
     name: queue
     attributes:
@@ -636,6 +643,7 @@ operations:
             - ifindex
             - irq
             - pid
+            - defer-hard-irqs
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 7c308f04e7a0..13dc0b027e86 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -122,6 +122,7 @@ enum {
 	NETDEV_A_NAPI_ID,
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
+	NETDEV_A_NAPI_DEFER_HARD_IRQS,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 1cb954f2d39e..de9bd76f43f8 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -161,6 +161,7 @@ static int
 netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			const struct genl_info *info)
 {
+	u32 napi_defer_hard_irqs;
 	void *hdr;
 	pid_t pid;
 
@@ -189,6 +190,11 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			goto nla_put_failure;
 	}
 
+	napi_defer_hard_irqs = napi_get_defer_hard_irqs(napi);
+	if (nla_put_s32(rsp, NETDEV_A_NAPI_DEFER_HARD_IRQS,
+			napi_defer_hard_irqs))
+		goto nla_put_failure;
+
 	genlmsg_end(rsp, hdr);
 
 	return 0;
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 7c308f04e7a0..13dc0b027e86 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -122,6 +122,7 @@ enum {
 	NETDEV_A_NAPI_ID,
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
+	NETDEV_A_NAPI_DEFER_HARD_IRQS,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
-- 
2.25.1


