Return-Path: <netdev+bounces-110365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F83792C1C7
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6149B1C2312F
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26631C006C;
	Tue,  9 Jul 2024 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Nk9zLMVj"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799A21BF329;
	Tue,  9 Jul 2024 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543123; cv=none; b=jZraxr1fS45gstmUzh7Ycy8ZRpyOe99zqqtJTzJi7wDzn93tQOnaAdrZCpPHmTyZT2PXE3aenLNZCPkOXjwl2BAQwjZRkQaWNeLYIO/DcFkKsF57u+pV/zprkfKsVTkwwz3xKp4wgcOD0yLmOsDKHs2Ecpr9PFHeoR658vQ9c74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543123; c=relaxed/simple;
	bh=JJoSLE5E+0mjDp0PfeRqb2o1NFt14d/nWg6OdMLm9/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWJ8IDCCXMQZCx33Mu5WvrYY3JcuAn6STorEEjkCTvnRQWUMEOutrBdwEKUG4dxxwdMPB95iMlfEfbK5tL7EovTrKA2Z/AENHUmsWVnqI7nOYCCuHjqXuWXSsUDRfm0WHBNmorE1o70913a8L4Ybng4rWrEbF43jPDmShumLLaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Nk9zLMVj; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720543111;
	bh=JJoSLE5E+0mjDp0PfeRqb2o1NFt14d/nWg6OdMLm9/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nk9zLMVjNzlrPNIy/z2GZWmhwiGqEpXZbnTlViciqxUvPWmZleQ0TDXLRGxl5lmLt
	 PEklPno1g5Uq3Xy/S/1JoxQNE91FC8PlbBWC/jP9FWfTdlz/+DsLzJ/xRk54tqSnsq
	 ciE+kvRL0eYixfwyhjb8VF0z8bGfv5gTruds3RnxYnvJOrlOvpDvBjwXcB8exwS3Zg
	 6UDgBHhKvjyoFPtDOLo+dv823riSrJOwLog++X5k5vIgVtffSAHpHPs4faVKZLpLmU
	 BbP5v5OEx7FlmMrZmC1aOzuHhQXVDZbk7lnVqtmYmwTxfgDOzP6EeCgNET9CA02gjW
	 AIBLCFFXxX4qQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 4BFD76007A;
	Tue,  9 Jul 2024 16:38:31 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 0F6D12049F5; Tue, 09 Jul 2024 16:38:27 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Davide Caratti <dcaratti@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Florian Westphal <fw@strlen.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 07/10] net/sched: cls_flower: add tunnel flags to fl_{set,dump}_key_flags()
Date: Tue,  9 Jul 2024 16:38:21 +0000
Message-ID: <20240709163825.1210046-8-ast@fiberby.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709163825.1210046-1-ast@fiberby.net>
References: <20240709163825.1210046-1-ast@fiberby.net>
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
Tested-by: Davide Caratti <dcaratti@redhat.com>
---
 net/sched/cls_flower.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index fc9a9a0b4897c..2a440f11fe1fa 100644
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
2.45.2


