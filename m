Return-Path: <netdev+bounces-109500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617129289CF
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D892AB26501
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBA815958D;
	Fri,  5 Jul 2024 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Pe6+JHtJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44425155A26;
	Fri,  5 Jul 2024 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186460; cv=none; b=hSrW9Jj9JNG89kWscg1qE6Xm5bkgqKAO0oa3CJ74rEancpfKmMXAdax5wjcucga44yUHJLk49XGPbKTvX7OasNKDcbkLW0M5465o1XSvfd+WL95QHKFAMcBiJin7UYb8yxDyCcfVZDX7hpArkyc5MArTPV9Gb9IGGk71hpUYwvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186460; c=relaxed/simple;
	bh=U8fAUnOXpGztA1trUTv5zEWA4jw7bK7vWDTmwvAnmjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=giM0XvCMbnI8hZE0pjgW8KjlbghM76PNYFK+TD3ZVU6Rxd5a9q+26FzbLbnr+Yorusjvd0RNNxzYbwbXfNPAekYCsj2sNsXQ0QyNKzdTNzbreRDP+pG2Hvai7KaLvaGYI7HTUd4GzyiaRWlRnc8bgRwk6YtWxAGfXxAkQ1RSAJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Pe6+JHtJ; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720186451;
	bh=U8fAUnOXpGztA1trUTv5zEWA4jw7bK7vWDTmwvAnmjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pe6+JHtJW7AOydbFxFjEn47M8LvclAUd9mShKQ+o53oq/t2i1/mJTxiaWklxmTCNm
	 +MyHZq4s/ZA+Ri667LrhAcIk2rPRAgkndpuCXaCl+4O/BNfn6zyAWWb46mkd6QGODR
	 onDKifXuRumeIKYnJXH8I5eElz1aV4UNPb3K4+DZv9r39qSMexisquHhzdGMsPMnQt
	 biOxVHALhx6FGgNvERO2Pa//ZmaBUYYGnuI08d3bH3V4BEbY25Cu6gpuQUOaSg4YQn
	 klwzM8/VU9c3IT9F0hNAr6T5ITFDV6lsGDHjcJ/QLBVefm/13huxz43xOKWKTRvpMF
	 st0Ze6APRhpoA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 38F8B6009B;
	Fri,  5 Jul 2024 13:34:10 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id EBA8D204753; Fri, 05 Jul 2024 13:33:49 +0000 (UTC)
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
Subject: [PATCH net-next v2 01/10] net/sched: flower: refactor tunnel flag definitions
Date: Fri,  5 Jul 2024 13:33:37 +0000
Message-ID: <20240705133348.728901-2-ast@fiberby.net>
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


