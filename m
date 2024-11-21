Return-Path: <netdev+bounces-146741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C067F9D55DA
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 23:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694F91F22E66
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 22:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C2B1DDA34;
	Thu, 21 Nov 2024 22:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ghtOvb9R"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3976223098E;
	Thu, 21 Nov 2024 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732229746; cv=none; b=WjRXcYfJTDtnOCuJQ4lI3424PBrCcTT8nyIyT7c+dz675WhgtdzEVljflaypXMIjzYrtUIJ4bYTFeIgOVvEAgrriFJ3jISfthXQTlwP/AFnFSwhLkAYN18IP5K3CBkpVYbLmUZu/T0DywGVpJiYNcXmCCDBgkCnOBL8lx21tDkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732229746; c=relaxed/simple;
	bh=zO1lwbBfnR33OKzfQqRUTBn3qgyTmput2YiGtIxai1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MTwn079VG+VV/ViGjDjadcuUXC2069uJgUhx7DiuRvbHCaYSntyw0vg4D1EC/os7jGKSSOTMQfnO3zD4m7G7OU9hKSz/R391p0sar4GT+uiZUZi/LeBrVU+ipioDPByUNQUMECy1/oWO3wVDYBIw1vZey/sStgMZXeBCFMABYmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ghtOvb9R; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 233CE403E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1732229743; bh=08T7GhtD33Aas5PbmABVE1NeeqKDFayNzkbTOZZ5Qa0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ghtOvb9Rh8RYFfCBZz7zruyn6z5xWmzC1gUwyYOroCIbib6C+F/xPnlYXKalP5BK3
	 AOekC07sw926SQKE2ybebizRHTG9b7eDCIhOWHZ9r/QBxpRnHDXH4NCE/VdLwDmGWs
	 zntkZk+qhMfEWNWViidwlWMLKpmVoZQZy4V4urnzlpyGfTDpwEUCpADPJGmNsrJlDu
	 WiOe+uaqtBu4hguglxuOyRLC5OPP7DDq8/EvfwqJ8zW8jw1dUVfhjEedFXL0ZiWK8r
	 XBhyaVZdaI5zaC+36V7r1g9TkelLjCi08ZupVYDnd8XuB9sY3rcWkg+uTJWiVPtk7z
	 cPBV5cZ+IBiyA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 233CE403E7;
	Thu, 21 Nov 2024 22:55:43 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Vyshnav Ajith <puthen1977@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vyshnav Ajith <puthen1977@gmail.com>
Subject: Re: Slight improvement in readability
In-Reply-To: <20241121224604.12071-1-puthen1977@gmail.com>
References: <20241121224604.12071-1-puthen1977@gmail.com>
Date: Thu, 21 Nov 2024 15:55:42 -0700
Message-ID: <87bjy85h8x.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vyshnav Ajith <puthen1977@gmail.com> writes:

> Removed few extra spaces and changed from "a" to "an ISP"
>
> Signed-off-by: Vyshnav Ajith <puthen1977@gmail.com>
> ---
>  Documentation/networking/eql.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/networking/eql.rst b/Documentation/networking/eql.rst
> index a628c4c81166..4f47121323c9 100644
> --- a/Documentation/networking/eql.rst
> +++ b/Documentation/networking/eql.rst
> @@ -23,9 +23,9 @@ EQL Driver: Serial IP Load Balancing HOWTO
>  
>    Which is worse? A huge fee for a 56K leased line or two phone lines?
>    It's probably the former.  If you find yourself craving more bandwidth,
> -  and have a ISP that is flexible, it is now possible to bind modems
> +  and have an ISP that is flexible, it is now possible to bind modems
>    together to work as one point-to-point link to increase your
> -  bandwidth.  All without having to have a special black box on either
> +  bandwidth. All without having to have a special black box on either

Grammar fixes are fine, but we have an explicit policy that certain
things are *not* typos and do not need fixing.  These include American
or British spellings and, to the point here, the number of spaces after
a period.  Please do not submit that kind of change.

Thanks,

jon

