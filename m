Return-Path: <netdev+bounces-149213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F349E4C78
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 03:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E60A282FF4
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 02:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A00B17B4EC;
	Thu,  5 Dec 2024 02:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVs58Mog"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CB579DC;
	Thu,  5 Dec 2024 02:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733366931; cv=none; b=L2Dbzjh+qXRlG+mmaNBZmTZbG6+RABxuVZtORQJ+rS997qOSKZZJFlkaTyiUFryIOtHuHrO0xd5T5eQTj9/pdLdteESe1NQhmLQxDvbCIzF5jdOCzc7rPeYXdriuS7dyGZu9oVbM+pS8luJ063zzQmraOOjSao78tVbgV4ECLeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733366931; c=relaxed/simple;
	bh=nG++O5r+Zr1cUHWNMEBeLhjGClGniD0dVe9MPISxVlU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VgZYTimAhi7SIIV3BmJXs4Jl1aRhCIy5EIKwq8mP6uZcEstnsPuWCJxuXiBbhR+5rVv7kAaotCQCn6VoqkLHWRnc+x0pbrQcPi9+II1wQ1RGa3kv+/62E+hg+UxruX+cgKLO3L6emYVePzgpFVlaQt12lx837ZxPN+zI6f4snPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVs58Mog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1515C4CECD;
	Thu,  5 Dec 2024 02:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733366931;
	bh=nG++O5r+Zr1cUHWNMEBeLhjGClGniD0dVe9MPISxVlU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eVs58Mogp7xDbO6bcMS7bKCmSwk26RaFVpAL5ASesTbx55330jmYh8o+8jyiAx/jL
	 kfFXpNziG7njxQSePjROEtK9VGLFA3GKAqxgPjtno9HWI3qp6jE3goZceIKCD2PKff
	 JAmHJ2dWh1XYKbxxprzkrFjA508HeVpEBIvzQ8e/ware5RbrX4aTmTuG0zLrbsQopu
	 eOPjWgg3MZoEE1ZTLdlZZE5RMzdX/N/Th1VLXpyxIJum0NQ90xPFpsfflOiNF4MbIh
	 djClgsfn2gBeQjCmshvLY/oewV2yEe960MQ1RIBfnvE1mbNDIaNWSMGLvHCu1bVBWc
	 BEoO2eGqTaH4g==
Date: Wed, 4 Dec 2024 18:48:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] qca_spi: Fix clock speed for multiple QCA7000
Message-ID: <20241204184849.4fff5c89@kernel.org>
In-Reply-To: <20241202155853.5813-1-wahrenst@gmx.net>
References: <20241202155853.5813-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Dec 2024 16:58:53 +0100 Stefan Wahren wrote:
> Storing the maximum clock speed in module parameter qcaspi_clkspeed
> has the unintended side effect that the first probed instance
> defines the value for all other instances. Fix this issue by storing
> it in max_speed_hz of the relevant SPI device.
> 
> This fix keeps the priority of the speed parameter (module parameter,
> device tree property, driver default).

I think we should also delete the (seemingly unused?) qca->clkspeed 
in this change. Otherwise it looks surprising that we still assign
the module param to it?
-- 
pw-bot: cr

