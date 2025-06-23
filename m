Return-Path: <netdev+bounces-200147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5E5AE3632
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 08:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CADB11892437
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 06:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DFA1E8324;
	Mon, 23 Jun 2025 06:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlK8D3GF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C91545948;
	Mon, 23 Jun 2025 06:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750661419; cv=none; b=QAxg/kzs2mZidgMGsPADpOhGn38kVmxpdpqFGS/feEeq8+7Ic+XF/cBXqEX6PzfTrukEdyZFrP7gInF61177Emu40C+S7P1b7FZ/gzCy0m1lBZB1hRb1oUuw3m/R2cEKpYvViSLN6GP4bwGwQ9+iLmjDBB+75SrU1uQirpcsxAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750661419; c=relaxed/simple;
	bh=gUcXvmQE/4OGkPu+1pWmspRNi25l7Kd4ITJO6J0F8GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2DIq7u59DG/rwfvTVqwU2Uq6gh7bFqEuKT27QkeR6bMw7RhaylvEMvMuqv+sG+cOd3n0w7nQYrLMyRZ20tbPBp2nyU1vL8NoFptR14fpEk1QyMPrpRNRwXNJOM9yk393ljyhsi2Zv165AZeKvc0Kkre+rtgtFjV+vAKr/MlHyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlK8D3GF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23649faf69fso37294875ad.0;
        Sun, 22 Jun 2025 23:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750661417; x=1751266217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6pa7zdu2J08RltO7Fc5iu0znoovQ/LLzNNFFw4lTRcE=;
        b=GlK8D3GFcNXZDm9E3k4FYOSrVnN5AodXcozFb20PrZ7nfTMFRoVgkoD0pkWZKa/IzW
         hig7tpryYAmj3dmPJj/Xq6UEYpD8qsFeCBot+a1BpvtYlQ5nyYQ2O0aPszQwFBK0JZaY
         Czju5YNxN63Eac/lzwJB5CXe9NJvrwfGfWQ5ibhM9Zag30GjdGrqfqZD5FLLPZidLT12
         hSi4hhkpqFm/sCpcoKlyOE6NiYzPBP+lH1Yakhx3KQInj2S2mGneWbGaIBoDewEMJW6g
         crH0H09CNeyQyoH2tZ9Tv4MhWBbPZOE3CgZPQwMim+t/a9gehmAcJahsgZA7tRTuaB/1
         uvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750661417; x=1751266217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pa7zdu2J08RltO7Fc5iu0znoovQ/LLzNNFFw4lTRcE=;
        b=n1otBr/lKcgM6jlQCN94mx265+Q3/zgGG6uRIfMVNvSsK1b/CcJsbPmSg3ggKPN6Xr
         rjK6KO+7yxL7DzfJk+Edby0gE/BnqqGmNWbyxdvFIMz4rCEJmrW3dLA8ZMmjVDeEUZyO
         zO2/ZGPWWn1GYtOlWbiQh+oOxosq4VKxucHOWcuDhgm9vfmQWkdChmMhBxpJ4H3FzP08
         vmEuTWbGIYUuIAAkk6KdwLYGO61xu677wiC0gQkeroXULs+L61d/6uisYyidsrhfBOVE
         mK3VDN3W18mhQUGpqjR67+zP8F60kbdb2X243mpxvzEUAnJxqA70xrRnUTv/snaZnKeO
         hxFg==
X-Forwarded-Encrypted: i=1; AJvYcCVzT0EICf6d1r6hzt3vDyCcTOyyPDEjNhR6A5WHOJ3zabpELdRPDKjDNzPMjKBQeaCqRUqcRXlOgaat@vger.kernel.org, AJvYcCWaNf9NBKDZVBEHlX/vG6NGf6EwOitpzQhe0eEjSWzOrU0Yl8md8STxbS8/hQASZyLJvEc/8oHH@vger.kernel.org, AJvYcCXo/b0FKcTBjK04A8CZxJd8YesM8c/okEU5Fud6xLy50pWY4hRSarmUJJf9ugGAqeUnSdJM6qMN+njbLV7P@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0pcj76bZ8nrNJPwvQtA2bExfWubf112ZTLenCiGnQCnQaKLoj
	pJxbVfrC9yTj8cKOVYg183dZtDdZVVwL2oK1yjgYTqdstJ5+a1zwifo9
X-Gm-Gg: ASbGncuzEruJsS82cxSd5+DXltY2ff+vW6DH4q0DSDTdA/h4dvwEghxuWVjbC9hDYKf
	lVSs4fAZn3oU8O7Nj6W0EwudNjayXYTHz8vVlt7NCk/CRT2wCYmE+iskmyK2iHnnujuhKsDWUHo
	49lcZCP+d+ghsuumFJLbGEelvtRxShk/x/wDjPZXtqlJVe4ceghzV5D35kvyNwsi2PIK8hFeCjM
	ix2jeIRgEOCNOB9MSuWJEUoA5+CtCYmTjLTrOe5OgnuySDxWbO1jS4Apf12SXshWsxuFt9k9vK4
	KS+L9IB39CwDeE9p+nxF8AdjeJzUblBd7eJEhV5zo1MWe9/+6Tu6kwAlHUxhgg==
X-Google-Smtp-Source: AGHT+IHpm5rL2B+2lf3y7D/IeDkqmgR4hxP+AbO8ivmJka/IKdtwO1eRP/D1h74sTcLcDtCuBLdozA==
X-Received: by 2002:a17:902:ce85:b0:234:aa98:7d41 with SMTP id d9443c01a7336-237d9ab0977mr168116245ad.42.1750661417171;
        Sun, 22 Jun 2025 23:50:17 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-237f7f87676sm17710635ad.122.2025.06.22.23.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 23:50:16 -0700 (PDT)
Date: Mon, 23 Jun 2025 14:50:08 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Maud Spierings <maud_spierings@murena.io>, inochiama@gmail.com
Cc: alex@ghiti.fr, alexander.sverdlin@gmail.com, andrew+netdev@lunn.ch, 
	aou@eecs.berkeley.edu, conor+dt@kernel.org, conor.dooley@microchip.com, 
	davem@davemloft.net, devicetree@vger.kernel.org, dlan@gentoo.org, edumazet@google.com, 
	huangze@whut.edu.cn, krzk+dt@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, looong.bin@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	richardcochran@gmail.com, robh@kernel.org, sophgo@lists.linux.dev, 
	thomas.bonnefille@bootlin.com, unicorn_wang@outlook.com, yu.yuan@sjtu.edu.cn
Subject: Re: [PATCH net-next RFC v2 1/4] dt-bindings: net: Add support for
 Sophgo CV1800 dwmac
Message-ID: <2rqpe3f54peuuslzu2mtbqt2ee7atoa6j6xiudxrway32vzmui@2apefxcrdhpi>
References: <20250623003049.574821-2-inochiama@gmail.com>
 <4cb09d05-d1f2-4d34-b3f7-be523b900a9e@murena.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cb09d05-d1f2-4d34-b3f7-be523b900a9e@murena.io>

On Mon, Jun 23, 2025 at 08:40:35AM +0200, Maud Spierings wrote:
> Inochi sent:> The GMAC IP on CV1800 series SoC is a standard Synopsys
> > DesignWare MAC (version 3.70a).
> > 
> > Add necessary compatible string for this device.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  .../bindings/net/sophgo,cv1800b-dwmac.yaml    | 113 ++++++++++++++++++
> >  1 file changed, 113 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml
> > new file mode 100644
> > index 000000000000..2821cca26487
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml
> > @@ -0,0 +1,113 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/sophgo,cv1800b-dwmac.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo SG2044 DWMAC glue layer
> 
> This looks like a copy paste error
> 
> kind regards,
> Maud
> 

Yeah, I will fix this in the next version.

Regards,
Inochi

