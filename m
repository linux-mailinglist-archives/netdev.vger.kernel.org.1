Return-Path: <netdev+bounces-140960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BCB9B8E17
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A62D4B2319C
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 09:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B62515A84E;
	Fri,  1 Nov 2024 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cn5gD4Dy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EF415886C;
	Fri,  1 Nov 2024 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730454300; cv=none; b=f/bznQhXnXfEuH8SeQ7a3jRX1M9zjRjw5s69h1yccFB+tOFm9/iT0S57UgE2xoKUhNToYI7q9o1Zih0ZnhglZnv/T0EaZHJidnlNEnggj3yTVPzf3SBGXAbvTd39vIz3d86Zgos0iiA5vnQCGlEXAzFL91mp+H+IR8+7WZ6dalo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730454300; c=relaxed/simple;
	bh=R7aD/M/dMWS4DrkbS2NnWoepD0SGOhjguKz+f6jBfIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEDB/WwaPcwmxdegmlZ+e7JHbm5//jqNR15c4TmjSaz3SB17ZK5lvWwii2/Tr19n+qwO6wjfQLwEgst3LcIGeqAwXR+zqqgfVI45vvLIfHOZ7v+siXARcrZqHnE7fZslUooA4KRKcaN5fahCK5uTMvAfkRSDzB0TCnLCwphVgmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cn5gD4Dy; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e983487a1so1454176b3a.2;
        Fri, 01 Nov 2024 02:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730454298; x=1731059098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5XPa1IlpixAalo9BA/o5sNKVNrHLCsckth76VFUIYgU=;
        b=Cn5gD4DyMMAnSApf4qc7Ot399dLYinpg12porOgEe93i8War+4WXqMtCDvBqIQB8A2
         VuBN2ZoD4qVFjQRHNLjoydy9nd9SbIkEHUFjx9dORA4obVPHQJg9N1unw8knaLKDetm4
         +G/6rGCjqTMD4egXGDl+0LpDjkGQlQxWPFCx+NHUctQSVitAbIZCs6OCAcVlsnu0fS49
         fe2LwP3spgGN96tsQKdrOF3C0ti8hILQGGQlZMuIKNCRR7BX6E2ipJ9rsZ/aHnaazF2I
         3H7E4+qSUdxwDCV6vgyesQ7f7q9MjYMgAVWF3ikrEHmCj6Kpt2zeJhOTz7ZR1cjq70Ke
         BXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730454298; x=1731059098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XPa1IlpixAalo9BA/o5sNKVNrHLCsckth76VFUIYgU=;
        b=AygVJ9DmcqByPwZxrYxddmnP6rxdX1JzFXM7dz5By90eWWxO7k4/xEK69M3i4MgIjP
         cNEetJGbJrHnAx/j098MKs3u6L6wmMaNOLAZzsKeGrWn5a3bj37jASFg0w1A7nHN5Lct
         eOLxNLAF+W/xqUmQc3Zn4tKe4OwwaWYDP9YthcV5OFHfsXgJiBpI9rZ6zSnvJVBBLPvK
         f9PpHpK8nGhSzpQh+q9V2R+Fb2JP06rRGaQstwPEZdOSCZV/kqYw+82og39iWG9w2zgW
         p2vHgDeKiWbfsL4QScOhQoTPUQtTm13WQ1BO6UWqEpwDWoHIyZxq2b2MHFtih00CqMjr
         5Cdg==
X-Forwarded-Encrypted: i=1; AJvYcCU+9qisGifBDdTlbvdRN0zLgU7H2jqEprCFZq3y9WqZHQia9A//Am64/cwInB2+Wv6kl/9BDJmY@vger.kernel.org, AJvYcCUEjMwjhNxVmR8iUKbUyOPykyk1Zl2u7Hy7ns+7IrkiYF9yvmezY0lt886KL5+SdlbG+5gHcB5MuDkE@vger.kernel.org, AJvYcCXYcnDrgNVaPM7I6fJr4Bf4YgDEDhUKrpIvwuFxzZjFTY/FWtxtIu5ZmkrOtVHH35+iUQspIb25zhop5/kD@vger.kernel.org
X-Gm-Message-State: AOJu0YzOICXAHAHiUtATnK/Il0W8IpektdV/EIAENdhnSfwmqhRjCNk8
	SQBM5eeJAL0Hrza92WoSEuxS61DDKTBamzzOHFw7zJKHnnwQNlIa
X-Google-Smtp-Source: AGHT+IGzz+VDzAUOmgRPvDn9gKwbiqOY+8Ufm53TjoKqgLSjfioPk2EG5eDX4bVncoKvbVOiHTGVQg==
X-Received: by 2002:a05:6a21:e8e:b0:1d9:2453:433e with SMTP id adf61e73a8af0-1db91d517c4mr6918796637.4.1730454297630;
        Fri, 01 Nov 2024 02:44:57 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92f90c6ddsm4712932a91.0.2024.11.01.02.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 02:44:57 -0700 (PDT)
Date: Fri, 1 Nov 2024 17:44:27 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC net-next 1/3] dt-bindings: net: Add support for
 Sophgo SG2044 dwmac
Message-ID: <hlnvrmxos77rw4fftwnyg6q2sfjgvx4vlzdvyuf7kwiuamcvpa@llfuqlijev6t>
References: <20241101014327.513732-1-inochiama@gmail.com>
 <20241101014327.513732-2-inochiama@gmail.com>
 <uzr6gpmyng3irrhuf3q3bvswlbzyxnr74jwccyosplr32ceczu@jjrva67iq4ce>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uzr6gpmyng3irrhuf3q3bvswlbzyxnr74jwccyosplr32ceczu@jjrva67iq4ce>

On Fri, Nov 01, 2024 at 08:51:11AM +0100, Krzysztof Kozlowski wrote:
> On Fri, Nov 01, 2024 at 09:43:25AM +0800, Inochi Amaoto wrote:
> > The GMAC IP on SG2044 is almost a standard Synopsys DesignWare
> > MAC (version 5.30a) with some extra clock.
> > 
> > Add necessary compatible string for this device.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  .../devicetree/bindings/net/snps,dwmac.yaml   |   4 +
> >  .../bindings/net/sophgo,sg2044-dwmac.yaml     | 124 ++++++++++++++++++
> >  2 files changed, 128 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> > 
> 
> I wish patches for review were not marked as RFC. I remember this
> patch, so I don't consider this as RFC... but that's rather exception.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

Sorry for the change to RFC. I was told to switch to RFC as it
has a unmerged dependency since v2. Thanks for your review tag
and apology for the confusion.

Regards,
Inochi

