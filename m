Return-Path: <netdev+bounces-181676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED30AA86128
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 16:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14405446826
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 14:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8B71F8747;
	Fri, 11 Apr 2025 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpoUVj5R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E401F7575;
	Fri, 11 Apr 2025 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744383459; cv=none; b=bt9mgwIDqkDmVwsLEY62BquriJ75eYCp+Q/jKoWZ+ORdGA+VkiG/ShhyaI7Qv8wm+iQgVOzhP1LsbaFct4KYmQRLhrqp9Z9WRDTok3XD2yUtUqisqfRpzUh6R4ZtInDVkIiIRaE69ntrno5qqa/slqL3MFr1JwKiN+AW91vnIGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744383459; c=relaxed/simple;
	bh=XMYmtaaUQ2VVNlPLM1fOfKTQ9pdUuVLK4wYq6Ebg3/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gamdp99WavqvwWpA2fDwwLulR+xSZi3mWZd1yn/aTfS7IalvrhbYRtpoIPvNoz4X9maHWh3bXp31g087DXcUok6qvNsXRHqHRUh7+DCA8c34ry6ghdfHDAuKTi3EpRInmeImwRzWh+59YUGFoG0I+wq0SXQGUzHpeqJ5SQccSjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpoUVj5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE926C4CEE2;
	Fri, 11 Apr 2025 14:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744383459;
	bh=XMYmtaaUQ2VVNlPLM1fOfKTQ9pdUuVLK4wYq6Ebg3/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hpoUVj5R8bwYr3FUIpQqIZzXGSG1gqA0s3uniEizYS6gGVkzLFl9o1YMAjSU0HFPP
	 aZGyVGcsjDtA6OiYmx4sJmPaggmXqskJZzDO8FQiEh0ByqFnyfUBnSd9iIiuSb/GUe
	 ZV4t7OH1rK/OTAoqLb8YCPxnUU3Tt7vEi8ePZDL8ZU+w4hhbGaJlXin6pdlEQ5tlM6
	 DxTQ1Vi2NTzYIk8IaVioZ2JSvHzbLvMv8p0Vm/P6l0ZGHkIewgJWf/mLDIK+9PV9jC
	 4DXtOHmaSs+42z+mWG98XLvpP7Gxm5EVw4sGSidGJjVZRDyHAiUTjMYExej30FnRC4
	 0cZYYgA6VaCfw==
Date: Fri, 11 Apr 2025 15:57:34 +0100
From: Simon Horman <horms@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Abdun Nihaal <abdun.nihaal@gmail.com>, netdev@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
	Vishal Kulkarni <vishal@chelsio.com>
Subject: Re: [PATCH net-next] cxgb4: fix memory leak in
 cxgb4_init_ethtool_filters() error path
Message-ID: <20250411145734.GH395307@horms.kernel.org>
References: <20250409054323.48557-1-abdun.nihaal@gmail.com>
 <5cb34dde-fb40-4654-806f-50e0c2ee3579@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5cb34dde-fb40-4654-806f-50e0c2ee3579@web.de>

On Wed, Apr 09, 2025 at 05:47:46PM +0200, Markus Elfring wrote:
> …
> > +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
> > @@ -2270,6 +2270,7 @@ int cxgb4_init_ethtool_filters(struct adapter *adap)
> >  		eth_filter->port[i].bmap = bitmap_zalloc(nentries, GFP_KERNEL);
> >  		if (!eth_filter->port[i].bmap) {
> >  			ret = -ENOMEM;
> > +			kvfree(eth_filter->port[i].loc_array);
> >  			goto free_eth_finfo;
> >  		}
> >  	}
> 
> How do you think about to move the shown error code assignment behind the mentioned label
> (so that another bit of duplicate source code could be avoided)?

Hi Markus,

If you mean something like the following. Then I agree that it
is both in keeping with the existing error handling in this function
and addresses the problem at hand.

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
index 7f3f5afa864f..df26d3388c00 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
@@ -2270,13 +2270,15 @@ int cxgb4_init_ethtool_filters(struct adapter *adap)
                eth_filter->port[i].bmap = bitmap_zalloc(nentries, GFP_KERNEL);
                if (!eth_filter->port[i].bmap) {
                        ret = -ENOMEM;
-                       goto free_eth_finfo;
+                       goto free_eth_finfo_loc_array;
                }
        }

        adap->ethtool_filters = eth_filter;
        return 0;

+free_eth_finfo_loc_array:
+       kvfree(eth_filter->port[i].loc_array);
 free_eth_finfo:
        while (i-- > 0) {
                bitmap_free(eth_filter->port[i].bmap);


> 
> Regards,
> Markus
> 

