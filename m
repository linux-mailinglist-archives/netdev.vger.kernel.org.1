Return-Path: <netdev+bounces-163639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA10A2B1D9
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 19:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C1C1889424
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 18:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF991A3056;
	Thu,  6 Feb 2025 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvxDa2jd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4DD1A2C06
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738868241; cv=none; b=tHRpNc1NRvdqev6vSdUDqnNd/+DUcvb6vQz/FkUFC6eNNXpoxd76YsBqIU7uPRhlhAGfZuMtijJTCGZTgSZRk0twlwaFiQWlhXLdjo1OhYtEHvo+G+FyyEYeoXDe0v8JLdV8LypYMWES5Fptv6yofbWk9m0pyIgQbCJYgtZns+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738868241; c=relaxed/simple;
	bh=TPePmZCPXcaG0UTSmZ9q5V7OsD2otJ6zxRyMZF5OM+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uInk5DXJmjzrYToKTd7edoG7XJ4MS/IiZbO0tCga4twjTr+mMpWsOIDoAlKBlllppt0vh4E7mZtoJaElmirfMKB6Fazl9bDNd4RoLEY1mRe2/S/pDD+tIKHz/Y7ioiiQ/398BpErq3KZ9nB2KNB4dUItaCO0IU42yADctNoFIEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvxDa2jd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF58C4CEDD;
	Thu,  6 Feb 2025 18:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738868240;
	bh=TPePmZCPXcaG0UTSmZ9q5V7OsD2otJ6zxRyMZF5OM+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZvxDa2jd0aw9H6IdLUba7cozMJTmnwaTZZlm8NR+rtXnMLrswhrC5B/1qGIifTS9W
	 aXS/r1srr1JfeBBsvjY9Wkcc/vtL3qzzmXooJs8+OfpMmaXhIP2RmH/IhlHUbwZhHZ
	 aX4f9AbpDluW45geDsrauPMkJklmflYgNbLapZMX8qLBZA0g2acFVPMczuK3ObVjhW
	 9a8mgE6Pwc3q1YHifry+olZsk529TBbR+JVyDyY4EOiA8/gPIJk+qK5ANSvvtC0r7F
	 mdTs8QO5LxHVicFpq+5vRGLWRo6JP+53aOElwkSdyIeJ3CxB9FCpbksNg9gA63UPMf
	 d4Xt5uDRA1yQQ==
Date: Thu, 6 Feb 2025 10:57:20 -0800
From: Kees Cook <kees@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Konrad Knitter <konrad.knitter@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nick Desaulniers <nick.desaulniers@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH iwl-net] ice: health.c: fix compilation on gcc 7.5
Message-ID: <202502061056.162506F7@keescook>
References: <20250205104252.30464-2-przemyslaw.kitszel@intel.com>
 <20250205204546.GM554665@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205204546.GM554665@kernel.org>

On Wed, Feb 05, 2025 at 08:45:46PM +0000, Simon Horman wrote:
> I ran into a similar problem not so long ago and I'm wondering if
> the following, based on a suggestion by Jiri Slaby, resolves your
> problem.
> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
> index ea40f7941259..19c3d37aa768 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/health.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/health.c
> @@ -25,10 +25,10 @@ struct ice_health_status {
>   * The below lookup requires to be sorted by code.
>   */
>  
> -static const char *const ice_common_port_solutions =
> +static const char ice_common_port_solutions[] =
>  	"Check your cable connection. Change or replace the module or cable. Manually set speed and duplex.";
> -static const char *const ice_port_number_label = "Port Number";
> -static const char *const ice_update_nvm_solution = "Update to the latest NVM image.";
> +static const char ice_port_number_label[] = "Port Number";
> +static const char ice_update_nvm_solution[] = "Update to the latest NVM image.";
>  
>  static const struct ice_health_status ice_health_status_lookup[] = {
>  	{ICE_AQC_HEALTH_STATUS_ERR_UNKNOWN_MOD_STRICT, "An unsupported module was detected.",
> 

I'd agree that would be the preferred fix. :)

-- 
Kees Cook

