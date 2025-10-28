Return-Path: <netdev+bounces-233373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB9FC128C5
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC4FD3482C3
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E7419ABD8;
	Tue, 28 Oct 2025 01:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6nc+2XN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4FE1388;
	Tue, 28 Oct 2025 01:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761615026; cv=none; b=j9v9DHJIP86LhTDz1uinsrXO5NJPKq6hWyDAVle/2j/ca+Mz+7DMNbCyp8uGcpxGd0yg0BYs9+wWv95uxW7z3rrTqsTq1+vI847Cqjjh0Qv0VuE0MqI/iBjwvRQihbN58j9KsApMRsvZSqoCwAKYLSQZlZJJDLqkxL+pBHlXYKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761615026; c=relaxed/simple;
	bh=eMWI0IDIfjL7fqmnNvq+dSCX3slzTb//Jge4YdkRWHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtF4jwEXMTMVO2aIQ+IInnoOFrO2eyRZloanwOpugZhoIkdbFvA0w+KYURRmViUX83c9TXXTF7hJCNmXxkS75VJgZBTPxws8NxTAY4cy3mCOY7+zLBP3Ouw4Hn+qpmF5MF+5DCWf9R+j8Eb0jh0CCXlzSK+mK9UlqsyXzRiapsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6nc+2XN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751B4C4CEF1;
	Tue, 28 Oct 2025 01:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761615025;
	bh=eMWI0IDIfjL7fqmnNvq+dSCX3slzTb//Jge4YdkRWHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d6nc+2XN450X/W7Kf6J9ZKKmILICRBXhiv0KGyNNwxnwS+Cg2g2BkKegFp2RRGNtR
	 xLGxI/5MLjdjJs7zTgHOn7RYU0f3WHsdJgJ9IXCoqHxiHuDnaLuqmFywboH7ikBRKZ
	 P3aM2zjyG1eKN+vbBj/rYTaSrQD1Nux1zbv3l9PZOYesYe5at7caHfBmjMQkBCtmxb
	 Lpw6/BqFmmqgyW8UdoNdTdzG6Qn9kr+7P1nn2DGKoxDRQKOzcin9ZO9I4KkmQPAGHG
	 QqH+D0gsvjNdcPDhUGvsK7d7pDd0LV4wXVFAsxVSfeJVckDqvvRllprdI3y21F0T4H
	 HbE/ZFRwQk1GQ==
Date: Mon, 27 Oct 2025 18:30:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: vadim.fedorenko@linux.dev, davem@davemloft.net,
 richardcochran@gmail.com, nick.shi@broadcom.com,
 alexey.makhalov@broadcom.com, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, jiashengjiangcool@gmail.com, andrew@lunn.ch,
 viswanathiyyappan@gmail.com, wei.fang@nxp.com, rmk+kernel@armlinux.org.uk,
 vladimir.oltean@nxp.com, cjubran@nvidia.com, dtatulea@nvidia.com,
 tariqt@nvidia.com, netdev@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
 florian.fainelli@broadcom.com, vamsi-krishna.brahmajosyula@broadcom.com,
 tapas.kundu@broadcom.com, shubham-sg.gupta@broadcom.com,
 karen.wang@broadcom.com, hari-krishna.ginka@broadcom.com
Subject: Re: [PATCH v3 0/2] ptp/ptp_vmw: enhancements to ptp_vmw
Message-ID: <20251027183023.45a76082@kernel.org>
In-Reply-To: <20251023131048.3718441-1-ajay.kaher@broadcom.com>
References: <20251023131048.3718441-1-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 13:10:46 +0000 Ajay Kaher wrote:
> This series provides:
> 
> - implementation of PTP clock adjustments ops for ptp_vmw driver to
> adjust its time and frequency, allowing time transfer from a virtual
> machine to the underlying hypervisor.
> 
> - add a module parameter probe_hv_port that allows ptp_vmw driver to
> be loaded even when ACPI is disabled, by directly probing for the
> device using VMware hypervisor port commands.

We'd like to get out of the business of representing pure VM clocks
as PTP devices, see:
https://lore.kernel.org/20250815113814.5e135318@kernel.org

Your driver is already in the tree which is a bit awkward but I'd
prefer to resolve that discussion before we add any more functionality
to such clocks.
-- 
pw-bot: cr

