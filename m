Return-Path: <netdev+bounces-60084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A1C81D465
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 15:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02D91F21F5C
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 14:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7E5DDBE;
	Sat, 23 Dec 2023 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="IWnVMb+b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46722DDA5
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-67f47b15fa3so19493946d6.1
        for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 06:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703340130; x=1703944930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9o75PhI3xzZFY6wRbm+k1VjTX3cvEH8O/7qf7mb8L+o=;
        b=IWnVMb+bx7gsXKbD8mBZqFansmGCy8QbA/6eQ6xaYMHxk66uqw/ch0T60emkAlx5aE
         aHJGLuPmdvPtfrpojcEyQk4WsQ12ZI4nbbfQ6MLMIzMtBa2GmwJmxF5suYMt31/0H9Th
         5Hgjt6kbD/OVT1nl675IHyTnwDVDjjaOISFJr0au6MqDSP80UYEPxwyDURRySg/GNIHo
         l0U9OUerLZ27DSaluJKtaOgaREh6tcsJ2nlk9eE3L+LT1jPgrQekHrw1k3YNXQ02yx/n
         xp3KoK/pixalD32Kysl0/IjqnN9xoDHjTfmwdwEgnjoT7ndmVtdwN+hHNVOasXs9Q5Ev
         xxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703340130; x=1703944930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9o75PhI3xzZFY6wRbm+k1VjTX3cvEH8O/7qf7mb8L+o=;
        b=cFvxF75fkO7Qol0HQl/DDyM8IIuPeBGQVLZS66FqwqlU/O56WzW+0X95QbjOIuXqxM
         nvNeNvaghQbv0LFRpTGKi8zusCIbnwt4B5KUM2+Sv33mZpurLNwVKZx0vb/slv3zobG3
         XLUWUmCzQAPdj5ULvCzI8SdSndxdAlnCjyQPRis6Rd+HFQv3CgvHEJ786nHpKtDVg8tK
         tVww482meObqCkvNL+GAJPnhmOL/t5q8g8V4XVE19mWZFbibt4SyfTMxi6VZUr2ufjXL
         116sNpADcr0Gdcg0iyv1ETtwiY/GAOzE6/INGyhQide9XSCGP6ai87La+knUiNGL1TcM
         NLWw==
X-Gm-Message-State: AOJu0YyAk0AF1LgIk3DxVjQBjnm7l/RwF2o/0Ua0/7/K+KBaAEXiLDuV
	d67jV8ZDXFpkNL4JKtw35S/RpdP4GfXs
X-Google-Smtp-Source: AGHT+IH7tDwFSbUS2YrlmrJpnhg9GQA6gRYAoI6s59t+cE6qDj6rFPxMnyvpqA3fIlO/2QaOyajkbA==
X-Received: by 2002:a05:6214:2b06:b0:67f:65c1:2a54 with SMTP id jx6-20020a0562142b0600b0067f65c12a54mr4395697qvb.57.1703340130237;
        Sat, 23 Dec 2023 06:02:10 -0800 (PST)
Received: from majuu.waya ([174.91.6.24])
        by smtp.gmail.com with ESMTPSA id 25-20020a05620a04d900b0077f0a4bd3c6sm2062968qks.77.2023.12.23.06.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 06:02:06 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Cc: jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org,
	stephen@networkplumber.org,
	dsahern@gmail.com,
	pctammela@mojatatu.com,
	victor@mojatatu.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net-next 1/5] net/sched: Remove uapi support for rsvp classifier
Date: Sat, 23 Dec 2023 09:01:50 -0500
Message-Id: <20231223140154.1319084-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231223140154.1319084-1-jhs@mojatatu.com>
References: <20231223140154.1319084-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 265b4da82dbf ("net/sched: Retire rsvp classifier") retired the TC RSVP
classifier.
Remove UAPI for it. Iproute2 will sync by equally removing it from user space.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/uapi/linux/pkt_cls.h       | 31 ------------------------------
 tools/include/uapi/linux/pkt_cls.h | 31 ------------------------------
 2 files changed, 62 deletions(-)

diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index c7082cc60d21..0d85f7faad53 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -280,37 +280,6 @@ struct tc_u32_pcnt {
 
 #define TC_U32_MAXDEPTH 8
 
-
-/* RSVP filter */
-
-enum {
-	TCA_RSVP_UNSPEC,
-	TCA_RSVP_CLASSID,
-	TCA_RSVP_DST,
-	TCA_RSVP_SRC,
-	TCA_RSVP_PINFO,
-	TCA_RSVP_POLICE,
-	TCA_RSVP_ACT,
-	__TCA_RSVP_MAX
-};
-
-#define TCA_RSVP_MAX (__TCA_RSVP_MAX - 1 )
-
-struct tc_rsvp_gpi {
-	__u32	key;
-	__u32	mask;
-	int	offset;
-};
-
-struct tc_rsvp_pinfo {
-	struct tc_rsvp_gpi dpi;
-	struct tc_rsvp_gpi spi;
-	__u8	protocol;
-	__u8	tunnelid;
-	__u8	tunnelhdr;
-	__u8	pad;
-};
-
 /* ROUTE filter */
 
 enum {
diff --git a/tools/include/uapi/linux/pkt_cls.h b/tools/include/uapi/linux/pkt_cls.h
index 3faee0199a9b..82eccb6a4994 100644
--- a/tools/include/uapi/linux/pkt_cls.h
+++ b/tools/include/uapi/linux/pkt_cls.h
@@ -204,37 +204,6 @@ struct tc_u32_pcnt {
 
 #define TC_U32_MAXDEPTH 8
 
-
-/* RSVP filter */
-
-enum {
-	TCA_RSVP_UNSPEC,
-	TCA_RSVP_CLASSID,
-	TCA_RSVP_DST,
-	TCA_RSVP_SRC,
-	TCA_RSVP_PINFO,
-	TCA_RSVP_POLICE,
-	TCA_RSVP_ACT,
-	__TCA_RSVP_MAX
-};
-
-#define TCA_RSVP_MAX (__TCA_RSVP_MAX - 1 )
-
-struct tc_rsvp_gpi {
-	__u32	key;
-	__u32	mask;
-	int	offset;
-};
-
-struct tc_rsvp_pinfo {
-	struct tc_rsvp_gpi dpi;
-	struct tc_rsvp_gpi spi;
-	__u8	protocol;
-	__u8	tunnelid;
-	__u8	tunnelhdr;
-	__u8	pad;
-};
-
 /* ROUTE filter */
 
 enum {
-- 
2.34.1


