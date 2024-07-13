Return-Path: <netdev+bounces-111198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ADB93034F
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 04:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55971C21556
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 02:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7B8131BAF;
	Sat, 13 Jul 2024 02:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="bfBHOReK"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A22446A1;
	Sat, 13 Jul 2024 02:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720837169; cv=none; b=fuzWELEq0p3AgOLJRugDyYtMmd+rhClMYb0iEl5R+2XUIRFP2U17dAjFbyFM5l2zlrdX6YiQZovv6zOFcIGoDzmzzOm+bqa1GRnbG0LFiqJb11VMntZEYXaA5eps7/ln4lmJesrLj59ylGqfcTPL5mwqYoNbpg7ieRg2X+pjJZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720837169; c=relaxed/simple;
	bh=97BaKpl+A98ebdWTkMEpQnN/VML4HX7Gwx29yVODybs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbP5X6Y1Ked8OA9e3xyHfxb5l7ytVyObvT66uAg+GwX+cHlFqbmqSgWk4KgcryFvJMp61e6JMCEKAPmmyq/HLpSUQrl8aAkIcpHbUDSud16bI11ZPf0dNIIy2M/U/vBExLR9TgX8fdBumk+P6FM+TVFHUTXwIpHRu3lqD0l3zsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=bfBHOReK; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720837160;
	bh=97BaKpl+A98ebdWTkMEpQnN/VML4HX7Gwx29yVODybs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bfBHOReK4es2OSKZtSYHhEWmdhhS4gksrxslQ8RbfWMrqTqH6TcXUZwhC6arCp+Wf
	 gREeAf28XyHKWCM+E6AwvaybBwqR8NI1udc4a2pX0AbOOO5JUaONwjLKwXY7aW05j4
	 9cfNS8EW6p013HKvdlS3vStN32/zoijS8ybJ9QqOq/oCKDXKbVsEzcMvMb/RRk/41R
	 1mpQpqLX+R/V6801UTDgvCPRicCeXISlXqkRn4RdwafHNQBeR+alVMaAnkfkUclSJf
	 YBZfuUAJG7jEBPXmeX3JEtQWWEUJDfJcxQYbd/vVaFqgLrKnAvWaj4q/5m3JF5df7V
	 aSbd93QdMk2rA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id ABAD26007D;
	Sat, 13 Jul 2024 02:19:17 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 4B6FD201ED5; Sat, 13 Jul 2024 02:19:11 +0000 (UTC)
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
	Donald Hunter <donald.hunter@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 01/13] net/sched: flower: refactor control flag definitions
Date: Sat, 13 Jul 2024 02:18:58 +0000
Message-ID: <20240713021911.1631517-2-ast@fiberby.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713021911.1631517-1-ast@fiberby.net>
References: <20240713021911.1631517-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Redefine the flower control flags as an enum, so they are
included in BTF info.

Make the kernel-side enum a more explicit superset of
TCA_FLOWER_KEY_FLAGS_*, new flags still need to be added to
both enums, but at least the bit position only has to be
defined once.

FLOW_DIS_ENCAPSULATION is never set for mask, so it can't be
exposed to userspace in an unsupported flags mask error message,
so it will be placed one bit position above the last uAPI flag.

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Reviewed-by: Davide Caratti <dcaratti@redhat.com>
---
 include/net/flow_dissector.h | 14 +++++++++++---
 include/uapi/linux/pkt_cls.h |  3 +++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index 3e47e123934d4..c3fce070b9129 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -7,6 +7,7 @@
 #include <linux/siphash.h>
 #include <linux/string.h>
 #include <uapi/linux/if_ether.h>
+#include <uapi/linux/pkt_cls.h>
 
 struct bpf_prog;
 struct net;
@@ -24,9 +25,16 @@ struct flow_dissector_key_control {
 	u32	flags;
 };
 
-#define FLOW_DIS_IS_FRAGMENT	BIT(0)
-#define FLOW_DIS_FIRST_FRAG	BIT(1)
-#define FLOW_DIS_ENCAPSULATION	BIT(2)
+/* The control flags are kept in sync with TCA_FLOWER_KEY_FLAGS_*, as those
+ * flags are exposed to userspace in some error paths, ie. unsupported flags.
+ */
+enum flow_dissector_ctrl_flags {
+	FLOW_DIS_IS_FRAGMENT		= TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT,
+	FLOW_DIS_FIRST_FRAG		= TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST,
+
+	/* These flags are internal to the kernel */
+	FLOW_DIS_ENCAPSULATION		= (TCA_FLOWER_KEY_FLAGS_MAX << 1),
+};
 
 enum flow_dissect_ret {
 	FLOW_DISSECT_RET_OUT_GOOD,
diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index b6d38f5fd7c05..12db276f0c11e 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -677,8 +677,11 @@ enum {
 enum {
 	TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT = (1 << 0),
 	TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST = (1 << 1),
+	__TCA_FLOWER_KEY_FLAGS_MAX,
 };
 
+#define TCA_FLOWER_KEY_FLAGS_MAX (__TCA_FLOWER_KEY_FLAGS_MAX - 1)
+
 enum {
 	TCA_FLOWER_KEY_CFM_OPT_UNSPEC,
 	TCA_FLOWER_KEY_CFM_MD_LEVEL,
-- 
2.45.2


