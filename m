Return-Path: <netdev+bounces-108810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2D3925A66
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF351C25AEC
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 10:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF921946B4;
	Wed,  3 Jul 2024 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="jGQCpe8I"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7A191F7D;
	Wed,  3 Jul 2024 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003650; cv=none; b=BbVpAqdmzJDYDLWw8t5ItwOnz9zzs25ZH+VNfMVJC9qJ2JMgYorSy0uTsO9YYNpy1q0KKjcu7puOe1Mmj1FMbnbEe4b0nabZilD86xVkQzMvjBFK3Uauc1pBQoKEFHBD/BRn/QlGczppBysQ/jaPWTL6dj0dPqg5xajblmA0j1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003650; c=relaxed/simple;
	bh=WPpZm7+6vuDKlo51TzZYK3aZLYFfzpSibMBJnD/Iqsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZi/MopCF5/f8Q1zMTq8eQcUiu/7adKFCiYfLcHwwJXwA7WNfNWl68MHPkg2hoH/GesHUh2FCctKySbJFe33zNtRxbUpwLGtCXaPmPK7hPj6wkcPe0lcfo5keamxTjCXmA9lDPBv32rIUDYjHPwHG3ajxjQulP4TxjfITmNUfKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=jGQCpe8I; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720003636;
	bh=WPpZm7+6vuDKlo51TzZYK3aZLYFfzpSibMBJnD/Iqsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jGQCpe8IfEgg25MTi5IziWztc4jhZijHUjA9086CFG4jpHsbPqjzhfP8EWKXNvgWv
	 9NoQ1KXpHLXF+qwu91dmuYhLNR2XDsJkVQVI6zPrRkmPrVxy1vF2Ai6aoM+/h6yvSv
	 HpEBd5e4Zl0MTWqM4CVbUoOTomZzz1B08NbYBfXs4zat6wM888nCo+JuFs7F7Ctzd9
	 z2ly+nefX7uqDbBLz1diy8fVgemfdpQG7M+8H3/B816K3BcV2Vp2MrmQsEO65xEs0K
	 A5m9w+XTkvJCdY4344ty1JGI1bPkvMgoVBE1kh2pfLirAU9zh7IMSRAan7yiF2QrZK
	 dYEy5AmPiyuUA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 542576009B;
	Wed,  3 Jul 2024 10:47:16 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id C1E862041B4; Wed, 03 Jul 2024 10:46:07 +0000 (UTC)
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
Subject: [PATCH net-next 1/9] net/sched: flower: define new tunnel flags
Date: Wed,  3 Jul 2024 10:45:50 +0000
Message-ID: <20240703104600.455125-2-ast@fiberby.net>
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

Define new TCA_FLOWER_KEY_FLAGS_* flags for use in struct
flow_dissector_key_control, covering the same flags
as currently exposed through TCA_FLOWER_KEY_ENC_FLAGS,
but assign them new bit positions in so that they don't
conflict with existing TCA_FLOWER_KEY_FLAGS_* flags.

Synchronize FLOW_DIS_* flags, but put the new flags
under FLOW_DIS_F_*. The idea is that we can later, move
the existing flags under FLOW_DIS_F_* as well.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 include/net/flow_dissector.h | 17 +++++++++++++----
 include/uapi/linux/pkt_cls.h |  5 +++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index 3e47e123934d..f560e2c8d0e7 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -16,7 +16,8 @@ struct sk_buff;
  * struct flow_dissector_key_control:
  * @thoff:     Transport header offset
  * @addr_type: Type of key. One of FLOW_DISSECTOR_KEY_*
- * @flags:     Key flags. Any of FLOW_DIS_(IS_FRAGMENT|FIRST_FRAGENCAPSULATION)
+ * @flags:     Key flags.
+ *             Any of FLOW_DIS_(IS_FRAGMENT|FIRST_FRAG|ENCAPSULATION|F_*)
  */
 struct flow_dissector_key_control {
 	u16	thoff;
@@ -24,9 +25,17 @@ struct flow_dissector_key_control {
 	u32	flags;
 };
 
-#define FLOW_DIS_IS_FRAGMENT	BIT(0)
-#define FLOW_DIS_FIRST_FRAG	BIT(1)
-#define FLOW_DIS_ENCAPSULATION	BIT(2)
+/* Please keep these flags in sync with TCA_FLOWER_KEY_FLAGS_*
+ * in include/uapi/linux/pkt_cls.h, as these bit flags are exposed
+ * to userspace in some error paths, ie. unsupported flags.
+ */
+#define FLOW_DIS_IS_FRAGMENT		BIT(0)
+#define FLOW_DIS_FIRST_FRAG		BIT(1)
+#define FLOW_DIS_ENCAPSULATION		BIT(2)
+#define FLOW_DIS_F_TUNNEL_CSUM		BIT(3)
+#define FLOW_DIS_F_TUNNEL_DONT_FRAGMENT	BIT(4)
+#define FLOW_DIS_F_TUNNEL_OAM		BIT(5)
+#define FLOW_DIS_F_TUNNEL_CRIT_OPT	BIT(6)
 
 enum flow_dissect_ret {
 	FLOW_DISSECT_RET_OUT_GOOD,
diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index b6d38f5fd7c0..24795aad7651 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -677,6 +677,11 @@ enum {
 enum {
 	TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT = (1 << 0),
 	TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST = (1 << 1),
+	/* FLOW_DIS_ENCAPSULATION (1 << 2) is not exposed to userspace */
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM = (1 << 3),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT = (1 << 4),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM = (1 << 5),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT = (1 << 6),
 };
 
 enum {
-- 
2.45.2


