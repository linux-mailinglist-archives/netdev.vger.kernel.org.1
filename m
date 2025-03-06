Return-Path: <netdev+bounces-172489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2BDA54FD0
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 16:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74CB116E36D
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 15:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A367C1FF7CC;
	Thu,  6 Mar 2025 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d22R9Ivi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC71211469
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276644; cv=none; b=N5zXQK2C51Wrqpy6Q/MiCQSSG4HIBcd4z4b8igNVKhxVWaGzy1nLDqVszi6nMHYyL9d3dnN4iQm7I11o7Z1a/IWPuMWX1dQ46JZsCTRoPEIIaoDJkUT0A9vVY8D9dqb1DRak4MBy1qhh84JA1lew5T3nNrzWrhbqpm9Oy3L9uLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276644; c=relaxed/simple;
	bh=vCB7lz4/RxUG2E6xIQ76I1yr3ws8hSo2307caHG4iNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PmiaDGoGCXfVGai7vL/RDuWkCD7EUyDXkN5Fppuf0LUrTYsn6XwJkY1chxsbrNB+HxiFE9qRqJz6I9P9UJ4DDuUFW+YLxcuOfvVhZ4DK7chgJtm4CrpEtClIk5RzqqaLpIoigcDFhZ846/KD08b2XgfGQxYFNLr/1RuQwST9ulE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d22R9Ivi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741276641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nJ3+zZnTEYqCCYXF17Ikth4xtYbVBAh2b3WlryNMYzA=;
	b=d22R9IviGKCQr+xApE788IV8BVxQ4i2+af1ba3H7ieSyi+n2H3YluKesVb/OYJuIdhXDv8
	HGbyfwd6DbSqRI6SXBn3ACb5uzpA+7MrELu1swA9W77RHCfp8nGHYLhsjlMwGgy19hfzu9
	QVu4mos2gNo8O73PC8SQIFxQR+54HbQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-eGeZtun5NY-V7CyHDIVMvA-1; Thu,
 06 Mar 2025 10:57:08 -0500
X-MC-Unique: eGeZtun5NY-V7CyHDIVMvA-1
X-Mimecast-MFC-AGG-ID: eGeZtun5NY-V7CyHDIVMvA_1741276627
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6001180025E;
	Thu,  6 Mar 2025 15:57:06 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.236])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0658F180AF71;
	Thu,  6 Mar 2025 15:57:03 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next 0/2] udp_tunnel: GRO optimizations
Date: Thu,  6 Mar 2025 16:56:51 +0100
Message-ID: <cover.1741275846.git.pabeni@redhat.com>
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

Paolo Abeni (2):
  udp_tunnel: create a fast-path GRO lookup.
  udp_tunnel: use static call for GRO hooks when possible

 include/linux/udp.h        |  16 ++++
 include/net/netns/ipv4.h   |  11 +++
 include/net/udp.h          |   1 +
 include/net/udp_tunnel.h   |  22 +++++
 net/ipv4/udp.c             |  15 +++-
 net/ipv4/udp_offload.c     | 169 ++++++++++++++++++++++++++++++++++++-
 net/ipv4/udp_tunnel_core.c |  14 +++
 net/ipv6/udp.c             |   2 +
 net/ipv6/udp_offload.c     |   5 ++
 9 files changed, 252 insertions(+), 3 deletions(-)

-- 
2.48.1


