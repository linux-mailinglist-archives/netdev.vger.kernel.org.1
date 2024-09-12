Return-Path: <netdev+bounces-127770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A429397666F
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 12:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2576C1F21F67
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 10:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0EE1A0BDC;
	Thu, 12 Sep 2024 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gLcnY742"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D081A0BD4
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135696; cv=none; b=ay90Pc07i8vEt08wzyI6IkC1zyN71YTb3K5dnL9XNfcjQQusekNGe9ox8YDg8baZiUgYlsgx2f5yeUR+3HsK7zWfNHL6aP/p/DdPRhw8mBFoR8Tbab4EQ8VK2bKaiCFbDyxlHUG7rraSP7XDasn/HvQNayI4GL1qSvEB/07vWIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135696; c=relaxed/simple;
	bh=bGa4PmJzGB9kewoC30T211UZN3HCaTEaFMhaE0IBKR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ux8zV+Ds3d+N7uwribCkvt+0AyMO+BVfuaRL0Z45eiTV3hYqiMfVFFcQIwmFfnlPA4syue+jKQwFozKerwKDQCRGXSscsoxxRLD8bRd4Dpno6Fl4p3p+Ny8gZCmnjQPvzmb+Y4aKFJss7ONM/bQFzKgnokZN32oxAl+DpbtpiS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gLcnY742; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fee6435a34so7291335ad.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 03:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726135694; x=1726740494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1ZQwn8/7gDdmGCiwR/rNIphJ/ao5OLIORUttbLlJdI=;
        b=gLcnY742FGT5T5YaEU8pnPyxGguQGytoHSi64lGn0tVv3yNQyH1sJa6b6BYOKUAgKx
         KhUfNlUUDlZJgkKWnQcNqxwaxkQJBL3iCIxd2K/xGYdXXx5jYJGkz5y2ep7qoVIJnmZp
         7AtjL9NUQRAa21gwNHhyLbu6IzQJ8g6y2Krag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726135694; x=1726740494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1ZQwn8/7gDdmGCiwR/rNIphJ/ao5OLIORUttbLlJdI=;
        b=M4QblpF7S2y02SRNgJtPBk+v4eqDWGdlftGyKkI+j/7m8W1NG5Hrf8BTNuQ6stegZ+
         SneftVgOfvj3hwyPTKN8Pe7TiQVoF1/dyg5cUns/OPBRX46zrv4YfMk6tzAGajsftvy+
         WnGgLmpCTVAPB5fO7HzXKRaJTacSVZvkWcIQpcd2WzeWkraSubd3oauLoR+w5ZeYg8Fv
         cdbd+fRrrJ4k+2TGMwEoZmAS6P3I26r8UbrNy46/ax92S2/VP5c1sgBtWAn3F4ckt3qI
         B3FdRYsxyuJJzWnh376uC/OpQMvMEjnw9485EW948nWw/1tmTlUuUq5PPUBCxh+Xl7ZG
         zGFA==
X-Gm-Message-State: AOJu0Yzj3MJVTh9g44q5jUZXsTjVcTG8sue2CDmpmivlsOkKVFl2rTwk
	ZXImWrYKK3Rdxssmyckd/nz9YV+dEfbn2MLYZhrK6PfHDc1/lTrGlTsLyVsyfTKKErWTn3z8Pez
	Y1xa73MmBkOXLM0INdVGXNAXf+C2FAVljrCx6sCzmR6hIs9Q1doorvfgQrulG4hBm0DtP+mLFn0
	XkuwkzABQeDMXlIx47COhF3H01LIfdjZQsYQQ52g==
X-Google-Smtp-Source: AGHT+IGzJodF6HLtBaNWh2wOCh15vOg4b928UX54k0lGLfWvsqPi1igaQRhJqO8yUSbA4RsaQPk/wA==
X-Received: by 2002:a17:902:db01:b0:205:410c:f3c2 with SMTP id d9443c01a7336-2076e3f8983mr35469005ad.41.1726135694147;
        Thu, 12 Sep 2024 03:08:14 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe9da3sm11583795ad.239.2024.09.12.03.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 03:08:13 -0700 (PDT)
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
	Daniel Jurgens <danielj@nvidia.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v3 2/9] netdev-genl: Dump napi_defer_hard_irqs
Date: Thu, 12 Sep 2024 10:07:10 +0000
Message-Id: <20240912100738.16567-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912100738.16567-1-jdamato@fastly.com>
References: <20240912100738.16567-1-jdamato@fastly.com>
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
index 959755be4d7f..351d93994a66 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -244,6 +244,13 @@ attribute-sets:
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
@@ -593,6 +600,7 @@ operations:
             - ifindex
             - irq
             - pid
+            - defer-hard-irqs
       dump:
         request:
           attributes:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 43742ac5b00d..43bb1aad9611 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -121,6 +121,7 @@ enum {
 	NETDEV_A_NAPI_ID,
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
+	NETDEV_A_NAPI_DEFER_HARD_IRQS,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index a17d7eaeb001..e67918dd97be 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -160,6 +160,7 @@ static int
 netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			const struct genl_info *info)
 {
+	u32 napi_defer_hard_irqs;
 	void *hdr;
 	pid_t pid;
 
@@ -188,6 +189,10 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
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


