Return-Path: <netdev+bounces-22087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B81B76604E
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 01:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9851C21734
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 23:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5971DA5D;
	Thu, 27 Jul 2023 23:48:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD483E57A
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 23:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB57C433C7;
	Thu, 27 Jul 2023 23:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690501702;
	bh=leAC5f+fPlZ/cfu7jAxbCYBzhzOHtZlQG/UH+1WwYJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k0s7B5clwMRIUnKXxzjuwBkCWS4MLUNGeaj8MCrix0Inaxm9GcXL01oJrC+TDOlTg
	 ArMX+warqSug5XXdNKHTZ+WX+q0fXx7DfyExGtR38N4NQkgnDQN334EWobNwkDFXzh
	 9lruDdJRfoyOwZBR3iYUL0anjcSSh/ouNhV9UhGYauq3idrDurIAb9ZJGOUDNezQ+h
	 TT2BJYT6OMZ4L+TjeYbUMLrDuNN8QjsnvgmKLIPThgDbfVxf5MZ9mL/SZXfVU8E+uG
	 R1SMBWAVNuHQNbUcS4otOrKg7FPdPx2r52OeUp59iL+dspB9gSnzatRN0Z0Mv+/yoZ
	 P4ezf3AdhlvcA==
Date: Thu, 27 Jul 2023 16:48:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: Paolo Abeni <pabeni@redhat.com>, Zheng Wang <zyytlz.wz@163.com>,
 <lee@kernel.org>, <linyunsheng@huawei.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <richardcochran@gmail.com>,
 <p.zabel@pengutronix.de>, <geert+renesas@glider.be>,
 <magnus.damm@gmail.com>, <yoshihiro.shimoda.uh@renesas.com>,
 <biju.das.jz@bp.renesas.com>, <wsa+renesas@sang-engineering.com>,
 <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <hackerzheng666@gmail.com>,
 <1395428693sheep@gmail.com>, <alex000young@gmail.com>
Subject: Re: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
Message-ID: <20230727164820.48c9e685@kernel.org>
In-Reply-To: <607f4fe4-5a59-39dd-71c2-0cf769b48187@omp.ru>
References: <20230725030026.1664873-1-zyytlz.wz@163.com>
	<20230725201952.2f23bb3b@kernel.org>
	<9cfa70cca3cb1dd20bb2cab70a213e5a4dd28f89.camel@redhat.com>
	<607f4fe4-5a59-39dd-71c2-0cf769b48187@omp.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jul 2023 21:48:41 +0300 Sergey Shtylyov wrote:
> >> Still racy, the carrier can come back up after canceling the work.  
> > 
> > I must admit I don't see how/when this driver sets the carrier on ?!?  
> 
>    The phylib code does it for this MAC driver, see the call tree of
> phy_link_change(), on e.g. https://elixir.bootlin.com/linux/v6.5-rc3/source/...
> 
> >> But whatever, this is a non-issue in the first place.  
> > 
> > Do you mean the UaF can't happen? I think that is real.   
> 
>    Looks possible to me, at least now... and anyway, shouldn't we clean up
> after ourselves if we call schedule_work()?However my current impression is
> that cancel_work_sync() should be called from ravb_close(), after calling
> phy_{stop|disconnect}()...
>
> >> The fact that ravb_tx_timeout_work doesn't take any locks seems much
> >> more suspicious.  
> > 
> > Indeed! But that should be a different patch, right?  
> 
>    Yes.
> 
> > Waiting a little more for feedback from renesas.  
> 
>    Renesas historically hasn't shown much interest to reviewing the sh_eth/ravb
> driver patches, so I took that task upon myself. I also happen to be a nominal
> author of this driver... :-)

Simplest fix I can think of is to take a reference on the netdev before
scheduling the work, and then check if it's still registered in the work
itself. Wrap the timeout work in rtnl_lock() to avoid any races there.

