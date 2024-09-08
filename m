Return-Path: <netdev+bounces-126292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966EA9708AC
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 18:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1ABA1C2127B
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 16:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB1617994F;
	Sun,  8 Sep 2024 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="TvY1osHd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91438178CF2
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725811729; cv=none; b=nLb7/XbOReUvz9EMDCA9b9FV+ugNLTI6KQs8GkERm39f+6URSIXOt72UVTkdiy7KYCI7gPzKKg22GV0louzezR12aG5owKW712OCfyXMkQGD7f7w+bd97/6iVNSd/YPE2Hkvco6Dy2DKi8A0yEqkTkst6EC0URflUiz499CipYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725811729; c=relaxed/simple;
	bh=S6PZndeVLZnfh6ZqdJsAlBwaDjFgBkDRfqKlXOKQG7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nt4LWmGQXedKDzA6kmh5EZUCw7868wxuVURab7Hnok5bkNx1kztyQsERO20UPcZ0YvdlXYA3qpKDm0jHfgl3dyuS+s/KKRzk0H6quYVGhyNxhZjzFbqFGQDzLc4tCzgwTd0KuZJaaJ4+GqNxVFUukvgAUiKWALWcgwDhBRVPbuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=TvY1osHd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2057835395aso31924865ad.3
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725811727; x=1726416527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITiLh+mkz38oBRCpyHHyb5jRcgvfzTrPSkEX4VapaAc=;
        b=TvY1osHdU7jojtlmef8LyN4PZxcZbLUreT1yDtc+H5+azxhQeu0kH2fKeMYFd/o4oN
         e59vEOKGDoFcj3jAsXeZ4QC0JcLjJE+5qh7RwoShvqGGdbmz0wtcsDo06LmHicC2Y+BM
         A3pZDldsOgqNtdViC7Nqnr3T8yPb4secEriJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725811727; x=1726416527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITiLh+mkz38oBRCpyHHyb5jRcgvfzTrPSkEX4VapaAc=;
        b=Hle42oUQlmtC6yC1KtkEotMzSPZhxo8zE8Q5i+3o4HUrpOBw/iAbSB5FkWKoJaTsKC
         BYo/Pm3pxxNkomOqKKJcktYucM9pciV+nvdExlP2FzzZJ6beAZxvOkPATGr5scTSkhm5
         KHlCfJ7BJVwZfPa91eOkLTd2aB8tYKwNSD3M14ZFOwv3+rXLS5VeMYTlhlXSkHZMYj4L
         kLp06GHd/BEcrHviLE4Hc8O3j+f1WqWdMicSpfS+sspI4F397BaPaI1/0oHzOdX2XaVn
         2rkhj9wFiCFsgYNEqXrAg/HgDEjxcINVcAWnENr0tWSAQEQS9daSCxJQncxzQJfLAkCt
         iYzA==
X-Gm-Message-State: AOJu0Yw4pfVTJqF0nHBM3e+Fx8r46xCOKQcFcQMTuT3o5ukrivlF1huA
	W8qv8yKiFVJrdczW85JlcNhWpC1kbARktKZubvNroSs09KmaMtlCkLHVIQ/I/HdkSYvZgJAvWQN
	0AEdS6LJbdECc54dv8egHewBeDPTwnWbjEImuw2Xys2sNptaBHLCHIvLTkG3ADzhGYXNhKUxmYj
	f6SXYUPf71GJSIPLJo/nwihfJJBAOxIF+IRnQG+eZd
X-Google-Smtp-Source: AGHT+IFJzkoh2w79YY2G7uU21hfkz80FED0X4UGg87fkUXsPO7qkO/RCEE4WoM3GHcjxmcv7th1ddA==
X-Received: by 2002:a17:902:b696:b0:205:709e:1949 with SMTP id d9443c01a7336-2070a817383mr52725005ad.57.1725811727148;
        Sun, 08 Sep 2024 09:08:47 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f3179fsm21412535ad.258.2024.09.08.09.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 09:08:46 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	kuba@kernel.org,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v2 4/9] netdev-genl: Dump napi_defer_hard_irqs
Date: Sun,  8 Sep 2024 16:06:38 +0000
Message-Id: <20240908160702.56618-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240908160702.56618-1-jdamato@fastly.com>
References: <20240908160702.56618-1-jdamato@fastly.com>
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
 net/core/netdev-genl.c                  | 5 +++++
 tools/include/uapi/linux/netdev.h       | 1 +
 4 files changed, 15 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index cf3e77c6fd5e..e4219bfff08d 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -252,6 +252,13 @@ attribute-sets:
         checks:
           min: 0
           max: s32-max
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
@@ -602,6 +609,7 @@ operations:
             - irq
             - pid
             - index
+            - defer-hard-irqs
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index e06e33acb6fd..bcc95b7ebd92 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -122,6 +122,7 @@ enum {
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
 	NETDEV_A_NAPI_INDEX,
+	NETDEV_A_NAPI_DEFER_HARD_IRQS,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 9561841b9d2d..f1e505ad069f 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -160,6 +160,7 @@ static int
 netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			const struct genl_info *info)
 {
+	int napi_defer_hard_irqs;
 	void *hdr;
 	pid_t pid;
 
@@ -191,6 +192,10 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			goto nla_put_failure;
 	}
 
+	napi_defer_hard_irqs = napi_get_defer_hard_irqs(napi);
+	if (nla_put_s32(rsp, NETDEV_A_NAPI_DEFER_HARD_IRQS, napi_defer_hard_irqs))
+		goto nla_put_failure;
+
 	genlmsg_end(rsp, hdr);
 
 	return 0;
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 43742ac5b00d..43bb1aad9611 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -121,6 +121,7 @@ enum {
 	NETDEV_A_NAPI_ID,
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
+	NETDEV_A_NAPI_DEFER_HARD_IRQS,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
-- 
2.25.1


