Return-Path: <netdev+bounces-220146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F86DB4490E
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 00:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972A71CC246C
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8890F2E7651;
	Thu,  4 Sep 2025 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="bzZnJJFp"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE462DF124;
	Thu,  4 Sep 2025 22:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023411; cv=none; b=BJSJmK+2aPQQCo74wNL66vAXTXvtIYVeE++oFTVlQ7C8+bsOx9g7FYzzw17abT22vzFQERbz1i079LzdkhfhEJAwFBoU7srWWgX2Fr/cAKNHxJW6j4B/w7bVopBAiIStOwvE6c0YAQSLckQf/S/Lr4lnhmhW/MtBbKR7x3c9BJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023411; c=relaxed/simple;
	bh=ECNMbXl3XLvGt4tALH0EaehkGJdjFoR5BhZ1oyO4DKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rGkQUTnhAnMJ7uTP7CnFVpYVTp82biD5ta8zc+mBJ367EY3BcmfM392TZ5hb6xtxTIa2nQ8IL0KW+mH9GGHaGMrHZB5knVzCTa6u6iVhAYNiUkdZ6fRNRVhY86SEzwH3yOeCmBs9wLzrVTdQjZCHWAqZL+v+S4rBZKooyA4iFDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=bzZnJJFp; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757023398;
	bh=ECNMbXl3XLvGt4tALH0EaehkGJdjFoR5BhZ1oyO4DKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bzZnJJFp7x0TGcadOB6VkbUDx+lay5/40mepR8zc6VCVjxCiyGL1QiULRw/Qu5U+Q
	 8sw45x379bEcIu1SInV5H3yjZMonFjOgEljmG1gq8bpwpUi5lt9gXhx9oaNJap74aw
	 xWxmOt1wAzXn2jCnjUrYVRCXC0ONm++TMeUForqMPkyncIpBCWgA0n503NU1oX9F+P
	 qdHIz3R6B70msIoQIgUHFK43EypLTIZpH/2F52eMyojuHzFplUukL6A/shfIw4ufK3
	 oz542vZ+n5Scvs0qw08/EUJGQXtIPQSyQcyv307bYeSa6mp4iF6leJdXNOWyHBZI+5
	 DRPwypK2RjabQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 5D3096013C;
	Thu,  4 Sep 2025 22:03:18 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id B6C0E202B2F; Thu, 04 Sep 2025 22:02:58 +0000 (UTC)
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
Subject: [RFC net-next 13/14] wireguard: netlink: enable strict genetlink validation
Date: Thu,  4 Sep 2025 22:02:47 +0000
Message-ID: <20250904220255.1006675-13-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904-wg-ynl-rfc@fiberby.net>
References: <20250904-wg-ynl-rfc@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Wireguard is a modern enough genetlink family, that it doesn't
need resv_start_op. It already had policies in place when it was
first merged, it has also never used reserved fields, or other
things toggled by resv_start_op.

[TODO: before v1, also test with ancient wireguard-tools versions]

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/wireguard/netlink.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index 0e34817126b9..67c448eef25d 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -592,7 +592,6 @@ int wireguard_nl_set_device_doit(struct sk_buff *skb,
 static struct genl_family genl_family __ro_after_init = {
 	.split_ops = wireguard_nl_ops,
 	.n_split_ops = ARRAY_SIZE(wireguard_nl_ops),
-	.resv_start_op = WG_CMD_SET_DEVICE + 1,
 	.name = WG_GENL_NAME,
 	.version = WG_GENL_VERSION,
 	.module = THIS_MODULE,
-- 
2.51.0


