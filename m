Return-Path: <netdev+bounces-111196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACAC93034A
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 04:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9BC1281D2F
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 02:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D0673463;
	Sat, 13 Jul 2024 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="jW3le5CB"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4A93BBE1;
	Sat, 13 Jul 2024 02:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720837168; cv=none; b=T+9Re1EmrZhmguVY9LKVUNf43ZjhTO7qvJguWmBarCTFDSdVHY4So3zt9DdCYbQWqjduBkRFSkatzYyTMFmj0ZZWGEwoN2Wr0lZE4rB8ZZH6NNgX2IffRwdOfFSejOq/sNVMctGyhNjAsEYX0o9cEY5Sj7oy449FBPSVNDga29U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720837168; c=relaxed/simple;
	bh=KVVucSH7qdejdbA3OLd4Hi2J1oxsxsQeckJt2jn1zLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FY8uPXUhmekPNvXQdnVCbHyMIqRR1/pSmr6aOqltkuYtMaNceSwks6RzOHo8Yd4XlChKW0YWE89VYae7HJvrdfIPmhqvFUj6fgViuxgcM7epWZheIrw3gehhF9VaT95sMHzCzK5fSw6vdsYvBzbVZ7S/MdUUvFwy8Jpmqz/hmok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=jW3le5CB; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720837160;
	bh=KVVucSH7qdejdbA3OLd4Hi2J1oxsxsQeckJt2jn1zLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jW3le5CBDQPShPjt+hFuZn9cHFw6OXcldr/CC3lnaCttmL0kG5OcVHTzmL4wgrPI7
	 7bHiVI2F+aytxeDAJRS6AS2uS8iiy+BFkGuwuhIeqP00Mx02U1gbobuiny+m/tVh+m
	 h6AF0cB4eQZpgOfQ6qZmw+NAw2wGzufSU+57OPfzDdby9PRVNI9NbKziqNq+KP9K1j
	 AyWCw+YC4HrZ/mnmpvg+/9iKMATpNm3T46e30koVuFqJgKm8Rmlk6cJ9+yLwtm35wk
	 vlM2ogfjiOR/3ZdTbHstQxF7fWU8lsgFeYD8zGq7KxbsOgbh+5WuJGqnoaSD5qjxai
	 6DGK1a4dnWw5g==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 880B86007A;
	Sat, 13 Jul 2024 02:19:17 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id BFCB120484A; Sat, 13 Jul 2024 02:19:11 +0000 (UTC)
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
Subject: [PATCH net-next v4 05/13] net/sched: cls_flower: add policy for TCA_FLOWER_KEY_FLAGS
Date: Sat, 13 Jul 2024 02:19:02 +0000
Message-ID: <20240713021911.1631517-6-ast@fiberby.net>
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

This policy guards fl_set_key_flags() from seeing flags
not used in the context of TCA_FLOWER_KEY_FLAGS.

In order For the policy check to be performed with the
correct endianness, then we also needs to change the
attribute type to NLA_BE32 (Thanks Davide).

TCA_FLOWER_KEY_FLAGS{,_MASK} already has a be32 comment
in include/uapi/linux/pkt_cls.h.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Tested-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Davide Caratti <dcaratti@redhat.com>
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


