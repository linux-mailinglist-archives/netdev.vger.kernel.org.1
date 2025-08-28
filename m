Return-Path: <netdev+bounces-217547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 670DCB39033
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8474B1C230A5
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396A52EAE3;
	Thu, 28 Aug 2025 00:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzNajhel"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9321CA81;
	Thu, 28 Aug 2025 00:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756342042; cv=none; b=paGWfriJj7lveyocp813WT4iy6fhXGaptDnKZNKKfC6kY+MkXy0/Qp359angETlmIunW0GFEV2QSLmRXXraU6MQJAQPZNU+OT6MmrCDXIQu6k6z7+S8HgdTWasOqrfQynKNujdcMbhL58kqAHvpOUmaLG0qBs4N6xg8Pn2sx6ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756342042; c=relaxed/simple;
	bh=q1z3RZuqEJxK9EDCy/Zsitit/jOg5xqwARkTq6Uc31A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7NNuq/h94EnKE05po2ySKQDvxKTJFgrk0rk6ylsPvK0QltnjrIpQBMpW3EJnrrgYQ7bdLnimdNgJvWKYqATvtxgiJTVgpBuirJEx/mKb8RhWeqtYesENd/Nos2n6dlffh3x9ZsSISatO5pmG9qMUdeUXOIL9gMV1d5X2vfOQxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzNajhel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D77C4CEEB;
	Thu, 28 Aug 2025 00:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756342041;
	bh=q1z3RZuqEJxK9EDCy/Zsitit/jOg5xqwARkTq6Uc31A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MzNajhelfqS/dm7DcvHPm2F/fO14AudOOWphhCt6kcXPNwZmgpE3XPV+6I5DJL+yS
	 l1W2l754D2RKJEMTa/+NiKyPleVQY/KbE4RZNb4GCFoMniZLiwRYU/e01NlSHy5JuD
	 yRiNZXS7Y4w56pOxHHzGoW+Yb7OsQljttf5JKXx9wQ9CfnKipxGd4inWVpkRQDwaix
	 XAK+Af84kR3gxbpIYbQUqFAmmE7ir85vtoQoZDLOWyCvrWvnq1jY0BBSPXnqT132P5
	 VbZSElCjEZ6hAe71X0b8jWRdh0Z119HcsTKrnpkB20JNqerCBBwQAigGf8ukORjXmC
	 qB0SEJlb3m0SQ==
Date: Wed, 27 Aug 2025 17:47:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <richardcochran@gmail.com>, <Parthiban.Veerasooran@microchip.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 2/2] net: phy: micrel: Add PTP support for
 lan8842
Message-ID: <20250827174720.7b6406a1@kernel.org>
In-Reply-To: <20250826071100.334375-3-horatiu.vultur@microchip.com>
References: <20250826071100.334375-1-horatiu.vultur@microchip.com>
	<20250826071100.334375-3-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 09:11:00 +0200 Horatiu Vultur wrote:
> +#define LAN8842_STRAP_REG_PHYADDR_MASK		GENMASK(4, 0)

> +	addr = lanphy_read_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
> +				    LAN8842_STRAP_REG);
> +	addr &= LAN8842_STRAP_REG_PHYADDR_MASK;
> +	if (addr < 0)
> +		return addr;

Did you mean to mask the value after the check if it's negative?

