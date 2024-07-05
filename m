Return-Path: <netdev+bounces-109495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 747039289C5
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206131F22039
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EAB14D71E;
	Fri,  5 Jul 2024 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="VJkrr0Le"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A704A146A8D;
	Fri,  5 Jul 2024 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186456; cv=none; b=stw3znKxuUARikvGDLOoEkVw/QQnww1WeISic/8n/Obnx08zwmDQxP8lcWyn7anQmMFT0ptasvHplbqNRiNAK96FBsm1g7MesQGGL1ShGyjWMMMTmoj8qBY/UH/2e0df0Bne0Obh1bMJHbF5eMOdCAAoSsbT9E44ocYyFK1dZ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186456; c=relaxed/simple;
	bh=KalIqYrrAmq2wYiKdfTeen2fcLPp3RDkpdrBpHQLS0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yd9h6VhQRJu1O1BWXyYgL99beqZXDhYIaWxwQpTIBXdaUM4wqDCHgIbaatq/WBoa4QHAf9thVJ/nGC9X/OMdvoZZHNTFGsibz1NmSdJR0t68OtHbo5uswGGpG20mUTVgunZ3iCzgQKc6t6wyXSM7wNY8uIog9P7N4V7qH2gHBuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=VJkrr0Le; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720186450;
	bh=KalIqYrrAmq2wYiKdfTeen2fcLPp3RDkpdrBpHQLS0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJkrr0Le+oq7HxC3O4TzjaXuf0NS64kj/fnKQwDZkg8gYepbkEuIkd5iO7rlxmhhZ
	 XIuyy80eDIercIFx2U5XsCXMhtoWSdoP8E7C+zdKfTfu+wAW736TbdUQY1Wr8wEsoV
	 J3FrXkHE+Uxvf+pHQku8BTo126Zvgu4ExNS9TL2Q/xWt2pWTwrb8W7LliOsE4PRIlr
	 OW22mnrMGHfgcHcdbFSLHT7MLO3pCcLAEsp09Z6ondBOEYwbcmcnLEUaa9PIWthE6p
	 gAYs3kCs6v++o7HWY0K6Z4nNBtL2hh5knu3gRFSSezxCwane/cmFPOO18jdOl7TsMm
	 /I5L1B+3ny1pA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 73EA06007C;
	Fri,  5 Jul 2024 13:34:09 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 849B2204819; Fri, 05 Jul 2024 13:33:50 +0000 (UTC)
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
Subject: [PATCH net-next v2 04/10] net/sched: cls_flower: add policy for TCA_FLOWER_KEY_FLAGS
Date: Fri,  5 Jul 2024 13:33:40 +0000
Message-ID: <20240705133348.728901-5-ast@fiberby.net>
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


