Return-Path: <netdev+bounces-102759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EDE9047D1
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 01:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03DD8B23070
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 23:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E79156678;
	Tue, 11 Jun 2024 23:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="wDGQzWmj"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D82C155A5C;
	Tue, 11 Jun 2024 23:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718150066; cv=none; b=nl2FOPjwAtfrvhov2YSmaLQYcqZwfJeA9bvUNzIrVWjk1rkMbrYk43M91AjG7d3xOlm72zjyRJKn4XqHsddQU140SLiDU5i+SSrauNMgpmvik5Epac2+XZT3n4alx1ZSvWJFscnv89RPvgu2Y/rKuD4cojGJJ2RL5RQbWLaejOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718150066; c=relaxed/simple;
	bh=+hUPd2L+XW9o1OK0uo9xBYcaeGFFYjWBxApJBDzWEPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTz/YFBL/0RuRCcthJbc+1BfMUYQK3J+OPLaeKsbXphAi8t+g3nA+LJ0Q5uwrnDK/QqqJ7ShFjKpBKoHALxsQWHnXOgDJqkuyv1mh6lO00xZGp1CG60ZSK+zC6WRUkU1eZwHdGZGP0iCeZKGh/oJBBj+m4KeWi1jKd6fxS5SCCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=wDGQzWmj; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1718150057;
	bh=+hUPd2L+XW9o1OK0uo9xBYcaeGFFYjWBxApJBDzWEPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wDGQzWmj+Yj7AXrocGXVArV9XEZglOCxvvj1ga6GT9i9TKmGkmBo6gLmWQwKJz3SP
	 9ReewMNOLaucH2ohNrbIZdX9/R27K1iJUPMtQ0silY7cqhaxr65ZNE1t/+zQbQZ2W6
	 mbJ5oR1A3944FS3J5I+kH4E0A5RWP7KI1eyZHiQChTqde+mfWxGYPzGEFUntHiPc2O
	 Wf5r4/Be0HAXaOaJ23xAxluHGHt/16fxr6kI8CrSShQnBADWFADgf64V3UHm3PYoUg
	 zstWI1gHtenkxVke0IHzT/MQhb1a97bnsHjFDQt4ePHroHnlEwAd3oRaLiN2u2PmhW
	 ngUT1AHEodl9w==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id AEEFE60084;
	Tue, 11 Jun 2024 23:54:10 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 8C9B9202FDB; Tue, 11 Jun 2024 23:54:00 +0000 (UTC)
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
Subject: [RFC PATCH net-next 6/9] net/sched: cls_flower: add tunnel flags to fl_{set,dump}_key_flags()
Date: Tue, 11 Jun 2024 23:53:39 +0000
Message-ID: <20240611235355.177667-7-ast@fiberby.net>
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

Prepare to set and dump the tunnel flags.

This code won't see any of these flags yet, as these flags
aren't allowed by the NLA_POLICY_MASK, and the functions
doesn't get called with encap set to true yet.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 net/sched/cls_flower.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 6a2afc31f038b..61ab336645caa 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -1204,6 +1204,21 @@ static int fl_set_key_flags(struct nlattr **tb, bool encap, u32 *flags_key,
 			TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST,
 			FLOW_DIS_FIRST_FRAG);
 
+	fl_set_key_flag(key, mask, flags_key, flags_mask,
+			TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM,
+			FLOW_DIS_F_TUNNEL_CSUM);
+
+	fl_set_key_flag(key, mask, flags_key, flags_mask,
+			TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT,
+			FLOW_DIS_F_TUNNEL_DONT_FRAGMENT);
+
+	fl_set_key_flag(key, mask, flags_key, flags_mask,
+			TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM, FLOW_DIS_F_TUNNEL_OAM);
+
+	fl_set_key_flag(key, mask, flags_key, flags_mask,
+			TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT,
+			FLOW_DIS_F_TUNNEL_CRIT_OPT);
+
 	return 0;
 }
 
@@ -3127,6 +3142,21 @@ static int fl_dump_key_flags(struct sk_buff *skb, bool encap,
 			TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST,
 			FLOW_DIS_FIRST_FRAG);
 
+	fl_get_key_flag(flags_key, flags_mask, &key, &mask,
+			TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM,
+			FLOW_DIS_F_TUNNEL_CSUM);
+
+	fl_get_key_flag(flags_key, flags_mask, &key, &mask,
+			TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT,
+			FLOW_DIS_F_TUNNEL_DONT_FRAGMENT);
+
+	fl_get_key_flag(flags_key, flags_mask, &key, &mask,
+			TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM, FLOW_DIS_F_TUNNEL_OAM);
+
+	fl_get_key_flag(flags_key, flags_mask, &key, &mask,
+			TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT,
+			FLOW_DIS_F_TUNNEL_CRIT_OPT);
+
 	_key = cpu_to_be32(key);
 	_mask = cpu_to_be32(mask);
 
-- 
2.45.1


