Return-Path: <netdev+bounces-30974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF99278A4BD
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 05:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543B9280DBC
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 03:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F467E4;
	Mon, 28 Aug 2023 03:06:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E393E654
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 03:06:45 +0000 (UTC)
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E10119;
	Sun, 27 Aug 2023 20:06:43 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qaSZs-008Na8-4h; Mon, 28 Aug 2023 11:06:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 28 Aug 2023 11:06:09 +0800
Date: Mon, 28 Aug 2023 11:06:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: mengkanglai <mengkanglai2@huawei.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Fengtao (fengtao, Euler)" <fengtao40@huawei.com>,
	"Yanan (Euler)" <yanan@huawei.com>
Subject: Re: ltp testcases failed due to commit cf3128a7aca
Message-ID: <ZOwPIczX73/22a35@gondor.apana.org.au>
References: <dd2a5ae913a84a36bded3dfeb4dbe466@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd2a5ae913a84a36bded3dfeb4dbe466@huawei.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
	PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
	SPF_PASS,TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 28, 2023 at 02:12:12AM +0000, mengkanglai wrote:
>
> This command eventually use setkey -c to add spdadd entry failed:
> spdadd $src_ipaddr $dst_ipaddr any
> 　　-P out ipsec $protocol/tunnel/${src_ipaddr}-${dst_ipaddr}/use ; 
> 
> It returns Invalid argument.
> 
> I found this failed due to commit cf3128a7aca(af_key: Reject optional tunnel/BEET mode templates in outbound policies), is latest ltp testcases are not adapted? 

Correct.  The above specification makes no sense for an outbound
policy as the SA can only be optional for inbound (where IPComp
can be skipped for incompressible plaintext).  So change the word
"use" above to "require" and it should work.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

