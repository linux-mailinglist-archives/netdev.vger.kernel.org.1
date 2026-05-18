Return-Path: <netdev+bounces-289170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPmLDMB2C2o+IAUAu9opvQ
	(envelope-from <netdev+bounces-289170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 22:29:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9C957366F
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 22:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 141F23028F10
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FD2392803;
	Mon, 18 May 2026 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2+8Fw9V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BFC3932C2
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135854; cv=none; b=BIQ8qh8raMFWQqSXEOc5iUaJxzm+Jfh+mF2hsqmOy4X2XZYJ9s1FcWaRr5rh5/cwhuBF2lKGPG4BG01wnVkQaA1E5wFL7KQx2aSl8L0qwqE+P6WwO76sFDO2XWBHsghjVyWPFdPl1FqBiFOUcuxfgqcRFnS9T8Hn7RkyephO15c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135854; c=relaxed/simple;
	bh=021/l9/8OL217QO42te3Zu20uNixwVxZ7AoY1NEc1w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdHelGPbawZV+t8oRbZ2erPs3gwO0N+uZnzggQ+x2LHI5dotrBUcaNu/BfnjnhZk9gm1RHKExAFGpHO7t6wBTtsby9k9qZlTTP3XvuebjRsonhG843dgTj3rk3+GxdWh2A2OXhhjBO4BaxJ7yYa7eBa5TjK+HK+dSM4A9JWz6z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2+8Fw9V; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bd11a3729e8so459674766b.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 13:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779135850; x=1779740650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkEkkjaKOmQR9080tV/xQI9ewZ+yP8ZfSPO/lalrl2w=;
        b=l2+8Fw9VvmqiyiUkV3GR38OotO8HZwznV839RXcr6GCHSbAwIjjgSHc2K7/kzXGog9
         EwKXTf9OLwTdRIghBMu7K9mbVvnSToEq9IpZc5fCv+nNg9TIl6x8VgxZThtR2jhpfJNK
         m8KUKu8cw3yyKFP9+uebHrvyj5ZG9fhS4u7XgkEcy7sFHYpzAK8+PHPzw42n0gXwEV6x
         2n3ih5e07Dq7lhorSMboVFlIxgyNLhji8iapO7hVUueASD5eBj8ES7liVhx2DzpaFpdW
         9y80YcZakJOEFCxs7J//HnmOqpTVEPtJohQn85tjuQXYV/wkVKWHE+DRpZeCFqcBrf4G
         PTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779135850; x=1779740650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TkEkkjaKOmQR9080tV/xQI9ewZ+yP8ZfSPO/lalrl2w=;
        b=Ybc9nGTc9oKZVdEujr8xGHDsWGiQ1+s4T5u/uhaIyFxPZg1+4m5K4dEVcopodOGr2T
         UI0VSgSpXOr5wQ3UU8f90bk3MGoj8AGrDkYrkxr1WCV/mrNwNJ2x5yD98SvpKv7InW1x
         HjCOIBXGqm7rWHMgsMJU/VPnx+8pUkavNnUGN1/VC8W2uw/kzUGbyqoK78FVEDeUkF+K
         vLwNUw6DwQInr2CDhvncXZMas7A/g4mv4tlb5NRMlSzCB/l/LeKroNreDcl+2t1OF3Ha
         9l84Vb1CHhwjA2J9pVMdCL0L4zImUuio/Eqg1S0uyIe6+lg6X12BJSApVEZSrLBtd1ML
         eGBQ==
X-Gm-Message-State: AOJu0YxcPAcFZAXtpFbstijjJsfAT+y1z+F/2vj0ehWbriLDFtK8YFvI
	EWnW0hoJs6+itHdTkpjcJHf8PeIfkmuTXD4XL6js1akU19IdRgCbAnGpgxjtQ+6RhF4=
X-Gm-Gg: Acq92OGIrA2bzJpVecwsua+3eP7/QM9QVNTvqfEjLPixN8jbr1cqDkReifiBbOes4GZ
	Tbvw9OBAmdzCyvgzgWDmEFM6oZZU+8Vj9bRO4q6tMeLXBHhzO5jCjTxen2Tan2hsJohr29k5o3T
	olatyVKvIaGAD/1q2B65mZNpLPb/T+qkl5USN5qv++x+JLmUhOaRvGzCatKmEWdvOfES6g0230a
	yFJMmWLBdAXBnR13xIuFH0MngSSP7xtPwpDq94WrgsTbInlw9Bc/i9Sw06crtY5iXDbgh/fMJVd
	bnf/CnaYNAqQnND+ldObrDS7nDRoc5PpEl4Q75hdjehZVHPXiwsoZglvptpPQfwPs9ZJrJGhu26
	A+rDlSdnTiljxJmemb6AqimYc9v6OIwGTggQxgWQVpi+BOCBWedNoFr5+AhPufyJ5bsb4D7RUoz
	oMI6zPeKOsbOKFr8c5UQfO
X-Received: by 2002:a17:907:1b1c:b0:bd2:387:6bd with SMTP id a640c23a62f3a-bd5177afa91mr677776266b.4.1779135850361;
        Mon, 18 May 2026 13:24:10 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:43::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4e68fa6sm618312466b.54.2026.05.18.13.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 13:24:08 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexander.duyck@gmail.com,
	dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com
Subject: [iproute2-next V4 4/6] netshaper: Extract struct shaper_args and parse_shaper_arg() helper
Date: Mon, 18 May 2026 13:23:51 -0700
Message-ID: <20260518202353.390827-5-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260518202353.390827-1-mohsin.bashr@gmail.com>
References: <20260518202353.390827-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289170-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,networkplumber.org,redhat.com,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8B9C957366F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mohsin Bashir <hmohsin@meta.com>

Extract common shaper parameters (dev, bw-min, bw-max, weight) into
struct shaper_args and add parse_shaper_arg() to parse them. This
avoids duplicating argument parsing when the group command is added
in the next patch.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 netshaper/netshaper.c | 111 +++++++++++++++++++++++++++---------------
 1 file changed, 72 insertions(+), 39 deletions(-)

diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
index 20f4ed71..93f50b9c 100644
--- a/netshaper/netshaper.c
+++ b/netshaper/netshaper.c
@@ -69,6 +69,54 @@ static int parse_rate(const char *str, __u64 *rate_bps)
 	return 0;
 }
 
+struct shaper_args {
+	__u64 bw_min_bps, bw_max_bps;
+	__u32 weight;
+	bool has_bw_min, has_bw_max, has_weight;
+	int ifindex;
+};
+
+#define SHAPER_ARGS_INIT { .ifindex = -1 }
+
+static int parse_shaper_arg(const char *key, int *argcp, char ***argvp,
+			    struct shaper_args *args)
+{
+	int argc = *argcp;
+	char **argv = *argvp;
+
+	if (strcmp(key, "dev") == 0) {
+		NEXT_ARG();
+		args->ifindex = ll_name_to_index(*argv);
+		if (args->ifindex == 0) {
+			fprintf(stderr, "Device \"%s\" not found\n", *argv);
+			return -1;
+		}
+	} else if (strcmp(key, "bw-min") == 0) {
+		NEXT_ARG();
+		if (parse_rate(*argv, &args->bw_min_bps))
+			return -1;
+		args->has_bw_min = true;
+	} else if (strcmp(key, "bw-max") == 0) {
+		NEXT_ARG();
+		if (parse_rate(*argv, &args->bw_max_bps))
+			return -1;
+		args->has_bw_max = true;
+	} else if (strcmp(key, "weight") == 0) {
+		NEXT_ARG();
+		if (get_unsigned(&args->weight, *argv, 10)) {
+			fprintf(stderr, "Invalid weight value\n");
+			return -1;
+		}
+		args->has_weight = true;
+	} else {
+		return 0;
+	}
+
+	*argcp = argc;
+	*argvp = argv;
+	return 1;
+}
+
 static void print_netshaper_attrs(struct nlmsghdr *answer)
 {
 	struct rtattr *handle_tb[NET_SHAPER_A_HANDLE_MAX + 1] = {};
@@ -155,41 +203,25 @@ static int do_cmd(int argc, char **argv, int cmd)
 	GENL_REQUEST(req, 1024, genl_family, 0, NET_SHAPER_FAMILY_VERSION, cmd,
 		     NLM_F_REQUEST | NLM_F_ACK);
 
-	bool has_bw_min = false, has_bw_max = false, has_weight = false;
+	struct shaper_args args = SHAPER_ARGS_INIT;
 	int handle_scope = NET_SHAPER_SCOPE_UNSPEC;
-	__u64 bw_min_bps = 0, bw_max_bps = 0;
-	__u32 handle_id = 0, weight = 0;
 	bool handle_present = false;
 	bool has_handle_id = false;
 	struct nlmsghdr *answer;
-	int err, ifindex = -1;
+	__u32 handle_id = 0;
+	int err, ret;
 
 	while (argc > 0) {
-		if (strcmp(*argv, "dev") == 0) {
-			NEXT_ARG();
-			ifindex = ll_name_to_index(*argv);
-			if (ifindex == 0) {
-				fprintf(stderr, "Device \"%s\" not found\n", *argv);
-				return -1;
-			}
-		} else if (strcmp(*argv, "bw-min") == 0) {
-			NEXT_ARG();
-			if (parse_rate(*argv, &bw_min_bps))
-				return -1;
-			has_bw_min = true;
-		} else if (strcmp(*argv, "bw-max") == 0) {
-			NEXT_ARG();
-			if (parse_rate(*argv, &bw_max_bps))
-				return -1;
-			has_bw_max = true;
-		} else if (strcmp(*argv, "weight") == 0) {
-			NEXT_ARG();
-			if (get_unsigned(&weight, *argv, 10)) {
-				fprintf(stderr, "Invalid weight value\n");
-				return -1;
-			}
-			has_weight = true;
-		} else if (strcmp(*argv, "handle") == 0) {
+		ret = parse_shaper_arg(*argv, &argc, &argv, &args);
+		if (ret < 0)
+			return -1;
+		if (ret > 0) {
+			argc--;
+			argv++;
+			continue;
+		}
+
+		if (strcmp(*argv, "handle") == 0) {
 			handle_present = true;
 			NEXT_ARG();
 
@@ -241,16 +273,17 @@ static int do_cmd(int argc, char **argv, int cmd)
 		argv++;
 	}
 
-	if (ifindex == -1)
+	if (args.ifindex == -1)
 		missarg("dev");
 
 	if (!handle_present)
 		missarg("handle");
 
-	if (cmd == NET_SHAPER_CMD_SET && !has_bw_min && !has_bw_max && !has_weight)
+	if (cmd == NET_SHAPER_CMD_SET &&
+	    !args.has_bw_min && !args.has_bw_max && !args.has_weight)
 		missarg("bw-min, bw-max, or weight");
 
-	addattr32(&req.n, sizeof(req), NET_SHAPER_A_IFINDEX, ifindex);
+	addattr32(&req.n, sizeof(req), NET_SHAPER_A_IFINDEX, args.ifindex);
 
 	struct rtattr *handle = addattr_nest(&req.n, sizeof(req),
 					     NET_SHAPER_A_HANDLE | NLA_F_NESTED);
@@ -260,16 +293,16 @@ static int do_cmd(int argc, char **argv, int cmd)
 	addattr_nest_end(&req.n, handle);
 
 	if (cmd == NET_SHAPER_CMD_SET) {
-		if (has_bw_min)
+		if (args.has_bw_min)
 			addattr64(&req.n, sizeof(req), NET_SHAPER_A_BW_MIN,
-				  bw_min_bps);
-		if (has_bw_max)
+				  args.bw_min_bps);
+		if (args.has_bw_max)
 			addattr64(&req.n, sizeof(req), NET_SHAPER_A_BW_MAX,
-				  bw_max_bps);
-		if (has_weight)
+				  args.bw_max_bps);
+		if (args.has_weight)
 			addattr32(&req.n, sizeof(req), NET_SHAPER_A_WEIGHT,
-				  weight);
-		if (has_bw_min || has_bw_max)
+				  args.weight);
+		if (args.has_bw_min || args.has_bw_max)
 			addattr32(&req.n, sizeof(req), NET_SHAPER_A_METRIC,
 				  NET_SHAPER_METRIC_BPS);
 	}
-- 
2.53.0-Meta


