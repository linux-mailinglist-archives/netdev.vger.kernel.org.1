Return-Path: <netdev+bounces-164003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74996A2C444
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01ED0188DD54
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0B61FA165;
	Fri,  7 Feb 2025 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fEvfYS1g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFB81F942D
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738936732; cv=none; b=E8MhBH9ZMmHK6TQgOfdn0PU5aRVFszSZfOFPjgdywLV69HtfAUkh3iWiwDyFFO4h9EVqYrZysWrxRYF+A/+6JQdyFtt3hYVB3H4hogsmigwvJVXMiLivlil4uY72KxqE+d0ZQ86FUU69ghZEBoUqHpv8ShFRqjt6q2rD8MuQAh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738936732; c=relaxed/simple;
	bh=eSvHPIFwwVoeUmNsdpvm6YTdhb4tcySVhCRRx4aX340=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TjmHWn6K0dlhLWgTKAah+5JG/zAbA2KHu1XojIhFJHz+Kt/EsUWOJiHBg1hopUKyzAoI+6IXuT2N0BC6Jwbv6Cq12cI+kyb56kOv7w81K9zlLiZloHSwzPkAMU2Tp7WvHIzIKXnHdwrCSpiBNbVYfkFUdnUByrWUdgk4+1xl82s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fEvfYS1g; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7b6e1b037d5so320078085a.0
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 05:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738936729; x=1739541529; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jicRPQahGa2VoW5nRw/pCeZMJBXEDGddrE/M9f6dfaY=;
        b=fEvfYS1gFkWQq2ZOHczDCr3u3RNIFGGImKsMV0B3BKdJqcxOyeMWs2qeoOK/F0Ukn6
         BpkyCbRPnMtWd4przY2HKVYG/wy/VG+ciUPipnxqu7rZZu87QGJ0d4RDQuM7BFym+ijC
         XcXAJHexvHg9u3cNakdUYzjYvbZCIFUxjHJ8JIFxSS4tSOzJqXhtmmEoxqpKgNXiKOUE
         92ei/OVAE/uI8vceYOOVpu1HIJEk2NqbbiHJUAn2yg7TGUkRaTVKydXlsl1GWjCBuWpK
         1b910epc5QcFMWnlgQ06xb+YldCZTiPWU1wE7VtOIe76swo1aXsG7O5Olw5+bf+NUfMb
         MfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738936729; x=1739541529;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jicRPQahGa2VoW5nRw/pCeZMJBXEDGddrE/M9f6dfaY=;
        b=Atoh+vov40zLspmB20VqnUaxeLadCE5Rjw9ucYa6ZIM6vd+mao0Tgxn0EzP2B6k45G
         mGZKgP0K2Ymoe+Pu5uUNtIqwlHvYH+0TskzoGmlF3CXP3IZGq++hJ0mA+4R+bVk75Yjx
         9v3TqWwrMECRgSzjzuML8Tl6GAKpfQcOQOtnCA6CnNEGAI0a6hp8gNvzxupCR4tOdJwe
         UxApXwujF08pqVsloQvOKv8n8draYyPv7fpaGRSrJ6ROqHKE+cZK5sKRlqkOqTl0j7xi
         J2sLiXqLHnxnAdaIE33Ibefct4XnnEfcAWdAS5Tn6KgjQktYUljG2XBGBgCfYMRXBke7
         lBHw==
X-Gm-Message-State: AOJu0YybwW7EFeySwkezFDsU9KM0xYbdq9XfJaf0KnC85s88Pke63AiK
	AdOLpqJmF7/pJBm3H8xyv+LFAkZTSgFngngMTYUIwywgEaSKYuaGdyuSP8oLTX711bCxwwVJSqg
	8fgK8gcA4hw==
X-Google-Smtp-Source: AGHT+IHoOT0GWGQIc4ynHj3lZBMo5jOxVgheXiAu5hhO9d3+hU6SbZyGyqvRUr6b4J+KjAZ02983zMQiEQycIw==
X-Received: from qkpa40.prod.google.com ([2002:a05:620a:43a8:b0:7b6:f34f:23e0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4251:b0:7b6:d4ea:fe8a with SMTP id af79cd13be357-7c047bf3af3mr382690985a.12.1738936729662;
 Fri, 07 Feb 2025 05:58:49 -0800 (PST)
Date: Fri,  7 Feb 2025 13:58:37 +0000
In-Reply-To: <20250207135841.1948589-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250207135841.1948589-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250207135841.1948589-6-edumazet@google.com>
Subject: [PATCH net 5/8] openvswitch: use RCU protection in ovs_vport_cmd_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ovs_vport_cmd_fill_info() can be called without RTNL or RCU.

Use RCU protection and dev_net_rcu() to avoid potential UAF.

Fixes: 9354d4520342 ("openvswitch: reliable interface indentification in port dumps")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/openvswitch/datapath.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 225f6048867f4a396f6411c50b0cdf9437303e97..5d548eda742dfc43fcd3d07458704ee9b7e9ed64 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -2101,6 +2101,7 @@ static int ovs_vport_cmd_fill_info(struct vport *vport, struct sk_buff *skb,
 {
 	struct ovs_header *ovs_header;
 	struct ovs_vport_stats vport_stats;
+	struct net *net_vport;
 	int err;
 
 	ovs_header = genlmsg_put(skb, portid, seq, &dp_vport_genl_family,
@@ -2117,12 +2118,15 @@ static int ovs_vport_cmd_fill_info(struct vport *vport, struct sk_buff *skb,
 	    nla_put_u32(skb, OVS_VPORT_ATTR_IFINDEX, vport->dev->ifindex))
 		goto nla_put_failure;
 
-	if (!net_eq(net, dev_net(vport->dev))) {
-		int id = peernet2id_alloc(net, dev_net(vport->dev), gfp);
+	rcu_read_lock();
+	net_vport = dev_net_rcu(vport->dev);
+	if (!net_eq(net, net_vport)) {
+		int id = peernet2id_alloc(net, net_vport, GFP_ATOMIC);
 
 		if (nla_put_s32(skb, OVS_VPORT_ATTR_NETNSID, id))
-			goto nla_put_failure;
+			goto nla_put_failure_unlock;
 	}
+	rcu_read_unlock();
 
 	ovs_vport_get_stats(vport, &vport_stats);
 	if (nla_put_64bit(skb, OVS_VPORT_ATTR_STATS,
@@ -2143,6 +2147,8 @@ static int ovs_vport_cmd_fill_info(struct vport *vport, struct sk_buff *skb,
 	genlmsg_end(skb, ovs_header);
 	return 0;
 
+nla_put_failure_unlock:
+	rcu_read_unlock();
 nla_put_failure:
 	err = -EMSGSIZE;
 error:
-- 
2.48.1.502.g6dc24dfdaf-goog


