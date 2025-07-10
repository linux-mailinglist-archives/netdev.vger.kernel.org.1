Return-Path: <netdev+bounces-205907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E639B00BD9
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1341C1C82ABF
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 19:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FA72FCFF8;
	Thu, 10 Jul 2025 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4OJJOdX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE88F2FCFD5;
	Thu, 10 Jul 2025 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752174565; cv=none; b=HuwKgPvE78HvaCdbvsxp8oA1nXQ/VOFCCuiT8T5Nq9qigKdPoef5WUQnyNwCQ+Tkw8suI890leQlYUvUpfcKt44HYRQSePwSd7jIrxlW6aSbvdyUjXE2jxxm5xeAf2X4HeiKEMXSFWHnB2O7JwxsNgQlvgUzV0AhYiVyNBnHOew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752174565; c=relaxed/simple;
	bh=vmAYK2Qk6hKH8H60VRTBpaX+y9L/EdzeZJY8RofpCQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBG+UPe2X6uSyQHeoR+/RwNT5+D0XzjHgMemyBZxFhHJrHc8HhFFXLpcRjyPdXYqSlGc18aLlSNul2XuCSNMeC1Yf8rHTs/L13ykFL1S0o2ZpVfStwMzNNvmAWsNOLFESRP3k4HzjktRYwsuzprp7PE33cFVbmrYOUiIUVZy6g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4OJJOdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8D4C4CEE3;
	Thu, 10 Jul 2025 19:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752174565;
	bh=vmAYK2Qk6hKH8H60VRTBpaX+y9L/EdzeZJY8RofpCQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O4OJJOdXKelyY+H9tmV7Uc0hEO2OvMwEJ+Yw9BTkzTaInjCAejbNVo6WRxc96IoVE
	 mmaFNVuH6mTWF5Od4zyB5WP6c0ebXiM9vUos6HP58V6NKfGnMZYWvBhp32qeo3bh9w
	 KXRBTtP2LjWERTx6JT5+yu5NvKgnwJ2QyEOZ47k4Pt1M4Nkf1Lb5q3KOItH/NPddko
	 Bev2h43uxcP6SxAAOI5XfPW/zNfS0Veh24av01OjgmgwqJWmgRl5FWTFvd1SpQNaic
	 JHN/77s+cI1TOOcVAtO7OUzk71y7e45JjKwTE/jnt3xNr4frvXztPUGN/HZsfF3kTI
	 aPr2/cHVslcUw==
Date: Thu, 10 Jul 2025 12:09:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Florian Fainelli <f.fainelli@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH net] net: phy: Don't register LEDs for genphy
Message-ID: <20250710120923.0c307a9c@kernel.org>
In-Reply-To: <85f00716-4cd7-410c-a4c7-8efd52e04ec8@linux.dev>
References: <20250707195803.666097-1-sean.anderson@linux.dev>
	<20250707163219.64c99f4d@kernel.org>
	<3aae1c17-2ce8-4229-a397-a8a25cc58fe9@linux.dev>
	<1019ee40-e7df-43a9-ae3f-ad3172e5bf3e@linux.dev>
	<20250710105254.071c2af4@kernel.org>
	<04583ed9-0997-4a54-a255-540837f1dff8@linux.dev>
	<20250710114926.7ec3a64f@kernel.org>
	<85f00716-4cd7-410c-a4c7-8efd52e04ec8@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 14:57:48 -0400 Sean Anderson wrote:
> OK, so if A is this patch and B is the conflict above, you'd like me to
> post an A' like:
> 
>      B---merge---A' net-next
>     /   /
> base---A            net
> 
> ? Or did you have something in mind more like
> 
>      B---A' net-next
>     /
> base---A    net

The latter, so we will end up with:

     B---A' net-next --M
    /                 /
base---A    net -----

where M is a merge with a conflict, to resolve will basically pick 
the net-next version.

