Return-Path: <netdev+bounces-165975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E85BA33D46
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 12:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51E1169984
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951C42153D0;
	Thu, 13 Feb 2025 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oblr/DtU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB7D2153CD
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444451; cv=none; b=sTJ6hkA5+JlnseuILqx+zxmf2HtdJkkEk6cCctsTyt//parsaf5oqH+rOpyBzKauu1LPnE5gLILx/nUQeowzIJqURoP/UB/pWChwRRpswiKhhZiOEjUL2DPyZtM2drHFOl8zcMjVZ9F04moc5H5jjQAUJwSDF/YO5J2MWcfLQQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444451; c=relaxed/simple;
	bh=H1nfbbc+DNTr9c7soOdkJDZDBuFwRn1OAMGIxM0nPRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VT1yBqvddtMgWA7BO4zjmh+X3L3O6Y3UsNr9Dimxc3e33sLrL0BAetRTqw/5zCYig0JvstIcDGcqh4wD7LEYBmh6po6JxUS6PPbQkL9thd8oiQMJ45JS20o/f5UzHgtCG7htVwliDWI9k5nx9YjhO9+7BNC/8A+48ZsjHiFyC48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oblr/DtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A586CC4CED1;
	Thu, 13 Feb 2025 11:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739444451;
	bh=H1nfbbc+DNTr9c7soOdkJDZDBuFwRn1OAMGIxM0nPRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oblr/DtUUxGTSBTNU2lJY15UlOZTU216telkxtswMxzZH/JRCLyRFKJwCpXXJ42wh
	 zfOZ1xxko18wqg7orXvQPaOEsJ49CDbb77qAn/Q5zZVEI91ksyT3LexsUgRdT8vYPP
	 7ccMxFV905okVRn6TPwwKZOYpDj6YXE/+zugRM78FATHXM9Pvmp1xS4cMNPJKMQytK
	 r8rs27gYxwO8+65jmpcTWX+/4kpVaMqg91pAZHva9BJNr6Dy1LppEk4GkMwTMPp+NP
	 jnNos266TPo4ARQKFjmuXiauoFKDaFQYr32S5dSLoZF847IpqssbnyuUB/TT69PAtl
	 CpdEQaXwQD6Tg==
Date: Thu, 13 Feb 2025 11:00:47 +0000
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: Re: [PATCH iwl-net 2/2] ice: Avoid setting default Rx VSI twice in
 switchdev setup
Message-ID: <20250213110047.GK1615191@kernel.org>
References: <20250211174322.603652-1-marcin.szycik@linux.intel.com>
 <20250211174322.603652-2-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211174322.603652-2-marcin.szycik@linux.intel.com>

On Tue, Feb 11, 2025 at 06:43:22PM +0100, Marcin Szycik wrote:
> As part of switchdev environment setup, uplink VSI is configured as
> default for both Tx and Rx. Default Rx VSI is also used by promiscuous
> mode. If promisc mode is enabled and an attempt to enter switchdev mode
> is made, the setup will fail because Rx VSI is already configured as
> default (rule exists).
> 
> Reproducer:
>   devlink dev eswitch set $PF1_PCI mode switchdev
>   ip l s $PF1 up
>   ip l s $PF1 promisc on
>   echo 1 > /sys/class/net/$PF1/device/sriov_numvfs
> 
> In switchdev setup, use ice_set_dflt_vsi() instead of plain
> ice_cfg_dflt_vsi(), which avoids repeating setting default VSI for Rx if
> it's already configured.
> 
> Fixes: 50d62022f455 ("ice: default Tx rule instead of to queue")
> Reported-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> Closes: https://lore.kernel.org/intel-wired-lan/PH0PR11MB50138B635F2E5CEB7075325D961F2@PH0PR11MB5013.namprd11.prod.outlook.com
> Reviewed-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


