Return-Path: <netdev+bounces-139407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D84769B2161
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 00:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDE71C20C21
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 23:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447A516F8F5;
	Sun, 27 Oct 2024 23:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CM4nVdNu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F0C43AAE;
	Sun, 27 Oct 2024 23:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730071976; cv=none; b=ahQm0NtrUtvP+cs6CGUE4/+Arh4MErcvcu0TOHrM6wYaYw+Vz5Sp6AKKbXxMxsu5zrvnY1FAFFhkxJ+vOa3W1JkpUGR87Nh0/u07lTJkgMENi30M2DIaOb2yUz3exjb1F3WWRELknNUH8UXHzO0HFfKqlXyC4IV3qJpGYe+azMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730071976; c=relaxed/simple;
	bh=rqz+Ilu/nIZLj6ETXEVsVJ0BJ0E/UCVOZ631ZweaVX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVVzK40lToVUq7QGHExc3zH0HAFUWB5W//c/Mg4eItpT5KBL6hcW85+37EW/mTxesdzc6JGKpXu5QNXWjld/5N1hFOFj29uvbbCCVfj1p5dwfOv28Y/SlbNGc3c1PMiKHhBLhu7glTz3mGXut1RxxNeRCbhd1/1ENgNWGAMF4EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CM4nVdNu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c803787abso28297545ad.0;
        Sun, 27 Oct 2024 16:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730071974; x=1730676774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=63amZP33iYpS8AXXhtgX4nWJKEpmd3UTb0cRGCmUwK0=;
        b=CM4nVdNuUuHQ7OIi3mOOTijfNKp9rtVg7wTniqTZQJKyHjrEYViAX0KHuo2aibxFVQ
         K43z/3k+67UO7n0E76EevNKYkZ/+dV393lnLVsltJDkj7Gp/8qOfqGVmyXmZTpl7cyO8
         GDkg2tz9ZzqmrzvkIOaC2sPR8I0yvCB3o2kSJDBO0gfMdhBUMTkj9xkzvdWjO1rXMU+2
         XdtgLs5Uu/jC35tf8C2L+VsKNnoXjFfck7MGRGDz9hwj5kW0yTTBTlw7YCYK8j0/ClRB
         LZ7dY307YZEkD/+b5kkepslaVxhnReT6Wb1ryyzKnQxRZCv+K7knNB5M7K1JhwYR+zNc
         sjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730071974; x=1730676774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63amZP33iYpS8AXXhtgX4nWJKEpmd3UTb0cRGCmUwK0=;
        b=hqNbl677dk998Lv1afK2ZedjQ1PdhiLvRrHTU0Fk7uQJMZDxMvMBsgokbYGn2kYCtw
         WDCImv+rJVEqi5RnwhBAAylH0eactB7YIa2B0pnJHmxzlf3SLyHHyfDlM9gd+eZQ90Q0
         y5UZHFup00XLBtCNOQFiMRZEjsaOPUCk2kfZSYGcQUrcVS7ew5tYV8+R5zl1BLeu0a0O
         gFnaZ9xESV4y6D5FSxLXCpWsA4OxyNU1+4bkBQmyRtCyJEYUyBsjLN9DldUOoXwTBVd9
         tpP3p3aBkNw5v+AdxQsjjKE9/vl0RcmNFdyOY3EXhGSB7mEQ+vytBew9Xuqw6jZSa6xe
         u/oQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/ngFlb4Yd3IhdpLJPjE3H7gA4U1TgWzmnjkey4llEgxUIeod1bJ43fY12wfPsVwNSsTlTmcpH@vger.kernel.org, AJvYcCUHvd/hGPTeeXFRJt6f/KlSNSzwrEXcctwpr3QSlZwAT6eJ8r5X8nZ1LUob8KnO5ueJ6Ap8Cac5aMHUsoSK@vger.kernel.org, AJvYcCUWVBHcX85sbOoh6j6vnsrZ9q5T1zPHOt7ocCfXZxtnsXxgsHn+Z7WDVHtm+X2rLV8VVgO+3WoeA9Lp@vger.kernel.org
X-Gm-Message-State: AOJu0YzGq6/OFlASN+SiQQ8sAnbNXm47sYud30kRY3L7YeZqjEl0cKYe
	PW1f45RkvtbstTC8kkNFv5GfiL0euX2TaeWSlvgpccA9WmKc6wr1
X-Google-Smtp-Source: AGHT+IGH/FrrfW96edZYOU/1eyhLzJAIrm6AzqPxdvn8RuUgJVuG2hN9MhbFU5coSZ1MSxKcT0X90A==
X-Received: by 2002:a17:902:db0f:b0:20c:c482:1d72 with SMTP id d9443c01a7336-210c5a46f96mr94859525ad.20.1730071973692;
        Sun, 27 Oct 2024 16:32:53 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc044cb1sm39854595ad.249.2024.10.27.16.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 16:32:53 -0700 (PDT)
Date: Mon, 28 Oct 2024 07:32:28 +0800
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
Subject: Re: [PATCH v2 2/4] dt-bindings: net: Add support for Sophgo SG2044
 dwmac
Message-ID: <mwlbdxw7yh5cqqi5mnbhelf4ihqihup4zkzppkxm7ggsb5itbb@mcbyevoat76d>
References: <20241025011000.244350-1-inochiama@gmail.com>
 <20241025011000.244350-3-inochiama@gmail.com>
 <4avwff7m4puralnaoh6pat62nzpovre2usqkmp3q4r4bk5ujjf@j3jzr4p74v4a>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4avwff7m4puralnaoh6pat62nzpovre2usqkmp3q4r4bk5ujjf@j3jzr4p74v4a>

On Sun, Oct 27, 2024 at 09:38:00PM +0100, Krzysztof Kozlowski wrote:
> On Fri, Oct 25, 2024 at 09:09:58AM +0800, Inochi Amaoto wrote:
> > The GMAC IP on SG2044 is almost a standard Synopsys DesignWare MAC
> > with some extra clock.
> > 
> > Add necessary compatible string for this device.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> 
> This should be squashed with a corrected previous patch 

Good, I will.

> (why do you need to select snps,dwmac-5.30a?), 

The is because the driver use the fallback versioned compatible 
string to set up some common arguments. (This is what the patch
3 does). It is also better to have a accurate fallback compatible
if we already know what it is.

Regards,
Inochi

