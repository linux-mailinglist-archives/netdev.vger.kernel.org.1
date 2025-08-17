Return-Path: <netdev+bounces-214384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A2CB2939A
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 16:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D2E3BF723
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 14:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CA3770FE;
	Sun, 17 Aug 2025 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Gg8/gm0E"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B66D38F80;
	Sun, 17 Aug 2025 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755442107; cv=none; b=tyRtf8kumpXrrO2eQZB7UP/zj5/ThtBX8SHSQux1wi09FOvmRVGeCy2XTfWte7elRam4UGA9Q7GD4MvqVq7NRWCd64X1uHv+PEBhLBeJ2aY4Byzgbs8bHIKwu3S9vhN3kBz9Bmlvz5hBUaIxya1IYODWlFRw8ywy7EORwxO5D4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755442107; c=relaxed/simple;
	bh=LZR3aB3y+tiOZpoXlCy/7P5bNxuZ3k8TzEL9EaxB2UA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agWxVlNjDnQVbDhhjSKHWe7xxOYtH1IfxpeDRpL/zR8kpyUUAcuT6AOFCJkHlVfLboGSztZN16MKeGI0SS3wYdQfsGhazYRm4FDqQrBuJVTvWI+AaXH3J9WlPY0kpMIl+gpcoe/H40iCFYWSgvvxB+cLCNB4YDMHypWLwparK1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Gg8/gm0E; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 6F39420606;
	Sun, 17 Aug 2025 16:48:24 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sWzYaDuY1Gkf; Sun, 17 Aug 2025 16:48:24 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E7D062050A;
	Sun, 17 Aug 2025 16:48:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E7D062050A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1755442103;
	bh=6DYfHVIyP3OXUwscPjwu3WrtIU5hORiCvkuUvwAeDAc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Gg8/gm0E85BYCPC4m8JZOILx4Ss+6iuuLjAYBn88p8l76pYZBoND3h923frilNo4H
	 KMO2eEOvtsDNT0vaqyqFHk1yJiUSXHhuXkJAoE730owcdbHzJkXK9Cdf0XiHhj2yKm
	 RZXyWc60+V3aaNBuabeT46M8rb+s2jyiy8YMq13T4hhFNL0lBA0o4M6qt74oTO/xIc
	 6YNMAQOjLzAS1bO4W115961ptVxVYTkisriMkQbmc9JkKYyCfc2y/VTO6NUGYCqLdx
	 6xG9TTA2klYhUqafo6rW9OuD/TvwEMkBm5f1w4dX5AFPgwUa+dfeJ2BX7qfV1qNlDw
	 WPsmLnGl2ZrCg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Sun, 17 Aug
 2025 16:48:23 +0200
Received: (nullmailer pid 2609053 invoked by uid 1000);
	Sun, 17 Aug 2025 14:48:22 -0000
Date: Sun, 17 Aug 2025 16:48:22 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Miguel =?iso-8859-1?Q?Garc=EDa?= <miguelgarciaroman8@gmail.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<skhan@linuxfoundation.org>
Subject: Re: [PATCH net-next] xfrm: xfrm_user: use strscpy() for alg_name
Message-ID: <aKHrttHa0W1RfZjB@secunet.com>
References: <20250814193217.819835-1-miguelgarciaroman8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250814193217.819835-1-miguelgarciaroman8@gmail.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

On Thu, Aug 14, 2025 at 09:32:17PM +0200, Miguel García wrote:
> Replace the strcpy() calls that copy the canonical algorithm name into
> alg_name with strscpy() to avoid potential overflows and guarantee NULL
> termination.
> 
> Destination is alg_name in xfrm_algo/xfrm_algo_auth/xfrm_algo_aead
> (size CRYPTO_MAX_ALG_NAME).
> 
> Tested in QEMU (BusyBox/Alpine rootfs):
>  - Added ESP AEAD (rfc4106(gcm(aes))) and classic ESP (sha256 + cbc(aes))
>  - Verified canonical names via ip -d xfrm state
>  - Checked IPComp negative (unknown algo) and deflate path
> 
> Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>

Patch applied, thanks!

