Return-Path: <netdev+bounces-276054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLIiKrYk1WnK1AcAu9opvQ
	(envelope-from <netdev+bounces-276054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:37:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5353B1228
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94CEE30E0DFD
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B8E36DA1B;
	Tue,  7 Apr 2026 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMefPmLC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19203BFE5D
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575904; cv=none; b=iNtnwCs/6nu0l8GMRwXu7B5w7f4XmxRwPE4aJgdXm13YEphPanhfI4d7jInEbznd+RoKBI98FerPo9J8jDjMRbkXDphacptUF8ingaO8s12ZlP+6tCgXTlpV5ERQ+tj+S0SA5dy/Me6oVufdEU4hBYjhW3UwXMbpUJu1yP+xT7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575904; c=relaxed/simple;
	bh=v23//E0JGII2nVxzm68+kN8cdfhFLcB/CTJGXqqcX1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DViYC2hIH4jkkt3kcPL13n60xsZFCKtFftMaZJFNoRxKHG6cdJFLe+ASg7h2ZpiyJmb6L8JOkHvm7bnyRk+Uxasx/sSMpYStXAxKTIwsfbqoaf/5edXeflyZhuOk5JmTAawVRmPzF7v2/QS9zh72sLAffkI1Vpy3u4tD3EVMlng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sMefPmLC; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7d1872504cbso969a34.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 08:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775575890; x=1776180690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAWENlI9PzRx9ggSEqs5vEqtc+nROP63EGy+XuO8Xws=;
        b=sMefPmLCTc64ueKcTktOjzXoNycTgReyFR4JddmqxX9mXSDmZLACTvphhqDjvpL7l+
         2yHPEafHgEHsAkyO7rjisGlwsUh9RonZvAFZxdMF//PICgg81eXcsgVhk1nupZ2lEeSb
         RiYcsMEP4GW3jPUWFQoRxfIsW/8JeIbYoaZiEHt9MLlieuh7DZpfi0JhJPazzC4FHpqH
         HfnHTEEVRCVMgLJAbEnu4jwF436nOn781KtyCM7ZYATMGJfHMXFXzNf9N//CPth2pMQk
         d71E9dVrbc8HA4xRTQ97h/SrLSGUe6IgMT5B7rRcpm2fQToMBkwYkRE+crTLe3J7LUE5
         gPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775575890; x=1776180690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OAWENlI9PzRx9ggSEqs5vEqtc+nROP63EGy+XuO8Xws=;
        b=N3moX/KXAMDfq/NeuQ0W/c7efglOsOQlISMObwwAdkpxZl1wFPQXJU89NYJWrZd8It
         dK6WklsoJiPaIslrszdJ3f1J+vFD/uIqP6kL+1yWsDMs9gZzKrzy31SQEa7yu7GAtzr1
         nEnHvkxBpPBJENlEcFpry0WTO8B24cR5d3dpL6OwQsO+X6n8s4WzcpUmp7FZSikmUgPc
         +iKfSJDjsntb9Yc9BxliO9Xu21SsG9pYzIJeq4bD41JVMPNIHVR24lTePeQIEj0aUJ7s
         pwJkSnDuQmCaMj25maLAQscmmCb0vDzlvN1yyhYHZrn9MiXQce+g88pOjGYRUDYUugfD
         VOVw==
X-Gm-Message-State: AOJu0YyMAXpdd9zY8xNKAocX7rtGcEXcBwsrjbqzz3L1Ivqk2gDN6Uen
	4E76Svxtb+jGk7C/+6r50+Nlts89l/2IroaCVpQQdxGFFL4zAxC2ZI/Qs2XFw5VvxUs=
X-Gm-Gg: AeBDies+Wc3mcBnV9FGDNPD3FtUYkuyztbBoC2zmfJKUOhPyaKrFbVyjwY0azK/1J/r
	zIrNQ6do+5fdqsrcQ0rLpGh0lOl6n6hJOU9OQe8RolT/Ossxl+efbzaope2ZPwYIzZhSB0L1l9I
	5nytR/wLklQbczuCYGCDzlEnLHQAXvHAZEsOi8O01QESv1II03UIGbW7zFKigk9RyP1FY6DbRo7
	EHCrDtOVoI2dyP+qmDsiaISskAgFkiNz+eI9hdK03OTBECp3YyExI6zUCBHi6yUhF95OwmSQH/s
	/l7iACe7Gq26d4hBMmonP5wAlc3FICGud6kuQe72IRantx5beA5yvB+vJeRlBUBFPF/DlR7YO9X
	x3s2zrGIxTKPICxezOo3Ld2PG6Zi/YKMWzCqk+gforKtlynciixnODL5FcyAWbduTay6SoTKJ1+
	t3kmBFzvq0GJAxnQ4q
X-Received: by 2002:a05:6830:d:b0:7d7:f3d1:d701 with SMTP id 46e09a7af769-7dbabc2f75fmr8173405a34.6.1775575889650;
        Tue, 07 Apr 2026 08:31:29 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:5::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbed6c3512sm2894870a34.4.2026.04.07.08.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 08:31:29 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v6 10/14] netdevsim: convert to ndo_set_rx_mode_async
Date: Tue,  7 Apr 2026 08:30:57 -0700
Message-ID: <20260407153101.3694714-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407153101.3694714-1-sdf@fomichev.me>
References: <20260407153101.3694714-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276054-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,fomichev.me:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F5353B1228
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert netdevsim from ndo_set_rx_mode to ndo_set_rx_mode_async.
The callback is a no-op stub so just update the signature and
ops struct wiring.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/netdevsim/netdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index c71b8d116f18..73edc4817d62 100644
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
 
@@ -593,7 +595,7 @@ static const struct net_shaper_ops nsim_shaper_ops = {
 
 static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_start_xmit		= nsim_start_xmit,
-	.ndo_set_rx_mode	= nsim_set_rx_mode,
+	.ndo_set_rx_mode_async	= nsim_set_rx_mode,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= nsim_change_mtu,
@@ -616,7 +618,7 @@ static const struct net_device_ops nsim_netdev_ops = {
 
 static const struct net_device_ops nsim_vf_netdev_ops = {
 	.ndo_start_xmit		= nsim_start_xmit,
-	.ndo_set_rx_mode	= nsim_set_rx_mode,
+	.ndo_set_rx_mode_async	= nsim_set_rx_mode,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= nsim_change_mtu,
-- 
2.52.0


