Return-Path: <netdev+bounces-229548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D18BDDED1
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 12:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F3AC5025F3
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 10:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5346131BCB5;
	Wed, 15 Oct 2025 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXPXKsC4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD26631B83A
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523049; cv=none; b=AH4JE5UpeshHk9EDBmJvL2hi1eiaEZwhZR+1QeabxGLdRYVCGGaz+syPk7RFFdbOkFUFS1a/uKRQXFCQ7QlDRay/px5MKXYGXgMGcUKKW73nlcGwOect2BvY69IuZOm7W7hukOJJ/fX0T6uf4AnxheGPvWUET9qrD8h7nSUryZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523049; c=relaxed/simple;
	bh=IjqFrDMZhFIlDeRoqtvJN6qs/40VTEvy2y42s7I85BM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=anyEOcd28wZMRLPnfSXIZE+L/kahg3b71c9HWGsYORMwNhrHmf8Pwwqn/VjzjYYqpp9xxzyM3321kYrhseedTxbF/rueB9J6+r0wcPebT5mEl6qu7mtKLTsuT71HTkpfuvsfOC1hVLU5as7KBQfdOuLMJ45uOJck3bapwMuC52k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YXPXKsC4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760523046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sHMn8wqOXE+LlSdaygjbOHcvEk1zmPHWwQyGSnqYUGw=;
	b=YXPXKsC4ElsK9IZv66JCihqWe/Mb2M7yQGzMbumJFVZIAsbT+97usIJrUplQ9F395f68Sv
	6bT1RDYXgRenPpOHAvqCiBUhERnkZqu9cfgAZHiuYUZiQH8fokATNDH2sq2GXNeMVCls9v
	IiL8EjEqN0qXRh/359ARPKzBO6GLYic=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-xdk0O1mZPn-9p33Pe9BLrw-1; Wed,
 15 Oct 2025 06:10:43 -0400
X-MC-Unique: xdk0O1mZPn-9p33Pe9BLrw-1
X-Mimecast-MFC-AGG-ID: xdk0O1mZPn-9p33Pe9BLrw_1760523042
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B5E3186016B;
	Wed, 15 Oct 2025 10:10:38 +0000 (UTC)
Received: from fedora (unknown [10.44.34.108])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4777A1955BE3;
	Wed, 15 Oct 2025 10:10:35 +0000 (UTC)
From: Jan Vaclav <jvaclav@redhat.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Jan Vaclav <jvaclav@redhat.com>
Subject: [PATCH net-next] net/hsr: add interlink to fill_info output
Date: Wed, 15 Oct 2025 12:10:02 +0200
Message-ID: <20251015101001.25670-2-jvaclav@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Currently, it is possible to configure the interlink
port, but no way to read it back from userspace.

Add it to the output of hsr_fill_info(), so it can be
read from userspace, for example:

$ ip -d link show hsr0
12: hsr0: <BROADCAST,MULTICAST> mtu ...
...
hsr slave1 veth0 slave2 veth1 interlink veth2 ...

Signed-off-by: Jan Vaclav <jvaclav@redhat.com>
---
 net/hsr/hsr_netlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index 4461adf69623..851187130755 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -160,6 +160,12 @@ static int hsr_fill_info(struct sk_buff *skb, const struct net_device *dev)
 			goto nla_put_failure;
 	}
 
+	port = hsr_port_get_hsr(hsr, HSR_PT_INTERLINK);
+	if (port) {
+		if (nla_put_u32(skb, IFLA_HSR_INTERLINK, port->dev->ifindex))
+			goto nla_put_failure;
+	}
+
 	if (nla_put(skb, IFLA_HSR_SUPERVISION_ADDR, ETH_ALEN,
 		    hsr->sup_multicast_addr) ||
 	    nla_put_u16(skb, IFLA_HSR_SEQ_NR, hsr->sequence_nr))
-- 
2.51.0


