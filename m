Return-Path: <netdev+bounces-104092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1FB90B301
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190E11C21D46
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 14:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8EC10A2B;
	Mon, 17 Jun 2024 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClXaVSFw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9896B1BC43
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632896; cv=none; b=n3gMmPvFr8Fm7tSFmZaoKJp3TeudxU0pxYOV3xNp7vL/qtTgCsuSOvZA+FQAAWGq79qBcP2F9weObYAmxTVjG+9kPMaXs/GSJ/fQm0D4QXhVT2OM+ClHkGKp2DzNXFCRmM+3D9z3J+83upi36GjTk3qp67Bmolw7trvGwvkMF9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632896; c=relaxed/simple;
	bh=ZSTtpCZOHnxjZs6PTQF1g7rTOoGh1x9yJulQj1I5kaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eefX+pdGjsJSHhmzP1ZYCMK+LhYbwXfiFknTV7opTVFVXmjLDMNcuj+LynY2oTsTBNIpqNA62SEZxb7VOmv1dn1hf7uxo4WPbgAHyUEfp0dLtXu7k605r7ZoD4KxaUeByTUmPBF+TRZe/RBVrpSe89JFIyFQDZYuZCsGfEGAge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClXaVSFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EBDC2BD10;
	Mon, 17 Jun 2024 14:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718632896;
	bh=ZSTtpCZOHnxjZs6PTQF1g7rTOoGh1x9yJulQj1I5kaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ClXaVSFwFP7ZVVO8UtNNj7LEODi+6OKSidaaCQRIubS3jSz8JIMZP46ZVITX3O8ik
	 KwGfFy5geGZ1YMj+hU5xL//UTdI7TCDepgIfKyCo5ydbokYMvnqpF3i7cI3tuOk/6B
	 b39DzeuyIDyt7Is0YqngA4U8y6DQi/uZlFfGQC/RRblnP/ul236XWu6TXpWZJ/R4bl
	 inFyd52cmhN+3kT8aAGFua7HcCcZmu2a8vJCpHhCtpweYlJoUu2ipEMEd3VOLpl96X
	 ZT80t8pbCT2FAbhCrPv2lJklQUON+v4dDilY7rBj8iW9P14N/XsWXA+DnF8l7egLjP
	 1XRCz8hjXCoKw==
Date: Mon, 17 Jun 2024 15:01:33 +0100
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Piotr Gardocki <piotrx.gardocki@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next] ice: Distinguish driver reset and removal for
 AQ shutdown
Message-ID: <20240617140133.GT8447@kernel.org>
References: <20240614103811.1178779-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614103811.1178779-1-marcin.szycik@linux.intel.com>

On Fri, Jun 14, 2024 at 12:38:11PM +0200, Marcin Szycik wrote:
> From: Piotr Gardocki <piotrx.gardocki@intel.com>
> 
> Admin queue command for shutdown AQ contains a flag to indicate driver
> unload. However, the flag is always set in the driver, even for resets. It
> can cause the firmware to consider driver as unloaded once the PF reset is
> triggered on all ports of device, which could lead to unexpected results.
> 
> Add an additional function parameter to functions that shutdown AQ,
> indicating whether the driver is actually unloading.
> 
> Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


