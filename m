Return-Path: <netdev+bounces-131804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C80D98F9CE
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 00:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9F91C21F12
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 22:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762211CC143;
	Thu,  3 Oct 2024 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKPVVsha"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8C4824BD;
	Thu,  3 Oct 2024 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727994247; cv=none; b=g/pyMbNoLA7K7A+fdHHsC1oIBAtBYE9a6Jqu0uZhB8aKe8arVouCazfVmGNqAHfJ/EZQwAq7wL9aAQC6y0EEVPbAeZsW9obakHy57G7rV6AbiPgAVw3d/E2beeBKYK4rbJNYSOBy6KT29Fnh8tYYvUoZ/k1Gr0WGNvVrxh/x6Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727994247; c=relaxed/simple;
	bh=vSMA1YV67XcnFvZmzlndB3wEKDANGVm35x9HoTaoamM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRdIRqImqfyZN8YrbIq2MPwJVNqQ06Nc05gRJiNrROb7+MA+2jL1b2R1wmbT0NnV7KGHVsCpAUiFe8QRE7lnOCoZXXE1HVQagVG94Wsb/or3GrgPlO4GmIu0anJSwS5w8nnD6/2s5XfDMc/ZhiOMThfNi9if4ZHj5GDTwCUjs0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKPVVsha; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42ca4e0014dso2085095e9.2;
        Thu, 03 Oct 2024 15:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727994244; x=1728599044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vSMA1YV67XcnFvZmzlndB3wEKDANGVm35x9HoTaoamM=;
        b=mKPVVshaG2/Uk2mweZUNcWEuGY397KYGbYC/o1FrTlcF5t2EDjn6YMkso8874NWM13
         Xsr0aasBQXEn++GoqJR7L8MlUcSWKAV4cePv17ncNdeDGcdQBpK3zl9weVArdfkg9FED
         NKFRbLFgoCTw+gtvh6zNruipamjp1nmPaThfrKMU0oBHr5XVoaonyiGZkvZVbudFQr1V
         gnh9RvvSEdxhdJaxMu92T3po51CQRI+iw7iwhn0snVAxrDRBIinzDLLr1qen/s/Kqgrt
         jRC4G1LtfO8rKitKr11LVNV8bACtF7V96lKYcW+1FzIhFq1s8ygE9wOPZp5Hl1kwmDl7
         J3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727994244; x=1728599044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSMA1YV67XcnFvZmzlndB3wEKDANGVm35x9HoTaoamM=;
        b=MWe+suz+HE3hREBVPPTXpjJ3GILSYjgm77FtWOo9AK6U497bSAXz5bHal6OGkJMrBk
         z4LfQyrJy7Q/pkawzm6n5Pa8CpDB0O4rLJLU/9ktUfFehIjjaqIcVQmxG9l9YnAaKACX
         haF8l41m0wBw8N5gZSGvgXzTwipiOuEokDHYoMtPcKN/1whOo5Mk4gXXiU/fb5IWipQH
         KEgyPAu9+uKaL/QqXe8Ue6zTwGfTqy1Gi2lSf2tQt8Mj4z99LhBYiNf0S+jugWMhxOdX
         Lrq7RHTxfIhtIkSXCoFOcjXaMip2ONsze18aR15riH7/Qmfk/En0vQ3H5veqskVZW4rr
         xO7A==
X-Forwarded-Encrypted: i=1; AJvYcCU/eLiDcOH4ZxfwXltsQsL6uo6bj1+9XcU/hbAGaHcqZ6py4DwOeGoWcAZCQmY7eP6FzuhdvwnS@vger.kernel.org, AJvYcCWeN+ERtrWv3SnEBUukpJp7AMRxZJeeXuE3IOUu+w3lTtVnHNIZIiityMxXOKevEjVDoIgm4TgKTrTnqJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1IiEmcgAUovsMqkZXHtaLOofBqhQDyJ+zT9M40HPiyekZCW+N
	sdCySTTeqC3D2dGakujb8QCXZVnL/Z9XFstJmKq8vK7C8oAs7F3s
X-Google-Smtp-Source: AGHT+IHiKv93Km2hHj/dG2voSYUFuTsznaF+QIWQisJtg//fc4AZ0IlUoBOlUTGdnpjG0JRHY0F7gg==
X-Received: by 2002:a05:600c:1390:b0:42c:aeee:d8ef with SMTP id 5b1f17b1804b1-42f85af6f4emr1474715e9.9.1727994243866;
        Thu, 03 Oct 2024 15:24:03 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d223asm2069632f8f.104.2024.10.03.15.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 15:24:03 -0700 (PDT)
Date: Fri, 4 Oct 2024 01:24:00 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: phy: Validate PHY LED OPs presence before
 registering
Message-ID: <20241003222400.q46szutlnxivzrup@skbuf>
References: <20241003221250.5502-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003221250.5502-1-ansuelsmth@gmail.com>

On Fri, Oct 04, 2024 at 12:12:48AM +0200, Christian Marangi wrote:
> Validate PHY LED OPs presence before registering and parsing them.
> Defining LED nodes for a PHY driver that actually doesn't supports them
> is wrong and should be reported.

What about the case where a PHY driver gets LED support in the future?
Shouldn't the current kernel driver work with future device trees which
define LEDs, and just ignore that node, rather than fail to probe?

