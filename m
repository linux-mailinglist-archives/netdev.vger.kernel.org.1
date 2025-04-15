Return-Path: <netdev+bounces-182956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A34A8A719
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 20:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01FD0190059B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEB622DFB1;
	Tue, 15 Apr 2025 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZh+2foY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3291A22068B
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744742879; cv=none; b=ElIFUSTdpAbyujdjGEI5EZGGIwxq1TZwwQI8gD1yw6BwnnSVppS15pBme5r4afH84Z2atmyTIJZk2gvV7L3sVxyzDATOlke550d4bNfvn+DZfjTd14uoL98DVlyZyk2Ki8myNuLC4KfhmwEM2T3/u/EaA5jMC/+amNT23PImMgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744742879; c=relaxed/simple;
	bh=+PrHw4B96ootjUmAag8HXDw7kQgaxLx+4OL9Ry9uuHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKpE34vL56XgqEgNrF5QW2AvyuSwNcm5NjKEfkd9PZivS7WAdsSHaCcFhaShAQFsndYrS3HmkfeRbKV92dI0eqZz6p8V5+h8Z5rWvlbfQsHBO3wz9bh5skdleK0NCrOLNg+wfvvH25tYgJaV7eM5ZjWcd99i8Z+8wUf8Bi0kic0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZh+2foY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso65126655e9.3
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 11:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744742875; x=1745347675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7YztXzGtx3oW9Nc+7dXeuRWKRlp8ckJ/3O65A5Bd8Xc=;
        b=ZZh+2foYKtCG0mUU9aSpqFC64qQjrxhGwyGEER0pTkiU/veb6kSxbyHgRHftVgHCit
         Ed5ncJVVZQCBEVTFKZeTIMnWLPnb2q7W9u7z4VeNevuDxD6NGFBCYEja9BqgXIW5CVYa
         QghsdkxwKbVK+5TsmIUCBxFFVCgxuUUFUaFBcqQdUQ0n3mkEKyrsh5EcwqCa4+v2HMjv
         kddI3fNmZmwqWpb5SpcoJrc1YG8vP7XvJda7mjf4m36wj24zqAQLhkiZApa6PjLSL/Dr
         AA/yThn51g3MgzSiRI3d8tlS8rAG2sG7b0eff9cGqmoxmHX9A9RBHtCM0lelkhN5kUxs
         gF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744742875; x=1745347675;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YztXzGtx3oW9Nc+7dXeuRWKRlp8ckJ/3O65A5Bd8Xc=;
        b=cLHpjoLPMHauaUed7dkwOuBqOX24o/6DyfI1aCMT1GWoR9hlebj2et7GdEpUzm29Q0
         7TWBbAeQMXCNgXejzFgXx21C0+GfZfRCS1LlHknq69tI9xrnXWhOEAKFmFdj3ixA22Dj
         FaR21huYReOIpt/CxaNqq0zP56tr1HOcd07l83yTtG0+GJ9tKpgteChhlyzys6pnxU6i
         fH6LhaY1/uEJxBiW1y7Dfa3eYev0DClwcFHED3BGJUM6X1V6EkMceDZC0lO40UeCTtd/
         MPB4GtrYTawcnSQ5sGTOr33Dei9Fo789f5/np7tZsYyd6GGU7Nr2O8rRiav98mELlnpG
         VbMg==
X-Forwarded-Encrypted: i=1; AJvYcCVxn9dujuaI632Dy05BhrfXXk61y75hJv1xVPyq8QX9wq4LwBqnj+6Hpt0H9R3Owv4h1RETJt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKgVmA/tkD/TOBocS1C/HjB0DH/+TyIAOO24BvlFMyN5ENoHWc
	QkvJcAKIX4oy6b8lqDxVoWw8aKE+LdYjity6nMrxchC7Ud7nCWkR
X-Gm-Gg: ASbGnctZpYOXTbaFxvMKiwGOXvuI2WEL9Cduw2Id/8bQFa0uJSXFq8tWbvAPmn0GLr4
	oB9yxphWXXv2Xz2o0EyyXKswZUQzY2Zpn5Z6BbYAuI8kWBRp16xMd5XvHyzQfDBpM+JKxMnNc9w
	Lf/2xIqDHU8uK9ZLoc5cEsQEq7lLw7UNLSag9r+pL0YxosJowdWYF4IKpsOrGb6K25UALgXYNkj
	ANyvnds8ZuzGqyQrTbg4QgUd5VzkVPqaZKk6Xp8HsE5FkKeYSHHv+7YAJd+v4pQR7V6fynJlZ+Y
	PG+7RW6Lrvv0mdLtMtVb7JRA2rOlc9gtVqXsMS6L9xFty6smy0VMxuIRQSKsj2PjlCZg5pxkKR2
	7Wl8a4mn2uND+TD9a4wostc3xvBMw01sXh5We6KU9aHzhiMjSkckC9+GFbUDGPEs4EdAoUMVGV/
	U3Sw0RUHEkEIxgQjJCZ2UE53umpParNCox
X-Google-Smtp-Source: AGHT+IGF66YJbDDNi1maIYBLqWA/oIPMDqkHvJwfXCoqFStaTsQY8KywUoJ/I99pkRyGfx6IYjQTgw==
X-Received: by 2002:a05:600c:5397:b0:43c:e305:6d50 with SMTP id 5b1f17b1804b1-4405a0f561fmr1714035e9.24.1744742875087;
        Tue, 15 Apr 2025 11:47:55 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9dee:8100:1d74:fdeb:d1fd:499e? (dynamic-2a02-3100-9dee-8100-1d74-fdeb-d1fd-499e.310.pool.telefonica.de. [2a02:3100:9dee:8100:1d74:fdeb:d1fd:499e])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39eae963f62sm14805547f8f.5.2025.04.15.11.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 11:47:54 -0700 (PDT)
Message-ID: <4f8d3018-d7e5-47e5-b99d-550f8a4011ee@gmail.com>
Date: Tue, 15 Apr 2025 20:48:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: do not call rtl8169_down() twice on shutdown
To: Niklas Cassel <cassel@kernel.org>, nic_swsd@realtek.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 netdev@vger.kernel.org
References: <20250415095335.506266-2-cassel@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250415095335.506266-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.04.2025 11:53, Niklas Cassel wrote:
> For a PCI controller driver with a .shutdown() callback, we will see the
> following warning:

I saw the related mail thread, IIRC it was about potential new code.
Is this right? Or do we talk about existing code? Then it would have
to be treated as fix.

Existence of a shutdown callback itself is not the problem, the problem is
that all PCI bus devices are removed as part of shutdown handling for this
specific controller driver.

> [   12.020111] called from state HALTED
> [   12.020459] WARNING: CPU: 7 PID: 229 at drivers/net/phy/phy.c:1630 phy_stop+0x134/0x1a0
> 
> This is because rtl8169_down() (which calls phy_stop()) is called twice
> during shutdown.
> 
> First time:
> [   23.827764] Call trace:
> [   23.827765]  show_stack+0x20/0x40 (C)
> [   23.827774]  dump_stack_lvl+0x60/0x80
> [   23.827778]  dump_stack+0x18/0x24
> [   23.827782]  rtl8169_down+0x30/0x2a0
> [   23.827788]  rtl_shutdown+0xb0/0xc0
> [   23.827792]  pci_device_shutdown+0x3c/0x88
> [   23.827797]  device_shutdown+0x150/0x278
> [   23.827802]  kernel_restart+0x4c/0xb8
> 
> Second time:
> [   23.841468] Call trace:
> [   23.841470]  show_stack+0x20/0x40 (C)
> [   23.841478]  dump_stack_lvl+0x60/0x80
> [   23.841483]  dump_stack+0x18/0x24
> [   23.841486]  rtl8169_down+0x30/0x2a0
> [   23.841492]  rtl8169_close+0x64/0x100
> [   23.841496]  __dev_close_many+0xbc/0x1f0
> [   23.841502]  dev_close_many+0x94/0x160
> [   23.841505]  unregister_netdevice_many_notify+0x160/0x9d0
> [   23.841510]  unregister_netdevice_queue+0xf0/0x100
> [   23.841515]  unregister_netdev+0x2c/0x58
> [   23.841519]  rtl_remove_one+0xa0/0xe0
> [   23.841524]  pci_device_remove+0x4c/0xf8
> [   23.841528]  device_remove+0x54/0x90
> [   23.841534]  device_release_driver_internal+0x1d4/0x238
> [   23.841539]  device_release_driver+0x20/0x38
> [   23.841544]  pci_stop_bus_device+0x84/0xe0
> [   23.841548]  pci_stop_bus_device+0x40/0xe0
> [   23.841552]  pci_stop_root_bus+0x48/0x80
> [   23.841555]  dw_pcie_host_deinit+0x34/0xe0
> [   23.841559]  rockchip_pcie_shutdown+0x20/0x38
> [   23.841565]  platform_shutdown+0x2c/0x48
> [   23.841571]  device_shutdown+0x150/0x278
> [   23.841575]  kernel_restart+0x4c/0xb8
> 
> Add a netif_device_present() guard around the rtl8169_down() call in
> rtl8169_close(), to avoid rtl8169_down() from being called twice.
> 
> This matches how e.g. e1000e_close() has a netif_device_present() guard
> around the e1000e_down() call.
> 
This approach has at least two issues:

1. Likely it breaks WoL, because now phy_detach() is called.
2. r8169 shutdown callback sets device to D3hot, PCI core wakes it up again
   for the remove callback. Now it's left in D0.

I'll also spend a few thoughts on how to solve this best.

> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 4eebd9cb40a3..0300a06ae260 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -4879,7 +4879,8 @@ static int rtl8169_close(struct net_device *dev)
>  	pm_runtime_get_sync(&pdev->dev);
>  
>  	netif_stop_queue(dev);
> -	rtl8169_down(tp);
> +	if (netif_device_present(tp->dev))
> +		rtl8169_down(tp);
>  	rtl8169_rx_clear(tp);
>  
>  	free_irq(tp->irq, tp);


