Return-Path: <netdev+bounces-128349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB997979147
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 16:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278F41C212B6
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 14:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4721CFEB8;
	Sat, 14 Sep 2024 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wh+vxoxA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC624210E9;
	Sat, 14 Sep 2024 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726323176; cv=none; b=k3lOZ0i9NXBUZ9cDkt+bSxAUO5lazMGZqXHkVt+Lq/aX/m8PtYzYn0FpyRerV9fDUjF/K/1YOsXGzwZTu+mY2uGIv39IKeSKdEMiqLht2+8SHf//a2ictHl7E3iaV66FJ09KfMn0hNdHLi+RUn0S69IX1RQT+rg9qutDAZM+dH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726323176; c=relaxed/simple;
	bh=OUWNoD7awRpxEl9pyzhx0ChN/RlHBzUSmYfsZU4Hbgg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTFqn50wbElfPFXBF9h1r2aqbDCKpFgt6UCrWQX9EHZaOE3vyiy8W/npPbLTWvn5XqcuCGNBNUuV974Zvb7fWA4TvFFHFC1pN4K0sJUcGL0mLb8EMgX+W2HbZ9vk4duuuBpR7eEE+YxnQseyl/0cjilFARPljKWsECZj0yhvwpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wh+vxoxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B0EC4CEC0;
	Sat, 14 Sep 2024 14:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726323176;
	bh=OUWNoD7awRpxEl9pyzhx0ChN/RlHBzUSmYfsZU4Hbgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wh+vxoxArUV81MlvJ7XMJ4uoLE0HpX+6thoKTx/cIpAfjj1RpuaKh+XlqKSyLPZS/
	 Oc8kwWefeCSFZ6YOkeRHhDYevDYF+9+xnog6+bRJRylD17Cbg8x87VNOB+B/eBF308
	 rz3vg67zsU4DL19zWCXq2HZ7mOTcev1da+gQtpV6/T6ZhjXnzIzRaXbubw5QqO1ehX
	 TjAIF5mKDNsMR7NXNVLO5oEIeInC3oryLwWNUOCUqxpvrj7xEDxvBnZWXmP9LoVpU8
	 aWgjHwyaRx+1GegkQGkZg/6rWx4o+yK26VxUIfPPXEJ7S/VfGRe0rw3hfxogjC0uvg
	 LCmQuVd2XT6zg==
Date: Sat, 14 Sep 2024 07:12:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Su Hui <suhui@nfschina.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 horms@kernel.org, dan.carpenter@linaro.org, tuong.t.lien@dektech.com.au,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net v2] net: tipc: avoid possible garbage value
Message-ID: <20240914071254.7b376031@kernel.org>
In-Reply-To: <20240914102620.1411089-1-suhui@nfschina.com>
References: <20240914102620.1411089-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Sep 2024 18:26:21 +0800 Su Hui wrote:
> Clang static checker (scan-build) warning:
> net/tipc/bcast.c:305:4:
> The expression is an uninitialized value. The computed value will also
> be garbage [core.uninitialized.Assign]
>   305 |                         (*cong_link_cnt)++;
>       |                         ^~~~~~~~~~~~~~~~~~
> 
> tipc_rcast_xmit() will increase cong_link_cnt's value, but cong_link_cnt
> is uninitialized. Although it won't really cause a problem, it's better
> to fix it.
> 
> Fixes: dca4a17d24ee ("tipc: fix potential hanging after b/rcast changing")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> Reviewed-by: Justin Stitt <justinstitt@google.com>

Applied, thanks:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=99655a304e450baaae6b396cb942b9e47659d644
-- 
pw-bot: accept

