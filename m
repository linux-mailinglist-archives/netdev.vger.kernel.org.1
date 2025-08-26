Return-Path: <netdev+bounces-217057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9491B37359
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 21:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CAB61BA28D5
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 19:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3071C30CDAD;
	Tue, 26 Aug 2025 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilwFVOfz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A60830CDAC
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 19:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756237498; cv=none; b=O3VSMiHyzWGgmBZaB0VkAViBOaONd4tXDrDFZStyds38k4psnp6VCHoiapLBC7FeSsi1GUiWv3aek2BkmFNpRq5+JIL+vtQh7jzir5iTWBCQ9C5vxTTpAG0OzUQ96TjmdOvU7KU6hiDEkoiVgVCPAmC7SUemPSuIL7AdLL8IQOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756237498; c=relaxed/simple;
	bh=Zic5KfnYYlSwdfc+stSFWiXnIsqTpiJwj8RZvMBJyho=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPBXLYp1i/KJeKpKXJ8gRu4MDCXHKKZFD5dtKM4G1HsAqx0C1enmKZ/8dDyUwc1Gd+fY3/CQxXUTN5hDxqxw0GlwtQH6Ws/M2cBd2fLDiLA8eTD5IxR3txd1lpcopIBOY1AY0zZFLgH7Slb3I6EoS5PjHeA19eJ4Y9OoY+PPMyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilwFVOfz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso5319051b3a.1
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 12:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756237496; x=1756842296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XX4THsl51mMb/4Qdyeb7xprDVdK15qF/pWnCpGxOAdM=;
        b=ilwFVOfz6HeZBwUrgElrnVp1qc/2DZDZRLSz9hq/yjrqMwebT5DkbWMI6YeMl7ZZGp
         JnCcCXZiAfRExDs0N+pPbJKqK1NMQ7chzoGihlpk4RThjIU03bN7esbcqMFwghTGebxk
         CpZ4JuElwSWgiSCOK6Ua51gpcirZPMnlIh7VIK3ggUwVXbV+4VS4NpjNllkerAxE0Org
         8XYhpQJ/aITQdBJhPIrumx5kfv8ojqTWK+B0HlLJSZrjG2GV19CItULVI3di29zkW34u
         Gfa0ZLG1z+PNicpeXPm/TwqIvJRlmlOnvSwzG//pPq5JMEOu9gC4vGjCA667juL2obN4
         Q1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756237496; x=1756842296;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XX4THsl51mMb/4Qdyeb7xprDVdK15qF/pWnCpGxOAdM=;
        b=t/ccEic60JiXlEi+tzgwZkU5U25e7xTP9loH8zOSgjiS6QZaquYhRkcK4uBS6zgFrq
         LkINYxdN1JCiPpa34IAj1H3p8cXXP98TY++/I68Qoi2iIaqb4U1jvNmrLCZfh94KPpTt
         mh0u0H6DkXNv23EWWZqSJVXiFEyHE3b4KuSi6nlAASCoAzJKO8DhK39VExxhJZTF3XkW
         OatJSWsj9DE/vVVp9acYCnh7Nt28cIiqa8h1JSuIQFB7QVwC3P8amXJeX1KTLzilEhKT
         /wWDNqdBKiK8uFi1osma1IgkqRzC4ITh18Zt4Jxkr2e9Se9tL38JzB2l6Y2Wr3zh3I7J
         T+mA==
X-Gm-Message-State: AOJu0YxWVJDSgM3RLzJV0ayyM7yOzSD5hGKD2K6EoZeCE/hiRdFpqBHt
	hQDDJb7M+ux46WuFYDFSu+PshOgQmvVwD9bEmrAGWImHA4U+USjzLmAa
X-Gm-Gg: ASbGncsG6a6nuBgJhEBrWTOCFRCbRP/FKePlSuTxvmBb8Ab9TG8dfXxFy/7AwKnme0o
	yyYjRyV2i0AA8GLZ9WNU1CrHAvl74hKbvqnvAX1ayuKlYKsR8BKXs+MJkyDbBP1VJ4TpL4l7Rh1
	1tLAGlBzb0DSi11oqE63DWXTr4BJxh8lTO3JCaOQlZYWPyhyNm2CuXaWyOg4obxzGlWG97caXaP
	3J4Lg9ufs9El+fQh6vj5usRXhiC6oxxjrxWJ/+QHTjUDJsluIqZSdlPBQfBsFwfywp4taFBSeU5
	oY9Bj82Kq4laeilyfzPmBhBAF8q1TfHB4CbODfGzVawydB67CZHnr9KDo3HFfzLrM8Tv1ZyhU4u
	ulm1nuiv6cQCMqz+u139X6mlMPP14gGfKQJ6GemwJEJ4dyc+YOqbz1r5y
X-Google-Smtp-Source: AGHT+IHFasHdCd7tItGERsv6Qh1uHi96mm6ZcGXUEew/UYQu2k+nc3c4jEJ7gnQBOVDiTkJ7xrdKFw==
X-Received: by 2002:a05:6a00:1742:b0:76e:885a:c3f1 with SMTP id d2e1a72fcca58-7702fc2d308mr21472464b3a.29.1756237495842;
        Tue, 26 Aug 2025 12:44:55 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b01b2sm11021077b3a.64.2025.08.26.12.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 12:44:55 -0700 (PDT)
Subject: [net-next PATCH 2/4] fbnic: Pass fbnic_dev instead of netdev to
 __fbnic_set/clear_rx_mode
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 pabeni@redhat.com, davem@davemloft.net
Date: Tue, 26 Aug 2025 12:44:54 -0700
Message-ID: 
 <175623749436.2246365.6068665520216196789.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <175623715978.2246365.7798520806218461199.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <175623715978.2246365.7798520806218461199.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

To make the __fbnic_set_rx_mode and __fbnic_clear_rx_mode calls usable by
more points in the code we can make to that they expect a fbnic_dev pointer
instead of a netdev pointer.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |   15 ++++++++-------
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h |    4 ++--
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c    |    4 ++--
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index c75c849a9cb2..e2b831610388 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -179,11 +179,10 @@ static int fbnic_mc_unsync(struct net_device *netdev, const unsigned char *addr)
 	return ret;
 }
 
-void __fbnic_set_rx_mode(struct net_device *netdev)
+void __fbnic_set_rx_mode(struct fbnic_dev *fbd)
 {
-	struct fbnic_net *fbn = netdev_priv(netdev);
 	bool uc_promisc = false, mc_promisc = false;
-	struct fbnic_dev *fbd = fbn->fbd;
+	struct net_device *netdev = fbd->netdev;
 	struct fbnic_mac_addr *mac_addr;
 	int err;
 
@@ -237,9 +236,12 @@ void __fbnic_set_rx_mode(struct net_device *netdev)
 
 static void fbnic_set_rx_mode(struct net_device *netdev)
 {
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_dev *fbd = fbn->fbd;
+
 	/* No need to update the hardware if we are not running */
 	if (netif_running(netdev))
-		__fbnic_set_rx_mode(netdev);
+		__fbnic_set_rx_mode(fbd);
 }
 
 static int fbnic_set_mac(struct net_device *netdev, void *p)
@@ -256,10 +258,9 @@ static int fbnic_set_mac(struct net_device *netdev, void *p)
 	return 0;
 }
 
-void fbnic_clear_rx_mode(struct net_device *netdev)
+void fbnic_clear_rx_mode(struct fbnic_dev *fbd)
 {
-	struct fbnic_net *fbn = netdev_priv(netdev);
-	struct fbnic_dev *fbd = fbn->fbd;
+	struct net_device *netdev = fbd->netdev;
 	int idx;
 
 	for (idx = ARRAY_SIZE(fbd->mac_addr); idx--;) {
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index 0a6347f28210..e84e0527c3a9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -94,8 +94,8 @@ void fbnic_time_init(struct fbnic_net *fbn);
 int fbnic_time_start(struct fbnic_net *fbn);
 void fbnic_time_stop(struct fbnic_net *fbn);
 
-void __fbnic_set_rx_mode(struct net_device *netdev);
-void fbnic_clear_rx_mode(struct net_device *netdev);
+void __fbnic_set_rx_mode(struct fbnic_dev *fbd);
+void fbnic_clear_rx_mode(struct fbnic_dev *fbd);
 
 void fbnic_phylink_get_pauseparam(struct net_device *netdev,
 				  struct ethtool_pauseparam *pause);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index b70e4cadb37b..06645183be08 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -137,7 +137,7 @@ void fbnic_up(struct fbnic_net *fbn)
 
 	fbnic_rss_reinit_hw(fbn->fbd, fbn);
 
-	__fbnic_set_rx_mode(fbn->netdev);
+	__fbnic_set_rx_mode(fbn->fbd);
 
 	/* Enable Tx/Rx processing */
 	fbnic_napi_enable(fbn);
@@ -154,7 +154,7 @@ void fbnic_down_noidle(struct fbnic_net *fbn)
 	fbnic_napi_disable(fbn);
 	netif_tx_disable(fbn->netdev);
 
-	fbnic_clear_rx_mode(fbn->netdev);
+	fbnic_clear_rx_mode(fbn->fbd);
 	fbnic_clear_rules(fbn->fbd);
 	fbnic_rss_disable_hw(fbn->fbd);
 	fbnic_disable(fbn);



