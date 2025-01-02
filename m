Return-Path: <netdev+bounces-154843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B386A000EC
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 22:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29BE37A1CAB
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 21:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26821A9B53;
	Thu,  2 Jan 2025 21:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw+OWWXt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFADC18801A
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 21:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735855007; cv=none; b=oFqc1xECVP+1fEAYcTmMsPXjjJniZsDgQ9jqolY/QwQrd0ZtV7hdme5Se6IQNuA1GcRgHLuoWw3gEBGubfJeFhLkzeky9yIxG9wo0N4E4KW8zENNqzR7LvBM913jKYE+3bXZgvySnsC8xtdMkPSi8f1PNwskggHuZlVBa5gUqIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735855007; c=relaxed/simple;
	bh=QFLyxBJafmtDGw8ld0+IP+1jlpAL7/4pM+5ypnE8sVI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvoGwhXNFos3OAtB0G0QNZEnX2sGYj+Y26DpNGhPKM668PGSua/4fRg0mj9kSfW1daY2f8ZhlHSriVrAJMAqzDY1lxYLVxLHmK02aaX+M0IbnV6TKWLBpcHJYbdkQNxqE+chqoo7wYa++mfdy1mSH7BfAN698kqyZiCqL2+Wt1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qw+OWWXt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436637e8c8dso119475135e9.1
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 13:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735855004; x=1736459804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YV5urj80tLHXnBBiz5L3/BcvjVmRKuhPsIYUO3wONvU=;
        b=Qw+OWWXtcPaKqB2Ag5LCD90+3DX/BinjcM6ib0vmA8AJD41vfM8rUdCFoNcgI5C51r
         wKalTPSKelzPjkC4dQhRBI0FLUBHVF0oKCxlpuP1DMG3MkAdfT+Tyb5AmVK0ir9KP4i9
         1DrhYjI7D4tfZjbhojwfsho/3zGsC7v/R2dEHJUQgEgLmljs/DYypLJ16aajV48w/TPB
         xAHq2Ss9VOlpa2kkgmmRyBjgLiUqQ6GzTcWuZSsKZ0IgFR4YbcDnW6ESGNVJ9w3o+O+I
         ZKxqPltD36y8JJS3/4c1i78Nq/YCw63kFIIJbu9cri1K62TBHCFiagaB5KGt/riPWv5w
         o0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735855004; x=1736459804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YV5urj80tLHXnBBiz5L3/BcvjVmRKuhPsIYUO3wONvU=;
        b=tb2okXCEktRlg0UNWqEWgKyqC8kaToPt+0VjwreZahFIvAPFCLyGthUZddpmV/B5yS
         GjT1+uJo5Gz4iKsgyQLoedqWXyXDgFaiUkoOgjoBoEWKEkLtbR6vm3mlOgRCVqnIn/Bu
         9m8K27+j3KnauYRseHYYJMBFXXYTRhHSBw9IBNz4rtuF4Yxw/D5pRxil59Q5BAW3QP4v
         x8e66K6zFI14S99Pmk1sQWcG+YkdWMsCQwqgkk0v7l187rXIB2K+RJ5iE4d1JmpA+u5+
         BmGHwSgALR6le4Vri2WnjQtgIkGnQf7c8ZTxo/GsYiReXkmI8rFVUAZBrWX2Ly9inj1c
         cFcA==
X-Forwarded-Encrypted: i=1; AJvYcCVWp6bNoaq6LXJYiUJePrzShmQybNqE9G0eybqtZ7blNpV9WX+NeIyo0pq9t0SDs/04sJTCWwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy380/UsRu/mHlyY076ycPUnDUmVpwt7YqDmhWCa8X1FVe05bw8
	RSw8QeT9DkNhH2b/Sa43EtZv9O986BYqmjy8y5fz03JRSgCamOf3
X-Gm-Gg: ASbGncvZhXoF6fGZJpy9xEb5q5abLsUs6yNTYvuTbO+39ZJjYGBb5xOnHhmGHQDhXHS
	sAfxVCbjpbUKhn85JeqB9PKDruEqDZlGPzgWf+nIXyQKh0uJz3MEsoSANK4NCpVkPcb9oNaZFS4
	kMC/JUznYtoZPa6sbTJHRJMYvnj0h75ySjShgageo5FcCtOeQd8eVbOU8rLDxD1l1Zaww3d40YM
	OEvtlstRWhiZNpADN02ccL7QAL57qp7lhd61ddm8gwFmq79H+In0hztn/zOPScee0/sY1mry3Kx
	x3IifRQNo3pbwbuMRWiA0A8=
X-Google-Smtp-Source: AGHT+IGkN1xxozwID0cTTI3Jo16J8TSiFCrtAtZ5iDp+6JOIT9zkpHJgfssb79cR29DkxgdnM3b1oQ==
X-Received: by 2002:a05:6000:1561:b0:385:e013:73f0 with SMTP id ffacd0b85a97d-38a22405c97mr41230404f8f.59.1735855004020;
        Thu, 02 Jan 2025 13:56:44 -0800 (PST)
Received: from dsl-u17-10 (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8474b6sm39138787f8f.51.2025.01.02.13.56.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jan 2025 13:56:43 -0800 (PST)
Date: Thu, 2 Jan 2025 21:56:42 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller "
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] Add support to do threaded napi busy poll
Message-ID: <20250102215642.21da3755@dsl-u17-10>
In-Reply-To: <20250102191227.2084046-1-skhawaja@google.com>
References: <20250102191227.2084046-1-skhawaja@google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Jan 2025 19:12:24 +0000
Samiullah Khawaja <skhawaja@google.com> wrote:

> Extend the already existing support of threaded napi poll to do continuous
> busypolling.
> 
> This is used for doing continuous polling of napi to fetch descriptors from
> backing RX/TX queues for low latency applications. Allow enabling of threaded
> busypoll using netlink so this can be enabled on a set of dedicated napis for
> low latency applications.
> 
> Currently threaded napi is only enabled at device level using sysfs. Add
> support to enable/disable threaded mode for a napi individually. This can be
> done using the netlink interface. Add `set_threaded` op in netlink spec that
> allows setting the `threaded` attribute of a napi.
> 
> Extend the threaded attribute in napi struct to add an option to enable
> continuous busy polling. Extend the netlink and sysfs interface to allow
> enabled/disabling threaded busypolling at device or individual napi level.
> 
> Once threaded busypoll on a napi is enabled, depending on the application
> requirements the polling thread can be moved to dedicated cores. We used this
> for AF_XDP usecases to fetch packets from RX queues to reduce latency.

I think it would be more generally useful to be able to set the priority
of the NAPI thread.
'busypolling' is just an extreme version of a high priority thread.

We've had to use threaded NAPI and a low SCHED_FIFO priority in order to
clear the RX queues without the softint code locking out a other SCHED_FIFO
user threads for 20ms+.
That is currently rather a pain to setup.

	David



