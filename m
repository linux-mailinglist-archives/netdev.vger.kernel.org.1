Return-Path: <netdev+bounces-129789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA239860F7
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 16:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02341C20D5B
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A916818D65C;
	Wed, 25 Sep 2024 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX4SL2P9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88A518DF61
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727271824; cv=none; b=n9WtACasNkths35kY5zTtjufsGLkV8sLclB/yXqYXl9UkzAEQdW0bcIhJLytevty8CXXTqE3OIeB6M9yWM0+pGvFOc7CZLSGujJ1G+qAQoHEF0O7NAGFwBqIIhiO0aOtzMPczNNouvZxuQZPjpwvXDqT7fIuGjxDw8259SVy3js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727271824; c=relaxed/simple;
	bh=n8S2ShJWhNyzbrArMxcsS1/NutiYNHtvyd5VAm9gxr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXDuMXRtOos6qVfC4D+k6Ab+lEdSOUMVtGvd8C12SuBrIO1IFsen9fAqaSPIBmWDzE7GTenuxjfYcaEZBF8xLLX4T6mZ0xI22rYKia1DIMYo4Iyqkl7F5XniI86cHa97wIPHGxxzdy/4fRjCsg0Grv10AvleYXsquSEzmTX2/1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kX4SL2P9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42ee66c2c49so865725e9.0
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 06:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727271821; x=1727876621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uHvDwBZzI4wRaMBB4iym1ztBubtpy+b9V7vHZYPrE5I=;
        b=kX4SL2P9uuSHmW1ecpZ+H5jCcCdQE7cM623LDZsCrHiGacTB2ub1q6JkAe4TXAIrm1
         nMT5K4rPQofr6G/hNUit8jIZZoAGc7x90av+9HtdSgBN2/zA5NbS6A0vdIPYDrR3xwX/
         f9Dd44xA18Bkxore4k1JTJ8JrGGqY2F/CPK7dnxLPWvzmkuSYzfoNKEj6UK18mabQ9ka
         +ax2vafPx1r6k0HTpBiOadwlVUmDelDJejCIuU9fnHw4+xoD6J9aJ/YO6ApeV3i9j9IV
         g9o18ib9uBm+6CtK+O2TGHwgSinxlpXe3cvbiM7YDCPqvvHvOJWLd8c3/0aI7tmxLyv8
         91kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727271821; x=1727876621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHvDwBZzI4wRaMBB4iym1ztBubtpy+b9V7vHZYPrE5I=;
        b=rjbyLa4rJwkdbCfeDB7Nr5/wevP9Eo6ghwIjQgmsIaXfiBDyttyqVaRALjf6l3hypW
         +e3HHXF5P+XuJPivwDTpplWWauH0fVDIlkbeFourTGGN4XcmjikEP0RmxbjOx42IJVaO
         7/de5WyLa4KfL/jitMoxgnHM9B8zb3BAvBCbTRmF8UVmHDC6FHL6D3a9HfSerUgB0YGH
         huO3bpmpHiKruOOxwwzD4zPbnMJYMd4nX6MqOPnRXLU/5ogcAhFgpDtfHojPhxFJN1v9
         q9iPaN9eTq21PQjvwCo8n/51BgsiGVMn2UDVi1vZy3d2rxrn0DijthpXK+kf8j6E9wLk
         oj2w==
X-Forwarded-Encrypted: i=1; AJvYcCV8YuOeidvz7wzqX+MXsO+UrzRQcjOOeXbPIZD3uY+PFvCUrys/hBpOfNjf0kaGttOHcJdP6kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpUGAqtG+b/hCjP6eBkGI0BIBsjNSLswkeCL5LtICVtTdYy9Eb
	Pvg6bVmTvCKSwSabydmVVBV7oG/wuYbv0f11lBFDBI2DxK+Ee5hs
X-Google-Smtp-Source: AGHT+IHmnVWjsS8xkdZZ7T2bxRduY3ggznHkuYE5rMeBgUZ+UEHsPUYheF24v3Oz1tufHagTFvs72g==
X-Received: by 2002:a05:600c:3c9e:b0:42c:b8da:c79b with SMTP id 5b1f17b1804b1-42e96144caamr9214525e9.5.1727271820933;
        Wed, 25 Sep 2024 06:43:40 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969a48fasm19531535e9.0.2024.09.25.06.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 06:43:40 -0700 (PDT)
Date: Wed, 25 Sep 2024 16:43:37 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC 00/10] net: pcs: xpcs: cleanups batch 1
Message-ID: <20240925134337.y7s72tdomvpcehsu@skbuf>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>

Hi Russell,

On Mon, Sep 23, 2024 at 03:00:26PM +0100, Russell King (Oracle) wrote:
> First, sorry for the bland series subject - this is the first in a
> number of cleanup series to the XPCS driver.

I presume you intend to remove the rest of the exported xpcs functions
as well, in further "batches". Could you share in advance some details
about what you plan to do with xpcs_get_an_mode() as used in stmmac?

	if (xpcs_get_an_mode(priv->hw->xpcs, mode) != DW_AN_C73))

I'm interested because I actually have some downstream NXP patches which
introduce an entirely new MLO_AN_C73 negotiating mode in phylink (though
they don't convert XPCS to it, sadly). Just wondering where this is going
in your view.

