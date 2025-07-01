Return-Path: <netdev+bounces-202720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA73CAEEC0F
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 03:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD451890B7F
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 01:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C9718C322;
	Tue,  1 Jul 2025 01:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjTDVRga"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1CE4C97;
	Tue,  1 Jul 2025 01:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751333017; cv=none; b=uheKuq6VdrmBLMBIp85suIxnjOfmlUU25qH3XRjVxvNLFMZNr+H+aLodJzfUxbmPLuoNVIY135G3jU41aC2aVEf0CSP/Sxbxod0yR5wvute4Zc1yb2p6SzsCZgmwPqFljfzuCwKRHdI8z95dOew4S5qWxps9tTVb+Am7vXstzro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751333017; c=relaxed/simple;
	bh=nWsdPjkIHLStXytRDGELqLXh6E1K8A/hb4EUHkz3d2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cr400GwGhkRN+Uc/eknnLvmEW1a741KY5CFJFXv/a9si1+n080iivBpCbQsYTqwVynNSzg/l1rolwnjrxcnhG2o7gfgP45J1xZZgS2zqmBuS7e2GvNuE0Nh4xT8o3zOL1U8CtpDkrfxPvHF91e+gf6tXgR/mlcsDjEoolVWm1hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjTDVRga; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b34ab678931so4331302a12.0;
        Mon, 30 Jun 2025 18:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751333014; x=1751937814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z6DtZA4TeVhHJ4LgQPcp62/OtINngczo0Qlp10jTpvs=;
        b=fjTDVRga1RdzPLhuBmnlRpiR2yMry5yzR/788IA0nqxm/job94fNqyMW+IrrFUkEUk
         VIigMaTZRMnBmE9oB1fqeEho6CkUQ3s5fUkLiZvOwRukeEN83ZeOEW9oXeS5X23w0Wss
         hr4SsPMzio9J3+8SQrztE4lcaj98tKRa1hEPwAcxWljP8ZW5nRBRO/Xn20q1x5+Q4BDW
         9k4O60Zad0CbQOTUvuP3ZYB2lDqO37fd9QgHtLqsT0aAZG/IWatkD2FWUWjYsLH9Vq4n
         TOIKjYTwQ6KNu7+dN4p5DSlUOGJCO/w0weE8sTxyygNgM+M4sd9wxQ+HkftduF9a+m9x
         co0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751333014; x=1751937814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6DtZA4TeVhHJ4LgQPcp62/OtINngczo0Qlp10jTpvs=;
        b=mU/RppwYw4q4FXusc/fMzgdBMLok/vlg4slU2qtrFwhLUosuSNwZhf1GpPGHFlcR5x
         W7RI2KRiOsA0jBBfeb6r2/uz/7veOYSshmzd4XmXtBpYYqOZxICjl8zfuqtphNZPXGZr
         u/QSetjxQPjMV8ZJX9CTXYm7yvx6KxAEm42/D0hgIZMM9c9sJc3WeVx164E0ivpSJszW
         ZnDrwETppVx632AYyxUJKM2bjUpR2NHyxE9uFzyEKmrS2WjIiCAmqmuMltG2bEZMjDzX
         3vjwwnLAP5F8+yZxHIdTLfY1qTHL6x8PaV9VZ8kG4zC4ppf3aJNI9jECkJTo+MiIduef
         zIDg==
X-Forwarded-Encrypted: i=1; AJvYcCWZFPxEZKNwU6ECPuuueGAMgUE5gq8yKm8yS9d4MraYqx1e/HOInhhPYmNeAJXKRfTzNZJcKd1Z51jl@vger.kernel.org, AJvYcCWb9myZMAGkuv1E0vpC4L/40a/d5CyVf5tC0jfZ8D0I0tPkhseKIiBbjfO56s8Iei2dawLSXiok1Dioiv2B@vger.kernel.org
X-Gm-Message-State: AOJu0YzDfTIYnBYMgXTQilcecaKmO1mH0CyFrXSCGPBdDucbUQan+Q8z
	AuxFWgbIoZFxJFDniA/jFe+08CiBHyfUECq5nkRo47LcQ97F/9OP2e8a
X-Gm-Gg: ASbGncu46+QqN9wi6HG73qLQ6Wa4IFuwMLAv7CUsCq2pBC8a58OK1imWftcCW6/npdo
	vQW3FW808s2ahBbnU7HVWUrVMvZLCp8ZU4bCCJ+htRyPIXToHACsbo7Xsi4hzQ/q8a49pCdsTsL
	A5iPxmWBCkM15Hxm9LffnAF+f8RM/4YK3tF7b+PzAaCgB5tbdeqXLEhvjqY6vD0IRj6S3GVPiKt
	G1ifKz5uoENsmhfP7750jkyCzJtvhKGt2jfFeXvuuXcEZR0ZGnl415BHNNCJfENkTvQb/gQtJE7
	tP1KuarTliBoqHwk2TCZ0DKcK81TIYcGiKVoi9RFhpQ6kQPoIWnC83G25YuYWw==
X-Google-Smtp-Source: AGHT+IHBfzg5Sx40TE02hAClbOF6eEZK4Q2Z0GmTczaAMMCBaM6R3MFw6f7sjjsS70ov9TvAF6LTsg==
X-Received: by 2002:a17:903:1b28:b0:235:2403:779f with SMTP id d9443c01a7336-23ac4682496mr217436775ad.29.1751333014268;
        Mon, 30 Jun 2025 18:23:34 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb2e2423sm91648245ad.37.2025.06.30.18.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 18:23:34 -0700 (PDT)
Date: Tue, 1 Jul 2025 09:23:16 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Richard Cochran <richardcochran@gmail.com>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Yixun Lan <dlan@gentoo.org>, Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Ze Huang <huangze@whut.edu.cn>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next RFC v4 0/4] riscv: dts: sophgo: Add ethernet
 support for cv18xx
Message-ID: <vxnvovuetfd6rzgaenwplpkhxm62fhw6t3vi4wkyigul7p4bkx@pwlprna4pyul>
References: <20250701011730.136002-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701011730.136002-1-inochiama@gmail.com>

On Tue, Jul 01, 2025 at 09:17:25AM +0800, Inochi Amaoto wrote:
> Add device binding and dts for CV18XX series SoC, this dts change series
> required the reset patch [1] for the dts, which is already taken.
> 
> [1] https://lore.kernel.org/all/20250617070144.1149926-1-inochiama@gmail.com
> 
> The patch is marked as RFC as it require reset dts.
> 
> Change from RFC v3:
> - https://lore.kernel.org/all/20250626080056.325496-1-inochiama@gmail.com
> 1. patch 3: change internal phy id from 0 to 1
> 
> Change from RFC v2:
> - https://lore.kernel.org/all/20250623003049.574821-1-inochiama@gmail.com
> 1. patch 1: fix wrong binding title
> 2. patch 3: fix unmatched mdio bus number
> 3. patch 4: remove setting phy-mode and phy-handle in board dts and move
> 	    them into patch 3.
> 
> Change from RFC v1:
> - https://lore.kernel.org/all/20250611080709.1182183-1-inochiama@gmail.com
> 1. patch 3: switch to mdio-mux-mmioreg
> 2. patch 4: add configuration for Huashan Pi
> 
> Inochi Amaoto (4):
>   dt-bindings: net: Add support for Sophgo CV1800 dwmac
>   riscv: dts: sophgo: Add ethernet device for cv18xx
>   riscv: dts: sophgo: Add mdio multiplexer device for cv18xx
>   riscv: dts: sophgo: Enable ethernet device for Huashan Pi
> 
>  .../bindings/net/sophgo,cv1800b-dwmac.yaml    | 113 ++++++++++++++++++
>  arch/riscv/boot/dts/sophgo/cv180x.dtsi        |  73 +++++++++++
>  .../boot/dts/sophgo/cv1812h-huashan-pi.dts    |   8 ++
>  3 files changed, 194 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml
> 
> --
> 2.50.0
> 

As this is mark as RFC due to the reset dependency, now it is OK
to merge it as the reset patch is taken and this patch is a minor
change . I hopeif anyone can take the binding patch so I can take
the devicetree patches.

Regards,
Inochi

