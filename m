Return-Path: <netdev+bounces-202587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FAEAEE4FC
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE42189C971
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654A528DF2F;
	Mon, 30 Jun 2025 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6c2sUEV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0F542AA4;
	Mon, 30 Jun 2025 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751302369; cv=none; b=C5YhHHuw53GTbrx7fSkjfYozOV2CzgznzumVHEqVlV2tiv5G5PUA1qTxzaBLl94IgNhmZ4MLerYO+tVk1dE74hbqCZPdOoYR81uGTES3CmBBPchZzV5TQcFmTE2XDKf8HDBMcqzIqgPaZEVIkFp7xNxbO374lpwE9tDzMdWJGYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751302369; c=relaxed/simple;
	bh=ynSULjvftMGEMlk5ALeUVxFoOeZH57lE+BBWW/McDyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwM18Ve1L/yIxGe9xJHFvYscgxwJsPAbbLTcm0vlDtPQCiCq8J8AW6iXX/wEihKZaBZaINCRluosZeATa0+QEGh9WNGObLjiFTxv/DjjSZZXLxmVrwbkdno08+4ihkqAAPjAKsQMInmHKI1kEzJX1py3ppFgkqyrAl0J3kDCS84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6c2sUEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8152C4CEE3;
	Mon, 30 Jun 2025 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751302368;
	bh=ynSULjvftMGEMlk5ALeUVxFoOeZH57lE+BBWW/McDyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f6c2sUEV2lZhr4RcULq52OO0QWjUVVSO3vfJqZW9A84yVZnzsmhTwdSC8stVTEqWi
	 y0mscqT6CR3X1TcasuJQk4tli2MKnFa06KP88RMUZBrbaiCsAR+LRhYaMhnmLGsy0m
	 vQv80hQa7vKFlbUAFLXSRgYy9QoA0BxSKLW325Dj9SVyRaLYfn/bMEbs3m+J9KyTWI
	 ACHS7WqCtYRHnMOO6TSOVagXc6cascmuxySzg+MMkryREWOPAVZBlRo0GubY1IHIRo
	 fFRuz+y5vN8jtz6/RRQtmhBdtz53GFwcBismX2jgLay0nB55/ckuwAM2pLbZk/DYdi
	 yyosxfV32KEvw==
Date: Mon, 30 Jun 2025 17:52:44 +0100
From: Simon Horman <horms@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] wireguard: queueing: simplify wg_cpumask_next_online()
Message-ID: <20250630165244.GL41770@horms.kernel.org>
References: <20250619145501.351951-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619145501.351951-1-yury.norov@gmail.com>

On Thu, Jun 19, 2025 at 10:54:59AM -0400, Yury Norov wrote:
> From: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> 
> wg_cpumask_choose_online() opencodes cpumask_nth(). Use it and make the
> function significantly simpler. While there, fix opencoded cpu_online()
> too.
> 
> Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> ---
> v1: https://lore.kernel.org/all/20250604233656.41896-1-yury.norov@gmail.com/
> v2:
>  - fix 'cpu' undeclared;
>  - change subject (Jason);
>  - keep the original function structure (Jason);

Reviewed-by: Simon Horman <horms@kernel.org>


