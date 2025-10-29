Return-Path: <netdev+bounces-234156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB693C1D4DD
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 21:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44A1A4E4B09
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 20:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2533A30FC2D;
	Wed, 29 Oct 2025 20:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="KvcL0d9h"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3681A314D16;
	Wed, 29 Oct 2025 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771129; cv=none; b=PCCG87jKo8CjGcRKNUZODE7p3cLLsiLPNmYJ6Q9z1dxKyYuhmIQu/ZCrT81zOMbsp+lrCdr36VG1drXuE8RWQcfTsmHW7Gb7hkW8PlIrjEYD7khY9Le9UOyll8sOGCOOKjG1HO+xMTiOPEm9QBRKbqhUgERxWiW8KvqOcxmiVWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771129; c=relaxed/simple;
	bh=VlEx46Bcg7sgwxSxB/rp/FiOEaMxATetMP+R+ePo8/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVlgiNqHUtjtQmtapHn6wF+wuSrfkLToSZuLjzyWEwksISYHL4YOCkZHYdsXjZ6iyEMqooXZxw46nvIUU/K9QPtnz6aTeJM5lVW02YtpPrdycgQvj3zSgXnq4dLpeIQ3IfNc3B5nFXraUxL7dT+2CQ8cBYzz/uZf+cUa1BPZRkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=KvcL0d9h; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1761771115;
	bh=VlEx46Bcg7sgwxSxB/rp/FiOEaMxATetMP+R+ePo8/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KvcL0d9hOsBgMZ3g9QAiuOGznkQ9tU27zh769JoH3X3kpz7YJpNcRAG9AdkWnxt/s
	 7kfxKMEtCEi8djzvqqelJD/6dQA5HjT12OiuUhZm7/iSJUMmnTr8UkvkXZxGSLzGaE
	 OnV0Bu/GjysTgWIGDm7j049ZD3H5AbyuQHSKbtUGGXyUGBbOZwV1/A59VHCDwW8ORY
	 FlfjNGMWYjvYrS7QCTDSLHHigOnzG7m3kmRxUA1kiqz627jSY4Tyv6UxI0T4+6tft6
	 M1ae9h0Q0jMdS18hPgmpPM143XvJLBELOBKeO1CCEBe+A90xVSRjcLmeUtjQTxXYJJ
	 FxB0bGcQjqGhg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 2E61D6010A;
	Wed, 29 Oct 2025 20:51:55 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 2FD9F205047; Wed, 29 Oct 2025 20:51:30 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1 09/11] wireguard: netlink: convert to split ops
Date: Wed, 29 Oct 2025 20:51:17 +0000
Message-ID: <20251029205123.286115-10-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029205123.286115-1-ast@fiberby.net>
References: <20251029205123.286115-1-ast@fiberby.net>
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
index 86333c263e6a5..2acd651f4c71f 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -614,28 +614,30 @@ static int wg_set_device(struct sk_buff *skb, struct genl_info *info)
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


