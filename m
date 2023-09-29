Return-Path: <netdev+bounces-37021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B1A7B32F3
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 14:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1F3D12830FC
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 12:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557B219458;
	Fri, 29 Sep 2023 12:59:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F0D3C1D
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 12:59:11 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D62B7
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 05:59:09 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qmD5E-00067p-SQ; Fri, 29 Sep 2023 14:59:04 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH ipsec-next v2 0/3] xfrm: policy: replace session decode with flow dissector
Date: Fri, 29 Sep 2023 14:58:39 +0200
Message-ID: <20230929125848.5445-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove the ipv4+ipv6 session decode functions and use generic flow
dissector to populate the flowi for the policy lookup.

Changes since v1:
- Can't use skb_flow_dissect(), we might see skbs that have neither
  skb->sk nor skb->dev set. Flow dissector WARN()s in this case, it
  tries to check for a bpf program assigned in that net namespace.

Add a preparation patch to pass down 'struct net' in
xfrm_decode_session so its available for use in patch 3.

Changes since RFC:

 - Drop mobility header support.  I don't think that anyone uses
   this.  MOBIKE doesn't appear to need this either.
 - Drop fl6->flowlabel assignment, original code leaves it as 0.

There is no reason for this change other than to remove code.

Florian Westphal (3):
  xfrm: pass struct net to xfrm_decode_session wrappers
  xfrm: move mark and oif flowi decode into common code
  xfrm: policy: replace session decode with flow dissector

 include/net/xfrm.h             |  10 +-
 net/ipv4/icmp.c                |   2 +-
 net/ipv4/ip_vti.c              |   4 +-
 net/ipv4/netfilter.c           |   2 +-
 net/ipv6/icmp.c                |   2 +-
 net/ipv6/ip6_vti.c             |   4 +-
 net/ipv6/netfilter.c           |   2 +-
 net/netfilter/nf_nat_proto.c   |   2 +-
 net/xfrm/xfrm_interface_core.c |   4 +-
 net/xfrm/xfrm_policy.c         | 287 +++++++++++++--------------------
 10 files changed, 128 insertions(+), 191 deletions(-)

-- 
2.41.0


