Return-Path: <netdev+bounces-141038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D52E9B932B
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 15:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1492B1F22CB1
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 14:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108381A264A;
	Fri,  1 Nov 2024 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QR9DiodU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059C01A2C06;
	Fri,  1 Nov 2024 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471357; cv=none; b=eKSF1gy4oNi/u4AmgUYQcR5ariF5+eW3nSVtHYO/6INXjwnSMDh3S5olZa7yCBhssVrYL5DTBj4AJs3bgneJpxQn0GkJaDci8yBTUyyj0Qe7C1kOKmEl9U6/+55ACjeQzYFnEiU9FToeap1WzAxXxxbiYmqEiD4dv69uPA2S2Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471357; c=relaxed/simple;
	bh=sGQPau7KCDdF/Ae95DXOCmqJ7A87TuwQ1h0aYFgMeA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNqU7gLrPStRZU2hNss9kCss0EamALeVYYUj+lzThlB7HSwIEJ+TdoiabPB8JoA3wiWfeWKR96dm1BNhDYJbAmd3PxjZy5wV+UDbDy1mx7YWQ2rg/+rcda3TnIzw4YhJMgCR2VIoyTbWOPds+1Mt3LP3b48/rjsKBhOjzcm4CZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QR9DiodU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315ce4d250so2060305e9.2;
        Fri, 01 Nov 2024 07:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730471353; x=1731076153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=odFhpibLPvwuhQLLhb1fVT+w+/dlMBz12uJSK00SoM4=;
        b=QR9DiodUQKPKjG9c0emqMv0coSWHJfEMiCTN2Gj0TXyrtteti3Ezb8aAKp5AyII96z
         MoX+xi4J7jP3cwZRIde67cpbNgE3K2HiMDWq2ItSPxSXWSFq/sqWKhffBPa4GxBBYQXz
         P2/LbaPFT/x4KbvBYkAJP6RhnTz6MMoLPR0PWa01k1MqV+iLU1MHZYNslxhG6oJqL6Is
         kyBiLuBDCIL/ftRR3aFYjZV4FfH+uM8ytVJUCMYFB2HUqQOygRXaJsG3/J6SL48hv4ef
         6BXtCdfjMmm2jEhPSXUsC4Dvo1TidsBKZqzceY+xnnxWfYz4fnhAdb9DSBFxKtVE8sta
         elGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730471353; x=1731076153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odFhpibLPvwuhQLLhb1fVT+w+/dlMBz12uJSK00SoM4=;
        b=qr1+m601h9RvRAkrqtmwfZe7KKQU7CsZk6TmMtUUEzHaPOkLOgUzw9OBZ/e+kzM7iV
         kJjRrcSl3zs1SnLb4RLky+E2nCkDUpZYZPtcciaOmm3iga+HgSPQnm7bNDO8yLUDNOEb
         ZPy0qpzV60PmsICg1YQmmS0RMAcwZohi7fQOfPhbJngOj8zeKJFyIT+OOYaMkYm8gwXw
         danHS2B2I11Fpr60IWhyZtQ/P5UWmkElcJ6tfS5gziIkUs7h1xaTDotRwceIEKdEzuAE
         ECbJOrJNo+QYqrXxnhIKL1v8An76jEvR/TOeDU2M27gQR42lZpiLrPlgcQpmkNl/o8vl
         zHfg==
X-Forwarded-Encrypted: i=1; AJvYcCXR5I8DGqXdTNYvrERaYE53rKJiiRtHtW4mJHDCvEOTre7EM/cVcp9EXCQ3pC0PRRrlqtQOdJSMMaS2P+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbMmhwBd12bJF6CvVtsPayYf5gcyGRMK/6vjKXinrQvzHDi+55
	9Wa3kDX1jFHqPUbOaLtOBqpGWLaXvlJVrtaZkdDqiZbvNSzBU90q
X-Google-Smtp-Source: AGHT+IEEMVRXqLdwmJV7pRqfFpEUN3/kmvstqI5JyyZgowwwoXMF0vgEs0QQNJ4tL3FcNqLPsYwFmA==
X-Received: by 2002:a05:600c:3542:b0:42c:ba6c:d9a7 with SMTP id 5b1f17b1804b1-4319ad08603mr88397485e9.4.1730471352892;
        Fri, 01 Nov 2024 07:29:12 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d685287sm66007415e9.35.2024.11.01.07.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 07:29:11 -0700 (PDT)
Date: Fri, 1 Nov 2024 16:29:08 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v8 0/8] net: stmmac: Refactor FPE as a separate
 module
Message-ID: <20241101142908.ohdxsokygout5mfs@skbuf>
References: <cover.1730449003.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730449003.git.0x1207@gmail.com>

On Fri, Nov 01, 2024 at 09:31:27PM +0800, Furong Xu wrote:
> Refactor FPE implementation by moving common code for DWMAC4 and
> DWXGMAC into a separate FPE module.
> 
> FPE implementation for DWMAC4 and DWXGMAC differs only for:
> 1) Offset address of MAC_FPE_CTRL_STS and MTL_FPE_CTRL_STS
> 2) FPRQ(Frame Preemption Residue Queue) field in MAC_RxQ_Ctrl1
> 3) Bit offset of Frame Preemption Interrupt Enable
> 
> Tested on DWMAC CORE 5.20a and DWXGMAC CORE 3.20a
> 
> Changes in v8:
>   1. Reorder functions in their natural calling order
>   2. Unexport stmmac_fpe_configure() and make it static
>   3. Swap 3rd patch and 4th patch in V7

For the series:

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

