Return-Path: <netdev+bounces-70471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 999D984F242
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3441C20F52
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 09:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9229067C44;
	Fri,  9 Feb 2024 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSUR8aCT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAC667E91
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707470710; cv=none; b=ufAVCeecPbV5upj9Fr4XOvzDg7CUMAGb+QmVPtDxSlm6owddh+oLwKwEAk4Pso1OEB1/ZSvvCEVuoSgWgMHtuD0BrKfJi38znrZ0sfsx3QSvL3UKCldqHRXxHkXtOoDTP9SYubpod69JvJcKP5OIIE50j2A8cJqznOtr/uTvk3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707470710; c=relaxed/simple;
	bh=nRQYk39RB8l0+IQa9ASOOAYGgErXDK7KqtH+/5tJkxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAwgZA4l2mn2Bm8khqTgbKfA9IZvm0Rf6PHijWyC2PAMPagtkO/x2Ya7HPTbNb/O0gmCt7tSxfBiHqFuT+io0j/QyuB83EkQI1CAuKwrtnrOPRgQyVblfISHvNZDScK0+8kPUIjK4F4Pa7uvlEJh2nheFFAn/4uNJOKli7ppCF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSUR8aCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE473C433C7;
	Fri,  9 Feb 2024 09:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707470709;
	bh=nRQYk39RB8l0+IQa9ASOOAYGgErXDK7KqtH+/5tJkxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MSUR8aCTc6YRL2ZfpviPOgk+0bS6lBzkZikfi4/1zLn+D0A/8vLSlIHEo2kVk7Qzt
	 +ype4H3HUztAfJAhKae4B7eJ9I+7JUGjrAysuXoQZQNyk74V66IYOjoCJgPa27ahKC
	 QCjVzkC/nF3OBDm416K5nIw+PgbWOjVBpnpYd7lDIEHntulZe8OZauI/qyMeSb7/75
	 UGrJy/aEQdGyLh3YXBlKWtqH50AXd4jDPENH1GxqEEurLaAMUnMURniIVlv32CQnYo
	 FVR+x1q5xJt6qiEmL6RNsYtIHUq260H2aWn75uvVEUyWo+uccUqx9bf+VasuGUKpJH
	 IjMq2z1rlTCAQ==
Date: Fri, 9 Feb 2024 09:25:05 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, sd@queasysnail.net, vadim.fedorenko@linux.dev,
	borisp@nvidia.com, john.fastabend@gmail.com, vakul.garg@nxp.com,
	davejwatson@fb.com
Subject: Re: [PATCH net 4/7] net: tls: handle backlogging of crypto requests
Message-ID: <20240209092505.GQ1435458@kernel.org>
References: <20240207011824.2609030-1-kuba@kernel.org>
 <20240207011824.2609030-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207011824.2609030-5-kuba@kernel.org>

On Tue, Feb 06, 2024 at 05:18:21PM -0800, Jakub Kicinski wrote:
> Since we're setting the CRYPTO_TFM_REQ_MAY_BACKLOG flag on our
> requests to the crypto API, crypto_aead_{encrypt,decrypt} can return
>  -EBUSY instead of -EINPROGRESS in valid situations. For example, when
> the cryptd queue for AESNI is full (easy to trigger with an
> artificially low cryptd.cryptd_max_cpu_qlen), requests will be enqueued
> to the backlog but still processed. In that case, the async callback
> will also be called twice: first with err == -EINPROGRESS, which it
> seems we can just ignore, then with err == 0.
> 
> Compared to Sabrina's original patch this version uses the new
> tls_*crypt_async_wait() helpers and converts the EBUSY to
> EINPROGRESS to avoid having to modify all the error handling
> paths. The handling is identical.
> 
> Fixes: a54667f6728c ("tls: Add support for encryption using async offload accelerator")
> Fixes: 94524d8fc965 ("net/tls: Add support for async decryption of tls records")
> Co-developed-by: Sabrina Dubroca <sd@queasysnail.net>
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> Link: https://lore.kernel.org/netdev/9681d1febfec295449a62300938ed2ae66983f28.1694018970.git.sd@queasysnail.net/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


