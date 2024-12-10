Return-Path: <netdev+bounces-150681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6649E9EB2B7
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E3128654F
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB821AAA0D;
	Tue, 10 Dec 2024 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mE/ivwqA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955B978F4C;
	Tue, 10 Dec 2024 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839698; cv=none; b=QLuXMTq/wlmYSffQOgGnFD/i2YzyHih4MOxUR7GlvSc2H8asiNvg/4xOBaNJZ6+hWraByS0gkbWphDPJi9KZCJ1bAtkcdLMEsvF8W7G2Mb6LiA/pILHj15EghZGSdOyoRpxQzgbzyTABDdc6nRHzNlqLbmK1QjHNdJGG4JkA6+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839698; c=relaxed/simple;
	bh=aThqeVHm59/gVdCaPIC8lNuoRKNN5Gz1CL7kYghQHJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxGIqgbBfU9gqD/mMeN4GpSiJUeFOoBAttKxqqOhUOG2DnXxamK0SCIfOijhGJqKZbet6SC9pNmtK95rZ1mAvZqTBGAPCbF4XFlPdxbDxH9SaQAdrRvjHr/OvUVjp+VsaGQZV0u1/D2mMmLK+qqzKiBp0iv6RKo5Tz6UYMDDffQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mE/ivwqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34FDC4CED6;
	Tue, 10 Dec 2024 14:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733839698;
	bh=aThqeVHm59/gVdCaPIC8lNuoRKNN5Gz1CL7kYghQHJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mE/ivwqA6rlHf+L6piB+oR6QzgMyS/P0gTp1E1Cx3WJFo3ZIh2iX/IdzGM0YzhJEi
	 +CgvO51sTUkWtKQEAJqUqahiRu/wlSSVTGNlyMay4br+99bCsAQXQsGmwcKJ2TwAYS
	 A/QNj/ROcU2kks3iuYUK45uNE4whYaJKQWBvVJqYZ4rhyJ4VS51FyZwoJgEuXmI6bH
	 sBrU5GqH7iIaDuFj7N+AWmap28yVlfPLgY/aYjxB1UseEC9uNyjf2hY9haGJ3FDIcS
	 Tp1hVj4meofa/VBHl6EZUJ2AQ9eMjHC33DfFN35ua6IrE6eUTELndTavA2alVMJEpy
	 8FjjB9lrUmczQ==
Date: Tue, 10 Dec 2024 14:08:14 +0000
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dsa: mv88e6xxx: Centralise common statistics check
Message-ID: <20241210140814.GD4202@kernel.org>
References: <20241207-v6-13-rc1-net-next-mv88e6xxx-stats-refactor-v1-0-b9960f839846@lunn.ch>
 <20241207-v6-13-rc1-net-next-mv88e6xxx-stats-refactor-v1-2-b9960f839846@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207-v6-13-rc1-net-next-mv88e6xxx-stats-refactor-v1-2-b9960f839846@lunn.ch>

On Sat, Dec 07, 2024 at 03:18:45PM -0600, Andrew Lunn wrote:
> With moving information about available statistics into the info
> structure, the test becomes identical. Consolidate them into a single
> test.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Simon Horman <horms@kernel.org>


