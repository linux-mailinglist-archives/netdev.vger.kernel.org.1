Return-Path: <netdev+bounces-278150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDj9M3Ap3WmVaQkAu9opvQ
	(envelope-from <netdev+bounces-278150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:35:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A563F18DF
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A5A430E1385
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FA134E745;
	Mon, 13 Apr 2026 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eqsrpn/D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2A134CFD6
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100307; cv=none; b=knF94WBpl74VjvnceXMbKtZJTHjiw1E723WHM6A6JLU5E2Tw03M/HX+bKMqFYEraOp9Q2BKersDh4K79lWGbAH8UZ5ACcHbNWdJ50y5hIXMwxYo3dAWB8Ivic1HXAtI7N4u1on1MCg+toeFJsG+BH2Rr+Qz5QrIGeRO6Fe+24bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100307; c=relaxed/simple;
	bh=DblTuTiiUScWKwjSM8y2bGCj9IwmvdkqVpvGEE/EQi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNrWOIbHMwqVDYoTn3SbijsUO/5oFk6a76TjoQQu7QH4qjncTMOcdbACtb2cLkPOdC3IadzkLIrLq0FvJrVLSJ9lT/2cJJ7k+/zE3H5yFydCfqbRokStFlH+AQ/TzELij+x9HMtHdOwHWZG3mvkXZtjLAIipfuLMw7E1fr9md3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eqsrpn/D; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-4710c186d8aso1332383b6e.3
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776100305; x=1776705105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fl9PJQRW1at9+hyIvljSyrZjl0s2ic+yWjg5140FMUY=;
        b=Eqsrpn/DfkSNtoLUKj5IljZBaFFBPG/nCD60h09G5fhCFxfeC+EojFYelf7p+pjc5J
         HPUqajZCiQRCTEOhJwlllcUSXv+yAjcIUKParWSTW+tweye7jFz+GeybxHc//QdmQxj9
         YDXcCWxp6uc7At9HJ7SKHimOcv2k2jEgYriy2p7p7RgcQYbleTaCVg3LV1uExFesIdfT
         Uk5UXMOq1uG+U3inF7l5Iuv3iSub+CAWGaTd9q3vyi9SIL2jfpPQy8SoWDui3O35f+7R
         qjX4s/hpuowxSFwoDuTE2E/TkHFGM7F8KwTmVMA86RGWC6eUOw6WT/Vkvq93DFwaJkUA
         p6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776100305; x=1776705105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fl9PJQRW1at9+hyIvljSyrZjl0s2ic+yWjg5140FMUY=;
        b=a05eyGVCwF/MzmqgYI60X+UWdMZzOcyv19vcfnT75yjNfJwBhRwkrciMKkC5c5eK3Y
         L8Gf+0OONI+WbVtrPYm5PR0hUUY4Rr+GNCFBAOp1WkiK2Z83UuOCvkR6mxHSm71KuQFp
         +Ew6QAbWirTA6ppISCmrxY17kmu83EbXzjEisUtch1c3VHGx/FVO7dNkMrHCyFp5hbHO
         S2NTQTZEMUyHhSX1Vi/MIkcvE7czczk61jGpcZh5zHGkyUz1cPVhHrDJHwNtQbowsPvp
         SQxzzY8gjEqN97c7TQd7VtVm5OitjDSE2w4VARD8MKPRSNJMJUV8MfO57+5CBl83jjRK
         0aMw==
X-Gm-Message-State: AOJu0YzmBaeuWCz1m0rdRz47/MyMPgftpr7IvM8ZPV5xNfcCmLUzKNZy
	c5osTg8D+Mn/gRcSqpDO3FGiMNRRiaUE8ugW/P2SPKNiLZHyCDXf6tX6kP84lX2d
X-Gm-Gg: AeBDievnq37X80xpog6zTfYckJ3bXYbXKGW6aPwo5HTbiWK8NZSEDOe1Rhz/wcWYbKn
	zYchUUgg+gPnLKJ4l9eOL8bhxlATy/IVOinQW9DtlzVTRAjQK532ga2GFdsapMMDFZEgIMO0t1J
	XlCtgU+6eeu58zVAdX8guz/zJFrXpNVLCGQCbmPAXJ7qx5MEASn03hgDCY+z/aW3zl+qE3FQ8+z
	9tLMb19vuaTx61GT3f0tBHkHwVPpRU7vOCGsHuDTR2HL9ZV6BCpBjxFg5mO8hKBmCIm7LSyLWAf
	/B+lmyExx4pKKlFi39iU3W03k/Pr+bAWbr8Cw8Q0RrXDY4v3ZaZu7KAI9mbjnWGgVsfz9SsbG5a
	DKX5A5f3itye9CetzVtrdLtI7I4s1hIh3/zDDsixisc0eom47KyT9dU5Jr3jMy7097b/kR2JS2x
	D/KN/Y8GXLZ2HcKC+6di+ium/Xmjg=
X-Received: by 2002:a05:6808:8955:b0:467:284:b3bf with SMTP id 5614622812f47-4789f210de6mr7017524b6e.42.1776100304973;
        Mon, 13 Apr 2026 10:11:44 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:5::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-478a101b75esm6957926b6e.6.2026.04.13.10.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 10:11:44 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v7 12/15] netkit: convert to ndo_set_rx_mode_async
Date: Mon, 13 Apr 2026 10:11:28 -0700
Message-ID: <20260413171131.550126-13-sdf@fomichev.me>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278150-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,fomichev.me:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33A563F18DF
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


