Return-Path: <netdev+bounces-152573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A8D9F4A56
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 12:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C529167EA6
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 11:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AC01EF0B7;
	Tue, 17 Dec 2024 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCkaIVnc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2A11EE002;
	Tue, 17 Dec 2024 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436507; cv=none; b=f/NVK2P8xQbYEhLdgmNPWLb2hwcziwQHzvPHGI0dJtGeaOQ8ILy5BOA2i10e48/tNb1FFeRKGXESS018qbu6V/8SRriMId1j5A8WwTNTaj9sX/vy1UcbLSEjll+KNZz7OE1+z2OA9pgWt2ILsEkzxTSjGzKhS0fzp9ltuBygGKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436507; c=relaxed/simple;
	bh=EYsHKINsZ9zML7ekiItTfl5biYxh4x+VwUfpilzpOws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfOlCe2hxIOtF5abZKZWcN0fjW9arwxY8zVEU61euEW5po+RH/jbm5sq3KmxjSpX3lz1LH87eHqXtMPYyLi4g7F+SiLphimFlhQMyz200JbcY35blA4X+SphloHikpV4fxHg5pYAuc+bYqI2qeOkFqW21HAlicsvNGw0kXnSVN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCkaIVnc; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so3587152a91.2;
        Tue, 17 Dec 2024 03:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734436506; x=1735041306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KbDpu+5dgXCRMaHlMudK/PfUogFA3io0WjXBUI+vpI=;
        b=gCkaIVnc+Yb64+J8xyombW5XzLRyePJbnEzFvT0D+HrVIeRw6cjl16VSbjM9h5t35S
         68hd5pwwiBkDIQt37zuF5ylTN1/wuJiVkW3KhvnyjKa2jQ7G49E7bV3QWbBJF6ms2HG2
         f3Fhyk2y3A/vu6Mezy/1QTYaNiiEiNqU20PycdQSI1cKZXsUXz3e76HXCoNl8K7ySpqW
         d0ZpluYXKIGAGQlmWLlA2ieeqyQUNyDVZbmQjsxGcyl/ePXyvnJr0dbT4NCIAZ6n/c02
         1IotdijsjkzcqednCCEwPidxIKOsGckZkiIOHXtXWbx0ALpCIyaieK52NQmv3EcWKB82
         RGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734436506; x=1735041306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KbDpu+5dgXCRMaHlMudK/PfUogFA3io0WjXBUI+vpI=;
        b=i9WCa2yvXeT0YJVk5RWft9RZTjrvZPPzJAqor90WgI44Ri6luLSH5n6ajtKwPd91Tv
         9hYF6v7uty8EbWTAOw6enUgosoTaY5V9lD0Ynnq5RYT9NXSj5/JhJuDWUm3/hPn8Ekig
         mFOeOg/viiCO+S8HyhxfWVgdGlcOYfhALlCbvAKSVo2YsCVIAKsbEgxrmJc4z5+G6e+5
         qR2LH8cZEiStaYnf8Y2dkHdqI+xZhxF9fb24Ke8HAockCcSCi68VfdImCOLLXSP73HKM
         SWyLOlX66ZC/+l4Yr+1X9OYts1SJ3ULqgQcI0X50li/dWIBMNYbXgGoKdc8NNfMw1FmG
         2G1g==
X-Forwarded-Encrypted: i=1; AJvYcCWFUjSbhmzec9e2h+zQVb5PZ7bCP5q5TzmOwpDbQM+bM28qZjbqBTiR3Vo2UzCOh0M4aW3jq4RkHZPeLKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3jds8oE5DI1qWyYvgE/fmbxZOcF8r31ixnfS4GecPG+nLsttQ
	AY4t46N03cIDRPFJUAd1DadgmJIBlECRICy4sx2vBP+0phUrMoEY
X-Gm-Gg: ASbGncvn7ckU14lMzdyLGqKFp8Q+nwsWZQPizI94XVcSx0Tvk63suOuPBvmp1KBkyxK
	OcuKT0r385ebf0+p8OEhH0slyGmKwmQqt56UMWScZlhO+ymy8pLRgGvLIB69xjMW5ehW2pGEcgm
	hTKKmdsVkCXOiMYb+ggD2mVmV9wnL+CuC+rWF3twtS3Bph+XNya4mFq+1tT8Dl8kOi3wW+FYckB
	pm/2cZcw6loJDld0u3vquuyP7xTsHwzt4+lYPl5mKQ+CBtTPAjsIQ==
X-Google-Smtp-Source: AGHT+IHngxmcUWV4lDNQlA0QXiov5JsCMkpOQ73Ck+LNIruRGkRdnCgPCkMNUjWYyHkKOes0d7ocDQ==
X-Received: by 2002:a17:90b:1810:b0:2ee:94d1:7a9d with SMTP id 98e67ed59e1d1-2f2901b3bb3mr21024098a91.32.1734436505718;
        Tue, 17 Dec 2024 03:55:05 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a1ebba00sm7161517a91.26.2024.12.17.03.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:55:05 -0800 (PST)
Date: Tue, 17 Dec 2024 19:54:54 +0800
From: Furong Xu <0x1207@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 xfr@outlook.com
Subject: Re: [PATCH net-next v1] net: stmmac: TSO: Simplify the code flow of
 DMA descriptor allocations
Message-ID: <20241217195454.000016ce@gmail.com>
In-Reply-To: <9d0722fe-1547-4b44-8a4a-69a8756bdb39@redhat.com>
References: <20241213030006.337695-1-0x1207@gmail.com>
	<9d0722fe-1547-4b44-8a4a-69a8756bdb39@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 10:30:24 +0100, Paolo Abeni <pabeni@redhat.com> wrote:

> On 12/13/24 04:00, Furong Xu wrote:
> > The DMA AXI address width of DWMAC cores can be configured to
> > 32-bit/40-bit/48-bit, then the format of DMA transmit descriptors
> > get a little different between 32-bit and 40-bit/48-bit.
> > Current driver code checks priv->dma_cap.addr64 to use certain format
> > with certain configuration.
> > 
> > This patch converts the format of DMA transmit descriptors on platforms
> > that the DMA AXI address width is configured to 32-bit (as described by
> > function comments of stmmac_tso_xmit() in current code) to a more generic
> > format (see the updated function comments after this patch) which is
> > actually already used on 40-bit/48-bit platforms to provide better
> > compatibility and make code flow cleaner.
> > 
> > Tested and verified on:
> > DWMAC CORE 5.10a with 32-bit DMA AXI address width
> > DWXGMAC CORE 3.20a with 40-bit DMA AXI address width
> > 
> > Signed-off-by: Furong Xu <0x1207@gmail.com>  
> 
> Makes sense to me.
> 
> Since this could potentially impact multiple versions, it would be great
> if we could have a little more 3rd parties testing.

Totally agree.

Multiple devices with multiple versions of DWMAC core which is
configured to 32-bit DMA AXI address width seem to very hard to find
and test this patch :(

Jon Hunter @ NVIDIA has two versions of DWMAC cores different from mine,
Tegra186 Jetson TX2 (DWMAC CORE 4.10) and
Tegra194 Jetson AGX Xavier (DWMAC CORE 5.00),
but both of them are configured to 40-bit DMA AXI address width, this does
not match the case that this patch tries to convert. So I decided not to
request him to provide help.

