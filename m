Return-Path: <netdev+bounces-44472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED4C7D8252
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 14:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EABFA281FA1
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 12:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBD72D7BA;
	Thu, 26 Oct 2023 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="hk9cafQl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887FC12B69
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 12:13:17 +0000 (UTC)
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 05:13:16 PDT
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FB710A
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 05:13:15 -0700 (PDT)
X-KPN-MessageId: e1fbd4ed-73f8-11ee-a95f-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id e1fbd4ed-73f8-11ee-a95f-005056abbe64;
	Thu, 26 Oct 2023 14:12:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=WIlwRYx+HN+on+KOsbbIIiQndJeYG2STg6SXZwVsyQ8=;
	b=hk9cafQlcC+s4orVSOyanroWeaLoopTtW3XMMf7fN7+l28DFcFLWlznbmD3s+i711JTjpkgUyQ48l
	 hSLWJvFEpktUahHZk97jqSE12ebCsSDxTVUHYtRD1WUE8S3aIYfU+enhlZlJ6Wt6bYpr0sH4TGWlCI
	 oLtP+2Kw/Zft0nC8=
X-KPN-MID: 33|Pa5AViUIcuHsJDxf3bgxcIcaRh7f4TYgP05IBnMOFtDxQd020wSbiUzib1Q7X9S
 4ktekw4/Loyj1hLgVDR9cAHeqJF4fF46BaJaTN8r9x+c=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|FAeh/i4EOBEHsmyus/Sgla+IewBoCHWn7ZERRl6YLb6WMUaINTCYdVxGQozwy7B
 dwtpsypCB2C8k26qJqsEE/w==
X-Originating-IP: 213.10.186.43
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id e38cb1f8-73f8-11ee-b96b-005056abf0db;
	Thu, 26 Oct 2023 14:12:11 +0200 (CEST)
Date: Thu, 26 Oct 2023 14:12:09 +0200
From: Antony Antony <antony@phenome.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	herbert@gondor.apana.org.au
Subject: Re: [PATCH ipsec-next v3 0/3] xfrm: policy: replace session decode
 with flow dissector
Message-ID: <ZTpXmUH_GQ0FVD7a@Antony2201.local>
References: <20231004161002.10843-1-fw@strlen.de>
 <ZSUCdEwwb/+scrH7@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSUCdEwwb/+scrH7@gauss3.secunet.de>


On Tue, Oct 10, 2023 at 09:51:16AM +0200, Steffen Klassert wrote:
> On Wed, Oct 04, 2023 at 06:09:50PM +0200, Florian Westphal wrote:
> > Remove the ipv4+ipv6 session decode functions and use generic flow
> > dissector to populate the flowi for the policy lookup.
> > 
> > Changes since v2:
> > - first patch broke CONFIG_XFRM=n builds
> > 
> > Changes since v1:
> > - Can't use skb_flow_dissect(), we might see skbs that have neither
> >   skb->sk nor skb->dev set. Flow dissector WARN()s in this case, it
> >   tries to check for a bpf program assigned in that net namespace.
> > 
> > Add a preparation patch to pass down 'struct net' in
> > xfrm_decode_session so its available for use in patch 3.
> > 
> > Changes since RFC:
> > 
> >  - Drop mobility header support.  I don't think that anyone uses
> >    this.  MOBIKE doesn't appear to need this either.
> >  - Drop fl6->flowlabel assignment, original code leaves it as 0.
> > 
> > There is no reason for this change other than to remove code.
> > 
> > Florian Westphal (3):
> >   xfrm: pass struct net to xfrm_decode_session wrappers
> >   xfrm: move mark and oif flowi decode into common code
> >   xfrm: policy: replace session decode with flow dissector
> 
> Series applied, thanks a lot Florian!
> 

Hi Steffen,

I would like to report a potential bug that I've encountered while working 
on a related patch involving xfrm and ICMP packet decoding using wrapped 
xfrm_decode_session. This issue came to my attention while testing my my 
patch "xfrm: introduce forwarding of ICMP Error messages"

Here is the output from gdb after xfrm_decode_session.

before this series applied
p fl.u.ip4.uli
$3 = {ports = {dport = 11, sport = 0}, icmpt = {type = 11 '\v', code = 0 '\000'}, gre_key = 11, mht = { type = 11 '\v'}}

after this series applied.
p fl.u.ip4.uli
$11 = {ports = {dport = 0, sport = 0}, icmpt = {type = 0 '\000', code = 0 '\000'}, gre_key = 0, mht = { type = 0 '\000'}}

I believe this discrepancy may indicate an issue with the decoding of ICMP 
packets following the application above patches. 

While I could further debug the issue and create a generic test case to 
replicate it without my patch, I wanted to bring it to your attention before 
the ipsec-next branch gets merged into net-next.

regards,
-antony


