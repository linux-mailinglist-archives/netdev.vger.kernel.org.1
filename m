Return-Path: <netdev+bounces-88338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECC68A6C10
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 15:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5A31C20AB4
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 13:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F7412C46F;
	Tue, 16 Apr 2024 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMMiLWnA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE0312C49B;
	Tue, 16 Apr 2024 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713273697; cv=none; b=S9Am1md4xe0ApmEQGgIsBwdy3gCO+dO/NI5RpE1eptsFctNm/4ZR2gZ9ZBD3RFb5zhnfp0jJ9reDsW3nVV31KSjxslgJvfB7xw1XISKimMW0Dw5HgC8ueK/QIxN/h3sfyP1pqMGU89AkQujMMoZ8Jo3wDoXeFjSP/Kw5D+EWeNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713273697; c=relaxed/simple;
	bh=rECNAQA2b5JeKpe3ThQ0Ts912GhBjOsctzDrRD27EuI=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hVAvPWjgWJMgZmT5yx0z1dYp81QfC7kKtc1P2K8f5dRyji/6eVtifRxhrPY5poEJ2HyIdV/dwauDQ2nBriO8cKbZFRdMKjdKdkriOQsXfSLVOxCzSH6/mbwvyF5rwE2lnUwhfOAreR8+NtpZaRkZFVW8ez/r/nPeEEVUNTJ0YVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMMiLWnA; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-58962bf3f89so950298a12.0;
        Tue, 16 Apr 2024 06:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713273694; x=1713878494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=549tbuOuKpI8ovt9UKf5mDbOdIqq2Ll6o+uA6hkmv4s=;
        b=NMMiLWnAZfvws60pjBkhxpTG3mGcc5bXWQ0j5YYV9mwaax4un/unRPGvrU0QZYlHZr
         4Dxr6RNO34UitP5/RRwOaAS+Z7cl45ilQwGOniORw/hS+ibK+oSzGQvkr8i4KvvHEXhJ
         NapP2iy4Hst2OCLJ9HtPkJtCUftQathq5q42QveDyXd6uBJ/RuEghhi40KpjP0CgGH64
         ZSukGFKw3FkGmFpIhbUiI4yCCMVO5gf7f0wwgQe4vMznTbrSmBIQxFRa/59Cmjc+szrV
         608n0niPsHWYRa6uyzqnb0cyvSZvWi+HZ/i7fbpjWdEXPEezzYtuQvMkN4/T+vnz+9L6
         wHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713273694; x=1713878494;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=549tbuOuKpI8ovt9UKf5mDbOdIqq2Ll6o+uA6hkmv4s=;
        b=ZymI4xVKb89Bf3a1U8EqGAIeQo8cMG8SRIrsgqsESOdgs86uKQM5J6mv8djC5upXtt
         Nc2bmDsPmRYOoRpVqw3crucKoAIopnMkrSg1dw4MR97wx4kxOn71epIUg08WfOPExNxD
         YNxXv7WvXfJedhkvFOIab9bJvc+uyflgXWqlHUpBWnbHj/8GIkWAYPTuKdEquqDzBSKS
         J/LDd1Bx30lpgpXl7g3uJxeReel/aCNt1rmnQSh3JLDE398UH8PABtMNsw0nzVsFXaiL
         CH8YXy7MVXRsBJ01wtEjH/IPqa65VM9XSfNBCcoZiN68BNCYtwWoeitfaN31TddH2JiT
         6Z0w==
X-Forwarded-Encrypted: i=1; AJvYcCUI1OF7X16PeCGz715eLnTmBjH0tKNGOHoA15DUxAEJ13r0LPWc+r2j95Tw6ossUVaiHJfCjxSCcRVycoBJUzk6Z1FjY22ixCh6WXtcP0c79OjIowbOsv1LjLd7LdGHepGvBJhHGJw=
X-Gm-Message-State: AOJu0YwCRVYU/loSzwtTjuJSTdhX1XEuFFvCL7u6Oaj/yMFBETu4lVKs
	FdiwKhGWn0EU6jyTNkQzqURxfpq21etpIr9qw4pY3IqgJy1yVTKI
X-Google-Smtp-Source: AGHT+IE0ul1+uFXU8qmq1kSK8DZLpSv/2o/mhnlYSWClPGMyGx3wejSwcw6EqGxsbBrLMX8AmRuKtw==
X-Received: by 2002:a05:6a20:c41b:b0:1aa:584f:3b6b with SMTP id en27-20020a056a20c41b00b001aa584f3b6bmr832897pzb.2.1713273693676;
        Tue, 16 Apr 2024 06:21:33 -0700 (PDT)
Received: from localhost (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id z2-20020a17090a6d0200b002a5290ad3d4sm9762831pjj.3.2024.04.16.06.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 06:21:33 -0700 (PDT)
Date: Tue, 16 Apr 2024 22:21:19 +0900 (JST)
Message-Id: <20240416.222119.1989306221012409360.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH net-next v1 2/4] rust: net::phy support C45 helpers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <26f64e48-4fd3-4e0f-b7c5-e77abeee391a@lunn.ch>
References: <e8a440c7-d0a6-4a5e-97ff-a8bcde662583@lunn.ch>
	<20240416.204030.1728964191738742483.fujita.tomonori@gmail.com>
	<26f64e48-4fd3-4e0f-b7c5-e77abeee391a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Tue, 16 Apr 2024 14:38:11 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> If I correctly understand the original driver code, C45 bus protocol
>> is used. Adding functions for C45 bus protocol read/write would be
>> enough for this driver, I guess.
> 
> Now i've read more of the patches, i can see that the MDIO bus master
> is C45 only. At least, that is all that is implemented in the
> driver. So for this combination of MAC and PHY, forcing C45 register
> access using C45 bus protocol will work.

Thanks a lot!

> However, can you combine this PHY with some other MDIO bus master,
> which does not support C45? Then C45 over C22 would need to be used?
> Looking at the data sheet i found online, there is no suggestion it
> does support C22 bus protocol. All the diagrams/tables only show C45
> bus protocol.

qt2025_ds3014.pdf?

> So this PHY is a special case. So you can use wrapper methods which
> force C45 bus protocol, and ignore phylib support for performing C45
> over C22 when needed. However, while doing this:
> 
> 1: Clearly document that these helpers are not generic, they force C45
>    register access using C45 bus protocol, and should only by used PHY
>    drivers which know the PHY device does not support C45 over C22
> 
> 2: Think about naming. At some point we are going to add the generic
>    helpers for accessing C45 registers which leave the core to decide
>    if to perform a C45 bus protocol access or C45 over C22. Those
>    generic helpers need to have the natural name for accessing a C45
>    register since 99% of drivers will be using them. The helpers you
>    add now need to use a less common name.

Sounds like we should save the names of c45_read and c45_write.

read_with_c45_bus_protocol and write_with_c45_bus_protocol?

They call mdiobus_c45_*, right?

