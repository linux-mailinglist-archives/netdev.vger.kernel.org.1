Return-Path: <netdev+bounces-145537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6049CFC54
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 03:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6C2BB22204
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 02:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD36422071;
	Sat, 16 Nov 2024 02:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JB+Dopj1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8190A47
	for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 02:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731722949; cv=none; b=tWKdGeRDScYyGLcl8FbvRvvhoLn4AyezF30EVvK4YrLkob3MZFViWoyI70yd4bKnNm7pkTbdqYnLpdIaoTZZfChbb/xerj94Soe0TnP2cwlCWRgHEkIqiXw8XiP5cxmfr7hCwkH0SRHX50isNo9mqrAjpalmawG8UcahjQ7fBwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731722949; c=relaxed/simple;
	bh=qoB4qNBzwfJdyD3U8KwXfQ/jC9rd/wyyebJNSBqWKcM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQYGNtIHpTDGpyT6X5+JpXT48hnDvVkBoPS+ByPiRqm+3zhiGeM4ioEgd2CRQ8p6kB+zeWGcg/KKLFWAThKDKcANvPvybdNiH+GIxpuSQmoarK7r+h0tjHbINrlmp5nowdL6In/Z7L/0fJxZmyRBV/CN3yyi3ahk7lcmEvl/YRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JB+Dopj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A66C4CECF;
	Sat, 16 Nov 2024 02:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731722949;
	bh=qoB4qNBzwfJdyD3U8KwXfQ/jC9rd/wyyebJNSBqWKcM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JB+Dopj1Vi1Pz0hQBbvTkxlfRwwycA+5EEYaPas5FCgvYsvfU7+AkWQHezrj5Qd0t
	 w59tYf0JrHizhTUPHlVK4xHVk0KxC6raURrb/P49oy6XvWKw7QuWhQHc6O14XsyhBh
	 ibIn0ckjsA61MIxkuGq+240dQpbUJClLQwNCABBix8bGSgcI2TAng7y6nqL/xT98PF
	 JnZmQsxk9ITHAkwy1Ax5bc4rwmtP/Hf7qfdZRV7HVW/N5yT13b7dYc/PpDJLVWN/QW
	 +ekiBSI4876X+Gdg15ZrVTfw/j7tX/oYSVkPfx98SSG6ZsgdgYAurd04O8nzAT7Ktd
	 xiLw21ATGp1BQ==
Date: Fri, 15 Nov 2024 18:09:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: David Miller <davem@davemloft.net>, Herbert Xu
 <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 01/11] xfrm: Add support for per cpu xfrm state
 handling.
Message-ID: <20241115180908.1d2c2108@kernel.org>
In-Reply-To: <20241115083343.2340827-2-steffen.klassert@secunet.com>
References: <20241115083343.2340827-1-steffen.klassert@secunet.com>
	<20241115083343.2340827-2-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 09:33:33 +0100 Steffen Klassert wrote:
> +	/* We need the cpu id just as a lookup key,
> +	 * we don't require it to be stable.
> +	 */
> +	pcpu_id = get_cpu();
> +	put_cpu();

Why not smp_processor_id() ?

> +	if (attrs[XFRMA_SA_PCPU]) {
> +		x->pcpu_num = nla_get_u32(attrs[XFRMA_SA_PCPU]);
> +		if (x->pcpu_num >= num_possible_cpus())
> +			goto error;
> +	}

cpu ids can be sparse, shouldn't it be checking if the CPU is online ?

