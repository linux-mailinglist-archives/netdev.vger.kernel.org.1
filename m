Return-Path: <netdev+bounces-173048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B853A57039
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196121898E98
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABD7241666;
	Fri,  7 Mar 2025 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OfnOXdmq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D72A192B8A
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371247; cv=none; b=rdtdjTUiyuWCg4GhZ+GABQWFJtf6rKbE/JnRSFd/qJxUVXlPHgBqQWoz019YtbpB3i3okN9hAFXoHEduUx+D6tGzl/+dcs4Z/OehCjMoEy3ZKpPE+0l2PmRrMbzaA6uhryBoGXcs0Bs0DGnxKnhvqC0hs2RIcjSL6kjtVpaLl2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371247; c=relaxed/simple;
	bh=hS1ChzKS7dWxPq0LUI0g/wMX1nyTETlJuPljXgNFvdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VEgzPBiJHRLhEv+4h3GSZhm3j8wA++H7EVeIIoTMtQ7C6Ke6dMe8CQwskRhucw2Gs88G25HCKV7NLolXFkOD3huvIE08uWqh/3AVnWWTWikejNGljUXRJprIMa2bcrGx3ppHzilCxY0TsT4WM2bAw6re9VAZa04RzMmodxyMTrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OfnOXdmq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741371244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TNj4d6X24MDSyH7iZJ/UbpgobK+ylVbYZFWRrWf34CU=;
	b=OfnOXdmqn8x4qfaxxcDbwyFRofmIbeP3u4M6XzjOY3CYZ0mxVEuDN+7g26Z1T3ELv0ghmP
	XeKsCQ4WI5xKgJbM/O+k5ZbXT3rp3AKqbi+grb8oVspEVa5VjIGjnxxaJsg9z74e2w4Ufg
	z2OQTkkbcvULtW57tGI6YRBnfmQafic=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-Q86sST0LOKqqJ9lZKedchQ-1; Fri,
 07 Mar 2025 13:14:02 -0500
X-MC-Unique: Q86sST0LOKqqJ9lZKedchQ-1
X-Mimecast-MFC-AGG-ID: Q86sST0LOKqqJ9lZKedchQ_1741371241
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BA061956080;
	Fri,  7 Mar 2025 18:14:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.34.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C496180AF71;
	Fri,  7 Mar 2025 18:13:57 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH v2 net-next 0/2]  udp_tunnel: GRO optimizations
Date: Fri,  7 Mar 2025 19:13:25 +0100
Message-ID: <cover.1741338765.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
 net/ipv4/udp_offload.c     | 177 ++++++++++++++++++++++++++++++++++++-
 net/ipv4/udp_tunnel_core.c |  14 +++
 net/ipv6/udp.c             |   2 +
 net/ipv6/udp_offload.c     |   5 ++
 9 files changed, 259 insertions(+), 2 deletions(-)

-- 
2.48.1


