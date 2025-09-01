Return-Path: <netdev+bounces-218779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C83B3E7E4
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 16:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABEE14E17C6
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 14:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3B3341641;
	Mon,  1 Sep 2025 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="lEoyYAZE"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67871214210;
	Mon,  1 Sep 2025 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738340; cv=none; b=VV8KaQcmimqVbjahKd3zZvxan51l91AQ8Q8hwIi7JArvpfMaXgSHr808LRdoHW2Fv9xDL14CmzSBJYs/SwZsGzTx/4QDnR4YAcdDWpStDtD8/Cl29cGYEu5DgEUJUbMMev76TwpaZNU9brmxPm8A44k6okTBpA+WDj+RR/TlzMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738340; c=relaxed/simple;
	bh=KRQXLnLWCIStjwU1PJ0qUlA5bTV+OsW/zTXcSrBlAVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iv0nOl5YMen3CoAQSRqzGaR/OazUV/uyl3qrR/0lb3tbFx1yLeLxiaqiAuS82B1MVfO+rfm0mIPwbdUXJ1kNbcIJaK1gmc/z1eFLA0hPluLeYHQf/QEJX7lz806lV8BAoLGyrCtGEgKOnz6cYRFHvfelDJoeQoW74cV7ULJBID4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=lEoyYAZE; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1756738334;
	bh=KRQXLnLWCIStjwU1PJ0qUlA5bTV+OsW/zTXcSrBlAVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lEoyYAZE4LBlNvQLwJDr+z53za758eHXv0ULf741D8USuM3M+5V4EJdihow8dsQBP
	 n2axbvChSsi6Qn8X43XBpwezhTGHy/rojp7OhEokMtUTlJYOWKuYsgFDBBf62vwQKO
	 +iODzQf/LbVokRz8AcM1LwK3aYBPWPTxzUTKEmlPx6EkJ1YzTsnUwkOwYWmk6848L+
	 fqi/DQuCrwJxV5nLPY7aXX/8O3LRnhKcLtRN2lfc1XnwkLskpU4fIGqntljvbjmfgT
	 HNNg6wIYNcgfdoON75UEgLmLAIjho6ClRd2g3tyGfqkxQ7MrGKQn/f+TcyXuLwpjTT
	 BDrOpsEx/BRRg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id E873660128;
	Mon,  1 Sep 2025 14:51:16 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id EC95420226D; Mon, 01 Sep 2025 14:50:54 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/4] netlink: specs: fou: change local-v6/peer-v6 check
Date: Mon,  1 Sep 2025 14:50:20 +0000
Message-ID: <20250901145034.525518-2-ast@fiberby.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250901145034.525518-1-ast@fiberby.net>
References: <20250901145034.525518-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While fixing the binary min-len implementaion, I noticed that
the only user, should AFAICT be using exact-len instead.

In net/ipv4/fou_core.c FOU_ATTR_LOCAL_V6 and FOU_ATTR_PEER_V6
are only used for singular IPv6 addresses, a exact-len policy,
therefore seams like a better fit.

AFAICT this was caused by lacking support for the exact-len check
at the time of the blamed commit, which was later remedied by
c63ad379526 ("tools: ynl-gen: add support for exact-len validation").

This patch therefore changes the local-v6/peer-v6 attributes to
use an exact-len check, instead of a min-len check.

Fixes: 4eb77b4ecd3c ("netlink: add a proto specification for FOU")
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 Documentation/netlink/specs/fou.yaml | 4 ++--
 net/ipv4/fou_nl.c                    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/fou.yaml b/Documentation/netlink/specs/fou.yaml
index 57735726262ec..8e7974ec453fc 100644
--- a/Documentation/netlink/specs/fou.yaml
+++ b/Documentation/netlink/specs/fou.yaml
@@ -52,7 +52,7 @@ attribute-sets:
         name: local-v6
         type: binary
         checks:
-          min-len: 16
+          exact-len: 16
       -
         name: peer-v4
         type: u32
@@ -60,7 +60,7 @@ attribute-sets:
         name: peer-v6
         type: binary
         checks:
-          min-len: 16
+          exact-len: 16
       -
         name: peer-port
         type: u16
diff --git a/net/ipv4/fou_nl.c b/net/ipv4/fou_nl.c
index 3d9614609b2d3..506260b4a4dc2 100644
--- a/net/ipv4/fou_nl.c
+++ b/net/ipv4/fou_nl.c
@@ -18,9 +18,9 @@ const struct nla_policy fou_nl_policy[FOU_ATTR_IFINDEX + 1] = {
 	[FOU_ATTR_TYPE] = { .type = NLA_U8, },
 	[FOU_ATTR_REMCSUM_NOPARTIAL] = { .type = NLA_FLAG, },
 	[FOU_ATTR_LOCAL_V4] = { .type = NLA_U32, },
-	[FOU_ATTR_LOCAL_V6] = { .len = 16, },
+	[FOU_ATTR_LOCAL_V6] = NLA_POLICY_EXACT_LEN(16),
 	[FOU_ATTR_PEER_V4] = { .type = NLA_U32, },
-	[FOU_ATTR_PEER_V6] = { .len = 16, },
+	[FOU_ATTR_PEER_V6] = NLA_POLICY_EXACT_LEN(16),
 	[FOU_ATTR_PEER_PORT] = { .type = NLA_BE16, },
 	[FOU_ATTR_IFINDEX] = { .type = NLA_S32, },
 };
-- 
2.50.1


