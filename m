Return-Path: <netdev+bounces-93502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B478BC18E
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 16:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F132811AD
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 14:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96722D03D;
	Sun,  5 May 2024 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZbApSiX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8590C2C1BA
	for <netdev@vger.kernel.org>; Sun,  5 May 2024 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714920885; cv=none; b=HyCJeE4EwxfwegoNx+/+E3MKf4xF6bJjoDvK3gHEbGKbKcbY48Ym2sd/Vf128Nm+TaU3UpozM+PnXHduUjqW4OgW4H4jV39PfFgPSWviii7oI1/sb5Sm2lJgg6cer1ZcLaW7rViUUu/SXJqTpG0Vtwm7P0Y5KRbsqLWbdLmUQGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714920885; c=relaxed/simple;
	bh=RpyBGyWv3U6DS168T43Y1lTadnlU+wGe0TSSo+0VXlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9EBPken1GSGAmpI2N+khwmUI5q1c5hbY8y1hMrPCjWoZy+Oi+ZsF9y4D7KnKwm3SDs0sFQSeMtwaxREFTyyTPTOS9txC2CrD+4q+WGTUnQNABqM+bO0Mzrt39n6NxN0KZIBeADtQEeZ8V8amJBkZDkSLsvBrrmav6ISt6fvexs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZbApSiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9580CC113CC;
	Sun,  5 May 2024 14:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714920885;
	bh=RpyBGyWv3U6DS168T43Y1lTadnlU+wGe0TSSo+0VXlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZbApSiXzI4+JyrGxqBo7Zhx04OKRS8vnigr3vSl0haLOcOhbVGiQsAsTIY3ksCoL
	 rLmzFxWfzVyxkfUqiU+fl5d8a+4pNKon0mrnoEZxoWGSXn65DbUKMaLSfHlGAG3x7W
	 coQGBgTlbc9EjHGB7KzEIRVIxbTMlkLY/VwXMVuAtnqdgqRU91l/oRvDoftAkQX8lI
	 Tx2ubUZecOu+eWDXQ/SRKAZ4xC4fsEi8cRHBISBXuddTISdOXOCF5UfdmV8A6bGTxC
	 2PSL+BVc2VuPOzEeh0b16U2Mcn9ioAef2M9+JiF5dsMR+NW3qWDNw+9fJuNst65WOh
	 qu1q1DkpZS9DQ==
Date: Sun, 5 May 2024 15:54:41 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 4/8] net: write once on dev->allmulti and
 dev->promiscuity
Message-ID: <20240505145441.GH67882@kernel.org>
References: <20240503192059.3884225-1-edumazet@google.com>
 <20240503192059.3884225-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503192059.3884225-5-edumazet@google.com>

On Fri, May 03, 2024 at 07:20:55PM +0000, Eric Dumazet wrote:
> In the following patch we want to read dev->allmulti
> and dev->promiscuity locklessly from rtnl_fill_ifinfo()
> 
> In this patch I change __dev_set_promiscuity() and
> __dev_set_allmulti() to write these fields (and dev->flags)
> only if they succeed, with WRITE_ONCE() annotations.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


