Return-Path: <netdev+bounces-138221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7229ACA37
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C81283BDB
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97471ABEA7;
	Wed, 23 Oct 2024 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G01LHK/v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F60A1AAE31;
	Wed, 23 Oct 2024 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687221; cv=none; b=Gu+MZFZenNyQIeghc03STYeAxSQfxAxHpoTUtFy+ZawkAO0bretMCw0NBMVSEg+gK0W702TLe1irJEppEihRxjsHYnkPXKv/5ZjygCAo1PLUp+oFDXHssAej06o6z99ASbilUkBCAhjH84cJ9ppXqVARDDBGm22EZ0bRIjFghQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687221; c=relaxed/simple;
	bh=dzqN+awO8TcOkYgyl6lEgGX9CYpgV1GK+LsfppVV8w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djBe6b4PTWLYljMAIotYtNv4C/DzsSyx1swKzXyM/AePC8niy+5O+ML9+mU51pwD/g8qNOA8OeHGQvXNS8z6qb7zbJwKZUPxEqzF8lNzPom9O924Zl5PsL53L/KjugXWJzK+9c7edGx75mGtdd0Yqz3o1DA/tc6h2Uf8oyEFO8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G01LHK/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957E3C4CEC6;
	Wed, 23 Oct 2024 12:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729687221;
	bh=dzqN+awO8TcOkYgyl6lEgGX9CYpgV1GK+LsfppVV8w4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G01LHK/vpGe0lTSOwUHtuMKExgS4os+O+zy89jYCbdgWExVshtObrm0N6Icqhkl+H
	 TdoU04T7Yi5eo5p6jdcc7emXRa4zVPv4vMBnvBwKdedNuusHFYl0x5EgLDBZUsMjve
	 I05pBGjEj2ueFiMMKKHrSOY5cJrY4cfp+/tRBCIjpg7NOIYEKqQI9sk9aLLIzov5w7
	 1zgrlF7BCFFU8ZgKMLKXNwiNZA2MWMs1xZk2WX4ILgR0Olb2gnfo0ladgTk0Idv2sx
	 Xleqrvsv2wXC6dp71tv5sbiEBgtpqy9QhFfybS6J36EmJxQUKTf253zMIuVlmAXXUK
	 KgqSETdRR9clg==
Date: Wed, 23 Oct 2024 13:40:14 +0100
From: Simon Horman <horms@kernel.org>
To: Jinjian Song <jinjian.song@fibocom.com>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
	corbet@lwn.net, linux-mediatek@lists.infradead.org,
	helgaas@kernel.org, danielwinkler@google.com, korneld@google.com,
	Jinjian Song <songjinjian@hotmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: Re: [net-next,RESEND v6 2/2] net: wwan: t7xx: Add debug port
Message-ID: <20241023124014.GU402847@kernel.org>
References: <20241021121934.16317-1-jinjian.song@fibocom.com>
 <20241021121934.16317-3-jinjian.song@fibocom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021121934.16317-3-jinjian.song@fibocom.com>

+ Jiri

On Mon, Oct 21, 2024 at 08:19:34PM +0800, Jinjian Song wrote:
> From: Jinjian Song <songjinjian@hotmail.com>
> 
> Add support for userspace to switch on the debug port(ADB,MIPC).
>  - ADB port: /dev/wwan0adb0
>  - MIPC port: /dev/wwan0mipc0
> 
> Application can use ADB (Android Debg Bridge) port to implement
> functions (shell, pull, push ...) by ADB protocol commands.
> E.g., ADB commands:
>  - A_OPEN: OPEN(local-id, 0, "destination")
>  - A_WRTE: WRITE(local-id, remote-id, "data")
>  - A_OKEY: READY(local-id, remote-id, "")
>  - A_CLSE: CLOSE(local-id, remote-id, "")
> 
> Link: https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/main/README.md
> 
> Application can use MIPC (Modem Information Process Center) port
> to debug antenna tunner or noise profiling through this MTK modem
> diagnostic interface.
> 
> By default, debug ports are not exposed, so using the command
> to enable or disable debug ports.
> 
> Switch on debug port:
>  - debug: 'echo debug > /sys/bus/pci/devices/${bdf}/t7xx_mode
> 
> Switch off debug port:
>  - normal: 'echo normal > /sys/bus/pci/devices/${bdf}/t7xx_mode

Hi,

I am somewhat surprised to see vendor-specific sysfs controls being added.
And I am wondering if another mechanism was considered. It seems to
me that devlink would be appropriate. Jiri (CCed) may have an opinion on
that.

...

