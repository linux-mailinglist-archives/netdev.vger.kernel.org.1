Return-Path: <netdev+bounces-190381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20235AB69AC
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC10A189F494
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 11:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635C8225401;
	Wed, 14 May 2025 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KznGD2du"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAEA46447
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747221599; cv=none; b=lrCrSUSTRW1TOdVRzkNTOECtCmVoiEUzWc1dYH7HgffVnyHFnO+C0OB+iJdA7/HB71VpTxpXiks2dQkmrmlIyAcWFs0EkGMlwUM4DzKW8XexCVSa77F7toIOFjUEyO7CtqMIgFLvr26VjxMGUoJq3QsfRpkllwPAzL1xvQSUMVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747221599; c=relaxed/simple;
	bh=GBUqUjQOpJZd65Jl9Td1GB1UEM/vW7SRKGw46XElmLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfYXBjumC6xdmUEHvvHuhbpyf9UuNbGp3iY5OoY2mO6tglL5BOPzUpueIxsghdBqkg23DSwpqIrp3mSw61kyKYKtpvOs9xdKFDAOSX61B6RGoHCSTXU9qygOtTaGYy3IjkDdxnJQK/luOgUJcbgLoTheoJG6J/7dvgAyKbck2T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KznGD2du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D3AC4CEEB;
	Wed, 14 May 2025 11:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747221598;
	bh=GBUqUjQOpJZd65Jl9Td1GB1UEM/vW7SRKGw46XElmLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KznGD2dudNmUUgp7CbIgyA6kya00b/yFGXpSklgungpjAGgKJlKxYhQgdrz0sdqAi
	 oRZ6MJQquV7BQI4+n2JZ2kaCWy2BD413qcp3RAZxJVtJ6rEjjnRrVszvQH1zfsGiBX
	 sejAodJYEbi7bK9hmODwaNNQFjLJlFSNBA3APY67JXHeYz2VOiPPZ5YF8AsN5XRV1P
	 lgPXicigCM5KxmDAk5B9BHq5xshf7YWDGe32B/Am3nDhPjaZPVSis9VqBMXEXVSb4m
	 304UAfbEdag6OHwyYHIgVDU/bwiEntN1cLA4SV+AaSoKDKW8790Gnoh4YOclxtksfh
	 Pe9qImf2Z3UfQ==
Date: Wed, 14 May 2025 12:19:54 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, mengyuanlou@net-swift.com
Subject: Re: [PATCH net v2 1/3] net: txgbe: Fix to calculate EEPROM checksum
 for AML devices
Message-ID: <20250514111954.GH3339421@horms.kernel.org>
References: <20250513021009.145708-1-jiawenwu@trustnetic.com>
 <1C6BF7A937237F5A+20250513021009.145708-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1C6BF7A937237F5A+20250513021009.145708-2-jiawenwu@trustnetic.com>

On Tue, May 13, 2025 at 10:10:07AM +0800, Jiawen Wu wrote:
> In the new firmware version, the shadow ram reserves some space to store
> I2C information, so the checksum calculation needs to skip this section.
> Otherwise, the driver will fail to probe because the invalid EEPROM
> checksum.
> 
> Fixes: 2e5af6b2ae85 ("net: txgbe: Add basic support for new AML devices")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>


