Return-Path: <netdev+bounces-48124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 564A77EC9E5
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DFD8280EBB
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 17:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2533EA94;
	Wed, 15 Nov 2023 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Op6umecg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31683BB49
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 17:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1285C433C7;
	Wed, 15 Nov 2023 17:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700070600;
	bh=n0s6JumETlN+9n/hXQMQBMbeMTivYx2zxD8T9/2FEpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Op6umecgS3kdGWXBPIQpr8QXahiAFcCYy6QB5H+/XLhqNdBrq4j+/oPyrekch31qW
	 95PAB/l7naHebPdSa1/MmVUSH0vKETCAJrB3bInfAJglI6hWRCxevUVwHiV7k9Dazt
	 hIWqP0aG/MhdnyVzcOyU0vM/REHR4zLNBTfXDCREroLNbjT7IoCoBAvu+CT+HANirC
	 FrHsUbyXNvgUVOcQz4nmU9C9bipVhmq96yy6g+ggN4nXC+eB8X+EXocA9Xu9shCTYI
	 lhiMowGhh+Fy2by9cTTHHUX2NdQMaV3e8PVQMg9eBFk4NeN66j7/ID8/Axs6ROaUJW
	 XrUFWb/gZ1ZPg==
Date: Wed, 15 Nov 2023 17:49:55 +0000
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, j.vosburgh@gmail.com, andy@greyhouse.net,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next,v3] bonding: use WARN_ON instead of BUG in
 alb_upper_dev_walk
Message-ID: <20231115174955.GV74656@kernel.org>
References: <20231115115537.420374-1-shaozhengchao@huawei.com>
 <ZVTUL4QByIyGyfDP@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVTUL4QByIyGyfDP@nanopsycho>

On Wed, Nov 15, 2023 at 03:22:39PM +0100, Jiri Pirko wrote:
> Wed, Nov 15, 2023 at 12:55:37PM CET, shaozhengchao@huawei.com wrote:
> >If failed to allocate "tags" or could not find the final upper device from
> >start_dev's upper list in bond_verify_device_path(), only the loopback
> >detection of the current upper device should be affected, and the system is
> >no need to be panic.
> >
> >Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> >---
> >v3: return -ENOMEM instead of zero to stop walk
> >v2: use WARN_ON_ONCE instead of WARN_ON
> 
> Yet the WARN_ON is back :O

Hi Jiri,

I think the suggestion was to either:

1. WARN_ON_ONCE(); return 0;      <= this was v2
2. WARN_ON(); return -ESOMETHING; <= this is v3
(But not, WARN_ON(); return 0;    <= this was v1)

And after v2 it was determined that the approach taken here in v3 is
preferred.

So I think this patch is consistent with the feedback given by Jay
in his reviews so far.

> 
> 
> >---
> > drivers/net/bonding/bond_alb.c | 6 ++++--
> > 1 file changed, 4 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
> >index dc2c7b979656..21f1cb8e453b 100644
> >--- a/drivers/net/bonding/bond_alb.c
> >+++ b/drivers/net/bonding/bond_alb.c
> >@@ -984,8 +984,10 @@ static int alb_upper_dev_walk(struct net_device *upper,
> > 	 */
> > 	if (netif_is_macvlan(upper) && !strict_match) {
> > 		tags = bond_verify_device_path(bond->dev, upper, 0);
> >-		if (IS_ERR_OR_NULL(tags))
> >-			BUG();
> >+		if (IS_ERR_OR_NULL(tags)) {
> >+			WARN_ON(1);
> >+			return -ENOMEM;
> >+		}
> > 		alb_send_lp_vid(slave, upper->dev_addr,
> > 				tags[0].vlan_proto, tags[0].vlan_id);
> > 		kfree(tags);
> >-- 
> >2.34.1
> >
> >
> 

