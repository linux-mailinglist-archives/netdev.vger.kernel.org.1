Return-Path: <netdev+bounces-149767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E646F9E759C
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 17:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5591916B7B8
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 16:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B378520E6E6;
	Fri,  6 Dec 2024 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRGJ34SO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8593220E31F;
	Fri,  6 Dec 2024 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501628; cv=none; b=hLmSlPdQW18JB4XyZx8GRiErHWoFAe8qA2xma8enKXuHd5UJ1QX5ThjQu2X0U5j/9Mrj3QHi8X+Vqzv9SiKDxpORx6d3/gX4G39LFHZZyeWSatqxVGs7WIXJ1hC4c7KgGziVfC+qd4nPg5bVvbyQV+P/YkXeBUIrdIGrypyynFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501628; c=relaxed/simple;
	bh=gIKZTHmhk9FfSEUJ3t9zvcYRaZMtqCmfMCj/RjZGjd4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgWiLcXXbMrq6VBZz3MmZK39q2k3VOT4RHNyTZGYPTqc7GyDbPlR79viXl2MSNuY/HNxLVnwknAlVaFqMmvv/jo1LlxSG4uiAU4SUXWIdUG6ddpl8y3jtFtMjC5iyqo4tq9eGLlC013jbCTU//vO0sIWkePUjVX1skRt14E59dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRGJ34SO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81744C4CEDC;
	Fri,  6 Dec 2024 16:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733501627;
	bh=gIKZTHmhk9FfSEUJ3t9zvcYRaZMtqCmfMCj/RjZGjd4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eRGJ34SO4bmZx++Ve5xbFLoW5N/Xg+QgW0gYjn1XDrVoTRb0Q8JlBTyB7yh3MkTNT
	 heGGheIfk7HilBfCPqwySGeuxh7QpJi3wLmSvwcEgX7UZfZKu7yNqz2t/SQhxA9YHM
	 4xAMS4xIdLmqmhfO8mfN3Esxugfv5XguSMPzQp7RZs3EPyFiZxE2Wkbo28zNPy+qzo
	 adefX35QpmuA84NLrKGiX/HPJyGcsmqgKaiZ9EHYTmUyilTV7M4EU/zF+qVcCNgFlr
	 E5kISK5nn3lzlp301ur/0Y5hju591yHjuDwnd8bbEfWtidO42WGhX4Fw+A28g+yE1X
	 IJx/Q3iShGJEQ==
Date: Fri, 6 Dec 2024 08:13:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/7] net: ethtool: plumb PHY stats to PHY
 drivers
Message-ID: <20241206081346.2fc81766@kernel.org>
In-Reply-To: <Z1K_xI-0d3JINvlg@shell.armlinux.org.uk>
References: <20241203075622.2452169-1-o.rempel@pengutronix.de>
	<20241203075622.2452169-2-o.rempel@pengutronix.de>
	<Z1GVLf0RaYCP060b@shell.armlinux.org.uk>
	<20241205171909.274715c2@kernel.org>
	<Z1K_xI-0d3JINvlg@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Dec 2024 09:11:32 +0000 Russell King (Oracle) wrote:
> Maybe:
> 
>  * The input structure is pre-initialised with ETHTOOL_STAT_NOT_SET and
>  * the implementation must only change implemented statistics.

Yup, that's better!

FWIW I think my brain goes to talking about zero-init because for
per-queue or per-cpu stats some drivers do:

	for each q:
		struct->stat += q->stat;

without first setting to 0. And it _seems_ fine since NOT_SET is -1,
and the off-by-one is hard to spot. But for PHY stats this sort of
iteration is very unlikely.

