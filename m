Return-Path: <netdev+bounces-14941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEBA7447D2
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 09:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1812F1C20C72
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 07:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0C23FDD;
	Sat,  1 Jul 2023 07:51:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C289B3C17
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 07:51:46 +0000 (UTC)
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C64199
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 00:51:42 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
	by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qFVOJ-0009R1-MW; Sat, 01 Jul 2023 17:51:36 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 01 Jul 2023 15:51:29 +0800
Date: Sat, 1 Jul 2023 15:51:29 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc: Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>,
	Linux Network Development Mailing List <netdev@vger.kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Benedict Wong <benedictwong@google.com>,
	Lorenzo Colitti <lorenzo@google.com>, Yan Yan <evitayan@google.com>
Subject: Re: [PATCH] FYI 6.4 xfrm_prepare_input/xfrm_inner_mode_encap_remove
 WARN_ON hit - related to ESPinUDP
Message-ID: <ZJ/bAeYnpnhEPJXb@gondor.apana.org.au>
References: <20230630153759.3349299-1-maze@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230630153759.3349299-1-maze@google.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
	PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 08:37:58AM -0700, Maciej Żenczykowski wrote:
> Steffan, this isn't of course a patch meant for inclusion, instead just a WARN_ON hit report.
> The patch is simply what prints the following extra info:
> 
> xfrm_prepare_input: XFRM_MODE_SKB_CB(skb)->protocol: 17
> xfrm_inner_mode_encap_remove: x->props.mode: 1 XFRM_MODE_SKB_SB(skb)->protocol:17

This seems to make no sense.  UDP encapsulation is supposed to sit
on the outside of ESP.  So by the time we hit xfrm_input it should
be lone gone.  On the inside of the packet, as it's tunnel mode we
should have either IPIP or IPV6, definitely not UDP.

Are you able to reduce this to a set of "ip xfrm" commands that I
can use to reproduce this?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

