Return-Path: <netdev+bounces-57472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF40813238
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 736F4B219B3
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CEB57866;
	Thu, 14 Dec 2023 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSKwAdCm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FF34F216
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 13:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462A0C433C8;
	Thu, 14 Dec 2023 13:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702561989;
	bh=ndDApgMv3pICtu5pbie5/BjN4F0Jmr+sMJasLI/mjZc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WSKwAdCm8j2HYsavwwRM8lrXYWX8I8GD0anvlbmKmBR9PkfZyopysMhxDGLGFIDR4
	 zMBUvrRLiKc8sZcrJ1eTKtgtgzdMkzYh4PLQUEV9IPZYJrUkkoZI0Gu87hAvZ0ZwmU
	 N04VdcOb4DmOLgtYXUELrgjp1CjjVKX/goZ6dVV5SdafKLHMKvYcFWVljA4lOZjEDT
	 /jhG9nisPI7oUmkA1ftdfNenSQjhN218hlmGeIAoIk66J3Aa5Sm5DxJ4LXUW9MCn2v
	 gZ6lcSZBkizaWsi8w8Icu7csNzRT+Wm/3StH2q5UIjZPeqWtOr20wXrOYn9hz1gbLu
	 Invtiqeoj1F+w==
Message-ID: <6a8bde60-1a76-4951-b20e-dd38d93b1918@kernel.org>
Date: Thu, 14 Dec 2023 15:50:53 +0200
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
 <0b437b72-d9ee-478c-a838-ff8c27ec05d5@kernel.org>
 <20231214134131.ecww24rt7socuplt@skbuf>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231214134131.ecww24rt7socuplt@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/12/2023 15:41, Vladimir Oltean wrote:
> On Thu, Dec 14, 2023 at 03:36:57PM +0200, Roger Quadros wrote:
>> Actually, this code is already present upstream. I'm only moving it around
>> in this patch.
>>
>> Based on the error message and looking at am65_cpsw_est_check_scheds() and
>> am65_cpsw_est_set_sched_list() which is called later in am65_cpsw_taprio_replace(),
>> both of which eventually call am65_est_cmd_ns_to_cnt() which expects valid link_speed,
>> my understanding is that the author intended to have a valid link_speed before
>> proceeding further.
>>
>> Although it seems netif_running() check isn't enough to have valid link_speed
>> as the link could still be down even if the netif is brought up.
>>
>> Another gap is that in am65_cpsw_est_link_up(), if link was down for more than 1 second
>> it just abruptly calls am65_cpsw_taprio_destroy().
>>
>> So I think we need to do the following to improve taprio support in this driver:
>> 1) accept taprio schedule irrespective of netif/link_speed status
>> 2) call pm_runtime_get()/put() before any device access regardless of netif/link_speed state
>> 3) on link_up when if have valid link_speed and taprio_schedule, apply it.
>> 4) on link_down, destroy the taprio schedule form the controller.
>>
>> But my concern is, this is a decent amount of work and I don't want to delay this series.
>> My original subject of this patch series was mpqrio/frame-preemption/coalescing. ;)
>>
>> Can we please defer taprio enhancement to a separate series? Thanks!
> 
> Ok, sounds fair to have some further taprio clean-up scheduled for later.
> I would also add taprio_offload_get() to the list of improvements that
> could be made.

Noted. Thanks!

-- 
cheers,
-roger

