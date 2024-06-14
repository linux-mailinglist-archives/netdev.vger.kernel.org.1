Return-Path: <netdev+bounces-103613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C03908C9A
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 15:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D8B1F257BD
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 13:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D0719D8BA;
	Fri, 14 Jun 2024 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="CLVVA4AN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B141C27
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372339; cv=none; b=jwFQI+iftKiSRlPNSqsxOZ5QCZPKJtmZemySk/PT/4W4r4kYNlIu86RUzmZv+P9pxUiGRWqGF+vvggFF8XibWgRZvF32M01hWztEnxChaAQSeeOZi44bvvht44HuJgozes4KMgsW7MQ5V1F/t23jdSdFU+MyPgPiY71ktOVV7AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372339; c=relaxed/simple;
	bh=xnE3v2fU7NxIpzyZJ2ceEC+dccvprNag/D4piqTJLCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YgESUqdKg1jT8SN6AG9wrsc76p/NZ82Xqd41ssGm5rg2JHF632zQXuBwSSQe0KX/7k64v5gwvWWtocUHZWbhJGWp5AzawJf9pFfjpQXao+8kCwpMOHyNfIaOAnCFnROHAgjm/50d5kFK3Pbgg7WQ2prgQvkf26LvVYYcu12ytK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=CLVVA4AN; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ebd421a931so21485371fa.1
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 06:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1718372336; x=1718977136; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u0S+LRarOvOVQhRVeLVj58mXdHnF8qmLz8b6eobZUBs=;
        b=CLVVA4ANXzUMP8KWaqiKIlj11a3Tb7xwsd0oLp41mRIVcxgypsmE2Fe3ZYrWyhdVlq
         LI6fxu9H2yXS5TmhLnvg8AFVI6pqIZteP3mx8WiWpCCK4AKlxzWZXdmbbD1ZOmsva/fs
         +rInHU6t4AyDghUTbqgvdAp2kRX96JDpvnlDLnAkBZ+wdD/0Qt/MK2Igwp9WtOivH1V+
         lnsncJxCBsFeGoK1MtEaqGZ7CbakTRy6ECuqrZuCVR2PCU8I4Dy6bLQKMwWp+RCUUkeG
         rd/loLFqFSEAr6jLvnr0p2EUAUsYeoVYWpEtA6ZnZBOpkToEmf2OfHcw2vNi/mQyOxou
         UmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718372336; x=1718977136;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u0S+LRarOvOVQhRVeLVj58mXdHnF8qmLz8b6eobZUBs=;
        b=MYRqbkJS7QSr99vTUwRhThXro3/bjYdH04wfQXOnDV1ky3gH5PigxdTY7NU246xJDb
         IoJbFBbdRxIqhysjvrMqwaWnjUG5AJmc4KqMjlztHjfV+K7Rsh6GAYaFJrXq5RUQc2bd
         Aat4bFGrfGXyfWMAmAhyjGheCcvwyF5gGQ7LCzIc2MOHBTocUyruSUclVcDmnV+KDlKV
         oMbx2LNgBGLXkGtwQK4BxDkw4j3ggMAi/BhlJSSV1WKeLvuopM8FyVTuI2sXZ9mr+7uG
         z8zlCdwkN0WbxZWJ+aLZQZm+Jir8c/J1kLO8hqBTqr8sY6bmwsg0amFoRCII3jP9xmV7
         IK2w==
X-Forwarded-Encrypted: i=1; AJvYcCWmmLtnlg+EcFRn/EUXcVgYOz5ddczyq8/ndWekMDgI54QZXEHPgCtIZKLDFCcMPM1qg00GKDKIOEjYc5rxBg4/9t942Mpr
X-Gm-Message-State: AOJu0YyhNTzpnDINtSFHhJQzZjk/arjFkq6IcUAQVTDzLAQi2DtS5VQR
	c2xIi98uL2Ua+BueuTbDkisUoSBBbvH/CLxVTenOKeBrH4oynqMcz7Whpsw/YGc=
X-Google-Smtp-Source: AGHT+IHKZDtHfMwsnJm+qDyAeGSnQhp6dFxmtliJyzHeZS27UXqCWt+2+mX/w6z9ZKpcvsj67mvD9g==
X-Received: by 2002:a2e:9f44:0:b0:2ea:e98e:4399 with SMTP id 38308e7fff4ca-2ec0e5ffc00mr19536901fa.36.1718372336046;
        Fri, 14 Jun 2024 06:38:56 -0700 (PDT)
Received: from wkz-x13.addiva.ad (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c179c5sm5327621fa.67.2024.06.14.06.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 06:38:55 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: liuhangbin@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH iproute2 2/3] bridge: vlan: Add support for setting a VLANs MSTI
Date: Fri, 14 Jun 2024 15:38:17 +0200
Message-Id: <20240614133818.14876-3-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614133818.14876-1-tobias@waldekranz.com>
References: <20240614133818.14876-1-tobias@waldekranz.com>
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

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 bridge/vlan.c     | 13 +++++++++++++
 man/man8/bridge.8 |  9 ++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/bridge/vlan.c b/bridge/vlan.c
index 0a7e6c45..34d7f767 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -56,6 +56,7 @@ static void usage(void)
 		"                      [ mcast_querier_interval QUERIER_INTERVAL ]\n"
 		"                      [ mcast_query_interval QUERY_INTERVAL ]\n"
 		"                      [ mcast_query_response_interval QUERY_RESPONSE_INTERVAL ]\n"
+		"                      [ msti MSTI ]\n"
 		"       bridge vlan global { show } [ dev DEV ] [ vid VLAN_ID ]\n");
 	exit(-1);
 }
@@ -406,6 +407,7 @@ static int vlan_global_option_set(int argc, char **argv)
 	short vid = -1;
 	__u64 val64;
 	__u32 val32;
+	__u16 val16;
 	__u8 val8;
 
 	afspec = addattr_nest(&req.n, sizeof(req),
@@ -536,6 +538,12 @@ static int vlan_global_option_set(int argc, char **argv)
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
@@ -945,6 +953,11 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
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


