Return-Path: <netdev+bounces-119068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C10B0953F5A
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56BA6B261DA
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82C933CD2;
	Fri, 16 Aug 2024 02:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbgH4V8T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2752BCFF;
	Fri, 16 Aug 2024 02:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774107; cv=none; b=JXoye0ZSbwT1STMHywr/TUnEneWt3gJ5CS1XwTuO6CvANg+Q51v8gMfDNvihdX6BSvZIw/38sF+Z+oTuaqZTI9Hupu5jjBOr+U3PptCD++HGguM30IWtod4K99N1lgAXpOGiZci2OMJ8jZhhtLhRFcJ/+6rqA2TUlKmIP+bYG+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774107; c=relaxed/simple;
	bh=cIrhdi39QhQ4i5z/+k9PT/2FC+Gsfhw4E9FmG2nYGEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fb+M+H84nNpZXoQqDp3SXsQUBV7fZB+4S7u1A1r5cGbVRy8EvKjbysj9JJKpmEeGEbhehVW2G83848Wj6lPOZXgCVU/hbwzB+0ejET7SPIJ3SalNRAHc5x9msg6aidI9FF4hGNtfIcdHoq0TBpQU7BApyqHwF2TShlNBioV80Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbgH4V8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5939DC4AF0D;
	Fri, 16 Aug 2024 02:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723774107;
	bh=cIrhdi39QhQ4i5z/+k9PT/2FC+Gsfhw4E9FmG2nYGEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AbgH4V8TsKNl7XLHx4SXwsCiixI/xwgVeWEK6nOljaJMk0TQfPGeca5ACoNRjpeHp
	 6GCbVXNixQ88IVrV9hxHrEBFH3ZC9mGX+HsOPFwkJaAMjGGgcaQjRYeAK36kWLrvZj
	 HgJOLgDp32sr0iHjpEbKgI+gsxPvOeY3U5Yp2sYNU7XPHzgMvuEEIzRLWW9fAIj/52
	 +nMdApXuzNGIBZYjMo+jFy7vlYRRJ+QI1j8ln6lWvrlLwNX0a4hCV5faC5185KTimN
	 P0R1UXnNjE2vcJ2LQJ31i4Rvek9N+RTwif5RP4DV04pD+gZcuD0Eb9K7nVf4HlMCaT
	 aNa2CKxxhsGZw==
Date: Thu, 15 Aug 2024 19:08:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] nfc: mrvl: use scoped device node handling to
 simplify cleanup
Message-ID: <20240815190826.076b7373@kernel.org>
In-Reply-To: <20240813103904.75978-1-krzysztof.kozlowski@linaro.org>
References: <20240813103904.75978-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 12:39:04 +0200 Krzysztof Kozlowski wrote:
> -	matched_node = of_get_compatible_child(node, "marvell,nfc-uart");
> +	struct device_node *matched_node __free(device_node) = of_get_compatible_child(node,
> +										       "marvell,nfc-uart");

The 100+ character line mixing declaration and code is more than 
I can bear. Sorry.

