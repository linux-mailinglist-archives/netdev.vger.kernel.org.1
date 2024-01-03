Return-Path: <netdev+bounces-61076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF06822606
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 01:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23952B228EE
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 00:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EDA655;
	Wed,  3 Jan 2024 00:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="AV602S5W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FD410EE
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bb9d54575cso6687396b6e.2
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 16:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704242173; x=1704846973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nraeyg+4k4cc+BR0LzOMPEDsmsLwNY2VG0Tez2jvnRM=;
        b=AV602S5WZcDhMgT7xFzgAPM13wCcTUOEq5LA8pgIF8YlZZxFKkVcWnFXdIbbWOpWQ6
         p59NzEPLZYXsKdHNoBubAl34H7gueyMPItIWKr3I+F0zu3Dfu3PT8rr86YGvEFyziKGd
         ZiPDXhS464faDTKZgjz3widGScQa9SaZYpDe17LQGhWETkFeWvxZaWYp/auqQU4RCdO1
         3ZMWJWvA0xT3ESGCQkFs7D+yKfcMsE5Cybs/D3ZY+iU0VpievUpQ6Uu9VfBAsszdZqr6
         gYkDbUxsmBemy1ZO8qHathHOuD2L1OqN4Lv4tjBBwa+R+VpmXRg7UjP77akJcte1QxSY
         Fbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704242173; x=1704846973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nraeyg+4k4cc+BR0LzOMPEDsmsLwNY2VG0Tez2jvnRM=;
        b=XLZRRCusFMi1gpv3AJei1ZY4TS7tckHSpYdmXL5mXVwser1//HDIby2k1cLoJTtxVH
         6EJrHrjMsPHgXLhi9Rpgf69EaQW5cQ9Z1PYAAOseERnCS0dg11bjiz4iuZYLFIdEmUdn
         T2jBwD8OqZ4QGoPskqzAcgIAmHQky/WpHpxM1h/16aYvm95pILRqh5IrdohHuz1BCGpH
         ewITsNn3E5Gce9RPL7GBsE5KlFqFMDV0lpsWc1khxwPsRJbAGQq8cVr6KzPag/gfkG18
         TEi2fDfFK8ZxJLwxPYKAPm1zfusJ+ErMhEmtq66bGORrzhCpl3g2qsQ7U/t72jKJH9wI
         yxww==
X-Gm-Message-State: AOJu0YxgdDulE3sxUtPk09FTcZqXjdH2PiGQ/JrBRvY8L0s4Q+jYVb6h
	cbo/c/5ZsCrapM+epIo8PBptXXNUM/mTVH/ewERMuWzknLQ=
X-Google-Smtp-Source: AGHT+IEFp+dA/pw3ENsiEbI8b761XuNWyOEcOChOFgyubYWMDdDipR03xLLfmXBvkQF54vc7EkisGg==
X-Received: by 2002:a05:6808:3999:b0:3bb:bfcb:d14b with SMTP id gq25-20020a056808399900b003bbbfcbd14bmr16906284oib.94.1704242173116;
        Tue, 02 Jan 2024 16:36:13 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7854c000000b006d9af59eecesm16698260pfn.20.2024.01.02.16.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 16:36:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: leon@kernel.org
Cc: netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC iproute2 6/8] rdma: do not mix newline and json object
Date: Tue,  2 Jan 2024 16:34:31 -0800
Message-ID: <20240103003558.20615-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103003558.20615-1-stephen@networkplumber.org>
References: <20240103003558.20615-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mixing the semantics of ending lines with the json object
leads to several bugs where json object is closed twice, etc.
Replace by breaking the meaning of newline() function into
two parts.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 rdma/dev.c      |  3 ++-
 rdma/link.c     |  4 +++-
 rdma/rdma.h     |  5 +++--
 rdma/res-cmid.c |  3 ++-
 rdma/res-cq.c   |  7 +++++--
 rdma/res-ctx.c  |  3 ++-
 rdma/res-mr.c   |  6 ++++--
 rdma/res-pd.c   |  4 ++--
 rdma/res-qp.c   |  6 ++++--
 rdma/res-srq.c  |  6 ++++--
 rdma/res.c      |  4 +++-
 rdma/stat-mr.c  |  3 ++-
 rdma/stat.c     | 17 ++++++++++-------
 rdma/utils.c    | 16 +++++-----------
 14 files changed, 51 insertions(+), 36 deletions(-)

diff --git a/rdma/dev.c b/rdma/dev.c
index 31868c6fe43e..c8cb6d675c3b 100644
--- a/rdma/dev.c
+++ b/rdma/dev.c
@@ -224,7 +224,8 @@ static int dev_parse_cb(const struct nlmsghdr *nlh, void *data)
 		dev_print_caps(rd, tb);
 	}
 
-	newline(rd);
+	close_json_object();
+	print_nl();
 	return MNL_CB_OK;
 }
 
diff --git a/rdma/link.c b/rdma/link.c
index d7d9558b49f2..0c57a01480ba 100644
--- a/rdma/link.c
+++ b/rdma/link.c
@@ -252,7 +252,9 @@ static int link_parse_cb(const struct nlmsghdr *nlh, void *data)
 	if (rd->show_details)
 		link_print_caps(rd, tb);
 
-	newline(rd);
+	close_json_object();
+	print_nl();
+
 	return MNL_CB_OK;
 }
 
diff --git a/rdma/rdma.h b/rdma/rdma.h
index 65e3557d4036..e93e34cbce45 100644
--- a/rdma/rdma.h
+++ b/rdma/rdma.h
@@ -135,9 +135,10 @@ int rd_attr_cb(const struct nlattr *attr, void *data);
  */
 void print_driver_table(struct rd *rd, struct nlattr *tb);
 void print_raw_data(struct rd *rd, struct nlattr **nla_line);
-void newline(struct rd *rd);
-void newline_indent(struct rd *rd);
 void print_raw_data(struct rd *rd, struct nlattr **nla_line);
+void print_nl_indent(void);
+
 #define MAX_LINE_LENGTH 80
 
+
 #endif /* _RDMA_TOOL_H_ */
diff --git a/rdma/res-cmid.c b/rdma/res-cmid.c
index fb32c58a695a..9714404aaded 100644
--- a/rdma/res-cmid.c
+++ b/rdma/res-cmid.c
@@ -198,7 +198,8 @@ static int res_cm_id_line(struct rd *rd, const char *name, int idx,
 		print_ipaddr(rd, "dst-addr", dst_addr_str, dst_port);
 
 	print_driver_table(rd, nla_line[RDMA_NLDEV_ATTR_DRIVER]);
-	newline(rd);
+	close_json_object();
+	print_nl();
 
 out:
 	return MNL_CB_OK;
diff --git a/rdma/res-cq.c b/rdma/res-cq.c
index b4dcc026ed4b..0d705a552781 100644
--- a/rdma/res-cq.c
+++ b/rdma/res-cq.c
@@ -47,7 +47,8 @@ static int res_cq_line_raw(struct rd *rd, const char *name, int idx,
 	open_json_object(NULL);
 	print_dev(rd, idx, name);
 	print_raw_data(rd, nla_line);
-	newline(rd);
+	close_json_object();
+	print_nl();
 
 	return MNL_CB_OK;
 }
@@ -122,7 +123,9 @@ static int res_cq_line(struct rd *rd, const char *name, int idx,
 	print_comm(rd, comm, nla_line);
 
 	print_driver_table(rd, nla_line[RDMA_NLDEV_ATTR_DRIVER]);
-	newline(rd);
+	close_json_object();
+	print_nl();
+
 
 out:
 	return MNL_CB_OK;
diff --git a/rdma/res-ctx.c b/rdma/res-ctx.c
index 500186d9ff59..1a5d31e817ff 100644
--- a/rdma/res-ctx.c
+++ b/rdma/res-ctx.c
@@ -47,7 +47,8 @@ static int res_ctx_line(struct rd *rd, const char *name, int idx,
 	print_comm(rd, comm, nla_line);
 
 	print_driver_table(rd, nla_line[RDMA_NLDEV_ATTR_DRIVER]);
-	newline(rd);
+	close_json_object();
+	print_nl();
 
 out:
 	return MNL_CB_OK;
diff --git a/rdma/res-mr.c b/rdma/res-mr.c
index fb48d5df6cad..8b647efbc6a9 100644
--- a/rdma/res-mr.c
+++ b/rdma/res-mr.c
@@ -16,7 +16,8 @@ static int res_mr_line_raw(struct rd *rd, const char *name, int idx,
 	open_json_object(NULL);
 	print_dev(rd, idx, name);
 	print_raw_data(rd, nla_line);
-	newline(rd);
+	close_json_object();
+	print_nl();
 
 	return MNL_CB_OK;
 }
@@ -87,7 +88,8 @@ static int res_mr_line(struct rd *rd, const char *name, int idx,
 
 	print_driver_table(rd, nla_line[RDMA_NLDEV_ATTR_DRIVER]);
 	print_raw_data(rd, nla_line);
-	newline(rd);
+	close_json_object();
+	print_nl();
 
 out:
 	return MNL_CB_OK;
diff --git a/rdma/res-pd.c b/rdma/res-pd.c
index 66f91f42860f..3ccfa364a236 100644
--- a/rdma/res-pd.c
+++ b/rdma/res-pd.c
@@ -76,8 +76,8 @@ static int res_pd_line(struct rd *rd, const char *name, int idx,
 	print_comm(rd, comm, nla_line);
 
 	print_driver_table(rd, nla_line[RDMA_NLDEV_ATTR_DRIVER]);
-	newline(rd);
-
+	close_json_object();
+	print_nl();
 out:
 	return MNL_CB_OK;
 }
diff --git a/rdma/res-qp.c b/rdma/res-qp.c
index 2390c0b5732b..d5d6a836e358 100644
--- a/rdma/res-qp.c
+++ b/rdma/res-qp.c
@@ -70,7 +70,8 @@ static int res_qp_line_raw(struct rd *rd, const char *name, int idx,
 	open_json_object(NULL);
 	print_link(rd, idx, name, rd->port_idx, nla_line);
 	print_raw_data(rd, nla_line);
-	newline(rd);
+	close_json_object();
+	print_nl();
 
 	return MNL_CB_OK;
 }
@@ -176,7 +177,8 @@ static int res_qp_line(struct rd *rd, const char *name, int idx,
 	print_comm(rd, comm, nla_line);
 
 	print_driver_table(rd, nla_line[RDMA_NLDEV_ATTR_DRIVER]);
-	newline(rd);
+	close_json_object();
+	print_nl();
 out:
 	return MNL_CB_OK;
 }
diff --git a/rdma/res-srq.c b/rdma/res-srq.c
index e702fecd1f34..b9d1fc45a1a4 100644
--- a/rdma/res-srq.c
+++ b/rdma/res-srq.c
@@ -170,7 +170,8 @@ static int res_srq_line_raw(struct rd *rd, const char *name, int idx,
 	open_json_object(NULL);
 	print_dev(rd, idx, name);
 	print_raw_data(rd, nla_line);
-	newline(rd);
+	close_json_object();
+	print_nl();
 
 	return MNL_CB_OK;
 }
@@ -241,7 +242,8 @@ static int res_srq_line(struct rd *rd, const char *name, int idx,
 	print_comm(rd, comm, nla_line);
 
 	print_driver_table(rd, nla_line[RDMA_NLDEV_ATTR_DRIVER]);
-	newline(rd);
+	close_json_object();
+	print_nl();
 
 out:
 	return MNL_CB_OK;
diff --git a/rdma/res.c b/rdma/res.c
index f64224e1f3eb..2c4507da8223 100644
--- a/rdma/res.c
+++ b/rdma/res.c
@@ -81,7 +81,9 @@ static int res_no_args_parse_cb(const struct nlmsghdr *nlh, void *data)
 	print_uint(PRINT_ANY, "ifindex", "%u: ", idx);
 	print_string(PRINT_ANY, "ifname", "%s: ", name);
 	res_print_summary(rd, tb);
-	newline(rd);
+	close_json_object();
+	print_nl();
+
 	return MNL_CB_OK;
 }
 
diff --git a/rdma/stat-mr.c b/rdma/stat-mr.c
index 2ba6cb07693e..be41f0db3d93 100644
--- a/rdma/stat-mr.c
+++ b/rdma/stat-mr.c
@@ -31,7 +31,8 @@ static int stat_mr_line(struct rd *rd, const char *name, int idx,
 			return ret;
 	}
 
-	newline(rd);
+	close_json_object();
+	print_nl();
 out:
 	return MNL_CB_OK;
 }
diff --git a/rdma/stat.c b/rdma/stat.c
index e90b6197ceb7..865f301370a0 100644
--- a/rdma/stat.c
+++ b/rdma/stat.c
@@ -136,7 +136,8 @@ static int qp_link_get_mode_parse_cb(const struct nlmsghdr *nlh, void *data)
 	open_json_object(NULL);
 	print_link(rd, idx, name, port, tb);
 	print_string(PRINT_ANY, "mode", "mode %s ", output);
-	newline(rd);
+	close_json_object();
+	print_nl();
 	return MNL_CB_OK;
 }
 
@@ -208,7 +209,7 @@ int res_get_hwcounters(struct rd *rd, struct nlattr *hwc_table, bool print)
 
 		nm = mnl_attr_get_str(hw_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME]);
 		v = mnl_attr_get_u64(hw_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_VALUE]);
-		newline_indent(rd);
+		print_nl_indent();
 		res_print_u64(rd, nm, v, hw_line[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME]);
 	}
 
@@ -308,7 +309,8 @@ static int res_counter_line(struct rd *rd, const char *name, int index,
 		isfirst = false;
 	}
 	close_json_array(PRINT_ANY, ">");
-	newline(rd);
+	close_json_object();
+	print_nl();
 	return MNL_CB_OK;
 }
 
@@ -757,7 +759,6 @@ static int do_stat_mode_parse_cb(const struct nlmsghdr *nlh, void *data,
 	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX] = {};
 	struct nlattr *nla_entry;
 	const char *dev, *name;
-	struct rd *rd = data;
 	int enabled, err = 0;
 	bool isfirst = true;
 	uint32_t port;
@@ -801,7 +802,7 @@ static int do_stat_mode_parse_cb(const struct nlmsghdr *nlh, void *data,
 			} else {
 				print_string(PRINT_FP, NULL, ",", NULL);
 			}
-			newline_indent(rd);
+			print_nl_indent();
 
 			print_string(PRINT_ANY, NULL, "%s", name);
 		}
@@ -809,7 +810,8 @@ static int do_stat_mode_parse_cb(const struct nlmsghdr *nlh, void *data,
 
 	if (!isfirst) {
 		close_json_array(PRINT_JSON, NULL);
-		newline(rd);
+		close_json_object();
+		print_nl();
 	}
 
 	return 0;
@@ -1070,7 +1072,8 @@ static int stat_show_parse_cb(const struct nlmsghdr *nlh, void *data)
 	print_uint(PRINT_ANY, "port", "%u ", port);
 	ret = res_get_hwcounters(rd, tb[RDMA_NLDEV_ATTR_STAT_HWCOUNTERS], true);
 
-	newline(rd);
+	close_json_object();
+	print_nl();
 	return ret;
 }
 
diff --git a/rdma/utils.c b/rdma/utils.c
index aeb627be7715..64f598c5aa8f 100644
--- a/rdma/utils.c
+++ b/rdma/utils.c
@@ -771,16 +771,10 @@ struct dev_map *dev_map_lookup(struct rd *rd, bool allow_port_index)
 
 #define nla_type(attr) ((attr)->nla_type & NLA_TYPE_MASK)
 
-void newline(struct rd *rd)
+void print_nl_indent(void)
 {
-	close_json_object();
-	print_nl();
-}
-
-void newline_indent(struct rd *rd)
-{
-	newline(rd);
-	print_string(PRINT_FP, NULL, "    ", NULL);
+	if (!is_json_context())
+		printf("%s    ", _SL_);
 }
 
 static int print_driver_string(struct rd *rd, const char *key_str,
@@ -920,7 +914,7 @@ void print_driver_table(struct rd *rd, struct nlattr *tb)
 	if (!rd->show_driver_details || !tb)
 		return;
 
-	newline_indent(rd);
+	print_nl_indent();
 
 	/*
 	 * Driver attrs are tuples of {key, [print-type], value}.
@@ -932,7 +926,7 @@ void print_driver_table(struct rd *rd, struct nlattr *tb)
 	mnl_attr_for_each_nested(tb_entry, tb) {
 
 		if (cc > MAX_LINE_LENGTH) {
-			newline_indent(rd);
+			print_nl_indent();
 			cc = 0;
 		}
 		if (rd_attr_check(tb_entry, &type) != MNL_CB_OK)
-- 
2.43.0


