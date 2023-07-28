Return-Path: <netdev+bounces-22223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 167287669A3
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4E61C2180D
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0398C11185;
	Fri, 28 Jul 2023 10:00:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A9F10977
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:00:54 +0000 (UTC)
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8943AAA
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:00:41 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qPKGr-0011Mj-R4; Fri, 28 Jul 2023 18:00:30 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 28 Jul 2023 18:00:29 +0800
Date: Fri, 28 Jul 2023 18:00:29 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Alexander H Duyck <alexander.duyck@gmail.com>
Cc: Yuanjun Gong <ruc_gongyuanjun@163.com>, dsahern@kernel.org,
	netdev@vger.kernel.org, steffen.klassert@secunet.com
Subject: Re: [PATCH v2 1/1] net: ipv4: fix return value check in
 esp_remove_trailer()
Message-ID: <ZMORvfKiMwxn6DlD@gondor.apana.org.au>
References: <f6831ace-df6c-f0bd-188e-a2b23a75c1a8@kernel.org>
 <20230725064031.4472-1-ruc_gongyuanjun@163.com>
 <50201d64ba71669422c9bc2900179887d11a974e.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50201d64ba71669422c9bc2900179887d11a974e.camel@gmail.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 10:44:50AM -0700, Alexander H Duyck wrote:
> On Tue, 2023-07-25 at 14:40 +0800, Yuanjun Gong wrote:
> > return an error number if an unexpected result is returned by
> > pskb_tirm() in esp_remove_trailer().
> > 
> > Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> > ---
> >  net/ipv4/esp4.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> > index ba06ed42e428..b435e3fe4dc6 100644
> > --- a/net/ipv4/esp4.c
> > +++ b/net/ipv4/esp4.c
> > @@ -732,7 +732,9 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
> >  		skb->csum = csum_block_sub(skb->csum, csumdiff,
> >  					   skb->len - trimlen);
> >  	}
> > -	pskb_trim(skb, skb->len - trimlen);
> > +	ret = pskb_trim(skb, skb->len - trimlen);
> > +	if (ret)
> > +		goto out;
> >  
> >  	ret = nexthdr[1];
> >  
> 
> In what case would you encounter this error? From what I can tell it
> looks like there are checks in the callers, specifically the call to
> pskb_may_pull() at the start of esp_input() that will go through and
> automatically eliminate all the potential reasons for this to fail. So
> I am not sure what the point is in adding exception handling for an
> exception that is already handled.

Good point.  pskb_trim should never fail at this point because
we've already made the packet completely writeable.

Perhaps we could add a comment?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

