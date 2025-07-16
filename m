Return-Path: <netdev+bounces-207417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454F2B0716E
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 11:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A7050095A
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6046A2EA470;
	Wed, 16 Jul 2025 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kM5pQudW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372C328C00D;
	Wed, 16 Jul 2025 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752657523; cv=none; b=W+spXh4BEdarnf+7+73AwqExu7mY83qgpKXRHhdWEPJ2BlzXYpx9nS2fMKY+JqRSbujfKQ8W+aN23CUKvfkZ/Fro64LmdHk1r5Tgi4ae44D0naU8k7b1hD7MqHBsSPwDaXSGd8yFAci/GLaEdp9+CmxyJVi9orIs/JzM0z1iq2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752657523; c=relaxed/simple;
	bh=4BI5blgxXpjJZIpySaa9qC3PiXN1NyUS2KRhcRVnqJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k68s1DQJgXXqHq5RJT2jJSEPe1goszTkeu43FbZ/M/LxDFqmEbyJnikWZiWkpBda3hxP6vpBAKgHUYgqKjNHICwuhbdEC6v9oANtWMHVgJu9uhbwSopg9fzngsi1O5I1wNwPLmd+yTwU4wcCyP075A1UElI2/3iK7irzxVRGaLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kM5pQudW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E59C4CEF1;
	Wed, 16 Jul 2025 09:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752657522;
	bh=4BI5blgxXpjJZIpySaa9qC3PiXN1NyUS2KRhcRVnqJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kM5pQudW4A52yW9aIDDsDMXimRq3AbiOUOD9Yx4soAJlOZ1kCMJICp7nPSmvp1IKo
	 O56G7LggJQZrDooQb1xPcqPmFoQAUqO6C2fOLvULHl+J2Vas8CdOcLd3jMhpxkYsgt
	 DMvwidUSy1ITR+DUYlPneMqdyno9QF625PzDZPaqxb/ivGw28AVx4DkPskjhTBsqdb
	 GG/nF0GHJzoMcUmF0oezL0XEyh/IdCgS2y1JL4P9zx7goh41fv8w5hy9qOr1wsoyjy
	 2Dx4laZs0Dclanor0ugSbSIL+7XszLX0f+swpZ19uZI9gV4klGWIdxUso9nGhJ6Iy/
	 3LQPq8AgDghvA==
Date: Wed, 16 Jul 2025 10:18:39 +0100
From: Simon Horman <horms@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: oneukum@suse.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: Make init_satus() return -ENOMEM if alloc
 failed
Message-ID: <20250716091839.GM721198@horms.kernel.org>
References: <20250716001524.168110-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716001524.168110-1-qiang.zhang@linux.dev>

On Wed, Jul 16, 2025 at 08:15:23AM +0800, Zqiang wrote:
> This commit make init_status() return -ENOMEM, if invoke
> kmalloc() return failed.
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Hi,

It seems to me that the code has been structured so that
this case is not treated as an error, and rather initialisation
that depends on it is skipped.

Are you sure this change is correct?

