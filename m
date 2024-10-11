Return-Path: <netdev+bounces-134653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236A599AB60
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40702832F1
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCBF1D0E2E;
	Fri, 11 Oct 2024 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ZgSUi6K+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11211D0E14
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672349; cv=none; b=UTdh8AtEvfk/AOGYgScH1zT1Ke3BtF1M7TM844cFSpzTcP1L3+nW9EuwmTd0sd38F33zOKDIy6vvRSF/wc4twPhxp4VBrwssZ+Jy6jNL60lzDwQfUGbl8faJuh1RQDpmBx74dstJhs8e0Ck757McQW9LjA7VHeJfhnGkVEaDGe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672349; c=relaxed/simple;
	bh=q+b9jZGAidjuh8GtSlIIKJ1LqbGOzaugQLHfnQm1lqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aUmBq3QnhB7IRlDNptPX6sUa9kFRjTCC5eDapvujNa92A79NUnLaLSTjNlRn9LXUMtfXo1Oaddoo0O66R/g+D6HGJBn7MlX6GOte6HmFLMoEuoHfxKUpKDPOWkEN9ThlntsLdiZ9O34yG6n4Bp8AMgDXO4GNct7Ue5YHISR3BgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ZgSUi6K+; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2cc469c62so1668836a91.2
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 11:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728672346; x=1729277146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXIej0C4eoHUHQ4nEdeNbNdLeJSUvgnrgxPSPMx1EiE=;
        b=ZgSUi6K+fg/sFQvrgP4gqFZWja7bxeRtBjGIIsSYjz8p0bbbRpKi4XeAUlLVNNjkzR
         9ha4BKc8FTRCLUGKEUoXjOM+FuuS0GZ466Jo6Q0LlOEYtfKaFnrgaCIFbtsSs9HrUQmJ
         FELVyiIjfwI/LwPBoQJBMFCDN0dSs/dOM15tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672346; x=1729277146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXIej0C4eoHUHQ4nEdeNbNdLeJSUvgnrgxPSPMx1EiE=;
        b=qivdbBltD8DekUib2ADt2FZ4zrDptDZuqEaSfavVNA27fDYXD0KmnpXpBAI6N5ggZb
         kQwL5Wq7xFDjMGeTpoIoEFWbu+P+Fb+ggNxpFjbr7MJoBXq9rdyuLag113KWlEDq+1Mq
         PdK4IaAy7KriM48P988/wuiy4upusBCTDkcj/NcZ6ihD4irCePFBboHtNfd4Wz73CspU
         2HyrdfdLXXAPJHsCgbvQW0iMsyN0U7ygTmrXyqHHx3zbZxMrGysUf7rL/k5KhQXsAS/7
         Q+2bMUoWj1KzDaZAX8xJDguZoovRiN2fW7CY5R7Xs4kuvaY3b6Enj7BaLtdR0E4ssfUR
         mNEg==
X-Gm-Message-State: AOJu0Yx1Ioe+UCTDNAc7i4DXUzUugy849RqfTsaZnxSCHAFJdtFg2X7l
	lHF98+/8Y4Rodnpz3GoGDmsimjl/70vIRuh5Z5yTP/gLIHITGQTrYHTGAqslnjmBJ8gyvolnpaL
	7JCna2piGVzStf1tEEQeVobamG0vKuCuvg8FV3uxznDo2KVYmsig5mjXnfeLwjpLPlntzKlpR33
	V0W/b9S7OGgRnrxLoc4AFDemOxidvaEHrrhdE=
X-Google-Smtp-Source: AGHT+IFnsyEs1/CwI3pWxWqWY7TURNss9/odTFhLrbhqMJEXea7TzszaE0iBWvpXWaM9N7sLxA6ERg==
X-Received: by 2002:a17:90b:4ac3:b0:2e2:e2f8:104 with SMTP id 98e67ed59e1d1-2e3152b0097mr445535a91.8.1728672346549;
        Fri, 11 Oct 2024 11:45:46 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e30d848e1csm687625a91.42.2024.10.11.11.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:45:46 -0700 (PDT)
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
Subject: [net-next v6 2/9] netdev-genl: Dump napi_defer_hard_irqs
Date: Fri, 11 Oct 2024 18:44:57 +0000
Message-Id: <20241011184527.16393-3-jdamato@fastly.com>
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

Support dumping defer_hard_irqs for a NAPI ID.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
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
index 358cba248796..f98e5d1d0d21 100644
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


