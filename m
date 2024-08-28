Return-Path: <netdev+bounces-122877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55757962F64
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30361F2248C
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E16B1A7067;
	Wed, 28 Aug 2024 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1sipsWp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325D71D554;
	Wed, 28 Aug 2024 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868647; cv=none; b=siyz7Vy094TWH+Yt1I5KT/arqbIkRFDbd30L6ZMpK4gi3rPxm46f3aDsU32zysvUM6xTHdLAsg4F9Kd/tRFeVSqUmPWH/e4FOXXV8ZPCmKCkWlKkFNKDrp7EnRpF7aLxsNlB+jNcEUsyYgKx4RN54hvxPCXDeE11tXZ64qLCjJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868647; c=relaxed/simple;
	bh=BLWFViZHyhfvUvUKzWyXSIKJCD0OeyNnNaETiXaafdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qb2V0+oMx435tXxKy0JjT/Jp4dUji4QfYoMgdVivyOFmvSSmoeBj38uin/zCVGMO+6sPoJz0jOquZLJPdaYo9Lp1AtQT7j87CN1LjLScKLzAi/p7LTMXQpKXmSCElECaIQxeW3FYCI1dGbUUaO06AKOhyr8dw0dyhxh6WUMldxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1sipsWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12471C4CEC0;
	Wed, 28 Aug 2024 18:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724868647;
	bh=BLWFViZHyhfvUvUKzWyXSIKJCD0OeyNnNaETiXaafdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z1sipsWpuNXKP+EOz6AL6w/fPKCe1izfUeP1TLDV4jTuBM8Pj5WwIHJZv/5wkVS5z
	 fCAChL1rCsdgyblCaFMvYGC1soBs6KWFaWLkCJocYbXmltsjwOxeS5sSsU4cbA9kG/
	 +iokNUm8LrSXg5Nm85d7OSywxmqqJGSjfbPAJryEHs6zlYK2OT/fPzLlXjbOVrVXXw
	 33KIaV3vl08lsNHVR1EAZ/vlIN2sefXmfIoZagjtQvbapHyJpfYJgdNExUKjC5jPlA
	 2jj4rn41vLLE9NH5gVZupLtUo5xV4HIPo4Wh0s84eJeF4Rs5XPG7sSbhoFaQcM5OP1
	 RpmJnWcc/yPIA==
Date: Wed, 28 Aug 2024 11:10:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Jinjie Ruan <ruanjinjie@huawei.com>,
 woojung.huh@microchip.com, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linus.walleij@linaro.org, alsi@bang-olufsen.dk, justin.chen@broadcom.com,
 sebastian.hesselbarth@gmail.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, mcoquelin.stm32@gmail.com, wens@csie.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, ansuelsmth@gmail.com, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com, jic23@kernel.org
Subject: Re: [PATCH net-next v2 00/13] net: Simplified with scoped function
Message-ID: <20240828111045.11dfc157@kernel.org>
In-Reply-To: <71deb322-4b54-4c1c-a665-d9de84ea9baf@kernel.org>
References: <20240828032343.1218749-1-ruanjinjie@huawei.com>
	<6092e318-ae0c-44f6-89fa-989a384921b7@lunn.ch>
	<71deb322-4b54-4c1c-a665-d9de84ea9baf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 16:45:32 +0200 Krzysztof Kozlowski wrote:
> On 28/08/2024 16:32, Andrew Lunn wrote:
> > On Wed, Aug 28, 2024 at 11:23:30AM +0800, Jinjie Ruan wrote:  
> >> Simplify with scoped for each OF child loop and __free(), as well as
> >> dev_err_probe().
> >>
> >> Changes in v2:
> >> - Subject prefix: next -> net-next.
> >> - Split __free() from scoped for each OF child loop clean.
> >> - Fix use of_node_put() instead of __free() for the 5th patch.  
> > 
> > I personally think all these __free() are ugly and magical. Can it  
> 
> It is code readability so quite subjective. Jakub also rejected one of
> such __free() changes, so maybe all these cases here should be rejected?

Andrew's comments on refcounting on DT objects notwithstanding --
I do like the _scoped() iterator quite a bit, FWIW. I think it's one 
of the better uses of the auto-cleanup and local variable declarations.

Direct uses of __free() are more questionable in my opinion.

Using advanced constructs to build clean subsystem APIs is great,
sprinkling unreadable constructs to save LoC is what C++ is for. 
(Lets see how many people this offends ;))

