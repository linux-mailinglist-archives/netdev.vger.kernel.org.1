Return-Path: <netdev+bounces-108443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8B2923D43
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E861C22E3C
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 12:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F5916B735;
	Tue,  2 Jul 2024 12:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="i+RnPTbq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625D11662F4
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719922117; cv=none; b=Kor0Les+KMQtbkKMHB3Czm6yC12Z3k43IMPl1tlBlFBfHSPVFbpw7tUtnsBUvYnEZUTi5wD2PEqJWavG1rPbmo//qflbJTCYLcXtxnPxZY5oZ4eQYDpghj2zk0UJo1Pb4yDj7TSJcyTaDSlFNo3vfmXZgV69Y4hKjhx533qAITw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719922117; c=relaxed/simple;
	bh=L4iknHWv24LRJnoIT3fvpcqfrurIP2YwW3xU1mKpwnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S4Qa+KVpXITmcrv2w1WOeEp0v87zcnJDneRvruAAPoAejTFbyNCW4/kWEaxCFj6DyjYj4rB8hzUY+TGVLdL9MGGmWDL2vaUzmYiqTeTvpqQMakGJRDmvnxh0yKVFqMgsgYRceLNs6443uE/8ZeOaUknLRHm9CoxDmTkeMGeGMWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=i+RnPTbq; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5295eb47b48so4975328e87.1
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 05:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1719922114; x=1720526914; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FCahmSEYU6tX9FqLb0Uk9Z14eoHvtjROOSdSw1YJQpE=;
        b=i+RnPTbqW9Wud0G6Bnk2/LZeFidNEwfAnlcDCj3sddtWNmo96DBcDwPN36CJ4gkWWZ
         T86aCNjs4le8Pw7Fsy5XHdjPlqTJwlErnc8KJS/PGaM85dFYnoDNA6umpaRnVNEY20CT
         ICloCOIb51nSxK46M4sZ3jnRsbrs83KXxKDyNQCrVBA3jM7wOt1Hwn2CtAZI4roSwC4F
         oskcNhyBZePZBlLAJ6516gSZm4l+MPUDlDCK0wWKw+7ZoEaz7GtnmzW5aiNKfHfZkohf
         AqL7LT4nERe5vtEK7+Achf0sHsb6J913C8RMQiSwytGCW4f6p58YWB3wWdvGL2lrbTnB
         3I+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719922114; x=1720526914;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FCahmSEYU6tX9FqLb0Uk9Z14eoHvtjROOSdSw1YJQpE=;
        b=kog49iI6/yUFsVuzZ5lrb8r90gOPi2h3BK5NFo95nLeyYIRIxuwmvSkCk34LU7Mq0N
         Y0efQylP96J69qjKZ+7wDpUlvgo5DEPfN3R5mud6GjU+MflxsUX/XslCZ0AN/isAIeQM
         nXVDV1sqsQIII8TFu7LVlTRxlkxMjwgvD07faGzZNlEGM1DKYzkS2dYck5VzHCBZeMEv
         pJVWbKE/nMIguBRx4F9odNqBMv66iS4ItC1/dkUsSr4SeA4jMLm5jji+7ngGzFdHjodB
         E0zKaltGiNDAnMHi7Mroh2atB7cYq0UPV7qJIh+iYU65J3wDHl9QHbtwUKCG61WMWsGA
         MQPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsPzEJrr9oY2luNu2uERw5rkrDvwX83tumeBoVdrtCH/D0uurfZEaRj83F4HNlmVs0WE24aTx6POlhzE8TDOkH8M56kTro
X-Gm-Message-State: AOJu0YxAMK8sLf+EGilSaO9JRC1P/Esro0svt80Smt6kL0Fp40o3Ib6o
	A8slAB7R7bicoO60m7eu0p1V7Jzfdo8KmMUXlGmWPDHh/yoBWA0jbc0LJKBKm78=
X-Google-Smtp-Source: AGHT+IHa8FAMkx5Vj/lheTFRq2vnO8kcgH30G8QkbdtT9a7fNLM9xq68XDWCaFIdq1JAVFRY9tlAWw==
X-Received: by 2002:a05:6512:3e28:b0:52c:a5cb:69e4 with SMTP id 2adb3069b0e04-52e826f12d1mr5949124e87.54.1719922113775;
        Tue, 02 Jul 2024 05:08:33 -0700 (PDT)
Received: from wkz-x13.addiva.ad (h-176-10-146-181.NA.cust.bahnhof.se. [176.10.146.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab1064asm1799414e87.103.2024.07.02.05.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 05:08:32 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org
Cc: liuhangbin@gmail.com
Subject: [PATCH v3 iproute2 3/4] bridge: vlan: Add support for setting a VLANs MSTI
Date: Tue,  2 Jul 2024 14:08:04 +0200
Message-Id: <20240702120805.2391594-4-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702120805.2391594-1-tobias@waldekranz.com>
References: <20240702120805.2391594-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

Allow the user to associate one or more VLANs with a multiple spanning
tree instance (MSTI), when MST is enabled on the bridge.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 bridge/vlan.c     | 13 +++++++++++++
 man/man8/bridge.8 |  9 ++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/bridge/vlan.c b/bridge/vlan.c
index 70f01aff..ea4aff93 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -53,6 +53,7 @@ static void usage(void)
 		"                      [ mcast_querier_interval QUERIER_INTERVAL ]\n"
 		"                      [ mcast_query_interval QUERY_INTERVAL ]\n"
 		"                      [ mcast_query_response_interval QUERY_RESPONSE_INTERVAL ]\n"
+		"                      [ msti MSTI ]\n"
 		"       bridge vlan global { show } [ dev DEV ] [ vid VLAN_ID ]\n");
 	exit(-1);
 }
@@ -403,6 +404,7 @@ static int vlan_global_option_set(int argc, char **argv)
 	short vid = -1;
 	__u64 val64;
 	__u32 val32;
+	__u16 val16;
 	__u8 val8;
 
 	afspec = addattr_nest(&req.n, sizeof(req),
@@ -533,6 +535,12 @@ static int vlan_global_option_set(int argc, char **argv)
 			addattr64(&req.n, 1024,
 				  BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_INTVL,
 				  val64);
+		} else if (strcmp(*argv, "msti") == 0) {
+			NEXT_ARG();
+			if (get_u16(&val16, *argv, 0))
+				invarg("invalid msti", *argv);
+			addattr16(&req.n, 1024,
+				 BRIDGE_VLANDB_GOPTS_MSTI, val16);
 		} else {
 			if (strcmp(*argv, "help") == 0)
 				NEXT_ARG();
@@ -942,6 +950,11 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
 			     "mcast_query_response_interval %llu ",
 			     rta_getattr_u64(vattr));
 	}
+	if (vtb[BRIDGE_VLANDB_GOPTS_MSTI]) {
+		vattr = vtb[BRIDGE_VLANDB_GOPTS_MSTI];
+		print_uint(PRINT_ANY, "msti", "msti %u ",
+			   rta_getattr_u16(vattr));
+	}
 	print_nl();
 	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_ROUTER_PORTS]) {
 		vattr = RTA_DATA(vtb[BRIDGE_VLANDB_GOPTS_MCAST_ROUTER_PORTS]);
diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index bb02bd27..b4699801 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -266,7 +266,9 @@ bridge \- show / manipulate bridge addresses and devices
 .B mcast_query_interval
 .IR QUERY_INTERVAL " ] [ "
 .B mcast_query_response_interval
-.IR QUERY_RESPONSE_INTERVAL " ]"
+.IR QUERY_RESPONSE_INTERVAL " ] [ "
+.B msti
+.IR MSTI " ]"
 
 .ti -8
 .BR "bridge vlan global" " [ " show " ] [ "
@@ -1493,6 +1495,11 @@ startup phase.
 set the Max Response Time/Maximum Response Delay for IGMP/MLD
 queries sent by the bridge.
 
+.TP
+.BI msti " MSTI "
+associate the VLAN with the specified multiple spanning tree instance
+(MSTI).
+
 .SS bridge vlan global show - list global vlan options.
 
 This command displays the global VLAN options for each VLAN entry.
-- 
2.34.1


