Return-Path: <netdev+bounces-57455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C528131B7
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E071283361
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A3156B99;
	Thu, 14 Dec 2023 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZwrKFHQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7F056B8F
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 13:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1E3C433C8;
	Thu, 14 Dec 2023 13:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702561023;
	bh=dvBK9We3CPYr4AE1yccRlg8Tw9QtvTnCqUPcNQJh52Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sZwrKFHQWsE/xWJjQ5/x30BilaAeOvUZkrmvK4CZHpDEPYPKTTC95BzvpHB7FOSxR
	 A8NLgMgw0yfBU+n7TBnw6cf0Im2/Uj7ZHukCZ8u0g5iHL3iPF4MJteCDZmXrnnoIn7
	 lUJb50Fa2p3tv7yrf/EAJTi6a0ESqKy0YlbYXBlkARaXRvel8hxBZuL1bm2pXRyuHA
	 Q280aqbZi2qBQ9x45afi54SUH9Y+wPRZRcx2JMMbVq098Kwsh3h0vCElM7+fRrLFXU
	 txShjIPsgZxva8EzMZqrYgR+/KlycmDCb6ULkA316ekqdzW1I6c2OZ41rETN/xhLBY
	 Mrx5bB2GXZp4A==
Message-ID: <0b437b72-d9ee-478c-a838-ff8c27ec05d5@kernel.org>
Date: Thu, 14 Dec 2023 15:36:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 05/11] net: ethernet: am65-cpsw: cleanup
 TAPRIO handling
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
 r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com, horms@kernel.org,
 p-varis@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213110721.69154-1-rogerq@kernel.org>
 <20231213110721.69154-6-rogerq@kernel.org>
 <20231214112352.iaomw3apleewkdfz@skbuf>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231214112352.iaomw3apleewkdfz@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/12/2023 13:23, Vladimir Oltean wrote:
> On Wed, Dec 13, 2023 at 01:07:15PM +0200, Roger Quadros wrote:
>> +static int am65_cpsw_taprio_replace(struct net_device *ndev,
>> +				    struct tc_taprio_qopt_offload *taprio)
>>  {
>>  	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
>> +	struct netlink_ext_ack *extack = taprio->mqprio.extack;
>> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>>  	struct am65_cpts *cpts = common->cpts;
>> -	int ret = 0, tact = TACT_PROG;
>> +	struct am65_cpsw_est *est_new;
>> +	int ret, tact;
>>  
>> -	am65_cpsw_est_update_state(ndev);
>> +	if (!netif_running(ndev)) {
>> +		NL_SET_ERR_MSG_MOD(extack, "interface is down, link speed unknown");
>> +		return -ENETDOWN;
>> +	}
> 
> I haven't used the runtime PM API that this driver uses. I don't know
> much about how it works. What are the rules here? By checking for

The only rule is that if network interface is down, the device might be
runtime_suspended so we need to get it back to runtime_active before any
device access.

> netif_running(), are you intending to rely on the pm_runtime_resume_and_get()
> call from ndo_open(), which is released with pm_runtime_put() at
> ndo_stop() time?

Actually, this code is already present upstream. I'm only moving it around
in this patch.

Based on the error message and looking at am65_cpsw_est_check_scheds() and
am65_cpsw_est_set_sched_list() which is called later in am65_cpsw_taprio_replace(),
both of which eventually call am65_est_cmd_ns_to_cnt() which expects valid link_speed,
my understanding is that the author intended to have a valid link_speed before
proceeding further.

Although it seems netif_running() check isn't enough to have valid link_speed
as the link could still be down even if the netif is brought up.

Another gap is that in am65_cpsw_est_link_up(), if link was down for more than 1 second
it just abruptly calls am65_cpsw_taprio_destroy().

So I think we need to do the following to improve taprio support in this driver:
1) accept taprio schedule irrespective of netif/link_speed status
2) call pm_runtime_get()/put() before any device access regardless of netif/link_speed state
3) on link_up when if have valid link_speed and taprio_schedule, apply it.
4) on link_down, destroy the taprio schedule form the controller.

But my concern is, this is a decent amount of work and I don't want to delay this series.
My original subject of this patch series was mpqrio/frame-preemption/coalescing. ;)

Can we please defer taprio enhancement to a separate series? Thanks!

> 
> I see some inconsistencies I don't quite understand.
> 
> am65_cpsw_nuss_ndo_slave_add_vid() checks for netif_running() then calls
> pm_runtime_resume_and_get() anyway.
> 
> am65_cpsw_setup_mqprio() allows changing the offload even when the link
> is down (which is more user-friendly anyway) and performs the pm_runtime_get_sync()
> call itself.
> 
>> -}

-- 
cheers,
-roger

