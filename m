Return-Path: <netdev+bounces-286794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA87NbkiAmonoQEAu9opvQ
	(envelope-from <netdev+bounces-286794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:40:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D16595148D7
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40A0530074D6
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034A34ADD92;
	Mon, 11 May 2026 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiRI74zG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2E54A33FC
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778524774; cv=none; b=b1Mv7rd3WxuwtfzRd+wJyzfyVSibTQym2nJearrfO/RSkVbmD7PmQrZn7duij0GT2KmImoPKruRZ6m0MdGTXU+KL5xT6DN/9oMf3NSHW0vhaLw3whbCuazgj03iwSB3+TE9UgVUDY1b2AuMm2/ioyUp6A/wR7L4zoCjqkogiOsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778524774; c=relaxed/simple;
	bh=LyL2uVUiJkOxhiLkWme8ixZC/D0OGIuEGUppYBU/yGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xn6glUBfQlTTm4klIkCc/WtY+S8hN8E35L4U/j9tzaIgha/QruGdBg1kmpXU0JM0rKq+v2NTLowhV0nBvUNDAzsCXP+t4sq3CIk80M7q6R2KKpss6xea7U+mGvQ3/jlLu1VGLpXNEzmvVcR8HSR76D/S+Gwof3qUPmd2pR2hjEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiRI74zG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-44e5624c053so2627512f8f.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 11:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778524763; x=1779129563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqfMUHJxk7ubEjQISnXt1OAzsplBLTkyFaCbZ3M56kk=;
        b=aiRI74zGYTGDFa9zhuJRL1+3mg5Wzqyzg1M+mAF/r9nE7vlIhq9cpeO9eTVCtkY1r9
         ByJhOablnYWSL9Y/ENTP9xLfQmzDtrNazYM6VskrVH9lJ/YiagyHwyqkOyRCr/QoB0Gu
         sVFJIY6VqryTh9p78JRI45hwFI7Tz8i3ZXRii429lGVOXnpjXpb7hs5QTnXt3E/BYaXJ
         /ZD4EUbH9MOKK9oz0VR1gDn7DT+FFzC05k1iMyZba/ehTMmKStv0YhKgTcUG+ZXMuyf+
         auxoU7tC1GiO/ycE/AYeGNNOcujcJa4vhLWw+8nOmgiLyqTj2LguJpIq5aD8LRxSJS8n
         s+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778524763; x=1779129563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LqfMUHJxk7ubEjQISnXt1OAzsplBLTkyFaCbZ3M56kk=;
        b=pXA6bKkcaiolys3z2ihlwbBQmR4fdyi1BZJ48pnuJ+CyNMefGD6dryBbSkgNLoShd+
         bceVXn2K0Tta18XVmghJAlLX9mGoNFDxDT7alIqcTQzg+Nh6InrCvRQaF09zkziRjIz/
         xEMXPuLt1QA7Se6nQ1iJ5ArrOCLUVt+9++t0GXm7v3FWnb10R5r0e2KEU+RF3fl3W96c
         qQcvjAYrH2EaqLBY0sIlOd4jDrB9bSTwCNgL7G59oaUNAHZKh/kYCz4tIbwH9bRGgBCZ
         WwSDYcjGnLN+rbZrVV+LittXnF5xxxwQlGDuuCkS7C+d2AjDX+5DV6QtfJf4qEwf6lIy
         kFuw==
X-Gm-Message-State: AOJu0YwMz5TTyf66UsEXhtHUqOOrmtT9u6koMNoPzzEIBBx6VGYZlSZ5
	83du5y21O/LjiuKNKg3m7WkfGCooEz5YCWYRSK49XLzy8MSuzrtdDkidG/M21KR2
X-Gm-Gg: Acq92OFEf6j0St0kmcjF00eyoA9pavkC6EMSfqmSgsRr7y+GB09FTqBLkAvTRQj9Yx0
	5Xi4SqhvqgALfmsIj7h0KJTu0MmdzjaGQBBreO0dOoHM4msslTmpDkrtGvOa44esfrv0++v2kMc
	8Jqw6Lj1oRNJiTHDWXST1WPiv+XZheso+DENmBl3ulI4l0yir6cpgCj7RRRQ1PvCXQaalqaVujm
	1upmebikflg+uT1m513BDBqCN0T0PexFHDmcYPmGrSfmlRxaJZzR6NNz9dOohczF06U02Y9jNIK
	Zc/0wVcCf54uM/vqp4nQt/t1FJ9cqkgPtgcq7KH/wOn3u9pv8qSuE1AOYzyhUovj8UpHAjwdelH
	JCXBjVfBx1AmSP3rxX1ivqA5G7Gs3Vc7aSWriclliPoWR71tWLbLashPRf0u78qrmyHiYzAHjQ1
	tPq1noVGW501QvCosbiqWh
X-Received: by 2002:a5d:588f:0:b0:43c:f583:126a with SMTP id ffacd0b85a97d-4515b5243famr39873910f8f.14.1778524762648;
        Mon, 11 May 2026 11:39:22 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:1f::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a66bfsm23933265f8f.4.2026.05.11.11.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:39:22 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com,
	alexanderduyck@gmail.com,
	Claude Assistant <noreply@anthropic.com>
Subject: [PATCH iproute2-next v3 2/6] netshaper: Add bw-min and weight parameter support
Date: Mon, 11 May 2026 11:39:11 -0700
Message-ID: <20260511183915.797792-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260511183915.797792-1-mohsin.bashr@gmail.com>
References: <20260511183915.797792-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D16595148D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-286794-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,redhat.com,linux.microsoft.com,gmail.com,anthropic.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anthropic.com:email,meta.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Mohsin Bashir <hmohsin@meta.com>

Add bw-min and weight parameters to the set command. Previously
only bw-max was supported. Use boolean flags (has_bw_min,
has_bw_max, has_weight) to track which parameters were provided,
so that zero-valued attrs like bw-max 0 are correctly sent.
Only emit rate and weight attrs for the set command. Add device
name validation and only send handle id when explicitly provided.
Update usage text to reflect the new parameters.

Reviewed-by: Claude Assistant <noreply@anthropic.com>
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


