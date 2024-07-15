Return-Path: <netdev+bounces-111452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7D4931173
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 11:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E040B229AD
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 09:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71BF186E5A;
	Mon, 15 Jul 2024 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Re0OJe5U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8470186E53;
	Mon, 15 Jul 2024 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721036471; cv=none; b=nJcyVKCps5ovWEeCLzVkErsNWXZ5tziDfiNy+PAwk+zpl/k8A2KkOxEZbEhm/a0xuf06H7pUxnaOIgGL0I6H0WSD0tkWHk77fl8jaAZlmVK41jHRIKmeF9zEI2kcMIRqa8odxFzGTILKvrcPM3AOojm7iaIG4GDEmW4hpdD9de0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721036471; c=relaxed/simple;
	bh=AEai4tRTjpLLxJMQynC7rJSqQSFH7z3lKVFB/znJm0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxllvNLoS4GX6nZi93XRtNNOsFCWTxJNPpbtuYhy2RIKRj5aI9kja6r41h0rtDGlO24oSscNqY9fDVqA6TBsXbfN81pYq6xHq0LJ0PycIuXY6LdsV7vpenc+tOTBOcQnJSKlqJtMRfO7EU29FMasLdj1jxKDjyRapamTNPc7J1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Re0OJe5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD12C32782;
	Mon, 15 Jul 2024 09:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721036471;
	bh=AEai4tRTjpLLxJMQynC7rJSqQSFH7z3lKVFB/znJm0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Re0OJe5Upu2yCWIQNxGahN+p84im4ZC+xPwuDAcU7lA32btwaFLFUvESaTrLCC+Ym
	 +8EJ5hYpVTKB03qr7qZWCc4j7viDn5U7zFyHXOZdGqDRPzWKe69MVWDPK2EK3u7RIq
	 fdkPcC/SRlP1jKND+cSsxUclGSf9jxWqcHnQ5v10f+vc5jHI0RVo6kFm0EuUYKwsyO
	 zcu8XzDREKByGytbo+fCidF98zSEub+UNcFvc8vpwjqO7sXlQDtB7eNNJPfe3uwmvg
	 MoXnLe5zVbbR0ZLQX1D/9Aaokk1x2QQfJCmJVCEJ7Im0iz96ID0d7TnXvz8+AWLOtt
	 BEHkPejXNg2WA==
Date: Mon, 15 Jul 2024 10:41:07 +0100
From: Simon Horman <horms@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] net/ipv4/tcp_cong: Replace strncpy() with strscpy()
Message-ID: <20240715094107.GM8432@kernel.org>
References: <20240714041111.it.918-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240714041111.it.918-kees@kernel.org>

On Sat, Jul 13, 2024 at 09:11:15PM -0700, Kees Cook wrote:
> Replace the deprecated[1] uses of strncpy() in tcp_ca_get_name_by_key()
> and tcp_get_default_congestion_control(). The callers use the results as
> standard C strings (via nla_put_string() and proc handlers respectively),
> so trailing padding is not needed.
> 
> Since passing the destination buffer arguments decays it to a pointer,
> the size can't be trivially determined by the compiler. ca->name is
> the same length in both cases, so strscpy() won't fail (when ca->name
> is NUL-terminated). Include the length explicitly instead of using the
> 2-argument strscpy().
> 
> Link: https://github.com/KSPP/linux/issues/90 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>

nit: Looking at git history, the subject prefix should probably be 'tcp'.
     And it would be best to explicitly target the patch against net-next.

     Subject: [PATCH net-next v2] tcp: ...

That notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

