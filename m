Return-Path: <netdev+bounces-44690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B064E7D93C9
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 11:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2A4C1C20F29
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 09:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470CE15AE5;
	Fri, 27 Oct 2023 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A8915E8B
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 09:35:06 +0000 (UTC)
X-Greylist: delayed 1375 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Oct 2023 02:35:03 PDT
Received: from good-out-13.clustermail.de (good-out-13.clustermail.de [IPv6:2a02:708:0:1ed::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E1BD6
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 02:35:03 -0700 (PDT)
Received: from [10.0.0.6] (helo=frontend.clustermail.de)
	by smtpout-03.clustermail.de with esmtp (Exim 4.96)
	(envelope-from <Daniel.Klauer@gin.de>)
	id 1qwIst-0006y8-38;
	Fri, 27 Oct 2023 11:12:04 +0200
Received: from [217.6.33.237] (helo=Win2012-02.gin-domain.local)
	by frontend.clustermail.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
	(Exim 4.96)
	(envelope-from <Daniel.Klauer@gin.de>)
	id 1qwIst-0001wQ-1v;
	Fri, 27 Oct 2023 11:12:04 +0200
Received: from [10.176.8.59] (10.176.8.59) by Win2012-02.gin-domain.local
 (10.160.128.12) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 27 Oct
 2023 11:12:03 +0200
Message-ID: <a51a5f27-6f84-450e-a1c5-233a9d4af12a@gin.de>
Date: Fri, 27 Oct 2023 11:12:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug] dpaa2-eth: "Wrong SWA type" and null deref in
 dpaa2_eth_free_tx_fd()
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <30428046-fe1a-be57-1df6-2830bd33a385@gin.de>
 <20231013155203.kib4nowqvhtcv5ak@LXL00007.wbi.nxp.com>
Content-Language: en-US
From: Daniel Klauer <daniel.klauer@gin.de>
In-Reply-To: <20231013155203.kib4nowqvhtcv5ak@LXL00007.wbi.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.176.8.59]
X-ClientProxiedBy: Win2012-02.gin-domain.local (10.160.128.12) To
 Win2012-02.gin-domain.local (10.160.128.12)
X-EsetResult: clean, is OK
X-EsetId: 37303A29342AAB58667760

On 13.10.23 17:52, Ioana Ciornei wrote:
> Thanks for the test program! I was able to reproduce the issue fairly easily.
> 
> I still do not know the root cause but it seems to always happen with
> frames which are not 64 bytes aligned. I am afraid that the memory is
> somehow corrupted between Tx and Tx conf.
> 
> The driver already has a PTR_ALIGN call in dpaa2_eth_build_single_fd()
> but if there is not enough space in the skb's headroom then it will just
> go ahead without it.
> 
> Attached you will find 2 patches which make the 64 bytes alignment a
> must. With these patches applied onto net-next I do not see the issue
> anymore.
> 
> Could you please also test on your side?

After applying the two patches, the test program runs without crashing.
The "wrong SWA type" warning is gone too. As before I've tested this with
our v6.1 and v6.5 kernels. Thanks!

> 
> In the meantime, I will search internally for some more information on
> the Tx alignment restrictions in DPAA2 and whether or not they are only
> "nice to have" as the comment below suggests.
> 
>         /* If there's enough room to align the FD address, do it.
>          * It will help hardware optimize accesses.
>          */
> 

