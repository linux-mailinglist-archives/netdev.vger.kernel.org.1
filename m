Return-Path: <netdev+bounces-167558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0910A3AE87
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2BE53B76D6
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 01:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B53D50276;
	Wed, 19 Feb 2025 01:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeFj9wNu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62EC1EEE0;
	Wed, 19 Feb 2025 01:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739926928; cv=none; b=pqH3HbsnYXUJfjfKU45uiO6W3UC0+Ygrn5z4l8n/EoFpWtkCgr8Mdllnrca4y3702p91lcHsdHdlTgCt9NPatiU6Tr5AxcZg2UZJ94Jl+6XPtjSu4Ikf6tFgAWWG+JLm1CPoH5JmHewQpCTqekeobh4KKRYqxpG6GtA3hgv55m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739926928; c=relaxed/simple;
	bh=CQEyO1JD29FoLIyqEIIaWwb0FvYhYniLQFwCCAw62SQ=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VVb6+p4zcfT97V5bU9GX499VqpY8jScKe4/IxHisS4EZOZ/p2dV+SYGuQzhexOJTeF8tn5IDQvXbFN2i7sPLNefHSuGhMwFd/eaHkOpe6/6Cy6tkZEMQEc+huoGemEnZx+lmozkl6+Dk67kMB3PGKWdg4ifrj+/RwFW+ju9e/OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeFj9wNu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-221057b6ac4so62545725ad.2;
        Tue, 18 Feb 2025 17:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739926926; x=1740531726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VA5g+eIODwuOxOovCAv0vuRoM9QGVOHfzYRSjAmXfsM=;
        b=IeFj9wNu5WsNl4ggz8owRvMELtuaWqb5B/bz5J247DrGJC1CI0YJqi2RVI1SrrC+vH
         e6Y1xHhgMwOBbf+DEjeIYQ+oabfs7g4eM49sQkMx+aG5EWwo4S5n17tUr2wU3VcPf0WU
         nQs3yiMijU5QcOIrkuAxKHAkg6Enmjyunk+unl1BOMRbPuj48udp2fT6Ep9kdfq+9j9c
         Cfy0Z4TY/rFoKpSaK0x1GvQtTZUYL1rSlgVqPW1aHs6uocjYghq+xPsooYssjNGx+ROQ
         h0R62UI2PmbyOPguRAe6IBczWesas7j0Wv4hFWTOCDCo7ujArzNKb4CyQ4KkD6qUOjmE
         ZLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739926926; x=1740531726;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VA5g+eIODwuOxOovCAv0vuRoM9QGVOHfzYRSjAmXfsM=;
        b=pqOkiHvCdTOkcICjopEzUyrgF0WZNqsnEyVKHSzZZAXSPKjNROSMOycRxHCzm4KcW4
         GuubuDgbpk9M3oXe8BHl07NrE5uXgYNMDqqVszKAXk7LZTT/bveGqB+ufNOw2Wb7iaQH
         lIEWPmi4TpwCcSZQ4/8VHk8fvhxlXzBXQcALHfOc6WXo17bqpPkFvh66mmSu46r6BosO
         c+AzTOqKZxA0ipKfev8Afsws5AWiUZMwsCDht7YqWqZOTxbcY93FHbEXtbTv1sH3cM4U
         +uazHi2PfowGdOmm/o7h0RdVbeQDKMu6we4yHIup3i8zzkX+gP/QLNrgkJteJQHCZM5h
         1j3w==
X-Forwarded-Encrypted: i=1; AJvYcCUgm2wvZQ6+ZHJznirXkdbXkV87eVOOgaxGo2QXVVv8R/GT4w4T5VdzWOXbxawY/EncksEK3TWU@vger.kernel.org, AJvYcCWB4lWuucSsS0WgD2rlx+K6lqCPN3FG8uWeIQTR/wvabcwtUke4gfMK7Px+/Cu/vjEfnW1nTaCR0iYQVZUjEwc=@vger.kernel.org, AJvYcCWGocBSe55qjJzMbX+ZO7qTFAY9EXY2A0s/+edWrKjM8ovEARlY7PhWs8tSn54YG87yR5k476OE978vveo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy133rnbFKX0azw4QxcZN/xcYPlumf/w/epMHRvTn/woLODICyl
	vvRzH/oiFf1SSov9qDL9WBb3u8WPgk48L9mny2gA3ZEwKRNIaiI4
X-Gm-Gg: ASbGnct0VX9BsfBL3lKn6E1jWVWf9qwo2h8GeuqWTDgJgLoJ20NN3My342d0U1fAcet
	UbO/J8OjyMKkQmg2OylQ9tgQGFwHWw3ifAjs1sxxHaWzcenePJ+DeQwE+m311oQ+KHCzFmltI9S
	cVA1FjFxfsZlidgFs8F30RjDU9/2Q+E88LM1/DW/tbHNLdoPn4cBo0bPyeaR7IjiZ2qlC9o8t2V
	ZOpmTlyFFAAZ054jQZIsx8+tm4saNyBhX6c11L3iUNsyuKkhTYcjHzroV05yVtXB7LOOwilJB/u
	FvbScGjaPKpNR79ZMsYhRhW0g+XmBMyF4kEbZkRVDVnnmTFmh+bi2IwH9gI5tkSta2X9R1cR
X-Google-Smtp-Source: AGHT+IFPDjZZ2jSWkDcDwN7HnAAvy+rcAZMJ8/BmyCkzIX2EoFGyQ7lLauZiw3lALlG+AjbDXGkZMA==
X-Received: by 2002:a17:902:d507:b0:216:2dc4:50ab with SMTP id d9443c01a7336-22103efc1d9mr249370005ad.2.1739926926221;
        Tue, 18 Feb 2025 17:02:06 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d474sm93826385ad.116.2025.02.18.17.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 17:02:05 -0800 (PST)
Date: Wed, 19 Feb 2025 10:02:00 +0900 (JST)
Message-Id: <20250219.100200.440798533601878204.fujita.tomonori@gmail.com>
To: charmitro@posteo.net
Cc: fujita.tomonori@gmail.com, tmgross@umich.edu, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: qt2025: Fix hardware revision check comment
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250218-qt2025-comment-fix-v1-1-743e87c0040c@posteo.net>
References: <20250218-qt2025-comment-fix-v1-1-743e87c0040c@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 23:53:50 +0000
Charalampos Mitrodimas <charmitro@posteo.net> wrote:

> Correct the hardware revision check comment in the QT2025 driver. The
> revision value was documented as 0x3b instead of the correct 0xb3,
> which matches the actual comparison logic in the code.
> 
> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
> ---
>  drivers/net/phy/qt2025.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
> index 1ab065798175b4f54c5f2fd6c871ba2942c48bf1..7e754d5d71544c6d6b6a6d90416a5a130ba76108 100644
> --- a/drivers/net/phy/qt2025.rs
> +++ b/drivers/net/phy/qt2025.rs
> @@ -41,7 +41,7 @@ impl Driver for PhyQT2025 {
>  
>      fn probe(dev: &mut phy::Device) -> Result<()> {
>          // Check the hardware revision code.
> -        // Only 0x3b works with this driver and firmware.
> +        // Only 0xb3 works with this driver and firmware.
>          let hw_rev = dev.read(C45::new(Mmd::PMAPMD, 0xd001))?;
>          if (hw_rev >> 8) != 0xb3 {
>              return Err(code::ENODEV);

Oops,

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Given that this patch is expected to be merged via netdev, you might
need to resend with a proper subject:

https://elixir.bootlin.com/linux/v6.13/source/Documentation/process/maintainer-netdev.rst

Thanks,

