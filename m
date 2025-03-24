Return-Path: <netdev+bounces-177244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A2DA6E676
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A0918960EB
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AC81EB9E2;
	Mon, 24 Mar 2025 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jUG+VDmU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFF918B464
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742854550; cv=none; b=XmY0tnYs0GcoztFqibjfsGcmX1tMszulUor9bbh21ywOOdZ9E/P1o6j/Ie4Z4RNGQNuCiYda9lxLYaWRKhcw5o4Rlvx8uCmYNX1MONLyHIaLB5bxvwtgKattVTO+Jrymct1Z4dMNjoGZ/Ly80iHeRnHLecHZE4FuY9UiXApJTIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742854550; c=relaxed/simple;
	bh=e/r4Zlp/KHSwdvwEkIA042d1FAjKutPhBALAVYylnJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kh1bJPZ2Hpuif7t+S4uc+L1Xizn3pcMAM6e2HZwJ2pb9Vb1po9p4pOwFdDP1CIEAU1qPdSeAsOFzC15elLWwz6sGGev5HuCrRlBwrh/xALhed3hRgBXEOwFBnRZ/Qsg4bc9TKCvg1IGVHCDmy+oOYVcCYmaE52ZpIoMU+fyUJsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jUG+VDmU; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8fd49b85eso78175416d6.0
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 15:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742854547; x=1743459347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LqCK4xrieYy8rHSMdxk0HMnzbYnnEsVe7CVfVt5N210=;
        b=jUG+VDmUNoV0CH8XZxglb+ZpiOmq6NTrnjn+9mGZk00XjGehUgWMMLN+rYUWvYx6NP
         l1kPyDiDtgYgjAW4sUcyJ3caT0rHiDGn8RnmDz1dUvUqqP5ju7kFmVHCstGnWI3FmmKT
         NMFuXGPjwDhRL6/+YQ4cMEQkFghCjC9vpI1kY7omXtgKRck8SuW52gdq/wydMlsyJBJs
         6LM6SMGIXqKJjJGCosKlBwNNTBHM9fSw91zKT0V6Rl+wpnTzal9Cz0xfpB+T7RLG76+Q
         Q5bUxTO1kDqkIuXYubFDC8b20zipg2RXfzctIMfshfQJ9bPxJKdKfm5tAw/UsykCwE3I
         2Ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742854547; x=1743459347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqCK4xrieYy8rHSMdxk0HMnzbYnnEsVe7CVfVt5N210=;
        b=JtbrsUcCoaqLAXyepkyYBbwiLVhMBaJ3BhErzUzP33JplGsgpDYtydvr7IuTWdpC2R
         U1rJH3LU7ZToqrQqeVCEzr3ZSx/KNKIs/+zxHhI3JtnemNmY1ipmQ50fooCrCbrlKxD2
         12K8/eMhUVlj7OedZcyNsnKgE3hV/MgPKHCYiG0IRKmjFSkaqvjFzNzsXaELMbMWbpqU
         HoIJXWxA693oExksRzb96b/wxWzHrW01sXVLVYfiRkf9PW+X6ekK5oOxUJcC8qfHj63f
         U0+FUvtgY1laLRs+2NeER91B1yEN8CmXGf2XTbFEa6toop74nV0RfAO8ddB0WSL/XZPv
         v+DA==
X-Gm-Message-State: AOJu0YzsPU7ViFJRGBJFriYd7qVe1E5tmslmmb7LAU2tX+t4kHYFEeQA
	s2Y6qV9RGB+WWi8hELKwHq/V/Qd0gaiJ3ekXzQwCI3lAR5vBagFMXC+I34hobUA=
X-Gm-Gg: ASbGnctsMjuik6rlpTn1IRXv5LwY4PT/ckW8NWjT9S60MIDr18EYOkzm+b3QxNz1d8D
	ByWvCBiLrFcAj1Jj1S8r4bt0UUuxQOWWY0aLTEEnD2+1gxM9Qkvsw1+MR9YdIHuNJjHhDz4Nc4+
	A/JE+B6h+Ubn9QgOAcrrFzbjdE7Ct3lCZ84ZwyNo4QCu6xySFx8zU3SNPkU8ppiOGMLbRKP5Dr+
	XbGHpG/73oAainRUONrPBNiOFk/SWf/B+1QFjFrEwjA2xLODElHrmZJNX1ogEX1Ovm6MNZamDs1
	SyXPuGjgC5L/UHvE3vMIHS8vdPcdBDCW5jzNKB/E77eL/5Bs+A==
X-Google-Smtp-Source: AGHT+IEQMqkj+FtpcZxgGtU488+dXoq+VgOKiN+59B24M1O2EfiLKvd38B84Qx7Els7TCQbDEjBbUQ==
X-Received: by 2002:a05:6214:f65:b0:6ea:face:e33f with SMTP id 6a1803df08f44-6eb3f2bad2emr231217546d6.3.1742854547178;
        Mon, 24 Mar 2025 15:15:47 -0700 (PDT)
Received: from [172.20.6.96] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef1f51esm49592736d6.26.2025.03.24.15.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 15:15:46 -0700 (PDT)
Message-ID: <fc0f1f19-f7e6-45d8-abff-a98305ce5bb7@kernel.dk>
Date: Mon, 24 Mar 2025 16:15:45 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vfs/for-next 1/3] pipe: Move pipe wakeup helpers out of
 splice
To: Joe Damato <jdamato@fastly.com>, linux-fsdevel@vger.kernel.org
Cc: netdev@vger.kernel.org, brauner@kernel.org, asml.silence@gmail.com,
 hch@infradead.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, open list <linux-kernel@vger.kernel.org>
References: <20250322203558.206411-1-jdamato@fastly.com>
 <20250322203558.206411-2-jdamato@fastly.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250322203558.206411-2-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/25 2:35 PM, Joe Damato wrote:
> Splice code has helpers to wakeup pipe readers and writers. Move these
> helpers out of splice, rename them from "wakeup_pipe_*" to
> "pipe_wakeup_*" and update call sites in splice.

This looks good to me, as it's moving the code to where it belongs.
One minor note:

> +void pipe_wakeup_readers(struct pipe_inode_info *pipe)
> +{
> +	smp_mb();
> +	if (waitqueue_active(&pipe->rd_wait))
> +		wake_up_interruptible(&pipe->rd_wait);
> +	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
> +}
> +
> +void pipe_wakeup_writers(struct pipe_inode_info *pipe)
> +{
> +	smp_mb();
> +	if (waitqueue_active(&pipe->wr_wait))
> +		wake_up_interruptible(&pipe->wr_wait);
> +	kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
> +}

Both of these really should use wq_has_sleeper() - not related to your
change, as it makes more sense to keep the code while moving it. But
just spotted it while looking at it, just a note for the future... In
any case:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

