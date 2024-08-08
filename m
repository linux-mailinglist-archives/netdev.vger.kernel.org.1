Return-Path: <netdev+bounces-116876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63D694BED4
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9823F1F22216
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC713148307;
	Thu,  8 Aug 2024 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9h4wjy2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A6A63D
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723125151; cv=none; b=MJkuwpXSC3nOeh4Q9w77Av2A+IGgKsfP4CtEFbzJZ0FEDE99sNJNMGKUyQTyC7R5XeQk/hA1BoJOne67TFss0bZwHTbEovMfg05p5i+S7mNqzWmJisyAE5AC3Rr1CfJKr3pn/IMO65eKFlhxJRDcTlEOUoZhd9vrafGDooL21ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723125151; c=relaxed/simple;
	bh=wFyFcx/mm1Nsd/3gDjiCbhCXx9zjXCrOWuYKeuUaEKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkajT4KJEKfkZ+Ih/MRNeTkaJnbPzUNk5o3jXkSQwm31XneBAqqe5oAq8FX8BcrYQyAxtPGI1TqHJ2l2xNYXLYgrmzgOUUFDeO4DyPt7mkxbet8c1SP7mcEuPqhZUcrqXYefOXjzJ0E7d6U45bCeC4VpgWD7VJLr7I16PCEYWII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9h4wjy2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E66DC32782;
	Thu,  8 Aug 2024 13:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723125150;
	bh=wFyFcx/mm1Nsd/3gDjiCbhCXx9zjXCrOWuYKeuUaEKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O9h4wjy2gpztoL6Zf+2SobETADA1WWvIUdU9+4ATChtAy2BaeNsDh/Gzt0G0ZXFcN
	 5vhrumTlenNgkYRHL662hQF7GF/HipkaBa3cNxy6Q3BnE8clZJDxSUzp+QgGQ0Y+Qr
	 j79koKFPaZqncxP36MYTIVqFngaZQ2qv5bYB4DjjnPn+GvpdDmpUjfiemkRSfcc+t6
	 2O9ZYWGUcyXCEa0g2WYyyXz1tjZokrgTiA1k9aiEmXiTTXOPwxPSprPnc818W7TUid
	 zxMDHSyhP4El6mjsY8zhK7w0WKOZgszq7WN4uuNt1sl4NqAzmqXUCWMiyTbajYNf+v
	 p+0MxmDE76TRA==
Date: Thu, 8 Aug 2024 06:52:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Jesper Dangaard Brouer <hawk@kernel.org>, Alexander
 Duyck <alexander.duyck@gmail.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [RFC net] net: make page pool stall netdev unregistration to
 avoid IOMMU crashes
Message-ID: <20240808065228.4188e5d3@kernel.org>
In-Reply-To: <CAC_iWj+G_Rrqw8R5PR3vZsL5Oid+_tzNOLOg6Hoo1jt3vhGx5A@mail.gmail.com>
References: <20240806151618.1373008-1-kuba@kernel.org>
	<CAC_iWj+G_Rrqw8R5PR3vZsL5Oid+_tzNOLOg6Hoo1jt3vhGx5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Aug 2024 14:12:34 +0300 Ilias Apalodimas wrote:
> In any case why do you want to hold on the IOMMU? The network
> interface -- at least in theory -- should be down and we wont be
> processing any more packets.

I should have you a link to Yonglong's report:

https://lore.kernel.org/all/8743264a-9700-4227-a556-5f931c720211@huawei.com/

we get_device() hoping that it will keep the IOMMU machinery active
(even if the device won't use the page we need to unmap it when it's
freed), but it sounds like IOMMU dies when driver is unbound. Even if
there are outstanding references to the device.

I occasionally hit this problem reloading drivers during development,
TBH, too. And we have been told we "use the API wrong" so let's fix
it on our end?..

