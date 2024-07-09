Return-Path: <netdev+bounces-110363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7B192C1C4
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8DB28AE82
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7119D1C0046;
	Tue,  9 Jul 2024 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="IRXsxnwu"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B301BF32F;
	Tue,  9 Jul 2024 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543123; cv=none; b=rbfsR8iY4q+e5YS6u7x1kSYBBgl1/NSGXHOFBNouV6YfKPC1VBc2esGeaMmBMmypqPbYqC3MLIRYMi0CDApwAES+MNadSrkEKIVgtNAz5PArnWcf7hRB/vZsPazm6yscjohMELdBUfR3LrAPRZsLp2v2iydKHVEHitQQWJcORMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543123; c=relaxed/simple;
	bh=KalIqYrrAmq2wYiKdfTeen2fcLPp3RDkpdrBpHQLS0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWGzxg4e2JDVS8JlgZlPonbZWv29BZA22tNqg4V1CNylJvKSoOWc//Oc1ELlhwokGiX5jFi6gjQW1DnVr2rhhxAIgqXz+ECexjvcc6mx9DkIjKjFXJq5Ixe8O9B5bEvMSmSipUgibWLuBXz6ATitgxTilLRf9sVAkhNHjoL20WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=IRXsxnwu; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720543111;
	bh=KalIqYrrAmq2wYiKdfTeen2fcLPp3RDkpdrBpHQLS0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IRXsxnwuW7dAZBJNpbKjh1FGz2rySWYM31I6S6g8DQTWI3rfLnWsu6T1QZNFABXv3
	 wHJ4+GQlt5ph4VYA3kDXbHSIYUVxPcAl6XpeOHgtq9FiePBZHCCJJduXDPLGW+zo6A
	 E/4Ru+iZv0Pl3ZXJFuSDzo5iYuKgoXWDNOhULTErWBDgfRCv5Dv0WVJJZ/IwVMM9Mr
	 FPFW3vgFpoTg5jrywE66jJBCbomYleH8U4uL1xRm6NIu2eMYCxqC2SIPGo9jPIeefh
	 UoP6bpgLeG0+cnr7ZYMqqnHBoJmu8lvCh4//I76oLaUKqz+zxw2hmw3j3q6vfwVPqU
	 TG1JF3oCE9+7Q==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 6E6DD6007D;
	Tue,  9 Jul 2024 16:38:30 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 9DD642048C9; Tue, 09 Jul 2024 16:38:26 +0000 (UTC)
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
Subject: [PATCH net-next v3 04/10] net/sched: cls_flower: add policy for TCA_FLOWER_KEY_FLAGS
Date: Tue,  9 Jul 2024 16:38:18 +0000
Message-ID: <20240709163825.1210046-5-ast@fiberby.net>
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

This policy guards fl_set_key_flags() from seeing flags
not used in the context of TCA_FLOWER_KEY_FLAGS.

In order For the policy check to be performed with the
correct endianness, then we also needs to change the
attribute type to NLA_BE32 (Thanks Davide).

TCA_FLOWER_KEY_FLAGS{,_MASK} already has a be32 comment
in include/uapi/linux/pkt_cls.h.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Tested-by: Davide Caratti <dcaratti@redhat.com>
---
 net/sched/cls_flower.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 6a5cecfd95619..fc9a9a0b4897c 100644
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
+	[TCA_FLOWER_KEY_FLAGS]		= NLA_POLICY_MASK(NLA_BE32,
+							  TCA_FLOWER_KEY_FLAGS_POLICY_MASK),
+	[TCA_FLOWER_KEY_FLAGS_MASK]	= NLA_POLICY_MASK(NLA_BE32,
+							  TCA_FLOWER_KEY_FLAGS_POLICY_MASK),
 	[TCA_FLOWER_KEY_ICMPV4_TYPE]	= { .type = NLA_U8 },
 	[TCA_FLOWER_KEY_ICMPV4_TYPE_MASK] = { .type = NLA_U8 },
 	[TCA_FLOWER_KEY_ICMPV4_CODE]	= { .type = NLA_U8 },
-- 
2.45.2


