Return-Path: <netdev+bounces-108811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC073925A67
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7271C210A1
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 10:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9A01946CB;
	Wed,  3 Jul 2024 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="vV67Dy3o"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091DF191F7B;
	Wed,  3 Jul 2024 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003650; cv=none; b=MxQXD1Yg27f1XT1DMWyY557UiE/qtzYQUoVGT95JUeZ6dbc1nGL7GwhGNsU+041tE/htD9HACuMzbMkcn27eEYA0V3sKMWQZ9sBlTMDKAK6BbYO1GkFVvquuandZJdb3JiI/WGuUJk9nE+umhTBuCMfCLa971Qd2Ryd3ZngTfAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003650; c=relaxed/simple;
	bh=HkHTHO+lKaqvpD5X9IDJOwVpoEkWM9lMvk3+zE2kBaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWF0XmOS+ojq/ypDBEW/pD4ZRHNeDG6gF6CXG+xoLSOWnnX6l8WhELjUSp+AHnqCpRaIyG6zpjX/vQQQY0/f2KvYANCXwZmusNbAhwS721LB7jOnodZ8xLCghjq412eUFjZ9PnZFV7CP/KRR4smPCATeR9hzeqc5uQ/PRP0yzkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=vV67Dy3o; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720003636;
	bh=HkHTHO+lKaqvpD5X9IDJOwVpoEkWM9lMvk3+zE2kBaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vV67Dy3oZlowh5318riuAMkHr+TE3NAEEjRGIrI/weoaA7L7FCYSY1mCAlCHzH+7u
	 540vmWvRpMRAnNqRUfc9xK+OGHPI31P3fSjZ9nUXNIScUvhArCQ4IUH3BUDDu+ttsS
	 IKDM7oZw/NhCDans0kFNRaCmV0pzZli5xvGB5in/KEze5IVoG8zB9v6PLYy1h0ZKir
	 gKaAdrbcP6dmJf5DWpZ0TF1zNe8pD88fIn2hh51lyt5MhLG8xb8Fis4JZ/v32qW9Zt
	 rrqVwyiexTdXWfClqk+Kqwxsmi3cv+/BmP2CYZk4/xy6n5zYzgm1/yvOTZmHMs/Efs
	 SzUZkXaKmOyZg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 29E7560089;
	Wed,  3 Jul 2024 10:47:16 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id A05B4204604; Wed, 03 Jul 2024 10:46:30 +0000 (UTC)
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
Subject: [PATCH net-next 6/9] net/sched: cls_flower: add tunnel flags to fl_{set,dump}_key_flags()
Date: Wed,  3 Jul 2024 10:45:55 +0000
Message-ID: <20240703104600.455125-7-ast@fiberby.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703104600.455125-1-ast@fiberby.net>
References: <20240703104600.455125-1-ast@fiberby.net>
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
index fc9a9a0b4897..2a440f11fe1f 100644
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


