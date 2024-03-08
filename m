Return-Path: <netdev+bounces-78804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E776C876974
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 18:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 189DFB22415
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 17:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F452D052;
	Fri,  8 Mar 2024 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="pjUCpy5c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646932577B
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918231; cv=none; b=F1CKyAyxbYa3+VZnDNnPdNCuGVTo7TKK/WhQpRkO5maYujy2kKKO23nz6tVPfwBA2xntDqj214xomiXcz6a0LQdFUIcG7+nVjHsKA9ZDPC+VCrWSRN0Z+FN1lufT0eMIU2YqhZ6HW2BVCgQD2hT2qtyr8hIgz9b2CdFbDbokRss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918231; c=relaxed/simple;
	bh=+ZHcsmBIKb0O1ganZhwb8nR8Krt+Q6jkO2p5SZ/MSjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpAyLGkiFMEZboUS6nXChx8vCRTzUXKNc3QFFvpSMyh+0xqzodqM78sYgrXhh1MdA5NTKPNxXy4RDuDF5YfYDGy4yV9sd8+W1MNkfpEIXyOcwG0J6zqRb0wlMQnZOXRpSx6ZUaToRdGbJTBO9ehIKxiflOM5ucq7vgZKdERxiok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=pjUCpy5c; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6082eab17so2152288b3a.1
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 09:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1709918228; x=1710523028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRpEzdy5Gx2FCyyAJ26fT9iVD/nmn4SZHUwFSVpHhTQ=;
        b=pjUCpy5cqxzwM52McqzmduEOed4qWiFihDX9kslui3mAMBx81mubvOQ3SV21XQUq9B
         hBlKZN2ewAhWJJRKFutf9GQxeWBEDBmbLVJ3yxQHXtRgUJXis4sfXXpYAQLL0qDuAej6
         QO3+3VVh9qvxisUzUSMFVCrvHiv5PKWNW7zUo2wn7ZE1JjXNDsRtZfYfkfblCRLfBDUb
         w1TRHrTtT/YQ4VY+cVQuHgPoqN8YvlxpAfTdEkD64enE9C30DtyWadXuXJ55xKetW5Yb
         wv7/iIQWEILxXnSpNC9uC1KjWkFIg2dB78kWGIXO0N665c9lSlvaj0ncmmL9Uw5eR934
         Sqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709918228; x=1710523028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRpEzdy5Gx2FCyyAJ26fT9iVD/nmn4SZHUwFSVpHhTQ=;
        b=JyMlLEGW9FSSCMHgjIgQpFemgb+0Lq55SshW/y7zy+Wk5AXBCk5bvr8lUZQs1wd8gU
         RC7Ln2FS60bwA3RUCGE2imSefKoHhhM2+4I/AQd5rGqdJE8a+fhtVJYR5oIRBLU+keTY
         KfLMv+uOgZCjqyVQuJhaZ18cqEhAccYCMCwy4ZsLmYLBkp2O6QIx27wz65DK/kCAxO+V
         HZLFdGOh8Bb9QVua5/y1f9ywhSUm8zoLcin/GEQYOj8vehDZAuMfw5KoGQkVQm9DHW8s
         NC05mslg9zCLsDNVihmZ6IO/t7XcarqughBmUGW4WPihU4PcEhZkklpoMs4N0t9EDIFS
         l34g==
X-Gm-Message-State: AOJu0Yx8H9J+h7TDAc2V60/ngAPxCvNQ2vhe8p/iI08rNQqFwJoZrypi
	GckLoF7CrqsgL8EiDAhsNPCt7HoAnu4QBV07blLPdAAn4pzue2ezr7AVC1Zpm7gepJaWIw3eFgx
	usRo=
X-Google-Smtp-Source: AGHT+IEWfMxFngaP+nYfCKQbYtQfnuambWKmF+a4+RG0BLhRY4WxSNqrt6mN4m6NRJv9/XkX7XM3ng==
X-Received: by 2002:a05:6a00:2354:b0:6e5:80a4:2ff2 with SMTP id j20-20020a056a00235400b006e580a42ff2mr24606703pfj.30.1709918228093;
        Fri, 08 Mar 2024 09:17:08 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id r8-20020aa79ec8000000b006e50cedb59bsm14771413pfq.16.2024.03.08.09.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:17:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 3/3] tc: remove no longer used helpers
Date: Fri,  8 Mar 2024 09:16:01 -0800
Message-ID: <20240308171656.9034-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240308171656.9034-1-stephen@networkplumber.org>
References: <20240308171656.9034-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The removal of tick usage in netem, means that some of the
helper functions in tc are no longer used and can be safely removed.
Other functions can be made static.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/tc_core.c | 15 +++------------
 tc/tc_core.h |  2 --
 tc/tc_util.c |  5 -----
 tc/tc_util.h |  1 -
 4 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/tc/tc_core.c b/tc/tc_core.c
index 871ceb45ff58..37547e9b3395 100644
--- a/tc/tc_core.c
+++ b/tc/tc_core.c
@@ -23,23 +23,14 @@
 static double tick_in_usec = 1;
 static double clock_factor = 1;
 
-int tc_core_time2big(unsigned int time)
+static unsigned int tc_core_time2tick(unsigned int time)
 {
-	__u64 t = time;
-
-	t *= tick_in_usec;
-	return (t >> 32) != 0;
-}
-
-
-unsigned int tc_core_time2tick(unsigned int time)
-{
-	return time*tick_in_usec;
+	return time * tick_in_usec;
 }
 
 unsigned int tc_core_tick2time(unsigned int tick)
 {
-	return tick/tick_in_usec;
+	return tick / tick_in_usec;
 }
 
 unsigned int tc_core_time2ktime(unsigned int time)
diff --git a/tc/tc_core.h b/tc/tc_core.h
index 6dab2727d199..7a986ac27a44 100644
--- a/tc/tc_core.h
+++ b/tc/tc_core.h
@@ -12,8 +12,6 @@ enum link_layer {
 };
 
 
-int  tc_core_time2big(unsigned time);
-unsigned tc_core_time2tick(unsigned time);
 unsigned tc_core_tick2time(unsigned tick);
 unsigned tc_core_time2ktime(unsigned time);
 unsigned tc_core_ktime2time(unsigned ktime);
diff --git a/tc/tc_util.c b/tc/tc_util.c
index aa7cf60faa6d..c293643dc80d 100644
--- a/tc/tc_util.c
+++ b/tc/tc_util.c
@@ -257,11 +257,6 @@ tc_print_rate(enum output_type t, const char *key, const char *fmt,
 	print_rate(use_iec, t, key, fmt, rate);
 }
 
-char *sprint_ticks(__u32 ticks, char *buf)
-{
-	return sprint_time(tc_core_tick2time(ticks), buf);
-}
-
 int get_size_and_cell(unsigned int *size, int *cell_log, char *str)
 {
 	char *slash = strchr(str, '/');
diff --git a/tc/tc_util.h b/tc/tc_util.h
index 623d9888a5ad..b7b9a097acd3 100644
--- a/tc/tc_util.h
+++ b/tc/tc_util.h
@@ -86,7 +86,6 @@ void tc_print_rate(enum output_type t, const char *key, const char *fmt,
 void print_devname(enum output_type type, int ifindex);
 
 char *sprint_tc_classid(__u32 h, char *buf);
-char *sprint_ticks(__u32 ticks, char *buf);
 char *sprint_linklayer(unsigned int linklayer, char *buf);
 
 void print_tcstats_attr(FILE *fp, struct rtattr *tb[],
-- 
2.43.0


