Return-Path: <netdev+bounces-169927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 240A3A467E6
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3652016916A
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 17:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310DB223313;
	Wed, 26 Feb 2025 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQsqllMQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B65921CFEA
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740590412; cv=none; b=i9J9pt5XEkqgZz02YUPMfii4PpIhVbjpNEzHnd+bmGQiGktp1jVnRQUYCSyF/wwEvPRQ+0ac1hzh0w1sRZpYkI/yNTYMpaeP8YLXkCAwgpmxhQf6E8qOHJVlPny/uYGGt7c7S4LaYVxq6cx0/Dn4KBM1Q3DGBusPfAzlqoCwONs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740590412; c=relaxed/simple;
	bh=X0Du9RFE5f0KcZhITaDIfErI9DNPNVabRECL9T7vpDM=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=SkFLKABa8nqtozl/vCYBEyyozIUXVHTqRGKJsr6gyfUjTasvB9bF83uBo7tsyfxo5scukHYiOdferqPduYU50DD2gy5zFA16IUsv0880Zs7Zq9DcQtUPeN+7J2LaeSnFy3Xe/zb8ATdJqBWtZ4JQAvZHHncctfayvhfp7rqRhbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQsqllMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB50C4CED6;
	Wed, 26 Feb 2025 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740590410;
	bh=X0Du9RFE5f0KcZhITaDIfErI9DNPNVabRECL9T7vpDM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=gQsqllMQpW48qJlCxFp8fRFY5wbW63dy+1MsXm96E1TMgMZlATd0ttBvcv06TCdsw
	 7KnJKI4SFOj/KVvL38zZpyB6nBUyBssdsM/8SCSmhVhKHKZbO9MP6jKjNsT6cGAwAj
	 jBnmeDzn+fbOJoCGjXFoRruYs0WHbgzLAL2PK+cKmiEJe0FZ24OLuWSl9Ou6zUZ5I8
	 VNV4R6wSy/ZLz5lK/WI11wK9R7LheDqR9dGW0Z1vjCYCzFInv/r+H8eVsDH1xy7PUt
	 wL5aaGL5HrF2PG3lNEpSpPnAa3WmPiDjko7PjdOfZTjDc1X8VCYL75WUQffX1w6WAm
	 eL7WTfa56duiQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250226171352.258045-1-atenart@kernel.org>
References: <20250226171352.258045-1-atenart@kernel.org>
Subject: Re: [PATCH net] net: gso: fix ownership in __udp_gso_segment
From: Antoine Tenart <atenart@kernel.org>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com, pshelar@ovn.org
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 26 Feb 2025 18:20:07 +0100
Message-ID: <174059040728.99819.2585982147439431813@kwain>

Quoting Antoine Tenart (2025-02-26 18:13:42)
> In __udp_gso_segment the skb destructor is removed before segmenting the
> skb but the socket reference is kept as-is. This is an issue if the
> original skb is later orphaned as we can hit the following bug:
>=20
>   kernel BUG at ./include/linux/skbuff.h:3312!  (skb_orphan)
>   RIP: 0010:ip_rcv_core+0x8b2/0xca0
>   Call Trace:
>    ip_rcv+0xab/0x6e0
>    __netif_receive_skb_one_core+0x168/0x1b0
>    process_backlog+0x384/0x1100
>    __napi_poll.constprop.0+0xa1/0x370
>    net_rx_action+0x925/0xe50
>=20
> The above can happen following a sequence of events when using
> OpenVSwitch, when an OVS_ACTION_ATTR_USERSPACE action precedes an
> OVS_ACTION_ATTR_OUTPUT action:
>=20
> 1. OVS_ACTION_ATTR_USERSPACE is handled (in do_execute_actions): the skb
>    goes through queue_gso_packets and then __udp_gso_segment, where its
>    destructor is removed.
> 2. The segments' data are copied and sent to userspace.
> 3. OVS_ACTION_ATTR_OUTPUT is handled (in do_execute_actions) and the
>    same original skb is sent to its path.
> 4. If it later hits skb_orphan, we hit the bug.

While AFAIU removing the skb destructor while not removing the socket
reference is not often wanted (we could add an helper as it's not the
first time we hit this?), I also looked at the OvS side for
completeness. The following also fixes the above,

--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1407,15 +1407,19 @@ static int do_execute_actions(struct datapath *dp, =
struct sk_buff *skb,
                        break;
                }
=20
-               case OVS_ACTION_ATTR_USERSPACE:
-                       output_userspace(dp, skb, key, a, attr,
-                                                    len, OVS_CB(skb)->cutl=
en);
+               case OVS_ACTION_ATTR_USERSPACE: {
+                       struct sk_buff *clone;
+
+                       clone =3D nla_is_last(a, rem) ? skb : skb_clone(skb=
, GFP_ATOMIC);
+                       if (clone)
+                               output_userspace(dp, clone, key, a, attr, l=
en,
+                                                OVS_CB(skb)->cutlen);
                        OVS_CB(skb)->cutlen =3D 0;
-                       if (nla_is_last(a, rem)) {
-                               consume_skb(skb);
+                       consume_skb(clone);
+                       if (nla_is_last(a, rem))
                                return 0;
-                       }
                        break;
+               }

output_userspace could be seen as a different path where cloning is
wanted, but at the same time it's only copying the packet content and I
didn't see a reason not to allow reusing the original skb after calling
__skb_gso_segment in the GSO case.

Thoughts?

Thanks!
Antoine

