Return-Path: <netdev+bounces-187133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5FFAA5257
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 19:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8212C3AA577
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 17:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8531118641;
	Wed, 30 Apr 2025 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFPjfdQK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFEE2DC775;
	Wed, 30 Apr 2025 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746032456; cv=none; b=Gb4u/8RCjMdlbS/0OTXNRBl327nYBaoMlQjO8Qg5oYTZoE/FMEdnN/HuogvPWuEfLeEBvB+hsOPSogTY9giHxG8bNgJj4VEfT53F9MSVv83htT0QaBJd1Be8LYLKjtw6uzqOmVil//wSwVVQxSOWAQ35fcivvdXaBGASVNrIY/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746032456; c=relaxed/simple;
	bh=IRh4j6kpy6+qJ+YaPU74qO9gVULUTzJ1z5X4szQtXQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJ1fLA8LY7KcPVNGp7dff4M7gETq1/T4cB8KSlkTNtptp28UEbA+qszeohFbtVgSHibiMyWK4VAFN8x/+AFRl2XWnYCmqKyRMsF45J5ULOA7Eu6yJNRXN/UM+9JNtdrnJKcqLZEt15mGb23ZZ+7R7snvTsTvQu2dhlaBgFwMgz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFPjfdQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCAEC4CEE7;
	Wed, 30 Apr 2025 17:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746032455;
	bh=IRh4j6kpy6+qJ+YaPU74qO9gVULUTzJ1z5X4szQtXQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sFPjfdQKjtDEAYaXJgeQGYgo1zLpesDdTThKcDksosboCoXA3lelAKddm2oCdY/j1
	 9JwYvhvo8Akxvu/C0j6Y/hjZqHQjF/407zNysPX2DAUDqpqrHIG2+qZmCIr3zYbYAu
	 KL/MkC70yWJ/4bFLjfR02LegzC/pzm61Tspldp6s69H4WDzqYpWi9endCCCjMo9Bus
	 qSW4XC9Wv/iKuIdkB4qOVD2yuqljr7zPggK4WDfoZ25dGz681VEWGTDbZ0hdGrlemJ
	 HXRs4Q9/eOfY2Emxh6ZeC0CeiTQjMKv/AFULMxelCJIbZcIED+o1UC6cGngc4e9PmR
	 wJCa5l5HeWMew==
Date: Wed, 30 Apr 2025 18:00:51 +0100
From: Simon Horman <horms@kernel.org>
To: Sathesh B Edara <sedara@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
	vimleshk@marvell.com, Veerasenareddy Burru <vburru@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Abhijit Ayarekar <aayarekar@marvell.com>
Subject: Re: [PATCH net] octeon_ep: Fix host hang issue during device reboot
Message-ID: <20250430170051.GV3339421@horms.kernel.org>
References: <20250429114624.19104-1-sedara@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429114624.19104-1-sedara@marvell.com>

On Tue, Apr 29, 2025 at 04:46:24AM -0700, Sathesh B Edara wrote:
> When the host loses heartbeat messages from the device,
> the driver calls the device-specific ndo_stop function,
> which frees the resources. If the driver is unloaded in
> this scenario, it calls ndo_stop again, attempting to free
> resources that have already been freed, leading to a host
> hang issue. To resolve this, dev_close should be called
> instead of the device-specific stop function.dev_close
> internally calls ndo_stop to stop the network interface
> and performs additional cleanup tasks. During the driver
> unload process, if the device is already down, ndo_stop
> is not called.
> 
> Fixes: 5cb96c29aa0e ("octeon_ep: add heartbeat monitor")
> Signed-off-by: Sathesh B Edara <sedara@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

