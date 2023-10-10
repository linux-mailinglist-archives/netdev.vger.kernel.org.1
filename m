Return-Path: <netdev+bounces-39455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CADF7BF4C5
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90EE281AE0
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 07:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC88211708;
	Tue, 10 Oct 2023 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A74D295
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 07:51:22 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0627FC6
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 00:51:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id BB6DD2074A;
	Tue, 10 Oct 2023 09:51:18 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AiMXfPagy-9H; Tue, 10 Oct 2023 09:51:17 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 83BF9201C7;
	Tue, 10 Oct 2023 09:51:17 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 73FEE80004A;
	Tue, 10 Oct 2023 09:51:17 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 09:51:17 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 10 Oct
 2023 09:51:16 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 6BD3031847DF; Tue, 10 Oct 2023 09:51:16 +0200 (CEST)
Date: Tue, 10 Oct 2023 09:51:16 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Florian Westphal <fw@strlen.de>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec-next v3 0/3] xfrm: policy: replace session decode
 with flow dissector
Message-ID: <ZSUCdEwwb/+scrH7@gauss3.secunet.de>
References: <20231004161002.10843-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231004161002.10843-1-fw@strlen.de>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 04, 2023 at 06:09:50PM +0200, Florian Westphal wrote:
> Remove the ipv4+ipv6 session decode functions and use generic flow
> dissector to populate the flowi for the policy lookup.
> 
> Changes since v2:
> - first patch broke CONFIG_XFRM=n builds
> 
> Changes since v1:
> - Can't use skb_flow_dissect(), we might see skbs that have neither
>   skb->sk nor skb->dev set. Flow dissector WARN()s in this case, it
>   tries to check for a bpf program assigned in that net namespace.
> 
> Add a preparation patch to pass down 'struct net' in
> xfrm_decode_session so its available for use in patch 3.
> 
> Changes since RFC:
> 
>  - Drop mobility header support.  I don't think that anyone uses
>    this.  MOBIKE doesn't appear to need this either.
>  - Drop fl6->flowlabel assignment, original code leaves it as 0.
> 
> There is no reason for this change other than to remove code.
> 
> Florian Westphal (3):
>   xfrm: pass struct net to xfrm_decode_session wrappers
>   xfrm: move mark and oif flowi decode into common code
>   xfrm: policy: replace session decode with flow dissector

Series applied, thanks a lot Florian!

