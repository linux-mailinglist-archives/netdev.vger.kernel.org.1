Return-Path: <netdev+bounces-87640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653BD8A3F4F
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 00:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FC46B215F3
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 22:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B7157320;
	Sat, 13 Apr 2024 22:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="zR5F67Pv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5822E56B85
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713045933; cv=none; b=BmLSIhzax1Uj0lp6umDSv7jMvKG/xwXtEhQcpGKmPzEuzQ+ZwYjsMhrH8rTFTX7c582X3l94Sm444839iHe7JJWHAWWwBW0hNfZqbmu4r0kwaSapjFWYUwAcaPFmj+IMx8m5X6zjtddVaDKhSWfj2Hn4QtPeM5lDwoBz+XaIs0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713045933; c=relaxed/simple;
	bh=ex/TK/QBRkAh8HQkH0wf94ThCtVC+tnXA1lrd/DBA0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rn5a+gkTEvu2cKFfhn9NPLh9W8XnXUS24w9i9/VQnRKXCgr2qdwmfcWGo89zWOtGpOa8e0PTcB7hARjtHhwkK7MxuPwh184BUKkzBUehk3m3alDfEw5KFTD9p8d1/MdAJw34Q0CBBp3chZdYc6/Esf0jk+jwE/AXCfWmUg/4fHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=zR5F67Pv; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso1497736b3a.1
        for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 15:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1713045930; x=1713650730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KG0pi9cMDvzn7qBR5LlmuWI16FJF/UDqfeTzMUaA8E=;
        b=zR5F67PvBb3Hr0L+qDZjdaJdomk2DduPAzVkNZbYG0I6ZOJ/lss0XUD96zccttCJX9
         iFF3X56/0+jzIiOQKianEtzy7s1QrvCVK+A+Mpju6AJEQ/qGXKEBGmLrCQOIN4SyYlQt
         0OamqLONwYh4GclMmUn+YM+Z2662qfDPvestjATT4wOJXXlXtqKg8kdlOXD5WFgiwol1
         zdtBs5caTpLNLzhdo6bZs+dgerxx3d5kwEVWLdHTdl2LsTCTKpJSaMkEBo22KKxqSNiK
         PQANHxH9YPODhs7T9L3Eh9CYX0h/gA+s8Rys+EqOLbc5y8S8UDc/c47Cum8iihiUXHMv
         4zMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713045930; x=1713650730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KG0pi9cMDvzn7qBR5LlmuWI16FJF/UDqfeTzMUaA8E=;
        b=dIdC0cvRdZh4vndL+Myr5NsYu/saVqQGe/kzV+qrFG4i1TApypE43q1driNTMn9kX+
         gRtjfXU7eWXju6TTKmU+JTaBVsOL60y7HxH4gKIVgH+zrQQRs2UAuwSyLMGp6LPxJZ2Y
         zMZeMQFdNNJQLT9HyJBwdYpkhVuSxvMD7L59DQGw//TeVfYxxpnrhoNHy43AAzeo+aXP
         dbFco+Cume7cykIQP4rYrZrVR4xJTgCs7c7AG6/DCKxT9RERdrrJxUjhUw3uFyuInpuh
         PmCZvRx4ZbYVCWF13H0xdmRs1Mra3owj/b9jtEtCOBDGsuun9UxJof3oLZQU585FEVPT
         Ia2Q==
X-Gm-Message-State: AOJu0YxUkaN/uLe50I+VCWdGcCxWGJeWiS8818wD2TNnWA9vc8XVYK//
	z58ug/2fW+G5mbSIlct7WI0i1F3Nxow4mMTJGx0VYSR/jiD0+PKHy2htLSNkPStNwLjq/dlEfOf
	M
X-Google-Smtp-Source: AGHT+IFTO5+fFpsebTTiObQRyBZDovWcmjBGVY13NsaNjhLx0OoCvfkr4lIGVw3/YAXEY0kAmwu6cQ==
X-Received: by 2002:a05:6a21:81:b0:1a7:7ac1:a3ba with SMTP id iw1-20020a056a21008100b001a77ac1a3bamr5251228pzc.53.1713045929755;
        Sat, 13 Apr 2024 15:05:29 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902ec9000b001e3fe207a15sm5008082plg.138.2024.04.13.15.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 15:05:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 3/7] tc/util: remove unused argument from print_action_control
Date: Sat, 13 Apr 2024 15:04:04 -0700
Message-ID: <20240413220516.7235-4-stephen@networkplumber.org>
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

The FILE handle is no longer used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/m_bpf.c        | 2 +-
 tc/m_connmark.c   | 2 +-
 tc/m_csum.c       | 2 +-
 tc/m_ct.c         | 2 +-
 tc/m_ctinfo.c     | 2 +-
 tc/m_gact.c       | 4 ++--
 tc/m_gate.c       | 2 +-
 tc/m_ife.c        | 2 +-
 tc/m_mirred.c     | 2 +-
 tc/m_mpls.c       | 2 +-
 tc/m_nat.c        | 2 +-
 tc/m_pedit.c      | 2 +-
 tc/m_police.c     | 4 ++--
 tc/m_sample.c     | 2 +-
 tc/m_skbedit.c    | 2 +-
 tc/m_skbmod.c     | 2 +-
 tc/m_tunnel_key.c | 2 +-
 tc/m_vlan.c       | 2 +-
 tc/tc_util.c      | 3 +--
 tc/tc_util.h      | 3 +--
 20 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/tc/m_bpf.c b/tc/m_bpf.c
index 5cae51ba..f0cfd066 100644
--- a/tc/m_bpf.c
+++ b/tc/m_bpf.c
@@ -191,7 +191,7 @@ static int bpf_print_opt(struct action_util *au, FILE *f, struct rtattr *arg)
 			     b, sizeof(b)));
 	}
 
-	print_action_control(f, "default-action ", parm->action, _SL_);
+	print_action_control("default-action ", parm->action, _SL_);
 	print_uint(PRINT_ANY, "index", "\t index %u", parm->index);
 	print_int(PRINT_ANY, "ref", " ref %d", parm->refcnt);
 	print_int(PRINT_ANY, "bind", " bind %d", parm->bindcnt);
diff --git a/tc/m_connmark.c b/tc/m_connmark.c
index bd388665..880500fa 100644
--- a/tc/m_connmark.c
+++ b/tc/m_connmark.c
@@ -112,7 +112,7 @@ static int print_connmark(struct action_util *au, FILE *f, struct rtattr *arg)
 	ci = RTA_DATA(tb[TCA_CONNMARK_PARMS]);
 
 	print_uint(PRINT_ANY, "zone", "zone %u", ci->zone);
-	print_action_control(f, " ", ci->action, "");
+	print_action_control(" ", ci->action, "");
 
 	print_nl();
 	print_uint(PRINT_ANY, "index", "\t index %u", ci->index);
diff --git a/tc/m_csum.c b/tc/m_csum.c
index 966ae18e..8724bf0d 100644
--- a/tc/m_csum.c
+++ b/tc/m_csum.c
@@ -204,7 +204,7 @@ print_csum(struct action_util *au, FILE *f, struct rtattr *arg)
 		 uflag_4, uflag_5, uflag_6, uflag_7);
 	print_string(PRINT_ANY, "csum", "(%s) ", buf);
 
-	print_action_control(f, "action ", sel->action, _SL_);
+	print_action_control("action ", sel->action, _SL_);
 	print_uint(PRINT_ANY, "index", "\tindex %u", sel->index);
 	print_int(PRINT_ANY, "ref", " ref %d", sel->refcnt);
 	print_int(PRINT_ANY, "bind", " bind %d", sel->bindcnt);
diff --git a/tc/m_ct.c b/tc/m_ct.c
index 95098c88..3d71d8d4 100644
--- a/tc/m_ct.c
+++ b/tc/m_ct.c
@@ -523,7 +523,7 @@ static int print_ct(struct action_util *au, FILE *f, struct rtattr *arg)
 	ct_print_helper(tb[TCA_CT_HELPER_FAMILY], tb[TCA_CT_HELPER_PROTO], tb[TCA_CT_HELPER_NAME]);
 	ct_print_nat(ct_action, tb);
 
-	print_action_control(f, " ", p->action, "");
+	print_action_control(" ", p->action, "");
 
 	print_nl();
 	print_uint(PRINT_ANY, "index", "\t index %u", p->index);
diff --git a/tc/m_ctinfo.c b/tc/m_ctinfo.c
index 606ab280..2021d46d 100644
--- a/tc/m_ctinfo.c
+++ b/tc/m_ctinfo.c
@@ -236,7 +236,7 @@ static int print_ctinfo(struct action_util *au, FILE *f, struct rtattr *arg)
 		zone = rta_getattr_u16(tb[TCA_CTINFO_ZONE]);
 
 	print_hu(PRINT_ANY, "zone", "zone %u", zone);
-	print_action_control(f, " ", ci->action, "");
+	print_action_control(" ", ci->action, "");
 
 	print_nl();
 	print_uint(PRINT_ANY, "index", "\t index %u", ci->index);
diff --git a/tc/m_gact.c b/tc/m_gact.c
index 0d90963c..111dff28 100644
--- a/tc/m_gact.c
+++ b/tc/m_gact.c
@@ -178,7 +178,7 @@ print_gact(struct action_util *au, FILE *f, struct rtattr *arg)
 	}
 	p = RTA_DATA(tb[TCA_GACT_PARMS]);
 
-	print_action_control(f, "action ", p->action, "");
+	print_action_control("action ", p->action, "");
 #ifdef CONFIG_GACT_PROB
 	if (tb[TCA_GACT_PROB] != NULL) {
 		pp = RTA_DATA(tb[TCA_GACT_PROB]);
@@ -191,7 +191,7 @@ print_gact(struct action_util *au, FILE *f, struct rtattr *arg)
 	print_nl();
 	print_string(PRINT_ANY, "random_type", "\t random type %s",
 		     prob_n2a(pp->ptype));
-	print_action_control(f, " ", pp->paction, " ");
+	print_action_control(" ", pp->paction, " ");
 	print_int(PRINT_ANY, "val", "val %d", pp->pval);
 	close_json_object();
 #endif
diff --git a/tc/m_gate.c b/tc/m_gate.c
index b2643ad8..ea49b09f 100644
--- a/tc/m_gate.c
+++ b/tc/m_gate.c
@@ -517,7 +517,7 @@ static int print_gate(struct action_util *au, FILE *f, struct rtattr *arg)
 	if (tb[TCA_GATE_ENTRY_LIST])
 		print_gate_list(tb[TCA_GATE_ENTRY_LIST]);
 
-	print_action_control(f, "\t", parm->action, "");
+	print_action_control("\t", parm->action, "");
 
 	print_uint(PRINT_ANY, "index", "\n\t index %u", parm->index);
 	print_int(PRINT_ANY, "ref", " ref %d", parm->refcnt);
diff --git a/tc/m_ife.c b/tc/m_ife.c
index f5b2d52d..08b9d7de 100644
--- a/tc/m_ife.c
+++ b/tc/m_ife.c
@@ -236,7 +236,7 @@ static int print_ife(struct action_util *au, FILE *f, struct rtattr *arg)
 
 	print_string(PRINT_ANY, "mode", "%s ",
 		     p->flags & IFE_ENCODE ? "encode" : "decode");
-	print_action_control(f, "action ", p->action, " ");
+	print_action_control("action ", p->action, " ");
 
 	if (tb[TCA_IFE_TYPE]) {
 		ife_type = rta_getattr_u16(tb[TCA_IFE_TYPE]);
diff --git a/tc/m_mirred.c b/tc/m_mirred.c
index 5e9856e0..714f2472 100644
--- a/tc/m_mirred.c
+++ b/tc/m_mirred.c
@@ -337,7 +337,7 @@ print_mirred(struct action_util *au, FILE *f, struct rtattr *arg)
 		print_string(PRINT_ANY, "to_dev", " to device %s)", dev);
 	}
 
-	print_action_control(f, " ", p->action, "");
+	print_action_control(" ", p->action, "");
 
 	print_nl();
 	print_uint(PRINT_ANY, "index", "\tindex %u", p->index);
diff --git a/tc/m_mpls.c b/tc/m_mpls.c
index a378e35e..65b7163d 100644
--- a/tc/m_mpls.c
+++ b/tc/m_mpls.c
@@ -272,7 +272,7 @@ static int print_mpls(struct action_util *au, FILE *f, struct rtattr *arg)
 		}
 		break;
 	}
-	print_action_control(f, " ", parm->action, "");
+	print_action_control(" ", parm->action, "");
 
 	print_nl();
 	print_uint(PRINT_ANY, "index", "\t index %u", parm->index);
diff --git a/tc/m_nat.c b/tc/m_nat.c
index e4c74b08..ec421cdc 100644
--- a/tc/m_nat.c
+++ b/tc/m_nat.c
@@ -169,7 +169,7 @@ print_nat(struct action_util *au, FILE * f, struct rtattr *arg)
 	print_string(PRINT_ANY, "new_addr", " %s",
 		     format_host_r(AF_INET, 4, &sel->new_addr, buf1, sizeof(buf1)));
 
-	print_action_control(f, " ", sel->action, "");
+	print_action_control(" ", sel->action, "");
 	print_nl();
 	print_uint(PRINT_ANY, "index", "\t index %u", sel->index);
 	print_int(PRINT_ANY, "ref", " ref %d", sel->refcnt);
diff --git a/tc/m_pedit.c b/tc/m_pedit.c
index fc06d04b..5afa33d9 100644
--- a/tc/m_pedit.c
+++ b/tc/m_pedit.c
@@ -791,7 +791,7 @@ static int print_pedit(struct action_util *au, FILE *f, struct rtattr *arg)
 		}
 	}
 
-	print_action_control(f, "action ", sel->action, " ");
+	print_action_control("action ", sel->action, " ");
 	print_uint(PRINT_ANY, "nkeys", "keys %d\n", sel->nkeys);
 	print_uint(PRINT_ANY, "index", " \t index %u", sel->index);
 	print_int(PRINT_ANY, "ref", " ref %d", sel->refcnt);
diff --git a/tc/m_police.c b/tc/m_police.c
index d140c1eb..02e50142 100644
--- a/tc/m_police.c
+++ b/tc/m_police.c
@@ -325,12 +325,12 @@ static int print_police(struct action_util *a, FILE *f, struct rtattr *arg)
 		print_u64(PRINT_ANY, "pkts_burst", "pkts_burst %llu ", ppsburst64);
 	}
 
-	print_action_control(f, "action ", p->action, "");
+	print_action_control("action ", p->action, "");
 
 	if (tb[TCA_POLICE_RESULT]) {
 		__u32 action = rta_getattr_u32(tb[TCA_POLICE_RESULT]);
 
-		print_action_control(f, "/", action, " ");
+		print_action_control("/", action, " ");
 	} else {
 		print_string(PRINT_FP, NULL, " ", NULL);
 	}
diff --git a/tc/m_sample.c b/tc/m_sample.c
index 36e4c1db..6e2bca58 100644
--- a/tc/m_sample.c
+++ b/tc/m_sample.c
@@ -160,7 +160,7 @@ static int print_sample(struct action_util *au, FILE *f, struct rtattr *arg)
 		print_uint(PRINT_ANY, "trunc_size", " trunc_size %u",
 			   rta_getattr_u32(tb[TCA_SAMPLE_TRUNC_SIZE]));
 
-	print_action_control(f, " ", p->action, "");
+	print_action_control(" ", p->action, "");
 
 	print_nl();
 	print_uint(PRINT_ANY, "index", "\t index %u", p->index);
diff --git a/tc/m_skbedit.c b/tc/m_skbedit.c
index 00b245ee..8e25c268 100644
--- a/tc/m_skbedit.c
+++ b/tc/m_skbedit.c
@@ -239,7 +239,7 @@ static int print_skbedit(struct action_util *au, FILE *f, struct rtattr *arg)
 				     "inheritdsfield");
 	}
 
-	print_action_control(f, " ", p->action, "");
+	print_action_control(" ", p->action, "");
 
 	print_nl();
 	print_uint(PRINT_ANY, "index", "\t index %u", p->index);
diff --git a/tc/m_skbmod.c b/tc/m_skbmod.c
index c7a2ccd5..acb118b5 100644
--- a/tc/m_skbmod.c
+++ b/tc/m_skbmod.c
@@ -178,7 +178,7 @@ static int print_skbmod(struct action_util *au, FILE *f, struct rtattr *arg)
 	p = RTA_DATA(tb[TCA_SKBMOD_PARMS]);
 
 	fprintf(f, "skbmod ");
-	print_action_control(f, "", p->action, " ");
+	print_action_control("", p->action, " ");
 
 	if (tb[TCA_SKBMOD_ETYPE]) {
 		skbmod_etype = rta_getattr_u16(tb[TCA_SKBMOD_ETYPE]);
diff --git a/tc/m_tunnel_key.c b/tc/m_tunnel_key.c
index e62f9118..83adb09c 100644
--- a/tc/m_tunnel_key.c
+++ b/tc/m_tunnel_key.c
@@ -731,7 +731,7 @@ static int print_tunnel_key(struct action_util *au, FILE *f, struct rtattr *arg)
 					  tb[TCA_TUNNEL_KEY_ENC_TTL]);
 		break;
 	}
-	print_action_control(f, " ", parm->action, "");
+	print_action_control(" ", parm->action, "");
 
 	print_nl();
 	print_uint(PRINT_ANY, "index", "\t index %u", parm->index);
diff --git a/tc/m_vlan.c b/tc/m_vlan.c
index 31d3b06f..fb5a0669 100644
--- a/tc/m_vlan.c
+++ b/tc/m_vlan.c
@@ -282,7 +282,7 @@ static int print_vlan(struct action_util *au, FILE *f, struct rtattr *arg)
 			print_string(PRINT_ANY, "src_mac", " src_mac %s", b1);
 		}
 	}
-	print_action_control(f, " ", parm->action, "");
+	print_action_control(" ", parm->action, "");
 
 	print_nl();
 	print_uint(PRINT_ANY, "index", "\t index %u", parm->index);
diff --git a/tc/tc_util.c b/tc/tc_util.c
index 25c8d6b6..133fe9f9 100644
--- a/tc/tc_util.c
+++ b/tc/tc_util.c
@@ -539,8 +539,7 @@ int parse_action_control_slash(int *argc_p, char ***argv_p,
 	return 0;
 }
 
-void print_action_control(FILE *f, const char *prefix,
-			  int action, const char *suffix)
+void print_action_control(const char *prefix, int action, const char *suffix)
 {
 	print_string(PRINT_FP, NULL, "%s", prefix);
 	open_json_object("control_action");
diff --git a/tc/tc_util.h b/tc/tc_util.h
index 152ef3e6..851c2092 100644
--- a/tc/tc_util.h
+++ b/tc/tc_util.h
@@ -109,8 +109,7 @@ void parse_action_control_dflt(int *argc_p, char ***argv_p,
 			       int default_result);
 int parse_action_control_slash(int *argc_p, char ***argv_p,
 			       int *result1_p, int *result2_p, bool allow_num);
-void print_action_control(FILE *f, const char *prefix,
-			  int action, const char *suffix);
+void print_action_control(const char *prefix, int action, const char *suffix);
 int police_print_xstats(struct action_util *a, FILE *f, struct rtattr *tb);
 int tc_print_action(FILE *f, const struct rtattr *tb, unsigned short tot_acts);
 int parse_action(int *argc_p, char ***argv_p, int tca_id, struct nlmsghdr *n);
-- 
2.43.0


