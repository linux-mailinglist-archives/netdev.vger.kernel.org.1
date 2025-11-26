Return-Path: <netdev+bounces-241972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F0DC8B383
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E320359A87
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B7130FC1A;
	Wed, 26 Nov 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="qbY6DAwz"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EAE27A107;
	Wed, 26 Nov 2025 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764178597; cv=none; b=AB1FmFrPJrX7XAGKcco1/L6TFBmkU39juiLgm2wSHQUOuTQk8w8NPN0fdTOuKX+z4kd/tA31eLHhLMDIL7/ivwUOpog6y0LtrDhX9kNIwSjvjSlI01p4CCG/8q9w8msnxiYujHZsmPwSbbP3razuk5lGp83QcfX87leUsUZuWrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764178597; c=relaxed/simple;
	bh=zqscjuT+nqAfimhDrwVoWywXFau9EeWmN4CxkPbl48Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XjgtGXIhMcqPa+8o6QoBPkyVtA3rxK3yYU54/qk3QsR/e775cmIJnjtrlqHVPUW0i5wUF7IwzmRB5vJ1EvIkRIRHXi71XXw7jejPejVJXnW4BgxauKymPsZ8vKE8UhWbPqWa1iMcMowIvpcfNOsrVycREJC+7o96NbowMQ/Xdt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=qbY6DAwz; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1764178585;
	bh=zqscjuT+nqAfimhDrwVoWywXFau9EeWmN4CxkPbl48Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qbY6DAwzYHZhtxBCj+dmAIk5QdC5ttTLF2bmEYyGlT9TXjfN4KfPRX7Kkhotv6m8M
	 aYwzEzDkn30RILmkqsUod5ypOOrlNfptJg8ALkRwyo7sisJo07dUa0PGmlXhjDhzwg
	 XhnoGwjKekWyUNLIag+x7PRJNnrqTODW7fE4AN2aVX8eNxUDDC5zuo7NFr1+gfCjlf
	 w9ecv0/wdEHcxnlW4iz2GeS3LmSA+gItbUT/nZh/0JfVjisUDcZdWlCmZnjHJJO84/
	 8REpjuf4MWMg06Cy5jgBk3VNKpTj2LWogGSwXeQJDJGi6hcdjK93oSfIGbVxdx/n1A
	 ulVQDQikcfCHQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 24BE9600FF;
	Wed, 26 Nov 2025 17:36:25 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 7F457203189; Wed, 26 Nov 2025 17:35:50 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jordan Rife <jordan@jrife.io>
Subject: [PATCH wireguard v4 03/10] wireguard: netlink: convert to split ops
Date: Wed, 26 Nov 2025 17:35:35 +0000
Message-ID: <20251126173546.57681-4-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126173546.57681-1-ast@fiberby.net>
References: <20251126173546.57681-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch converts WireGuard from using the legacy struct genl_ops
to struct genl_split_ops, by applying the same transformation as
genl_cmd_full_to_split() would otherwise do at runtime.

WGDEVICE_A_MAX is swapped for WGDEVICE_A_PEERS, while they are
currently equivalent, then .maxattr should be the maximum attribute
that a given command supports, and not change along with WGDEVICE_A_MAX.

This is an incremental step towards adopting netlink policy code
generated by ynl-gen, ensuring that the code and spec is aligned.

This is a trivial patch with no behavioural changes intended.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/wireguard/netlink.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index 682678d24a9f6..e7efe5f8465dc 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -616,28 +616,30 @@ static int wg_set_device(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static const struct genl_ops genl_ops[] = {
+static const struct genl_split_ops wireguard_nl_ops[] = {
 	{
 		.cmd = WG_CMD_GET_DEVICE,
 		.start = wg_get_device_start,
 		.dumpit = wg_get_device_dump,
 		.done = wg_get_device_done,
-		.flags = GENL_UNS_ADMIN_PERM
+		.policy = device_policy,
+		.maxattr = WGDEVICE_A_PEERS,
+		.flags = GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DUMP,
 	}, {
 		.cmd = WG_CMD_SET_DEVICE,
 		.doit = wg_set_device,
-		.flags = GENL_UNS_ADMIN_PERM
+		.policy = device_policy,
+		.maxattr = WGDEVICE_A_PEERS,
+		.flags = GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DO,
 	}
 };
 
 static struct genl_family genl_family __ro_after_init = {
-	.ops = genl_ops,
-	.n_ops = ARRAY_SIZE(genl_ops),
+	.split_ops = wireguard_nl_ops,
+	.n_split_ops = ARRAY_SIZE(wireguard_nl_ops),
 	.name = WG_GENL_NAME,
 	.version = WG_GENL_VERSION,
-	.maxattr = WGDEVICE_A_MAX,
 	.module = THIS_MODULE,
-	.policy = device_policy,
 	.netnsok = true
 };
 
-- 
2.51.0


