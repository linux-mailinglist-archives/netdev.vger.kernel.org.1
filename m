Return-Path: <netdev+bounces-102767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5249047E3
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 01:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94352851FE
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 23:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240E915885F;
	Tue, 11 Jun 2024 23:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="tzl3N853"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EE5156F29;
	Tue, 11 Jun 2024 23:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718150071; cv=none; b=Nj8rC/Xk27VOWPCDAiJ37O1kAlRBfOcDQ8+VSitSzpMPRf2nFE/lwS4Zntxgt5FZgBzlAlkOK1stxKt1EgCv91v3b6SAQT+YLC6AQdz0TE6T9szsg9+q/K+Pw2yQzTEjAU88umXhN9yL5FeS298AMhb1JjYuWRZu59whw1RYuJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718150071; c=relaxed/simple;
	bh=VtZWuGrh1ylypaTQdU8aTLu6D7GfyOsmzUhjq6KIDwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c7C5PVTLC0+ppJFWlglSWJWDd0qGsyZkc2PP9RwtXPB6ASOavIe3/Aq6bkfGyrH1QYya9Hp/mtZwBlAXeXEAv4YpN5ii4vk9cWS9Im5yKT4x/zpF/swUUx3e5oNvj1jFGTI67r9zotkv/rai2n4uCneBEcFQf72hstVlm8/W4Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=tzl3N853; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1718150060;
	bh=VtZWuGrh1ylypaTQdU8aTLu6D7GfyOsmzUhjq6KIDwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tzl3N853ldx1Vy8RVIE4f7klT3sIGqET1NC5ncXlItYPqG8YniyvJJpZIQZovihdz
	 tsk5ebcSveeKwT1Z+cwKojy9zw4KCqKAd51/fI4QpE6WzqItL/8hSSF9qn7PgNbb6L
	 3jXVAJ0oPSqM4q16wogLB8YFQZlwDgF7GHED5SGmCHXKV98KiL6DQM6aW0kZw0t4Vo
	 jSvD22gcgSJEUvl50vq5wK9LiVYZXsHnzrS4umf7EbmWOcpQk3wMUhssoV6yBNatsB
	 IrAR7s8odiEwMeh/V9GuQY3Ko1nMY2DTnsn7qX43VWYAcQhz/SkjU2Yqumn+OKQh5x
	 ToZF6MXf+MnIQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 5D2B76009D;
	Tue, 11 Jun 2024 23:54:17 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 6FD3D202E0F; Tue, 11 Jun 2024 23:54:00 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Davide Caratti <dcaratti@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 3/9] net/sched: cls_flower: add policy for TCA_FLOWER_KEY_FLAGS
Date: Tue, 11 Jun 2024 23:53:36 +0000
Message-ID: <20240611235355.177667-4-ast@fiberby.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611235355.177667-1-ast@fiberby.net>
References: <20240611235355.177667-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This policy guards fl_set_key_flags() from seeing flags
not used in the context of TCA_FLOWER_KEY_FLAGS.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 net/sched/cls_flower.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 6a5cecfd95619..6a2afc31f038b 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -41,6 +41,10 @@
 #define TCA_FLOWER_KEY_CT_FLAGS_MASK \
 		(TCA_FLOWER_KEY_CT_FLAGS_MAX - 1)
 
+#define TCA_FLOWER_KEY_FLAGS_POLICY_MASK \
+		(TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT | \
+		TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST)
+
 #define TUNNEL_FLAGS_PRESENT (\
 	_BITUL(IP_TUNNEL_CSUM_BIT) |		\
 	_BITUL(IP_TUNNEL_DONT_FRAGMENT_BIT) |	\
@@ -676,8 +680,10 @@ static const struct nla_policy fl_policy[TCA_FLOWER_MAX + 1] = {
 	[TCA_FLOWER_KEY_ENC_UDP_SRC_PORT_MASK]	= { .type = NLA_U16 },
 	[TCA_FLOWER_KEY_ENC_UDP_DST_PORT]	= { .type = NLA_U16 },
 	[TCA_FLOWER_KEY_ENC_UDP_DST_PORT_MASK]	= { .type = NLA_U16 },
-	[TCA_FLOWER_KEY_FLAGS]		= { .type = NLA_U32 },
-	[TCA_FLOWER_KEY_FLAGS_MASK]	= { .type = NLA_U32 },
+	[TCA_FLOWER_KEY_FLAGS]		= NLA_POLICY_MASK(NLA_U32,
+							  TCA_FLOWER_KEY_FLAGS_POLICY_MASK),
+	[TCA_FLOWER_KEY_FLAGS_MASK]	= NLA_POLICY_MASK(NLA_U32,
+							  TCA_FLOWER_KEY_FLAGS_POLICY_MASK),
 	[TCA_FLOWER_KEY_ICMPV4_TYPE]	= { .type = NLA_U8 },
 	[TCA_FLOWER_KEY_ICMPV4_TYPE_MASK] = { .type = NLA_U8 },
 	[TCA_FLOWER_KEY_ICMPV4_CODE]	= { .type = NLA_U8 },
-- 
2.45.1


