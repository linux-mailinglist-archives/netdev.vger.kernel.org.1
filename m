Return-Path: <netdev+bounces-134956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566C499BAF7
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 20:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D342809AA
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 18:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5C7148FF5;
	Sun, 13 Oct 2024 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjrIYR9q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E70D1465AB
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 18:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728845599; cv=none; b=JJpjxOGri+LL4Ss53stS4utuoGFv3hXAX2/HdpIYo8h2rAVbAOW8NULIiP2RHR3a/t7G5cZxtMdQ8ZS6S28sCn5dBOtlSNleoDIGA93OEdOmhjbK9usPR6s2CU0qJZnkiXCMFIE6KtMaWIkYgnHzdFkjJuGRCgJMRv7CuptOZ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728845599; c=relaxed/simple;
	bh=g5Fwsyk9ayeonaiH+LbkjuLh6j338ra71Wigydu4Wh8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n6Auvki9yJ81WObTotRVZL3NxSF45pfTnEyOhWB2UsI5kX0lpHSOBcScD6RGnHh0UAtXGEUnb9qvEQuyAkn9yFtMtaHvp8bTTUWOP+iPptINBSsTVpaJu6Cnm8DTk2ysH4NZX4fE9QCkSOr9LTWwUXFj+uEZTKz6YgksQAH4E4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjrIYR9q; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d495d217bso3109121f8f.0
        for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 11:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728845594; x=1729450394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FxEljXXtRob3m8tvJlZFitBgQs2JmDPN2nfOkukmcng=;
        b=LjrIYR9qSNjVF5bTe0rzWpSrHD5/lrBabeePZaL0CRyl29T20vcEmQ7UMBbo4ZESft
         A7tj1R22JlI0C3BPEWK/jYnIMABFokknRaepqJWJYEK3DQqXPW1pf/zSkCz9eqVpUezA
         xRTm5r7L8MGRo2iJ829yZd5vAlaiY77YDQRh4Nfm8DeUcIYeIBJ3SSL0lpi3PK+/xvEQ
         dsJ5W/H4s3JH2YL9+5rGVi2C7MsB0OscketDdkaPcyX9aFiwW364LQ8ZgyHXjHkH1UId
         cTqdSXqsrHxJkYq2u6R/VsjKTXTqeeD6jaOrG2N9fbh9az6hB2W+ypo/sd8o3XUVDVSm
         am9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728845594; x=1729450394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FxEljXXtRob3m8tvJlZFitBgQs2JmDPN2nfOkukmcng=;
        b=NJzq353kaca4PH3DhZyE6XuBh8EirA9yhfOd3VAg9VSwJaSb/q9k/72OuEfIXRCmte
         lAw45fG/L1oCwA6aXcpv3d6xbWwzFtQYfsp01E96lK/EE97mL/TfNAKvXMoggZ1EYCHj
         EpNxXtd/06oA2oQM8s7VGqwi8ZqlqK2ga5dcrt4cNH+vFz4e/HjE3daugBXdJZ1jXmjb
         HISeuxENNDb3cSpAyDh6GAAxmqpPE+N9ecmpD/ihseMC4/f5SaOeXRXPxvpP0kBtrTwd
         8iiiCNK6c1meiPchmYIPKpD0/3w7f+8ff2UWJq4aT9vccqte80Qaluvr8lRbWqLPf3Q4
         iDWw==
X-Gm-Message-State: AOJu0YxWkB7KAj6v7bL/XZWK+SdlLRBvcfqqdcqvosIv5exMGS5qY2SJ
	Uz5U2CpWjy/wova2YLyukA6g8JDv89/gzkEdcnsROsKhFpWHo+NsuKJQZ/ZK
X-Google-Smtp-Source: AGHT+IEo5a0TVDp+X65EeT9VRqTSKnWEdjwbJukhNRpS1hmWb39MBsafP9X0kYKHdi2o3Awtk+EUUg==
X-Received: by 2002:a5d:4b92:0:b0:37c:fbf8:fc4 with SMTP id ffacd0b85a97d-37d601fc350mr5544911f8f.59.1728845594330;
        Sun, 13 Oct 2024 11:53:14 -0700 (PDT)
Received: from localhost.localdomain (89-138-141-122.bb.netvision.net.il. [89.138.141.122])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37d4b79fa21sm9347859f8f.85.2024.10.13.11.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 11:53:14 -0700 (PDT)
From: Yedaya Katsman <yedaya.ka@gmail.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Yedaya Katsman <yedaya.ka@gmail.com>
Subject: [PATCH] ip: Add "down" filter for "ip addr/link show"
Date: Sun, 13 Oct 2024 21:53:08 +0300
Message-Id: <20241013185308.12280-1-yedaya.ka@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently there is an "up" option, which allows showing only devices
that are up and running. Add a corresponding "down" option.

Also change the usage and man pages accordingly.

Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
---
 ip/ip_common.h           |  1 +
 ip/ipaddress.c           | 13 ++++++++++---
 ip/iplink.c              |  4 ++--
 man/man8/ip-address.8.in | 10 +++++++---
 man/man8/ip-link.8.in    |  8 ++++++--
 5 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/ip/ip_common.h b/ip/ip_common.h
index 350806d9d0cc..3804261fdb36 100644
--- a/ip/ip_common.h
+++ b/ip/ip_common.h
@@ -16,6 +16,7 @@ struct link_filter {
 	int scope, scopemask;
 	int flags, flagmask;
 	int up;
+	int down;
 	char *label;
 	int flushed;
 	char *flushb;
diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index f7bd14847477..d90ba94d11c5 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -52,12 +52,12 @@ static void usage(void)
 		"Usage: ip address {add|change|replace} IFADDR dev IFNAME [ LIFETIME ]\n"
 		"                                                      [ CONFFLAG-LIST ]\n"
 		"       ip address del IFADDR dev IFNAME [mngtmpaddr]\n"
-		"       ip address {save|flush} [ dev IFNAME ] [ scope SCOPE-ID ]\n"
-		"                            [ to PREFIX ] [ FLAG-LIST ] [ label LABEL ] [up]\n"
+		"       ip address {save|flush} [ dev IFNAME ] [ scope SCOPE-ID ] [ to PREFIX ]\n"
+		"                            [ FLAG-LIST ] [ label LABEL ] [ { up | down } ]\n"
 		"       ip address [ show [ dev IFNAME ] [ scope SCOPE-ID ] [ master DEVICE ]\n"
 		"                         [ nomaster ]\n"
 		"                         [ type TYPE ] [ to PREFIX ] [ FLAG-LIST ]\n"
-		"                         [ label LABEL ] [up] [ vrf NAME ]\n"
+		"                         [ label LABEL ] [ { up | down } ] [ vrf NAME ]\n"
 		"                         [ proto ADDRPROTO ] ]\n"
 		"       ip address {showdump|restore}\n"
 		"IFADDR := PREFIX | ADDR peer PREFIX\n"
@@ -981,6 +981,8 @@ int print_linkinfo(struct nlmsghdr *n, void *arg)
 		return -1;
 	if (filter.up && !(ifi->ifi_flags&IFF_UP))
 		return -1;
+	if (filter.down && ifi->ifi_flags&IFF_UP)
+		return -1;
 
 	parse_rtattr_flags(tb, IFLA_MAX, IFLA_RTA(ifi), len, NLA_F_NESTED);
 
@@ -1720,6 +1722,9 @@ static int print_selected_addrinfo(struct ifinfomsg *ifi,
 		if (filter.up && !(ifi->ifi_flags&IFF_UP))
 			continue;
 
+		if (filter.down && ifi->ifi_flags&IFF_UP)
+			continue;
+
 		open_json_object(NULL);
 		print_addrinfo(n, fp);
 		close_json_object();
@@ -2140,6 +2145,8 @@ static int ipaddr_list_flush_or_save(int argc, char **argv, int action)
 			filter.scope = scope;
 		} else if (strcmp(*argv, "up") == 0) {
 			filter.up = 1;
+		} else if (strcmp(*argv, "down") == 0) {
+			filter.down = 1;
 		} else if (get_filter(*argv) == 0) {
 
 		} else if (strcmp(*argv, "label") == 0) {
diff --git a/ip/iplink.c b/ip/iplink.c
index 0dd83ff44846..2fdd73e5b8be 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -110,8 +110,8 @@ void iplink_usage(void)
 		"		[ gso_max_size BYTES ] [ gso_ipv4_max_size BYTES ] [ gso_max_segs PACKETS ]\n"
 		"		[ gro_max_size BYTES ] [ gro_ipv4_max_size BYTES ]\n"
 		"\n"
-		"	ip link show [ DEVICE | group GROUP ] [up] [master DEV] [vrf NAME] [type TYPE]\n"
-		"		[nomaster] [ novf ]\n"
+		"	ip link show [ DEVICE | group GROUP ] [ { up | down } ] [master DEV] [vrf NAME]\n"
+		"		[type TYPE] [nomaster] [ novf ]\n"
 		"\n"
 		"	ip link xstats type TYPE [ ARGS ]\n"
 		"\n"
diff --git a/man/man8/ip-address.8.in b/man/man8/ip-address.8.in
index d37dddb7b1a9..92ebdfe69ded 100644
--- a/man/man8/ip-address.8.in
+++ b/man/man8/ip-address.8.in
@@ -32,7 +32,7 @@ ip-address \- protocol address management
 .B  to
 .IR PREFIX " ] [ " FLAG-LIST " ] [ "
 .B  label
-.IR PATTERN " ] [ " up " ]"
+.IR PATTERN " ] [ { " up " | " down " } ]"
 
 .ti -8
 .BR "ip address" " [ " show  " [ " dev
@@ -48,8 +48,8 @@ ip-address \- protocol address management
 .B  type
 .IR TYPE " ] [ "
 .B vrf
-.IR NAME " ] [ "
-.BR up " ] ["
+.IR NAME " ] [ { "
+.BR up " | " down " } ] ["
 .BR nomaster " ]"
 .B proto
 .IR ADDRPROTO " ] ]"
@@ -378,6 +378,10 @@ output.
 .B up
 only list running interfaces.
 
+.TP
+.B down
+only list not running interfaces.
+
 .TP
 .B nomaster
 only list interfaces with no master.
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index eabca4903302..64b5ba21c222 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -194,8 +194,8 @@ ip-link \- network device configuration
 .B ip link show
 .RI "[ " DEVICE " | "
 .B group
-.IR GROUP " ] ["
-.BR up " ] ["
+.IR GROUP " ] [ { "
+.BR up " | " down " } ] ["
 .B master
 .IR DEVICE " ] ["
 .B type
@@ -2903,6 +2903,10 @@ specifies what group of devices to show.
 .B up
 only display running interfaces.
 
+.TP
+.B down
+only display not running interfaces.
+
 .TP
 .BI master " DEVICE "
 .I DEVICE
-- 
2.34.1


