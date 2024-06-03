Return-Path: <netdev+bounces-100333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038A98D8924
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 20:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0391C217A1
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 18:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15F113B297;
	Mon,  3 Jun 2024 18:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdWMCAQ3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD2013BC25
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717441066; cv=none; b=EQ8phSh0fyF9ejqEXwY4ofjC8m/AQWWyBBVKntdS2mQxRa7aXvMRXFGrBSHlqLQR7GI+nmy6pM/q25hJSa61bXqUib+FiH/6y0UNQBPM3UltKbcNkS8LFuxgIjJD+yfGUyFUGlG8QTDO4RecVQfq7AqcMl580IUXjs5f45Zee1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717441066; c=relaxed/simple;
	bh=UiNNRqkx8ZAHTqgVlkicm4oNC6eywPhdnH4A/+rZHFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDrRNVvxBwKWFXCIsMF1EvM8vnXK1yc8FmSV5A6aIDL7lshEjGiFC5QVgJKnCqjH51kTfq4+Iw3rkMNvK28yy41a0e4Y4CpdhMzikRFqWuNtCmAyqLOKIx4fKMM0U9yhTvrMIxpFSV+BmIuB5R6HHgaQuQiqi2ttXSp3HGAvUao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdWMCAQ3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717441064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rOBO6rTwZsWPfk6+dPakOlkKyyoY1m68zoodZwM7lVI=;
	b=cdWMCAQ3x9yLkS2GcbpaN0+vfjlF5O0ptP4x3pil3nDACqTCdri4WtXwL8ExjvwkMFooEi
	bxF6bKKYoNyX/nEmhQ8KH8W+u5HfLPSQE9GAIyn8zvmTFoQkVsdve9zwo10oPeISz2tl0D
	ZqotDL7zEPK+i5W0dYCWKcI15+teIso=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-grTpO5YAMvmyg-NemEBKVA-1; Mon,
 03 Jun 2024 14:57:41 -0400
X-MC-Unique: grTpO5YAMvmyg-NemEBKVA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C03E1913F60;
	Mon,  3 Jun 2024 18:57:39 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.112])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 997951955F6E;
	Mon,  3 Jun 2024 18:57:35 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 7/9] net: openvswitch: do not notify drops inside sample
Date: Mon,  3 Jun 2024 20:56:41 +0200
Message-ID: <20240603185647.2310748-8-amorenoz@redhat.com>
In-Reply-To: <20240603185647.2310748-1-amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The OVS_ACTION_ATTR_SAMPLE action is, in essence,
observability-oriented.

Apart from some corner case in which it's used a replacement of clone()
for old kernels, it's really only used for sFlow, IPFIX and now,
local emit_sample.

With this in mind, it doesn't make much sense to report
OVS_DROP_LAST_ACTION inside sample actions.

For instance, if the flow:

  actions:sample(..,emit_sample(..)),2

triggers a OVS_DROP_LAST_ACTION skb drop event, it would be extremely
confusing for users since the packet did reach its destination.

This patch makes internal action execution silently consume the skb
instead of notifying a drop for this case.

Unfortunately, this patch does not remove all potential sources of
confusion since, if the sample action itself is the last action, e.g:

    actions:sample(..,emit_sample(..))

we actually _should_ generate a OVS_DROP_LAST_ACTION event, but we aren't.

Sadly, this case is difficult to solve without breaking the
optimization by which the skb is not cloned on last sample actions.
But, given explicit drop actions are now supported, OVS can just add one
after the last sample() and rewrite the flow as:

    actions:sample(..,emit_sample(..)),drop

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/openvswitch/actions.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 33f6d93ba5e4..54fc1abcff95 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -82,6 +82,15 @@ static struct action_fifo __percpu *action_fifos;
 static struct action_flow_keys __percpu *flow_keys;
 static DEFINE_PER_CPU(int, exec_actions_level);
 
+static inline void ovs_drop_skb_last_action(struct sk_buff *skb)
+{
+	/* Do not emit packet drops inside sample(). */
+	if (OVS_CB(skb)->probability)
+		consume_skb(skb);
+	else
+		ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
+}
+
 /* Make a clone of the 'key', using the pre-allocated percpu 'flow_keys'
  * space. Return NULL if out of key spaces.
  */
@@ -1061,7 +1070,7 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
 	if ((arg->probability != U32_MAX) &&
 	    (!arg->probability || get_random_u32() > arg->probability)) {
 		if (last)
-			ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
+			ovs_drop_skb_last_action(skb);
 		return 0;
 	}
 
@@ -1579,7 +1588,7 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 		}
 	}
 
-	ovs_kfree_skb_reason(skb, OVS_DROP_LAST_ACTION);
+	ovs_drop_skb_last_action(skb);
 	return 0;
 }
 
-- 
2.45.1


