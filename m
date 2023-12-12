Return-Path: <netdev+bounces-56173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0402780E0FA
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 02:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37D42810C3
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 01:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F8F800;
	Tue, 12 Dec 2023 01:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQgWiO3A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B214ACF;
	Mon, 11 Dec 2023 17:46:52 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d33819091fso188125ad.0;
        Mon, 11 Dec 2023 17:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702345612; x=1702950412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jju21SUwEHUZorrx0HLBuSA8/zFtpsFlwl1EG/olYPI=;
        b=LQgWiO3ATA/g2KX5cOTSPlowhbvltNP5EyFw+jMEjkJIACf5YV1QmpYYZhFYh8L6qm
         9AAA7/LiLYQczY/kpBGF9LvrbkJw61I2VuzuZW1FNIUPMOalAGDV9hTJMrlSUw/iC+mR
         FfA9bUDyOvgB03MGw7nbBBCJS9jN3Fe7qk223N8maB2OJavNGXGODL7s/4j05cgMsoQY
         tQl/5L1WSnxGbPFi7Bw9IriiUbib4SkBV6LIDryIlfZ7wURF9mtH/HBGWaEX23bQL+JB
         kdRgZsTg3vRUIAuoRIgTjSG9PxGTkzvxN+LdSF5VWGD8CZpjlClM/VYV3bQOQcptUYgu
         pZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702345612; x=1702950412;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jju21SUwEHUZorrx0HLBuSA8/zFtpsFlwl1EG/olYPI=;
        b=lnhEg0Tm1mEM7ytg7Gxx/hSTA9N1cHaRUevXPmQNzAa4LATQM2piXUqV6YxaqmDPj2
         yaWMwdrBEvPiAoISNQaRUYoAfI98+B2rUznA/gu/zXFxVNAoMCO6MPRSDalBYmiTTcmc
         CqvTYfNiiaX3Xm0SwzsDSZooAjfmzdgSLTIttJeIOUcez4nq1i2kIhYAHW9nLtcA6p5G
         g3Y+SSyhFt4+pFy6ZBqZvB3z/dEXVLGHOUwbmp0b4VBq81s4W04zmuWPZpIhP6N4RfZi
         E1ZhJq+00XDXUzIUu86mYudtjWdcPIe/p41+VWoFBE3j6jLgW5Tw/UMqsjb0ZvPYtWLI
         /PTQ==
X-Gm-Message-State: AOJu0YzQ2dSiSHv9Is+LBhkKp4rkpxmIQppp2Vhuv3hjF5tbp8WSdsVf
	MVRa9yzWcuSqYGjsgzkazt27s6Fa8xm/OUA2
X-Google-Smtp-Source: AGHT+IFvC2g98zxwV9w9zNQM32C+ci5k0t/PhIy1P0MdsnKUh5hDUPcEFIrBMBFprMrVlNdiuWNUWw==
X-Received: by 2002:a17:902:db09:b0:1d0:c93b:fb9 with SMTP id m9-20020a170902db0900b001d0c93b0fb9mr10701845plx.3.1702345612144;
        Mon, 11 Dec 2023 17:46:52 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id bh2-20020a170902a98200b001cfc34965aesm3602774plb.50.2023.12.11.17.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 17:46:51 -0800 (PST)
Date: Tue, 12 Dec 2023 10:46:50 +0900 (JST)
Message-Id: <20231212.104650.32537188558147645.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, alice@ryhl.io, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZXeuI3eulyIlrAvL@boqun-archlinux>
References: <ZXed8cQLJhDSTuXG@boqun-archlinux>
	<20231212.084753.1364639100103922268.fujita.tomonori@gmail.com>
	<ZXeuI3eulyIlrAvL@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 16:49:39 -0800
Boqun Feng <boqun.feng@gmail.com> wrote:

>> touch it (doesn't need to know anything about it). What safety comment
>> should be written here?
> 
> Basically, here Rust just does the same as C does in phy_read(), right?
> So why phy_read() is implemented correctly, because C side maintains the
> `(*phydev).mdio.addr` in that way. We ususally don't call it out in C
> code, since it's obvious(TM), and there is no safe/unsafe boundary in C
> side. But in Rust code, that matters. Yes, Rust doesn't control the
> value of `(*phydev).mdio.addr`, but Rust chooses to trust C, in other
> words, as long as C side holds the invariants, calling mdiobus_read() is
> safe here. How about 
> 
> // SAFETY: `phydev` points to valid object per the type invariant of
> // `Self`, also `(*phydev).mdio` is totally maintained by C in a way
> // that `(*phydev).mdio.bus` is a pointer to a valid `mii_bus` and
> // `(*phydev).mdio.addr` is less than PHY_MAX_ADDR, so it's safe to call
> // `mdiobus_read`.

I thought that "`phydev` is pointing to a valid object by the type
invariant of `Self`." comment implies that "C side holds the invariants"

Do we need a comment about the C implementation details like
PHY_MAX_ADDR? It becomes harder to keep the comment sync with the C
side because the C code is changed any time.

