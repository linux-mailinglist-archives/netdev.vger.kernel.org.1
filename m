Return-Path: <netdev+bounces-224999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C63B8CD77
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 18:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B7D5656B1
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 16:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1360228368A;
	Sat, 20 Sep 2025 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipHxqFzg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CEC223DF1
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758387147; cv=none; b=QiOgtnIEAe3jF6OuSYidez3xpVRZQUrlkzBW0V1yWKnPAnv4/YaAQmToQrt/RYujjX18RsESEjAvBZW4XKFWZov0w30LsKWh9CNppu35SYtnRa/NeDdmYUtdSA1Mi1l2wVf6E6CoGTMAOvA7EMxwS/39KElj+OZWYvIOjKXYaIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758387147; c=relaxed/simple;
	bh=GWpvS5x6cG1Y4f2S24NEW8dN0quQ/cx+TBhU9hoDln8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0v0fQYtFqfQ4TgJp3mBJx7LEW+BV/BTg4916+40KEoiIWGAJskwLsXC/6e6buqRjEiKObC5W1wDa731bI/TnD67Im1Cw8rmxkA1lmp3j2b8tJMpl95WIsfcnzYn+5lhedpQIR7gmS0bRAY+50qICdY8jNdpIqYLU12Xjt2mN/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipHxqFzg; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso5606065a12.3
        for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 09:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758387144; x=1758991944; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6t0lvNAvBHvFjIYOZdnPwHv9uI7zn4mkRak4VLc3x+o=;
        b=ipHxqFzgmWoxFnQBawz23NUMuyU0ry9vKhPQg5SDsvLh7zDpF6y8iv7WehZmb5f6+M
         91kdYgsLlAALngU2ik9ua4TeCacnnRGXgqrvBlukiESsLAwhrP+jnn1s2uiSAvSTKXr0
         oLu49Fmz5FXaABpW8TZzLAUvrkIcqoskVU876JuWQM74ggnaaBfsdJ4Kd5IgDFg6fbiu
         LfdlpMWQBDpJUMCGYWLHC8uBFT1Cm3QdUDlX9bdmHqUd8qxK/Bnu8M54fnIivaELmfiS
         Y/fGCHn18bCEwhtRl+sk7Sacl8wKNaXj5ZOz3aTRnd9SicgFJ0Z77s5+KupjlUQs1gRw
         1m2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758387144; x=1758991944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6t0lvNAvBHvFjIYOZdnPwHv9uI7zn4mkRak4VLc3x+o=;
        b=JAQXcLKFtTO7eDyrtcbkat9gxdjG07V2T4Y6Hmw11k5d+raUBXggjF1HrSSwESjlqk
         8R2/HRnYO1VjVPKobEjhQHg1ovCdt8WWH+40J4WtJln0Es8zT2lJaYXKNAd7PnBeGRug
         AUWsnZFBEoWYgzCMSQkW4qXwu/4QuXd7Rkf/C05lWyASDr1wFpegu2hVKnLjnKp3Hb99
         G+YylQTb++df3HUihgC4d92IizOP38WcqXW0d0Y2PVNPWs1vTL9wC3qIzZ0UFuT0CY1e
         owPxvmjOZzCyZAZHpHDArhm8LVfoP3NEcYvgw3/m5LZPDdxrkgeCIQaz9ePwtG3Rma8f
         tnsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkILZrFUG6uP2T3/Wv1B/vGCherhJP2WaGt31S/uTv/gWs5YX0uxHTtb8CsKZRl4BSMOiFzaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE0MvLwHXRXer+avoUkIUMpvHb9B7A8kN80hiagbWcmL2cr7vm
	40A4CrnAZ3/u7orPrjkHrCSe5sm0EbreeMYEFpbJLp4qIC9n+NHp2hN+9AP4i7XhmNQy3ywOoFc
	6zVDeSSxC4DXLRVU6wrUxC58OW+aGBqM=
X-Gm-Gg: ASbGncsts8sR+VqqzxUIKRA7BID5T3Q8neVpYCz+mAWWiV0TOojdR5Arn7Jy/AmK7qd
	aZVGeKtonUpUgA6p4uzafhciPnyZskcgj5h/vXvsCOzn9y4teeM34ZUlgQPt3vJbBlRdu+yHiQh
	1YfKJRmr0gzQDC+Wo0QU5gn2fw2V4pMKYRxCXDVeu8PQ2pH9rx5UM0KufrSJ0iYaN7qBVxU4L9M
	daw1lQzi3SFvRz80LFX0whg7xBNOWzOD2W25hJ7VI2VyDwtFn1ZwVdZIiuhmeA345o=
X-Google-Smtp-Source: AGHT+IHHbxws3SREQHUm9DXYPSh1lNZGC+x8Xy2uJwCBquseYOMfarK/RwziU8Ml2w72ef92uUul+cCZANWL5gTtfzQ=
X-Received: by 2002:a05:6402:1e96:b0:62d:6cac:1ec2 with SMTP id
 4fb4d7f45d1cf-62fc08d2120mr6186264a12.4.1758387143494; Sat, 20 Sep 2025
 09:52:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920045059.48400-1-viswanathiyyappan@gmail.com> <5b51d80e-e67c-437d-a2fc-bebdf5e9a958@lunn.ch>
In-Reply-To: <5b51d80e-e67c-437d-a2fc-bebdf5e9a958@lunn.ch>
From: viswanath <viswanathiyyappan@gmail.com>
Date: Sat, 20 Sep 2025 22:22:11 +0530
X-Gm-Features: AS18NWCYwk4g8GKTtmeraqfyKpXAyJkc7cnfC3ztEpzTK4PVyVgiyuigIenJluQ
Message-ID: <CAPrAcgOb0FhWKQ6jiAVbDQZS29Thz+dXF0gdjE=7jc1df-QpvQ@mail.gmail.com>
Subject: Re: [PATCH] net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast
To: Andrew Lunn <andrew@lunn.ch>
Cc: petkan@nucleusys.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com, 
	syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Sept 2025 at 21:00, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sat, Sep 20, 2025 at 10:20:59AM +0530, I Viswanath wrote:
> > syzbot reported WARNING in rtl8150_start_xmit/usb_submit_urb.
> > This is a possible sequence of events:
> >
> >     CPU0 (in rtl8150_start_xmit)   CPU1 (in rtl8150_start_xmit)    CPU2 (in rtl8150_set_multicast)
> >     netif_stop_queue();
> >                                                                     netif_stop_queue();
> >     usb_submit_urb();
> >                                                                     netif_wake_queue();  <-- Wakes up TX queue before it's ready
> >                                     netif_stop_queue();
> >                                     usb_submit_urb();                                    <-- Warning
> >       freeing urb
> >
> > Remove netif_wake_queue and corresponding netif_stop_queue in rtl8150_set_multicast to
> > prevent this sequence of events
>
> Please expand this sentence with an explanation of why this is
> safe. Why are these two calls not needed? The original author of this
> code thought they where needed, so you need to explain why they are
> not needed.
>
>     Andrew
>
> ---
> pw-bot: cr

Hello,

    Thanks for pointing that out. I wasn't thinking from that point of view.

    According to Documentation, rtl8150_set_multicast (the
ndo_set_rx_mode callback) should
    rely on the netif_addr_lock spinlock, not the netif_tx_lock
manipulated by netif
    stop/start/wake queue functions.

    However, There is no need to use the netif_addr_lock in the driver
directly because
    the core function (dev_set_rx_mode) invoking this function locks
and unlocks the lock
    correctly.

    Synchronization is therefore handled by the core, making it safe
to remove that lock.

    From what I have seen, every network driver assumes this for the
ndo_set_rx_mode callback.

    I am not sure what the historical context was for using the
tx_lock as the synchronization
    mechanism here but it's definitely not valid in the modern networking stack.

Thanks
Viswanath

