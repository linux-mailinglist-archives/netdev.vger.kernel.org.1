Return-Path: <netdev+bounces-31586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D399578EEBC
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 15:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571FF281412
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCA011729;
	Thu, 31 Aug 2023 13:38:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FFD11725
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 13:38:06 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0651A2;
	Thu, 31 Aug 2023 06:38:05 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qbhrq-0000RJ-9x; Thu, 31 Aug 2023 15:37:50 +0200
Date: Thu, 31 Aug 2023 15:37:50 +0200
From: Florian Westphal <fw@strlen.de>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Fernando Fernandez Mancera <ffmancera@riseup.net>,
	"open list:NETFILTER" <netfilter-devel@vger.kernel.org>,
	"open list:NETFILTER" <coreteam@netfilter.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lucas Leong <wmliang@infosec.exchange>, stable@kernel.org
Subject: Re: [PATCH nf v2] netfilter/osf: avoid OOB read
Message-ID: <20230831133750.GB15759@breakpoint.cc>
References: <20230831123931.60606-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831123931.60606-1-wander@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wander Lairson Costa <wander@redhat.com> wrote:
> 
> diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
> index 8f1bfa6ccc2d..13fedf2aaa0f 100644
> --- a/net/netfilter/nfnetlink_osf.c
> +++ b/net/netfilter/nfnetlink_osf.c
> @@ -315,6 +315,9 @@ static int nfnl_osf_add_callback(struct sk_buff *skb,
>  
>  	f = nla_data(osf_attrs[OSF_ATTR_FINGER]);
>  
> +	if (f->opt_num > ARRAY_SIZE(f->opt))
> +		return -EINVAL;
> +

Hmm, this isn't enough; as far as I can see there is no validation
whatsover.

This should also check that all of:

 char    genre[MAXGENRELEN];
 char    version[MAXGENRELEN];
 char    subtype[MAXGENRELEN];

... have a NUL byte.  You could use strnlen() == ARRAY_SIZE() -> EINVAL
for those.

Maybe there is more to be validated, I did not followup with all the
nested structures buried in user_finger struct.

