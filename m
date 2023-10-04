Return-Path: <netdev+bounces-37957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4074F7B8033
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 15:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 322F328143B
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 13:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530E714008;
	Wed,  4 Oct 2023 13:05:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DA110966
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 13:05:07 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA9D98
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 06:05:04 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 92B20205E5;
	Wed,  4 Oct 2023 15:05:02 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pKGvygJsXy3u; Wed,  4 Oct 2023 15:05:01 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 4DC432082B;
	Wed,  4 Oct 2023 15:05:01 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 4655E80004A;
	Wed,  4 Oct 2023 15:05:01 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 15:05:01 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 4 Oct
 2023 15:05:00 +0200
Date: Wed, 4 Oct 2023 15:04:53 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>
CC: Eyal Birger <eyal.birger@gmail.com>, <devel@linux-ipsec.org>, Eric Dumazet
	<edumazet@google.com>, <netdev@vger.kernel.org>, Antony Antony
	<antony.antony@secunet.com>
Subject: [PATCH v7 ipsec-next 0/3] xfrm: Support GRO decapsulation for ESP in
 UDP encapsulation
Message-ID: <cover.1696423735.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <6dfd03c5fa0afb99f255f4a35772df19e33880db.1674156645.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6dfd03c5fa0afb99f255f4a35772df19e33880db.1674156645.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

I have added how to enable this feature, and more description to the second
patch. Here is copy of that.

xfrm: Support GRO for IPv4i & IPv6 ESP in UDP encapsulation

This patchset enables the GRO codepath for ESP in UDP encapsulated
packets. Decapsulation happens at L2 and saves a full round through
the stack for each packet. This is also needed to support HW offload
for ESP in UDP encapsulation.

Enabling this would imporove performance for ESP in UDP datapath, i.e
IPsec with NAT in between. Our initial tests show 20% improvement.


By default GRP for ESP-in-UDP is disabled for UDP sockets.
To enable this feature for an ESP socket, the following two options
need to be set:
 1. enable ESP-in-UDP: (this is already set by an IKE daemon).
    int type = UDP_ENCAP_ESPINUDP;
    setsockopt(fd, SOL_UDP, UDP_ENCAP, &type, sizeof(type));

 2. To enable GRO for ESP in UDP socket:
    type = true;
    setsockopt(fd, SOL_UDP, UDP_GRO, &type, sizeof(type));

Enabling ESP-in-UDP has the side effect of preventing the Linux stack from
seeing ESP packets at the L3 (when ESP OFFLOAD is disabled), as packets are
immediately decapsulated from UDP and decrypted.
This change may affect nftable rules that match on ESP packets  at L3.
Also tcpdump won't see the ESP packet.

Developers/admins are advised to review and adapt any nftable rules
accordingly before enabling this feature to prevent potential rule breakage.
Also tcpdump will not see from ESP packets from a ESP in UDP flow when this
is enabled.

---

Initial, a quick test showed performance difference of about 20%
impromvent on the receiver, when using iperf, tcp flow, over ESP in UDP.

Steffen Klassert (3):
  xfrm: Use the XFRM_GRO to indicate a GRO call on input
  xfrm: Support GRO for IPv4 ESP in UDP encapsulation
  xfrm: Support GRO for IPv6 ESP in UDP encapsulation

 include/net/gro.h        |  2 +-
 include/net/ipv6_stubs.h |  3 ++
 include/net/xfrm.h       |  4 ++
 net/ipv4/esp4_offload.c  |  6 ++-
 net/ipv4/udp.c           | 16 +++++++
 net/ipv4/xfrm4_input.c   | 94 ++++++++++++++++++++++++++++++++--------
 net/ipv6/af_inet6.c      |  1 +
 net/ipv6/esp6_offload.c  | 10 ++++-
 net/ipv6/xfrm6_input.c   | 94 ++++++++++++++++++++++++++++++++--------
 net/xfrm/xfrm_input.c    |  6 +--
 10 files changed, 192 insertions(+), 44 deletions(-)

--
2.30.2


