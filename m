Return-Path: <netdev+bounces-87641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890408A3F4E
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 00:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2526D1F215C0
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 22:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE6F57329;
	Sat, 13 Apr 2024 22:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="TvmtmQmL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD24C56B9E
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713045933; cv=none; b=j3s8afu47rmbSPS1XQlOKTTvc8zyT62nY5mhBR7uBWUorkJb8g0+NYsGL0tPHb1daIwDB/03msYxXD9taVUFCao6dX84G0MuG0WeM1AC39EuD7i7/csclI43PQXroFiOXoU+r/L5YbSHgy5bMfX4U26bygm7mrwA6Uuu/ytVnVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713045933; c=relaxed/simple;
	bh=LSNu5ygi1wErnw72sK40/mBEJoMHFSho8xO5YDgBlm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGZ1xdKVnfH/+DI0pHmzAzpt7vAUeqmZl6YT8zPp+M+xc8bHivyxPFU4pr+nkZk3VoeoGWsEqG4/7TJbTQYwdY/ARknJuGjSRfC6C+iljqREf+R2xfky8EGFdpDuTdyy/YruNWf2uktwCpV3yLW18LH+m48z8kcBEsZl7mlfeAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=TvmtmQmL; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so1184354a12.1
        for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 15:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1713045931; x=1713650731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVH20qj8Zvy4wq8TL+O3ho3KjZhlfthBML53rBGlaAc=;
        b=TvmtmQmL2hD2uLIZpylYEmbpRSJB2B4AtHO9j/lzEgv++FTvMFXFzEiGqT0pXQNIAZ
         QHED5e1Vc1+sM2TTXlivfZ8AmGO5jUpgK5AZRGz1Ve6fElb/g0f+3mA0TbiaCoybiR61
         6j1U2andnuveRsH1HtHVxYO2eFyVojR3XGMsnOmnfFP8BQASwWxQ9L0Yrf5xN8jCvT3r
         JIpxVd32eBq/+TLXabIWneJOUibfdv07exNZJnwHWcAk3neJ9wruRWfyVn5lPsayiGt3
         MdWLcXmbjGK7RowlnU4vBkZKaRn5q9wmXSoa5zOHSBgyAKGWh2JljhS669o2wh0GrkmP
         AgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713045931; x=1713650731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVH20qj8Zvy4wq8TL+O3ho3KjZhlfthBML53rBGlaAc=;
        b=Mh+vKL9nqvt9Y0y7U8WuDNTu0HJk2D1QQg0A0hP6kNsNeq91sf6BV9yxefqgSseRYh
         aBEYBgbOSKaRbdfZNjN+Y2ONuBNLK6mGdtV4rSPR/UwdqJaV8GRT021L+uCFpBseqx+E
         0KHoEaPUwKmOsz/UbjIWZ1+CtXJudpjV4LDhrbmQeOuZvW6ckUV5wKgfcQEvRhLIv8gf
         0AbDiViS9BsOy1c2WjHtmUCcdvAtzlFU9q/G8oQHuZWbwff4HEgyup0ZW7hQ+2xiH13V
         EvKlvJ+9f7KLtQDswuf2s9RNKr9hMJNTSuOPmV16pi3iCekoS5bJx4Xd3KzY3hnUBIss
         Aoyg==
X-Gm-Message-State: AOJu0Yx3Cbgr+xps+mdRg/EM0uM04hHwsLkutEFVZX1BbmyZhI2xx08d
	n/ep6zqLHW3DzI8XWmNTyNPeI8S3T9SdmvnEjChewvqxPZP+37QBYaevIC5isKchIC8ovsfmuAW
	R
X-Google-Smtp-Source: AGHT+IF4WymW3SrJe4++UN3rxm5uRSuJoaGQzoi4KWadde8NFJdR0oXMb18oizNgKcL6AuoSOB91oA==
X-Received: by 2002:a17:902:c40d:b0:1e2:8c26:3264 with SMTP id k13-20020a170902c40d00b001e28c263264mr9052647plk.36.1713045931270;
        Sat, 13 Apr 2024 15:05:31 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902ec9000b001e3fe207a15sm5008082plg.138.2024.04.13.15.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 15:05:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 5/7] tc/util: remove unused argument from print_tcstats2_attr
Date: Sat, 13 Apr 2024 15:04:06 -0700
Message-ID: <20240413220516.7235-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240413220516.7235-1-stephen@networkplumber.org>
References: <20240413220516.7235-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function doesn't use the FILE handle.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/m_action.c | 2 +-
 tc/tc_util.c  | 5 ++---
 tc/tc_util.h  | 3 +--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/tc/m_action.c b/tc/m_action.c
index 6a361f11..feb869a9 100644
--- a/tc/m_action.c
+++ b/tc/m_action.c
@@ -396,7 +396,7 @@ static int tc_print_one_action(FILE *f, struct rtattr *arg, bool bind)
 		print_string(PRINT_FP, NULL, "\tAction statistics:", NULL);
 		print_nl();
 		open_json_object("stats");
-		print_tcstats2_attr(f, tb[TCA_ACT_STATS], "\t", NULL);
+		print_tcstats2_attr(tb[TCA_ACT_STATS], "\t", NULL);
 		close_json_object();
 		print_nl();
 	}
diff --git a/tc/tc_util.c b/tc/tc_util.c
index 133fe9f9..f9151408 100644
--- a/tc/tc_util.c
+++ b/tc/tc_util.c
@@ -708,8 +708,7 @@ static void print_tcstats_basic_hw(struct rtattr **tbs, const char *prefix)
 	print_uint(PRINT_ANY, "hw_packets", " %u pkt", bs_hw.packets);
 }
 
-void print_tcstats2_attr(FILE *fp, struct rtattr *rta,
-			 const char *prefix, struct rtattr **xstats)
+void print_tcstats2_attr(struct rtattr *rta, const char *prefix, struct rtattr **xstats)
 {
 	struct rtattr *tbs[TCA_STATS_MAX + 1];
 
@@ -790,7 +789,7 @@ void print_tcstats_attr(FILE *fp, struct rtattr *tb[], const char *prefix,
 			struct rtattr **xstats)
 {
 	if (tb[TCA_STATS2]) {
-		print_tcstats2_attr(fp, tb[TCA_STATS2], prefix, xstats);
+		print_tcstats2_attr(tb[TCA_STATS2], prefix, xstats);
 		if (xstats && !*xstats)
 			goto compat_xstats;
 		return;
diff --git a/tc/tc_util.h b/tc/tc_util.h
index de908d5e..2d38dd58 100644
--- a/tc/tc_util.h
+++ b/tc/tc_util.h
@@ -91,8 +91,7 @@ char *sprint_linklayer(unsigned int linklayer, char *buf);
 
 void print_tcstats_attr(FILE *fp, struct rtattr *tb[],
 			const char *prefix, struct rtattr **xstats);
-void print_tcstats2_attr(FILE *fp, struct rtattr *rta,
-			 const char *prefix, struct rtattr **xstats);
+void print_tcstats2_attr(struct rtattr *rta, const char *prefix, struct rtattr **xstats);
 
 int get_tc_classid(__u32 *h, const char *str);
 int print_tc_classid(char *buf, int len, __u32 h);
-- 
2.43.0


