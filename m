Return-Path: <netdev+bounces-219080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B725EB3FA46
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 11:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE2C3A92AB
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 09:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31B52E8B7B;
	Tue,  2 Sep 2025 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqQ61+VC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5EA2E5B1F
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805132; cv=none; b=FfDEJesdKYT8Gor8gY4T661DpbzDNshfxduvVbiWod3I0y++lexxcv5fbn0Q/+0rmlKrVRuzO5MRkx0IjSIhP62UVL4+u//SNk/EzPlImTRZ7cB7Jdv0X72BunB38Fj8C1aufAn61pnLdwGF9415c7vZMh0Xq0rG4TfJnFhmiqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805132; c=relaxed/simple;
	bh=9hKkEkPofO1htyp1fgRkBlzUCScGfR1sRK4Yt0SuIK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LP7NG84HuJxO0vTFs7xt6yn9WY+fxcCbliX3EfVeGwmcbts23blOh0IuQMLh2vMEs/g7GTbabSmV1ZJSLaFWMwBagZz4wxMgU1IE/NJMiBKOI1Zlm5Du7UhsxSDM1h3lENqDNO28zTb/UcYLtH4EVNHfLv9YNeMPtqoRyNE4DAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqQ61+VC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17890C4CEED;
	Tue,  2 Sep 2025 09:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756805131;
	bh=9hKkEkPofO1htyp1fgRkBlzUCScGfR1sRK4Yt0SuIK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sqQ61+VCz8AfIC0trnjts2MFrcOoJpuHQ3dHzc4XFJ18pPeK6rXqqSWfC6qUUtYRf
	 BKlZcAF7WdXpxovYwqjINrpoREVIG9R7dMKocUIDNvWTl67dIPPKp1ZbLHWARgaTJP
	 fMXyQXsS5edswNvH/XPTWgHg1kWYVWjSWASAroEKx09y4ihuFlLM3JwtLZCtS8qiAF
	 7OKPH4aKEtq7iU6SXNrl9WXf3itTYja6JSqh9cIlkTVfqBvYQY1vrcUQcpl4dKfgJy
	 LkRpCJhLNcvhNrA6nSBk4H27tVabXJiSZpLmojII4Jcc616LPvnuc69YTsj0G+dwXi
	 CkBOuQr9/cvdQ==
Date: Tue, 2 Sep 2025 10:25:27 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net 2/2] eth: sundance: fix endian issues
Message-ID: <20250902092527.GY15473@horms.kernel.org>
References: <20250901210818.1025316-1-kuba@kernel.org>
 <20250901210818.1025316-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901210818.1025316-2-kuba@kernel.org>

On Mon, Sep 01, 2025 at 02:08:18PM -0700, Jakub Kicinski wrote:
> Fix sparse warnings about endianness. Store DMA addr to a variable
> of correct type and then only convert it when writing to the descriptor.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


