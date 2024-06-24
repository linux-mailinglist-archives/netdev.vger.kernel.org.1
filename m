Return-Path: <netdev+bounces-106104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB31914DD2
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6551C2261B
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2967E13D526;
	Mon, 24 Jun 2024 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="X2OJq00z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1883B135414
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234062; cv=none; b=dTy8Y+1dIwq4VnsyV98vjL3VUw8bJ8xNKwKdAMlJAqzsKLfeZpuURATyXvJhcJYlMrMIGt6nB0bkYPZRmLulEPNOfQcfLeDG8KUafAwfKfAwZTHcuFJNYrRjOwCYn/LZLVubjMBdulSMSv+MhYZ+F3QNrENP0CH4bggYHE7uW14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234062; c=relaxed/simple;
	bh=RyokshU+WclVGMh//XugxXFLsaY29TtbRP0vMmVrUK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ToNJ/r/cDixqLc8HxLZJ7zup2wJmINCpqG7LUgQz+hyMU9eelSSZFJrzi/xlo5MFy0y0WCHxMaEtAgAWVb9mpWL3q1j5vyqVIcxUl8mzrcD+laMvQg7RY6zs9UB9E1PULb2a9kmiKO3AiSaadQYOuBnEbFHmBG24usMxXTO0jwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=X2OJq00z; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ce674da85so986732e87.2
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 06:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1719234058; x=1719838858; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ooLfCMYPlwAcfVO+ZEfEnAjNUYPYAXAlFcQUJX0gVv0=;
        b=X2OJq00zPYsgKa8OrfmC3deid4SBWuLQ0cZ9DBDaGEosZUCrSEhEwE+OYxvVYJGua9
         n5f5OGOI3Hji8S7W7m8WjDKBXmQVRgrTbyVn3DcnVEEqUV0aoQO3Dizzsh50jKPZNaFn
         2BS+kt+ogISvpKwa1FRWNjOwn9GsI9gZbublysilfs706UzGi+lTGPyqhWxYkP66xuBW
         Shk4tEnnEn6L9D8khuyjLd0S9a1BAsB4tCkb/Uv+LgqIpwhi4Oi/o8CEjQYEtn9eycpj
         wHDmNajImNa+Z8+NdgR1lIDb7iHkyLJ9kToGqgRv2127o8IQpbtdNyUfWNFdhVwFhg7H
         R64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719234058; x=1719838858;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ooLfCMYPlwAcfVO+ZEfEnAjNUYPYAXAlFcQUJX0gVv0=;
        b=b20gRiV8HUyqdLuPkCIfaXUkElBidQSpTi0tviT//6vUFfQkBG7bJWE17Tp+RkCRaO
         0W6SliC1wQ9BdX1DowjfTOd3Rly+s9fRty511ru61ZSZYjpEa3IkXPvyaK063LNW4Hza
         9jY01kLtxDebILIBL+FE8hUCiqnnGweFevGqnjkFegQF23xFNXAwbmQ0lZ3jzlzswo/i
         0zYieQOepomSZiHAi9PksaFQg9MnAbRCR0wIngt9m44hw0vNVLU2aA+KbJmcLv63ZqJu
         bHfBoIQV6RQOe5FYu9YES7adlQf4ubcZ9qXnW46xVZhcogpgE64+Gl1GnjwzaSSg73af
         8dcg==
X-Forwarded-Encrypted: i=1; AJvYcCUlJu9Qy+LtgAcndneCFO9KAe7ntaG9BkoFH/QYJQeUwtJtHzutKMj/9tbQeVHgZIHQ4O5YZSgs6DFScFYjFAAP0YamRp0P
X-Gm-Message-State: AOJu0YxQ03pjXhvz9kJuFCm0+MphMDsMmluyOnLUtWKVG/fAdNideuWm
	4Ea3pVuTcOxRCXqRWGJ6aqGDpx5UeRzTpe8e3qmW460s5U3qYG5Gwiff/m6st7s=
X-Google-Smtp-Source: AGHT+IEdtfYDa2BYtDClsU1EEcYZf0TgT2roI37WmsTsZB4ACxffu6xs6RVbl6YANlEC5AqXIbEHyw==
X-Received: by 2002:a05:6512:3090:b0:52b:bd50:baed with SMTP id 2adb3069b0e04-52ce1861711mr4448941e87.61.1719234058161;
        Mon, 24 Jun 2024 06:00:58 -0700 (PDT)
Received: from wkz-x13.addiva.ad (h-176-10-146-181.NA.cust.bahnhof.se. [176.10.146.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd6432bd9sm981827e87.227.2024.06.24.06.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:00:57 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: liuhangbin@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH v2 iproute2 1/3] ip: bridge: add support for mst_enabled
Date: Mon, 24 Jun 2024 15:00:33 +0200
Message-Id: <20240624130035.3689606-2-tobias@waldekranz.com>
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

When enabled, the bridge's legacy per-VLAN STP facility is replaced
with the Multiple Spanning Tree Protocol (MSTP) compatible version.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 ip/iplink_bridge.c    | 19 +++++++++++++++++++
 man/man8/ip-link.8.in | 14 ++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index 6b70ffbb..f01ffe15 100644
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
+		} else if (strcmp(*argv, "mst_enabled") == 0) {
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


