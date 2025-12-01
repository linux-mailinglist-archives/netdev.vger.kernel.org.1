Return-Path: <netdev+bounces-242942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 418D7C96A99
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 11:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2615F344673
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 10:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE778305E31;
	Mon,  1 Dec 2025 10:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCOiDo1L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2F63054DE
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764584935; cv=none; b=aAtefwBW2BOcFk2Y0SZ/SaxWOXZ71iJdqHhLV+ctXv2jgAMzYj9pgvjjrkQUaiHdlAw108Xkw/lM77j+OZVgiID/MKQRDSPCHZgg6SMghp+rQa2tFTUpSTXFntXrPrxfhED19XVRe5e3tNO6a9xSsICpcnhlvtqR3gZUCYcrLGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764584935; c=relaxed/simple;
	bh=kcdB10IAw2gkJ9lGc1YtDOyMNEKD6+NwmKs07aM43cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6d7OMlf7vqxsJbVpWoGyE2sUe22FxR8xl9y0pvf8iKTqPcJOYO1txIwhEIUqJLJSz4PBuiJIRpfX3Wzs18gtibzmlSPxPa3pJMV8V7qr6qeVfqsdHkPTLH2pfg85v54uUb+Ay+uQ3m0Akw5MShwCYEt3bn40S8wrkdAx9v5iNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCOiDo1L; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b735487129fso565018866b.0
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 02:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764584932; x=1765189732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KJH3bXmMEwxHSCHbGbfUAmcdLYGbe7hL6mo3kE3l6g=;
        b=GCOiDo1LLa6TgM+5ydT0JcPvC3RG84l0r40UBeAlxYOXjPxU+IjFEgQDPyA8YzF6D1
         ms4VhtF/URWTGYTvOfUYZVccyUwWGOFdKB2osXNvCIhrdpaDiRsaCFVZr1X01jTpI4SN
         UVYGCaSpu0PLNPCv8pg2ty/R28302bUuXotgzlpZQvPYBH61+iJcWkPtpakjvv3L5/9v
         IPKDaBxfvr98ogYFvlF7y+0YH5MAgOVDXf4jdTVx17W0wLs2OmyIbaxtimS0cecQImF+
         LgY/r007mJamH5cEgiRAxe2vVWLhxY7eTtuwLVcVA+bLO+/3KEXsYnuD3YqI6IU2+f7F
         U0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764584932; x=1765189732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0KJH3bXmMEwxHSCHbGbfUAmcdLYGbe7hL6mo3kE3l6g=;
        b=HlbrY4eeLX9Dd1/EdtGwtSwoxXEFYhy5d+LZddwphpV2g3NWGwcQFI5VlWSe8iXVGb
         2n5GP8V1y4Efb3nBp625nb726UVcSCc0jMPstq3OkThfnyKbE/pI3DOz6T4kx9pvVnYZ
         HYRfepYhpW89CEpANU5dEBms41EIcE4QDsR6+m19UWcbt89UE5JmcUt7wvkUaDFtbdbz
         0yZCByrmSumaHVMmoec1bvsmjJe+1x2ePYzFXURE3q+dF9JXkEv/QQGNbNJ8dXE0kfl3
         FPzgDebb89jzznfwtF3K/OWuZaNKUPwxTljgxqa+9NEtXyxeCTBrNplxeOfRL0PMq4T0
         KDwg==
X-Forwarded-Encrypted: i=1; AJvYcCXDxCqF/wl+/+ysSBmtBf/IA6pJBNmEUBFMfulRCqfWP0+lXCyiqS78k/YyBF5q/ClGAT+vjM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRUek547birgMB07L+UtFbDwmjMCcodYGC82EjsYVj7DbK2nYO
	T7h8n2LXws9JUgy4IrJyAIOmgb3chCInJG4LNwvcX0Pjq0eNKSMHirg2
X-Gm-Gg: ASbGncsGi1rEzmUFWZ5Xg9bRtLJkk8hd4RWl0A/iylM1fy0QG0Iqb9KuivOnLFEfz0w
	/f+8E0O3ixW3rBbR6bbS8JOdOfWuhFMHz0n0mFbCTIIDg0CXq5zqzlpkoRl1pG5eZVnp+W+Y6gF
	BHwQbtdFkyBjuOLzA2Jv+ZUqM0OrKy0FyDWpR619Q7ROJCSobiL+xx3NyWRsDoV0g/mw1O/7rcO
	HxghR+Hb7YMcG/03AWobB3jHaKtdHetEyCmy7wlGj0ClHbQVCnXFtTYeiOOLCbWELhHSx6jAC2l
	LYccTLHB5au+haauacXgju5G0nbg+N6CAMEJcykHG8sRc2OlalQaY3lAwPZQsPdQHnkhRP78Qtg
	qK4MeFK4fgUM65xHPMuAMZMdee/glRzZoSYCDobd6IoLeGKY8liiDffUSM/jbffUfdxMs+Eel+o
	BnPA1BOEVXm7SncgctPdtjlRJ/z2ibW+MoILcCpUIISm+hHvzOnBlLUrNwgHP1XzYlFrs=
X-Google-Smtp-Source: AGHT+IH8UzIXZ+P9m8fEUgF681BNGjOYCjDIaz/r0htVxM1wr+pTCtgffVG0RJhGTTYN5l3Ys9Se2Q==
X-Received: by 2002:a17:907:3e0b:b0:b74:f827:b886 with SMTP id a640c23a62f3a-b767170bfcfmr4074321666b.32.1764584931481;
        Mon, 01 Dec 2025 02:28:51 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f519d883sm1183492566b.17.2025.12.01.02.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:28:50 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC/RFT net-next v2 4/5] net: dsa: deny 8021q uppers on vlan unaware bridged ports
Date: Mon,  1 Dec 2025 11:28:16 +0100
Message-ID: <20251201102817.301552-5-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201102817.301552-1-jonas.gorski@gmail.com>
References: <20251201102817.301552-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/networking/switchdev.rst says:

- with VLAN filtering turned off, the bridge will process all ingress
  traffic for the port, except for the traffic tagged with a VLAN ID
  destined for a VLAN upper.

But DSA currently does not notify drivers about uppers on bridge ports
of a VLAN unaware bridge: Bridged ports on a VLAN unaware bridge will
usually not have filtering enabled and thus do not have
NETIF_F_HW_VLAN_CTAG_FILTER so dsa_user_vlan_rx_add_vid() is never
called.

And if filtering is always on for a driver, then DSA will just call
dsa_port_vlan_add(), in the same way it would for VLANs added to the
bridge. And VLANs programmed to the bridge are supposed to be ignored
while filtering is disabled, so drivers would still not act upon it.

Therefore traffic tagged with the VID will continue to be forwarded to
other ports, and therefore we cannot support VLAN uppers on ports of a
VLAN unaware bridges.

So reject any VLAN uppers for bridged ports of VLAN unaware bridges, and
reject disabling filtering as long as any VLAN uppers on bridged ports
exist.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
* actually deny VLAN uppers on VLAN-unware bridges
* fix DSA behaviour description for non-filtering bridge ports

 net/dsa/port.c | 23 ++++-------------------
 net/dsa/user.c |  9 ++++++++-
 2 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index 082573ae6864..d7746885f7e0 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -728,35 +728,20 @@ static bool dsa_port_can_apply_vlan_filtering(struct dsa_port *dp,
 {
 	struct dsa_switch *ds = dp->ds;
 	struct dsa_port *other_dp;
-	int err;
 
-	/* VLAN awareness was off, so the question is "can we turn it on".
+	/* VLAN awareness was on, so the question is "can we turn it off".
 	 * We may have had 8021q uppers, those need to go. Make sure we don't
 	 * enter an inconsistent state: deny changing the VLAN awareness state
 	 * as long as we have 8021q uppers.
 	 */
-	if (vlan_filtering && dsa_port_is_user(dp)) {
-		struct net_device *br = dsa_port_bridge_dev_get(dp);
+	if (!vlan_filtering && dsa_port_is_user(dp)) {
 		struct net_device *upper_dev, *user = dp->user;
 		struct list_head *iter;
 
 		netdev_for_each_upper_dev_rcu(user, upper_dev, iter) {
-			struct bridge_vlan_info br_info;
-			u16 vid;
-
-			if (!is_vlan_dev(upper_dev))
-				continue;
-
-			vid = vlan_dev_vlan_id(upper_dev);
-
-			/* br_vlan_get_info() returns -EINVAL or -ENOENT if the
-			 * device, respectively the VID is not found, returning
-			 * 0 means success, which is a failure for us here.
-			 */
-			err = br_vlan_get_info(br, vid, &br_info);
-			if (err == 0) {
+			if (is_vlan_dev(upper_dev)) {
 				NL_SET_ERR_MSG_MOD(extack,
-						   "Must first remove VLAN uppers having VIDs also present in bridge");
+						   "Must first remove VLAN uppers from bridged ports");
 				return false;
 			}
 		}
diff --git a/net/dsa/user.c b/net/dsa/user.c
index e8c6452780b0..442cf3b2dc30 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -3167,10 +3167,17 @@ dsa_user_check_8021q_upper(struct net_device *dev,
 	int err = NOTIFY_DONE;
 	u16 vid;
 
-	if (!br || !br_vlan_enabled(br))
+	if (!br)
 		return NOTIFY_DONE;
 
 	extack = netdev_notifier_info_to_extack(&info->info);
+
+	if (!br_vlan_enabled(br)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "VLAN uppers not supported with non filtering bridges");
+		return notifier_from_errno(-EBUSY);
+	}
+
 	vid = vlan_dev_vlan_id(info->upper_dev);
 
 	/* br_vlan_get_info() returns -EINVAL or -ENOENT if the
-- 
2.43.0


