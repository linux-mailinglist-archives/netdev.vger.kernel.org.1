Return-Path: <netdev+bounces-279127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yC+ACjkx4WlGqQAAu9opvQ
	(envelope-from <netdev+bounces-279127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:58:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC55413E9A
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B00DA30206E3
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A8034887B;
	Thu, 16 Apr 2026 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqwYknuS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com [209.85.161.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A839A34AB17
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365850; cv=none; b=GRlNy7XwZf6TWkLT9C9fpJVKGbt3UZ/9/H+haeFT9M+Qr81apgududd7WgvoS7RcbdvexgnQQNoV2rT/9pQfXNHo+au9YQbiTeAx4FvrVRSI3uYrLku7AIMXI8G2/MP1QlZgt/NjGd9wYOB0Xx/zXMCcR5EInNOteIwyBaWXkqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365850; c=relaxed/simple;
	bh=DblTuTiiUScWKwjSM8y2bGCj9IwmvdkqVpvGEE/EQi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ja7u0iai3NnC3YSr28zMXLPyiKZniG3udRmgzuD+G/AYOgWBWyYPcgnyfFYo38sBl6JCOrQj0N16h6H1UPwelzHv2d1oyEpW5s5ebkh+Z/tiItdJSP8fgy1jBPryImCH4iA8oK4cYrDIPwYoVQL24YIMoIFMaZxmJGVX1rrLS+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqwYknuS; arc=none smtp.client-ip=209.85.161.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f66.google.com with SMTP id 006d021491bc7-67c250805ccso2900881eaf.1
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776365845; x=1776970645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fl9PJQRW1at9+hyIvljSyrZjl0s2ic+yWjg5140FMUY=;
        b=iqwYknuS4Kpl9G+c8eMZ99bp33yU/9Cuz4oryN4duDnlxAG6R78poU/zWoF/rQ3jQs
         CfwBnwDJCzhhZIKHkRmZygF7JWotAGLtGo9C6pWPjGrrZ4/uMssmdwRFjEUrZzIgL/8f
         1kBcpeQJv0Py+/UROkDTLuUJ7+KzT0DxNwLYELynjOqEKqOr/XD54HMF5FSrH8Ml8NjZ
         6Jwq1s2bxygmobsycid2HlZNrfFt5Nlub73KkYtOYP4bxZprqjO8ceLcYx5Y0tCTW8Rx
         1ipURJiWw4fGXCEDtfqnIVo6mo8GNpMDnFxrqDORAy8/DyHRnIPMcSBYqHweJzOSOTdU
         nVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776365845; x=1776970645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fl9PJQRW1at9+hyIvljSyrZjl0s2ic+yWjg5140FMUY=;
        b=I0Aaugbi+h7yB2USxqnjT9S+VEz593EppAY5hliaOq91Ci+iWAlW5IZj2BjbxBgr1z
         yJDK+QzLThQjyxU78WhgxVvT62nQimqt1u9vm7SuuBbleCGSCijxP/v45VHrFNzQvYlX
         AQXt1XSDVumh7cNR9KMl52A8D05LbP9wznaZ9uj7kMYOk6R5Ay7c9uccRhwVJ6FYVebE
         qZg2MZwqUCV1Z20tDPPqZaBXmCN2bGJf2RTlrSxd+wDUNL/resKxxW/JPzaqkcSokkZh
         FM2oCMT5Ugod9mXzgeQASg5r9ieZyB1XfkEsO/p2K0nj1Gwywsd9ZjZr/bKFMSSrxI6n
         2aag==
X-Gm-Message-State: AOJu0Yw9ieBJwO9F3RSOFQWkVpUJUhvzciIFRUODuQ4jsgxmw7IHP9Mb
	sGT2uOpi9dlkAgQQq4Iq8n2XOFE7cXKXvkwYjxIBvjEwIfyRHuohDzGN5x7M/XRB
X-Gm-Gg: AeBDiesxJ++9yMx63nOnzSqh4kp9qHe0oHIh720NtNzyHESnowfVhACUHJz5Bkj42p0
	WLfS/95p2JFnlD9p3cCBE5MrNwuv2qpwyMHDi9desrGN60/A3vU5jz8MC+mcAtMvVxWieYZpmRd
	Kx5j/UyDs5MhkmZBNlGyNk1AZNzlH1YabQAnuI+6uFfqWTyFBdRIitBFnL1Z/HHTUL2SW1nItPv
	L+hmnQGTpspnP7LPck/YHyYHQK99LUEKgrbxjLfp0cNMuBL0K8GfBN4jxz/BhqCLtidUaHXuUzC
	ftEA+xqWGxfaw74P0S0aRkMUbWBKE1cW/XubE1aSrd4GvJ72OgaZd7hkTaZbZe0TchOHLoaD59F
	3uA8YRm42Oi7Dtn5NxEpdtjvOYL3RXzg/LMhc6ZlIk7D2MsFISkItEfKjoTlzW/4v5Upq9xB/fh
	J9KFOiNHIp1resY6otsoPrH3QRCcrn
X-Received: by 2002:a4a:e908:0:b0:688:2348:2953 with SMTP id 006d021491bc7-69461a93873mr227312eaf.20.1776365845613;
        Thu, 16 Apr 2026 11:57:25 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:70::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69460421421sm458775eaf.11.2026.04.16.11.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:57:25 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v8 12/15] netkit: convert to ndo_set_rx_mode_async
Date: Thu, 16 Apr 2026 11:57:09 -0700
Message-ID: <20260416185712.2155425-13-sdf@fomichev.me>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279127-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:mid,fomichev.me:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CC55413E9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert netkit driver from ndo_set_rx_mode to ndo_set_rx_mode_async.
The netkit driver's set_multicast_list is a no-op, presumably
for the same reason as the one in dummy? (fake multicast ability)

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/netkit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 7b56a7ad7a49..5e2eecc3165d 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -186,7 +186,9 @@ static int netkit_get_iflink(const struct net_device *dev)
 	return iflink;
 }
 
-static void netkit_set_multicast(struct net_device *dev)
+static void netkit_set_multicast(struct net_device *dev,
+				 struct netdev_hw_addr_list *uc,
+				 struct netdev_hw_addr_list *mc)
 {
 	/* Nothing to do, we receive whatever gets pushed to us! */
 }
@@ -330,7 +332,7 @@ static const struct net_device_ops netkit_netdev_ops = {
 	.ndo_open		= netkit_open,
 	.ndo_stop		= netkit_close,
 	.ndo_start_xmit		= netkit_xmit,
-	.ndo_set_rx_mode	= netkit_set_multicast,
+	.ndo_set_rx_mode_async	= netkit_set_multicast,
 	.ndo_set_rx_headroom	= netkit_set_headroom,
 	.ndo_set_mac_address	= netkit_set_macaddr,
 	.ndo_get_iflink		= netkit_get_iflink,
-- 
2.52.0


