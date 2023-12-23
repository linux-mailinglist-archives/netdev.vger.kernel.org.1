Return-Path: <netdev+bounces-60086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5680581D467
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 15:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147E82832F8
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 14:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8645AD53C;
	Sat, 23 Dec 2023 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Z1TyKPN+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2341DDF63
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7812275feccso170545085a.3
        for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 06:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703340136; x=1703944936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eq6geVqGvMFNSbq2e7VJ8wt0agz2scAL9ywNSevz4mM=;
        b=Z1TyKPN+2iAyZRaV2RafBLgKqsOKdybrwjj5irmo7y/YmpNoS0LBpCoFFkUTZYxX+N
         rP4PvtJYHGEY68brJAWlaxU35ZPoPWzQykZxZal+6FMLA6iJ105cMl7mlrjl2qFiMzUe
         UINOWSAsX6eQByPM13jWzwrRYq0HybKXjpdPFnZZVktJ86WghmnVVummLHKUHkuKBbf8
         1HztrXgah/qOPzEF2OO6O1ftCxFeqOIlrmpyh/9V4OwPAS6w0GMcAy7POG94lrLvy654
         Hs+V228oInBwyYz9esLhvbwUPkERuYGfd2VCgO+k3XdYOo63nJ54fKbACOTAWdnRI3Y4
         17iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703340136; x=1703944936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eq6geVqGvMFNSbq2e7VJ8wt0agz2scAL9ywNSevz4mM=;
        b=J4dpipIsW1yfnrUwSIHGvVwJgL3vs4YfmBTJAg6hWHSMiPny//6hpG4+xhzG1+CjIc
         80rppqoTO2eHDkauILUcvvn1r7SNkXo7964Gk4oo0bx49+R2o8T5p3pk8xCGNomgJtp/
         cynkvYpbT3f3T8OExK86TVWMocufoI1j0AnyVYjcJ7Ry+Q0LTemlSwejR0kOz3rJSWrl
         LcdLaAr0j+KkahrR//ojh5qQFpSlGlEeS9iyVz6Sl7ysiRGAYQV6NRiOya7Gf/JfuVgi
         MdLt9E0K+4CCMsC88QB5pWDmSXLgq7JfwQnykP5k4h4HVk2L80HZweM/ivK/Bnae85O6
         PUBw==
X-Gm-Message-State: AOJu0YzmBFEngKQRLfdGCxS/2b9bn36wOwcIQ6xLSnlwHyDnhZ8fCh/B
	oMU9SqnLs9rPp4ctZPr5dAggFsHKhxQO
X-Google-Smtp-Source: AGHT+IEkVihpRw5nIkicPWRaH9cOooLRnOWkuyFqkqk1bkamIweDb2BeJt6+iuOdQ6bfLcGK3LvJeA==
X-Received: by 2002:a05:620a:4556:b0:781:32c2:d578 with SMTP id u22-20020a05620a455600b0078132c2d578mr2360709qkp.143.1703340136148;
        Sat, 23 Dec 2023 06:02:16 -0800 (PST)
Received: from majuu.waya ([174.91.6.24])
        by smtp.gmail.com with ESMTPSA id 25-20020a05620a04d900b0077f0a4bd3c6sm2062968qks.77.2023.12.23.06.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 06:02:13 -0800 (PST)
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
Subject: [PATCH net-next 3/5] net/sched: Remove uapi support for dsmark qdisc
Date: Sat, 23 Dec 2023 09:01:52 -0500
Message-Id: <20231223140154.1319084-4-jhs@mojatatu.com>
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

Commit bbe77c14ee61 ("net/sched: Retire dsmark qdisc") retired the dsmark
classifier. Remove UAPI support for it.
Iproute2 will sync by equally removing it from user space.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/uapi/linux/pkt_sched.h       | 14 --------------
 tools/include/uapi/linux/pkt_sched.h | 14 --------------
 2 files changed, 28 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index f762a10bfb78..1e3a2b9ddf7e 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -557,20 +557,6 @@ enum {
 
 #define TCA_CBQ_MAX	(__TCA_CBQ_MAX - 1)
 
-/* dsmark section */
-
-enum {
-	TCA_DSMARK_UNSPEC,
-	TCA_DSMARK_INDICES,
-	TCA_DSMARK_DEFAULT_INDEX,
-	TCA_DSMARK_SET_TC_INDEX,
-	TCA_DSMARK_MASK,
-	TCA_DSMARK_VALUE,
-	__TCA_DSMARK_MAX,
-};
-
-#define TCA_DSMARK_MAX (__TCA_DSMARK_MAX - 1)
-
 /* ATM  section */
 
 enum {
diff --git a/tools/include/uapi/linux/pkt_sched.h b/tools/include/uapi/linux/pkt_sched.h
index 5c903abc9fa5..0f164f1458fd 100644
--- a/tools/include/uapi/linux/pkt_sched.h
+++ b/tools/include/uapi/linux/pkt_sched.h
@@ -537,20 +537,6 @@ enum {
 
 #define TCA_CBQ_MAX	(__TCA_CBQ_MAX - 1)
 
-/* dsmark section */
-
-enum {
-	TCA_DSMARK_UNSPEC,
-	TCA_DSMARK_INDICES,
-	TCA_DSMARK_DEFAULT_INDEX,
-	TCA_DSMARK_SET_TC_INDEX,
-	TCA_DSMARK_MASK,
-	TCA_DSMARK_VALUE,
-	__TCA_DSMARK_MAX,
-};
-
-#define TCA_DSMARK_MAX (__TCA_DSMARK_MAX - 1)
-
 /* ATM  section */
 
 enum {
-- 
2.34.1


