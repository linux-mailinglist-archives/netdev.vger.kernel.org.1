Return-Path: <netdev+bounces-136270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A2D9A1226
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F911C23C53
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6A02141B9;
	Wed, 16 Oct 2024 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M95TLc08"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB6418CC11;
	Wed, 16 Oct 2024 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105088; cv=none; b=dumrNzLuyFO2yk4XEXQvI711lyAv08sMvMflfA2KkUeRxpKiHmj6NU3zpl90G4jF56n6Jn0/PjvEAcoqp4TUc8g6qe+aJpU3mtJ8JVn85FXTlHAvzSiz90HI+wfiqrJlN58Ok+xJ8NNvZaW++lAxq3VvGLy+iadYgTjBVjVBAAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105088; c=relaxed/simple;
	bh=q/5uBft7cHmg/92MiyrwwxZd96uqerW0mBxnjZkjY3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPjgCERDfBdMotVSJeSMBEZSnH2JMUtIvH2c5Uk4+hhk524ae1NNhDD8VW7WOFbeQ/44CxQZaRvh/byiquW6SQzo2Eez0UWz/XNUeWpsiOSmcK9GhVXAYIIEfKP3JmqUw1t6ZJIxVHAqNMHrfpIC3OJvDpTYGHqIKDB5KWbekxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M95TLc08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E30C4CED0;
	Wed, 16 Oct 2024 18:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729105088;
	bh=q/5uBft7cHmg/92MiyrwwxZd96uqerW0mBxnjZkjY3c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M95TLc080VzfmTm7IKVktyVWfw5uNWTfWK7XT/dZ6ObeRDJ4tj8B/vprXD10ZChJC
	 iVilSDriZzHA40VnqndR7j/Z40FFV1b2/ArW5JN7QPeOawtVH8RYsC8152QOzyASpD
	 6nTHCM3jokJiESSv1Ue9W2v1mRkV/fDsXlGalFb5LHt/z6vYvM6kq9/LUScftjkPPI
	 x/+jKo4Z0Z9aktbsNZ9B03fKzPDLzr9SRVcY1R6IHDJyKnP7rtGMq7CDAS0qcBYXwL
	 O9+yo8lEqVuYIJJHalPSFwLMs/IAs1QCMy2SrZiucpvqIp2D/dvW6Rwg21/HWSWvUo
	 N8ErtCJQ7a/3g==
Message-ID: <86eb397d-5aee-479c-a021-49ce33b95dbc@kernel.org>
Date: Wed, 16 Oct 2024 21:57:58 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw: Fix uninitialized
 variable
To: Dan Carpenter <dan.carpenter@linaro.org>, Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Dave Penkler <dpenkler@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Julien Panis <jpanis@baylibre.com>, Chintan Vankar <c-vankar@ti.com>,
 Nicolas Pitre <npitre@baylibre.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 kernel-janitors@vger.kernel.org
References: <b168d5c7-704b-4452-84f9-1c1762b1f4ce@stanley.mountain>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <b168d5c7-704b-4452-84f9-1c1762b1f4ce@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/10/2024 17:41, Dan Carpenter wrote:
> The *ndev pointer needs to be set or it leads to an uninitialized variable
> bug in the caller.
> 
> Fixes: 4a7b2ba94a59 ("net: ethernet: ti: am65-cpsw: Use tstats instead of open coded version")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks Dan for this fix!

Reviewed-by: Roger Quadros <rogerq@kernel.org>

