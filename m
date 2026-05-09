Return-Path: <netdev+bounces-286087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA1fCMya/mkMtwAAu9opvQ
	(envelope-from <netdev+bounces-286087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:24:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B53CF4FD9CA
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 04:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA8C63007482
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 02:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CC62BF3E2;
	Sat,  9 May 2026 02:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+KTQOTc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EAD26CE05
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 02:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778293448; cv=none; b=Bpdf2PflHc2g0UZSNP+UlLRxaEa/PNCAkkr79QrfBwsBg81wybIJR7lQqw2TwCrviN60zgZXVz0sxfDU64i8hQGp29teqaJcusuICSdrl1UsZFjZjWQOOxckBVm3sV7BDw3eoWXK1R8uHJ3bDtIp0xubQiLpEsarNOB15czWcu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778293448; c=relaxed/simple;
	bh=8xCzuGoMa3EVouDtS7MP5bJGcHY2FdaNPfAQigjEHDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDKpX5LdHDzdO68P+OBfXBugvNrYSUmIRsEKq9i5HSWdmgUKWs8RA0n8IGkRnBfVzttQOJ8eWKO6ufV4AzRUUaLM7OqwnDM9rDdFGqMTcUKoaY6jBnLRnNkou2DL5yRqUn11T66wxFDeqHPU6fScGusKWXXCEnREhgbDZbrYm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+KTQOTc; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so2264996f8f.2
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 19:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778293445; x=1778898245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlF48lM82LSPIeVK5Kjv9+BnttoylKzADPDmvRDQ1zk=;
        b=U+KTQOTcmNOMM5/ot0vS6bs/8fawqbx0gccwD8frskX5dVIYAlUGufPDwX7sXaprym
         2vbtSDGdfbHN50vgAXihMEhYQOzci3xtDY6l2VNOeaH3plmAGhuLq5jfp0Ke5iDWX5VT
         txMCeKq9c8ulycYfY1pstw5NCW+TNqUdeRXFj/5aipHdTWuErYQXLRQUS1EgDb4fxGMR
         URFULOEt15/gxtci9wf8paaBg62vFkz2Qj05LxcE1ChTse97uUnAKxobrUt2OGzZljAm
         Nt/LHqBuQXSeYorHX8w82rygA6/hH7KKvKeO9sAy0CIYEIyN5in5jTAoOFSLH+a6n2PQ
         nO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778293445; x=1778898245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PlF48lM82LSPIeVK5Kjv9+BnttoylKzADPDmvRDQ1zk=;
        b=GH3FgZ+taworzglcJVenrTJGvE5WDA3UicU9Qw1w8nVmbfSQtnPNUWxVA12RbcJy33
         u3QOI5H4t7fAFRjkLc5+IKmxgB+YSNz2+0HNGH03IM409OpqaFumnTeyBBHGeQS1MPBn
         WGhZzKjbMF8pjpLJ0xZS3OkImFo1BeLnD70koKl+XIOcT7PpyzwL/RLPhABk8Xzkg6Nr
         uPypOzlO49jn0dq9vd/qyOLykp+5VZJsaD1BvL4vIfbo2BI+wzI7btH68EWGK2VjYoYl
         77xwjf0GDJNSLRVsxotrsdKelhdF4FAEIDYyWeoFPUJ6axoIOuGf5m/GK7GS9OdV7ZFN
         JTSw==
X-Gm-Message-State: AOJu0YyCBGaOBa1KwADmgKx0cxKNDnSxKfczKyKXy8mjUuQPuW8pIgL7
	gunxGRZ08eoNTk1p25fXpX5D93h79hHZxIPyFbvVVKsTg+6QfSwqStfhXlFOpOW4
X-Gm-Gg: Acq92OHGnUVSNwK/b4t4Vcv/cfHixzk4C0jl+u7XnwHoSC6FhQfxeRpWAhhQkTUKYeJ
	zpdH51K6rPJqfNvmABdfiyTaDALu6DlpmPBE/0YUqnRHBixowpnikZq82zbOKpkiJJxVIsrhiUK
	cqBpS7LsAyZvxn+snAIaxs0J2+W/ZinCUeeH1gnjObRpJyxy6VMEfwaiI5Zo+kXYkkpWvPSYl+6
	zQYoiJlkY8Bt2ruoTr2e/1g7dy7tqvyGaOFhx86mrrw21xvFrAgl2MvYDa/X37zR9cddFRPK00T
	IqDXtdyvG61A0GveBLr8bvjsdLyml/HKyuBuDuX0cMrp7BuCDTZ5nAPVm4B3Lm4roy1+u0czC7x
	EuvITepP7BGWVtUyE+8lvPEwr2WzNK64FrISxhWOEDHRUz4cE/54nrBRgaeQEpY8IsgtZ/LpCRy
	VRQzr5QMvCn+59D+/qdbXi
X-Received: by 2002:a05:6000:381:b0:452:a209:560 with SMTP id ffacd0b85a97d-456a44f6b51mr1068478f8f.28.1778293445061;
        Fri, 08 May 2026 19:24:05 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:27::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491cab9c2sm9200166f8f.31.2026.05.08.19.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:24:04 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com
Subject: [PATCH iproute2-next v2 2/6] netshaper: Add bw-min and weight parameter support
Date: Fri,  8 May 2026 19:23:49 -0700
Message-ID: <20260509022353.3470738-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260509022353.3470738-1-mohsin.bashr@gmail.com>
References: <20260509022353.3470738-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B53CF4FD9CA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-286087-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,redhat.com,linux.microsoft.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Mohsin Bashir <hmohsin@meta.com>

Add bw-min and weight parameters to the set command. Previously
only bw-max was supported. Use boolean flags (has_bw_min,
has_bw_max, has_weight) to track which parameters were provided,
so that zero-valued attrs like bw-max 0 are correctly sent.
Only emit rate and weight attrs for the set command. Add device
name validation and only send handle id when explicitly provided.
Update usage text to reflect the new parameters.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 netshaper/netshaper.c | 59 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
index f90ceb11..186076a1 100644
--- a/netshaper/netshaper.c
+++ b/netshaper/netshaper.c
@@ -33,11 +33,13 @@ static void usage(void)
 		"OPTIONS := { -V[ersion] | -c[olor] | -help }\n"
 		"COMMAND := { set | get | delete } dev DEVNAME\n"
 		"	    handle scope HANDLE_SCOPE [id HANDLE_ID]\n"
-		"	    [bw-max BW_MAX]\n"
+		"	    [bw-min BW_MIN] [bw-max BW_MAX] [weight WEIGHT]\n"
+		"\n"
 		"Where: DEVNAME         := STRING\n"
 		"       HANDLE_SCOPE    := { netdev | queue | node }\n"
 		"       HANDLE_ID       := UINT (required for queue/node, optional for netdev)\n"
-		"       BW_MAX          := UINT{ kbit | mbit | gbit }\n");
+		"       BW_MAX/BW_MIN   := UINT{ kbit | mbit | gbit }\n"
+		"       WEIGHT          := UINT\n");
 }
 
 static const char *net_shaper_scope_names[NET_SHAPER_SCOPE_MAX + 1] = {
@@ -123,22 +125,40 @@ static int do_cmd(int argc, char **argv, int cmd)
 	GENL_REQUEST(req, 1024, genl_family, 0, NET_SHAPER_FAMILY_VERSION, cmd,
 		     NLM_F_REQUEST | NLM_F_ACK);
 
-	struct nlmsghdr *answer;
-	__u64 bw_max_bps = 0;
-	int ifindex = -1;
+	bool has_bw_min = false, has_bw_max = false, has_weight = false;
 	int handle_scope = NET_SHAPER_SCOPE_UNSPEC;
-	__u32 handle_id = 0;
+	__u64 bw_min_bps = 0, bw_max_bps = 0;
+	__u32 handle_id = 0, weight = 0;
 	bool handle_present = false;
-	int err;
+	bool has_handle_id = false;
+	struct nlmsghdr *answer;
+	int err, ifindex = -1;
 
 	while (argc > 0) {
 		if (strcmp(*argv, "dev") == 0) {
 			NEXT_ARG();
 			ifindex = ll_name_to_index(*argv);
+			if (ifindex == 0) {
+				fprintf(stderr, "Device \"%s\" not found\n", *argv);
+				return -1;
+			}
+		} else if (strcmp(*argv, "bw-min") == 0) {
+			NEXT_ARG();
+			if (parse_rate(*argv, &bw_min_bps))
+				return -1;
+			has_bw_min = true;
 		} else if (strcmp(*argv, "bw-max") == 0) {
 			NEXT_ARG();
 			if (parse_rate(*argv, &bw_max_bps))
 				return -1;
+			has_bw_max = true;
+		} else if (strcmp(*argv, "weight") == 0) {
+			NEXT_ARG();
+			if (get_unsigned(&weight, *argv, 10)) {
+				fprintf(stderr, "Invalid weight value\n");
+				return -1;
+			}
+			has_weight = true;
 		} else if (strcmp(*argv, "handle") == 0) {
 			handle_present = true;
 			NEXT_ARG();
@@ -165,6 +185,7 @@ static int do_cmd(int argc, char **argv, int cmd)
 						fprintf(stderr, "Invalid handle id\n");
 						return -1;
 					}
+					has_handle_id = true;
 				}
 			} else {
 				/* For queue/node scope, id is required */
@@ -179,6 +200,7 @@ static int do_cmd(int argc, char **argv, int cmd)
 					fprintf(stderr, "Invalid handle id\n");
 					return -1;
 				}
+				has_handle_id = true;
 			}
 		} else {
 			fprintf(stderr, "What is \"%s\"\n", *argv);
@@ -195,19 +217,32 @@ static int do_cmd(int argc, char **argv, int cmd)
 	if (!handle_present)
 		missarg("handle");
 
-	if (cmd == NET_SHAPER_CMD_SET && bw_max_bps == 0)
-		missarg("bw-max");
+	if (cmd == NET_SHAPER_CMD_SET && !has_bw_min && !has_bw_max && !has_weight)
+		missarg("bw-min, bw-max, or weight");
 
 	addattr32(&req.n, sizeof(req), NET_SHAPER_A_IFINDEX, ifindex);
 
 	struct rtattr *handle = addattr_nest(&req.n, sizeof(req),
 					     NET_SHAPER_A_HANDLE | NLA_F_NESTED);
 	addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_SCOPE, handle_scope);
-	addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_ID, handle_id);
+	if (has_handle_id)
+		addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_ID, handle_id);
 	addattr_nest_end(&req.n, handle);
 
-	if (cmd == NET_SHAPER_CMD_SET)
-		addattr64(&req.n, sizeof(req), NET_SHAPER_A_BW_MAX, bw_max_bps);
+	if (cmd == NET_SHAPER_CMD_SET) {
+		if (has_bw_min)
+			addattr64(&req.n, sizeof(req), NET_SHAPER_A_BW_MIN,
+				  bw_min_bps);
+		if (has_bw_max)
+			addattr64(&req.n, sizeof(req), NET_SHAPER_A_BW_MAX,
+				  bw_max_bps);
+		if (has_weight)
+			addattr32(&req.n, sizeof(req), NET_SHAPER_A_WEIGHT,
+				  weight);
+		if (has_bw_min || has_bw_max)
+			addattr32(&req.n, sizeof(req), NET_SHAPER_A_METRIC,
+				  NET_SHAPER_METRIC_BPS);
+	}
 
 	err = rtnl_talk(&gen_rth, &req.n, &answer);
 	if (err < 0) {
-- 
2.53.0-Meta


