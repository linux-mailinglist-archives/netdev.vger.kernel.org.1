Return-Path: <netdev+bounces-162144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFDFA25E18
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DEF03A7D17
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447F22080EC;
	Mon,  3 Feb 2025 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="VuMd21i/"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C561518641;
	Mon,  3 Feb 2025 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738594866; cv=none; b=nRN16YOmVVC5WFv5SmOqEuTfjK1WZcb7koMeejsQ/RqWmIQsh/3vjYaIwTPdlMIs9oM/uCKfozQ1Nu/tvAjK9xlthCkqu4CvTRgu15RyJB0hLIVT1sC8UFLw0vTSr2o8TM7uNMNoKd0ETJNn3dl7JlOGD3xLE/cobeL6n3qIV2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738594866; c=relaxed/simple;
	bh=Ju+CFT6Ul2jXiRGjxBaYTPNKaHK34WxsjMbaR7mRfNg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TE205jvGjqeqjAOK0GtwcpsBjLHM63zfIz6DHswRMnWopVkRwOFwmSVtRyx+r1pJg+cxmT7CPSHXvO+zUVaig/hQJFrlKQr2P4QLBDQqQFlMDvSLhlA1Dn/NggEybhaGuhW2TA1ccaddW9fQX/XNCXK2VUUbTlOEhD9OUro60W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=VuMd21i/; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0F5B4404FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1738594857; bh=zxPKOX6W5P/1ne9egoKFrKBv/0PL1X8NO1EjLuwFwrE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VuMd21i/zlFj+XcORjSO9mS5W0KWPLFv2ELTX6yAJb4G8ZtHFQ+Jlm3UNXCmhZ085
	 1Pem9jiPMr5nkHhL1sYHJhp0YZoQpaYAL+l4rB5G5KPqkKT+MkBsAAw4Ibhtv5oBDt
	 QyVJY4/HhsifLW+0ghwv0NvkuNa+kmjaHb9J9ISVprqgxUwBpfSCns2eeG6Ek+d940
	 lpztNe8/fvGIZlXWXw/mL1JI8i2qc6dzNubZd/fILSLozs+9OmIYDSZBlUu3JUqpRL
	 RRnBBS230SLAEY2LsojK6WR5wP3LWQ0oW1+HKN7zR5UpH2BoAyP6c461p6hp0+Wje3
	 1hb9PkCEevBjA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0F5B4404FD;
	Mon,  3 Feb 2025 15:00:57 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Simon Horman <horms@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
 netdev@vger.kernel.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: netdev: Document guidance on inline functions
In-Reply-To: <20250203-inline-funk-v1-1-2f48418e5874@kernel.org>
References: <20250203-inline-funk-v1-1-2f48418e5874@kernel.org>
Date: Mon, 03 Feb 2025 08:00:56 -0700
Message-ID: <874j1bt6mv.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Simon Horman <horms@kernel.org> writes:

> Document preference for non inline functions in .c files.
> This has been the preference for as long as I can recall
> and I was recently surprised to discover that it is undocumented.
>
> Reported-by: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
> Closes: https://lore.kernel.org/all/9662e6fe-cc91-4258-aba1-ab5b016a041a@orange.com/
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  Documentation/process/maintainer-netdev.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> index e497729525d5..1fbb8178b8cd 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
> @@ -408,6 +408,17 @@ at a greater cost than the value of such clean-ups.
>  
>  Conversely, spelling and grammar fixes are not discouraged.
>  
> +Inline functions
> +----------------
> +
> +The use of static inline functions in .c file is strongly discouraged
> +unless there is a demonstrable reason for them, usually performance
> +related. Rather, it is preferred to omit the inline keyword and allow the
> +compiler to inline them as it sees fit.
> +
> +This is a stricter requirement than that of the general Linux Kernel
> +:ref:`Coding Style<codingstyle>`

I have no objection to this change, but I do wonder if it does indeed
belong in the central coding-style document.  I don't think anybody
encourages use of "inline" these days...?

jon

