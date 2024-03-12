Return-Path: <netdev+bounces-79577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66988879F20
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 23:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215231F22F9A
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 22:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903D43BB43;
	Tue, 12 Mar 2024 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="IXu/nBnr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D7D2B2D7
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710284109; cv=none; b=EbJjpq9eoXPkxVKTyjcUXK4519/GZqKOUEPWeKyX0pNvdXYGNnHP6KrhqTeQUXbCzaW+QTXsWaL2XsAv9ZAw1F8SgGbHEQfBgEkJRolOWJ7Ktil/FuEzqQGwYRarj4uzFrMzZwqOmWYVVh/4jIEZYD8639L8fPhV6/0vyUGL4X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710284109; c=relaxed/simple;
	bh=D17CfyLCkdZYZDTyILrmsyr0JuPNALsjc5fjrsMLRX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBomzX6s0kBuUKykTmo7rQ3+AWmtMWBvahMXf2urBPfZVj1iVhmwZY5aeEaN/y7NPs5oxbitk41d+6Kw2JHZ26ebnXeQI9zpttDUJzfldJ6T0iGk4Y0GoEWRjJuWLlkSegtDIkYIw1EeznzXwfaOmi7cYjPxhhpqRGL5MM92kPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=IXu/nBnr; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e5eaf5bb3eso4835351b3a.3
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 15:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710284107; x=1710888907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VW6qWmOMedufGlnAxm3HMyqlGBbwwKJdDG+kzVaEuHA=;
        b=IXu/nBnrOMlwLR75FodGPLr6uIIOu0YrRuM0OhhVHw7vhkl35D9WSb9rgsIt8dzJrG
         Zk3AyKOT/bdjlwnsMYavAlZjYPt5CJDcP2yJkwG4+SS1w0WamiA+PMT9sn6C/aq1VRbu
         NbdpmwEN8BgEeUG6PhMLU1k2VqXuzrmsBkifusl3xOic4cPifOc0uG3ZYp09gvDdXsuH
         no8+7yT//FBT3EHx6jZn0ltlB2bsi9HfOrnqp3YHfAYcLNhRM58w9mMEE1Mr4Zu5VqNH
         yUMSj/kdniLdNnarEgTl6GvNv0QT4hFZhpTK98aw/S3u60w362BS9kSETCVpKeeQ8Nl6
         DSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710284107; x=1710888907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VW6qWmOMedufGlnAxm3HMyqlGBbwwKJdDG+kzVaEuHA=;
        b=j5+sVQqfKucAeYPSR/rJSvqaKnunu0Nh4xgwaT6ICLt1+UcRuJrOnWgubBAvbp6QN0
         uZROroBvzQr2nLuwqYJ3gusU47jfQeDtkWmSkunTuClYzgQxcIZRRXrLxR+qLJCkfbqx
         g9uWF5hHpzkciFY/Zd9fBZjOAfW0ZSGaJoFjY1Ck30fJt3gx8Qee5SLgcheAo5m7AVeX
         H3Qv1ERB/fu4nKvmtN6szEWKAnN2LSEEusnQEZ2ISFquKQ12J1mmIb23vmPpyHKfDoP+
         XuVczXQGGSpHY6/oMmbnLthPySxXfpUh8KphRdGlNKNRLLQQXWki5NXzAs0qVzuZWqiN
         cqhg==
X-Gm-Message-State: AOJu0Yy9z1vB4loFklMPODwqLK9TvzthPxt0Q0V6/JEvFEqHhM2AXDSk
	IiKxsXwZIlRxIjYsj1p1/BZm8GWMbxkFWZ0MeMuiyDxspSEj/hoOuoL2jvNVwe0iVKPOm+sDbIQ
	b
X-Google-Smtp-Source: AGHT+IFPmg+qYMe3b0ngt2qfACkX16cIMDV8IKatl5m1ItbFPlwXb5W7LgDzYxh10iTpvMcv7Ls5pg==
X-Received: by 2002:a05:6a20:daa0:b0:1a1:7257:6302 with SMTP id iy32-20020a056a20daa000b001a172576302mr3537513pzb.4.1710284107012;
        Tue, 12 Mar 2024 15:55:07 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090a8b0800b0029bb8ebdc23sm98947pjn.37.2024.03.12.15.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:55:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 1/5] tc: support JSON for legacy stats
Date: Tue, 12 Mar 2024 15:53:28 -0700
Message-ID: <20240312225456.87937-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240312225456.87937-1-stephen@networkplumber.org>
References: <20240312225456.87937-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extended stats already supported JSON output, add to the
legacy stats as well.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/tc_util.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/tc/tc_util.c b/tc/tc_util.c
index aa7cf60faa6d..615e3e9cc377 100644
--- a/tc/tc_util.c
+++ b/tc/tc_util.c
@@ -804,28 +804,30 @@ void print_tcstats_attr(FILE *fp, struct rtattr *tb[], const char *prefix,
 		memcpy(&st, RTA_DATA(tb[TCA_STATS]),
 		       MIN(RTA_PAYLOAD(tb[TCA_STATS]), sizeof(st)));
 
-		fprintf(fp,
-			"%sSent %llu bytes %u pkts (dropped %u, overlimits %u) ",
-			prefix, (unsigned long long)st.bytes,
-			st.packets, st.drops, st.overlimits);
+		print_string(PRINT_FP, NULL, "%s", prefix);
+		print_lluint(PRINT_ANY, "bytes", "Sent %llu bytes",
+			     (unsigned long long)st.bytes);
+		print_uint(PRINT_ANY, "packets", " %u pkts", st.packets);
+		print_uint(PRINT_ANY, "dropped", " (dropped %u,", st.drops);
+		print_uint(PRINT_ANY, "overlimits", " overlimits %u) ", st.overlimits);
 
 		if (st.bps || st.pps || st.qlen || st.backlog) {
-			fprintf(fp, "\n%s", prefix);
+			print_nl();
+			print_string(PRINT_FP, NULL, "%s", prefix);
+
 			if (st.bps || st.pps) {
-				fprintf(fp, "rate ");
+				print_string(PRINT_FP, NULL, "rate ", NULL);
 				if (st.bps)
-					tc_print_rate(PRINT_FP, NULL, "%s ",
-						      st.bps);
+					tc_print_rate(PRINT_ANY, "rate", "%s ", st.bps);
 				if (st.pps)
-					fprintf(fp, "%upps ", st.pps);
+					print_uint(PRINT_ANY, "pps", "%upps ", st.pps);
 			}
 			if (st.qlen || st.backlog) {
-				fprintf(fp, "backlog ");
+				print_string(PRINT_FP, NULL, "backlog ", NULL);
 				if (st.backlog)
-					print_size(PRINT_FP, NULL, "%s ",
-						   st.backlog);
+					print_size(PRINT_ANY, "backlog", "%s ", st.backlog);
 				if (st.qlen)
-					fprintf(fp, "%up ", st.qlen);
+					print_uint(PRINT_ANY, "qlen", "%up ", st.qlen);
 			}
 		}
 	}
-- 
2.43.0


