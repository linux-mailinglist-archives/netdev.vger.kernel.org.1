Return-Path: <netdev+bounces-220284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B90B452F5
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 11:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1AF3A63BF0
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 09:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75D528468C;
	Fri,  5 Sep 2025 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHpn07aL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176A921CFF7
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 09:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063752; cv=none; b=lpBbtlb1SwDpezEDhRV6hU/65YIkGKasbUbRDiZCWN1jdEiJCiIIYQv+d+CJYbUySRAsJHU8iiTkqw27ut0wNRZ0ELeiS4AhZafbi9pw4q404ZhKexVFfa7xCxyfbpoZtggh6mh+HaZgFsrxrAzzRULuaT0EEqKhY6Lg4b3OWVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063752; c=relaxed/simple;
	bh=q/rSMxG7IJpVxHfEv5jrPbBdP0cf2lQV77fyjTBsLes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wd4avv3EXN74UF24rxcoQjk/Kxsmuqs5fvCoJbMjuN0dzWEjwRfKjnLsZtji8ZLEswFl5xwfzd0iLVx7RGrwVhvECrOnvCeEguOX3SEXIApiELEDy+C4M6oflUsCbXUwegyfU6TMuTHMbha6PU6P8ZAkdIpNo+oRtbUvNAweI+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHpn07aL; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7725147ec88so868848b3a.0
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 02:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757063750; x=1757668550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5oPb2NRRIQGHXxFjgs3Ifh8wStbPWL5s70iUCpzm6Y=;
        b=VHpn07aLIrsjtnK6wqhCS6QwHll+UspE51u1ViMrXkCDzup3XhAvQGtbLK9clG7xiI
         cwbixF9ZTyQTZcx7eSSxV0TloFBHmrw83koXXPa9U3C6ZXrpeEf5lz1bU+ckf2hNKg4R
         LG/vVQ+pavKb9ijsntXgneK0xtFVpnmFGAOt/BUfkG3XHzAti0sTtzdp7i8secBqvQ2S
         3wxC1Sue84IDTbLCj4BqGWMtq+0eKgghndR258IUOje9J1SJE4HvNtd18z27bVRNcl8P
         xzr1HMQ9cTufg0qr+1tegAk3M3Pm3ZOpdUqTPr70czhRjJiYi1QeGpVknnpsYrP3Hg13
         M1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063750; x=1757668550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5oPb2NRRIQGHXxFjgs3Ifh8wStbPWL5s70iUCpzm6Y=;
        b=qq/T7L4UOtsSYL9kRQIs5UiAUKKMbacqjqU0vU7CRT3k7QdZiOPCG71sagwPgnDTrh
         R4wLpvJKVfPn/u2hmJf4ESlwEl8l5iRJ7h9xAt48jn/FNiw0P9uOJbiwQshzxB5bu6Cy
         mIY1zFJN5dsCunV4VIRgiUGIhQGlhYEc+5n5nBhX3PXT5qmxPQaRtiPYJsqQJfDnEGUL
         ZXdc5NmMgHo/JM+DTTN+G8fMkUBlRomNcf3LfhUBlHb+SJK6+MMel7Tzkzzd2maxdZRd
         d3cV/knuzQLTasqT3S39wfTsS2yzo3E4bDkyxa0HG82WM5FzUvr41h6MuANFCm4gnGFR
         jYXQ==
X-Gm-Message-State: AOJu0YxbPjGgXdwbcAYxs1buKc/zUS3KE6eZ7/ymmMUglu2kKlOx3jUd
	JExAv2u3Tccdznwqhq35iEH7VCs57miJ1XgH7BjGd5gwXpB4fFddLAPGxlb676mmbjA=
X-Gm-Gg: ASbGncubcAb8s9/VYWLMRUBp4pbV3d/wM0LeJBz6iwKiANcuTZsSrhvVyLDuJW/LFN9
	JlaqnydsuuBarBEEyn3anzIzFePgWxgGPrPDF3zZcgOJuG9a5jva0/5A52YZXzcnE2JV/doYNrg
	9Z0APhmJAch66fPu1cXQ/kpAjMRb7q9cko3+OjIXYv7d3BNJQBCVQQ+l0kCuLyRKfkrZuQlCA1h
	3t2pNvTQRqR0XeLzCHZtvru58fiGbU1BVMXYLkC8rEiGPStQvQuKPSmrbVVU4t5NXO95nL98tEi
	KqwroMSPefGbxlBgzrG9I9LV7q/QLTYaJoYlSOuCJdNg6fhn6Z/gzZjjfk6CLQy4I/uxddT+w2c
	1IOk4R5UPikLwZecWahGBHgHfR6rk9u4j02q9UcsiT50RePEyyXuY
X-Google-Smtp-Source: AGHT+IG4MBHmmpQ1/6MljxG4wGOKKApVABad6mvZ3ksJY10iW6UwZZt3dyff1SZgtssa1ISS8POXkg==
X-Received: by 2002:a05:6a00:1a89:b0:772:397b:b270 with SMTP id d2e1a72fcca58-7741bf1f298mr3166799b3a.10.1757063749956;
        Fri, 05 Sep 2025 02:15:49 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a71c60bsm21078281b3a.103.2025.09.05.02.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:15:49 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
	Fernando Fernandez Mancera <ffmancera@riseup.net>,
	Murali Karicheri <m-karicheri2@ti.com>,
	WingMan Kwok <w-kwok2@ti.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 1/3] hsr: use rtnl lock when iterating over ports
Date: Fri,  5 Sep 2025 09:15:31 +0000
Message-ID: <20250905091533.377443-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905091533.377443-1-liuhangbin@gmail.com>
References: <20250905091533.377443-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hsr_for_each_port is called in many places without holding the RCU read
lock, this may trigger warnings on debug kernels. Most of the callers
are actually hold rtnl lock. So add a new helper hsr_for_each_port_rtnl
to allow callers in suitable contexts to iterate ports safely without
explicit RCU locking.

This patch only fixed the callers that is hold rtnl lock. Other caller
issues will be fixed in later patches.

Fixes: c5a759117210 ("net/hsr: Use list_head (and rcu) instead of array for slave devices.")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/hsr/hsr_device.c | 18 +++++++++---------
 net/hsr/hsr_main.c   |  2 +-
 net/hsr/hsr_main.h   |  3 +++
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 88657255fec1..bce7b4061ce0 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -49,7 +49,7 @@ static bool hsr_check_carrier(struct hsr_port *master)
 
 	ASSERT_RTNL();
 
-	hsr_for_each_port(master->hsr, port) {
+	hsr_for_each_port_rtnl(master->hsr, port) {
 		if (port->type != HSR_PT_MASTER && is_slave_up(port->dev)) {
 			netif_carrier_on(master->dev);
 			return true;
@@ -105,7 +105,7 @@ int hsr_get_max_mtu(struct hsr_priv *hsr)
 	struct hsr_port *port;
 
 	mtu_max = ETH_DATA_LEN;
-	hsr_for_each_port(hsr, port)
+	hsr_for_each_port_rtnl(hsr, port)
 		if (port->type != HSR_PT_MASTER)
 			mtu_max = min(port->dev->mtu, mtu_max);
 
@@ -139,7 +139,7 @@ static int hsr_dev_open(struct net_device *dev)
 
 	hsr = netdev_priv(dev);
 
-	hsr_for_each_port(hsr, port) {
+	hsr_for_each_port_rtnl(hsr, port) {
 		if (port->type == HSR_PT_MASTER)
 			continue;
 		switch (port->type) {
@@ -172,7 +172,7 @@ static int hsr_dev_close(struct net_device *dev)
 	struct hsr_priv *hsr;
 
 	hsr = netdev_priv(dev);
-	hsr_for_each_port(hsr, port) {
+	hsr_for_each_port_rtnl(hsr, port) {
 		if (port->type == HSR_PT_MASTER)
 			continue;
 		switch (port->type) {
@@ -205,7 +205,7 @@ static netdev_features_t hsr_features_recompute(struct hsr_priv *hsr,
 	 * may become enabled.
 	 */
 	features &= ~NETIF_F_ONE_FOR_ALL;
-	hsr_for_each_port(hsr, port)
+	hsr_for_each_port_rtnl(hsr, port)
 		features = netdev_increment_features(features,
 						     port->dev->features,
 						     mask);
@@ -484,7 +484,7 @@ static void hsr_set_rx_mode(struct net_device *dev)
 
 	hsr = netdev_priv(dev);
 
-	hsr_for_each_port(hsr, port) {
+	hsr_for_each_port_rtnl(hsr, port) {
 		if (port->type == HSR_PT_MASTER)
 			continue;
 		switch (port->type) {
@@ -506,7 +506,7 @@ static void hsr_change_rx_flags(struct net_device *dev, int change)
 
 	hsr = netdev_priv(dev);
 
-	hsr_for_each_port(hsr, port) {
+	hsr_for_each_port_rtnl(hsr, port) {
 		if (port->type == HSR_PT_MASTER)
 			continue;
 		switch (port->type) {
@@ -534,7 +534,7 @@ static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
 
 	hsr = netdev_priv(dev);
 
-	hsr_for_each_port(hsr, port) {
+	hsr_for_each_port_rtnl(hsr, port) {
 		if (port->type == HSR_PT_MASTER ||
 		    port->type == HSR_PT_INTERLINK)
 			continue;
@@ -580,7 +580,7 @@ static int hsr_ndo_vlan_rx_kill_vid(struct net_device *dev,
 
 	hsr = netdev_priv(dev);
 
-	hsr_for_each_port(hsr, port) {
+	hsr_for_each_port_rtnl(hsr, port) {
 		switch (port->type) {
 		case HSR_PT_SLAVE_A:
 		case HSR_PT_SLAVE_B:
diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index 192893c3f2ec..ac1eb1db1a52 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -22,7 +22,7 @@ static bool hsr_slave_empty(struct hsr_priv *hsr)
 {
 	struct hsr_port *port;
 
-	hsr_for_each_port(hsr, port)
+	hsr_for_each_port_rtnl(hsr, port)
 		if (port->type != HSR_PT_MASTER)
 			return false;
 	return true;
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 135ec5fce019..33b0d2460c9b 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -224,6 +224,9 @@ struct hsr_priv {
 #define hsr_for_each_port(hsr, port) \
 	list_for_each_entry_rcu((port), &(hsr)->ports, port_list)
 
+#define hsr_for_each_port_rtnl(hsr, port) \
+	list_for_each_entry_rcu((port), &(hsr)->ports, port_list, lockdep_rtnl_is_held())
+
 struct hsr_port *hsr_port_get_hsr(struct hsr_priv *hsr, enum hsr_port_type pt);
 
 /* Caller must ensure skb is a valid HSR frame */
-- 
2.50.1


