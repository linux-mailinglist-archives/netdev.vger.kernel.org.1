Return-Path: <netdev+bounces-151410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF9F9EE968
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9AF81887BCC
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 14:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D3C21571D;
	Thu, 12 Dec 2024 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad7uNqL+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9CC2135B0
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734015376; cv=none; b=YYp6xXGIoBa9d10HMop1JNgNiaiupxNVcHysq5SqVS5wZLtQ6gi9yc5VqIZfaEslwzPFsXj3rNHGhH+uI7kzD6t4j9FLOLfWB+3zB3NJ5TecvJJmjzhPeQB53XPGbiAIoMkt/gT3GD7xOQzu2lMr2mahMkQJ1gWuOZ8OOvXWsY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734015376; c=relaxed/simple;
	bh=nkMZR0gD1nje/cKqPC5Sl1IYCoTVpNYlKBhLAKGfhOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqfFBeC6Z+BIkQPuj8U0JdX5Kn2Nub7Qe7G+4E9/ssOCEido7riLuc+FeRMS7PUlnT7g/tJsmpLchcFhzEUXZhCeIfGuW3/8I1SlUqcn6WuU7l+1a5nC1I6BFC14kVIlf5wo60suWIdD1dA2xZ6jOuw2fAADzW/fLwtAp7aRjgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad7uNqL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3041C4CECE;
	Thu, 12 Dec 2024 14:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734015376;
	bh=nkMZR0gD1nje/cKqPC5Sl1IYCoTVpNYlKBhLAKGfhOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ad7uNqL+V2MhQ4cf9xK76cSTkY/bm8LgxR5hpAM3SJ4BTi95AlyPuCMbVzu894iVg
	 Us6Mdmmb/CS5cqy2vCpjtsIrabj05CQkqAyyD7ViKVXDaxFuqg8LxXYQ8CQ/s93W5w
	 o9adXle9sVUZ1fsv3rKQ2Mg8Vp5NwvXZsCc7QxF/lMdCkd8gnpikUgarVfCOXLBgxJ
	 /qHqbb5mn3EPlunBmsfIedrI3sgl0iKYO070Hgxkiya7dYFjL5+VcSkK19go6x5Qhq
	 w8Vze8Kqej8McQ+oCfI80nRx6+4+es7aA0ShxqndHmTMjpNSB3EYhml64/rcTl2SW9
	 m5lnJMQ4AyGgg==
Date: Thu, 12 Dec 2024 06:56:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Michael Chan <michael.chan@broadcom.com>, David Wei <dw@davidwei.uk>,
 <netdev@vger.kernel.org>, Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v3 3/3] bnxt_en: handle tpa_info in queue API
 implementation
Message-ID: <20241212065614.189cc7bc@kernel.org>
In-Reply-To: <b0a4f301-9dfa-4785-9468-85f3849db81d@huawei.com>
References: <20241204041022.56512-1-dw@davidwei.uk>
	<20241204041022.56512-4-dw@davidwei.uk>
	<9ca8506d-c42d-40a0-9532-7a95c06fed39@huawei.com>
	<0bc60b9d-fbf7-4421-ab6a-5854355d68f4@davidwei.uk>
	<a1d5ffda-1e6c-4730-8b36-6ba644bb0118@huawei.com>
	<fedc8606-b3bc-4fb1-8803-a004cb24216e@davidwei.uk>
	<CACKFLik1-rQB2QHY1pZ3eF0GYGUCgXFHvhh50DNboXV+A7MCuA@mail.gmail.com>
	<20241211164841.44cba0ad@kernel.org>
	<b0a4f301-9dfa-4785-9468-85f3849db81d@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Dec 2024 19:23:52 +0800 Yunsheng Lin wrote:
> It seems an extra RCU sync is not really needed if page_pool_destroy()
> for the old page_pool is called between napi_disable() and napi_enable()
> as page_pool_destroy() already have a RCU sync.

I did my best.

