Return-Path: <netdev+bounces-131006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1FA98C605
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C12A8284047
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 19:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CEE1CCEC2;
	Tue,  1 Oct 2024 19:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKRlvY+W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E32A1CCEE8
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 19:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810918; cv=none; b=CKcoRxoKJ/r0ZN1r/6O5mIqw4Sv90EZPHZEr4vkRSjA6ZGkQwevU7ynNPu5y74EUI3l+AOsos6tdof0sydJeXmMoUUE563QLYUgy9fJQl3cnsLChcr+kog64tUNAIV+TcvsfJvG9WlD0mVCP5wAWmwRnQuzBYTxNt0dKnj0JBlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810918; c=relaxed/simple;
	bh=kGTHWhOdpbJ4pgoCHf+PajzmJSj8Xw+he4OOkWSE+nY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IeDMua5aL4mGPFrv44xXiXEMx6xfqzkYIbGDNLr34LYSnPbgDT/lwz5SKXwhv8goYSNmXJepYMKql9VnahtdAzxyg2sB2qZelYzXx1YtTMv3eb9OwrTg5mOIFNdYjXp79WxaQQsCFAMYytpY70DLYeO3qmVBa/zvOKDa3t52aYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AKRlvY+W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727810916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5uCY9KowIheJi0xSKLb8NbKUh2Nq2MaKIvct2XXjHxQ=;
	b=AKRlvY+WXp9ickNZUIOFImQ8uIm+U45fTJQE3p354Zo5BlqiDuQ9ES1yuTRNUNjOEw1vj6
	3uaP8NoE12hHP2Lzu0bYUSY17RMlHlvAtby3Lnhq6zKlsolGdk+io3lbIVlbvKizpdmDBT
	QR1KR74gWDFJ4FC3w6ryp56KWNwMksI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692--eLTbyL8M--0MADp1bhyXA-1; Tue, 01 Oct 2024 15:28:34 -0400
X-MC-Unique: -eLTbyL8M--0MADp1bhyXA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37cd2044558so2635775f8f.1
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 12:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727810913; x=1728415713;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5uCY9KowIheJi0xSKLb8NbKUh2Nq2MaKIvct2XXjHxQ=;
        b=nKz9DUIz228IjVeRl0hF4FLXJyijih+kuDFMbI2F09LbOIK1/kpl4sZt95e5HPDvzk
         RIzWcG7M64epv3MEeSjjuE8eE4JOefxJrfl6tmyk3bg6kvXWk86GJrNQTCQoCceKT4p3
         f5E/9vrHnrhXW9UAitqjz8GeVwJoNlmDMfGYdUVmsnyu1DM03SKRCTln+HY/hqzhJNpE
         se6oDgvAIkADJrSdtTtfL4k6//Vq8duZUmmM95zIXndDSOXoG6SOfMyYvtGfsc4PAxXu
         6uGK5coDuTq8shGMmUefsk8xHf3gAeJvuGqwyOy/MVQPEIQUZma2xCmtVOvYQUXDTKDX
         h7Ig==
X-Gm-Message-State: AOJu0Yz6HDexBQPOWN3wpmivvYH9TVVsk/TlbAfJxSb8wMtPiF3RZXJm
	6i5X6ON7LS6omM9qQ2Wr3fLtnaTOaEdpdgD9b3/dqvZRiPOx+v8i2TzdFVkdABI8Ex/xcsKkhnJ
	ZkZn3ayYR0ix6IotuXduyKWda38RuJZai6YkP1KKeCY459yeSCX+XkA==
X-Received: by 2002:a5d:4850:0:b0:374:c3a3:1f4f with SMTP id ffacd0b85a97d-37cfb9d22b8mr423316f8f.24.1727810913374;
        Tue, 01 Oct 2024 12:28:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLCgpnc2a6dvZdb4xXa1I2/lJYVOJH5fokV8zUw+4rRqsuW/dNsUgG8PweO0M0cfiKQWoF0Q==
X-Received: by 2002:a5d:4850:0:b0:374:c3a3:1f4f with SMTP id ffacd0b85a97d-37cfb9d22b8mr423302f8f.24.1727810912992;
        Tue, 01 Oct 2024 12:28:32 -0700 (PDT)
Received: from debian (2a01cb058d23d60018ec485714c2d3db.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:18ec:4857:14c2:d3db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d42esm12541040f8f.14.2024.10.01.12.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 12:28:32 -0700 (PDT)
Date: Tue, 1 Oct 2024 21:28:30 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH net-next 0/5] ipv4: Convert ip_route_input_slow() and its
 callers to dscp_t.
Message-ID: <cover.1727807926.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Prepare ip_route_input_slow() and its call chain to future conversion
of ->flowi4_tos.

The ->flowi4_tos field of "struct flowi4" is used in many different
places, which makes it hard to convert it from __u8 to dscp_t.

In order to avoid a big patch updating all its users at once, this
patch series gradually converts some users to dscp_t. Those users now
set ->flowi4_tos from a dscp_t variable that is converted to __u8 using
inet_dscp_to_dsfield().

When all users of ->flowi4_tos will use a dscp_t variable, converting
that field to dscp_t will just be a matter of removing all the
inet_dscp_to_dsfield() conversions.

This series concentrates on ip_route_input_slow() and its direct and
indirect callers.

Guillaume Nault (5):
  ipv4: Convert icmp_route_lookup() to dscp_t.
  ipv4: Convert ip_route_input() to dscp_t.
  ipv4: Convert ip_route_input_noref() to dscp_t.
  ipv4: Convert ip_route_input_rcu() to dscp_t.
  ipv4: Convert ip_route_input_slow() to dscp_t.

 drivers/net/ipvlan/ipvlan_l3s.c |  6 ++++--
 include/net/ip.h                |  5 +++++
 include/net/route.h             |  8 ++++----
 net/bridge/br_netfilter_hooks.c |  8 +++++---
 net/core/lwt_bpf.c              |  5 +++--
 net/ipv4/icmp.c                 | 19 +++++++++----------
 net/ipv4/ip_fragment.c          |  4 ++--
 net/ipv4/ip_input.c             |  2 +-
 net/ipv4/ip_options.c           |  3 ++-
 net/ipv4/route.c                | 32 ++++++++++++++++++--------------
 net/ipv4/xfrm4_input.c          |  2 +-
 net/ipv4/xfrm4_protocol.c       |  2 +-
 net/ipv6/ip6_tunnel.c           |  4 ++--
 13 files changed, 57 insertions(+), 43 deletions(-)

-- 
2.39.2


