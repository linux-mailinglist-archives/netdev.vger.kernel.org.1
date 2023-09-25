Return-Path: <netdev+bounces-36148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA59E7AD9EF
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 16:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 633022812B6
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 14:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C611BDF5;
	Mon, 25 Sep 2023 14:18:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1432D1BDE5
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 14:18:06 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63600C0;
	Mon, 25 Sep 2023 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cNj/1QTokK7I0cKqSzFBGsx18N2Q64mg0Luc+HnEFsQ=; b=VlXolq9fDCkQvT2KnSnK2Yc5RE
	592RSNzfFH6Fxw+qg4+RL/LxHWW/ueJj0VnIbgInkIDjhUyvCjmSe/453VJ2ZMtevC0ERW0+LXs87
	YWlsmZtSA+Lr9kTEvszBrx1aGJMz5UsUCaJ5iMkGa0oYTK1oTyrVMzf3TCpInRKsS9kk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qkmPF-007Srt-Ak; Mon, 25 Sep 2023 16:17:49 +0200
Date: Mon, 25 Sep 2023 16:17:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Tam Nguyen <tam.nguyen.xa@renesas.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH net] net: ethernet: renesas: rswitch Fix PHY station
 management clock setting
Message-ID: <7156d89e-ef72-487f-b7ce-b08be461ec1c@lunn.ch>
References: <20230925003416.3863560-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925003416.3863560-1-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 09:34:16AM +0900, Yoshihiro Shimoda wrote:
> From: Tam Nguyen <tam.nguyen.xa@renesas.com>
> 
> Fix the MPIC.PSMCS value following the programming example in the
> section 6.4.2 Management Data Clock (MDC) Setting, Ethernet MAC IP,
> S4 Hardware User Manual Rev.1.00.
> 
> The value is calculated by
>     MPIC.PSMCS = clk[MHz] / ((MDC frequency[MHz] + 1) * 2)
> with the input clock frequency of 320MHz and MDC frequency of 2.5MHz.
> Otherwise, this driver cannot communicate PHYs on the R-Car S4 Starter
> Kit board.

If you run this calculation backwards, what frequency does
MPIC_PSMCS(0x3f) map to?

Is 320MHz really fixed? For all silicon variants? Is it possible to do
a clk_get_rate() on a clock to get the actual clock rate?

	Andrew

