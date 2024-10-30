Return-Path: <netdev+bounces-140369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78549B633F
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D98F1F21CF0
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 12:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F63F1E8859;
	Wed, 30 Oct 2024 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEPcUBjJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942941E411D
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 12:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292199; cv=none; b=jSP4ANKKU0SNEblfqBBQpfjCUyzar6W8iqXPtIEPbMaNXwajrcV/2kptPkZ1essY4GpR8zPlR641G5zy6QfQYPtjjG0KdSAZdyS9/xYCPsKX9PQ+Q/vBXi6Px7wAJoUic5Mf6ld0tDIgnx/Eso2IXAHRLxiZTbBI/Ib7WgIdHQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292199; c=relaxed/simple;
	bh=f8ktNFxxp88fXkwPUJzumSSuZLVrQ0+xUyPRGbJVjzk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NzK43q55PkkpdfrmtABkNAhZwjwMAEUf4YLwf7hj4ICYJ8BiOhQfZ3GVYdlSGeSoVZ+Fr/StSeBN63BrJgBaCFIabVhW0I7nWdRm4W9Qvh9sflhmV1CBEN3Hv1Ebo8RyAw9LomKbjt6rJ0MZHqbmE0MHWXCN+LjEbU0mFHgpwD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HEPcUBjJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730292196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=3hGS4eB170lCGb8LEsK8iUL++OVfZqypyg/F5yByD9o=;
	b=HEPcUBjJNmjda5l1NWUEX02K5ztm32cqLr6TRmREmZ5D9jMk9TEqrBOUXbnlPe5vsd/hnp
	8QfBNUB02/Aua8uMl3aAQFNEVGSqQSYCxIn7nl9LO8J07MbA0z9OHsoj3VYW8FvKNuiHZH
	XlBDKbQ1x9KNqLWMlEjxM42HGp7LnS0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-za6qTXeeMciY6ZHFYYvjWw-1; Wed, 30 Oct 2024 08:43:15 -0400
X-MC-Unique: za6qTXeeMciY6ZHFYYvjWw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4316e2dde9eso58698095e9.2
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 05:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730292194; x=1730896994;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3hGS4eB170lCGb8LEsK8iUL++OVfZqypyg/F5yByD9o=;
        b=PViymEI6xDnRScSUd14/9DdINdca7k5PET8b6WCOxOsGsOr/QGzq1IywvOuhfJkZMZ
         dM6nHgRQ1IM1EwcFmfNDmmzdT8sv6XuUQY5P1GtT3NTqo45fVXCwuq2vfUWHTkBzvHLs
         yiao88ePd+ewZx7mnmkt4GGVFABmlXiwfne/P3fTInZG/cHmEHqGdOtLkDwQWFf1RuPW
         htU3r1CkxCdFLiJphveGX0z0rGXMPMCmwIS/3bKTDuBfvpUO4SMMa2eYHNutulnfb469
         9SedICmNexQDGufP87LT03r4TYJoSZnw58qXkOqNTQRZmD2OCLvy7XVRb3OTHUYvzpZT
         Ij9Q==
X-Gm-Message-State: AOJu0YyT6j+v6+BQjtY3+aZi6H5FSph55gP2h5+If6ODtTRrvnQm2I4r
	C6OTcde7F0LMmLua40/yRkdCLd3Q1o4qTbuEIqDxrMlA6RzO7ltJDdrm2ecF5UV/uzdAMrEB8jz
	ZWpEYKOUM7hjGqFcpUdi/D1oYthbNAz3ICQ21SqRg5pJhNNGeJ+MJdg==
X-Received: by 2002:a05:600c:3c8c:b0:42b:ac3d:3abc with SMTP id 5b1f17b1804b1-4319ad068f6mr165621965e9.24.1730292193856;
        Wed, 30 Oct 2024 05:43:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHesBiLWQaMknGJ/FJGzwquRD0voaTPaJMqnCfKTkNpCiPWDwOC+m8WLhSme+2B+tATUEGQ5Q==
X-Received: by 2002:a05:600c:3c8c:b0:42b:ac3d:3abc with SMTP id 5b1f17b1804b1-4319ad068f6mr165621715e9.24.1730292193469;
        Wed, 30 Oct 2024 05:43:13 -0700 (PDT)
Received: from debian (2a01cb058d23d600438d14b4ec9f14b9.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:438d:14b4:ec9f:14b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b13246sm15281745f8f.11.2024.10.30.05.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 05:43:13 -0700 (PDT)
Date: Wed, 30 Oct 2024 13:43:11 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next] ipvlan: Prepare ipvlan_process_v4_outbound() to
 future .flowi4_tos conversion.
Message-ID: <f48335504a05b3587e0081a9b4511e0761571ca5.1730292157.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use ip4h_dscp() to get the DSCP from the IPv4 header, then convert the
dscp_t value to __u8 with inet_dscp_to_dsfield().

Then, when we'll convert .flowi4_tos to dscp_t, we'll just have to drop
the inet_dscp_to_dsfield() call.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 drivers/net/ipvlan/ipvlan_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index b1afcb8740de..fd591ddb3884 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -3,6 +3,7 @@
  */
 
 #include <net/inet_dscp.h>
+#include <net/ip.h>
 
 #include "ipvlan.h"
 
@@ -422,7 +423,7 @@ static noinline_for_stack int ipvlan_process_v4_outbound(struct sk_buff *skb)
 	int err, ret = NET_XMIT_DROP;
 	struct flowi4 fl4 = {
 		.flowi4_oif = dev->ifindex,
-		.flowi4_tos = ip4h->tos & INET_DSCP_MASK,
+		.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(ip4h)),
 		.flowi4_flags = FLOWI_FLAG_ANYSRC,
 		.flowi4_mark = skb->mark,
 		.daddr = ip4h->daddr,
-- 
2.39.2


