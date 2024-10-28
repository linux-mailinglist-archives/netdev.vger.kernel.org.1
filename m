Return-Path: <netdev+bounces-139433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9DD9B2405
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 06:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334481F21244
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 05:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010F218C903;
	Mon, 28 Oct 2024 05:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Doq+oLm5"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE09815B10D
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730092070; cv=none; b=GoGDDEN5adKcnprKz0dQOpQTiEMrABN/ocBBkBlPaPfcPCZ6OVsQIdzOYeEEyEOkBcsPMEsWxG4m2wgO2Uso/iyjv+c9n9atTkIb0siogJUYVaRFxPHeEbioAP/MS4rpvu5rUqCuUBlbAJ4O9mgXpKiQBGgKwqRlCDv6C2wVIes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730092070; c=relaxed/simple;
	bh=oyPLf17Iwv3aGdvjOQ/Zucpf0l1SWbVR5lm95upvBxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bbVFGKnwZbypyKBjxUUyme83BHFHIOKSKxRPGFNgAzpap85Bpdw776q4MA9E+G0jfORM2bRrLwrti8zcxVFN7F0NzokbDlAJs+hBpScGNF4IPnzq9yCbzaa+M2Rn5MM/Ftq64BOKZgAdB9sQFKJ6Eh1BDAmcqijQ4pGGeW5J7Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Doq+oLm5; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730092066;
	bh=friYgHxcHFCpKwFUOVsqQZO9DMHIz/whwCAryidTIt4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Doq+oLm5MuHK0JGP/f+oW2wBanyLp7bAEeb5OAAnTJrBUTpUjksOPLpBdrkczgS3H
	 0aueNh0yPcxkgRH8/HKeP2YyA7iCjHpQRfjDK0h1MUeNMf8yJ8sHAp+Lbv2q2QwTZ5
	 /LdvDHCbU9jTqF29Ncmk7/NzuHpzvPAh/g+UqBAyr24qSRhZpLMJNgLY8Vocn22I7S
	 jRgEhrcElEFEW4sfqwboS5AxL8PvHAzgNkMulDMiitey5tOgPycuGIOkvatpTVwda+
	 Umy1/GqOl/1LhdX3g23f8N9GoVGNEtFKgpJfX90nPyPAd4DHZT8etO2J5fLKbjbxeJ
	 kCC3ZwBEebdig==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id E265169EAB; Mon, 28 Oct 2024 13:07:46 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 28 Oct 2024 13:06:57 +0800
Subject: [PATCH 2/2] net: ncsi: restrict version sizes when hardware
 doesn't nul-terminate
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-ncsi-fixes-v1-2-f0bcfaf6eb88@codeconstruct.com.au>
References: <20241028-ncsi-fixes-v1-0-f0bcfaf6eb88@codeconstruct.com.au>
In-Reply-To: <20241028-ncsi-fixes-v1-0-f0bcfaf6eb88@codeconstruct.com.au>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Vijay Khemka <vijaykhemka@fb.com>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

When constructing a netlink NCSI channel info message, we assume that
the hardware version field is nul-terminated, which may not be the case
for version name strings that are exactly 12 bytes.

Build a proper nul-terminated buffer to use in nla_put_string()
instead.

Fixes: 955dc68cb9b2 ("net/ncsi: Add generic netlink family")
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/ncsi/ncsi-netlink.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index 2f872d064396df55c2e213c525bae7740c12f62e..f2ba74537061ff616ce48a587969fd2270fb44c9 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -58,6 +58,8 @@ static int ncsi_write_channel_info(struct sk_buff *skb,
 				   struct ncsi_dev_priv *ndp,
 				   struct ncsi_channel *nc)
 {
+	const unsigned int fw_name_len = sizeof(nc->version.fw_name);
+	char fw_name[sizeof(nc->version.fw_name) + 1];
 	struct ncsi_channel_vlan_filter *ncf;
 	struct ncsi_channel_mode *m;
 	struct nlattr *vid_nest;
@@ -73,7 +75,14 @@ static int ncsi_write_channel_info(struct sk_buff *skb,
 
 	nla_put_u32(skb, NCSI_CHANNEL_ATTR_VERSION_MAJOR, nc->version.major);
 	nla_put_u32(skb, NCSI_CHANNEL_ATTR_VERSION_MINOR, nc->version.minor);
-	nla_put_string(skb, NCSI_CHANNEL_ATTR_VERSION_STR, nc->version.fw_name);
+
+	/* the fw_name string will only be nul-terminated if it is shorter
+	 * than the 12-bytes available in the packet definition; ensure we have
+	 * the correct terminator here.
+	 */
+	memcpy(fw_name, nc->version.fw_name, fw_name_len);
+	fw_name[fw_name_len] = '\0';
+	nla_put_string(skb, NCSI_CHANNEL_ATTR_VERSION_STR, fw_name);
 
 	vid_nest = nla_nest_start_noflag(skb, NCSI_CHANNEL_ATTR_VLAN_LIST);
 	if (!vid_nest)

-- 
2.39.2


