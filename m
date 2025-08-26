Return-Path: <netdev+bounces-217049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A50AB372D8
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 21:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C6B1BA3CFF
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 19:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA46E3680AA;
	Tue, 26 Aug 2025 19:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bH6gl+pR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CFD1F2380;
	Tue, 26 Aug 2025 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756235244; cv=none; b=dX8WlMHMJlzdHPoRdS905D1R9fiQ7rN2+VDkn+AaoM5TuGN/DaccjCGEyn5XxsFKR6e/klGzJ9HZ67qq5tP8qoH8vPejP6xmvojcj0IFi9vGU2xR3Vb6QxTtgzLzeH9dCsL2zx1uVzGp6cFJPKoBXzMaJ95R6m27QA3EUl0ncuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756235244; c=relaxed/simple;
	bh=dzXDeml6LhaeVEW/Cm7+AKped8Y7Fz4TmxTIOd9241g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQpebswYMhe/DcYBzUM6jBoFZuMWeFtAbILWxnHix8naBR7JrnyYFTvHO/o+55NvxASw/vWb9akgH/Bd0sdnsa3e2TFqnHPcvSg6UsitoNPANyDbulXby+1Maa9dZmk6ANRWUE3+qNMjknY0hYO4vjf5o0Lu4lpzGVx+m09ikAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bH6gl+pR; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afe7f50b605so41069466b.0;
        Tue, 26 Aug 2025 12:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756235241; x=1756840041; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gzIB/UF+2pna+ufI5/Fze+18H1TaH1WQC6eyvlwlp4o=;
        b=bH6gl+pRr82O17aee7KH2ype2qn3wWLP8S+Uk2yh9fdTThGEaAs+zj3TtGsbA+OxNd
         vNSsV+KrxOVLeC2wwjdS94GbaIZ9UkZPtUHKKgJkF5uJd8QK4J0H03LPWd2VnX/FNtwk
         jfaSouUqlypcxh4Jhr6QwFCW5w7tHf3dB+gSBDibxgrOq1snQ910ywu9tPSeL/VTO2D3
         CeziIjX/cFjmjmSeykgrpbzj5g0+HtLw4DhO7HJ2Ih9bzJjLG0ia+BK9zc+vsv0hptdv
         IE7J/DKGUd48JQrZv2RdLYUXXzDrRmKO0CtvXsz3cLhultyxkhdh41ZpcbT9DnFWJLF5
         IjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756235241; x=1756840041;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzIB/UF+2pna+ufI5/Fze+18H1TaH1WQC6eyvlwlp4o=;
        b=E8u6ahXpO5D9d3YNd472OtGS8RnsKHjx/F8EKTD/R52FvkwzqM0Wyd4w9tJ7Sf6w54
         HChvWBhIrKEeKFqw3p75TzQmDL32vnIRK5imxW5ttrrMEIgJ2i0ETlSIfX4VHfOlBPZs
         PYZD6LNNbeve+8dVnaUfBWohOSPNpcfpPLCTSPBwYDrpc0sUMbp8s25xAx2bYPd6iFhI
         jjBD6oEOQBoeE+mHgihy0sbIobRkgEJR3BvWkT0Ufu9uEYHwK4amsJ9PzOPiBbaBBapL
         os4qx01H0Y7InnAKMRmCO3Ww06fgAArVIwB5JnQAMZx6dlCtmES1M1a3YtzzUX8dyNTY
         uuWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ9dnkMK3jiw46FXX8cukwWYl5nH1BaVnOJT4FMe1mY09LM7ZmfgxPSB1CE1uW6Xw248fwTBmQ@vger.kernel.org, AJvYcCUYmRkQITgtAoXhO+wVWaz1PCBQ68Ke94fApSMxgLtpIVQMzzrMrrSCvyO1uZpkrRu+XIyJ/Jnq9Trn@vger.kernel.org, AJvYcCXvAE5wBNp1thIXkCPsbm0LY7ygHwYRJ8emXgdna7KYaeHwNjHC9hRzjki0Bh4JaGLcr2EhTNc59P8II5b8@vger.kernel.org
X-Gm-Message-State: AOJu0YxZUnXNi4JUPF4REi4FT8iLjsWBlSujtKENwP+t5uY9kjiAc3gH
	Tj6LogCwFjSL4UhAk76GowxR0UrjZg8gDdf7aAaicmC6P+PyrtipXIvQ
X-Gm-Gg: ASbGncscaiwShyAA8rpynRZvClFG9Yt/P/TdyLEvZh4PH0bYAUXNTqsN4Hvd2nnrcpM
	yRjl7GLlD9T8DcKpsD4JK/SleG6akKrGicHCHzZ7lnio6I3ZusgSlcrh+AJiSN7bCu/0p2Zp7pP
	KxICBadqTZw3tRtwRvLocowFlGSVCtfXfZXNG+LYyMBrTpc3Opk5o9UUGuuhN/BHfQqJiBUcKWv
	JejC2jojVveASo8rwr9Q50aepdWdCyGht5LWzhT6wHkLPqtE+uEgXVgy+9MOxopfdL3qRMXhBx1
	EGsyNb+IiYxon4lcG8JqG2S/DiCumoXZmTuNYgmwVNGFn4DQrMWJlZGjggfwtK+ILPhrUUqtKzL
	wi2x0DCEWv+Ym2Ys4gSvJPHw1xw==
X-Google-Smtp-Source: AGHT+IHAtJyoC6LCpsX+9ixvxn5yPrzcVcxGfg2wMfyxcBXmm1gz09+B0+1LESU0l7oQqz0ECcArmw==
X-Received: by 2002:a17:907:6d16:b0:af9:3d0a:f379 with SMTP id a640c23a62f3a-afe2875d2f7mr889917866b.0.1756235241024;
        Tue, 26 Aug 2025 12:07:21 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:a59a:f42b:5034:e072])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe89bd7acesm417348066b.73.2025.08.26.12.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 12:07:20 -0700 (PDT)
Date: Tue, 26 Aug 2025 22:07:17 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Yangfl <mmyangfl@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <20250826190717.fkhj3qowvljsuvj6@skbuf>
References: <20250824005116.2434998-1-mmyangfl@gmail.com>
 <20250824005116.2434998-4-mmyangfl@gmail.com>
 <ad61c240-eee3-4db4-b03e-de07f3efba12@lunn.ch>
 <CAAXyoMP-Z8aYTSZwqJpDYRVcYQ9fzEgmDuAbQd=UEGp+o5Fdjg@mail.gmail.com>
 <aKtWej0nymW-baTC@shell.armlinux.org.uk>
 <CAAXyoMNot+aZ35Xtx=YiTEmGk_c8XT7VGiQ-DUn8T1vPUnO-9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMNot+aZ35Xtx=YiTEmGk_c8XT7VGiQ-DUn8T1vPUnO-9Q@mail.gmail.com>

On Mon, Aug 25, 2025 at 10:14:58PM +0800, Yangfl wrote:
> On Mon, Aug 25, 2025 at 2:14 AM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Mon, Aug 25, 2025 at 12:38:20AM +0800, Yangfl wrote:
> > > They are used in phylink_get_caps(), since I don't want to declare a
> > > port which we know it does not exist on some chips. But the info_* set
> > > might be inlined and removed since it is not used elsewhere.
> >
> > The problem is... if you have a port in 0..N that DSA thinks should be
> > used, but is neither internal or external, DSA's initialisation of it
> > will fail, because without any caps declared for it, phylink_create()
> > will return an error, causing dsa_port_phylink_create() to fail,
> > dsa_shared_port_phylink_register() or dsa_user_phy_setup(),
> > dsa_shared_port_link_register_of() or dsa_user_create()... etc. It
> > eventually gets propagated up causing the entire switch probe to fail.
> >
> > Again... read the code!
> 
> What would you expect when you specify Port 0 in DT when only Port 1,
> 3, 8 are available on the chip (YT9213NB)? Probe error.

It depends. Unless the driver has logic which behaves otherwise, the
setup of user ports can fail and DSA will just skip them and bring up
the rest. See commit 86f8b1c01a0a ("net: dsa: Do not make user port
errors fatal"). The shared ports are more important and their setup
failures do lead to a switch setup abort though.

