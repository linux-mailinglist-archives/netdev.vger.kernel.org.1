Return-Path: <netdev+bounces-279124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aG6GIJYx4WlGqQAAu9opvQ
	(envelope-from <netdev+bounces-279124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:59:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF137413EED
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6DC5310DA32
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6778E34B68F;
	Thu, 16 Apr 2026 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kkgaos3K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0628734BA50
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365846; cv=none; b=FWjYuTLAd+dFIk2dLmxWaVtr+/AGkV9OhuvnQ2c/07XXduHwLK6iZUJ2JFsKRaHT17XGhgRHsRcXn8F1Jgi/TEScNXErizFjw+i/hIyuR5bDtN7RroPjVjpEfaLUOGrfytLdX6BJ1/ck7pnpcNzHFHrjvqxXzBS/uZSMalHtSHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365846; c=relaxed/simple;
	bh=xYKw2eGTZjAdCjVB6K7BkpLUVWm0/KwQXCxpWvfJaZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPZj/eIRlx2s3yZcYV7VrWNWD1TPihELphBiyGaQBzlgrm1DmISRkd1F1jJP077VvH51C3MJjgdSeY+MJ4u2WCVxJV2iGy3124TmTivbIplSywajBpcSQyfQU3oycBw/UT6eQuPYabRYiZxzjscmoynXYaUo//jzdSV2E76CClo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kkgaos3K; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7d55b97f358so5046529a34.3
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776365844; x=1776970644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEq/lgIWHIyJ/pMnMGwtjV+p/fJ6+V2z0hIx139Qr6U=;
        b=Kkgaos3K8KMIJuO4riK4xHKHoM6nNmY4Q/GcCyeNo4EX/2FojVxZqeSDVK7Ohlq6/D
         h6gmG08LO59jkEtB6+mley5fA6aaJI5Enr2O77lBxgX/cgAeJqMRrDkqPjbW9m3Cb464
         hI8cWMQVSr8pmY21GF7DVUUHug+ryK5eDcbw1XkJZo6l4FcPIx1qK7yIQiL5GXvH/PkD
         Va3QN0dZR4Yhgmm4Yl5/0fQJddPFd6NizPBXq5XDn6xEcckASGz7lLWXg8f+qMK4jvdI
         JHcJRbpvbyhHD/aAlP/Vb/bjooYnYrOXVpHQekGLH0MovmAaDpU4rhxKYlbOuUi1hmCe
         zZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776365844; x=1776970644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cEq/lgIWHIyJ/pMnMGwtjV+p/fJ6+V2z0hIx139Qr6U=;
        b=VXs5Fu93Y/xLRjjDqY1AYqpPHWlNpwXVzCbOZQ3SpI8ToH2ZHKn/6fhfAPjgzM0ruI
         RH7TKsV5kjlnfpx3IsJ0Keg/H1uc8J07Lzn96QlDhMPqDbDusnD8U11FPVmudcqHdOpk
         iBnjsei9/S6HtQ4k5dpaIzMP8ymGXRqMiJ2yq6iI2ZEjvAv+M4CPwJxmS/Z69jyHum6K
         2IsvakZOOpVd2n2KChdRaA0fATJ/5cb6N+ytQtB45rpvb+r2T9o6OVgHfABT5tSfRuLW
         aqJyxmk+DUk3vxyly8KFK+63U5zWYaxDBQ8XYRQ3q7LQEEibStuTCyl8nvm5rMcp1Zh1
         9ZpA==
X-Gm-Message-State: AOJu0YxkuC1JKF9+vVzWWyE8OxbCw/pENxtZdyxy3se6mo/RIb3ABoD3
	YZIEsAy3lhWpVf21aDXeHBehiNWNvSsd+FoHXJCSGLRKcTS38uM36IfMTijJot4F
X-Gm-Gg: AeBDieudCiOS6pwBibvV02lSTeCVylww+dY0x+4kURZ90FZW86s9ZIeOa7jZ8oFM0wJ
	QL42RvZqtFiUgo0fPAQ2Kv+UXCtdvYm2Q4iNdkmPfURW6LWmJSHpkwZEZOdIsEhtOMcL9Bzaaas
	OO4yqBHobTVdKHr6HaDp9Y/kLeOBEZaCicMoj9jPOOvCJWdMvZNU3we6rtVgJdECJrODKmoweAq
	t+d4kACOmiVTtl57s78l7muqg8dM58l5adBU+myotM5oOwPzwZjV2GqGCPHJQ9ifUMpGKXqIqP/
	8d7g2iWVQu1ZQ4pEttO4LoXr67yPoBreRO6dNnwxvi0dy+EMeR5uWh7JclnMY8WfctwU/ChvjyS
	Dzl3jZOO06/CoJPT3EnfC3aAl7LdFDX7SwH96JFZYP8aM5O2bYmHGzVporMLZFndKAl8yprGFmD
	LmVxpLO46KKmLgRcY6t1tyu26xJ/g=
X-Received: by 2002:a05:6830:67d4:b0:7d7:cea3:6d89 with SMTP id 46e09a7af769-7dc922d7705mr371558a34.4.1776365843854;
        Thu, 16 Apr 2026 11:57:23 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:2::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc90a6583fsm522827a34.10.2026.04.16.11.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:57:23 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH net v8 10/15] netdevsim: convert to ndo_set_rx_mode_async
Date: Thu, 16 Apr 2026 11:57:07 -0700
Message-ID: <20260416185712.2155425-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260416185712.2155425-1-sdf@fomichev.me>
References: <20260416185712.2155425-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279124-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:mid,fomichev.me:email]
X-Rspamd-Queue-Id: BF137413EED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert netdevsim from ndo_set_rx_mode to ndo_set_rx_mode_async.
The callback is a no-op stub so just update the signature and
ops struct wiring.

Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/netdevsim/netdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index e1541ca76715..a05af192caf3 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -185,7 +185,9 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static void nsim_set_rx_mode(struct net_device *dev)
+static void nsim_set_rx_mode(struct net_device *dev,
+			     struct netdev_hw_addr_list *uc,
+			     struct netdev_hw_addr_list *mc)
 {
 }
 
@@ -623,7 +625,7 @@ static const struct net_shaper_ops nsim_shaper_ops = {
 
 static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_start_xmit		= nsim_start_xmit,
-	.ndo_set_rx_mode	= nsim_set_rx_mode,
+	.ndo_set_rx_mode_async	= nsim_set_rx_mode,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= nsim_change_mtu,
@@ -648,7 +650,7 @@ static const struct net_device_ops nsim_netdev_ops = {
 
 static const struct net_device_ops nsim_vf_netdev_ops = {
 	.ndo_start_xmit		= nsim_start_xmit,
-	.ndo_set_rx_mode	= nsim_set_rx_mode,
+	.ndo_set_rx_mode_async	= nsim_set_rx_mode,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= nsim_change_mtu,
-- 
2.52.0


