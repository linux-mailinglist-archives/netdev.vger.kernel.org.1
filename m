Return-Path: <netdev+bounces-27347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1179A77B8AA
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 14:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C901C20AFD
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 12:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7E1947E;
	Mon, 14 Aug 2023 12:32:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D44BE57
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608F4C433C8;
	Mon, 14 Aug 2023 12:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692016355;
	bh=QnzWRnNKK5uh8+5h9+aNn1Xh8mCvGwZ7h5mZ+Vh7V2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BF+MX+kkQE77H349CSZnkMDZx2nLBtolzpnqPCAkFDuDhXMzqd3uedRGCh0PqrywD
	 EyaDJ+PO401mlsAlBwJYDdpKCG4C90F8vEDd3toW/wuUFss6eYDvhn6YlesY8TA03R
	 6bFpYItk2CgoATzv/y3a111jYGT5Pf/Kl1x66pY4AN8Wr79eqG8zS3GtA/oOKfadr4
	 SeFvjHhKtbO1UmJlnKLhLQAQPQ+Y0HzqFUZ4m8Ob8VZwt+GcChq1RTlBbkEEKKafWw
	 ki/Rn66pvtouyRGWp2EFoYAUDXhvGsmw9yM//fA39OpHhzVgXhSZbSb9mK8rhQwZu0
	 UetNgdOddFUJg==
Date: Mon, 14 Aug 2023 15:32:32 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] tun: add __exit annotations to module exit func
 tun_cleanup()
Message-ID: <20230814123232.GI3921@unreal>
References: <20230814083000.3893589-1-william.xuanziyang@huawei.com>
 <20230814101707.GG3921@unreal>
 <0b8a2c5f-0d53-f5e5-f148-b333c0c89a14@huawei.com>
 <20230814120515.GH3921@unreal>
 <b0cbdac5-9518-225f-a607-90431f36fa2d@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0cbdac5-9518-225f-a607-90431f36fa2d@huawei.com>

On Mon, Aug 14, 2023 at 08:23:37PM +0800, Ziyang Xuan (William) wrote:
> > On Mon, Aug 14, 2023 at 07:27:59PM +0800, Ziyang Xuan (William) wrote:
> >>> On Mon, Aug 14, 2023 at 04:30:00PM +0800, Ziyang Xuan wrote:
> >>>> Add missing __exit annotations to module exit func tun_cleanup().
> >>>>
> >>>> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> >>>> ---
> >>>>  drivers/net/tun.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>> index 973b2fc74de3..291c118579a9 100644
> >>>> --- a/drivers/net/tun.c
> >>>> +++ b/drivers/net/tun.c
> >>>> @@ -3740,7 +3740,7 @@ static int __init tun_init(void)
> >>>>  	return ret;
> >>>>  }
> >>>>  
> >>>> -static void tun_cleanup(void)
> >>>> +static void __exit tun_cleanup(void)
> >>>
> >>> Why __exit and not __net_exit?
> >>
> >> tun_cleanup() is a module exit function. it corresponds to tun_init().
> >> tun_init() uses __init, so tun_cleanup() uses __exit.
> > 
> > __net_init is equal to __init.
> 
> That is not. They are equal when CONFIG_NET_NS is not enabled.
> Refer to the definition of __net_init and __net_eixt in include/net/net_namespace.h.

Right, thanks
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

