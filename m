Return-Path: <netdev+bounces-34549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E6C7A498D
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 14:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97810281D32
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F001CABE;
	Mon, 18 Sep 2023 12:26:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8A9EEC6
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:26:25 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490E2CE7
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 05:25:35 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qiDJf-00FVXX-Bq; Mon, 18 Sep 2023 20:25:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 18 Sep 2023 20:25:30 +0800
Date: Mon, 18 Sep 2023 20:25:30 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Alexander Aring <aahringo@redhat.com>,
	Network Development <netdev@vger.kernel.org>, kadlec@netfilter.org,
	fw@strlen.de, gfs2@lists.linux.dev,
	David Teigland <teigland@redhat.com>, tgraf@suug.ch
Subject: Re: nft_rhash_walk, rhashtable and resize event
Message-ID: <ZQhButkhI8K6cduD@gondor.apana.org.au>
References: <CAK-6q+ghZRxrWQg3k0x1-SofoxfVfObJMg8wZ3UUMM4CU2oiWg@mail.gmail.com>
 <ZQUjD0liUnH+ykKY@gondor.apana.org.au>
 <ZQg7s8MtByk4kfzP@calendula>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQg7s8MtByk4kfzP@calendula>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 01:59:47PM +0200, Pablo Neira Ayuso wrote:
>
> One more question: this walk might miss entries but may it also
> duplicate the same entries?

It depends on what happens during the walk.  If you're lucky
and no resize event occurs during the walk, then you won't miss
any entries or see duplicates.

When a resize event does occur, then we will tell you that it
happened by returning EAGAIN.  It means that you should start
from the beginning and redo the whole walk.  If you do that
then you won't miss anything (although, you may never finish
if the table keeps getting resized).

But obviously duplicates will occur if you take this approach.

> I will work on a patch to update netfilter clients for this code to
> use a rcu linked list.

Sounds good!

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

