Return-Path: <netdev+bounces-200414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3D3AE541B
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 23:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED31644648E
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 21:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA47223DC1;
	Mon, 23 Jun 2025 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0/5Vqmt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30605222581;
	Mon, 23 Jun 2025 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715951; cv=none; b=RamtyLAWkk1Y9kaqVvkjtzPxKpgVmhjAT+eN6sx9nMwF/yzbWRWZGRbLNms1vsxVrdBa7khNFqGe9hOTSTkL0Vpa90zXBcjeTPowyztYTfBh0lX6ZLccASUGLz+VHhvYrV17Q59knLs0xvEaceqtCaoYEy6LHJsHsdk4cC/gadk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715951; c=relaxed/simple;
	bh=CV+QG6+CRgw24neLMjPi3GkjM45lC+PSOpguhXjN91Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMwywrJHBRBrFye6uvaF6zv+dDycBmAAxo0p8HxBUH9iC1iEDusyfP4ApgvG5HfI7WY81aB/lO8it+QogJ7udO3loFyskK0yEb8dlLxXsAq7TiTZbFq4c2ryIYp5/ffi4JELJpITPr6O8mtakMOmIR3ClH24KcmE4OUTySqkMy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0/5Vqmt; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso4015257a12.3;
        Mon, 23 Jun 2025 14:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750715949; x=1751320749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l3yB+qOk7ujVR/LBAYKGt7qD8w55PbhtiiJGomEX+B0=;
        b=L0/5VqmtE1m596lhLw9fnegnQp8ylD702uSqGurQl4soZF0PT+MStvTp7mSZf99Ycv
         a2ICHKuFGE3GXW5GsPh1CryVY3bzEw4ehQo4qz5iv3IZxuwmoKQnybCVz/GReETME53U
         nrazeVLy8KnAV+4nxYVCpeNhIrT7R1bsLUyuh5ACdhUxpv951EejxYK9DsxOPJ/tbZC9
         n5hgda6y+TCD2NHtWMSp/69xM0ZPuVtUj65dbn1sm0+JhHn9Yi6f++mFNDyu8vdpysIs
         MaFsd0+dR0CPbMq3j9k5Wi489YKMhoXiOLhAgsWH55fF2qGVnJ0rzv05fWQswE7t6S7N
         Pbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750715949; x=1751320749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3yB+qOk7ujVR/LBAYKGt7qD8w55PbhtiiJGomEX+B0=;
        b=nl/UMXAC2yDiJB/+sA0H+9auQ1x0kdd95SeLtNtQYAqsb4zPwFLKzfl3SFs7f9TdRb
         +Rxq+td3+goz6iLQQJgSfQRhiGRp1Xn2HCagTyTBDUWno9+bxm5sOjkQ9N46ffNPn8vi
         dmB7u0nw0HHEhSzshs1soH9fCIBGX5DqV4lVb1gVPIO3ccUBOBLKt4qiBmsk0u0u8en6
         3x2ftiXCs1JbZNOuKniHmLhQVOTLzvqje+7deTFL6p/7QJMByOBRCxmATyR30RWuemkL
         eEbSaLek/8Fdg2YGjptCwSfAVaWx5vAYKhrhKNwCXReSFkWwUG5pX9hY0DJOG4x66kOM
         yOwg==
X-Forwarded-Encrypted: i=1; AJvYcCUecGXN2/dc7+fZSABzGRORavIFbFq675S1iwplu5mQk9rO4VUSSSKfsRY7pKMvVhUvLvAuprkJ@vger.kernel.org, AJvYcCV9DLD5x3/hl5LJAcSZ0PHZbWPpV/ZjI15Ti0Fr+DQpEJiZ9EW51k3nkVbn8yshbQpBSX/Fyotx4+k3y0O4@vger.kernel.org, AJvYcCXexLGV1E2B9TJWPnBxRf4qetymepdaIBjC9bSZJ1iIr62/UxoMhBttoc0LlX6UjWJ+6C6/LvTcP49B@vger.kernel.org
X-Gm-Message-State: AOJu0YwzL9RVp8iLHtwjHravemrl1ig6ch23Yp52FBiOAzPxL0PJbanD
	AuOgA77m8QI5ANhrYh5T5Q28lZuJZYBkiKBIUs6b78UDPArO1ss2wbPs
X-Gm-Gg: ASbGncsyLHK/78Ehbnj+Rrrn21bzR9mLdGMIB3uEZysL/VXv5Rb+0YAsX0ahQMITyWi
	V5seoKq6Df+HG4fFCJac7bE+FSN1OWtqbmPmNp3PsxzH9LxsC6yGBZ+yy0vW4CcCi5BQKOmmRYE
	zI+Hw6rkxEt4W2rVERxtusW7fmOl41caNwM88BliT5Wf8tODNJeX4xMv/hnsz3GDXGGpYGZypiX
	FTO8n8gVh4bbNTIEkbUQQzVzRwMPskaDsZKe7yz636cE09sk/z+9fhmvjhoHa9jZ8bCHh9AczUf
	SsJ19VlqBfMUpaFk9ohWLp09VRLOiWTp1px37L5lNB1mFIM5qUts6uoMDPKBqw==
X-Google-Smtp-Source: AGHT+IGFzE62qF3LBZw9k/a/Lzh2nlx6tpEsN8z9xHpzhHhKrHLcsX6GHI2IN06+kXkIIoSfeiuGQA==
X-Received: by 2002:a17:90b:4a01:b0:311:a54d:8492 with SMTP id 98e67ed59e1d1-3159d62bf03mr19438715a91.6.1750715949257;
        Mon, 23 Jun 2025 14:59:09 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3158a331288sm12485010a91.43.2025.06.23.14.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 14:59:08 -0700 (PDT)
Date: Tue, 24 Jun 2025 05:59:01 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Yu Yuan <yu.yuan@sjtu.edu.cn>, Ze Huang <huangze@whut.edu.cn>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next RFC v2 4/4] riscv: dts: sophgo: Add ethernet
 configuration for Huashan Pi
Message-ID: <vlolusjs436s3tsp23g2bsr33fngp6vrc2g7vbaeypf3l3gi5k@i44w7sjacahp>
References: <20250623003049.574821-1-inochiama@gmail.com>
 <20250623003049.574821-5-inochiama@gmail.com>
 <bd1485c7-e6c3-4360-8e3c-e584ea0b8040@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd1485c7-e6c3-4360-8e3c-e584ea0b8040@lunn.ch>

On Mon, Jun 23, 2025 at 09:26:43AM +0200, Andrew Lunn wrote:
> On Mon, Jun 23, 2025 at 08:30:46AM +0800, Inochi Amaoto wrote:
> > Add configuration for ethernet controller on Huashan Pi.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
> > index 26b57e15adc1..86f76159c304 100644
> > --- a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
> > +++ b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
> > @@ -55,6 +55,16 @@ &emmc {
> >  	non-removable;
> >  };
> >  
> > +&gmac0 {
> > +	status = "okay";
> > +	phy-handle = <&internal_ephy>;
> > +	phy-mode = "internal";
> > +};
> 
> Since the PHY is internal, it should be part of the SoC .dtsi file,
> same as any other peripheral. The board .dts file can then enable it.
> 

Does this mean only boards using external phy need to override the
"phy-handle" and "phy-mode"?

Regards,
Inochi

