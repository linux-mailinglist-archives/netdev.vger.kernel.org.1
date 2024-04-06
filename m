Return-Path: <netdev+bounces-85390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4189E89A935
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 07:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7BF128271B
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 05:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC281EB48;
	Sat,  6 Apr 2024 05:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uT/CL5Ru"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A997DA50
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 05:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712382306; cv=none; b=p3U2twhlPAD2OAwFs56+uTqR+T863PwE+Y0On6JtnCxuKNmdi/rbYk7+lRkA3FqBt7/KUR1VWQ3rtfvIFxzkV6jn9OPNXWvtftBYAb723Sdk5STeDZUq8cThCXuHTLVmRoGIb+uD62uiksr2CFEzAYPznI6oPXUWooOejU5W5Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712382306; c=relaxed/simple;
	bh=AF9MjjeX9uWkxGvAF0vqJAZcyFS/QHg117A4xiMxDfc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ryAmVWy3Ots38XIMUJNcDXLIyFzu6M1706K256j309vdrSuo1XcN9hjoDra93kyM01aDRFBrs1kl7HYIecZ0DwPZ7SdPeBODbK6VBzNTY0/KkzyUrEJaqzzvRc3fHUZu0gRjoM73seGTYYPh+LBfwAgEgv5Rjy1rfevMkrliPVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uT/CL5Ru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC42C433C7;
	Sat,  6 Apr 2024 05:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712382306;
	bh=AF9MjjeX9uWkxGvAF0vqJAZcyFS/QHg117A4xiMxDfc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uT/CL5RuKn6xzqAdKV2CuJEMuQWRBfGj5vwrEw/WfXt3KFyQsPdekV+LkeEsXcquu
	 IVRMr9RC6ho+fCJCRiv43UTz7FnrQEsZDxoPVugzyPPinIrPvhNKqgrnycf2YJE0Qb
	 xazs1bBj+gRD2q4KvY+UCOpnqd7hr9011uHUzw1YPHlIAZJeh9y21o4cd22VmCqEFD
	 a39h3gVLSvivydyRCgyj1kDuJOLQ4VKPD4UPGNVXZMsEjpRaTVPnCEtlqlW2v6vRRq
	 EeSNfOK1AzTgaGE6XcdksLzmOS313QH/HdB+36DMXAWs8BIMTgC236iMS5O6mi/i35
	 Yr3j/cE6F0dag==
Date: Fri, 5 Apr 2024 22:45:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com, galshalom@nvidia.com,
 mgurtovoy@nvidia.com, edumazet@google.com
Subject: Re: [PATCH v24 00/20] nvme-tcp receive offloads
Message-ID: <20240405224504.4cb620de@kernel.org>
In-Reply-To: <20240404123717.11857-1-aaptel@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Doesn't apply, again, unfortunately.

On Thu,  4 Apr 2024 12:36:57 +0000 Aurelien Aptel wrote:
> Testing
> =======
> This series was tested on ConnectX-7 HW using various configurations
> of IO sizes, queue depths, MTUs, and with both the SPDK and kernel NVMe-TCP
> targets.

About testing, what do you have in terms of a testing setup?
As you said this is similar to the TLS offload:

> Note:
> These offloads are similar in nature to the packet-based NIC TLS offloads,
> which are already upstream (see net/tls/tls_device.c).
> You can read more about TLS offload here:
> https://www.kernel.org/doc/html/latest/networking/tls-offload.html

and our experience trying to maintain and extend the very much used SW
kernel TLS implementation in presence of the device offload is mixed :(
We can't test it, we break it, get CVEs for it :( In all fairness 
the inline offload is probably not as bad as the crypto accelerator
path, but still it breaks. So assuming that this gets all the necessary
acks can we expect you to plug some testing into the netdev CI so that
we see whether any incoming change is breaking this offload?

