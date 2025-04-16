Return-Path: <netdev+bounces-183348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E0EA90771
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC3A3BB75B
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 15:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF50C205AB1;
	Wed, 16 Apr 2025 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9fBMyTP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F9B189BB5;
	Wed, 16 Apr 2025 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744816454; cv=none; b=Qm58Cm1LezQkS7q9bxwaoNTAQyixm5GGeCUhyHqIZ0Gfd7WaK4hAvUlseioB7U0J0OxGna8TfaQyy1zJP7ioaOKBfh5Rj+iEFP9qKW6DqfRcQBsad3YGGW4MLAgR3ZUcWe5RDCxFS2xdgsk/0UNqNBEUNG6Vt6lrmg0nsGipPiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744816454; c=relaxed/simple;
	bh=+h3IBbdTxBXBigSzDFMDt/U5N5aPqFEMS8apixZRTKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3hj55qOwHapI54hy4VSr6fEQaNDjKInWel6bkAdr2Kj4GI1UaaP7UrgXSbYElas3xLGPwK4UfSjDnBqQQTsk7MNven95Z+95FaWtSPFQVbHVkrQhIowVJ7SSdLFWxtGlJ4H8tYt/BZMGrFLHYKZJGKAlq9UKhhp56IWVta/YJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9fBMyTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15ADC4CEEC;
	Wed, 16 Apr 2025 15:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744816454;
	bh=+h3IBbdTxBXBigSzDFMDt/U5N5aPqFEMS8apixZRTKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T9fBMyTP3aP9xAuOgnCMwA8kouat3nn23uN7DoyuCXuQc4r0l1g7bsvuHCn4UawNb
	 WQXp/Z9LoiXbW/Y4L6rYFwS87kfBWW3QcR9+tpNWMdupE+NSSudLsBgQzfAQGWZLj6
	 lXLJOVY/Xkx9sl8zuRGTTwbAKZZK23s6LxPxKaTEwchyNCC++9xZRgQ4wOh7ICqiOZ
	 A30ZxmSbjRnZQUvBIU0c/ABSomeltH906q5T+iD1QHNzZKHlZtOO3JN6duwBkU49Lc
	 mEgujImYTZsbQYsYCNYp57YoBFT02UcOBOka2kwauDK8cxb7Tb4brMj0I8W8diSW/Q
	 j/4rPMRysKDdw==
Date: Wed, 16 Apr 2025 16:14:10 +0100
From: Simon Horman <horms@kernel.org>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: netdev@vger.kernel.org, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: lan743x: Allocate rings outside ZONE_DMA
Message-ID: <20250416151410.GR395307@horms.kernel.org>
References: <20250415044509.6695-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415044509.6695-1-thangaraj.s@microchip.com>

On Tue, Apr 15, 2025 at 10:15:09AM +0530, Thangaraj Samynathan wrote:
> The driver allocates ring elements using GFP_DMA flags. There is
> no dependency from LAN743x hardware on memory allocation should be
> in DMA_ZONE. Hence modifying the flags to use only GFP_ATOMIC. This
> is consistent with other callers of lan743x_rx_init_ring_element().
> 
> Reported-by: Zhang, Liyin(CN) <Liyin.Zhang.CN@windriver.com>
> Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
> ---
> v0
> -Initial Commit
> 
> v1
> -Modified GFP flags from GFP_KERNEL to GFP_ATOMIC
> 
> v2
> -resubmit to net-next
> 
> v3
> -Shortened prefix and updated commit message

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>


