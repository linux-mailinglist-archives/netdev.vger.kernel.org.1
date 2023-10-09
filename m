Return-Path: <netdev+bounces-39147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEC37BE38F
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 16:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B352815AF
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FA318E35;
	Mon,  9 Oct 2023 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fpibxk1D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9PirVOG9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FE018056
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 14:52:36 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E568F
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 07:52:34 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1696863153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UOeWQs9FLdGQo25V9gooBhGER+hpkh0PkA9Q2FoKocw=;
	b=fpibxk1DyYsA06cWfZOb51bUySp2L2lcXkU0Uftj8Dm9eYURx/OlVqZpz6fs3xtha1xQaU
	frpyUjt4m/n206GapXWzBaYd3ypUcW4zIy/yGIhV5doKOhF8GhwHgLe9mbV2D5SNrxRYYg
	Xn39j74AeFIWPYSfw4KTMfJoDbuKjihn102J/Rmx23WzUvSxm6qtawPjwCI2w+EJN/mzO4
	3BArH584vlHs/RnIh9DOo/HWR7pU4QoWLSgWk26h2mZFVy1mBW/bFclpmoUtaIkOUNqzh6
	9JHfaZxGRAmkeBY0TGVHCHLipi5/y714JIHDggrVwdT7MNp1FfGBLwullLbqEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1696863153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UOeWQs9FLdGQo25V9gooBhGER+hpkh0PkA9Q2FoKocw=;
	b=9PirVOG9i1YnWwCzVGjhMMbKpEUDr6SHNu5rU6hxz91IAyG/etQ7m7KxoyIUx11WOmRBMP
	SdF7ZyOgO1MIbADw==
To: Xabier Marquiegui <reibax@gmail.com>, netdev@vger.kernel.org
Cc: richardcochran@gmail.com, jstultz@google.com, horms@kernel.org,
 chrony-dev@chrony.tuxfamily.org, mlichvar@redhat.com, reibax@gmail.com,
 ntp-lists@mattcorallo.com, vinicius.gomes@intel.com, davem@davemloft.net,
 rrameshbabu@nvidia.com, shuah@kernel.org
Subject: Re: [PATCH net-next v5 1/6] posix-clock: introduce
 posix_clock_context concept
In-Reply-To: <992c76f8570de9e0549c4d2446d17cae0a959b77.1696804243.git.reibax@gmail.com>
References: <cover.1696804243.git.reibax@gmail.com>
 <992c76f8570de9e0549c4d2446d17cae0a959b77.1696804243.git.reibax@gmail.com>
Date: Mon, 09 Oct 2023 16:52:32 +0200
Message-ID: <87lecbq24v.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09 2023 at 00:49, Xabier Marquiegui wrote:

> Add the necessary structure to support custom private-data per
> posix-clock user.
>
> The previous implementation of posix-clock assumed all file open
> instances need access to the same clock structure on private_data.
>
> The need for individual data structures per file open instance has been
> identified when developing support for multiple timestamp event queue
> users for ptp_clock.
>
> This patch introduces a generic posix_clock_context data structure as a

"This patch .."

We already know that this is a patch.

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

>  
> +struct posix_clock_context {
> +	struct posix_clock *clk;
> +	void *private_clkdata;
> +};

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers

Thanks,

        tglx

