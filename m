Return-Path: <netdev+bounces-148193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D62479E0C3E
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 20:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE99CB35AB3
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 19:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6461DE4D4;
	Mon,  2 Dec 2024 19:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="UOOl6XEP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE9F2AD21
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733167765; cv=none; b=IGDkj5SAbjTWowsKz+YG+psV84oWm5AX3mNDosVW2EmgTeGq2TnIE22qmYpeqwrG0Xe84DNSkfIB4TGyK93a3j6C/0LRoPS8dLs0F0ZqFRe9r0KOcQ4DujYSnZes+6bmU7YpcurNvzypVMs6I7bb+0zKRQNiPgWbSNo9EeqcleE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733167765; c=relaxed/simple;
	bh=nOrckq6dI+NOW3xZ3ZsM8M3i7vU+U5hSj6VtEscVJUs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0Nu8JUktgMlKLZj3JpR7trqVFrPnmCD1YLXgAtLyQaF96CHpoO5H1xDhTKNTgPhI8Unr2aLShtrRYC3zjoLVyUElto2QQRKjXWbjUd/ia1eu7pfbl4xGZNCdd55gT/SIRSXP/9v+20WF/uaFarv9XV5beQtdhVM7iZeukjIUa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=UOOl6XEP; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fc41b4c78bso2521970a12.3
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 11:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1733167762; x=1733772562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWjAE+MAFjcIJfEobuyQ0p6A6hyh2++mPrDoB/VMumE=;
        b=UOOl6XEP3plnWTsWOr7+sbg8ctS4aoaIaHxmR+fLAgIech/ncoCCyrxj3W/dUtUwWm
         Y8hyse70Fd+s5sjtoOnjwhofD3DLInV0gnMrZA6wk5IGxm0a2d9jKn72tc6aYZqp45Gr
         8CYz3HqcPQgNKshZ83utfum7k2kaPuSP32xwTiyfK7yyIsdon6BCfQ6S/V2yHWcKejvK
         0K4mznCYU9DSBswf9i5E0uXmvlPn/LW/Rcb5kdhnGHimkJ+8QM+kpxaHj61t3+3g1Kta
         p9lw//cCjT3MNSsYx3DTi2nk+IRjax9Abp0vcMlTnxiAWHHcRoDGxv6dOHYGz0zTXEWY
         l9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733167762; x=1733772562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWjAE+MAFjcIJfEobuyQ0p6A6hyh2++mPrDoB/VMumE=;
        b=stolBP6TJjpfwHYQ2cyFzGETveCgyx38YTv9LC6iQ85PCl86pFhXdzeuzvujmF1N6q
         dC0Q3mfGDxTw+lFpGwmYfWDbQ40LCbwFeHiq/0RX1A2t2CCc9DxofXBM6JcULr+TmrAj
         lw1NJ89WY3+O0VCR/1VKT7uWBS1i0F7W0xKaCTnNQF8jTrD8S5hfbLAeVFN3LFGTJV2l
         gSIgy25oUqeuDI93DUlnbmjDQFEYu5oZtvCHpBPezvH9fYTVFHmN5/RBIIEt00h7FY8d
         9dGLeFHVpGBz02FyOsvUhu7Kbek3Hf2Eh0xhvvxc5L0qskKPz6/OyeuomOWtpvi9KHZv
         4OGw==
X-Gm-Message-State: AOJu0YwsdMgDFfSQosIqU2c9ZKoXkL4GGjdSgis84ZAv12rJAPNrr7FY
	wsuORAt8Gl3URtJp4eFzUmTX8dTr5f13zoWCEXl3vytqNXZwtI3hiS/Rg0arjSc=
X-Gm-Gg: ASbGncvCRov8g0RxFunI904vDjoWDokz9VP6cARilSaDgt9mJzHsNngOsNemMEbd9Uq
	HV411ad0K2WSyIoJBO6h/uemrhiB0AP2pzHAA8ijvYWs80O/B+8pfoyB7LaGuICy2HcsZEopbSP
	6MdqnM+F2oFMAIkj7Foi+bioQIg5S79VaU1C+7e4OO8Bt2C0EVjZkDiu5PRZyblGAEBwbXFegYQ
	QDjM/y3eCrBt+KuV4Pg9wHxBlWlqV3bvDrY+3znVf2oDeshEkU4qz44qFTIQ4OurceitBaq1D8i
	1rPBkiTPmCKNxSQUrGvIFNkAX8Y=
X-Google-Smtp-Source: AGHT+IHVBeH3r8zQch8jhKpimLPKyXV67ol+nYGMJ7IRgfqSitP3tMnMXfofvD1wj/aawPJE17McTg==
X-Received: by 2002:a17:90b:53c8:b0:2ee:5958:86d with SMTP id 98e67ed59e1d1-2ee59580911mr21361617a91.9.1733167762393;
        Mon, 02 Dec 2024 11:29:22 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee8444e31dsm4740643a91.45.2024.12.02.11.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 11:29:22 -0800 (PST)
Date: Mon, 2 Dec 2024 11:29:19 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: rawal.abhishek92@gmail.com
Cc: netdev@vger.kernel.org, dsahern@gmail.com, arawal@redhat.com,
 jamie.bainbridge@gmail.com
Subject: Re: [PATCH next] man: ss.8: add description for SCTP related
 entries.
Message-ID: <20241202112919.01dc7ee7@hermes.local>
In-Reply-To: <20241128044340.27897-1-rawal.abhishek92@gmail.com>
References: <20241128044340.27897-1-rawal.abhishek92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Nov 2024 10:13:40 +0530
rawal.abhishek92@gmail.com wrote:

> From: Abhishek Rawal <rawal.abhishek92@gmail.com>
> 
> SCTP protocol support is included, but manpage lacks
> the description for its entries. Add the missing
> descriptions so that SCTP information is complete.
> 
> Signed-off-by: Abhishek Rawal <rawal.abhishek92@gmail.com>
> Reviewed-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>

It is good to have more entries documented, but throwing entries
into the "some of the following" list just adds to an already messy section.

Similar issue is true for mptcp fields.

