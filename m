Return-Path: <netdev+bounces-179711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DBCA7E541
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32F51898097
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 15:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199DD204595;
	Mon,  7 Apr 2025 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bf+ozkgt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEA6204583
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744040768; cv=none; b=PE/of5JRV6UNJRWW7z/vwISs8LzwGafy98iIcTpMHE5Pr8+Xk607bbId42FU5cQsUX60YjMs7VHEll90tvGpa3Oc3lwaHho2ysbB/rXB4PzPjUNyjYFrDjYELpyYyYLpNx8fQdeNn5/iqHOS+FCF4j2aKACYpjCvjy579uMdAP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744040768; c=relaxed/simple;
	bh=ptmd5vT7ss2wRJRy8sReG9qJktGdoQ2gMArc1Qw9zG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tTzs7YIwjoG1kzg7ZSA5C/pkdas+I77WmGnKtCENTjZoXOCqOeKSHzvO4OA3dwaWQ8nwqj8Xs9c0tpp0NrzEbr4M8Ib4zXM/HWiG+0Pip3X8TXh6MfdY5yKF0KXnK7QZgpL8qCgfMHDlhtFSDAnhQuXqNBceLxdlr6YlbqBMAfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bf+ozkgt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744040763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YRjM5WO2YzPzG53DyjuYhiOZDdNZqA1q73ttwrDtt3w=;
	b=Bf+ozkgt8oXKFblD/GFnvLkAjnJvoXFfQg271YvpASj+0gAQVEhwZfbfkIlt6V1amR3Nu9
	shd56+mytHEW1qSYQsBkv1WqlC4+ojBfsc8wExLiWXSzIeZu7/Y63n6tfOvmjOnaD4o+SD
	c/S303324Ji/oBUrVKmJ6JBxL2NQDqg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-pCJ1QDyCNCyp30_b5YUEpw-1; Mon,
 07 Apr 2025 11:46:00 -0400
X-MC-Unique: pCJ1QDyCNCyp30_b5YUEpw-1
X-Mimecast-MFC-AGG-ID: pCJ1QDyCNCyp30_b5YUEpw_1744040758
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75E21180AF66;
	Mon,  7 Apr 2025 15:45:58 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.28])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BFA391809B73;
	Mon,  7 Apr 2025 15:45:55 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next v5 0/2] udp_tunnel: GRO optimizations
Date: Mon,  7 Apr 2025 17:45:40 +0200
Message-ID: <cover.1744040675.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

I measure ~10% performance improvement in TCP over UDP tunnel stream
tests on top of this series.
---
v4 -> v5:
 - incorporated the follow-up fixes:
   https://lore.kernel.org/netdev/cover.1742557254.git.pabeni@redhat.com/
 - more accurate benchmarking
 v4: https://lore.kernel.org/netdev/cover.1741718157.git.pabeni@redhat.com/

v3 -> v4:
 - cleanup lookup in patch 2
 - more RCU_INIT_POINTER usage in patch 1
 (see the individual patches changelog for more details)
 v3: https://lore.kernel.org/netdev/cover.1741632298.git.pabeni@redhat.com

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
  udp_tunnel: use static call for GRO hooks when  possible

 include/linux/udp.h        |  16 ++++
 include/net/netns/ipv4.h   |  11 +++
 include/net/udp.h          |   1 +
 include/net/udp_tunnel.h   |  16 ++++
 net/ipv4/udp.c             |  13 ++-
 net/ipv4/udp_offload.c     | 172 ++++++++++++++++++++++++++++++++++++-
 net/ipv4/udp_tunnel_core.c |  13 +++
 net/ipv6/udp.c             |   2 +
 net/ipv6/udp_offload.c     |   5 ++
 9 files changed, 247 insertions(+), 2 deletions(-)

-- 
2.49.0


