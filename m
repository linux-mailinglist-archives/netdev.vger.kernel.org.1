Return-Path: <netdev+bounces-64882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFED3837576
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 22:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804A52892A1
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 21:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C3947F66;
	Mon, 22 Jan 2024 21:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIVV20lh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEC24A988
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 21:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959284; cv=none; b=WhRKtCs6fuukTvXyBQXZuqqtGXgwAG7QgKtmImuBwghIFRNgNyqCCiPS6+aFmxV3d8XU0Mr9oElA9DtzftT7e/kxMuACEWBIVpkSCuwbmA8yAE4aDjHbu0QG9h6xG2feWeGHU1A0cYt4J37pGB1XULIfNJs+NflsfSaVeUzApVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959284; c=relaxed/simple;
	bh=3TKT9yJq24AyIbEVyuJNQPiUAvedxLQbgvuFK4P0zho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmverdHGFIL5bfdoBK+lNQCP+wGuu83vawuw8Skk3fcA+cR8jSSyc18anTXlEqYBXM/17v1LvSiQNWcwD5j4X7SRnHcH/tXlRgvJysc1PKhjR6r3hekN1INiSEuXbKEI1iXUSyiUfh70TBFvgFR/Y1oXLZrztDVRxhYzZ6CfhHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIVV20lh; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cd880ceaf2so41125151fa.2
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 13:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705959280; x=1706564080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zfd86BT01E4bkI5UdjQWHq+9XXPY+bNfLObP0/g0wqo=;
        b=eIVV20lhMSlskhy9IDbE3NLY9geJFAsSqiyoujgFbXIy89HRwNNK1YrR4ftC/CVdpQ
         x8LYf1opq89sPSq7gmCIm1bSbOyXme1bvqU7U5wtGhd2d8DtiVoHgwL1p4ij52B9TTPX
         gU1pUyHJShnBmUydfErgKI9ZzbCL+yMJinHZh1nLvwJKEDnAetQYyHgNoUyZsYJYii+u
         u7Y9XWSFdZwJh6kz07xjrQYJJbNNxUDfTxqGIO6IyTLJCMtJ+xLi6nYXhnFk7XQFARNN
         +f+xzfPk2tOiODyd/7t8h5Xj3o9Zk+xBz8c8LTRKOtIxvr7QU4NKHq9eg7JOZN4oVCM9
         RvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705959280; x=1706564080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zfd86BT01E4bkI5UdjQWHq+9XXPY+bNfLObP0/g0wqo=;
        b=jqS9vzz7ejiNqHJzRRlHmjDt24yd0BcKY48IWRee1orAxwmOFt7KYKhi6gcW4ggBkd
         dy6iZBT1ACwUCkLgTPdubVP7lk1dZimaQrDL03T1iqf9zIUO5faN4Gjy3vRaBVKej9b7
         2aU0sfZato6YZ1jFybPuR3Jj9BUgbi0e8gFCjfZjxhrt0enUeaoVDPe/eJEBNmkTlnpx
         yV7wVgrqU+81aEQTFa96rw4r26pBD3CCD3x3IOJ4NGXJ7S+qyBG/jVu95LkO/KBe0PVO
         XGxOck96Fq/wSmg0V47YwvPYMBxid7l5bEpt9D9w7deg3G6UpHN9Jyv0OcuuiGJWil/B
         4c1Q==
X-Gm-Message-State: AOJu0YypoSmQxOS8EwUMwZWknnoHJMmLieZ6/01SkjhIm4l+WD7JseYB
	8kXdIutQHOHUFF57eel09Y4THkFMvCzjJxDwunXxPBrKQlr00g+u
X-Google-Smtp-Source: AGHT+IEPiaPDeQdF9TdUpskjSb4CXo3NV3QEKALOyl+mt2kdcJ5p+390pA/a/VP6u6EszB8ktKAbhg==
X-Received: by 2002:a2e:9a82:0:b0:2cc:89f4:15a3 with SMTP id p2-20020a2e9a82000000b002cc89f415a3mr2004866lji.49.1705959280218;
        Mon, 22 Jan 2024 13:34:40 -0800 (PST)
Received: from ppc.Dlink ([91.223.70.172])
        by smtp.gmail.com with ESMTPSA id g5-20020a2e9cc5000000b002cce514819csm3596615ljj.124.2024.01.22.13.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:34:39 -0800 (PST)
Date: Tue, 23 Jan 2024 00:34:37 +0300
From: "Andrey Jr. Melnikov" <temnota.am@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Marc Haber <mh+netdev@zugschlus.de>, alexandre.torgue@foss.st.com, 
	Jose Abreu <joabreu@synopsys.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Jisheng Zhang <jszhang@kernel.org>, netdev@vger.kernel.org
Subject: Re: stmmac on Banana PI CPU stalls since Linux 6.6
Message-ID: <ufdsvmdz4cac2s6fkvyvzj7gyogg3tlpj6w34vafqhhecfoofg@h6arhapag3t3>
References: <Za173PhviYg-1qIn@torres.zugschlus.de>
 <8efb36c2-a696-4de7-b3d7-2238d4ab5ebb@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8efb36c2-a696-4de7-b3d7-2238d4ab5ebb@lunn.ch>

On Sun, Jan 21, 2024 at 10:52:56PM +0100, Andrew Lunn wrote:
> On Sun, Jan 21, 2024 at 09:17:32PM +0100, Marc Haber wrote:
> > Hi,

Hello. I have same symthom on same board.

[skip]
 
> make drivers/net/ethernet/stmicro/stmmac/stmmac_main.lst. You can then
> use whatever it is reporting for:
> 
> PC is at stmmac_get_stats64+0x64/0x20c [stmmac]
> 
> to find where it is in the listing.

root@bpi:~# grep -ah 'PC is at ' /var/log/syslog*
Jan 22 20:13:04 bpi kernel: [256048.826170] PC is at stmmac_get_stats64+0x5c/0x1f8 [stmmac]
Jan 22 20:14:51 bpi kernel: [256156.077831] PC is at stmmac_get_stats64+0x40/0x1f8 [stmmac]
Jan 22 20:15:18 bpi kernel: [256183.687522] PC is at stmmac_get_stats64+0x64/0x1f8 [stmmac]
Jan 17 10:50:44 bpi kernel: [156104.837571] PC is at stmmac_get_stats64+0x4c/0x1f8 [stmmac]
Jan 17 10:51:52 bpi kernel: [156172.085436] PC is at stmmac_get_stats64+0x64/0x1f8 [stmmac]
Jan 17 10:52:37 bpi kernel: [156217.161344] PC is at stmmac_get_stats64+0x64/0x1f8 [stmmac]
Jan 17 10:53:03 bpi kernel: [156243.852175] PC is at stmmac_get_stats64+0x64/0x1f8 [stmmac]
Jan 17 10:54:40 bpi kernel: [156340.689082] PC is at stmmac_get_stats64+0x48/0x1f8 [stmmac]
Jan 17 10:55:07 bpi kernel: [156367.851904] PC is at stmmac_get_stats64+0x50/0x1f8 [stmmac]
Jan 17 10:56:11 bpi kernel: [156431.692860] PC is at stmmac_get_stats64+0x44/0x1f8 [stmmac]
Jan 17 10:56:49 bpi kernel: [156469.648758] PC is at stmmac_get_stats64+0x64/0x1f8 [stmmac]
Jan 17 10:57:15 bpi kernel: [156495.851573] PC is at stmmac_get_stats64+0x64/0x1f8 [stmmac]
Jan 17 10:59:20 bpi kernel: [156620.036359] PC is at stmmac_get_stats64+0x64/0x1f8 [stmmac]
Jan 17 11:00:31 bpi kernel: [156691.276191] PC is at stmmac_get_stats64+0x38/0x1f8 [stmmac]
Jan 17 11:01:07 bpi kernel: [156727.700103] PC is at stmmac_get_stats64+0x40/0x1f8 [stmmac]
Jan 17 11:01:31 bpi kernel: [156751.850926] PC is at stmmac_get_stats64+0x48/0x1f8 [stmmac]

so, PC always after first memory barrier (according to objdump -DS sttmac.ko):

....

00005b6c <stmmac_get_stats64>:
    5b6c:       e92d47f0        push    {r4, r5, r6, r7, r8, r9, sl, lr}
    5b70:       e52de004        push    {lr}            @ (str lr, [sp, #-4]!)
    5b74:       ebfffffe        bl      0 <__gnu_mcount_nc>
    5b78:       e2805a03        add     r5, r0, #12288  @ 0x3000
    5b7c:       e59535c0        ldr     r3, [r5, #1472] @ 0x5c0
    5b80:       e5937078        ldr     r7, [r3, #120]  @ 0x78
    5b84:       e5934074        ldr     r4, [r3, #116]  @ 0x74
    5b88:       e3570000        cmp     r7, #0 // r7 - 
    5b8c:       12802db9        addne   r2, r0, #11840  @ 0x2e40
    5b90:       12822008        addne   r2, r2, #8
    5b94:       13a06000        movne   r6, #0
    5b98:       1a00000b        bne     5bcc <stmmac_get_stats64+0x60>
    5b9c:       ea000026        b       5c3c <stmmac_get_stats64+0xd0>
    5ba0:       f57ff05b        dmb     ish
    5ba4:       e320f000        nop     {0}
    5ba8:       e320f000        nop     {0}
    5bac:       e320f000        nop     {0}
    5bb0:       e320f000        nop     {0}
    5bb4:       e320f000        nop     {0}
    5bb8:       e320f000        nop     {0}
    5bbc:       e320f000        nop     {0}
    5bc0:       e320f000        nop     {0}
    5bc4:       e320f000        nop     {0}
    5bc8:       e320f000        nop     {0}
    5bcc:       e5923000        ldr     r3, [r2]
    5bd0:       e3130001        tst     r3, #1
    5bd4:       1afffff1        bne     5ba0 <stmmac_get_stats64+0x34>
    5bd8:       f57ff05b        dmb     ish

....

it loops in tx stats reading.
 
> Once we know if its the RX or the TX loop, we have a better idea where
> to look for an unbalanced u64_stats_update_begin() /
> u64_stats_update_end().


