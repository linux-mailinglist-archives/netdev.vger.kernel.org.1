Return-Path: <netdev+bounces-192126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB95ABE98C
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 04:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE583BC2B9
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 02:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F251223DE7;
	Wed, 21 May 2025 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ng4L1pgX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4994E2563
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 02:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747793383; cv=none; b=bbyz2viUzvUjSactgHBr6cEbuQuKsoX5/0W8Gj1uwv46tob7HliPZLDICDftDc+VemBKtH2AcGLebSYMT6JRd6jG/5VteABRFG4PcweyqbmJcMZNyUmWwBuR4RfcqYUXGW28+RxIktXq55CJs38tm5zhN+FQ0i369ZTuejCm9s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747793383; c=relaxed/simple;
	bh=+zlzs2BloFneggLE9H+uA0yjC3p6N9aPAp5p5Je7mX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCS+aOc3bheXK/TVUfZv45AHik4OwFB5plv0sh+07Ko+Unx/clRTNGfcscxfw/Uk/aC+9aJPXJ3ItToY+F0pnXC/yb+z8YbPNR17H/2cFrmG46G6r2BR+DhGblhfxkxnR31rvLVYpQvmQJGcGF8xOoumcfE1eQ0wC90XF1vJ9vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ng4L1pgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56612C4CEE9;
	Wed, 21 May 2025 02:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747793382;
	bh=+zlzs2BloFneggLE9H+uA0yjC3p6N9aPAp5p5Je7mX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ng4L1pgXrVaK1Hs/242xaTyHsZGPbApt1uUGD/oqNzFdR6xSZlZG6LVr/iZiQd2e7
	 X67LP2olgINQgtGR4tdS2wcDLiqQvOKcCwXULSj8grpGz6S9QfkWYxfd1xUuJC4sYy
	 nSKZZhp7bIsNqPDQD3nKgvVyDkMjKLj27Mvrds3zce3fcX7yJSmUiGJrMjXHmrB7Lq
	 UPTyYen/nx6Jv5GchX+pWibGCFTRQlhs6XBjDEc+A3niHq4wvoiHaAsxYDM382CrhT
	 lZbfSdvgdFMZs45NGopdA+wMJO4kxj14zuqfl5thlamUoPGydqUo3gPCpj68bA6WGk
	 udDNxwdVFb2Ww==
Date: Tue, 20 May 2025 19:09:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: "David S . Miller " <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, jdamato@fastly.com,
 mkarsten@uwaterloo.ca, weiwan@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: stop napi kthreads when THREADED napi
 is disabled
Message-ID: <20250520190941.56523ded@kernel.org>
In-Reply-To: <20250519224325.3117279-1-skhawaja@google.com>
References: <20250519224325.3117279-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 22:43:25 +0000 Samiullah Khawaja wrote:
> -/* Called with irq disabled */
> -static inline void ____napi_schedule(struct softnet_data *sd,
> -				     struct napi_struct *napi)
> +static inline bool ____try_napi_schedule_threaded(struct softnet_data *sd,
> +						  struct napi_struct *napi)
>  {
>  	struct task_struct *thread;
> +	unsigned long new, val;
>  
> -	lockdep_assert_irqs_disabled();
> +	do {
> +		val = READ_ONCE(napi->state);
> +
> +		if (!(val & NAPIF_STATE_THREADED))
> +			return false;

Do we really need to complicate the fastpath to make the slowpath easy?

Plus I'm not sure it works. 

          CPU 0 (IRQ)             CPU 1 (NAPI thr)          CPU 2 (config)
                         if (test_bit(NAPI_STATE_SCHED_THREADED))
                               ...

  ____napi_schedule()
  cmpxchg(...)
  wake_up_process(thread);
                                                       clear_bit(NAPI_STATE_THREADED)
                                                       kthread_stop(thread)

                         if (kthread_should_stop())
                                exit

Right?

I think the shutting down thread should do this:

	while (true) {
		state = READ_ONCE()

		// safe to clear if thread owns the NAPI,
		// or NAPI is completely idle
		if (state & SCHED_THREADED || !(state & SCHED)) {
			state &= ~THREADED;
		} else {
			msleep(1);
			continue;
		}

		if (try_cmpxchg())
			break;
	}

But that's just an idea, it could also be wrong... :S

