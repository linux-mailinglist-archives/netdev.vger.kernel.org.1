Return-Path: <netdev+bounces-173628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCBDA5A3A5
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 20:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BCF83A6777
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 19:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C772F1CAA60;
	Mon, 10 Mar 2025 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADqdphl4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2431B395F
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741633827; cv=none; b=Vp/i9lucoZj+i3PZ8YgXITOW1or5s81wd5WNaqtOgQbIMx4tZEg6Wi66ePp6cxHXU4KKUe38gqiUbj37u0u4uOvLTzLGS8hnTTIeOk0vCB3L64d+0OKj5dpS91Sm5XrBKkJhXDk4Wa1Yg0xn6ZWX4CwDgBIUTLX0Yg31Sy0JSAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741633827; c=relaxed/simple;
	bh=YqhNvuWb5ANjpyGpFzec0QiDephT+V5kEHDLn2Tpr6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sx40UcUuhuIvDZYdhxvY3Us5LOGsnosSO9F91wRUbx3HGz6e1em+UWyhmdg3jnVhIE+iqdC+4WY1EdgN/anbUblFRFjhY9pX+wTamyyeR3drAJ/G7XPb4dhfrY8Qzn8nkXdZJZCxA2pOTaO4YOZ229hhtA1gSosWwL/wSfr57h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADqdphl4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741633825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2zrS39Hdye79wTY3VWcJ9V9eFga/mL2OFmR3tOdcFzg=;
	b=ADqdphl4JBkwA/ORqxkFP6z5II2b66M+s5dfrH3skCEYoEY3GKHrwZlfrVBeTXTAGOYbgH
	MrjG77LDusvy7OY2RE4n7/kVYwrczEr6L8X7ZVWFhV8w53jfHNsnNlialssDOj/HxL5cTp
	/iZyZkFxSyXWjYVjwvQJr1sTIh9RX0I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-RgzWEq0zP46p2ECOCa4Y8g-1; Mon,
 10 Mar 2025 15:10:20 -0400
X-MC-Unique: RgzWEq0zP46p2ECOCa4Y8g-1
X-Mimecast-MFC-AGG-ID: RgzWEq0zP46p2ECOCa4Y8g_1741633818
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BCED180AF7B;
	Mon, 10 Mar 2025 19:10:18 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.22.89.223])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA40A19560B9;
	Mon, 10 Mar 2025 19:10:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	kuniyu@amazon.com
Subject: [PATCH v3 net-next 0/2] udp_tunnel: GRO optimizations
Date: Mon, 10 Mar 2025 20:09:47 +0100
Message-ID: <cover.1741632298.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The UDP tunnel GRO stage is source of measurable overhead for workload
based on UDP-encapsulated traffic: each incoming packets requires a full
UDP socket lookup and an indirect call.

In the most common setups a single UDP tunnel device is used. In such
case we can optimize both the lookup and the indirect call.

Patch 1 tracks per netns the active UDP tunnels and replaces the socket
lookup with a single destination port comparison when possible.

Patch 2 tracks the different types of UDP tunnels and replaces the
indirect call with a static one when there is a single UDP tunnel type
active.

I measure ~5% performance improvement in TCP over UDP tunnel stream
tests on top of this series.
---
v2 -> v3:
 - avoid unneeded checks in udp_tunnel_update_gro_rcv()
 - use RCU_INIT_POINTER() when possible
 - drop 'inline' from c file
 v2: https://lore.kernel.org/netdev/cover.1741338765.git.pabeni@redhat.com/

v1 -> v2:
 - fixed a couple of typos
 - fixed UDP_TUNNEL=n build
 - clarified design choices 
 (see the individual patches changelog for more details)
 v1: https://lore.kernel.org/netdev/cover.1741275846.git.pabeni@redhat.com/

Paolo Abeni (2):
  udp_tunnel: create a fastpath GRO lookup.
  udp_tunnel: use static call for GRO hooks when possible

 include/linux/udp.h        |  16 ++++
 include/net/netns/ipv4.h   |  11 +++
 include/net/udp.h          |   1 +
 include/net/udp_tunnel.h   |  22 +++++
 net/ipv4/udp.c             |  13 ++-
 net/ipv4/udp_offload.c     | 174 ++++++++++++++++++++++++++++++++++++-
 net/ipv4/udp_tunnel_core.c |  14 +++
 net/ipv6/udp.c             |   2 +
 net/ipv6/udp_offload.c     |   5 ++
 9 files changed, 256 insertions(+), 2 deletions(-)

-- 
2.48.1


