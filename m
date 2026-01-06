Return-Path: <netdev+bounces-247339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DF1CF7E22
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 11:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DDFF3047DAE
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 10:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A2633AD90;
	Tue,  6 Jan 2026 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXIs3TeH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93497338F35
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767695312; cv=none; b=HE5MlfwV659rHRCZ88jqs1AM116vK7DKqS2eI6e0h+znrEzhyCp5uJhcIVYG+H53THS9ey9KHcE2md1iuCAdTNwP8YRjZ+Q2PbDT4rY9BQJAC/ZJmNo1ui3YDgeBHymEysmel790GU2++k8YR38ESyJ1Zw9rSpd0NsHwlEccChg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767695312; c=relaxed/simple;
	bh=nEu4WOz+vtpJU2TGs6EPbQkaMhnf0O8StNk988KhUnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCpO64bq8Datbf1Owy1CZ4IHfw5X6moOTskO235W3dQVS/qHdKZZDrrsB3FHLq2M01P6B56YUscgBhoFd77iFtt1Xhgojro2MMMcPjIuVtpeyDwCFybodrbsSFeIYWarcjyMUyzyzK/0V226TnGq5YY5UNhlNF1fUIVqdhHDoH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXIs3TeH; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b9dfc146fso1392752a12.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 02:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767695309; x=1768300109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BAJkKuJpYWdtj8kvDzq7kj79D0dSrUm44Ey46PsxwVE=;
        b=GXIs3TeHA8VrIpHmJG5jEUs57YX2R0imV5kGC02WUZV72JYuotVdUmXv7dSYnJW1M5
         Rq17KQ/uBevK1F3UUKQSDmkOtrH5lSY7E2WlP3QLHD+RyxY2kGp9RUT2rVJJtbNJXOq6
         MAlBS0orPUmhO8AUV69LO3KydnH1kwkjovd+3/Uok13OjLNLnEv5m/lr5d4M7IBhsqe3
         hn0no5ZCGLvXPnIOgo1pTWDfCwip6pSv8F7DErEdvK34l7wgMrLstvf1wXeLOeuVh16f
         K6aN35IGgvCKgBiGZobavl5+2lHz+GIhcAHB+RKMsYehhgUDs+QAuHfDluPsfVZSfblG
         F6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767695309; x=1768300109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAJkKuJpYWdtj8kvDzq7kj79D0dSrUm44Ey46PsxwVE=;
        b=DtED79YM9PX7TEy9Rg9sKIeXZSIkrODRe9ZlZwmZGJ6YQyYbWN5wc9JC4GEck/5dkJ
         9qj9QGaz3c6akk45YRUdz/n8CbCa86rme09chj4ZM3uvskib+8Yc2KwYLYzn33sRGk4g
         eETceDIawIz7AYckCSOpInYYrsP+bUQbWjXvUvEZ1/1xLOobiC9XlczjQo8snW/5Yghe
         JgUgrnM+vZpIZcyCgSiOjA8j4SagF2X/kqkNCy3gs6yBb1/ylBVL2EFrXH4XFsOBzfLs
         aRSbzsKNkPaN/ZH2fEiIfhXT1146S6fjt23V7fVxuIu/fu9ckLdGzn4NkhptRSaqesS3
         HH3w==
X-Gm-Message-State: AOJu0YzXc1f8TAKDw79V2bbz2BcBre8Tk88OZlU17qaT/7Q0CIgDeM43
	WLmWgY2hZ5F//OOdfwqM3Icdpv+8Kzz1QNIvsTIJC0XdTz/mdcLi0XsPtPnKLeArLSGTXgHd7Zq
	+eb4v9pGGGvuYFWRvr+NSXDwg0HICYz0=
X-Gm-Gg: AY/fxX4Jqzo69jyDgApraD/8lFGhpsLAef5aM4SHn1714dOA0bN0OxgW0ZwB2v4vt3O
	IlumpZkqvXlnqJoAvAA0VJJ2vCbJOTXpfuP0XvFgxq0XDrFdDq6wpCpzI0s6MhRJcLz+EKwGN+D
	RqkHRDcyVvLNON8bGGyYDCQPrIRmpjCju4Mb2LqhE10aEfG0Fx6H2uV2NzWsfy5H1MfhkWm+2Vd
	2SXeQGxYV8WMvi6ce+g63HsT1MCluqkU501KUgnXG7wVI7J+VONY4gnS9hWp2EKSCOMEOHDm0rv
	ZtQJrsU6m0krldo3FB12O7nSMZA=
X-Google-Smtp-Source: AGHT+IE596N+CStEx+ymFl4KP/IAg7DPwvIzsQgEPdelrrDg73nHTs58Enhoj6GXrimF8vBvgCjK+cC8m257+3fVL7o=
X-Received: by 2002:aa7:c343:0:b0:64b:a52b:fa1b with SMTP id
 4fb4d7f45d1cf-6507bc60919mr1656343a12.6.1767695308725; Tue, 06 Jan 2026
 02:28:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102180530.1559514-1-viswanathiyyappan@gmail.com> <20260102180530.1559514-2-viswanathiyyappan@gmail.com>
In-Reply-To: <20260102180530.1559514-2-viswanathiyyappan@gmail.com>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Tue, 6 Jan 2026 15:58:16 +0530
X-Gm-Features: AQt7F2qFv-ofQsHt7p0xfCLNT_q5NACm8CoTMw_f6VL8XWeKj3K9Y8M7vOIoYlU
Message-ID: <CAPrAcgNR+=GS0RxH_UP1Hz3U-HJL3_ZdGoy=hqkdS=iXL8zF8w@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/2] net: refactor set_rx_mode into snapshot
 and deferred I/O
To: edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, mst@redhat.com, eperezma@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +static void netif_free_cleanup_work(struct net_device *dev)
> +{
> +       if (!dev->cleanup_work)
> +               return;
> +
> +       cancel_work_sync(&dev->cleanup_work->work);
> +       kfree(dev->cleanup_work);
> +       dev->cleanup_work = NULL;
> +}
> +
> @@ -1682,6 +1882,16 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
>         if (!ret && ops->ndo_open)
>                 ret = ops->ndo_open(dev);
>
> +       if (!ret && dev->needs_cleanup_work) {
> +               if (!dev->cleanup_work)
> +                       ret = netif_alloc_cleanup_work(dev);
> +               else
> +                       cancel_work_sync(&dev->cleanup_work->work);
> +       }
> +
> +       if (!ret && ops->ndo_write_rx_mode)
> +               ret = netif_alloc_rx_mode_ctx(dev);
> +
>         netpoll_poll_enable(dev);

This is the response to the AI review. Honestly impressed by how good
the AI review is

My bad, It should be flush_work() not cancel_work_sync() in
__dev_open() and also in
netif_free_cleanup_work(). These are the only places where execution
needs to wait
for completion of the cleanup work

It's ok to just cancel rx_mode work so this issue is only with the cleanup work

