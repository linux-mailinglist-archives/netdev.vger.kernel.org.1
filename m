Return-Path: <netdev+bounces-111188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCB693033E
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 04:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F951F21CEC
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 02:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEEE1B7F7;
	Sat, 13 Jul 2024 02:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="TA8Aw8KV"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41DF101E6;
	Sat, 13 Jul 2024 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720837165; cv=none; b=PPVYQo2eyvHJnpDurNMLCJxH9pqgPiz06TtbQLf03TuaBS/VOsai3lduSx1H699vVEtIvxqbcMG+FTH6VdZMsudrAS/FRCsPazDTsbYB0zdrsEec+xcNn0IeU9SJaF6dd+p6vI/pt+YQRnQFxealE5KeymZBTNvpcy6Z9c9YFhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720837165; c=relaxed/simple;
	bh=COkLIhjoM/P9wK9pZom4lMH4jvqQ5DLAuFYjti4yFSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQxUWto3fbFNg41rmnysErxd2J8K0/p4Aig+YePTPh9tYb++x5e6IczZT+uNuMbhlaRYBnHf75jpzjt+7Ql+g9G5ysIWsBCfKRwlWgnEASMZ40fNWSi+/Rd3msnnRlwiWkgh2PnrkKFidbKCJnnMqoDHobr5nhMLDlDSIoGw3+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=TA8Aw8KV; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720837159;
	bh=COkLIhjoM/P9wK9pZom4lMH4jvqQ5DLAuFYjti4yFSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TA8Aw8KVNcAEyPiakAo3lFpzqsYCK1dxNk2l9VryfezwhNAL5hwq3om45l0UmIVrp
	 MyAdRqxi29CS4N5GDhwwmyrpsDWdceD9Mx8uq4n3tmiPGiWGQejqiZetUfvF721zZV
	 VCCLC6dcHy4gkvDJotD81D/goub34I5XKPLMmmKULLNOkxHE8qhZF3VzSqlNTQ071J
	 sf6HdlbeimbkVCk7ZRINLXgMShLxplEI8pNLn4D3iL9LZD+q28uuMEy7F/wM+kN+En
	 JWIk6g8Fqba0AQImpDNvr748XCzBdXGxUoiGRC/U0bBB5s3jRdsj7u1XV1Wt2x87SO
	 kjJ+5w+BcjxXQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 054DF60084;
	Sat, 13 Jul 2024 02:19:19 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 74D3B20232E; Sat, 13 Jul 2024 02:19:11 +0000 (UTC)
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
Subject: [PATCH net-next v4 03/13] net/sched: flower: define new tunnel flags
Date: Sat, 13 Jul 2024 02:19:00 +0000
Message-ID: <20240713021911.1631517-4-ast@fiberby.net>
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

Define new TCA_FLOWER_KEY_FLAGS_* flags for use in struct
flow_dissector_key_control, covering the same flags as
currently exposed through TCA_FLOWER_KEY_ENC_FLAGS.

Put the new flags under FLOW_DIS_F_*. The idea is that we can
later, move the existing flags under FLOW_DIS_F_* as well.

The ynl flag names have been taken from the RFC iproute2 patch.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 Documentation/netlink/specs/tc.yaml | 4 ++++
 include/net/flow_dissector.h        | 7 ++++++-
 include/uapi/linux/pkt_cls.h        | 4 ++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index fbbc928647fa3..aa574e3827abc 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -47,6 +47,10 @@ definitions:
     entries:
       - frag
       - firstfrag
+      - tuncsum
+      - tundf
+      - tunoam
+      - tuncrit
   -
     name: tc-stats
     type: struct
diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index c3fce070b9129..460ea65b9e592 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -17,7 +17,8 @@ struct sk_buff;
  * struct flow_dissector_key_control:
  * @thoff:     Transport header offset
  * @addr_type: Type of key. One of FLOW_DISSECTOR_KEY_*
- * @flags:     Key flags. Any of FLOW_DIS_(IS_FRAGMENT|FIRST_FRAGENCAPSULATION)
+ * @flags:     Key flags.
+ *             Any of FLOW_DIS_(IS_FRAGMENT|FIRST_FRAG|ENCAPSULATION|F_*)
  */
 struct flow_dissector_key_control {
 	u16	thoff;
@@ -31,6 +32,10 @@ struct flow_dissector_key_control {
 enum flow_dissector_ctrl_flags {
 	FLOW_DIS_IS_FRAGMENT		= TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT,
 	FLOW_DIS_FIRST_FRAG		= TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST,
+	FLOW_DIS_F_TUNNEL_CSUM		= TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM,
+	FLOW_DIS_F_TUNNEL_DONT_FRAGMENT	= TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT,
+	FLOW_DIS_F_TUNNEL_OAM		= TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM,
+	FLOW_DIS_F_TUNNEL_CRIT_OPT	= TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT,
 
 	/* These flags are internal to the kernel */
 	FLOW_DIS_ENCAPSULATION		= (TCA_FLOWER_KEY_FLAGS_MAX << 1),
diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 12db276f0c11e..3dc4388e944cb 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -677,6 +677,10 @@ enum {
 enum {
 	TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT = (1 << 0),
 	TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST = (1 << 1),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM = (1 << 2),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT = (1 << 3),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM = (1 << 4),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT = (1 << 5),
 	__TCA_FLOWER_KEY_FLAGS_MAX,
 };
 
-- 
2.45.2


