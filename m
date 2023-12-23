Return-Path: <netdev+bounces-60087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 898F581D468
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 15:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED931F21D7E
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 14:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8A5E569;
	Sat, 23 Dec 2023 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="roNN+wy8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4793BDF60
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7811b05d23bso190514585a.0
        for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 06:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703340137; x=1703944937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAGo65pNUCy+KMKD4r5DVW7p890G53cgas3s/t7q3qM=;
        b=roNN+wy8uBD5tgZ1PXo1fTKJKXNHn5U3rDW82iKwyABMEh28n7RoMCgt9+sEfib30w
         /Bu6+rMtpJSgBpcq/j6H8BGxVcaoDbwJN74XcOFoLyyT7PMoEi+8zOHJWS/8ve2j7qNO
         20P2+AwC2tkgnCBWM57caXXrWGlkd+LxtzmG/zSNpGhocdbQpX2MqVlcT+9MsXfs0URO
         UWntGDmLsbJ73vbIOpQhdsDgIbRbA2gn37DR7SBVkeS3uLOFsFSyQQIyjI6IqaLlpSPD
         tJyEPXu4z7Dkz1/JeL8q7mM/agrEhTkhTsn5WgYYCi8ySvTqM1wsgsQhv16vK3DxlbIW
         ClaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703340137; x=1703944937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAGo65pNUCy+KMKD4r5DVW7p890G53cgas3s/t7q3qM=;
        b=q7Kqa5D5z1dS1d3tcb+X28xPh7RsDVQq7qHSzUY0SdC3VyC+hmsuJBiyOgGVh8uy0l
         DrK6VxtOaMHaBVp7O5LGG2Kc4LmZ8WMK/FLru3STGMN5Sclj9dVTg0DshPyep5uGPR8y
         yzhe8n6jLXN6BHwjVz6MbL/t2yzfvnSuBBtcj1tBHfDW6dXi3Y+FtZzcvJFH66M+2xss
         t7GXoJmIV/xNVsJsPhHpGfFPbQnqNy4FpEuaMIOS/GC2CGruRgfuehf0HgI0LpcKORMI
         TRN/ONS/gAuoVXoyPiYOBXIXZ7U7SumC2wLV/PG4j/RfDtOJ+OpFEqla/gdijvj8b+cO
         j7Gg==
X-Gm-Message-State: AOJu0Yw6uBJDV6MDG5eZe/AA8F0lFjTZkP6TZPmvF7vaIbyj9+VXN/aH
	OtDLUrQH7ItFg/kLxKzS3xRn7cVU1Kjz
X-Google-Smtp-Source: AGHT+IFJDh8N6q8ip69vEs4S3phGnXvF9MdlhI4NRUxuASwAYJxhnoZlm9miPhZe3PHMJ0/cWh0Q2w==
X-Received: by 2002:a05:620a:5598:b0:77f:b2ab:3f34 with SMTP id vq24-20020a05620a559800b0077fb2ab3f34mr3275101qkn.48.1703340137340;
        Sat, 23 Dec 2023 06:02:17 -0800 (PST)
Received: from majuu.waya ([174.91.6.24])
        by smtp.gmail.com with ESMTPSA id 25-20020a05620a04d900b0077f0a4bd3c6sm2062968qks.77.2023.12.23.06.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 06:02:16 -0800 (PST)
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
Subject: [PATCH net-next 4/5] net/sched: Remove uapi support for ATM qdisc
Date: Sat, 23 Dec 2023 09:01:53 -0500
Message-Id: <20231223140154.1319084-5-jhs@mojatatu.com>
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

Commit fb38306ceb9e ("net/sched: Retire ATM qdisc") retired the ATM qdisc.
Remove UAPI for it. Iproute2 will sync by equally removing it from user space.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/uapi/linux/pkt_sched.h       | 15 ---------------
 tools/include/uapi/linux/pkt_sched.h | 15 ---------------
 2 files changed, 30 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 1e3a2b9ddf7e..28f08acdad52 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -557,21 +557,6 @@ enum {
 
 #define TCA_CBQ_MAX	(__TCA_CBQ_MAX - 1)
 
-/* ATM  section */
-
-enum {
-	TCA_ATM_UNSPEC,
-	TCA_ATM_FD,		/* file/socket descriptor */
-	TCA_ATM_PTR,		/* pointer to descriptor - later */
-	TCA_ATM_HDR,		/* LL header */
-	TCA_ATM_EXCESS,		/* excess traffic class (0 for CLP)  */
-	TCA_ATM_ADDR,		/* PVC address (for output only) */
-	TCA_ATM_STATE,		/* VC state (ATM_VS_*; for output only) */
-	__TCA_ATM_MAX,
-};
-
-#define TCA_ATM_MAX	(__TCA_ATM_MAX - 1)
-
 /* Network emulator */
 
 enum {
diff --git a/tools/include/uapi/linux/pkt_sched.h b/tools/include/uapi/linux/pkt_sched.h
index 0f164f1458fd..fc695429bc59 100644
--- a/tools/include/uapi/linux/pkt_sched.h
+++ b/tools/include/uapi/linux/pkt_sched.h
@@ -537,21 +537,6 @@ enum {
 
 #define TCA_CBQ_MAX	(__TCA_CBQ_MAX - 1)
 
-/* ATM  section */
-
-enum {
-	TCA_ATM_UNSPEC,
-	TCA_ATM_FD,		/* file/socket descriptor */
-	TCA_ATM_PTR,		/* pointer to descriptor - later */
-	TCA_ATM_HDR,		/* LL header */
-	TCA_ATM_EXCESS,		/* excess traffic class (0 for CLP)  */
-	TCA_ATM_ADDR,		/* PVC address (for output only) */
-	TCA_ATM_STATE,		/* VC state (ATM_VS_*; for output only) */
-	__TCA_ATM_MAX,
-};
-
-#define TCA_ATM_MAX	(__TCA_ATM_MAX - 1)
-
 /* Network emulator */
 
 enum {
-- 
2.34.1


