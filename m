Return-Path: <netdev+bounces-289168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wItdC6J2C2o+IAUAu9opvQ
	(envelope-from <netdev+bounces-289168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 22:29:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF21573667
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 22:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 770433024C87
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768DE391828;
	Mon, 18 May 2026 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odflPI/Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1643392803
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135847; cv=none; b=nWnRPyOsZNcLO/CW1wVVGzTkJWLHIuWDCkz1HbnC4iRpBLnsj32T0/XlNZWlhS1i6peXzZsadvkXfbDZCciwUkJwe7/69/IVaZqyn+a79rPNX9nH14A3QZd/PFJYfoq74iDWGcR9uZAms+mkHMif3xfbPdvNze01b/km2qVBJe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135847; c=relaxed/simple;
	bh=Z6wBTYLNy4MC9N5u+2okO/yNc3Ap46OztTJTBRAnkxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEHRosdd7hrLfCg+ASspjmZRYKOPpNLuopdtZ0z+ssEOiQ98RIP2XjnUxhOgmH/7Y5foMKFOI4t8I/uKVUMn45qz5PVhv0ZvBfjDfTisoojOBQGKIBzeqmoTUABHZv9F1SsyOQPlmcqxTulXL8OhNl+WsowpFt+shfhyhnuKWQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=odflPI/Y; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bd4f8260e4eso561635366b.1
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 13:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779135844; x=1779740644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CerWS9eKLApaDW54qzizAIz0Akx2Ni2s/5n6GDDC+0=;
        b=odflPI/YSESmKN2/v37Ur6dEbC5owfkc5BnznThlpgJ1fBYg+977r0QI6XW4HmqB9Y
         gcqXrejxZRw1DrapA1o0evNqweuGfSej/+V6bdHWyeRvCX7fF0fBWz0NAMQ0RkaFVmAn
         kDa4LFt6QzYJkzOM4uZrzhEaBQnBhjUFSN23uE2HeP4Fv5labBKsJ94nhoWSmS9wGBEf
         IY1re2cVGzQtIya4uliXLroLB0j7pGs2NgAfAFmDUMl8q4eD1D9ZR30CeUaggHb9gziW
         Sf3H7pc34/0H/ZM59pW89UAdT+es9WHz3rN/kDBaEPbmaY4ECWJhFE3EKbXMUbEoqR+x
         D/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779135844; x=1779740644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8CerWS9eKLApaDW54qzizAIz0Akx2Ni2s/5n6GDDC+0=;
        b=Y+xJUkA06oGFi7ZuxZ3/TmW6CH7LShRtJgkierCg67AWDrvYlkMt1YFW7M/Hjv2Frq
         yRIdkD2puL3Fof8L73XEhbXnjYUlxkPgJ0hzmVTKNxxOzkJ/PRF2Aq2kbUJ/FHVcVakx
         Ldi2QPHP8UL8VgD+b0jld9UvAxnD555IQdNA5sk+hKZzYsepWKN5Mwt5DPROin0o8oX1
         U8QnovT1CsLMy++pGpCiRXhit5fKI6oXEyNyeHkUHH4/NNQD0l72i3cKhm+2EyUfn9MI
         nDgRoykNOIcqiMm0Uim/VrDxrv27BdpdmLtok/L+TrQViPM8jbIlj16HHt6bI2MeVVWe
         Eqog==
X-Gm-Message-State: AOJu0YyjWp2MXOKtvod9lLVgznUf/AsFEzXiwHwjIlWX9ypo+xWju3zw
	/spGKWuSSo5JIM0zbDHbLDiRjLcqOly7Xy5ZJXhYFvJRAyhjXarhWaCjx5zF2AigBy4=
X-Gm-Gg: Acq92OHgWlsYECbEzxqrhBmAYi0exHqxkE52mXuGgBl4nGze7/p6oq0d7jLJtTK4aRz
	3fwr0twc+ikhYWkPY3UXZPVCD3YwBBwgjqSUW1ojG2/hN8tV/RKuO8x86+R3aTPKTRvQanx7PV9
	5wUPYVPG6XUOxfVpM8Nm3wxjCD7Zkk2uRoFkFm5c/67LzdRleRdXrdm+3kGs2gBXrOppQAYp69v
	gwoycno+l5s2SBcUvJ5NtdALq4B0jQe7Ik1cyYMOGEPF1wAEWCZFuENuSfgGQlIuqUy4q2K5IOP
	EVoZ0UdLrbD8VeP3MrtwvbSXBjtk7vlJka5/QfzzXRVrsFSj9/T1eiY9xNt1vJjAyHcVLIqzGb2
	LJAvBL/0yBGCk/b5gsOepWk0dVp7vj0fGgo32rfHqO7FnOhTb15kNae1ImfEDXuyTq+AEf/sru9
	POwZ1VTVFb17QSZpIQkcuyrnaESpzC6fw=
X-Received: by 2002:a17:907:940f:b0:bd2:aeaf:470c with SMTP id a640c23a62f3a-bd51795b268mr870153066b.40.1779135843939;
        Mon, 18 May 2026 13:24:03 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:43::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4e2d75bsm601422966b.45.2026.05.18.13.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 13:24:03 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexander.duyck@gmail.com,
	dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com
Subject: [iproute2-next V4 2/6] netshaper: Add bw-min and weight parameter support
Date: Mon, 18 May 2026 13:23:49 -0700
Message-ID: <20260518202353.390827-3-mohsin.bashr@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289168-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8EF21573667
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mohsin Bashir <hmohsin@meta.com>

Add bw-min and weight parameters to the set command. Previously
only bw-max was supported. Use boolean flags (has_bw_min,
has_bw_max, has_weight) to track which parameters were provided,
so that zero-valued attrs like bw-max 0 are correctly sent.
Only emit rate and weight attrs for the set command. Add device
name validation and only send handle id when explicitly provided.
Update usage text to reflect the new parameters.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
---
 netshaper/netshaper.c | 59 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
index f90ceb11..74175b39 100644
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
+		"       BW_MIN/BW_MAX   := UINT{ kbit | mbit | gbit }\n"
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


