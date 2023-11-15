Return-Path: <netdev+bounces-48070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD517EC708
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 16:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C6E28119B
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 15:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27599341AE;
	Wed, 15 Nov 2023 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027872FC58
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 15:19:38 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FC9195
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 07:19:35 -0800 (PST)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-hWzZXMzuMgCsuaH5hWNz7g-1; Wed, 15 Nov 2023 10:19:29 -0500
X-MC-Unique: hWzZXMzuMgCsuaH5hWNz7g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6EB2F101A53B;
	Wed, 15 Nov 2023 15:19:29 +0000 (UTC)
Received: from hog (unknown [10.39.192.24])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 618F31121306;
	Wed, 15 Nov 2023 15:19:28 +0000 (UTC)
Date: Wed, 15 Nov 2023 16:19:27 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net] macsec: Abort MACSec Rx offload datapath when skb is
 not marked with MACSec metadata
Message-ID: <ZVThf1Z-hExKlDE2@hog>
References: <20231101200217.121789-1-rrameshbabu@nvidia.com>
 <ZULRxX9eIbFiVi7v@hog>
 <87r0l25y1c.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87r0l25y1c.fsf@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2023-11-06, 14:15:11 -0800, Rahul Rameshbabu wrote:
> However, I believe that all macsec offload supporting devices run into
> the following problem today (including mlx5 devices).

If that's the case, we have to fix all of them.

> When I configure macsec offload on a device and then vlan on top of the
> macsec interface, I become unable to send traffic through the underlying
> device.
[...]
>   ping -I mlx5_1 1.1.1.2
>   PING 1.1.1.2 (1.1.1.2) from 1.1.1.1 mlx5_1: 56(84) bytes of data.
>   From 1.1.1.1 icmp_seq=3D1 Destination Host Unreachable
>   ping: sendmsg: No route to host
>   From 1.1.1.1 icmp_seq=3D2 Destination Host Unreachable
>   From 1.1.1.1 icmp_seq=3D3 Destination Host Unreachable

Which packet gets dropped and why? Where? I don't understand how the
vlan makes a difference in a packet targeting the lower device.

> I am thinking the solution is a combination of annotating which macsec
> devices support md_dst and this patch.

Yes, if we know that the offloading device sets md_dst on all its
offloaded packets, we can just look up the rx_sc based on the sci and
be done, or pass the packet directly to the real device if md_dst
wasn't provided. No need to go through the MAC address matching at
all.

> However, I am not sure this fix
> would be helpful for devices that support macsec offload without
> utilizing md_dst information (would still be problematic).

Yeah, anything relying on md_dst is not going to help the rest of the
drivers.

--=20
Sabrina


