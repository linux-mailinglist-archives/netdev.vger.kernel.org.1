Return-Path: <netdev+bounces-110573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D214B92D341
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 15:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875BC1F24772
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 13:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B34193450;
	Wed, 10 Jul 2024 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m33srKBc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EBD192B98;
	Wed, 10 Jul 2024 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619062; cv=none; b=bGJCJnBELEuKsJPuBeOQKCylMCeQVV7ESfcmM9A7esgFA1za/Qx/EYieYOrMi8EkEJ/eWegXsgkAO27M8niMlKHFQSa78THsm9O5KD5WS9PiWidnkSc8UMwZUfZUt74AboOBWbMPrfr0CYUvIXtJptym9notOqNvtKxcgpIAijg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619062; c=relaxed/simple;
	bh=YLWNJAMBEj6wuEjbKu2MzzNMNoT+GkqatSDHG9Byrc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ir/ATMYLlLFffguBectn9pCsA6RftzIhrf5q0Dmhp5vC/Cf5li/7SX0b8LJZ4zeFt/wRjVupx+HCq1q6gZQ3StYqaDggKdm8r/peNn5WjEroR1xIngoyVy8iBrUV3hsFd5hyxD331cqv+3d2F4zEXQz5cbsNVNn/L8mm2P12KTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m33srKBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F5BC32781;
	Wed, 10 Jul 2024 13:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720619062;
	bh=YLWNJAMBEj6wuEjbKu2MzzNMNoT+GkqatSDHG9Byrc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m33srKBcRZK1Q5vXVsDRTMGtm+UM9DyOxNZR/f+uMA+1wDcgKxieAiKLB5g8UQvAH
	 6vUE/q4io+Udiy3avskC6Py3Ypss1vGlzKmqq474M0aGTKYaWz8FV77Y+5A9nPVXKX
	 GSzhGtTneElcSrkAIa2Hpi2P7yjl9WOkqp7Xsh8WtRA73uK62RSJ2fft2vf2qdkspk
	 drvzsrLg/DQWxPI17CIG1urfR347QQCGps7OuZ4lyw0gCmi+8BNCI6KapJiX7fji97
	 RrBv9QVvtAlF3HyM+QkSUPN0vUBM6R0SccMl63X9J2Ug0RFguHS+H5sRdywfpRvhb5
	 ASRKe20xOoPlw==
Date: Wed, 10 Jul 2024 14:44:16 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	keescook@chromium.org, linux-hardening@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] netdevice: define and allocate &net_device
 _properly_
Message-ID: <20240710134416.GT346094@kernel.org>
References: <20240710113036.2125584-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710113036.2125584-1-leitao@debian.org>

On Wed, Jul 10, 2024 at 04:30:28AM -0700, Breno Leitao wrote:
> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> In fact, this structure contains a flexible array at the end, but
> historically its size, alignment etc., is calculated manually.
> There are several instances of the structure embedded into other
> structures, but also there's ongoing effort to remove them and we
> could in the meantime declare &net_device properly.
> Declare the array explicitly, use struct_size() and store the array
> size inside the structure, so that __counted_by() can be applied.
> Don't use PTR_ALIGN(), as SLUB itself tries its best to ensure the
> allocated buffer is aligned to what the user expects.
> Also, change its alignment from %NETDEV_ALIGN to the cacheline size
> as per several suggestions on the netdev ML.
> 
> bloat-o-meter for vmlinux:
> 
> free_netdev                                  445     440      -5
> netdev_freemem                                24       -     -24
> alloc_netdev_mqs                            1481    1450     -31
> 
> On x86_64 with several NICs of different vendors, I was never able to
> get a &net_device pointer not aligned to the cacheline size after the
> change.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> 
> ---
> Changelog
> 
> v3:
>  * Fix kernel-doc documentation for the new fields (Simon)

Thanks for the update, LGTM.

