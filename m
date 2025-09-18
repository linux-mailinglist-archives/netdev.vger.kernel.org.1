Return-Path: <netdev+bounces-224435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8402B84B5F
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9381B1C22C8C
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 12:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D3A2FD7A7;
	Thu, 18 Sep 2025 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXnGKhAL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF24A279DA1
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200328; cv=none; b=cHA4io5R6XwkobAd1EPzy/0OLTHMXniWQ54/5sXGCV40QjsjdPUjFifWL+BPN8bEcv1K00EHxHOLsxlXuH4sHyUXZeTFGk5VjluOwQW66zr7E3j8pzKdY9WVr016qmWgA3gmfRc9oJ3RI1Xy+61OrFTjIkK8BqRB4u94e5U4+Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200328; c=relaxed/simple;
	bh=lvcQGE6zMqa3RPKmZjZH5zBkLah9vgbD3X7rCwM3Uvs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LguCSHaosgSljiiYHdOeDle3GKkhhkisPt21kyVWGPsvE+gsAp4E/briEGbBgyy5dSTn0zz0728/Jr41slJdOEWDiV5KqfFOEEUEKSDj8H9o1FWrZEPbvEUtOCK9Erqo421DNPpGDvaPQDAlpfBjk97mE/NWaF09RU0xLlZKJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXnGKhAL; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b07dac96d1eso306398066b.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 05:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758200325; x=1758805125; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lvcQGE6zMqa3RPKmZjZH5zBkLah9vgbD3X7rCwM3Uvs=;
        b=NXnGKhALfj6DlKeOHQ2Bg5ICvOLXQRL87q2c4Dyfau+W0hglTwwzaKOaqY507QyHnk
         9Ki6JEkZw+W8uT7xLGegNVOiM3eJsB4Qsfno57q+yr9fZEhK1DF72giefaYlvQnbRh4q
         T1bxVw5tDGdpoNO6bNIBIx8zPnlS61+y/zkFtld7loynoTEUfDnADlYz8fSqBMuGhpsR
         4imNkTluKLs0F4YMvhlWkf3xFjPiE6DOAv4yj/VlZdgGAyWQdtqMAI4zg3Uqnbqibm4l
         IZvoXM2f6DyscJIoOV3AnJdAiOJiz7VFf/Nd/fIqK8gmn59ywBUTodIKGvjbjP/rBw1W
         uNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758200325; x=1758805125;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lvcQGE6zMqa3RPKmZjZH5zBkLah9vgbD3X7rCwM3Uvs=;
        b=fDcJttuEKqBz4mLvOncY0J4SjGCu+N0bvvpa57u60VXfInfvY6nOMSibv4DdcVKURD
         o1EBDPVF7K98j6CxZffKUj8HZiKG08YYsFIFVQzbIZoB5WCdAGMYevkQje7wNGWM8oij
         qjoUN4RCCF1/ZT9Gg25087OgQiSzYMS75Lzegk9TZ6Wx6uaM23zXC+XDXGaRlaONfODK
         SqHHFKRpuQmMvAo5aYS6zYZUFiPAJs3Q9PCtJ2/yb+0faAFz97sExJqPWm5kseBdKRBe
         dcMwhr4mGZm/mcuLN2K9yXoJDPA8UxQaM30gra9iqSbE8sAk6zSshpylJsTYHtpNJl5u
         arQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX43Q0ZVTmyrt3kIIieXkdsSUVRhKHbMawBjTr9sq465EB16vhEuCBg9l+s3xbY09J4icjg6Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFNg5WIrBBJlZAKw1pnzAKkIR/FevNIkMrQpsvgzEgJFHvzCJi
	fdkL3axafdqkGOp/WZidD0ZHzxLJGM8K1hSpwyfcTom3mgoo28D+sAq6tIfSIgjKw8lrEee/1t6
	qvjpQ6DXi+5LnTe6Hzfng4oCmIb0o498=
X-Gm-Gg: ASbGncsRSpmm9/VOR204j1BzEt/X/w7zbi3AP6e2R0nTWr7XwE9j3lFpaw+q/PHQe7u
	wpi0iq2ocrHSkcgohx6hSEHt1cXllxYdh0vuVjeYswOkU07zVXAZLT+C8XzDI1tHCfWpVBb5yy2
	gUwVVLclpHmmgvyqPhCHj8/8SuJsiV4VSXV5+yT3cMycP71XDLw7tf1k7WRVk6OoD9W0IHdQFJC
	BAutkfc6bzs189Z/uv7tjfOLA==
X-Google-Smtp-Source: AGHT+IHG8sk3bcUaHQwBrZoLncnJChfwaJcuvBt6nfYyVTZWygm5etjUbCmo0srSUZFjiTWBAdZCH1hJ4cgs9M5FLD4=
X-Received: by 2002:a17:907:6d06:b0:b0d:400:9182 with SMTP id
 a640c23a62f3a-b1fac4e0b80mr343825666b.22.1758200324771; Thu, 18 Sep 2025
 05:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrea Daoud <andreadaoud6@gmail.com>
Date: Thu, 18 Sep 2025 20:58:33 +0800
X-Gm-Features: AS18NWCEXBGAyDTuAdYfLyOIr8P8xtqgcUaqAsI0KK0ysqpeO0oKN9Ycaxuqg4o
Message-ID: <CAOprWosSvBmORh9NKk-uxoWZpD6zdnF=dODS-uxVnTDjmofL6g@mail.gmail.com>
Subject: Possible race condition of the rockchip_canfd driver
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Heiko Stuebner <heiko@sntech.de>, Elaine Zhang <zhangqing@rock-chips.com>, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

I'm using the rockchip_canfd driver on an RK3568. When under high bus
load, I get
the following logs [1] in rkcanfd_tx_tail_is_eff, and the CAN bus is unable to
communicate properly under this condition. The exact cause is currently not
entirely clear, and it's not reliably reproducible.

In the logs we can spot some strange points:

1. Line 24, tx_head == tx_tail. This should have been rejected by the if
(!rkcanfd_get_tx_pending) clause.

2. Line 26, the last bit of priv->tx_tail (0x0185dbb3) is 1. This means that the
tx_tail should be 1, because rkcanfd_get_tx_tail is essentially mod the
priv->tx_tail by two. But the printed tx_tail is 0.

I believe these problems could mean that the code is suffering from some race
condition. It seems that, in the whole IRQ processing chain of the driver,
there's no lock protection. Maybe some IRQ happens within the execution of
rkcanfd_tx_tail_is_eff, and touches the state of the tx_head and tx_tail?

Could you please have a look at the code, and check if some locking is needed?

[1]: https://pastebin.com/R7uuEKEz

