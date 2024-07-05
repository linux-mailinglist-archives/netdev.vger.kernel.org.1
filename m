Return-Path: <netdev+bounces-109499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 530769289CE
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7FE28A61E
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E59F158D8D;
	Fri,  5 Jul 2024 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="R2W8xAB5"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4439015574A;
	Fri,  5 Jul 2024 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186459; cv=none; b=Jnq5ekhTED41iIWxvKx8LMSUt31vIMB6MtAZtfnhZFd2daaCWEwcmxM75jth9RftLOZvEmRoMGKOVL68+vMf9+uAkc3DEUChVmo4n+rD3qredxkxUeSdR0mBPckdB4zozyTyIe+/pIyeKsnuCZvhnKEoBzvsl9YjTPIBGUd1Rys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186459; c=relaxed/simple;
	bh=JJoSLE5E+0mjDp0PfeRqb2o1NFt14d/nWg6OdMLm9/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7tPo067Aw7vdxqrG6juYqeiGNuUu3iBhLaKIHWhdUGHljbrMp5063CGW6khncBNpLt+QehzcO8ifUfRDxo36UdQkPQ3yFB0rnSEqrCojEnO2QbxpIQx0SVwCVhd6mZM1/hrRa5QKPauMyrQJZ4FRzhSBPqVe+q3OQR94ooHsQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=R2W8xAB5; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720186451;
	bh=JJoSLE5E+0mjDp0PfeRqb2o1NFt14d/nWg6OdMLm9/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R2W8xAB5Ldt4R0R2QUgU/ZVjbhEW5J85dmj1D8ep+nkAT8wtVQjr7raSDkHiBPR6Z
	 dQAU4/WFJMwBvUXeYlk+im1Zb9ORG11e56S9vsqQztAWomUue6kAWqougNwitw80cy
	 4IBkQSSJBpg5W6dwGJCxRmxfVoryuCwIz1JDW9j3Py2nF3bM92h5bPCg9olLwWZc3j
	 LlCshz3iQwr6UBKZqjOGdRKyoZ3k3ZOoUO0cMuG8ZRv/CvGqmrk7PQN1J/OEoIXR2m
	 wm85DI/ApnJP4J5g/ixKD2ipBKMerS4EdmB9lt9XYdR0F9cbMZvWenGGrODwJaBb9a
	 JVGbmc6a8YazA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 2D0E160079;
	Fri,  5 Jul 2024 13:34:09 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 0EA722048B2; Fri, 05 Jul 2024 13:33:51 +0000 (UTC)
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
Subject: [PATCH net-next v2 07/10] net/sched: cls_flower: add tunnel flags to fl_{set,dump}_key_flags()
Date: Fri,  5 Jul 2024 13:33:43 +0000
Message-ID: <20240705133348.728901-8-ast@fiberby.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705133348.728901-1-ast@fiberby.net>
References: <20240705133348.728901-1-ast@fiberby.net>
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


