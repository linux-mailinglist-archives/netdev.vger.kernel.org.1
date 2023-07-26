Return-Path: <netdev+bounces-21152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E7076294A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 05:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E20D1C21062
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 03:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7191FD9;
	Wed, 26 Jul 2023 03:31:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E01615C9
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 03:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE6CC433C7;
	Wed, 26 Jul 2023 03:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690342313;
	bh=owdyVoGHzwrB1kYbBsJ2Addg8UsT4A8rZ0oG+GuSTf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jFI+JT6o1d1qPVFNEXJJD0tgP0wRf/W53JxQniwqQcQ1UU9wbZDhS3RJeX/MXFpa9
	 r18kGGF3kqWcFP65/sVK+gMt224vaZDj8OYE6Xne8gM72jI3huiIoM7U4d30wHPNHE
	 /cNCwEO4GeM9FnjYhw6Qwt660EN+m+c7TnEQ8FnVmTDA+ucKgxcqiGtzrh0hi0bOfe
	 24k1l1SkSeoEsnFDnPORAkYZh5ORrWFA+k87mLNwaEiuRuuxt4RgluNJ8F9iS1j5I3
	 Uuua/euU75BpZZqmUsuTZPKPDAm/KjBW5b5cXqWmo5eWZOWY7ZGwQyMWgE7CFuw+xz
	 VYdFT8dOS5fZw==
Date: Tue, 25 Jul 2023 20:31:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Adham Faris <afaris@nvidia.com>, Gal Pressman
 <gal@nvidia.com>
Subject: Re: [net-next 02/14] net/mlx5: Expose NIC temperature via hardware
 monitoring kernel API
Message-ID: <20230725203152.363d5dae@kernel.org>
In-Reply-To: <20230724224426.231024-3-saeed@kernel.org>
References: <20230724224426.231024-1-saeed@kernel.org>
	<20230724224426.231024-3-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jul 2023 15:44:14 -0700 Saeed Mahameed wrote:
> Expose NIC temperature by implementing hwmon kernel API, which turns
> current thermal zone kernel API to redundant.
> 
> For each one of the supported and exposed thermal diode sensors, expose
> the following attributes:
> 1) Input temperature.
> 2) Highest temperature.
> 3) Temperature label.
> 4) Temperature critical max value:
>    refers to the high threshold of Warning Event. Will be exposed as
>    `tempY_crit` hwmon attribute (RO attribute). For example for
>    ConnectX5 HCA's this temperature value will be 105 Celsius, 10
>    degrees lower than the HW shutdown temperature).
> 5) Temperature reset history: resets highest temperature.
> 
> For example, for dualport ConnectX5 NIC with a single IC thermal diode
> sensor will have 2 hwmon directories (one for each PCI function)
> under "/sys/class/hwmon/hwmon[X,Y]".
> 
> Listing one of the directories above (hwmonX/Y) generates the
> corresponding output below:
> 
> $ grep -H -d skip . /sys/class/hwmon/hwmon0/*

I missed it glancing on the series yesterday because it's just 
a warning in pw - we should really get hwmon folks and ML CCed
on this one.
-- 
pw-bot: cr

