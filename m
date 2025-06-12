Return-Path: <netdev+bounces-196960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A31AD7173
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E3F97A325D
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 13:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D11424EF88;
	Thu, 12 Jun 2025 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGxAPgM0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40B124DD0A;
	Thu, 12 Jun 2025 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734132; cv=none; b=M3Yx+8gPNthyleuxTPSVgnHJg1QRfQNPJejAI8mAzwCHsaFGu2aTV2/IJCpexqCFDUhnHn6Z9hX0ieg3P91apQdtQOhDzLXMCyNHhGnDTjxSquWZeuJUJBlu5ymR9jSiAdDv/zGN0MiycHwFZhECrheoj/P1KRekKX3tlRuoT/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734132; c=relaxed/simple;
	bh=HEf5Zhr4IVF9RVpb3UdXEyyJs0FHMbpkjn++wpvfamE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJPx0itnIFSymQbr2CJ5paxkVCj86jXjcH5NRRf/BF8wv3QvS0wfCo9sA/zNPLvMO8J0vOWkp2WoCqhqeXHpje6xwz2WqEfFh+gT06VHIdMpEjp0OMjMghGpDh09xSLLA+3jUJ5g0BZbaE/Y/TgWUR6pO8qsCK3R9NyWogDM6WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGxAPgM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAAEC4CEEA;
	Thu, 12 Jun 2025 13:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734131;
	bh=HEf5Zhr4IVF9RVpb3UdXEyyJs0FHMbpkjn++wpvfamE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LGxAPgM018PFUi3Fjgo/IcjVf6nFkeNOYsNacc7lIz69h7c1RwNYEVjVNZ0jkuF0o
	 nrozAUOmlQdBLBkKZBeV+q9cqNgwZ1rToMBpyaFEUztwMuv+9KTeNlaogoHNzZjf4L
	 6RUWFxx+tbVDoeGZOxPo7sP6yP42aFtEd86F4ysygTICrM3rA/d2lzSuQgCkklKB1I
	 TtZccmaqbDBpASjqImoR64W7XlF1CLpLAXf8kbdnmFtTXqmNVehnK1U4JTyCU6WGsV
	 wkslf1Uk+rHpUxS/dbHsT4cxc5peB1iI/0PZK8+wSFo0rIds+aXHcPPezXKSVu9KEE
	 7IuV5bfAlHKAA==
Date: Thu, 12 Jun 2025 14:15:27 +0100
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, brett.creeley@amd.com
Subject: Re: [PATCH net-next 3/3] ionic: cancel delayed work earlier in remove
Message-ID: <20250612131527.GD414686@horms.kernel.org>
References: <20250609214644.64851-1-shannon.nelson@amd.com>
 <20250609214644.64851-4-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609214644.64851-4-shannon.nelson@amd.com>

On Mon, Jun 09, 2025 at 02:46:44PM -0700, Shannon Nelson wrote:
> Cancel any entries on the delayed work queue before starting
> to tear down the lif to be sure there is no race with any
> other events.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>


