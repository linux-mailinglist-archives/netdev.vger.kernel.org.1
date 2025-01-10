Return-Path: <netdev+bounces-156938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7818AA08546
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 03:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DF457A1BC6
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 02:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF8413DDAE;
	Fri, 10 Jan 2025 02:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HN4LUVnH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D4818027
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 02:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736475710; cv=none; b=Z2mbT90TayW1uiYC1ek2REpGju3YZMZq2SaB8Aovyo46un1njIDacFXmWSKD/MyDvRO39sxHzxT83G46fwxf6N5IOMr4af6DfyTyBjKd+IW6yAEYgx4gwsGb3H2jZ28Xo1V1QyNFAHkXmFVd6fsE5XNLS8jc2m/kcvxMsqUuCg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736475710; c=relaxed/simple;
	bh=F/8BouBaHiQC2/IwByek9Zu82WMlzS2SnGvqop5eY10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CapNIPOstniBICtvZaCbrWX17e0dwludM+1TH2m9GaI6xMsESOEYX/raiVrUIav9lZBhxX9FvjGKALfRB3V+mIpxT2ZtHO0/wEXtUf6Uo0lq96fG5WwKM193IsIDvxD22qSDA4TtCfcfmSZtvXNYpQHTWVtkXtHttl9vvoLEZ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HN4LUVnH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4DDC4CED2;
	Fri, 10 Jan 2025 02:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736475710;
	bh=F/8BouBaHiQC2/IwByek9Zu82WMlzS2SnGvqop5eY10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HN4LUVnHRBh/OLUVk0G3RIXXox+NQg+3urnEcXmaFUB3drLNDrVMpeB0ya8YOJayQ
	 JPdn5Bc09oUwilNvepenLiAoRA8ckSqWtZOSkpFbeZOr5YTARNEVUDyR03d266PqzA
	 /9ooCfDl2NimhSNfAo+Vi+4+FWzbGK4RuBvnRIKIBHHNWC3YIQ4oSM1CIQxYHTAr8N
	 lVCfm9Qk+4Ek8VbMU9o97Bh4JQug8jniiiK4kDESkwmBj000WG2q4WPQkBYXybmHaQ
	 VvPwBePmC5H1pl/2ytagrYNsh9UMBZxOulp7AbP7UZ+p3/8peyAkGfYIzEci/xCiuo
	 K2ecyO36MwrYA==
Date: Thu, 9 Jan 2025 18:21:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, anton.nadezhdin@intel.com,
 przemyslaw.kitszel@intel.com, milena.olech@intel.com,
 arkadiusz.kubalewski@intel.com, richardcochran@gmail.com, Karol Kolacinski
 <karol.kolacinski@intel.com>, Rinitha S <sx.rinitha@intel.com>
Subject: Re: [PATCH net-next 08/13] ice: use rd32_poll_timeout_atomic in
 ice_read_phy_tstamp_ll_e810
Message-ID: <20250109182148.398f1cf1@kernel.org>
In-Reply-To: <20250108221753.2055987-9-anthony.l.nguyen@intel.com>
References: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
	<20250108221753.2055987-9-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Jan 2025 14:17:45 -0800 Tony Nguyen wrote:
> --- a/drivers/net/ethernet/intel/ice/ice_osdep.h
> +++ b/drivers/net/ethernet/intel/ice/ice_osdep.h
> @@ -26,6 +26,9 @@
>  
>  #define rd32_poll_timeout(a, addr, val, cond, delay_us, timeout_us) \
>  	read_poll_timeout(rd32, val, cond, delay_us, timeout_us, false, a, addr)
> +#define rd32_poll_timeout_atomic(a, addr, val, cond, delay_us, timeout_us) \
> +	read_poll_timeout_atomic(rd32, val, cond, delay_us, timeout_us, false, \
> +				 a, addr)

Could you deprecate the use of the osdep header? At the very least don't
add new stuff here. Back in the day "no OS abstraction layers" was 
a pretty hard and fast rule. I don't hear it as much these days, but 
I think it's still valid since this just obfuscates the code for all
readers outside your team.

