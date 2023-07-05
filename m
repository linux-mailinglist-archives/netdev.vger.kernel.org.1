Return-Path: <netdev+bounces-15542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C381E74852F
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 15:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76184280FEB
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 13:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5CDC8F3;
	Wed,  5 Jul 2023 13:40:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD49C8F1
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 13:40:37 +0000 (UTC)
Received: from smtp.missinglinkelectronics.com (smtp.missinglinkelectronics.com [162.55.135.183])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716139F
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 06:40:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by smtp.missinglinkelectronics.com (Postfix) with ESMTP id A0B5B20623;
	Wed,  5 Jul 2023 15:40:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at missinglinkelectronics.com
Received: from smtp.missinglinkelectronics.com ([127.0.0.1])
	by localhost (mail.missinglinkelectronics.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yeu7sfGY0gLH; Wed,  5 Jul 2023 15:40:30 +0200 (CEST)
Received: from 0.0.0.0 (p578c5bfe.dip0.t-ipconnect.de [87.140.91.254])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: joachim)
	by smtp.missinglinkelectronics.com (Postfix) with ESMTPSA id DA06A2011C;
	Wed,  5 Jul 2023 15:40:29 +0200 (CEST)
Message-ID: <ed966750-482e-50e3-7c27-028e135d3208@missinglinkelectronics.com>
Date: Wed, 5 Jul 2023 15:40:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: Fix special case of empty range in
 find_next_netdev_feature()
Content-Language: de-DE, en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>
References: <20230623142616.144923-1-joachim.foerster@missinglinkelectronics.com>
 <20230626141739.54d78c7e@kernel.org>
From: =?UTF-8?Q?Joachim_F=c3=b6rster?=
 <joachim.foerster@missinglinkelectronics.com>
In-Reply-To: <20230626141739.54d78c7e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,RCVD_HELO_IP_MISMATCH,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/26/23 23:17, Jakub Kicinski wrote:
> On Fri, 23 Jun 2023 16:26:16 +0200 Joachim Foerster wrote:
>> Fixes: 85db6352fc8a ("net: Fix features skip in for_each_netdev_feature()")
>> Cc: stable@vger.kernel.org
> Nothing passes @feature with bit 0 set upstream, tho, right?
> Fix looks fine, but it doesn't need the fixes tag and CC stable,
> since its theoretical/forward looking.
We are triggering this issue by using the inline function 
for_each_netdev_feature() from the kernel header files in a custom 
module running on a stable kernel involving NETIF_F_SG, which happens to 
be bit 0. So my argument is that the function is part of the public API. 
Or is this actually not supposed to be treated like it is public API? 
Does this statement change the assessment in terms of tagging with CC 
stable?

Regarding the Fixes tag, I think, I made a mistake, since the previous 
commit 3b89ea9c5902 ("net: Fix for_each_netdev_feature on Big endian") 
on find_next_netdev_feature() already causes the issue by not 
considering the special case of bit 0. So I will repost with fixes tag 
updated ...

>
> Please repost explaining how we can hit this problem upstream
> or with the Fixes/CC stable replaced by a sentence stating that
> the problem can't currently be triggered.


-- 
Joachim Förster

Missing Link Electronics
http://www.missinglinkelectronics.com
Office DE: +49 (731) 141-149-0
Office US: +1  (408) 457-0700


