Return-Path: <netdev+bounces-179583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D71A7DB98
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D543AFF18
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 10:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB68227586;
	Mon,  7 Apr 2025 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMAn1MsP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CCE1B3934
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744023366; cv=none; b=NkKJePbtcpwjU/yjy6HtbE2RNxSFLiskqIU7AQhZPN2W8w7GqG7gYLSOJ3TJJuE7jemGzCezxNet6DZ6QiGJivq3rz0c6TFTFhab+htDxENLsNnXfwm6PyyihH47Ne2vux+1JWndJBN7mxqUkJy3yLq3QQaHfMEBVilzy489DvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744023366; c=relaxed/simple;
	bh=jM7AAweGED8mc3guHtEU4rXNh1Fp6xWdvEJorfOLNNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UcJLqS1VoK3QGUbWyoCLDVLB0J7YrHxr5eO8jsYATRFWM8k48EJkoJk3YNySMFy2JeBjaaFsvP6pOk/HYAweatExzYQNqLk4KKyAhKkQ8aINHF6/Jt7ILW9g1nj60tR38VmAJdgK01Uk2m5h6odDFK7FZNIOWOdVn+vEG5KghZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gMAn1MsP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744023363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r7z9rSi6LfaqQZ/T36OsK3ccL/vCmilaLDsVGchltIE=;
	b=gMAn1MsPe9bMjpCaRe+tox1GIMXuvHjBj8QBS9+OMRjT+PWFUGzNYzTne/p/Ql1KDU7yhE
	fm2JCVWRAxTRGEHSQvpiOQpzJAukSXhiB59m6QifsPlB3FaqjXeAxzMCLHmy7+ric0fQLB
	Ax51VMEiaUk2PdeThlyCSh9jy+yCEgQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-4bklZVotM16uNpnHEAsWHQ-1; Mon, 07 Apr 2025 06:56:01 -0400
X-MC-Unique: 4bklZVotM16uNpnHEAsWHQ-1
X-Mimecast-MFC-AGG-ID: 4bklZVotM16uNpnHEAsWHQ_1744023360
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-30d6a0309f6so24587331fa.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 03:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744023360; x=1744628160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7z9rSi6LfaqQZ/T36OsK3ccL/vCmilaLDsVGchltIE=;
        b=FLslwAiitEETgSl+NDe3oQM9cD9xDJ7qN+qFZaAdIhOjMdqIeTvra0E338ozCcjqtM
         RcHlYpWAFk0BatV0KIvl1C+54BiBLuzkQBWm3hfkdAF7KKN1h+ZVEJDQjAJb0qjmM5RI
         OFX+Xf+oZyUVubn/+t2N0jRQVacT6dE4qCbxoMyhL1AgtFrba6PhlJUbFOfTTvjJZyRk
         7muHgh8mgSiUCICVJAeC60Vq5TmChMEdQcHHJh0XhhmJ4ZV8XkSH+dl48Xl5mTAvndUK
         jtl7EMeMaybqMpUylbTgVlljMemBucZ9qAuAjNAHw6wcyX0TllVk7D8rlnMl76DaZOt/
         h36w==
X-Forwarded-Encrypted: i=1; AJvYcCV9lJHy9p7aeO9gqeVZVyttNOcdv1FFPj43UTBdbMsP4ciAQlmqV9UKpbIwte1DkNOTc2ssj1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNnzt1Jtdpes8CnxbQqAQDC9wo//0maWbAoy9HyZP5DLLegPfv
	7zL8ESIVcC0v1GlIBaPPCxKbmaKss/Ifz2mBe7edRhUq162RoSPWhj+WmslHqE+Ednvb6wLwKva
	ai/oesC/Zyc5Mpi6ESVHUVX0fuZPu0Cj1/HWDecF8H7TJqLZ6+SwaIQ==
X-Gm-Gg: ASbGncstJ6ysdrOwmdFVoRfn6LXQHthjpr1dFg+2peR8vxWwwLMbA3QlwusTJPT7D7a
	9eZGFg+ECJjcbbMZ8KOyRBKS4ppHQZOHPvM4fp98yBfKAn+IgdMt/KlDF6JVksBhI9kTY32aV9z
	9VzIRJmDilxRq3klO+PHl40jWU3wn/K4sL3PMC6ATNi8/sBEtzrT582aWb3L8GKnM9I7TgOmecC
	fnx9Fc8MgQelh6k8/Hbs0f1e6oJNMl/65qbVOGYC/dkVxz/yPqkLGYFe8GtmGHJtFGDxMf3IPjM
	hRTId/LA+8kt9yeuoBG1KjIeoQ1Tk+wZ+EdfLjtT
X-Received: by 2002:a05:651c:1545:b0:30d:e104:a944 with SMTP id 38308e7fff4ca-30f0a19216bmr35049991fa.40.1744023359971;
        Mon, 07 Apr 2025 03:55:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+hqwKfC0XA8/fdQHHn5shCwFbjXe/3TUWD5pSIYZo0utiA6IgLe22iO9GQsvO/vNQATXp6Q==
X-Received: by 2002:a05:651c:1545:b0:30d:e104:a944 with SMTP id 38308e7fff4ca-30f0a19216bmr35049921fa.40.1744023359557;
        Mon, 07 Apr 2025 03:55:59 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f031bcc02sm15697471fa.82.2025.04.07.03.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 03:55:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id AF814199187C; Mon, 07 Apr 2025 12:55:57 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: Ilya Maximets <i.maximets@redhat.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Frode Nordahl <frode.nordahl@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net] tc: Ensure we have enough buffer space when sending filter netlink notifications
Date: Mon,  7 Apr 2025 12:55:34 +0200
Message-ID: <20250407105542.16601-1-toke@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The tfilter_notify() and tfilter_del_notify() functions assume that
NLMSG_GOODSIZE is always enough to dump the filter chain. This is not
always the case, which can lead to silent notify failures (because the
return code of tfilter_notify() is not always checked). In particular,
this can lead to NLM_F_ECHO not being honoured even though an action
succeeds, which forces userspace to create workarounds[0].

Fix this by increasing the message size if dumping the filter chain into
the allocated skb fails. Use the size of the incoming skb as a size hint
if set, so we can start at a larger value when appropriate.

To trigger this, run the following commands:

 # ip link add type veth
 # tc qdisc replace dev veth0 root handle 1: fq_codel
 # tc -echo filter add dev veth0 parent 1: u32 match u32 0 0 $(for i in $(seq 32); do echo action pedit munge ip dport set 22; done)

Before this fix, tc just returns:

Not a filter(cmd 2)

After the fix, we get the correct echo:

added filter dev veth0 parent 1: protocol all pref 49152 u32 chain 0 fh 800::800 order 2048 key ht 800 bkt 0 terminal flowid not_in_hw
  match 00000000/00000000 at 0
	action order 1:  pedit action pass keys 1
 	index 1 ref 1 bind 1
	key #0  at 20: val 00000016 mask ffff0000
[repeated 32 times]

[0] https://github.com/openvswitch/ovs/commit/106ef21860c935e5e0017a88bf42b94025c4e511

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Frode Nordahl <frode.nordahl@canonical.com>
Closes: https://bugs.launchpad.net/ubuntu/+source/openvswitch/+bug/2018500
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/cls_api.c | 66 ++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 21 deletions(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 4f648af8cfaa..ecec0a1e1c1a 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2057,6 +2057,7 @@ static int tcf_fill_node(struct net *net, struct sk_buff *skb,
 	struct tcmsg *tcm;
 	struct nlmsghdr  *nlh;
 	unsigned char *b = skb_tail_pointer(skb);
+	int ret = -EMSGSIZE;
 
 	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*tcm), flags);
 	if (!nlh)
@@ -2101,11 +2102,45 @@ static int tcf_fill_node(struct net *net, struct sk_buff *skb,
 
 	return skb->len;
 
+cls_op_not_supp:
+	ret = -EOPNOTSUPP;
 out_nlmsg_trim:
 nla_put_failure:
-cls_op_not_supp:
 	nlmsg_trim(skb, b);
-	return -1;
+	return ret;
+}
+
+static struct sk_buff *tfilter_notify_prep(struct net *net,
+					   struct sk_buff *oskb,
+					   struct nlmsghdr *n,
+					   struct tcf_proto *tp,
+					   struct tcf_block *block,
+					   struct Qdisc *q, u32 parent,
+					   void *fh, int event,
+					   u32 portid, bool rtnl_held,
+					   struct netlink_ext_ack *extack)
+{
+	unsigned int size = oskb ? max(NLMSG_GOODSIZE, oskb->len) : NLMSG_GOODSIZE;
+	struct sk_buff *skb;
+	int ret;
+
+retry:
+	skb = alloc_skb(size, GFP_KERNEL);
+	if (!skb)
+		return ERR_PTR(-ENOBUFS);
+
+	ret = tcf_fill_node(net, skb, tp, block, q, parent, fh, portid,
+			    n->nlmsg_seq, n->nlmsg_flags, event, false,
+			    rtnl_held, extack);
+	if (ret <= 0) {
+		kfree_skb(skb);
+		if (ret == -EMSGSIZE) {
+			size += NLMSG_GOODSIZE;
+			goto retry;
+		}
+		return ERR_PTR(-EINVAL);
+	}
+	return skb;
 }
 
 static int tfilter_notify(struct net *net, struct sk_buff *oskb,
@@ -2121,16 +2156,10 @@ static int tfilter_notify(struct net *net, struct sk_buff *oskb,
 	if (!unicast && !rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
 		return 0;
 
-	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
-	if (!skb)
-		return -ENOBUFS;
-
-	if (tcf_fill_node(net, skb, tp, block, q, parent, fh, portid,
-			  n->nlmsg_seq, n->nlmsg_flags, event,
-			  false, rtnl_held, extack) <= 0) {
-		kfree_skb(skb);
-		return -EINVAL;
-	}
+	skb = tfilter_notify_prep(net, oskb, n, tp, block, q, parent, fh, event,
+				  portid, rtnl_held, extack);
+	if (IS_ERR(skb))
+		return PTR_ERR(skb);
 
 	if (unicast)
 		err = rtnl_unicast(skb, net, portid);
@@ -2153,16 +2182,11 @@ static int tfilter_del_notify(struct net *net, struct sk_buff *oskb,
 	if (!rtnl_notify_needed(net, n->nlmsg_flags, RTNLGRP_TC))
 		return tp->ops->delete(tp, fh, last, rtnl_held, extack);
 
-	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
-	if (!skb)
-		return -ENOBUFS;
-
-	if (tcf_fill_node(net, skb, tp, block, q, parent, fh, portid,
-			  n->nlmsg_seq, n->nlmsg_flags, RTM_DELTFILTER,
-			  false, rtnl_held, extack) <= 0) {
+	skb = tfilter_notify_prep(net, oskb, n, tp, block, q, parent, fh,
+				  RTM_DELTFILTER, portid, rtnl_held, extack);
+	if (IS_ERR(skb)) {
 		NL_SET_ERR_MSG(extack, "Failed to build del event notification");
-		kfree_skb(skb);
-		return -EINVAL;
+		return PTR_ERR(skb);
 	}
 
 	err = tp->ops->delete(tp, fh, last, rtnl_held, extack);
-- 
2.49.0


