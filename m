Return-Path: <netdev+bounces-76638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3567386E6B3
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 18:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E230828A562
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 17:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364B13A1CB;
	Fri,  1 Mar 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOwBAKSN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131FC3A1C7
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312586; cv=none; b=o8VsRkF4idxqEem4tiU9A96gyGnHE9Gv5uZ+hWStza4VrNewWPpMs6pVarVB1SkhX0XlsvWu1/Ab7j8PInR+T048M0RjM3bgjgetlPX3l1zYJ1VeJQVxYfPAQ47wHTLu9PfJ0gJm1WE0KpC0WK0ItPeE8EY+mEsrmCHRCHETAiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312586; c=relaxed/simple;
	bh=vaCI6AV8Lak3qhdvwoBflxxoyDmXc+I7w5TAWB/IFGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnrkFIQCVl3kdpHM6LBSR4n6BzwUeklb2SM2YjX5zsaZIpOENtNmsZJG/0V0IpuMPkK0295zYweckWu6Ok5Ig+N826Il1+bnznNvqd/LXqHla/YWC46SUR0ygynWSjOVorOMsYikRXkmWZh1qjvzuaQQI4IwAK9BDIDTJz0L9IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOwBAKSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127ADC433F1;
	Fri,  1 Mar 2024 17:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709312585;
	bh=vaCI6AV8Lak3qhdvwoBflxxoyDmXc+I7w5TAWB/IFGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NOwBAKSNqfkOIltQyi4HntKRYTLS8J3BvZ6GXN9J0wV/C9LeZQlSdYHwKyb8o2Os+
	 MXYZDR1K8TSGjlCOMNPSnbUB0B3ZDAmUT+Vyweyp7ZWCvgOQxyGKg7HKtOAAmNPrZG
	 gfSnZScW6+lj5EpDLGmG0l4s250y5LZlUZMUSQyIOT846GpH2+aglL5iIY57njrl74
	 ff8YM+Ws4UguqU76gY7rS3WGWtYJtdsIe7gXk4UUG+Djef/zvRhs4DD1Z3BHWJlo4b
	 P34R74KLUd5UU6Z9ugxko14VBNUY+llqrBZIOo6kAoDXLnEQYhI7nFTieHKawI6p6r
	 al2G2TXLtnM+A==
Date: Fri, 1 Mar 2024 09:03:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com, galshalom@nvidia.com,
 mgurtovoy@nvidia.com, edumazet@google.com
Subject: Re: [PATCH v23 00/20] nvme-tcp receive offloads
Message-ID: <20240301090304.6eaa3407@kernel.org>
In-Reply-To: <25334ta5f36.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
References: <20240228125733.299384-1-aaptel@nvidia.com>
	<20240229093219.66d69339@kernel.org>
	<25334ta5f36.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 01 Mar 2024 14:09:01 +0200 Aurelien Aptel wrote:
> Out of curiousity, what tool is generating these warnings?
> I don't see them on patchwork nor in our local CI (running sparse, smatch,
> checkpatch, clang...).

make coccicheck

