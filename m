Return-Path: <netdev+bounces-106105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5618F914DD3
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9430AB23DB6
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FC513D622;
	Mon, 24 Jun 2024 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="xaJOzwfL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E913A13699A
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234062; cv=none; b=ua4AX2ErcyKUVbcsU6iL7hhCYgDzxd6AeX+ZulHKNDw4n76IYsAFUGMl9isWJSi2LVClmhbes7upcD609x2aFHYYmni/JzYItqL3IeX69HKF06P/Z38D44paSR/Ik+K19u9GmuvvHrDd178/DUKl5mwj3WTgDIZLi8T03aHTWZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234062; c=relaxed/simple;
	bh=xnE3v2fU7NxIpzyZJ2ceEC+dccvprNag/D4piqTJLCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lkV7AW5wiHv73yRIGL4Fno0vAXnJsdu4v6bcg6jVoof5tvHz78/e5weA1+3E1DTLn6atxy1aZ7+18FvMgo93cIY07uveCe/kzLoUy3jLksdUCsWfkLCasPZAkI+UAmQVVcsy3QcGqx/pPpqzYUVjc+2qzTLhU2VX3UDwwkWhdRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=xaJOzwfL; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52cdea1387eso1995044e87.0
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 06:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1719234059; x=1719838859; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u0S+LRarOvOVQhRVeLVj58mXdHnF8qmLz8b6eobZUBs=;
        b=xaJOzwfLnQRfC20j+USWNgWOqotJV0Yw6M+FK7g3Oc4roQA4va2X43F6Dx48ra+Pn+
         tbnKN8DEW5B51tRxoU8FbuSHun21uMNq6HIx+LSuQFXkEwrVDAkM3fpQYipgtskLUvUa
         0574fynYXxOK9Crn0su5uWJSC1vbeMfcWc5K7OCVoRvBOPb9NAvxPSCFvT0u74l0kWDq
         VJsuFLOcwfJRlNFQIxrJHAXDcBJQ0aWKm48YAzFwkfh2PPHLph3oCyWoxmb4afLsyb8P
         LakhFlXWmv9x5MrE0DlXO53h05Z7SYaw+uyqx+5agrx9/mecLfofmsMSSfFRrIvTHuTq
         OBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719234059; x=1719838859;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u0S+LRarOvOVQhRVeLVj58mXdHnF8qmLz8b6eobZUBs=;
        b=jF/Ns+s7KWz4h0V0UqDwoRf1poNE29nZhfO/iG6YX2SSOin2HpPivsftmKzHMrD9q8
         5e3F0f4Gk6N5A1Q1esxIwvXGgVG+7OCoxeYX2R3fmelRldYr/VZyGTNI/6HqKWU+NkIB
         PA2UfPToNO/2GwjW3JfOLcUMBIc6SqGjJgIuhLLakJaRttvo+O6YJnmSYMOevSGlo5XH
         vX9p3piFiCfzjZJKpEuROOjTIqA/DhXvEMHIKPBpJzpySkU44GkvK7CY37Kz9hrgRb3/
         uSVxK2QaD6y+a/sqWFg24G2G+ufVNoF9ua811qyQSWvp4TKZB2afqUBwQue+Pw9Hm2TZ
         sSeg==
X-Forwarded-Encrypted: i=1; AJvYcCXVruwTbJelh822A6kIvgglDcwxYyKLPTnnyXXjzhJPWVt0GcDSub19N9n4gP1EHW3s5mUlC1EXAGMxe5RQ2Rsnjozg/Kdx
X-Gm-Message-State: AOJu0YzPvCEWnNNvvYIJQ2qkOvUfs+dwY6WUW3CFxIkQm6ikDxLGSBPM
	KMp2Y9LBlEQKbsNMz/VCKHB24ebKeHPqbSivnC+LofdbS6Z7fve0Ne0QGW4EMeg=
X-Google-Smtp-Source: AGHT+IGyvI4gZnxJKRtt5b+1pabodPynS1nmb/JHqR1uMChQmrVzErXxCsV5ayfG2l8wX3sJ3F89lA==
X-Received: by 2002:a19:7407:0:b0:52c:cca8:db45 with SMTP id 2adb3069b0e04-52ce185fa61mr2464084e87.46.1719234059291;
        Mon, 24 Jun 2024 06:00:59 -0700 (PDT)
Received: from wkz-x13.addiva.ad (h-176-10-146-181.NA.cust.bahnhof.se. [176.10.146.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd6432bd9sm981827e87.227.2024.06.24.06.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:00:58 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: liuhangbin@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH v2 iproute2 2/3] bridge: vlan: Add support for setting a VLANs MSTI
Date: Mon, 24 Jun 2024 15:00:34 +0200
Message-Id: <20240624130035.3689606-3-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624130035.3689606-1-tobias@waldekranz.com>
References: <20240624130035.3689606-1-tobias@waldekranz.com>
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


