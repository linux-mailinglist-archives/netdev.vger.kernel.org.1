Return-Path: <netdev+bounces-207281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9491FB06908
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB40456505C
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 22:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6643E2C159E;
	Tue, 15 Jul 2025 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHVqqc1X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1BB2C158F;
	Tue, 15 Jul 2025 22:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752617221; cv=none; b=X+mo5YIKTED8foRsY3BsPXYXwmZGT6Dj3tKOcg0wbUvX3T5V669/ehnx+UnGhRsjL22FQrzjBHb+EYt1n4qGFbYo0i/dDxxqIy6qtiMWHgGag0ftzYkilvAOTpg3/TQkMZLEG32kZhL/haSojykVJnJF3SLIcBA3fa4kDaHBEKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752617221; c=relaxed/simple;
	bh=Zufzfaszt8lMoqhAnmQDPusrRHLz87gmZprCGkIVLWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aB5n5zWs4lKAL6rakh61F3kEePHpq9J4NtcRuzbFwtnDkfn5K+VdHgGVvr/XSTHhtq+q6dX5BRooVmlMSIL+XRZrP70DcHvOi82+G3qEZEHkm3shuxe8Idvphs5m9jxBWABTQWqpHpsT49C0Z5+ztusJrEW8LY2A5c2qfyKa9ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHVqqc1X; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-311ef4fb43dso4859842a91.3;
        Tue, 15 Jul 2025 15:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752617219; x=1753222019; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5+1bnGTrSGimGK3Zq/YxQ9BHvkckKvMOjIcjntRlGw4=;
        b=aHVqqc1XnwSdgPm1DaItW+YIh+sV5jTS+46KF9NM2wVO76QLRsVOgeiuaq0mCJBNZY
         482BdRsIJXOW6ecPrBnXOYdxMDoN/ozc73f4qh0vaz7yded/7zPo9XFOv8feTeWpzIKX
         +G9G91bKNtBSvToqELVPKnV2i8GTxdmMdmmfm3Eot7hQ9tOO6Tk3hgdEhg/8diTgWl37
         5EiwIyA3BJY9cmJwjCmVHsS+StCYZ8H9oGnD75qUcB83CRGkicad4duSeAPKx2UJShf9
         0VBdYuZ89Xq68PZFxkPnGZz8nvDNII0cFjNzMDiVtCTp05KvJHN9BsBQrzeLn3abpxL/
         5nwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752617219; x=1753222019;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+1bnGTrSGimGK3Zq/YxQ9BHvkckKvMOjIcjntRlGw4=;
        b=q+u6NXP7vo2Qrl9ZW780FhI0/unHjVfQqtGi5RECqamqj4Hr5Z1UIGHXQui1B0bnD4
         u1K40SE2Yo0XXyrJaYkoFOeh2AT0m9zWROv7AdJu1pvo43RUWC4Z73vOxzfK5AA8teiZ
         ep7rvutIlTKKffvGbBCBe53+7qXpDk4c7ftADT88bsbEMsnWBqkWqAWwVAs4YnXO75Db
         0rOx9h1jlP2o32qmsuhJRB37uY59obrOrAGTF8HOZEAzqrKvW2xEdT5DoQopOPJvU4wP
         UmK9f84c6xiSH9RBUSh/zwsMWJGCk7p5j4UyL55cFtGImBOwUivk2cLKpirerp0Rl1Ls
         KroQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpb2UUlaH66f/nWPFR0aJB3qwbGtpcJfNCQMny+n7+mNab2TJKAVa1qf/4Hc/RJAFRjPXwCBNoSqwACjSG@vger.kernel.org, AJvYcCVxGt0nF/6q8V51IJSiPSa87pugNa/ENLWsGL3gNiDx3VgmTb4IiOmfAvH0JOFBPfToksECAXqjd/Zv@vger.kernel.org, AJvYcCWRPyqot+y15VhDMhb6rcgdhFimwMW5Akp9QElKvFoHdKwl+eZeIkhorDeADFCz+nf8R1Zs8dJx@vger.kernel.org
X-Gm-Message-State: AOJu0YzPPAGvb+v0vMVi24Bne4OTJ/UxbsMkIyd3VxnWa2D9jZa1ujhB
	SFj0BGc0waKvYnToB4EMshB55heUg8/R/CiCYY1SvBQ+CaFGsZllXmO+
X-Gm-Gg: ASbGnct9U8mJQohtAP7pRWojSuvsmMMPNoZY7Hp/RgA+Q0nG6V9kGgV458vo1jzbWQa
	0ZPATvVXDkVq5m11DWbR37GAkmm7syskdp4GVSpq2c6WOIx9WlNbaJOG9Uw/Mu+3LtS7bhU8ri3
	v29yp2KrRPXbZQmEh4FZb+nYvqCpjCHCEFQYvHGXRkcC3VAs7mTha7xOMzdqkz59uAetqEglau6
	A9aNYu/FRWnREiGGHLQBcBWYVgDDBAhp3LsCUhnYVZFs6wKRmoVaF8wwCIZJdGvBK9MhIjU6FDR
	Aq5IEQDed9qZPsjFIImpYlKiZx3OJxpsVlviTO2Tjt7XL3B5nnB/2tqFvChHRupiqclpU4P842X
	s7AJLSlzql8D+K9QGOgZBNA==
X-Google-Smtp-Source: AGHT+IGA5Go/W11svBOlx+oojZuGSHeTcf6nPxWvkyTAK/25JmtPG/Wzl0xDDQgSb4VJ+3l1d//G6Q==
X-Received: by 2002:a17:90b:2ec7:b0:311:ef19:824d with SMTP id 98e67ed59e1d1-31c9f435537mr372501a91.2.1752617219023;
        Tue, 15 Jul 2025 15:06:59 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31c9f1e61d2sm96213a91.11.2025.07.15.15.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 15:06:58 -0700 (PDT)
Date: Wed, 16 Jul 2025 06:06:40 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Chen Wang <unicorn_wang@outlook.com>, 
	Richard Cochran <richardcochran@gmail.com>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Yixun Lan <dlan@gentoo.org>, Ze Huang <huangze@whut.edu.cn>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 2/3] riscv: dts: sophgo: Add mdio multiplexer device for
 cv18xx
Message-ID: <bww3dwd37ujcnztbzw7o7r2qajwcvn54kcd6pcd42y4axfp2d4@zx5jrtcmkh4k>
References: <20250703021600.125550-1-inochiama@gmail.com>
 <20250703021600.125550-3-inochiama@gmail.com>
 <CAL_JsqLKLKHj+vQJmZnaXRj3TmqR3ELjpBc27HRbTOOP9FD0hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLKLKHj+vQJmZnaXRj3TmqR3ELjpBc27HRbTOOP9FD0hg@mail.gmail.com>

On Tue, Jul 15, 2025 at 12:43:35PM -0500, Rob Herring wrote:
> On Wed, Jul 2, 2025 at 9:16 PM Inochi Amaoto <inochiama@gmail.com> wrote:
> >
> > Add DT device node of mdio multiplexer device for cv18xx SoC.
> 
> This adds a dtbs_check warning:
> 
> mdio@3009800 (mdio-mux-mmioreg): mdio@80:reg:0:0: 128 is greater than
> the maximum of 31
> 
> >
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  arch/riscv/boot/dts/sophgo/cv180x.dtsi | 29 ++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> > index 7eecc67f896e..3a82cc40ea1a 100644
> > --- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> > +++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
> > @@ -31,6 +31,33 @@ rst: reset-controller@3003000 {
> >                         #reset-cells = <1>;
> >                 };
> >
> > +               mdio: mdio@3009800 {
> 
> The nodename is wrong here because this is not an MDIO bus. It is a
> mux. So "mdio-mux@..." for the node name.
> 

Thanks, I will send a fix for this.

Regards,
Inochi


