Return-Path: <netdev+bounces-16319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA3B74CB09
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 06:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A722280ED3
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 04:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91811FAF;
	Mon, 10 Jul 2023 04:09:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9998817F2
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 04:09:35 +0000 (UTC)
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B9CE7;
	Sun,  9 Jul 2023 21:09:30 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
	by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qIiCt-0010X8-6f; Mon, 10 Jul 2023 14:09:04 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 10 Jul 2023 14:08:56 +1000
Date: Mon, 10 Jul 2023 14:08:56 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Howells <dhowells@redhat.com>
Cc: syzbot <syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-crypto@vger.kernel.org,
	netdev@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: algif/hash: Fix race between MORE and non-MORE
 sends
Message-ID: <ZKuEWM3dbt/NpJDx@gondor.apana.org.au>
References: <2227988.1688721158@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2227988.1688721158@warthog.procyon.org.uk>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
	RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 07, 2023 at 10:12:38AM +0100, David Howells wrote:
> The 'MSG_MORE' state of the previous sendmsg() is fetched without the
> socket lock held, so two sendmsg calls can race.  This can be seen with a
> large sendfile() as that now does a series of sendmsg() calls, and if a
> write() comes in on the same socket at an inopportune time, it can flip the
> state.
> 
> Fix this by moving the fetch of ctx->more inside the socket lock.
> 
> Fixes: c662b043cdca ("crypto: af_alg/hash: Support MSG_SPLICE_PAGES")
> Reported-by: syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/r/000000000000554b8205ffdea64e@google.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> Tested-by: syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com
> cc: Herbert Xu <herbert@gondor.apana.org.au>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: linux-crypto@vger.kernel.org
> cc: netdev@vger.kernel.org
> ---
>  crypto/algif_hash.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

