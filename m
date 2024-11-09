Return-Path: <netdev+bounces-143492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D44589C29CA
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 04:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF97F1C21086
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 03:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8835335C7;
	Sat,  9 Nov 2024 03:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTAFK3pk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB8033DF;
	Sat,  9 Nov 2024 03:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731124783; cv=none; b=sk4NKprL84oGnp06zK939jX++MJ1VmNlRGlAnBTbLPfbP9RqdhaiGKr65J5wC/u62hnLqqbTYDnx9K4b57D34Jvx3wYhC2GMWBOz7LD5o2FBexSt+SGy3wCO60gUO05Vo7B5ot+Z1vTd/7iY6NoOpb2o6t4nYzzYq0p9IaUi8EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731124783; c=relaxed/simple;
	bh=+PqEu08Z2e2qccxTHfOiTHCYReV9xzQyZLvFwtWeTzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqSQUBtfL4QgZLer+56kSXCk/7BZ1jMIjaXs/rnRBI7F2apD+uQ5lL5WcokpsvLN9h9bz8ueaEXA7u/afuO8ofR6tQ6h9E2gwlUFF4icWw7F+slu9nV+xIy5+SF0zXsiOEz127LzeGnCSjOwgxK0MNnOb0aOaARDKvIwqDSdUhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTAFK3pk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AF3C4CEC6;
	Sat,  9 Nov 2024 03:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731124783;
	bh=+PqEu08Z2e2qccxTHfOiTHCYReV9xzQyZLvFwtWeTzg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sTAFK3pkXKOor0M7rI+XMYqjwNzVpdmKO24LL/lXGQYZ/eMhnqqbKY/fXJ0lbk87O
	 rNBXM0Ox6iT1imehKYic+kF7ZwoV4SPwDNCMCzhNqz6uYIjzlvBU28doJatFMt9Qon
	 cbAOP2bOAIOObgQ9KyhduoniU52ijVVhRBPZi74ZBriBvx8Gi47B/1WGEjdE8Y458m
	 hE75bxtb9aJrI2u0nLqZekaBg9Mu5h4h2CbuJht7ekTTuGxIA7uirDCg4Mo+ggflfF
	 w4Gyc2Dgxi8jGLc+yhb2ESzum2FKJSIVhrkrToL6NuegAeb2FnrQ61EbBZiID39CTZ
	 /wVy9vCSdqOLA==
Date: Fri, 8 Nov 2024 19:59:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Louis Peens <louis.peens@corigine.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 oss-drivers@corigine.com (open list:NETRONOME ETHERNET DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] net: netronome: use double ptr for gstrings
Message-ID: <20241108195941.7d45c6e3@kernel.org>
In-Reply-To: <20241108204154.305560-1-rosenp@gmail.com>
References: <20241108204154.305560-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Nov 2024 12:41:54 -0800 Rosen Penev wrote:
> Currently the code copies a pointer and propagates increments that way.
> 
> Instead of doing that, increment with a double pointer, which the
> ethtool string helpers expect.
> 
> Also converted some memcpy calls to ethtool_puts, as they should be.

Let's not "convert" a driver which already uses the ethtool_ print
helpers. Replace the memcpy but leave the rest be, please.
-- 
pw-bot: cr

