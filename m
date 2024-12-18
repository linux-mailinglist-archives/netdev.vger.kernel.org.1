Return-Path: <netdev+bounces-152913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1527C9F6508
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 063DB7A21BB
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF0F19F419;
	Wed, 18 Dec 2024 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtG43OSP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AE319E97B;
	Wed, 18 Dec 2024 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734521874; cv=none; b=W13cnzBtYLoPtgdDgyk0b4BXPqv0kRjvbJsOg7j0/hWtj183xzj53myT16jyiChlJAXjv1XDL5LT5+ZZfDO7a7d8St6fqgBF4rEAKe7a3W7Y6Q50sdh2nSjuJO4BwVrnbnOpl7JFECWKDpaL427WpCLIK74CfjWgysx4c9ipC38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734521874; c=relaxed/simple;
	bh=ZaWUsNhGX7QfhkvcP9E/Y4TrOoOcUblakPu9k7IjeQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzQegfd5FmzL1wi6Sey0JmvNpc+dy5ErRE3woOWVosPRiemkww/LtCNXBBbMpwpoLgKeaKSgjYq5ByitNHZUmGSsBnsUD9C3EkD4KNtBVtdfjgIBMLn+XNCnKdulFSe19oZfu6r5gi/y6EIo10gdkJ6p9xca5HOGFlgUiXoKueo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtG43OSP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-725ce7b82cbso7333067b3a.0;
        Wed, 18 Dec 2024 03:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734521872; x=1735126672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4nGgzN+PLoX+DtGKu6QZhwKkrW+RWGU8KNUJKfHD5k=;
        b=YtG43OSPuaSOpKcljSpqVmPu4BvrVcXKE3RWXRDXtzrM/le3+it45XpkIpf0ygcFCE
         gy2uX60Sz8V0u18RtM8pTC8v+yQKsvb1I3SiN1ttQME/yQplr3o+OVt9k+04JhkbZ/uO
         HNBJEzi+rpfJwB5/Vnd6ZDakZ7YeD8wTX8UrnS+mQQMpP8rT9NQJ80YK5o3RWlj1RLYD
         hM7bcIrK2jYqWuKtqYT2DWCYfS6wU0ef852LJY4whom40uzttm2YRF/L/wVZjIL1XtEU
         tL8SuZba08NHeS2z9t58OpHHclbJM3Qw+fXWuQnpj1rcGg7cTuW48sZ8lnial/NzHb6V
         ulTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734521872; x=1735126672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4nGgzN+PLoX+DtGKu6QZhwKkrW+RWGU8KNUJKfHD5k=;
        b=Ndk28IaL6vM26lYwSrdxwRlyGJsWVdwrA/0IrKY5xTPcqrUNi4PwsikNDy4UBSHZRM
         AGMXGNyXQgrN7BTht7jmcd6Y5SRTxoUwa4HiO0Z30eZdjL51YNwZZSpeTEqxaWPX/Kas
         aoMQ0uZ/sMCldwexrDK2dpb94Tg1sotaQ9r2TGphkJGgbkcz2ybaQiohm/Oz5qvxpS56
         SMH7C9ecUt01hOp61bz9e6bFcJG8nX36K8bP2VST960uYe9WmmOSnikykyM4NxA3JCvE
         2q0qYuj0SB98WU3ktRJobi5H+tkdlQFGRyt+HGRYTVNw7DrcgQ6fnMYeY/YPKuxebgub
         4dag==
X-Forwarded-Encrypted: i=1; AJvYcCXezQ48cxGA/zB54At32BqXrqypPCG/fce7WUQhSLWr6yHhBXs6fw1fLOf609XlG/xZl/peSqv+NnFFNvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ijnImptEuC7txUCmukkBNueizYZRCU+H7diCID4WG+zAt2kg
	3wb/NVuOJxAbYfsT02vdw82zQaY26xhP5AAGyQPwjgssQbykbWLz+cobhg==
X-Gm-Gg: ASbGncvCAArzE+EBC5glKfjpMFpqQ8JL0ErqgjkLVQubq54RBz0mhzqwTw6DjqsOcKH
	GOhS7cDkmIzaHaBdiruJlA2dKlif23ZDbTVBWmiWb5wKmrS8+O3AYhMPdtjfGNj2POa79PFrp7F
	5hXHu95wrDR0x/GAcqa+fOEog+RHk0iDEefp8u8cIoObZXkXNIPAeLEZmSGYZZnJg0IaZyX7fDg
	Q7PLVhBrQLqJAuXrfCa8YxpsKU7tc1MDj2KUBVNRyURYfSmF0lP0w==
X-Google-Smtp-Source: AGHT+IFBGhYjjpAE0oXnnXnxBVHrfx2nI3EfADj8QvczSv8I5fWLimmdInMDqXwJQC+cnnxzTSbD3Q==
X-Received: by 2002:a17:90b:2dcf:b0:2ee:acb4:fee0 with SMTP id 98e67ed59e1d1-2f2e91d941fmr4373626a91.16.1734521871854;
        Wed, 18 Dec 2024 03:37:51 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e72292sm73745605ad.273.2024.12.18.03.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 03:37:51 -0800 (PST)
Date: Wed, 18 Dec 2024 19:37:43 +0800
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v1] net: stmmac: TSO: Simplify the code flow of
 DMA descriptor allocations
Message-ID: <20241218193743.0000521f@gmail.com>
In-Reply-To: <20241213030006.337695-1-0x1207@gmail.com>
References: <20241213030006.337695-1-0x1207@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 11:00:06 +0800, Furong Xu <0x1207@gmail.com> wrote:

> The DMA AXI address width of DWMAC cores can be configured to
> 32-bit/40-bit/48-bit, then the format of DMA transmit descriptors
> get a little different between 32-bit and 40-bit/48-bit.
> Current driver code checks priv->dma_cap.addr64 to use certain format
> with certain configuration.
> 
> This patch converts the format of DMA transmit descriptors on platforms
> that the DMA AXI address width is configured to 32-bit (as described by
> function comments of stmmac_tso_xmit() in current code) to a more generic
> format (see the updated function comments after this patch) which is
> actually already used on 40-bit/48-bit platforms to provide better
> compatibility and make code flow cleaner.
> 
> Tested and verified on:
> DWMAC CORE 5.10a with 32-bit DMA AXI address width
> DWXGMAC CORE 3.20a with 40-bit DMA AXI address width

One more DWMAC core tested and verified:
DWMAC CORE 5.00a with 32-bit DMA AXI address width


