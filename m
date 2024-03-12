Return-Path: <netdev+bounces-79567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A78CF879E48
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 23:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE561C21EBA
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 22:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1110A144047;
	Tue, 12 Mar 2024 22:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="IdXw0WMc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E489E143C60
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281677; cv=none; b=id7d90TqiC6/yNAfeIEfU+vNpktTOR3vqqfH6jReY0JSgdrvnmhCzy6+suQl+F+w1E/rbubXlL6OVDrLDpmXUtVltfegeIomA7VwwG15B+yZdjZ8CG2zDeoEVhSPzz7WcQPzQH8cIEfN2pKXdymn5Fi5whrefjMBWiZ8Kt8KEUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281677; c=relaxed/simple;
	bh=f8U/VB+9jEsZTOV7uq66psdP5t7+htRD3JRQNkUTtE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZP3Okt8YqzFEn+RlyclUxT4bfGPKiPHZxjbOKl8hF7QSYfJyZHOT1eAaW7mMQmX1eIFBrg6r/rSlI5al6abZR88Q0vCMIonnIWz8IDMLggtOjMuRlncUW5RtYwZaIHUVr+RwL0Gah1UK/TIkgMxsGBdK0NlysaQRmmOotlFWJEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=IdXw0WMc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dd6198c4e2so43618575ad.2
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 15:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710281674; x=1710886474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TF/QmIyd2cNWNHHDXZO/yui0ONUx5lCVQ6+6kstCr9E=;
        b=IdXw0WMcwDOFe3LMg95ril0x7m93WQkbcyCkDtD1loZM04q75lxd9mNPWAGNAdCWIs
         80fpHNalKf+KEGMNmaTU7Tc+BJDKSUwOQXZHGH7nc89fJ9QPoCi+M0dKezFyfRdStJRz
         uoj+KzIXs9W1NczBi1jPH6Yn+Qh8qiRnPn6QbaQ+oz8a/g/4LpqXekkYm4PZ3Tm3hd75
         tKU5NRMTmrubC7/UGNYBWi6Vk9evBWvVZqwvL3yYs68wWTfbEbQ1uCEishuJzMj/xkdT
         tdpvtzynhi+YV+2ZVJUpyxQ0TZLXlwuColemtcS1EWqnnYbydZ2r1lStyGkGVqY90PbD
         SjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710281674; x=1710886474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TF/QmIyd2cNWNHHDXZO/yui0ONUx5lCVQ6+6kstCr9E=;
        b=RYd4whO504XRpehQ+B4BHy70UYYjydrSt68ReUdpZ1KZl2DIc3Q03L3dJosShjtHTB
         kyoITqwGEbGIZ1D75NIcPAW9B1HGif20BfzLVSxoG3fquMRKo3531IeZ1CLAPABTEAPY
         GBEEV2dMC1zqHW4THnz3lb8kkOc80spTe//BsXYIlKQSjJWO5bYEs6V2cr3ZYY9n33t4
         QIhFwqDr4887y3Jyb6TVDHtde9KgW8gy7CNtU2KVBQeBePksVgItR94z+yWVcEK83p6z
         iL2gnHf3fYkQHSsXZqYxpJW613IQ2lZ4vJ5ciD8I5V055aoRMeM5vtecHUaPhLmB9D54
         8xsg==
X-Gm-Message-State: AOJu0Yy1t94X8POwTvp4fNQU9Mj/EHiHy87zNn/Ox4aieEtUE4W7xWhO
	pbKcM05HaiAvXwBhaxiMdZLtcMQDL+gkzOckHGSd8t9+BiT6FcvoqE4cBTxD9YshiVxfwEdQjKW
	p
X-Google-Smtp-Source: AGHT+IFi/BXpj9B16ezTDn9ms93bGGRn5RpIgm4ByXap4gTJZQpCphiHlph7WQHJMle70HaZHdqiXA==
X-Received: by 2002:a17:902:f545:b0:1dd:b45f:4d02 with SMTP id h5-20020a170902f54500b001ddb45f4d02mr4437936plf.22.1710281674173;
        Tue, 12 Mar 2024 15:14:34 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902e28a00b001dcfaab3457sm7240473plc.104.2024.03.12.15.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:14:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 2/4] tc: make filter_util args const
Date: Tue, 12 Mar 2024 15:12:40 -0700
Message-ID: <20240312221422.81253-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240312221422.81253-1-stephen@networkplumber.org>
References: <20240312221422.81253-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The callbacks in filter_util should not be modifying underlying
qdisc operations structure.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 tc/f_basic.c    | 4 ++--
 tc/f_bpf.c      | 4 ++--
 tc/f_cgroup.c   | 4 ++--
 tc/f_flow.c     | 4 ++--
 tc/f_flower.c   | 4 ++--
 tc/f_fw.c       | 4 ++--
 tc/f_matchall.c | 4 ++--
 tc/f_route.c    | 4 ++--
 tc/f_u32.c      | 4 ++--
 tc/tc.c         | 6 +++---
 tc/tc_filter.c  | 6 +++---
 tc/tc_util.h    | 6 +++---
 12 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/tc/f_basic.c b/tc/f_basic.c
index 1ceb15d404f3..a1db5ba5dbc0 100644
--- a/tc/f_basic.c
+++ b/tc/f_basic.c
@@ -32,7 +32,7 @@ static void explain(void)
 		"NOTE: CLASSID is parsed as hexadecimal input.\n");
 }
 
-static int basic_parse_opt(struct filter_util *qu, char *handle,
+static int basic_parse_opt(const struct filter_util *qu, char *handle,
 			   int argc, char **argv, struct nlmsghdr *n)
 {
 	struct tcmsg *t = NLMSG_DATA(n);
@@ -103,7 +103,7 @@ static int basic_parse_opt(struct filter_util *qu, char *handle,
 	return 0;
 }
 
-static int basic_print_opt(struct filter_util *qu, FILE *f,
+static int basic_print_opt(const struct filter_util *qu, FILE *f,
 			   struct rtattr *opt, __u32 handle)
 {
 	struct rtattr *tb[TCA_BASIC_MAX+1];
diff --git a/tc/f_bpf.c b/tc/f_bpf.c
index a6d4875fc057..3e53c56ab7c3 100644
--- a/tc/f_bpf.c
+++ b/tc/f_bpf.c
@@ -71,7 +71,7 @@ static const struct bpf_cfg_ops bpf_cb_ops = {
 	.ebpf_cb = bpf_ebpf_cb,
 };
 
-static int bpf_parse_opt(struct filter_util *qu, char *handle,
+static int bpf_parse_opt(const struct filter_util *qu, char *handle,
 			 int argc, char **argv, struct nlmsghdr *n)
 {
 	const char *bpf_obj = NULL, *bpf_uds_name = NULL;
@@ -187,7 +187,7 @@ opt_bpf:
 	return ret;
 }
 
-static int bpf_print_opt(struct filter_util *qu, FILE *f,
+static int bpf_print_opt(const struct filter_util *qu, FILE *f,
 			 struct rtattr *opt, __u32 handle)
 {
 	struct rtattr *tb[TCA_BPF_MAX + 1];
diff --git a/tc/f_cgroup.c b/tc/f_cgroup.c
index 291d6e7ebe33..4aba4bacaf09 100644
--- a/tc/f_cgroup.c
+++ b/tc/f_cgroup.c
@@ -17,7 +17,7 @@ static void explain(void)
 	fprintf(stderr, "                  [ action ACTION_SPEC ]\n");
 }
 
-static int cgroup_parse_opt(struct filter_util *qu, char *handle,
+static int cgroup_parse_opt(const struct filter_util *qu, char *handle,
 			   int argc, char **argv, struct nlmsghdr *n)
 {
 	struct tcmsg *t = NLMSG_DATA(n);
@@ -75,7 +75,7 @@ static int cgroup_parse_opt(struct filter_util *qu, char *handle,
 	return 0;
 }
 
-static int cgroup_print_opt(struct filter_util *qu, FILE *f,
+static int cgroup_print_opt(const struct filter_util *qu, FILE *f,
 			   struct rtattr *opt, __u32 handle)
 {
 	struct rtattr *tb[TCA_CGROUP_MAX+1];
diff --git a/tc/f_flow.c b/tc/f_flow.c
index 4a29af22e99d..07ecb84cf905 100644
--- a/tc/f_flow.c
+++ b/tc/f_flow.c
@@ -126,7 +126,7 @@ out:
 	return 0;
 }
 
-static int flow_parse_opt(struct filter_util *fu, char *handle,
+static int flow_parse_opt(const struct filter_util *fu, char *handle,
 			  int argc, char **argv, struct nlmsghdr *n)
 {
 	struct tcmsg *t = NLMSG_DATA(n);
@@ -273,7 +273,7 @@ static const char *flow_mode2str(__u32 mode)
 	}
 }
 
-static int flow_print_opt(struct filter_util *fu, FILE *f, struct rtattr *opt,
+static int flow_print_opt(const struct filter_util *fu, FILE *f, struct rtattr *opt,
 			  __u32 handle)
 {
 	struct rtattr *tb[TCA_FLOW_MAX+1];
diff --git a/tc/f_flower.c b/tc/f_flower.c
index 53188f1cd87a..cfcd7b2f6ddf 100644
--- a/tc/f_flower.c
+++ b/tc/f_flower.c
@@ -1535,7 +1535,7 @@ static int flower_parse_cfm(int *argc_p, char ***argv_p, __be16 eth_type,
 	return 0;
 }
 
-static int flower_parse_opt(struct filter_util *qu, char *handle,
+static int flower_parse_opt(const struct filter_util *qu, char *handle,
 			    int argc, char **argv, struct nlmsghdr *n)
 {
 	int ret;
@@ -2882,7 +2882,7 @@ static void flower_print_cfm(struct rtattr *attr)
 	close_json_object();
 }
 
-static int flower_print_opt(struct filter_util *qu, FILE *f,
+static int flower_print_opt(const struct filter_util *qu, FILE *f,
 			    struct rtattr *opt, __u32 handle)
 {
 	struct rtattr *tb[TCA_FLOWER_MAX + 1];
diff --git a/tc/f_fw.c b/tc/f_fw.c
index 5e72e526b175..cf4abe122d8c 100644
--- a/tc/f_fw.c
+++ b/tc/f_fw.c
@@ -29,7 +29,7 @@ static void explain(void)
 		"		FWMASK is 0xffffffff by default.\n");
 }
 
-static int fw_parse_opt(struct filter_util *qu, char *handle, int argc, char **argv, struct nlmsghdr *n)
+static int fw_parse_opt(const struct filter_util *qu, char *handle, int argc, char **argv, struct nlmsghdr *n)
 {
 	struct tcmsg *t = NLMSG_DATA(n);
 	struct rtattr *tail;
@@ -112,7 +112,7 @@ static int fw_parse_opt(struct filter_util *qu, char *handle, int argc, char **a
 	return 0;
 }
 
-static int fw_print_opt(struct filter_util *qu, FILE *f, struct rtattr *opt, __u32 handle)
+static int fw_print_opt(const struct filter_util *qu, FILE *f, struct rtattr *opt, __u32 handle)
 {
 	struct rtattr *tb[TCA_FW_MAX+1];
 
diff --git a/tc/f_matchall.c b/tc/f_matchall.c
index 38b68d7e2450..e595ac38d6f9 100644
--- a/tc/f_matchall.c
+++ b/tc/f_matchall.c
@@ -31,7 +31,7 @@ static void explain(void)
 		"NOTE: CLASSID is parsed as hexadecimal input.\n");
 }
 
-static int matchall_parse_opt(struct filter_util *qu, char *handle,
+static int matchall_parse_opt(const struct filter_util *qu, char *handle,
 			   int argc, char **argv, struct nlmsghdr *n)
 {
 	struct tcmsg *t = NLMSG_DATA(n);
@@ -107,7 +107,7 @@ static int matchall_parse_opt(struct filter_util *qu, char *handle,
 	return 0;
 }
 
-static int matchall_print_opt(struct filter_util *qu, FILE *f,
+static int matchall_print_opt(const struct filter_util *qu, FILE *f,
 			   struct rtattr *opt, __u32 handle)
 {
 	struct rtattr *tb[TCA_MATCHALL_MAX+1];
diff --git a/tc/f_route.c b/tc/f_route.c
index ca8a8dddc2aa..87d865b7182b 100644
--- a/tc/f_route.c
+++ b/tc/f_route.c
@@ -30,7 +30,7 @@ static void explain(void)
 		"NOTE: CLASSID is parsed as hexadecimal input.\n");
 }
 
-static int route_parse_opt(struct filter_util *qu, char *handle, int argc, char **argv, struct nlmsghdr *n)
+static int route_parse_opt(const struct filter_util *qu, char *handle, int argc, char **argv, struct nlmsghdr *n)
 {
 	struct tcmsg *t = NLMSG_DATA(n);
 	struct rtattr *tail;
@@ -134,7 +134,7 @@ static int route_parse_opt(struct filter_util *qu, char *handle, int argc, char
 	return 0;
 }
 
-static int route_print_opt(struct filter_util *qu, FILE *f, struct rtattr *opt, __u32 handle)
+static int route_print_opt(const struct filter_util *qu, FILE *f, struct rtattr *opt, __u32 handle)
 {
 	struct rtattr *tb[TCA_ROUTE4_MAX+1];
 
diff --git a/tc/f_u32.c b/tc/f_u32.c
index 59aa4e3a2b50..a06996363b07 100644
--- a/tc/f_u32.c
+++ b/tc/f_u32.c
@@ -1018,7 +1018,7 @@ static __u32 u32_hash_fold(struct tc_u32_key *key)
 	return ntohl(key->val & key->mask) >> fshift;
 }
 
-static int u32_parse_opt(struct filter_util *qu, char *handle,
+static int u32_parse_opt(const struct filter_util *qu, char *handle,
 			 int argc, char **argv, struct nlmsghdr *n)
 {
 	struct {
@@ -1232,7 +1232,7 @@ static int u32_parse_opt(struct filter_util *qu, char *handle,
 	return 0;
 }
 
-static int u32_print_opt(struct filter_util *qu, FILE *f, struct rtattr *opt,
+static int u32_print_opt(const struct filter_util *qu, FILE *f, struct rtattr *opt,
 			 __u32 handle)
 {
 	struct rtattr *tb[TCA_U32_MAX + 1];
diff --git a/tc/tc.c b/tc/tc.c
index 5191b4bd8cde..7edff7e39166 100644
--- a/tc/tc.c
+++ b/tc/tc.c
@@ -69,7 +69,7 @@ static int parse_noqopt(const struct qdisc_util *qu, int argc, char **argv,
 	return 0;
 }
 
-static int print_nofopt(struct filter_util *qu, FILE *f, struct rtattr *opt, __u32 fhandle)
+static int print_nofopt(const struct filter_util *qu, FILE *f, struct rtattr *opt, __u32 fhandle)
 {
 	if (opt && RTA_PAYLOAD(opt))
 		fprintf(f, "fh %08x [Unknown filter, optlen=%u] ",
@@ -79,7 +79,7 @@ static int print_nofopt(struct filter_util *qu, FILE *f, struct rtattr *opt, __u
 	return 0;
 }
 
-static int parse_nofopt(struct filter_util *qu, char *fhandle,
+static int parse_nofopt(const struct filter_util *qu, char *fhandle,
 			int argc, char **argv, struct nlmsghdr *n)
 {
 	__u32 handle;
@@ -146,7 +146,7 @@ noexist:
 }
 
 
-struct filter_util *get_filter_kind(const char *str)
+const struct filter_util *get_filter_kind(const char *str)
 {
 	void *dlh;
 	char buf[256];
diff --git a/tc/tc_filter.c b/tc/tc_filter.c
index 54790ddc6cdf..7db850bda11a 100644
--- a/tc/tc_filter.c
+++ b/tc/tc_filter.c
@@ -65,7 +65,7 @@ static int tc_filter_modify(int cmd, unsigned int flags, int argc, char **argv)
 		.n.nlmsg_type = cmd,
 		.t.tcm_family = AF_UNSPEC,
 	};
-	struct filter_util *q = NULL;
+	const struct filter_util *q = NULL;
 	__u32 prio = 0;
 	__u32 protocol = 0;
 	int protocol_set = 0;
@@ -250,7 +250,7 @@ int print_filter(struct nlmsghdr *n, void *arg)
 	struct tcmsg *t = NLMSG_DATA(n);
 	int len = n->nlmsg_len;
 	struct rtattr *tb[TCA_MAX+1];
-	struct filter_util *q;
+	const struct filter_util *q;
 	char abuf[256];
 
 	if (n->nlmsg_type != RTM_NEWTFILTER &&
@@ -398,7 +398,7 @@ static int tc_filter_get(int cmd, unsigned int flags, int argc, char **argv)
 		.t.tcm_family = AF_UNSPEC,
 	};
 	struct nlmsghdr *answer;
-	struct filter_util *q = NULL;
+	const struct filter_util *q = NULL;
 	__u32 prio = 0;
 	__u32 protocol = 0;
 	int protocol_set = 0;
diff --git a/tc/tc_util.h b/tc/tc_util.h
index bcd661ea4626..51f9effc27b1 100644
--- a/tc/tc_util.h
+++ b/tc/tc_util.h
@@ -49,9 +49,9 @@ extern __u16 f_proto;
 struct filter_util {
 	struct filter_util *next;
 	char id[FILTER_NAMESZ];
-	int (*parse_fopt)(struct filter_util *qu, char *fhandle,
+	int (*parse_fopt)(const struct filter_util *qu, char *fhandle,
 			  int argc, char **argv, struct nlmsghdr *n);
-	int (*print_fopt)(struct filter_util *qu,
+	int (*print_fopt)(const struct filter_util *qu,
 			  FILE *f, struct rtattr *opt, __u32 fhandle);
 };
 
@@ -74,7 +74,7 @@ struct exec_util {
 const char *get_tc_lib(void);
 
 const struct qdisc_util *get_qdisc_kind(const char *str);
-struct filter_util *get_filter_kind(const char *str);
+const struct filter_util *get_filter_kind(const char *str);
 
 int get_qdisc_handle(__u32 *h, const char *str);
 int get_percent_rate(unsigned int *rate, const char *str, const char *dev);
-- 
2.43.0


