Return-Path: <netdev+bounces-53046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A45801283
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C041C20A09
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2174F212;
	Fri,  1 Dec 2023 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yi1v/4Xg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022B0115
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:20:31 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cdedb683f9so1797310b3a.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 10:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701454830; x=1702059630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6FH0TcrjcnuCcZhjexfAuu7+PxcUWEk5ugjeQLcg8YU=;
        b=Yi1v/4XgjPjmzmxX7Ay50OHL2ufSIr+m2qFwG91eDb22CI/nQjeOaJe23mZI0FvMmR
         nOxZ2BUhBobhumC0YMGvBAcy13YAECeX5iOWfPhKl3S4Je8GOH3tS5yUZ7Xxr1WOP0mp
         wL4pZgma2yqC7I2XBVd2PtEzVhYKySm0Nev08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701454830; x=1702059630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FH0TcrjcnuCcZhjexfAuu7+PxcUWEk5ugjeQLcg8YU=;
        b=ZEAnIoeueu9aYt3vMiWT06QnJ1gw/yO3M5YioOtumuJOLA/NW1GYeiv6XkiTm+w41D
         NOLQcU/Y5o2pvljw0y2BGE6MAFraqrjJamvm3cUCefiGXwH10gKWb/qp0riIunzgh0WU
         XFB9fge93XbsrHJstbWOQPGihSctRix17DBRvivUmcCjRLRDjvspfQbVgc+t5MlnOElq
         9D/neLcCb6pRA7AOI+pxP/Z+/F/CxB6GGLJ0nSCR+3DRzVlWSD0B0+CajKlQtrSILU2A
         iWfue4PMgB52M0xfyjdHluu1N2nbI5e/1D7FDonrGorsd5MxJceA39xp2JBNhzeWiroT
         vPOw==
X-Gm-Message-State: AOJu0Yxr5VRXqelVykKNVY4KpZNc2Z9WvG7Wl8bLFCPgObXpOwueKw2e
	18nmCy0nfEKzxDJ8Eto+pjaWJw==
X-Google-Smtp-Source: AGHT+IHmo+dAmB2azgLcLmANp8ELoQuOdQvcO3kAua9TsyV23+hBWe1Ep5gppWgWzdtq/+AMt8jsyA==
X-Received: by 2002:a05:6a00:2293:b0:6ce:d04:2b46 with SMTP id f19-20020a056a00229300b006ce0d042b46mr1441149pfe.25.1701454830520;
        Fri, 01 Dec 2023 10:20:30 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k18-20020a6568d2000000b005c1ae0b5440sm3011950pgt.74.2023.12.01.10.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:20:30 -0800 (PST)
Date: Fri, 1 Dec 2023 10:20:29 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: ena: replace deprecated strncpy with strscpy
Message-ID: <202312011019.A40455F@keescook>
References: <20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v1-1-ba4879974160@google.com>
 <170138158571.3648714.3841499997574845448.b4-ty@chromium.org>
 <20231130224134.73652d71@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130224134.73652d71@kernel.org>

On Thu, Nov 30, 2023 at 10:41:34PM -0800, Jakub Kicinski wrote:
> On Thu, 30 Nov 2023 13:59:48 -0800 Kees Cook wrote:
> > [1/1] net: ena: replace deprecated strncpy with strscpy
> >       https://git.kernel.org/kees/c/111f5a435d33
> 
> Again, please drop, Arthur requested for the commit message
> to be changed.

Dropped, though I did change the commit message in the pulled commit.

Justin, can you send a v2 with the commit change? Then it can go through
regular netdev machinery?

-- 
Kees Cook

