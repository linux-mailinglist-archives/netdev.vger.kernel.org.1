Return-Path: <netdev+bounces-175857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54ABA67C3A
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 19:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC7E42303F
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 18:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA211AB50D;
	Tue, 18 Mar 2025 18:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLGYgmOV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4F31898FB
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 18:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742323665; cv=none; b=M4NPZuj+FzHMrv8sHHg28JsQNLDf5xvANOgDdlkP/JK6iqCMq6Sa9H1LqTQuF4OEBOL9IG1r5UVFrgiaSdzyamhw8ImQa/R5ZU9Q3QJu+BO89pjZ+yoxpvrvlXFoiL33PVBhjUvnsns3fgUFbOnxDV2V0p3Gogoz0u6BbQIO9To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742323665; c=relaxed/simple;
	bh=OpRmsDExUANV0p0hffFIVTJXoa/plVnm6JMRrHjKwx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IXZPhvcpch7icSr0fE9iMM8m079SvOivBP9Ih88sc2TpniEJ1kYDGB/tU8Er1VLwl0EgsnbgbU5eN5UkKV0a5YGN56CV2ZfgXe6tPk4JzI4A3tYYXo996OYjAZXyOzbofmnLVH9SbNbIN0jZcIXxPhsl+uXpIr8VrgMIpcm+9bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DLGYgmOV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742323662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uIWpSWFwRmhJqErXn2M5EsepnZBsIhKVcTOE1aiCETI=;
	b=DLGYgmOVKCCkQHq8SpG44sPbpvaaSKdDx1NctRvKMjaboIZbTpgF/SOcpBZ+AL1c/BEdwQ
	Ho+5skJN/HVH0OibhbmTFRXbwEdyEN9Fy0GAmgtO5dN68BEh+U8Pwups6MgrBsDvUg8/6F
	A7pY7sggrKYjSz3EtfZtYTBAtqIoMTU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-2T-btuQ2NzW4QP-6IiC5cA-1; Tue,
 18 Mar 2025 14:47:39 -0400
X-MC-Unique: 2T-btuQ2NzW4QP-6IiC5cA-1
X-Mimecast-MFC-AGG-ID: 2T-btuQ2NzW4QP-6IiC5cA_1742323657
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65C9519560B4;
	Tue, 18 Mar 2025 18:47:37 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.222])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D37A1955DCD;
	Tue, 18 Mar 2025 18:47:34 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] udp_tunnel: properly deal with xfrm gro encap.
Date: Tue, 18 Mar 2025 19:47:20 +0100
Message-ID: <6001185ace17e7d7d2ed176c20aef2461b60c613.1742323321.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The blamed commit below does not take in account that xfrm
can enable GRO over UDP encapsulation without going through
setup_udp_tunnel_sock().

At deletion time such socket will still go through
udp_tunnel_cleanup_gro(), and the failed GRO type lookup will
trigger the reported warning.

We can safely remove such warning, simply performing no action
on failed GRO type lookup at deletion time.

Reported-by: syzbot+8c469a2260132cd095c1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8c469a2260132cd095c1
Fixes: 311b36574ceac ("udp_tunnel: use static call for GRO hooks when possible")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/udp_offload.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 088aa8cb8ac0c..2e0b52ae665bc 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -110,14 +110,7 @@ void udp_tunnel_update_gro_rcv(struct sock *sk, bool add)
 		cur = &udp_tunnel_gro_types[udp_tunnel_gro_type_nr++];
 		refcount_set(&cur->count, 1);
 		cur->gro_receive = up->gro_receive;
-	} else {
-		/*
-		 * The stack cleanups only successfully added tunnel, the
-		 * lookup on removal should never fail.
-		 */
-		if (WARN_ON_ONCE(!cur))
-			goto out;
-
+	} else if (cur) {
 		if (!refcount_dec_and_test(&cur->count))
 			goto out;
 
-- 
2.48.1


