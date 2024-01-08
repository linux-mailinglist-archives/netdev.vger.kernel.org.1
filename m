Return-Path: <netdev+bounces-62425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43490827164
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 15:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5521F230C3
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 14:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62FC7FF;
	Mon,  8 Jan 2024 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMe1P/Xy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FCD6D6E4
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a28d25253d2so192204766b.0
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 06:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704724302; x=1705329102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PM9kipN//5dmi9A5cadQkBtMsfqYlFsxzZhAvhC6a7o=;
        b=bMe1P/Xynon32C42EBPucdUzBsfjMHaOk6RIdYcCa0Px4NnLAKIb9Ke0sCVUaodNfY
         SJYoO09Li5SQUdnthxLXgqrQGAlzKPnL4ERs2A2A/yTIvbzsZ53NWSM8UCDwD9RvJ6Xh
         iDr+cPmoWt/g5LlezssgrP+4eahF7S/0Xy7VER3XImUnyxwdQVcLv3M3rEpW48QuYxma
         80A9t/vrTDLFnIzAAK8eXH+jnX7zwRAcKt0op9lrLA6E9NEegjkAe8oQOqgEFbzuNatM
         bXM4O75DuDehVrieamC4a68oFAGmNtOfh9tQWB8Ldjp2yGQD0gL2/8iYBxX4Vv1r1NGN
         gACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704724302; x=1705329102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PM9kipN//5dmi9A5cadQkBtMsfqYlFsxzZhAvhC6a7o=;
        b=Gfn9Ht1KyAfZh2cwezAP1/a2KF/CBv8j8F4ekz6DQGTDuQAE6ZmCRNXih8idiluFPm
         HoBJrj+YEWOvLktmqYs5Fl7bItK+6GyRNnsHuxhd7IsXdDRhsk5uJOSNDUzx9+9+M5ub
         OwJr+8J/6/8u8WMYuUHuuU2ArT6fj2or8jlfN454fzcmDKXl9qDRIjyq8iR8M/+RB39h
         esiIB7CmhS1/+atAF2JdySuAz1FMNUiSBNUPpPndE8IrWXxYgX3mFwXaLhX6M5ANHg4X
         bR2wJvcvWCP2grZA0OdisW+EnYMYdVI+k7DMIM66huHnhf3lRdAywKatVMd58SDpPwgh
         MFxg==
X-Gm-Message-State: AOJu0YyYaAC5C4jF7GQrPUP22eCUUVVkz+ACGlM+t7xO53vzM9jeKScW
	xKQJhZWRYpAJKrBnGwjwKao=
X-Google-Smtp-Source: AGHT+IEIlk6KtKsti1kV8qXyoX07cX7/QPYrir5NKqIFjobjAUhwpW/ZzUJLtr5zkVhNtobgoRgxvQ==
X-Received: by 2002:a17:906:c295:b0:a28:e077:ce14 with SMTP id r21-20020a170906c29500b00a28e077ce14mr1593339ejz.43.1704724302218;
        Mon, 08 Jan 2024 06:31:42 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id q1-20020a170906a08100b00a2777219307sm3937178ejy.202.2024.01.08.06.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:31:41 -0800 (PST)
Date: Mon, 8 Jan 2024 16:31:39 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com
Subject: Re: [PATCH net-next v3 6/8] net: dsa: realtek: migrate user_mii_bus
 setup to realtek-dsa
Message-ID: <20240108143139.6igg5emhtdj2nh3o@skbuf>
References: <20231223005253.17891-1-luizluca@gmail.com>
 <20231223005253.17891-1-luizluca@gmail.com>
 <20231223005253.17891-7-luizluca@gmail.com>
 <20231223005253.17891-7-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223005253.17891-7-luizluca@gmail.com>
 <20231223005253.17891-7-luizluca@gmail.com>

On Fri, Dec 22, 2023 at 09:46:34PM -0300, Luiz Angelo Daros de Luca wrote:
> In the user MDIO driver, despite numerous references to SMI, including
> its compatible string, there's nothing inherently specific about the SMI
> interface in the user MDIO bus. Consequently, the code has been migrated
> to the common module. All references to SMI have been eliminated.
> 
> The realtek-mdio will now use this driver instead of the generic DSA
> driver ("dsa user smi"), which should not be used with OF[1].
> 
> The driver now looks for the MDIO node searchking for a child node named
> "mdio" instead of using the compatible string. This requirement is
> already present in binding docs for both interfaces.
> 
> The line assigning dev.of_node in mdio_bus has been removed since the
> subsequent of_mdiobus_register will always overwrite it.
> 
> ds->user_mii_bus is not assigned anymore[2]. It should work as before as
> long as the switch ports have a valid phy-handle property.
> 
> With a single ds_ops for both interfaces, the ds_ops in realtek_priv is
> no longer necessary. Now, the realtek_variant.ds_ops can be used
> directly.
> 
> The realtek_priv.setup_interface() has been removed as we can directly
> call the new common function.
> 
> The switch unregistration and the MDIO node decrement in refcount were
> moved into realtek_common_remove() as both interfaces now need to put
> the MDIO node.

Can you please make all these individual changes separate patches,
some before moving the code to realtek_common, and some after?
There's a lot of stuff happening at once here.

