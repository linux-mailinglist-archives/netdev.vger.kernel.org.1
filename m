Return-Path: <netdev+bounces-215927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BFAB30EF8
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 08:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93B197B41E0
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 06:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565512DE6E2;
	Fri, 22 Aug 2025 06:32:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037E02D77E4;
	Fri, 22 Aug 2025 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755844347; cv=none; b=UkQbSE8eCYQB5zs3OuhCYbJCXyfa1gpQaRCLSDhZBVPfZp/9k9/Aidt+tjtWKtkbR6Bx7kcasSx00EzCASUkR6SEQ9O9imGxFtkAanHVufRc1OHkX6ZgTtA1+b7dQVcPpQwX8zHO0d8Gvp4Yf5I7tvbcThD/oPLoUNM4+pXDClA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755844347; c=relaxed/simple;
	bh=Jw1/6DUF+Ac5HcoF990e1YAh6IPo3BGIaMyRMVjFFWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZpNUH6OaZDcTiQNwwedIfyPvbOeiIlbnh1Os+NwDHYvdB9radN4N1uJkz4pulBDuNxcwzxTTDvLqE0DB9W9aWcVv7xLXuIYtUbu7W6plunRuXj0n5ic7lmg7hY1WGv52ndMunjnCaq20cHufhNMaEHYPBhl0HmkEovcIAkm9q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7b3.dynamic.kabel-deutschland.de [95.90.247.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3298161E64841;
	Fri, 22 Aug 2025 08:31:53 +0200 (CEST)
Message-ID: <0f19e779-ec78-419a-a261-c4550d778b45@molgen.mpg.de>
Date: Fri, 22 Aug 2025 08:31:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] i40e: Prevent unwanted interface
 name changes
To: Calvin Owens <calvin@wbinvd.org>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Ivan Vecera <ivecera@redhat.com>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
References: <94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Calvin,


Thank you for your patch..

Am 20.08.25 um 06:29 schrieb Calvin Owens:
> The same naming regression which was reported in ixgbe and fixed in
> commit e67a0bc3ed4f ("ixgbe: prevent from unwanted interface name
> changes") still exists in i40e.
> 
> Fix i40e by setting the same flag, added in commit c5ec7f49b480
> ("devlink: let driver opt out of automatic phys_port_name generation").
> 
> Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_devlink.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> index cc4e9e2addb7..40f81e798151 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> @@ -212,6 +212,7 @@ int i40e_devlink_create_port(struct i40e_pf *pf)
>   
>   	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
>   	attrs.phys.port_number = pf->hw.pf_id;
> +	attrs.no_phys_port_name = 1;
>   	i40e_devlink_set_switch_id(pf, &attrs.switch_id);
>   	devlink_port_attrs_set(&pf->devlink_port, &attrs);
>   	err = devlink_port_register(devlink, &pf->devlink_port, pf->hw.pf_id);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

