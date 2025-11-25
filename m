Return-Path: <netdev+bounces-241564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D346C85E45
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F724351209
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AF923ABA9;
	Tue, 25 Nov 2025 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HC/JbDx0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E92025393E
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087113; cv=none; b=nl2WwWFXyKbLwIfcDHQVd9wnVtBScaQzVcfClmSrpnzj6zUyJAhiDL9zLSOw+EQuv1/ZU8PH8I9a4R3gOTW3tfmoTdee3G3kCHF7yr274XJIiqUZMnNMSBphfcXD7EkX2DNzQcLiZIUtK6JEgUXvitIMuqzQklNF7SIbESbDd0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087113; c=relaxed/simple;
	bh=MRl2GGGvRvu6BNSzcwkZMasmfQItOiOnvG31w92u1U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLHWLab9RmOEsT+nlXt/q2P3BpuukjWWMkVA8KSaOv4k5LDD/oUGLqUpz7UU3MGb5wHaVBbIsvulp0lPnlf4HHVd3+T2L392sdPTREg47xp7ktLGv3bFvlTg+lmN5ve0++TIECQlIhLNlm7BaxgyNOA5Y2P3PJDnEcrD+HCbvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HC/JbDx0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764087111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgH+nvycDY4jpEE4j8alrbEVnY+VUnUlfDDlMAHbGhE=;
	b=HC/JbDx0DnBIVMgA02sfzJPAJh93BvK87gz6Fzf/oOGWrr2kl4GKREwbZuDwvZhXNgXDtu
	+v4SQY+b8gfT6ZXSlpHdGcNavy0tVxw1HoHbs2RCL0IDDEU0oHxXmzFc84TYzNk/wZLoGR
	jPqtBrgtz0tx+BYUkL9AGrugfR74vXU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-s9XTAyhWNPK9MDuCpCf32A-1; Tue,
 25 Nov 2025 11:11:46 -0500
X-MC-Unique: s9XTAyhWNPK9MDuCpCf32A-1
X-Mimecast-MFC-AGG-ID: s9XTAyhWNPK9MDuCpCf32A_1764087105
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DEE901956053;
	Tue, 25 Nov 2025 16:11:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.183])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AF1618004A3;
	Tue, 25 Nov 2025 16:11:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next 05/10] geneve: constify geneve_hlen()
Date: Tue, 25 Nov 2025 17:11:10 +0100
Message-ID: <cc9de6f36cfe39bc400ad78793407ea856f073b9.1764056123.git.pabeni@redhat.com>
In-Reply-To: <cover.1764056123.git.pabeni@redhat.com>
References: <cover.1764056123.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Such helper does not modify the argument; constifying it will additionally
simplify later patches.

Additionally move the definition earlier, still for later's patchesi sake.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/geneve.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 9837df99de65..fc8c41221eb6 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -365,6 +365,11 @@ static void geneve_uninit(struct net_device *dev)
 	gro_cells_destroy(&geneve->gro_cells);
 }
 
+static int geneve_hlen(const struct genevehdr *gh)
+{
+	return sizeof(*gh) + gh->opt_len * 4;
+}
+
 /* Callback from net/ipv4/udp.c to receive packets */
 static int geneve_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 {
@@ -497,11 +502,6 @@ static struct socket *geneve_create_sock(struct net *net, bool ipv6,
 	return sock;
 }
 
-static int geneve_hlen(struct genevehdr *gh)
-{
-	return sizeof(*gh) + gh->opt_len * 4;
-}
-
 static struct sk_buff *geneve_gro_receive(struct sock *sk,
 					  struct list_head *head,
 					  struct sk_buff *skb)
-- 
2.52.0


