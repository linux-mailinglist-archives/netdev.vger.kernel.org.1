Return-Path: <netdev+bounces-138464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30C79ADB39
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 07:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C1DBB22242
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 05:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BAB170828;
	Thu, 24 Oct 2024 05:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoQqr0E0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F551C01;
	Thu, 24 Oct 2024 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729746528; cv=none; b=qA0WzIH8YpLSkJHFjYu02sAxThKLUKDpg4puad+b6vCCYybld1VAsILt18ctWMaoW7cpvDUCrzBsKMnCEHhra4nPrAHaxeaLzEFmxWOPn32grkTDmA/+VqEwUm39XA6tLr2epVyWP+MmYF8ntVDJWWD6U6nnCJ+SdAmF9HfDhxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729746528; c=relaxed/simple;
	bh=dlzcr23m4Ud20cAHk1CWN5ik4PcIgtl9XwAB94eo7KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYtpvI1wGlupdeE1ZDjmDz4JH7kiRO1JGJHLgfk5YRF9vEoiICm+QxJlAblFQNU5/LViefpqObFmmDDNCGVPL7OJkrK8Ovm/iDg7ckOwQfi0gmXRQeINTBL6kZwIPukyhSpvvdvvkiQugkGBNJNy+oI13L4mdBj97HconJdZygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoQqr0E0; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-83aae6aba1aso20364739f.2;
        Wed, 23 Oct 2024 22:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729746526; x=1730351326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h+fsHdO3eEGRLBsyxvQ4eLN0TAO1AeUct9QR19BrA5o=;
        b=JoQqr0E0fZOJiohBystn46GdJmXOixWuEqNyS72tI2VGPXwuTQtrui44yQrlVXTsQ/
         rJOBPNuqdQWHK57kjQJZdnBL26eROBccgw1WQolFl098Djqr4VWe/l7IxxMoiR4StaCJ
         ZGMbn3vkcRS48vYdG+AAJ6pod+KzW6TcWeNfhGV/7nf1rLuDyJHZgkJ/+MbV0O6hQQFz
         eRAwr2ySGjq3aDokbx1XOBeWPuOapDjGkaG8irBDl4oFiuNoL4SRVTr5gGz+gNUr0+AV
         kYCxpcPigxc5CTKNEhYi3xutAKd9p1xdSbIJENPx5YwajWD4ltzJussq7ofYOZPzjXJO
         va0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729746526; x=1730351326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+fsHdO3eEGRLBsyxvQ4eLN0TAO1AeUct9QR19BrA5o=;
        b=MLzFVcDBgle9u3p/rPonx1pOx6R6RjROsi7iG+TZSc6MDU6GEWARYr7Xe+pmzfDKXJ
         srUq6rBRN3CKU1bXFJOXblTv8KLzsmFu/8xUxMi2z5kRIudXE6To0jvRWS3pN97RPNfC
         aX7JD6ZUJ0PoHPZK2BUZzaiBQ7PINCcuXzJdAAT7JRaIr7qKAaDg+Xx0WYmlcxS2eO5o
         qbj7oKYCbmKSVvMXKYqMPc0V1wrzdqJC1iae/nARc7kxZWkX26EevDNrsm0mdu+AwKoC
         SNTUfMG+vui/2wgcQl2zKCL715icmOYE9k6l5yhzAh/N3P/9/pemBsbP0SauTcbX3B4c
         UJ+A==
X-Forwarded-Encrypted: i=1; AJvYcCUl5wqhA7o7TX+fXOhswEkToschXmtypESIxidh83RjEOyPgAZxZE/rxIgk9deRi7aHUSIfMrTv@vger.kernel.org, AJvYcCVKVHasHTRKWgIk7fkep0aN2G9k8LYBPK+vujYQq+iCE42ZHGubuBQtNs4dkedS1QZ6smtxf9bIo3bRlLJi@vger.kernel.org, AJvYcCWiXSaWBH4ShD8hMcDiaGWzbTDe+XtuFJJCMpR4di9cjmMnVHjHydAOVW2/4BJi20WkjAMxtCVqKcA8@vger.kernel.org
X-Gm-Message-State: AOJu0YwdukOX+TKaLt3DeilBMt0ntODq4ZIlaPnYcwr67kAj/ySrIhy9
	7HBk4cL9W7NyfKMFAfEEn2cAkcGHNkjplO8jfUkQUOMbU1eDzyLq
X-Google-Smtp-Source: AGHT+IG5X1vksF/tv0wq/h048to95RzgD7AYZAZKnCMoZdlNaKEv7NrmBxQKxyy/6w+cY2qtmyTkfA==
X-Received: by 2002:a05:6602:15c6:b0:83a:a305:d9f3 with SMTP id ca18e2360f4ac-83af61f1857mr646877539f.12.1729746526016;
        Wed, 23 Oct 2024 22:08:46 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabc118fsm7788874a12.70.2024.10.23.22.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 22:08:45 -0700 (PDT)
Date: Thu, 24 Oct 2024 13:08:24 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Chen Wang <unicorn_wang@outlook.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Yixun Lan <dlan@gentoo.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: net: Add support for Sophgo SG2044 dwmac
Message-ID: <o46c732wznqvz2p4gkqtjjratxwrgntw4mqballph7fjitvmhw@lylkpsqdp2ar>
References: <20241021103617.653386-1-inochiama@gmail.com>
 <20241021103617.653386-3-inochiama@gmail.com>
 <CAJM55Z8SnjQFui0J2hOD34HmBsGqZfxn8e_KAWhXxiqswqv6Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJM55Z8SnjQFui0J2hOD34HmBsGqZfxn8e_KAWhXxiqswqv6Ww@mail.gmail.com>

On Wed, Oct 23, 2024 at 07:41:28PM -0400, Emil Renner Berthing wrote:
> Inochi Amaoto wrote:
> > The GMAC IP on SG2044 is almost a standard Synopsys DesignWare MAC
> > with some extra clock.
> >
> > Add necessary compatible string for this device.
> >
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
> >  .../bindings/net/sophgo,sg2044-dwmac.yaml     | 145 ++++++++++++++++++
> >  2 files changed, 146 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > index 3c4007cb65f8..69f6bb36970b 100644
> > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > @@ -99,6 +99,7 @@ properties:
> >          - snps,dwmac-5.30a
> >          - snps,dwxgmac
> >          - snps,dwxgmac-2.10
> > +        - sophgo,sg2044-dwmac
> >          - starfive,jh7100-dwmac
> >          - starfive,jh7110-dwmac
> >
> > diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > new file mode 100644
> > index 000000000000..93c41550b0b6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > @@ -0,0 +1,145 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/sophgo,sg2044-dwmac.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: StarFive JH7110 DWMAC glue layer
> 
> I think you forgot to change this when you copied the binding.
> 
> /Emil
> 

Thanks, I will fix it.

Regards,
Inochi

