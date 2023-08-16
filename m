Return-Path: <netdev+bounces-28075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 394FA77E242
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 15:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93241C21098
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 13:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA141096A;
	Wed, 16 Aug 2023 13:12:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A1E1078E
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 13:12:41 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD38270D
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 06:12:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 28163205ED;
	Wed, 16 Aug 2023 15:12:38 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C4Zks3rQA7-4; Wed, 16 Aug 2023 15:12:37 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 8B08620547;
	Wed, 16 Aug 2023 15:12:37 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 7BBC980004A;
	Wed, 16 Aug 2023 15:12:37 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 15:12:37 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 15:12:36 +0200
Date: Wed, 16 Aug 2023 15:12:29 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>
CC: Eyal Birger <eyal.birger@gmail.com>, <devel@linux-ipsec.org>,
	<netdev@vger.kernel.org>, Antony Antony <antony.antony@secunet.com>
Subject: [PATCH v5 ipsec-next 0/3] xfrm: Support GRO decapsulation for ESP in
 UDP encapsulation
Message-ID: <cover.1692191034.git.antony.antony@secunet.com>
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
Here I re-worked this patch set and here is v5 based of feed back from Eyal.


v1->v2 fixed error path added skb_push
        use is_fou instead of holding sk in skb.
        user configurable option to enable GRO; using UDP_GRO

v2->v3 only support GRO for UDP_ENCAP_ESPINUDP and not
        UDP_ENCAP_ESPINUDP_NON_IKE. The _NON_IKE is an IETF early draft
        version and not widly used.

v3->v4 removed refactoring since refactored function is only used once
        removed refcount on sk, sk is not used any more.
        fixed encap_type as Eyal recommended.
        removed un-necessary else since there is a goto before that.

v4->v5 removed extra code/checks that accidently got added.


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


