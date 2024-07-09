Return-Path: <netdev+bounces-110370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6455392C1D7
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85EB61C235C5
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5ED1C2DDC;
	Tue,  9 Jul 2024 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="qQt1IxO3"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183B61C0DC7;
	Tue,  9 Jul 2024 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543127; cv=none; b=sxCBMcO1cCXo+KAyjqzRbBzasa7gjF8D8HcSOpCXws+pjTGD7ib9vavCXb86lehAUs2RPeDA1DTwIGahYtL3e2GOXuzduQmGanmDaev08V9nw6fiYpa9b+flE/GlGHQXz98brLu4IpHBNRyY8BhUNkYD6CJ27DZr8Ez7aboc2Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543127; c=relaxed/simple;
	bh=U8fAUnOXpGztA1trUTv5zEWA4jw7bK7vWDTmwvAnmjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uIPYDObbxY9X5s9KYpGhHBrZv0djlKvKcAKbdKYfzwa6PpLoQq71b+vIen0gvphJbh4mMhwDWabXlduC4duAjhiYrnBwbfcw2fsosSGkSvXCHf4M0oYe5wPNOmEOtvs5sBR2uw1zTJtuyBF3jdXHcdAPtI1/LNgGOrF4Xf6LfVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=qQt1IxO3; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720543114;
	bh=U8fAUnOXpGztA1trUTv5zEWA4jw7bK7vWDTmwvAnmjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qQt1IxO3f/rjy1PwKcvK59swcIowFenYxaH6gUJVnWG/cpTLFdeoLQGpz1pyyscDz
	 J8KS2hQQd7nEPb2apR98uHqMLxYFKj84Qj9e1lZjOTe4bZArhIza7p2VSsALcQKcZn
	 oKyagItEgTidkh4QsteOxTyFWecNLinIvyOngT8D396540dkVzv4KZDB141Fbsu+jy
	 va4sNueDdEDOliT7YxFtKFyXJ1VtvQueLaB5bVrWP3glTTv8uckYxMrilruiLc2QBU
	 WPveVP4DdFMzVGswvIz8s84whJ1kO5bVglw7X1mdJRhkrnWI0wg6FntI5VxyG1E/3E
	 XA0E6JLK5Jchw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 665F3600A2;
	Tue,  9 Jul 2024 16:38:32 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 122C620474A; Tue, 09 Jul 2024 16:38:26 +0000 (UTC)
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
Subject: [PATCH net-next v3 01/10] net/sched: flower: refactor control flag definitions
Date: Tue,  9 Jul 2024 16:38:15 +0000
Message-ID: <20240709163825.1210046-2-ast@fiberby.net>
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


