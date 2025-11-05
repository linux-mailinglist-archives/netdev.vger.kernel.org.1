Return-Path: <netdev+bounces-235945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 521F9C37541
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 19:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7B41A21DC8
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 18:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAFF33E34D;
	Wed,  5 Nov 2025 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="p/j5nRwW"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2997C31D371;
	Wed,  5 Nov 2025 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367586; cv=none; b=QqGFEA07esOlILsn/L+PbV86IaOTbevpP7HjNKZR3iMIm9pvInQ/jEiFndqX7wRePhAh8oedDbM9RVXbveH7W4zEtO/eofYiyCechh2s2rFTZRp8S3HDkI8ZqLpN39T2MyMaDR5tlIgOydCiZbSN6RwbtVjTOlG2/fdleXM+Dt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367586; c=relaxed/simple;
	bh=YP/7Az468O3K9xv25TYnGVQmzRYsWPioltt1rTnsRhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6+uYF89g6a5J7obbqSyIXPV2c6d00deOKBu/HuZ4oPTMkYmxUhRX0st/BUWbPb84nh91uFYDYyJxZ10vRy7p30qdySnmVf2wVJrN+usdGR50S95nfhFS2QMwOPOx4Mn0k4P1wsRp6tjeQdW584hpoMzJovVGorOz3bhTrxRH8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=p/j5nRwW; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1762367571;
	bh=YP/7Az468O3K9xv25TYnGVQmzRYsWPioltt1rTnsRhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p/j5nRwW8wg+AoZ3gV6Wm0zWg8FqBHTyPcV5fku/rtnGh/fpBw5D4H8KpMXje0RvC
	 M+CT8x3WF/fiLQj2xV6gXI6ZS9pi4dBiqWfvAVhGahRVkpG4mKC0F+oBo//wlSAkK1
	 dIO0t03dQq1ezzZbqzptO9brpO9xl0l9QNWEdN3OIUWAhc1v+Dq/EVrti5Lfv8aB6B
	 D/GSu7XA0Ylj74YeN/5GzznIvEl9aSSxgaTJ8JRAqeYnn8NpB8U0MLYOM6MHkoLAVR
	 eLEXw4u1WBN4uNH77HRc0kO3j6oKuyyFKUuZd28AmH8vxWfkhSpF8D/2fnY49JCmSY
	 BGe+fPfMVTukQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 13A2260115;
	Wed,  5 Nov 2025 18:32:51 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 68A00205462; Wed, 05 Nov 2025 18:32:25 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jordan Rife <jordan@jrife.io>
Subject: [PATCH net-next v3 09/11] wireguard: netlink: convert to split ops
Date: Wed,  5 Nov 2025 18:32:18 +0000
Message-ID: <20251105183223.89913-10-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105183223.89913-1-ast@fiberby.net>
References: <20251105183223.89913-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch converts wireguard from using legacy struct genl_ops
to struct genl_split_ops, by applying the same transformation
as genl_cmd_full_to_split() would otherwise do at runtime.

WGDEVICE_A_MAX is swapped for WGDEVICE_A_PEERS, while they are
currently equivalent, then .maxattr should be the maximum attribute
that a given command supports, which might not be WGDEVICE_A_MAX.

This is an incremental step towards adopting netlink policy code
generated by ynl-gen, ensuring that the code and spec is aligned.

This is a trivial patch with no behavioural changes intended.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/wireguard/netlink.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index f9bed135000f..7fecc25bd781 100644
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


