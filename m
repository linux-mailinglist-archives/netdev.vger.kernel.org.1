Return-Path: <netdev+bounces-142149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 519499BDA71
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82FEA1C227E4
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 00:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90AB26AFB;
	Wed,  6 Nov 2024 00:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kROV9PXJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39D5CA5B
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 00:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853599; cv=none; b=SezbXZT1JfyX8T4ejDSIgybPuUNGPkI2Ud3/jcL7PCSuodwAys2sqnrXMUDGO/IqaGA9VZhpnbqUrCYZanq7oQ1Vx5WBNLKqaP60r7e6bR6DtgSwEia+T0dHI32eAj2SY947K9Aow5bL53FXfnKtR5gXYVmYtHmTiViCB6eLDnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853599; c=relaxed/simple;
	bh=WrWrsC3sbzZB+EPZIKIGEPdkMepNs+iXGXGZ7Ubfb84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rwmfdbxaxp3EkBtqL87WJJ6fjjTtKLjhkzDKOOi8USTi+LVIIn1Hd86N0/maESh53FZ7Mds2cbGCU/u0qvM+DP7ra8RE0HV/iYUPUmyB3vxc1EI/SHyiIikdYHzbvfKjQ24FAmJIURQewt2gIerZdR0mBphWnWHcIq503gwLmE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kROV9PXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1CEC4CECF;
	Wed,  6 Nov 2024 00:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730853599;
	bh=WrWrsC3sbzZB+EPZIKIGEPdkMepNs+iXGXGZ7Ubfb84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kROV9PXJvvnBESIdnA53r2wJR9Qard5+btXJQWdIYwI9cCcJgQHUKfHSayBmoNWsh
	 I6vb+oYTqb/azzb35Q7O+6mlUJKqFWfbCnnO+uEANeYuNNuozBL4KPJBkK+4gFRzzb
	 imKJqQoOIPFfTj32TZl2ZeRkscrdogeG84b9lvBVEc9xyl5VQ3a5P2eYY4RG0Ngy06
	 uspNWlqxE59YsT3yXInJ33qc3ky05SqrRQ6dtcI3ilKW1zckmyhLdiXjjYqvq3mjVc
	 /sZ40s5wS1SerR11fuKJDcNihI2oF20XfXESEZ8ryVr01efhoO5vWgN1793CI33EHm
	 jSsSaUBSt1L/Q==
Date: Tue, 5 Nov 2024 16:39:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov
 <razor@blackwall.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 3/8] rtnetlink: Add peer_type in struct
 rtnl_link_ops.
Message-ID: <20241105163957.34e07588@kernel.org>
In-Reply-To: <20241105163911.55d1bf60@kernel.org>
References: <20241105020514.41963-1-kuniyu@amazon.com>
	<20241105020514.41963-4-kuniyu@amazon.com>
	<20241105163911.55d1bf60@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Nov 2024 16:39:11 -0800 Jakub Kicinski wrote:
> On Mon, 4 Nov 2024 18:05:09 -0800 Kuniyuki Iwashima wrote:
> > +	const unsigned char	peer_type;  
> 
> technically netlink attr types are 14b wide or some such

I guess compiler will warn if someone tries to use < 255

