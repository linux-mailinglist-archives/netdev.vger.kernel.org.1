Return-Path: <netdev+bounces-36990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7F17B2D89
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 10:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 376A0281483
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 08:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79A45388;
	Fri, 29 Sep 2023 08:08:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3069CA5B
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 08:08:21 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F22E1A5;
	Fri, 29 Sep 2023 01:08:20 -0700 (PDT)
Received: from [78.30.34.192] (port=36496 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1qm8Xm-007wJ5-HC; Fri, 29 Sep 2023 10:08:16 +0200
Date: Fri, 29 Sep 2023 10:08:13 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Joao Moreira <joao@overdrivepizza.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kadlec@netfilter.org, fw@strlen.de, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	rkannoth@marvell.com, wojciech.drewek@intel.com,
	steen.hegenlund@microhip.com, keescook@chromium.org,
	Joao Moreira <joao.moreira@intel.com>
Subject: Re: [PATCH v3 2/2] Make num_actions unsigned
Message-ID: <ZRaF7YP03oTDdGEO@calendula>
References: <20230927164715.76744-1-joao@overdrivepizza.com>
 <20230927164715.76744-3-joao@overdrivepizza.com>
 <ZRWDCGG5/dP12YEs@calendula>
 <8f531b29873587b4f9b7ee64c745b667@overdrivepizza.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f531b29873587b4f9b7ee64c745b667@overdrivepizza.com>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 07:55:09PM -0700, Joao Moreira wrote:
> On 2023-09-28 06:43, Pablo Neira Ayuso wrote:
> > On Wed, Sep 27, 2023 at 09:47:15AM -0700, joao@overdrivepizza.com wrote:
> > > From: Joao Moreira <joao.moreira@intel.com>
> > > 
> > > Currently, in nft_flow_rule_create function, num_actions is a signed
> > > integer. Yet, it is processed within a loop which increments its
> > > value. To prevent an overflow from occurring, make it unsigned and
> > > also check if it reaches 256 when being incremented.
> > > 
> > > Accordingly to discussions around v2, 256 actions are more than enough
> > > for the frontend actions.
> > > 
> > > After checking with maintainers, it was mentioned that front-end will
> > > cap the num_actions value and that it is not possible to reach such
> > > condition for an overflow. Yet, for correctness, it is still better to
> > > fix this.
> > > 
> > > This issue was observed by the commit author while reviewing a
> > > write-up
> > > regarding a CVE within the same subsystem [1].
> > > 
> > > 1 - https://nickgregory.me/post/2022/03/12/cve-2022-25636/
> > 
> > Yes, but this is not related to the netfilter subsystem itself, this
> > harderning is good to have for the flow offload infrastructure in
> > general.
> 
> Right, I'll try to look up where this would fit in then. I'm not an expert
> in the subsystem at all, so should take a minute or two for me to get to it
> and send a v4.

Thanks.

> > >  	struct nft_expr *expr;
> > > 
> > >  	expr = nft_expr_first(rule);
> > > @@ -99,6 +100,10 @@ struct nft_flow_rule
> > > *nft_flow_rule_create(struct net *net,
> > >  		    expr->ops->offload_action(expr))
> > >  			num_actions++;
> > > 
> > > +		/* 2^8 is enough for frontend actions, avoid overflow */
> > > +		if (num_actions == 256)
> > 
> > This cap is not specific of nf_tables, it should apply to all other
> > subsystems. This is the wrong spot.
> 
> Any pointers regarding where I should look at?

See flow_rule_alloc().

