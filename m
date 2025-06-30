Return-Path: <netdev+bounces-202620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3814AEE5BC
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686BC441433
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC55A2E3B09;
	Mon, 30 Jun 2025 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YETbN4qM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F452C3273;
	Mon, 30 Jun 2025 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751304300; cv=none; b=feLGTdTuQlx1mt8Qhl+zapIu0BqPBSMFQ2KuzmQsDLrJtFb/57gx3xBtA9avk07FjsIiKXJlaIMi1SKqTHTTuxV5YQ6yoaviFq1VaumMMkxT0KPqDimSYLROGnWImR0IRzhyuUt5H7cZCuZdVmGJDSlbkw3TCFPb6l/48ErCqos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751304300; c=relaxed/simple;
	bh=uehCu0PQ3Rt5UP3Eqg8DxWd06wirGlh5cnhD9O7bFeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXyNK8N4nvLmoyuajOVfXO3XbAaEKLZcbHFVorNHLUkeg80cwM/ANQO1/f32E8KtQeuJ8PsrauVT6ftdjq/9P8TglVgJSBIcjnJNDfF5MaLzN7xV7DNtHjJFNmc8Qn1a4wIJHknEQp4aRVlTV4MBrpXTn4YuyOb135b+31kXcis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=YETbN4qM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5EEC4CEE3;
	Mon, 30 Jun 2025 17:24:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YETbN4qM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1751304298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mmwZNE2u/jLWQ97nyzsa8bOnYBvTHITQRZ6hjwPm9kM=;
	b=YETbN4qM+f1cBb669m1/hT7Q4hRI2+0z525cA9bYYlRfOYah39n5n+zgwzsVs0gbBi9NIU
	M0yaSxKCDBssANSv6sXIfguOLhdf2+vNn3N+VpC3WaXidp2KGUdR6N0dutVq2bSHWVo22D
	ft0Ay9OF7nLQl4y180ov5VQDK1aOpS8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 21b57f64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Jun 2025 17:24:57 +0000 (UTC)
Date: Mon, 30 Jun 2025 19:24:33 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] wireguard: queueing: simplify wg_cpumask_next_online()
Message-ID: <aGLIUZXHyBTG4zjm@zx2c4.com>
References: <20250619145501.351951-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
> 
>  drivers/net/wireguard/queueing.h | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
> index 7eb76724b3ed..56314f98b6ba 100644
> --- a/drivers/net/wireguard/queueing.h
> +++ b/drivers/net/wireguard/queueing.h
> @@ -104,16 +104,11 @@ static inline void wg_reset_packet(struct sk_buff *skb, bool encapsulating)
>  
>  static inline int wg_cpumask_choose_online(int *stored_cpu, unsigned int id)
>  {
> -	unsigned int cpu = *stored_cpu, cpu_index, i;
> +	unsigned int cpu = *stored_cpu;
> +
> +	if (unlikely(cpu >= nr_cpu_ids || !cpu_online(cpu)))
> +		cpu = *stored_cpu = cpumask_nth(id % num_online_cpus(), cpu_online_mask);

I was about to apply this but then it occurred to me: what happens if
cpu_online_mask changes (shrinks) after num_online_cpus() is evaluated?
cpumask_nth() will then return nr_cpu_ids?

Jason

