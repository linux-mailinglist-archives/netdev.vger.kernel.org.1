Return-Path: <netdev+bounces-278148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIJEJt4n3WmVaQkAu9opvQ
	(envelope-from <netdev+bounces-278148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:29:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 500793F1750
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0CB3A304A202
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F12434CFBB;
	Mon, 13 Apr 2026 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCEhutYW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBD533F390
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100305; cv=none; b=PXs0Gycn4jJOBxxDUIc+Qa7H7KEtQbixK9Ht/htWhDUofCk0+4CYMCliGEQ3qYB0v6vlTm+qw2fMS12iMtIJnzQguT5Fxu2weD3A+x0MVq6iPHL+k0C9U1wrCACTfJta5S/RBvTWp5pEK9c/ETGRjyF1cjyjqq4ngEDdmG9xzKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100305; c=relaxed/simple;
	bh=wsYlgGTBlys5VwVNyeDbwD8hz1JSKcg/S8Nt36Cylu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYv+x1FT8GmPLQnZtteOi8X5y3kbqk3iqbUcIn5iW2/YMaSmo5RarRP4M+UOOTnn5XtPGYY8b84MWXgtjgQwW2A/X5oDmv+8xWnHVtK8uT4vSnyvJ2FKlxvwZbMugWpeK5KWfR3fN+/+FUAzvVtmNgAoQgnw/lZiNsqvw1Wi3zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCEhutYW; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7dbba5076c8so2355366a34.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776100303; x=1776705103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jED2uh/NnlR5YsZ+z7EvK5KD7UFkLevWECSvjFZMvQs=;
        b=HCEhutYWNaz/RdVIDg46+QDPXPWZMkgP/y+j0lAHvToA80F9l420vAL6tO7aDzUi5j
         9IpFVGY++y2DCWOnaJGyc82CgpM82Ms+cqDN0pK4duh+tz9LFF3KTe6bJ0/PgSR+4361
         7cr03YQgU6bQDTQG8KBuXNZG2pElfVmv/NdTxhOxtGmc2LA1vmA5DTnnIfFuu91n4z9n
         /58ur4goLOxfaHE3vMkiX3s69sDuku5hiY3aXwtvdEhzwMNCPUd/QrWtHZdmp406tbiO
         rXU2nP0F5uxGXHTNysjiH2zNIHWpG/hsD9gt9KOmNtEpRblsNvFG/+9z9vnsPCNXuCxs
         XMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776100303; x=1776705103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jED2uh/NnlR5YsZ+z7EvK5KD7UFkLevWECSvjFZMvQs=;
        b=drQzxceyMKmy65HOeq2Mrr0hr/HCBnUuTmdfE7c5/iZVWHxlU9PHJvdWqFvSIAwX3+
         BwsTgVbY4AXR3cmn52LhBKxc0eZzRbAtFtn9mIKpT58w1cgf3FpzSpw4aRM1Xjiewa1w
         wlASQo5LrOFhr8ElXc/SV/LutST5ITFt7u3I+tq/bU1akeqq7aJ1td2DaxAdkXkhfHpD
         yypjVTn2EnUwuSstYCm6NiKm22MrloD96FTg9ZtGkvbw7HHUr81ujK+71cP1AcB5SEoj
         Mo3j3C8vHtzSBPz8DOvlEgoznDu8eX/Nk3bQwosMCdNYnu5TBcqJGWDFuQcxHiTjOVlA
         aAYg==
X-Gm-Message-State: AOJu0YyH4G34B4dcMxy9i5YyEUbI2ArvsrLCVki8DS3uuL0Udi62dZtL
	+Ho3WMIXllCuU+7WuDRMqPMhDJcrbh2KMy1f/Ws/3ocSFN4mLXCP45VTJndGFn5o
X-Gm-Gg: AeBDievQHL2tELCcMETwOvBKJNqT1e7wMC4fIo+wV4TUcEH0NHmMB1A8D+9R+3Ca8YO
	vkvTyoeHATNiW76lHuakxsltJxo4L68K5dVzFeuBZ0UKjEiBAoewdx/RCHWtuwxBECEnhXLlCpd
	DKWOW/xuz5kjJn8BlVKiWtWXENwRaelWWsAO1Y674Tr4qQ+4/u/7XEs4jPEno5huy8GHpEJJlFN
	Uka8Hi4xLmulff3ymJvBjr/pHL2p8zO6fk0TsvnTeLjG/3oO5KWRi31GmcAXLzVo/k1nhkrTl8T
	d4kvHs+lIn+S05ws76TPFzfYKxghPbtJq0iEmjqC/2JsKV0UPRVMnKnrXqTOGGQkdNLwUpF5zra
	Y4FBrUIW0M4LqbyFVZ3HoEiBWd+dmq9+t2tUV1t4C83E/G8EpDD4k0ad/KeiBMMWNV+FYIA/wX2
	OgOSc7TA+sazFTPaL/EC1HUuybhD3F
X-Received: by 2002:a05:6830:6504:b0:7d7:dfc6:e1d1 with SMTP id 46e09a7af769-7dc27d87a0cmr8314867a34.3.1776100302982;
        Mon, 13 Apr 2026 10:11:42 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:71::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc2d1aca3asm7693856a34.6.2026.04.13.10.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 10:11:42 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v7 10/15] netdevsim: convert to ndo_set_rx_mode_async
Date: Mon, 13 Apr 2026 10:11:26 -0700
Message-ID: <20260413171131.550126-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413171131.550126-1-sdf@fomichev.me>
References: <20260413171131.550126-1-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278148-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: 500793F1750
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


