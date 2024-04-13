Return-Path: <netdev+bounces-87638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF458A3F4C
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 00:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26DE1F21789
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 22:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A3F56B8E;
	Sat, 13 Apr 2024 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="SkFm3JX2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5B856B69
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713045931; cv=none; b=EsaaCW18uDl6++krzO5J3o5+b+zvkLmQxNXLNyMpouTit3GdUR1utGcE1fl8jTDzQN3DQCEiwIzfR7vs/K8ADKmPhhkhaJNAfEto7bH5pJhgow/XA8p4q1vNvuuXenxNrkEMmR4nwbH4bGMbtCQndeFIy8fX84yAsCwryUmUDpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713045931; c=relaxed/simple;
	bh=KdeV1kYDuRsVYgYBjLJ8A03xJofGS+/z4NHigM7ezaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSa9JVC8Z9sZOC5lIGMDGZVhTyCn2Hxkws5q8nRZe3SHA6TvH3d7xVb99sgVmNkBsGThYvLA2zSmC9TRuCdy9ovitWmvN/yLHOBkmn6Dcs8S51+EeqjOj/x20i85HJpth0kolDvNzAiHUZldbalRlfU6Rcib4w4lThsSIsd/Tlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=SkFm3JX2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e411e339b8so16044025ad.3
        for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 15:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1713045929; x=1713650729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bnz0SHCH34wJqsNY0aYKG8143htnBJpUOYFCrCUHe2M=;
        b=SkFm3JX2SPrky1WgwAYOHOAB6tIbamDzSudT2kAEqQVszSNxtMqo6em7/1+M+861Kz
         QX/TESpUDwe9ReoTrSB0TF6+A30U3ukxPstAzeU2CDce+/f5sNThWNFLdq0wWl9e3Hsx
         Btu5zp/ooFAdPPnuggj0LruQbiHSgAfTVTqAcXo4xyC1qRXXIZrLmmitNCpVHexq6ijj
         LtWZNg8bVaNekc+AyB/IgLVL++4hbpY7Rhwi86NPEm4xen+gCoycU8+cDweP9MTlZOtg
         y3kOvk5l07i3s2mRWuMDNA9GwQCJpa2z6ApRBjIzQQvuvLlFTZ7sKx7qCHW5PiI0w8xr
         O1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713045929; x=1713650729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bnz0SHCH34wJqsNY0aYKG8143htnBJpUOYFCrCUHe2M=;
        b=lc8qCPVYnHXbLyqb4Nyq87NMt2bSdRY3iz3VDZLRHtpe6JpeONgg2zRrZEw7/LONXd
         ZcOJLmW2XPXpVZb/SwavDX2hH7aCApueTsQ++qlYyhfCJiLf2qTXNQ0tavhu8aIFCGc8
         s6z99tZ4aLraqkyXvHH8k49Q1OSpRHzbI1Td52GlC78JFkz12nG/L/SjnlU3IrYMK9DV
         epLQNw3EndrqS+jMMrL7Ynpm4FAlIU5fTIvSfAabOIhvcvDyk3nhOf4weiMbYNvb7HiO
         c017w/iKBlFg6uXmVBsNzP5myqpeplm875SWHV7O4Q1XiRyDv8dzB2yZiEJIeBtZ11f1
         pvDA==
X-Gm-Message-State: AOJu0YyANoI1j7MjCsWSul03TeU73jbba6RSbqDYSvTW/i9zGqi7oOat
	F5WKqpbjEYHvUunTDFgcyJ0wQl7T9mSMg+iwm0Lws92FxYwC1eCwwivQ6dcxDS5WUc61VKP25ds
	O
X-Google-Smtp-Source: AGHT+IEUBOKaYf5EAkHNKovfVBv2OgdII8V7NpPs68mYBdgxnJpL7QvOXRRlb4xbLseVVBDxDholCw==
X-Received: by 2002:a17:902:b104:b0:1e5:3d8a:75fd with SMTP id q4-20020a170902b10400b001e53d8a75fdmr5888007plr.69.1713045928963;
        Sat, 13 Apr 2024 15:05:28 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902ec9000b001e3fe207a15sm5008082plg.138.2024.04.13.15.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 15:05:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 2/7] tc/util: remove unused argument from print_tm
Date: Sat, 13 Apr 2024 15:04:03 -0700
Message-ID: <20240413220516.7235-3-stephen@networkplumber.org>
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

File argument no longer used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/m_bpf.c        | 2 +-
 tc/m_connmark.c   | 2 +-
 tc/m_csum.c       | 2 +-
 tc/m_ct.c         | 2 +-
 tc/m_ctinfo.c     | 2 +-
 tc/m_gact.c       | 2 +-
 tc/m_gate.c       | 2 +-
 tc/m_ife.c        | 2 +-
 tc/m_mirred.c     | 2 +-
 tc/m_mpls.c       | 2 +-
 tc/m_nat.c        | 2 +-
 tc/m_pedit.c      | 2 +-
 tc/m_police.c     | 2 +-
 tc/m_sample.c     | 2 +-
 tc/m_simple.c     | 2 +-
 tc/m_skbedit.c    | 2 +-
 tc/m_skbmod.c     | 2 +-
 tc/m_tunnel_key.c | 2 +-
 tc/m_vlan.c       | 2 +-
 tc/tc_util.c      | 2 +-
 tc/tc_util.h      | 2 +-
 21 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/tc/m_bpf.c b/tc/m_bpf.c
index da50c05e..5cae51ba 100644
--- a/tc/m_bpf.c
+++ b/tc/m_bpf.c
@@ -200,7 +200,7 @@ static int bpf_print_opt(struct action_util *au, FILE *f, struct rtattr *arg)
 		if (tb[TCA_ACT_BPF_TM]) {
 			struct tcf_t *tm = RTA_DATA(tb[TCA_ACT_BPF_TM]);
 
-			print_tm(f, tm);
+			print_tm(tm);
 		}
 	}
 
diff --git a/tc/m_connmark.c b/tc/m_connmark.c
index 8506d95a..bd388665 100644
--- a/tc/m_connmark.c
+++ b/tc/m_connmark.c
@@ -123,7 +123,7 @@ static int print_connmark(struct action_util *au, FILE *f, struct rtattr *arg)
 		if (tb[TCA_CONNMARK_TM]) {
 			struct tcf_t *tm = RTA_DATA(tb[TCA_CONNMARK_TM]);
 
-			print_tm(f, tm);
+			print_tm(tm);
 		}
 	}
 	print_nl();
diff --git a/tc/m_csum.c b/tc/m_csum.c
index f5fe8f55..966ae18e 100644
--- a/tc/m_csum.c
+++ b/tc/m_csum.c
@@ -213,7 +213,7 @@ print_csum(struct action_util *au, FILE *f, struct rtattr *arg)
 		if (tb[TCA_CSUM_TM]) {
 			struct tcf_t *tm = RTA_DATA(tb[TCA_CSUM_TM]);
 
-			print_tm(f, tm);
+			print_tm(tm);
 		}
 	}
 	print_nl();
diff --git a/tc/m_ct.c b/tc/m_ct.c
index 8c471489..95098c88 100644
--- a/tc/m_ct.c
+++ b/tc/m_ct.c
@@ -534,7 +534,7 @@ static int print_ct(struct action_util *au, FILE *f, struct rtattr *arg)
 		if (tb[TCA_CT_TM]) {
 			struct tcf_t *tm = RTA_DATA(tb[TCA_CT_TM]);
 
-			print_tm(f, tm);
+			print_tm(tm);
 		}
 	}
 	print_nl();
diff --git a/tc/m_ctinfo.c b/tc/m_ctinfo.c
index 996a3621..606ab280 100644
--- a/tc/m_ctinfo.c
+++ b/tc/m_ctinfo.c
@@ -166,7 +166,7 @@ static void print_ctinfo_stats(FILE *f, struct rtattr *tb[TCA_CTINFO_MAX + 1])
 	if (tb[TCA_CTINFO_TM]) {
 		tm = RTA_DATA(tb[TCA_CTINFO_TM]);
 
-		print_tm(f, tm);
+		print_tm(tm);
 	}
 
 	if (tb[TCA_CTINFO_STATS_DSCP_SET])
diff --git a/tc/m_gact.c b/tc/m_gact.c
index 225ffce4..0d90963c 100644
--- a/tc/m_gact.c
+++ b/tc/m_gact.c
@@ -203,7 +203,7 @@ print_gact(struct action_util *au, FILE *f, struct rtattr *arg)
 		if (tb[TCA_GACT_TM]) {
 			struct tcf_t *tm = RTA_DATA(tb[TCA_GACT_TM]);
 
-			print_tm(f, tm);
+			print_tm(tm);
 		}
 	}
 	print_nl();
diff --git a/tc/m_gate.c b/tc/m_gate.c
index 37afa426..b2643ad8 100644
--- a/tc/m_gate.c
+++ b/tc/m_gate.c
@@ -527,7 +527,7 @@ static int print_gate(struct action_util *au, FILE *f, struct rtattr *arg)
 		if (tb[TCA_GATE_TM]) {
 			struct tcf_t *tm = RTA_DATA(tb[TCA_GATE_TM]);
 
-			print_tm(f, tm);
+			print_tm(tm);
 		}
 	}
 
diff --git a/tc/m_ife.c b/tc/m_ife.c
index 162607ce..f5b2d52d 100644
--- a/tc/m_ife.c
+++ b/tc/m_ife.c
@@ -315,7 +315,7 @@ static int print_ife(struct action_util *au, FILE *f, struct rtattr *arg)
 		if (tb[TCA_IFE_TM]) {
 			struct tcf_t *tm = RTA_DATA(tb[TCA_IFE_TM]);
 
-			print_tm(f, tm);
+			print_tm(tm);
 		}
 	}
 
diff --git a/tc/m_mirred.c b/tc/m_mirred.c
index 60bd9045..5e9856e0 100644
--- a/tc/m_mirred.c
+++ b/tc/m_mirred.c
@@ -348,7 +348,7 @@ print_mirred(struct action_util *au, FILE *f, struct rtattr *arg)
 		if (tb[TCA_MIRRED_TM]) {
 			struct tcf_t *tm = RTA_DATA(tb[TCA_MIRRED_TM]);
 
-			print_tm(f, tm);
+			print_tm(tm);
 		}
 	}
 	print_nl();
diff --git a/tc/m_mpls.c b/tc/m_mpls.c
index dda46805..a378e35e 100644
--- a/tc/m_mpls.c
+++ b/tc/m_mpls.c
@@ -283,7 +283,7 @@ static int print_mpls(struct action_util *au, FILE *f, struct rtattr *arg)
 		if (tb[TCA_MPLS_TM]) {
 			struct tcf_t *tm = RTA_DATA(tb[TCA_MPLS_TM]);
 
-			print_tm(f, tm);
+			print_tm(tm);
 		}
 	}
 
diff --git a/tc/m_nat.c b/tc/m_nat.c
index 95b35584..e4c74b08 100644
--- a/tc/m_nat.c
+++ b/tc/m_nat.c
@@ -179,7 +179,7 @@ print_nat(struct action_util *au, FILE * f, struct rtattr *arg)
 		if (tb[TCA_NAT_TM]) {
 			struct tcf_t *tm = RTA_DATA(tb[TCA_NAT_TM]);
 
-			print_tm(f, tm);
+			print_tm(tm);
 		}
 	}
 
diff --git a/tc/m_pedit.c b/tc/m_pedit.c
index 32f03415..fc06d04b 100644
--- a/tc/m_pedit.c
+++ b/tc/m_pedit.c
@@ -801,7 +801,7 @@ static int print_pedit(struct action_util *au, FILE *f, struct rtattr *arg)
 		if (tb[TCA_PEDIT_TM]) {
 			struct tcf_t *tm = RTA_DATA(tb[TCA_PEDIT_TM]);
 
-			print_tm(f, tm);
+			print_tm(tm);
 		}
 	}
 	open_json_array(PRINT_JSON, "keys");
diff --git a/tc/m_police.c b/tc/m_police.c
index 46c39a81..d140c1eb 100644
--- a/tc/m_police.c
+++ b/tc/m_police.c
@@ -347,7 +347,7 @@ static int print_police(struct action_util *a, FILE *f, struct rtattr *arg)
 		if (tb[TCA_POLICE_TM]) {
 			struct tcf_t *tm = RTA_DATA(tb[TCA_POLICE_TM]);
 
-			print_tm(f, tm);
+			print_tm(tm);
 		}
 	}
 	print_nl();
diff --git a/tc/m_sample.c b/tc/m_sample.c
index 769de144..36e4c1db 100644
--- a/tc/m_sample.c
+++ b/tc/m_sample.c
@@ -171,7 +171,7 @@ static int print_sample(struct action_util *au, FILE *f, struct rtattr *arg)
 		if (tb[TCA_SAMPLE_TM]) {
 			struct tcf_t *tm = RTA_DATA(tb[TCA_SAMPLE_TM]);
 
-			print_tm(f, tm);
+			print_tm(tm);
 		}
 	}
 	print_nl();
diff --git a/tc/m_simple.c b/tc/m_simple.c
index fe2bca21..a2366187 100644
--- a/tc/m_simple.c
+++ b/tc/m_simple.c
@@ -187,7 +187,7 @@ static int print_simple(struct action_util *au, FILE *f, struct rtattr *arg)
 		if (tb[TCA_DEF_TM]) {
 			struct tcf_t *tm = RTA_DATA(tb[TCA_DEF_TM]);
 
-			print_tm(f, tm);
+			print_tm(tm);
 		}
 	}
 	print_nl();
diff --git a/tc/m_skbedit.c b/tc/m_skbedit.c
index d55a6128..00b245ee 100644
--- a/tc/m_skbedit.c
+++ b/tc/m_skbedit.c
@@ -250,7 +250,7 @@ static int print_skbedit(struct action_util *au, FILE *f, struct rtattr *arg)
 		if (tb[TCA_SKBEDIT_TM]) {
 			struct tcf_t *tm = RTA_DATA(tb[TCA_SKBEDIT_TM]);
 
-			print_tm(f, tm);
+			print_tm(tm);
 		}
 	}
 
diff --git a/tc/m_skbmod.c b/tc/m_skbmod.c
index b1c8d00d..c7a2ccd5 100644
--- a/tc/m_skbmod.c
+++ b/tc/m_skbmod.c
@@ -218,7 +218,7 @@ static int print_skbmod(struct action_util *au, FILE *f, struct rtattr *arg)
 		if (tb[TCA_SKBMOD_TM]) {
 			struct tcf_t *tm = RTA_DATA(tb[TCA_SKBMOD_TM]);
 
-			print_tm(f, tm);
+			print_tm(tm);
 		}
 	}
 
diff --git a/tc/m_tunnel_key.c b/tc/m_tunnel_key.c
index ff699cc8..e62f9118 100644
--- a/tc/m_tunnel_key.c
+++ b/tc/m_tunnel_key.c
@@ -742,7 +742,7 @@ static int print_tunnel_key(struct action_util *au, FILE *f, struct rtattr *arg)
 		if (tb[TCA_TUNNEL_KEY_TM]) {
 			struct tcf_t *tm = RTA_DATA(tb[TCA_TUNNEL_KEY_TM]);
 
-			print_tm(f, tm);
+			print_tm(tm);
 		}
 	}
 
diff --git a/tc/m_vlan.c b/tc/m_vlan.c
index c1dc8b42..31d3b06f 100644
--- a/tc/m_vlan.c
+++ b/tc/m_vlan.c
@@ -293,7 +293,7 @@ static int print_vlan(struct action_util *au, FILE *f, struct rtattr *arg)
 		if (tb[TCA_VLAN_TM]) {
 			struct tcf_t *tm = RTA_DATA(tb[TCA_VLAN_TM]);
 
-			print_tm(f, tm);
+			print_tm(tm);
 		}
 	}
 
diff --git a/tc/tc_util.c b/tc/tc_util.c
index aa7cf60f..25c8d6b6 100644
--- a/tc/tc_util.c
+++ b/tc/tc_util.c
@@ -650,7 +650,7 @@ const char *get_clock_name(clockid_t clockid)
 	return "invalid";
 }
 
-void print_tm(FILE *f, const struct tcf_t *tm)
+void print_tm(const struct tcf_t *tm)
 {
 	int hz = get_user_hz();
 
diff --git a/tc/tc_util.h b/tc/tc_util.h
index 623d9888..152ef3e6 100644
--- a/tc/tc_util.h
+++ b/tc/tc_util.h
@@ -114,7 +114,7 @@ void print_action_control(FILE *f, const char *prefix,
 int police_print_xstats(struct action_util *a, FILE *f, struct rtattr *tb);
 int tc_print_action(FILE *f, const struct rtattr *tb, unsigned short tot_acts);
 int parse_action(int *argc_p, char ***argv_p, int tca_id, struct nlmsghdr *n);
-void print_tm(FILE *f, const struct tcf_t *tm);
+void print_tm(const struct tcf_t *tm);
 int prio_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt);
 
 int cls_names_init(char *path);
-- 
2.43.0


