Return-Path: <netdev+bounces-133389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA1E995C85
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53503281BD4
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 00:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B746364AE;
	Wed,  9 Oct 2024 00:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Zl9J5qaQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA00F1799B
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 00:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435351; cv=none; b=X59gDazyVqaV/Iow88imE4JBtib3Lq97S/SfFKhr/gVN/8Je0qKYHdqTiYq0poet+/DFRHmEE+zX9Rohg8SsUh7uoTtvlYjOjXjkD3oySuuarKUG4C2q/JxFiv0xBvkZPTXkhmqRBBoc3a6KVYw/Q/jkqIxrFbdeiOzee/Zkq8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435351; c=relaxed/simple;
	bh=xH668O18crr5A1NH6k8Aj+JP8S+91oltJLMlwh58J78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iih5Emh9IAjh5Hx4T5s6GdHuBud8CpECVY0iShyA+vZHR4ObEK5krn4FyFaGOt0BiRYt5TJDQZUb4NC7z1O90m84HXBmsUOfY9nHM+KfOAToAoEfscEVgfcNNVm5tJljAoUZ/Xr6D/H7eBjCtJvLWBbiqnoXGbS42gIeVNrL2LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Zl9J5qaQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20ba8d92af9so47796185ad.3
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 17:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728435348; x=1729040148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqUcKdW42CrdR2Dee2W+Xtk6g2oMU7HQioOPLi4n5sw=;
        b=Zl9J5qaQZi+UghVH3h2kfroIOeWVJ/hgQg9C+B+DNgblOSnvfeYtEVj2Fx2hg7Ce/p
         3svvzN5bieYuhXTJaGmRFCHToR/KGfDTkDn+fvtu1ICWX/RHcovFkTv/fqxLtEOmNbDn
         AfymLN1kmIJgnpAQJbJdSBrblDAKT3UjoBy+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728435348; x=1729040148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqUcKdW42CrdR2Dee2W+Xtk6g2oMU7HQioOPLi4n5sw=;
        b=uwMYG2TKnq8XKiw0kzOd1bxUNw8l8U+O8lv2I88laY+b5o4KkCZqerjeWV7NSiD0ml
         ZI9z9N2r0SqqIlA6cDvYHgiOcYoXQPKIcRfmr+NzfJWrjqyCzCWI9M/o5aMISw6iffu2
         SQHI+1YbBqpHpHl/+mX7WtZd1aTuUNO5G0GSAsBthBZ274HFlQgoWCM7VgMDIRQNUrcl
         XvMqW2yY0UDkVQVJ4ykV4ngs/sZmVAqNabMRaVfyHD/PRnJSSUc9orOukEinBj5c4xzH
         XgnbIaByblmtGrKywAKfMe9QVdqH/hvc9K+rp9Jw6lJJkautUG4DQoY39Idx0C1Hut0v
         rjrg==
X-Gm-Message-State: AOJu0YzFUNGwzkUjKw6n6/YbIFITPwMcSNMGmrr4MTVLuPVhh1/51k4U
	bmLLScJM0XihgFcbjhyFeGWmYDfBeCIXfxeawLgn4f3YG4PRcCE05P1sKhdBvulVkee5RFuER42
	1wWdymTIQlBfU59bQtuZ4LpMgzK7ZdyZwDV1+ka2a+mu2sYb3LiKnJeiwkrOX/7L3euyu5skCdH
	hyAYCccPXuYv6WihJKftzwyOTVKgpa0N2Dvqk=
X-Google-Smtp-Source: AGHT+IGfMGlqV4u9Qk5t0M3OQWhoi/AtJl6chgAjQYihLIPfXcXG6om5Wm1XMryvJEMq2Go13N+ZEg==
X-Received: by 2002:a17:903:41c5:b0:20c:637e:b28 with SMTP id d9443c01a7336-20c637e0b3bmr11984985ad.39.1728435348225;
        Tue, 08 Oct 2024 17:55:48 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cec92sm60996045ad.101.2024.10.08.17.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 17:55:47 -0700 (PDT)
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
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v5 2/9] netdev-genl: Dump napi_defer_hard_irqs
Date: Wed,  9 Oct 2024 00:54:56 +0000
Message-Id: <20241009005525.13651-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009005525.13651-1-jdamato@fastly.com>
References: <20241009005525.13651-1-jdamato@fastly.com>
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
2.34.1


