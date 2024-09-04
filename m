Return-Path: <netdev+bounces-125145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E1F96C0B1
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 16:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9723D1C2515E
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377781DA0F3;
	Wed,  4 Sep 2024 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7uwX438"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8B61E871;
	Wed,  4 Sep 2024 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460387; cv=none; b=BK8n1cW6dwNzvItWfNtNCKwUcketJ4aYxD6r+WE8V7O0JU35MyZgSYjdyGz/zIboXb9Aao7xXsrsAVQl+DhwkOmmahT60OK5ggDfgyY9+7eF2iN+/rwzHw+eYLXukHiqaISWesaZDIQ6vm3kRGIww5/kQ72R7NO+z4CyYCvU67I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460387; c=relaxed/simple;
	bh=VUbS/eWYRXe0dzCozXBddttHq2IEobNfmyTbrqxR/Os=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8YFuXFGLzUp3UXLfXwTVnHFyHAyjnC+tHVYQp7YCs8Yks8OwDZEzgA92DSTajRCH+lfht7BZlmgbdIoPQVuJavJElK0e3pJ8aMRU+M+azhLAJNnnC6pHXyhGBdGYvEPlqOM2FczvheYl/gUMJ5C/cXfXE2qqadRtWT4VCHiBA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7uwX438; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DDDC4CEC3;
	Wed,  4 Sep 2024 14:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725460386;
	bh=VUbS/eWYRXe0dzCozXBddttHq2IEobNfmyTbrqxR/Os=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t7uwX43896GPIxki0muQXweDYB54v/1SPHpACh01PFqn72a+X36LUDDCdZUMHQMRa
	 xpmI2grx6hD7TzrpAVWiGW0LokIBvYGbHyaf5kDUVWbkP6Lm02Kjk1PQAJNNngqNMq
	 mdUUdJl1boptWdKFxnNw7N4pbCR4CDVYUua6GjD9cZA81RcZeWgRlXFfM7kSBpw1bD
	 NwOGWdjFTYrCi5QZ9miLcwFtsymah2qN1sDb3ii7xXocDz5UBwonBeJ0y3j9gPz3Vy
	 cdArN77dyvJ45QDL9tIKMCzUY6Crcbe9DdtvcEsXhQagGQfUOjWx0acyFy8t4m71uI
	 Knx3nrcGGuj8Q==
Date: Wed, 4 Sep 2024 07:33:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Andy Shevchenko <andy@kernel.org>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, <kees@kernel.org>,
 <jasowang@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <akpm@linux-foundation.org>,
 <linux-hardening@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-mm@kvack.org>
Subject: Re: [PATCH -next 2/4] tun: Make use of str_disabled_enabled helper
Message-ID: <20240904073305.7578f81b@kernel.org>
In-Reply-To: <56a4c8ec-2cc1-4078-b5d9-fb128be3efeb@huawei.com>
References: <20240831095840.4173362-1-lihongbo22@huawei.com>
	<20240831095840.4173362-3-lihongbo22@huawei.com>
	<20240831130741.768da6da@kernel.org>
	<ZtWYO-atol0Qx58h@smile.fi.intel.com>
	<66d5cc19d34c6_613882942a@willemb.c.googlers.com.notmuch>
	<9d844c72-bda6-4e28-b48c-63c4f8855ae7@huawei.com>
	<ZtcmjI-C3zfqjooc@smile.fi.intel.com>
	<56a4c8ec-2cc1-4078-b5d9-fb128be3efeb@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Sep 2024 10:27:18 +0800 Hongbo Li wrote:
> However, with these modifications, I'm not sure whether Willem and Jakub 
> agree with the changes. If they don't agree, then I'll have to remove 
> this example in the next version.

This and, to be clear, patch 4 as well.

> In the future, we can guide other 
> developers to use these helpers directly instead of rewriting it themselves.

