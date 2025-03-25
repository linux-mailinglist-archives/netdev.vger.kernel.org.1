Return-Path: <netdev+bounces-177464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C81A70445
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D551896B4B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33C825A33A;
	Tue, 25 Mar 2025 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQhesUih"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF34257AC2
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914268; cv=none; b=RjPdGDOyMO9/x5eslO3Avv7VwnwenFyHC8N5LkGgKsV+0eWu7fljQ9Q02ZsOG2OlRzr8P83VvBYUAiFR9FqnKRwrifHkUDMWjdlhsQPb3chwR44doINByElwKOHG7TQwl58IukvsLLFAVOHkKpTl+1OZZX8npaTqVHLI+bOoikA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914268; c=relaxed/simple;
	bh=eA58Yb6fJv/7Gh2LADwONIX8ovhZbXNvhQu3EyA6lPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pchvXYgbvdqksbXXh8QXd3O5Dk4wTiIhFXv234Xd8AKgLsnWOu68MCSb2UitTZK9mx0b1lcI/D7o7Yw25BHj+nWGxWkF/U/RktV4FC4jlVAySGostwYRy/1m7T2HjpD4DUNVO+yFQYFvQHx2EcrkAhVBkPTVqIMdp5FEgEPPw5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQhesUih; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAAAC4CEE4;
	Tue, 25 Mar 2025 14:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742914268;
	bh=eA58Yb6fJv/7Gh2LADwONIX8ovhZbXNvhQu3EyA6lPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uQhesUihjOMbIB+r0Z4AzXOMLCeWdtGP3CQhWpeVWVcDoM/W+CO6xWZaGYxu3VSUF
	 1BghaPD0eOvhNko1xQZ4mithEDLEH4uDHA2Agz6ijYVMtMB7wyXvwyW14b6kbcxUqe
	 TVHyWd7LmqeUu8J7zv/dWKfwvL0akKxGqGZv8vqtKdpt4vUFFP0Q83mJ4oXP/YAAg0
	 TG2b+1cxNUEptLRCia9T7RAU83vy9GE51BK67DC9+XXCaYVvCe2sF5ntx65gtIKaKw
	 8Rk/bWJGbf4TO91//JO6g00Dr39Zan+Q0PDme8xIL2uQTZP9LCQI5SCz9EgwmVS/+n
	 w0zS8Ltoh9Bmg==
Date: Tue, 25 Mar 2025 07:51:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Joe Damato <jdamato@fastly.com>, "David S . Miller "
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com,
 mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/4] Add support to set napi threaded for
 individual napi
Message-ID: <20250325075100.77b5c4c0@kernel.org>
In-Reply-To: <Z92dcVfEiI2g8XOZ@LQ3V64L9R2>
References: <20250321021521.849856-1-skhawaja@google.com>
	<20250321021521.849856-2-skhawaja@google.com>
	<Z92dcVfEiI2g8XOZ@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Mar 2025 10:10:09 -0700 Joe Damato wrote:
> > +int napi_set_threaded(struct napi_struct *napi, bool threaded)
> > +{
> > +	if (napi->dev->threaded)
> > +		return -EINVAL;  
> 
> This works differently than the existing per-NAPI defer_hard_irqs /
> gro_flush_timeout which are also interface wide.
> 
> In that implementation: 
>   - the per-NAPI value is set when requested by the user
>   - when the sysfs value is written, all NAPIs have their values
>     overwritten to the sysfs value
> 
> I think either:
>   - This implementation should work like the existing ones, or
>   - The existing ones should be changed to work like this
> 
> I am opposed to have two different behaviors when setting per-NAPI
> vs system/nic-wide sysfs values.
> 
> I don't have a preference on which behavior is chosen, but the
> behavior should be the same for all of the things that are
> system/nic-wide and moving to per-NAPI.

And we should probably have a test that verifies the consistency
for all the relevant attrs.

