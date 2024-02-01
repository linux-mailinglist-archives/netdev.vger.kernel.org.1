Return-Path: <netdev+bounces-68133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2AF845E32
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D384B1C2784C
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946AF161B41;
	Thu,  1 Feb 2024 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hHe0zQjV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442F8160886
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807400; cv=none; b=nvPNJ3DC9WpWvUis07M/GCL4sFgdK93HifB04BJuoHUC8Ni4HiuwJGD2ZwFwycpvcNY4hvcQPx0++9zJEGaj9bddbEhAOSpGC6Oh9VgqBf9sXdsLFna8nMBHJe8wCzKbg0osIdTp9G+Xqt4GdLFCQ6TZ61IjeVBopCFjmNhZ+5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807400; c=relaxed/simple;
	bh=JG089lsaC9buA+Ubq/D0bZhmAk2945F096bngUZk74k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LZWJM3i1C+ockthKlTRf5P1htnNGI4cmgfHI//tPztFp7jOaxtD/Skpx6wG5suZpCHZs35g39KFaReLyLw2ABtlQhug7TfIY1rvkNkKY49Rx7OJtoDLArc4QJ6q5CfQEy6BnY6bG79OWbf97hUqq/fGsR7o0kNIY5RSMgT65f1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hHe0zQjV; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f0fd486b9aso17993757b3.2
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 09:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706807391; x=1707412191; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ieLLM0KqgOVOiN6xMg/fWqk86GRumgUkTZ2JXjw3xy4=;
        b=hHe0zQjVZxrp292ZI+eqTsTNkH/ctnDTJLH4j5v+LxbRYjhmKEKhsw5+v1thJb5CQe
         65HZFeU89y2DPGChpXdTseTCTNGmgiarD431d9tQbVCVYhM0A3WJJyXh58upl+rsFp56
         k0rHmseaxJtFza7LslJwZCEs//HWrMazg02g78iQKWM6ph/pPMd2phHe7qjjy73hf5do
         k+374SAfpnhcgAHE0V8V+p0HxzqIagn37wAaCWvg/OGkSaR6gnlErYHYt7X6Bl+5pkVb
         tb6r9h70THt0893JLVQpx+0Qm0ItCki3clfzufM/ewsMWnU/ohx9Tr+fc9nWoukDscOs
         IUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706807391; x=1707412191;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ieLLM0KqgOVOiN6xMg/fWqk86GRumgUkTZ2JXjw3xy4=;
        b=j73nYmdh4/KZfDi5ag+5JygANcJrQmeJxyQ8+y0MsL0VgqcW5CFnYl7cwD6X8IqysO
         vqkE0i7HoPiaCVK237DJEPRQs7O1RI8nxHH/ZeXKKVses35px7rrhHIR7M+MVPkXnaF4
         Kibr660Ru3+LI5FfAInnN6hljHUUZKu54eJU6CNdLmDdRXKulVeALMAH5iV1fBtELoIz
         F8OeLyDXcpkf+nTw7tMjU3YYe0evfTWJpzlgRr12AutBDS/8yvcve2Ua9TJvbQ3+utt1
         7jMOvKRXdBC1vQMqjUIjEHNvhcuteeBVpTMHrBCxIgCEp/wyb8sUMb+EF211GtTnC45t
         niZA==
X-Gm-Message-State: AOJu0YzxWw/wluXcSvsbD84xJdS6zKYvQaKYAY/ogwwcRN33wL3n1JlA
	BoHEVx6Yq/ahXyt/XCuXSUB/JSFk0GXM4yuW5h94PZnH3fF7BQ2dTLTbXY6FYDWYfcZq+VjDQc7
	48YQJU13uTA==
X-Google-Smtp-Source: AGHT+IFtTLCRBXv5xx71HuynyZnYfJPQhhkw9ueWJsLimNtcYkBI3HwcGE7p3IkK4Sp0VpLCwlJ8ROGRzXqreg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:98d:b0:dc2:5273:53f9 with SMTP
 id bv13-20020a056902098d00b00dc2527353f9mr96086ybb.1.1706807390972; Thu, 01
 Feb 2024 09:09:50 -0800 (PST)
Date: Thu,  1 Feb 2024 17:09:30 +0000
In-Reply-To: <20240201170937.3549878-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201170937.3549878-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201170937.3549878-10-edumazet@google.com>
Subject: [PATCH net-next 09/16] vxlan: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair per netns
and one unregister_netdevice_many() call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 16106e088c6301d3aaa47dd73985107945735b6e..df664de4b2b6cc361363b804e7ad531d59e2cdfa 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4846,23 +4846,25 @@ static void vxlan_destroy_tunnels(struct net *net, struct list_head *head)
 
 }
 
-static void __net_exit vxlan_exit_batch_net(struct list_head *net_list)
+static void __net_exit vxlan_exit_batch_rtnl(struct list_head *net_list,
+					     struct list_head *dev_to_kill)
 {
 	struct net *net;
-	LIST_HEAD(list);
-	unsigned int h;
 
+	ASSERT_RTNL();
 	list_for_each_entry(net, net_list, exit_list) {
 		struct vxlan_net *vn = net_generic(net, vxlan_net_id);
 
-		unregister_nexthop_notifier(net, &vn->nexthop_notifier_block);
+		__unregister_nexthop_notifier(net, &vn->nexthop_notifier_block);
+
+		vxlan_destroy_tunnels(net, dev_to_kill);
 	}
-	rtnl_lock();
-	list_for_each_entry(net, net_list, exit_list)
-		vxlan_destroy_tunnels(net, &list);
+}
 
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+static void __net_exit vxlan_exit_batch_net(struct list_head *net_list)
+{
+	struct net *net;
+	unsigned int h;
 
 	list_for_each_entry(net, net_list, exit_list) {
 		struct vxlan_net *vn = net_generic(net, vxlan_net_id);
@@ -4875,6 +4877,7 @@ static void __net_exit vxlan_exit_batch_net(struct list_head *net_list)
 static struct pernet_operations vxlan_net_ops = {
 	.init = vxlan_init_net,
 	.exit_batch = vxlan_exit_batch_net,
+	.exit_batch_rtnl = vxlan_exit_batch_rtnl,
 	.id   = &vxlan_net_id,
 	.size = sizeof(struct vxlan_net),
 };
-- 
2.43.0.429.g432eaa2c6b-goog


