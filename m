Return-Path: <netdev+bounces-246187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5BCCE5529
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 18:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 234B53009245
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 17:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD336227E95;
	Sun, 28 Dec 2025 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzSqnvPn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154072253AB
	for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766944787; cv=none; b=LqSmHgBa1dedR9o4VvTT0obOJBqhaoHwMDKmoMuwGXhrUF+EYXymW4Ojlej6wGVU4MBxzMpxlbsgNboOlL+m40Y0KDt+EChrFzCvjqKU0fp0dsV2bwHRjdF/PMaSROzYsslP18TRxds/V3sH1U7mPxpJdw+ZNXnKqkAGsPivhy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766944787; c=relaxed/simple;
	bh=ABr9QuCuFpvVEjGLA5zflWNdvKSNMSKsOWE1W8HNYzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rV3cf/bxOmWQynP7tBzjv/fTqpypSINz8eH0+CDT7cMbIuvvmJkJxtVIFrAEvbkCD0W8hn4exgCEmB+iOTIfkbiWPLACe4ahoY0CwE599qKiWJZolVHl1gQyBke4SH5QArpuQn8bhkrSY6imWNov6oiv1+g/K5yt6jitbIOPzfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzSqnvPn; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7636c96b9aso1538737466b.2
        for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 09:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766944784; x=1767549584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V/ARQOXIbK4vcozFQlBAvDR8Ur22ZtFHr6qerGT5Zz4=;
        b=DzSqnvPnN+42jN8l7INHqabiJpWDT4udtoM+w+dVeVxUbhxKZC3zbnLvE9SRU7BK59
         tzGBl9yUluZRZNbO4l0dGAW3vm//TbbUOBWtG9lEZXcaI2xMnRBeScMVEC2zRapdD/IX
         BkpY6fyKyLl6VHyIQEKgaiq/cSAkg4uujDdWpeCpfAYLOc7pzSUdkHMnyb7kcDzGiVnn
         n7Jw44pJNseeIpI8LNo9Ri7o6S52waQEKM7rSSfg07KwX/qhbCg99ZBHJ5bZfC6x20Dy
         L+suwirE9gMAMgBCRzkKoMN1GjXYuAovX5yQLJVlJJq2R+kOyQsdiMPoIkaaHPhKW+TH
         iT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766944784; x=1767549584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/ARQOXIbK4vcozFQlBAvDR8Ur22ZtFHr6qerGT5Zz4=;
        b=m8d8UJnIk3ohBEx2R6b1TRUCY3s0WtsH8K0kZNOghM04HsfgjIMVFsJdk+fkgcq6w6
         iOQO2ddUWf4xMv3Bem+N2dqixEj9WH4n34QXOPS/Rq2jMsg2y/l71A3EGadIRlNbntx1
         0GviM00Hso2hBvLi3MIddbwF9Wkpy8kSrfpdw4kh/OxUveLlycpNXLMqy7ZihE52rir2
         k2iMTXZ92vrM5wopzZcE/oLsRJfhZOS0TrTytUzp85rz7AeoLnDNKcj/Smztin/S2ZU7
         L+YBwSzLHIP8EI5oc/9mAGagGQaGwfr/bn2/x1pnQgGJPZd2GjFnw/XX0GC140tDtnKT
         sdDg==
X-Forwarded-Encrypted: i=1; AJvYcCVVPqtd+z3cC1l4nnQYh+nQwCCQ8Q6yj2SWVYMosDDjFNwikfre0BMqawtv6iqwlRIrkacBIFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg8vMIrD7FBFqUKnCv0m0WYZoGgbnCNXKneEXXN7Zyt5bGo96a
	k/04QVauj/XQ8tzB8CbY7nrcJZaDuhDWgOvFmd7sITpRZOrQ8z1v6DYsM0lV7RFTvQEVJ1GPko0
	L2fT43XelrZ5T3ng9aVU3kgyDeJXufSDSPdeE
X-Gm-Gg: AY/fxX4/tGA9tQjB0lB/w+hOe6rcbu0ytu/3LYsGj5dh/4NdQv6gCGsjuS6xDjcgush
	oFykm3hvUzSktkXolou8m3xHbq7tGtngd1iswD5if+SQKpZbf7nE4riVFiz/xoi+m7JTPIqpNH9
	VsBGcI+zi8Byhgh+HDbjox1Zk4jcZeIZgme6VIY+yEr3unGpgVHVBo7vqo0eo0lbtYNZaSjHmvk
	OxTdARiQxhgKNrHKTVWME7Blbkv1LFehsqYiCxXOZAkgaXPBpsukR+SOQPjXYnTpLyMwyU/qpfi
	0EclXWo78RpWVKxWvd2vabdyC3QQyzVLqXjNuBvqXmzFGwv/t/dO3IlyN01yVQ==
X-Google-Smtp-Source: AGHT+IEjpKXeQCELZ0y3D93JccaLcbcsCsJMzBKlzwHx4rSSOF4PpFJWw69I7R6QVlfuHQJLhsgZt18C6Rdh7uTf/2M=
X-Received: by 2002:a17:906:fd86:b0:b7a:615:75aa with SMTP id
 a640c23a62f3a-b80371a3a86mr2951475166b.42.1766944784132; Sun, 28 Dec 2025
 09:59:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251227174225.699975-1-viswanathiyyappan@gmail.com> <f7840b22-38b5-4252-9663-4aefb993b211@redhat.com>
In-Reply-To: <f7840b22-38b5-4252-9663-4aefb993b211@redhat.com>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Sun, 28 Dec 2025 17:59:32 +0530
X-Gm-Features: AQt7F2ppih5Ccj2k4B7ak3uDByTwQEcqT1aY3KEaxGLvP0C0cSGUUvKLxXP3Hv4
Message-ID: <CAPrAcgOaEt_4V289tiab2T2B7+A9PjizXMPjGL5ogWhNc-MR3g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/2] net: Split ndo_set_rx_mode into snapshot
 and deferred write
To: Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, horms@kernel.org, andrew+netdev@lunn.ch, 
	edumazet@google.com, xuanzhuo@linux.alibaba.com, mst@redhat.com, 
	jasowang@redhat.com, eperezma@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Dec 2025 at 20:50, Paolo Abeni <pabeni@redhat.com> wrote:
> ## Form letter - net-next-closed
>
> The net-next tree is closed for new drivers, features, code refactoring
> and optimizations due to the merge window and the winter break. We are
> currently accepting bug fixes only.
>
> Please repost when net-next reopens after Jan 2nd.
>
> RFC patches sent for review only are obviously welcome at any time.
>

Hello,
   I would like feedback on the design of the cleanup mechanism, i.e.,
the members deferred_work_cleanup and needs_deferred_cleanup in struct
net_device
 and the functions netif_alloc_deferred_work_cleanup,
netif_free_deferred_work_cleanup and netif_deferred_work_cleanup_fn

  I will resend this as RFC if required

Thanks
Viswanath

