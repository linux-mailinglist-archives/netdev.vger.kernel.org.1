Return-Path: <netdev+bounces-25458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0BD77426A
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9BB2816D5
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E322D14F87;
	Tue,  8 Aug 2023 17:44:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79D414F7C
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 17:44:35 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F9C21E7F
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 10:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=H4KnvWUgvi3LsDxgjze5WSJwUO0zv/U5QpcYXEsZsDQ=; b=QAe4q24k+cS/lG8y6UhWFdP9Of
	qZl4qF5NrnuC4VJo6b2v9pz0aTbn+msg78xSm3BXZ+06w/F+66acDXcU2t79VkT4UNW/tPAHdr+hN
	Lh+/dM2b/lL7kAEdZRh5kw5etq3qV6kf3WLzHUnqa3Tdq/oPJGx2Ze7y2bpaPk1o4J63UFGkwk9vB
	HrbXkCWcERfIsf4aFGN3bY9lGO9ay0ZStySZqCRwVvd/uiVMOJ6vfmVjoEYDtqAfQqHaKTVfQIX8u
	SISe4qWnRSUuEvvfAtlwyos1JLvkACMofuEB5cEynsyWLSmtUOituSpr0r1MBrHRYReRfcWlVcKsT
	TtT3jhZw==;
Received: from 108-90-42-56.lightspeed.sntcca.sbcglobal.net ([108.90.42.56] helo=[192.168.1.80])
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qTQZA-004wq0-36;
	Tue, 08 Aug 2023 17:32:21 +0000
Message-ID: <0a0249e9-c408-696c-1ee1-c74b053c488b@infradead.org>
Date: Tue, 8 Aug 2023 10:32:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] net/ps3_gelic_net: Use ether_addr_to_u64() to
 convert ethernet address
To: Li Zetao <lizetao1@huawei.com>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20230808114050.4034547-1-lizetao1@huawei.com>
Content-Language: en-US
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <20230808114050.4034547-1-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 8/8/23 04:40, Li Zetao wrote:
> Use ether_addr_to_u64() to convert an Ethernet address into a u64 value,
> instead of directly calculating, as this is exactly what
> this function does.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  drivers/net/ethernet/toshiba/ps3_gelic_net.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

I tested this on PS3 and it seems to be working OK.
Thanks for your contribution.

Tested-by: Geoff Levand <geoff@infradead.org>


