Return-Path: <netdev+bounces-242868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B63C95952
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 03:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9530A4E1145
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 02:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7B21A2545;
	Mon,  1 Dec 2025 02:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ixnplAiO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9610A19D065
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 02:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764556139; cv=none; b=rzHirBRc+zmyaaQ/7NrrQrDzowtoSEjVKWV534zDFLDvsm4JFJtp9Fofj9LPidy35hV8DIOL40JXtKrXApboDF6D9MoPIdf/ied2cRlkShn91mR5CcHD1q9/AIYdJIChPS7cE3w2dIgPXbsmp7snTM8UoWPYGdoL0xRvP2DKwW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764556139; c=relaxed/simple;
	bh=mTg1QJqFEmyY91LNiaJEhSns91/hEqiI3HX3ozrbDns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBY8lt9njVjRIKZeMHJtocSlySj+ArWWGJ4NeJ4WBQp7BFRYfz+A5o5SL0aeDu0whsA9Ixwtixm0rq/5vm/qW/bWLkjgRAjhd0oM1aU5GpHqMm2kRDR8Y4yDo+q7V0SfhMhCOPGxkrW9+xmozbm9ckcpyxFpD3ACrV264yJ8amg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ixnplAiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98710C116B1;
	Mon,  1 Dec 2025 02:28:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ixnplAiO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1764556137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qcBmduSgnco6sSopqiB2JcVarA/MH3hvaH5zOxmMiOA=;
	b=ixnplAiO87AJowU8RyIVMG7q8/Q1MOHDB9OnbyC3eV+dZnNmIXrpa9gO8PSpeB/oxMiA3i
	D+EyrvEyy/6c1Ds+UE7H0vM136sLEVzkHuf+P9mx069UvtGN5G2mwy2oM7Korwcsty9Heh
	1zQEEezY1kkGSVUv6T08DPGTkJZOpKM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4098e0d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 02:28:57 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 02/11] wireguard: netlink: validate nested arrays in policy
Date: Mon,  1 Dec 2025 03:28:40 +0100
Message-ID: <20251201022849.418666-3-Jason@zx2c4.com>
In-Reply-To: <20251201022849.418666-1-Jason@zx2c4.com>
References: <20251201022849.418666-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Use NLA_POLICY_NESTED_ARRAY() to perform nested array validation
in the policy validation step.

The nested policy was already enforced through nla_parse_nested(),
however extack wasn't passed previously, so no fancy error messages.

With the nested attributes being validated directly in the policy, the
policy argument can be set to NULL in the calls to nla_parse_nested().

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/netlink.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index 8adeec6f9440..97723f9c7998 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -18,6 +18,8 @@
 #include <crypto/utils.h>
 
 static struct genl_family genl_family;
+static const struct nla_policy peer_policy[WGPEER_A_MAX + 1];
+static const struct nla_policy allowedip_policy[WGALLOWEDIP_A_MAX + 1];
 
 static const struct nla_policy device_policy[WGDEVICE_A_MAX + 1] = {
 	[WGDEVICE_A_IFINDEX]		= { .type = NLA_U32 },
@@ -27,7 +29,7 @@ static const struct nla_policy device_policy[WGDEVICE_A_MAX + 1] = {
 	[WGDEVICE_A_FLAGS]		= NLA_POLICY_MASK(NLA_U32, __WGDEVICE_F_ALL),
 	[WGDEVICE_A_LISTEN_PORT]	= { .type = NLA_U16 },
 	[WGDEVICE_A_FWMARK]		= { .type = NLA_U32 },
-	[WGDEVICE_A_PEERS]		= { .type = NLA_NESTED }
+	[WGDEVICE_A_PEERS]		= NLA_POLICY_NESTED_ARRAY(peer_policy),
 };
 
 static const struct nla_policy peer_policy[WGPEER_A_MAX + 1] = {
@@ -39,7 +41,7 @@ static const struct nla_policy peer_policy[WGPEER_A_MAX + 1] = {
 	[WGPEER_A_LAST_HANDSHAKE_TIME]			= NLA_POLICY_EXACT_LEN(sizeof(struct __kernel_timespec)),
 	[WGPEER_A_RX_BYTES]				= { .type = NLA_U64 },
 	[WGPEER_A_TX_BYTES]				= { .type = NLA_U64 },
-	[WGPEER_A_ALLOWEDIPS]				= { .type = NLA_NESTED },
+	[WGPEER_A_ALLOWEDIPS]				= NLA_POLICY_NESTED_ARRAY(allowedip_policy),
 	[WGPEER_A_PROTOCOL_VERSION]			= { .type = NLA_U32 }
 };
 
@@ -467,7 +469,7 @@ static int set_peer(struct wg_device *wg, struct nlattr **attrs)
 
 		nla_for_each_nested(attr, attrs[WGPEER_A_ALLOWEDIPS], rem) {
 			ret = nla_parse_nested(allowedip, WGALLOWEDIP_A_MAX,
-					       attr, allowedip_policy, NULL);
+					       attr, NULL, NULL);
 			if (ret < 0)
 				goto out;
 			ret = set_allowedip(peer, allowedip);
@@ -593,7 +595,7 @@ static int wg_set_device(struct sk_buff *skb, struct genl_info *info)
 
 		nla_for_each_nested(attr, info->attrs[WGDEVICE_A_PEERS], rem) {
 			ret = nla_parse_nested(peer, WGPEER_A_MAX, attr,
-					       peer_policy, NULL);
+					       NULL, NULL);
 			if (ret < 0)
 				goto out;
 			ret = set_peer(wg, peer);
-- 
2.52.0


