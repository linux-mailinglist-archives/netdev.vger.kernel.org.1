Return-Path: <netdev+bounces-132220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8C9991008
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648AA1F2714B
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E466231C94;
	Fri,  4 Oct 2024 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6RWkwW+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738D3231C93;
	Fri,  4 Oct 2024 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728071445; cv=none; b=P+BHIktevKmfqpsP9t26BNs3OX6jVN2Ih59cDj/fsVRzURu2elChPCrFcRUtokhOjr2grHFea5TQGiMi4mf6cPdJybAWpmLH9Q4u/vw6t1Qe/RoB7hWr4lBw30fYwX+bb0Xuk29sg8f3fe4hopTddjQHmI+Nys0NDmm3VVnSrxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728071445; c=relaxed/simple;
	bh=SvQmEK73Iauaibm9H5yENY81Kh+90v+wpP0MuGa3eHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRqOUbLe7wBtyB43/bE6dYHOUJ5mXN+qxL6HSmX0ChDJo1sSwuTtZjhhLx3nLqHm0simXB8tmANep0dDoTpQRlsMc+Nkx/Cq0rhlStPI194YajXjV6G5ejjtCPe6iKVRqVbw9oI4k6KKNMydsEqbUtlKkA/m6zfNsWxxxDbAapY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6RWkwW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0921C4CEC6;
	Fri,  4 Oct 2024 19:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728071445;
	bh=SvQmEK73Iauaibm9H5yENY81Kh+90v+wpP0MuGa3eHI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k6RWkwW+joiajpbMGmrG9Cp1DLrQk1fKbmuMQBZkZg3LLQJor2ZwZxBA98m5IqwB0
	 /zZ1fF19XXE8G91PuIOzPdNeJKlb1AvYAyHLFYrTuCb8eILS9Y9nuy8eBxeCiJ6DLD
	 LMgoo8lZQGYkdGfkq5maYsSN/YjNUtVuqjhoypLDeLO9k9zvry/Fy7PIEKXsN4bb8e
	 k1Dqn6IziERplqlPy7IoupfLjtX57yo66C7EgLe2U87fvfkhfOour6NmGqfyG6LztU
	 dxgIhXFG7ypQ0GYLX+jxUJP5Jw+6x9SUfTae6URYdDXEDMh2REZ4WrIQ2wwDrJ36Mh
	 9FythXHgmn97A==
Message-ID: <f41f65bd-104c-44de-82a2-73be59802d96@kernel.org>
Date: Fri, 4 Oct 2024 22:50:40 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] net: ethernet: ti: am65-cpsw: avoid
 devm_alloc_etherdev, fix module removal
To: Nicolas Pitre <nico@fluxnic.net>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Grygorii Strashko
 <grygorii.strashko@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241004041218.2809774-1-nico@fluxnic.net>
 <20241004041218.2809774-3-nico@fluxnic.net>
 <b055cea5-6f03-4c73-aae4-09b5d2290c29@kernel.org>
 <s5000qsr-8nps-87os-np52-oqq6643o35o2@syhkavp.arg>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <s5000qsr-8nps-87os-np52-oqq6643o35o2@syhkavp.arg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/10/2024 18:37, Nicolas Pitre wrote:
> On Fri, 4 Oct 2024, Roger Quadros wrote:
> 
>> Hi Nicolas,
>>
>> On 04/10/2024 07:10, Nicolas Pitre wrote:
>>> From: Nicolas Pitre <npitre@baylibre.com>
>>>
>>> Usage of devm_alloc_etherdev_mqs() conflicts with
>>> am65_cpsw_nuss_cleanup_ndev() as the same struct net_device instances
>>> get unregistered twice. Switch to alloc_etherdev_mqs() and make sure
>>
>> Do we know why the same net device gets unregistered twice?
> 
> When using devm_alloc_etherdev_mqs() every successful allocation is put 
> in a resource list tied to the device. When the driver is removed, 
> there's a net device unregister from am65_cpsw_nuss_cleanup_ndev() and 
> another one from devm_free_netdev().

I couldn't find out where devm_free_netdev() calls unregister_netdev().
Also we didn't use devm_register_netdev() so resource manager will not
call unregister_netdev().

> 
> We established in patch #1 that net devices must be unregistered before 
> devlink_port_unregister() is invoked, meaning we can't rely on the 
> implicit devm_free_netdev() as it happens too late, hence the explicit 
> am65_cpsw_nuss_cleanup_ndev().
> 
>>> am65_cpsw_nuss_cleanup_ndev() unregisters and frees those net_device
>>> instances properly.
>>>
>>> With this, it is finally possible to rmmod the driver without oopsing
>>> the kernel.
>>>
>>> Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
>>> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
>>> ---
>>>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 20 ++++++++++++--------
>>>  1 file changed, 12 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>>> index f6bc8a4dc6..e95457c988 100644
>>> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>>> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>>> @@ -2744,10 +2744,9 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
>>>  		return 0;
>>>  
>>>  	/* alloc netdev */
>>> -	port->ndev = devm_alloc_etherdev_mqs(common->dev,
>>> -					     sizeof(struct am65_cpsw_ndev_priv),
>>> -					     AM65_CPSW_MAX_QUEUES,
>>> -					     AM65_CPSW_MAX_QUEUES);
>>> +	port->ndev = alloc_etherdev_mqs(sizeof(struct am65_cpsw_ndev_priv),
>>> +					AM65_CPSW_MAX_QUEUES,
>>> +					AM65_CPSW_MAX_QUEUES);
>>
>> Can we solve this issue without doing this change as
>> there are many error cases relying on devm managed freeing of netdev.
> 
> If you know of a way to do this differently I'm all ears.

I sent another approach already. please check.
https://lore.kernel.org/all/67c9ede4-9751-4255-b752-27dd60495ff3@kernel.org/

> 
> About the many error cases needing the freeing of net devices, as far as 
> I know they're all covered with this patch.

No they are not. you now have to explicitly call free_netdev() in error paths of am65_cpsw_nuss_init_port_ndev().
I see 3 places directly returning error code.
i.e.
        default:
                dev_err(dev, "selected phy-mode is not supported\n");
                return -EOPNOTSUPP;
        }
...
        if (IS_ERR(phylink))
                return PTR_ERR(phylink);
...
        ndev_priv->stats = netdev_alloc_pcpu_stats(struct am65_cpsw_ndev_stats);
        if (!ndev_priv->stats)
                return -ENOMEM;

> 
>> I still can't see what we are doing wrong in existing code.
> 
> Did you try to rmmod this driver lately?

Yes and it throws an oops, so we do need a fix.
> 
> 
> Nicolas

-- 
cheers,
-roger

