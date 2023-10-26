Return-Path: <netdev+bounces-44475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BB17D8335
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 14:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9831C20EA2
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 12:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B1F2D041;
	Thu, 26 Oct 2023 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469B18813
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 12:57:56 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C97FAC
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 05:57:54 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qvzvo-0006mq-AG; Thu, 26 Oct 2023 14:57:48 +0200
Date: Thu, 26 Oct 2023 14:57:48 +0200
From: Florian Westphal <fw@strlen.de>
To: Antony Antony <antony@phenome.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	herbert@gondor.apana.org.au
Subject: Re: [PATCH ipsec-next v3 0/3] xfrm: policy: replace session decode
 with flow dissector
Message-ID: <20231026125748.GA22233@breakpoint.cc>
References: <20231004161002.10843-1-fw@strlen.de>
 <ZSUCdEwwb/+scrH7@gauss3.secunet.de>
 <ZTpXmUH_GQ0FVD7a@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTpXmUH_GQ0FVD7a@Antony2201.local>
User-Agent: Mutt/1.10.1 (2018-07-13)

Antony Antony <antony@phenome.org> wrote:
> > > Florian Westphal (3):
> > >   xfrm: pass struct net to xfrm_decode_session wrappers
> > >   xfrm: move mark and oif flowi decode into common code
> > >   xfrm: policy: replace session decode with flow dissector
> > 
> > Series applied, thanks a lot Florian!
> > 
> 
> Hi Steffen,
> 
> I would like to report a potential bug that I've encountered while working

s/potential//

Does this patch make things work for you again?  Thanks!

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6aea8b2f45e0..e8c406eba11b 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3400,11 +3400,18 @@ decode_session4(const struct xfrm_flow_keys *flkeys, struct flowi *fl, bool reve
 		fl4->fl4_dport = flkeys->ports.dst;
 	}
 
+	switch (flkeys->basic.ip_proto) {
+	case IPPROTO_GRE:
+		fl4->fl4_gre_key = flkeys->gre.keyid;
+		break;
+	case IPPROTO_ICMP:
+		fl4->fl4_icmp_type = flkeys->icmp.type;
+		fl4->fl4_icmp_code = flkeys->icmp.code;
+		break;
+	}
+
 	fl4->flowi4_proto = flkeys->basic.ip_proto;
 	fl4->flowi4_tos = flkeys->ip.tos;
-	fl4->fl4_icmp_type = flkeys->icmp.type;
-	fl4->fl4_icmp_type = flkeys->icmp.code;
-	fl4->fl4_gre_key = flkeys->gre.keyid;
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -3427,10 +3434,17 @@ decode_session6(const struct xfrm_flow_keys *flkeys, struct flowi *fl, bool reve
 		fl6->fl6_dport = flkeys->ports.dst;
 	}
 
+	switch (flkeys->basic.ip_proto) {
+	case IPPROTO_GRE:
+		fl6->fl6_gre_key = flkeys->gre.keyid;
+		break;
+	case IPPROTO_ICMP:
+		fl6->fl6_icmp_type = flkeys->icmp.type;
+		fl6->fl6_icmp_code = flkeys->icmp.code;
+		break;
+	}
+
 	fl6->flowi6_proto = flkeys->basic.ip_proto;
-	fl6->fl6_icmp_type = flkeys->icmp.type;
-	fl6->fl6_icmp_type = flkeys->icmp.code;
-	fl6->fl6_gre_key = flkeys->gre.keyid;
 }
 #endif
 

