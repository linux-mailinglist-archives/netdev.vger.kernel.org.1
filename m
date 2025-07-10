Return-Path: <netdev+bounces-205884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D15DB00AD8
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 19:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B569C177855
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 17:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC4C2F0E41;
	Thu, 10 Jul 2025 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWi6ZnGr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3473D2F0C6D;
	Thu, 10 Jul 2025 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169976; cv=none; b=qpwJBXgdYqTeb83KiIUtO4H6K4TGEOqmpXlBTM/lHFIW4O6j8/yF5ECY138JdjqamlGFOD+nT4o8OxazI1XxtoIjHfGi06JkTeiLbAV0C/McUIdY2u7oU+bYaeY5g80o6AJUjx38TOxrAhNQkvURj0UMAYC/iPjo/xJK6ZvKgu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169976; c=relaxed/simple;
	bh=a/h1jWkVkO73SwlAMTs337a4Tpv9IOJvNCxyuO/9vck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXAhfmJL2LUhH+EERczFI+g01Wr5Lt7HpqwPtWMmV9rUArc/wmeJKc61qtQtAaI7o1tQ7m/GJ5UYiVJGuq7wj+V7xpdf2fY8YiheIsjTAUgrina16o8ths8/+Lfinsf0MhZzYU0+N0ufwBVFOnRyB106St3IXSosAgS7DrQL/kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWi6ZnGr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F7BC4CEE3;
	Thu, 10 Jul 2025 17:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752169975;
	bh=a/h1jWkVkO73SwlAMTs337a4Tpv9IOJvNCxyuO/9vck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eWi6ZnGruVYIbL3fgorJ46REt9Qk1hVeX8uJa/Mfl8C+7eRQXcASkxIH29VVLmsAh
	 IlNzUw+lZmFfs+yM0GKmzgBClvMLK80KBIqnN9qW8wUwdPGsHSKct/uY80MQJxFlWH
	 nQ6MpU8jHClqwPnM5hOy5v2LAwA2XdGQlpKZq+TAtHcOnjhAGUSJdWbPBK1VU+d7mY
	 yawoSEQvpEDzusgISGEl2yfYesv9eBPPgewbUdf5nMwFPAibdOHNb6+2lCEDsB2PCh
	 fkS8xwPeTlVxYwHEnrtJVFHv/QH4eNYmniNiklf6Pu7Z1fkHs4x1sCXKOOcwmARVQu
	 mUI1JtvGxoe+A==
Date: Thu, 10 Jul 2025 10:52:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Florian Fainelli <f.fainelli@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH net] net: phy: Don't register LEDs for genphy
Message-ID: <20250710105254.071c2af4@kernel.org>
In-Reply-To: <1019ee40-e7df-43a9-ae3f-ad3172e5bf3e@linux.dev>
References: <20250707195803.666097-1-sean.anderson@linux.dev>
	<20250707163219.64c99f4d@kernel.org>
	<3aae1c17-2ce8-4229-a397-a8a25cc58fe9@linux.dev>
	<1019ee40-e7df-43a9-ae3f-ad3172e5bf3e@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 13:40:33 -0400 Sean Anderson wrote:
> I see this is marked "Changes Requested" in patchwork. However, I don't
> believe that I need to change anything until the above commit is merged
> into net/main. Will you be merging that commit? Or should I just resend
> without changes?

The patch must build when posted. If it didn't you need to repost.

