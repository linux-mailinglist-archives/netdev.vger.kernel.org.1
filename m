Return-Path: <netdev+bounces-99608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 152588D5790
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 03:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFD61F2608C
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845395258;
	Fri, 31 May 2024 01:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fD44h0x7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD1F1C680;
	Fri, 31 May 2024 01:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717117522; cv=none; b=nf5nE2VGSqGuR1ouJR1P3n5QajeqfZBJHT/2GuJk/0Q4i/cauRXOYdJs7N2msPBwGGgZqQPDdq5v1Q7RBVE9M8wO46GcvGLCzymSGVX9E/a+H7S7jz6aVjzGp5AkSXxEx0ciTQt32REaGb5aNzxqSjeA1wShHRel1mG//HUDgfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717117522; c=relaxed/simple;
	bh=DjwBjylFu9zSk4+6/Yk76rJE/iaP8TMTmXRb6LPlt4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UkjSxGIK9425Bcm8UvWImdHNGw8miZl+YOWlP84ioB0Uwnd/eAcL4WIGxLr6Hg5uhfnrFvnpI7Qyew5IVCGpPpJlinO5M6GJ7iFRf8KcmIG6cGHERkOBNb3g2s5a0ARkGhQ+/j+Ds515t3BuZ/EbA7uWvnD4/+HBf6mtHdmpOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fD44h0x7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757D1C2BBFC;
	Fri, 31 May 2024 01:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717117521;
	bh=DjwBjylFu9zSk4+6/Yk76rJE/iaP8TMTmXRb6LPlt4A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fD44h0x7wlmfSHGWHRGG2ruvPH9z6SdSCygNuqpGnXNkhJgH50Uv3YuDRUUq/mfsz
	 isviumGNuaOzidq3wX0LKAAfebOnysNNS6k6cV0DWWlT9rVdQ2QNUUKVIE/wt6Bzl3
	 FNpKj0A6C7Jfykw/bPCYpeJLwNa9AfPjCYT9uMC2f/V5XOPM6dBRI/oZ6YEZ6406Ie
	 FzG9ZqIERyDp84wJP9JLW2ggAbeMETCm9eDEezP6NLyZ3gzYndqgAbqGcUcDoFeCdC
	 GxBR5PhypSv/F09C6AUICQPZX7i0W7o3fQgW/tzekXrrEC9SCQZSSO3uhOqyXG+L5P
	 PLYE1Puybftpg==
Date: Thu, 30 May 2024 18:05:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: <netdev@vger.kernel.org>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 3/4] vmxnet3: add command to allow disabling
 of offloads
Message-ID: <20240530180520.74899d37@kernel.org>
In-Reply-To: <20240528233907.2674-4-ronak.doshi@broadcom.com>
References: <20240528233907.2674-1-ronak.doshi@broadcom.com>
	<20240528233907.2674-4-ronak.doshi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 16:39:05 -0700 Ronak Doshi wrote:
> @@ -270,6 +270,14 @@ netdev_features_t vmxnet3_fix_features(struct net_device *netdev,
>  	if (!(features & NETIF_F_RXCSUM))
>  		features &= ~NETIF_F_LRO;
>  
> +	if ((features & NETIF_F_LRO) &&
> +	    (adapter->disabledOffloads & VMXNET3_OFFLOAD_LRO))
> +		features &= ~NETIF_F_LRO;
> +
> +	if ((features & (NETIF_F_TSO | NETIF_F_TSO6)) &&
> +	    (adapter->disabledOffloads & VMXNET3_OFFLOAD_TSO))
> +		features &= ~(NETIF_F_TSO | NETIF_F_TSO6);

Why do you clear them in fix_features?
They are not declared as supported how can they get enabled?
-- 
pw-bot: cr

