Return-Path: <netdev+bounces-103612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56EC908C99
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 15:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E49289F4C
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 13:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CF919D8B1;
	Fri, 14 Jun 2024 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="c7XxNVeT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2DB184E
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372338; cv=none; b=Ux277Dt71N4KTtDj1Me+0qynoAhEEdkCxfmo9KzUBlSlfNQIacrkpS29nfnZwXw9qwl8SRseZs9PDcYspBLi6AAj9vA6BgqyewdUAtLZF5vFFbN53Kt8eR9/B97tvTdGS1RpoLVxXxg8LnDFwm/opdT39dFV3+PFlVoyKMtJE3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372338; c=relaxed/simple;
	bh=ZVLaGLZG/PqORfy+FQw8Lf37kV4aEYO/FMejChT+k6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B0zWKyxc7Tj4nuBtg9UZNku7OeS3SeTnB1ivtl185w6E6CsSOIC/w16uS2q8zjSvKhqARPZYxbaiHwWuHkqvixxQZ85DzGnuqzb02JwCxn76254jeVwClp9jEFnrc01j4QT7CHeHwhZLi8eNDZgTBPJhiEl0fBTh8JOSRCCbClg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=c7XxNVeT; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so23530751fa.2
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 06:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1718372335; x=1718977135; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QPtIu2Oh1GAneYAcqWUOWEePzATLj5rj0bM+l+vj59A=;
        b=c7XxNVeT3bRbQymj4PBExG+mVrTLMRHAAgPw6mqVNIH84wuGE9v4B1s7SZY8kSKxTX
         WT1ObmsKmvD8VJTF1iju03efOxjaOvzLtEVMMkCAOayz3QhWuh/H+meEqGm8tlGrSMve
         g/U4rz0ct1G2Dx0txgKXu807YSNZrCWaA4BdAtUd8duW2v6tMXaXG5D5U8jrDUt+uU2r
         ZSZrvX1dU9pXwtk6JfEKDH1Z3qCtaTL8qV754XYLF9xcsSElZW54cfJ8JXVat4CD19TN
         O+uxFiORGvbZoVvzyJSJrLClyqDvi2WwLaSIVfR+plXg4JeRqXDH3fGwciJ7SxpgkF/L
         3UQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718372335; x=1718977135;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPtIu2Oh1GAneYAcqWUOWEePzATLj5rj0bM+l+vj59A=;
        b=fN8GPNmeWt8lOoTT12MSsfC5ojgYCkzFR+x6aHQsiT6JMXM0+W+Z1dhSsTwGSXjypN
         1UxTHJHccyCF/v0mM1CKH/3Uy5CC8PwiCEThXiJ2vTtoXFQZQN1PYfRht9X03/Bhk2Lv
         kNxGQdLR0N5nyB0C0/J/3fD9yOohcRhVZDWcTTL0tHZ0818ZsTOiWGcObes2bCEN3wqW
         chIkWpHHfa0Khn35WoAzWY7g1ux5RKzIfAex2JRYr4V2Gw5a1A8rAA0ZUIVzrtZ/Ud9C
         NzPZ3qQHMUJzYmb4bzekafvuByM8JUFSDMVOmQSF5SBCQiB5GP2+jqVoC1qxV4wr3bSj
         se/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXW09dfff6ZJBzc6HJThWb/bPQh9pIgpMYa5j4KdtyJN0a9EpFTouTQdYfNJV2XHxz9QZmqjnfhUWy3L/Y3mgfwCgQ0U1ly
X-Gm-Message-State: AOJu0YwOrsCFeCAjqVN/2NLFXP32GpPLiYsJBjV/1IWGNPWJiTQr79K8
	w9thSiVrohZXQHIkRRfkFwvla6By+K0Jjep+nIvmPZuVeE4Kd6PKaOMOHURfiZc=
X-Google-Smtp-Source: AGHT+IFQkG3EBTfxtsw5JaE8O+dTTeYyOa5fVY1r3lJWtSCEeY4VA8eNDpIa3p7MyHD1WyWp6UMSeQ==
X-Received: by 2002:a2e:9244:0:b0:2eb:e405:dc with SMTP id 38308e7fff4ca-2ec0e46db18mr19619891fa.14.1718372334868;
        Fri, 14 Jun 2024 06:38:54 -0700 (PDT)
Received: from wkz-x13.addiva.ad (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c179c5sm5327621fa.67.2024.06.14.06.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 06:38:54 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: liuhangbin@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH iproute2 1/3] ip: bridge: add support for mst_enabled
Date: Fri, 14 Jun 2024 15:38:16 +0200
Message-Id: <20240614133818.14876-2-tobias@waldekranz.com>
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

When enabled, the bridge's legacy per-VLAN STP facility is replaced
with the Multiple Spanning Tree Protocol (MSTP) compatible version.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 ip/iplink_bridge.c    | 19 +++++++++++++++++++
 man/man8/ip-link.8.in | 14 ++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index 6b70ffbb..8c4428a0 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -30,6 +30,7 @@ static void print_explain(FILE *f)
 		"		  [ max_age MAX_AGE ]\n"
 		"		  [ ageing_time AGEING_TIME ]\n"
 		"		  [ stp_state STP_STATE ]\n"
+		"		  [ mst_enabled MST_ENABLED ]\n"
 		"		  [ priority PRIORITY ]\n"
 		"		  [ group_fwd_mask MASK ]\n"
 		"		  [ group_address ADDRESS ]\n"
@@ -169,6 +170,18 @@ static int bridge_parse_opt(struct link_util *lu, int argc, char **argv,
 				bm.optval |= no_ll_learn_bit;
 			else
 				bm.optval &= ~no_ll_learn_bit;
+		} else if (matches(*argv, "mst_enabled") == 0) {
+			__u32 mst_bit = 1 << BR_BOOLOPT_MST_ENABLE;
+			__u8 mst_enabled;
+
+			NEXT_ARG();
+			if (get_u8(&mst_enabled, *argv, 0))
+				invarg("invalid mst_enabled", *argv);
+			bm.optmask |= mst_bit;
+			if (mst_enabled)
+				bm.optval |= mst_bit;
+			else
+				bm.optval &= ~mst_bit;
 		} else if (strcmp(*argv, "fdb_max_learned") == 0) {
 			__u32 fdb_max_learned;
 
@@ -609,6 +622,7 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 	if (tb[IFLA_BR_MULTI_BOOLOPT]) {
 		__u32 mcvl_bit = 1 << BR_BOOLOPT_MCAST_VLAN_SNOOPING;
 		__u32 no_ll_learn_bit = 1 << BR_BOOLOPT_NO_LL_LEARN;
+		__u32 mst_bit = 1 << BR_BOOLOPT_MST_ENABLE;
 		struct br_boolopt_multi *bm;
 
 		bm = RTA_DATA(tb[IFLA_BR_MULTI_BOOLOPT]);
@@ -622,6 +636,11 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 				   "mcast_vlan_snooping",
 				   "mcast_vlan_snooping %u ",
 				    !!(bm->optval & mcvl_bit));
+		if (bm->optmask & mst_bit)
+			print_uint(PRINT_ANY,
+				   "mst_enabled",
+				   "mst_enabled %u ",
+				   !!(bm->optval & mst_bit));
 	}
 
 	if (tb[IFLA_BR_MCAST_ROUTER])
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index c1984158..eabca490 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -1685,6 +1685,8 @@ the following additional arguments are supported:
 ] [
 .BI stp_state " STP_STATE "
 ] [
+.BI mst_enabled " MST_ENABLED "
+] [
 .BI priority " PRIORITY "
 ] [
 .BI no_linklocal_learn " NO_LINKLOCAL_LEARN "
@@ -1788,6 +1790,18 @@ or off
 .RI ( STP_STATE " == 0). "
 for this bridge.
 
+.BI mst_enabled " MST_ENABLED "
+- turn multiple spanning tree (MST) support on
+.RI ( MST_ENABLED " > 0) "
+or off
+.RI ( MST_ENABLED " == 0). "
+When enabled, sets of VLANs can be associated with multiple spanning
+tree instances (MSTIs), and STP states for each port can be controlled
+on a per-MSTI basis. Note: no implementation of the MSTP protocol is
+provided, only the primitives needed to implement it. To avoid
+interfering with the legacy per-VLAN STP states, this setting can only
+be changed when no bridge VLANs are configured.
+
 .BI priority " PRIORITY "
 - set this bridge's spanning tree priority, used during STP root
 bridge election.
-- 
2.34.1


