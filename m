Return-Path: <netdev+bounces-146632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E51FA9D4B10
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 11:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5701F218EF
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 10:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE7E1C2DCF;
	Thu, 21 Nov 2024 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9cCRY6X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6546B13AD20;
	Thu, 21 Nov 2024 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732186251; cv=none; b=EPg8k/hfN6POc00qkARAwEhgNVQTO6wG6AiE30Fxu97I0LPBpUECk5WEFiL+PHFXUZF/FkEWqi7vso1JqBaONWsXjAtMiLl5MJuIgXJM6lLP7DLSrBuuGO05Fc/1BH3p6Cw309mJwaW5FtYbk7i9tTi7kZ59o6eapLI8h5JEAIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732186251; c=relaxed/simple;
	bh=I78UdYNZMljbHhsSf2LouY026xam5fZRKBa3/mnS9b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5Zz5Dy1m+q41upxa1/G5m1xJ1r/fMRIJWHrkS17U/COw+l/6HvKnCt67Znh19qHHdeimMGwJo0kHdDX/CmakJ61XXqUVDbwFXimkc7BwiRgvsZGOCsqWt0W156V6thOjwJe4AlRk7ADorixp9giS6lg0xqJPlbNJXjUP5YcDas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9cCRY6X; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43158124a54so338165e9.3;
        Thu, 21 Nov 2024 02:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732186248; x=1732791048; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Z0JYiHhNUAEkW+bAUqaJxEl5/3N8aR0I+9SYcXiEh0=;
        b=C9cCRY6X0f5QfYkPYFzk0K1tOi06ckY9ZCybYkY51n8A9HCjMdiMraTI+2jzXryhCB
         qRX6Ti4DdlFObOW2T3dBHEKawbwmyXhtntrNz3MZpk5+D+MlogsCx3Ib2f2gFGaZjv1t
         nBnG8e2MyaXwXvHrkdhV7Aq9/j5gAY6ueuAejCwD6BCBFjp6g/oocrt1urzqKWcjIWku
         K4Adrep+dY/1cIHqLsJ623xsGixQ/9bVIjsX2HcufxK8A+Wcp7snXyOrDHZIv0f+3xIW
         chDOD2+o9VowFTDjap9a8rnZTfX+2JYuSX2LGowhEFDeHkLSfp36/GblsNb9JIq+U0bq
         zLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732186248; x=1732791048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Z0JYiHhNUAEkW+bAUqaJxEl5/3N8aR0I+9SYcXiEh0=;
        b=kbKKZrHjiVphZvalIdDDlXTRYtPmYIqGIcfBTphHltOvA7+TvcTJsDoXvyOyZGciWF
         nrjmljbo8CW0DqA4GtYM1XOjTgYTSaKcnv/qEJSkvcZj8fDURP+wM3Mojm3Yh1xeUA74
         Puvak0qkKDvO2jUtCDCHfI1M3g8MsjOtNV7vwsOwRePnkGVUjyaHElLtOqh4s/Pl2pis
         SpNPfTQZh+GY9HcTxaBpgBRPR6DcxTAkpzJN6lJGMsCC6NMTqU3l3bsNP3nAyMsc8jmA
         EQUHdGHFKTR9Q7j/R0WmPOzr19kDfegz+0y2EyiHMkMKDJoimFf6pdfD3FyQHwcx2nRC
         5Iww==
X-Forwarded-Encrypted: i=1; AJvYcCUnzU7b5eKafYgV7rnYnX4UDuAfZL1+pkeu8bg366mO3Mh3tcD6m39iNt3+xqogU51VJbJ+bdB2@vger.kernel.org, AJvYcCUxAQy+IMgyehZpZwy/cd2Yy6Ct2T9BDfi3O3sLXv07QyCQqc8IZCAcRP3pOA4b79PAcnFqzIMS1oJbHjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6IzcDhQmCdnddC6LemH0jeA65329CSCs1rIf6e2Z38y9dubP5
	PASE4FaUJFI6IekXzqPxWXCvxfjNio2SKpsvX35oYwX3E2TS7J80
X-Gm-Gg: ASbGncsK25Bd5HmCni0qV23FC1STJy+Y6ONDOvQGw9Tww+gvMWvEnmcL8JWZijQXs8S
	PJFfRMD+FAKWgk3gYuCyjpuHSrnjSi2O+W2Ro+/xYbejxbTPFiUpA3anyUBt4j5HJMLoZ1ICoi/
	kL/a7AwlIM8qBONj4xaM5oIcVucVLtmibSokww4TWXqfaDAR+g1l0h5FrYOhol+A10z5TZUzSXx
	eHW/4caHYTaz+bIq/0e7VKcYcRdQu8C3cA6w/w=
X-Google-Smtp-Source: AGHT+IH4G2YtFr5S38w48iap8514kXMIX5qDd+J/+5P4iHlo711pVJ/CDcf/dMnonabNgm1GviqgRw==
X-Received: by 2002:a05:600c:1d0a:b0:42c:bfd6:9d2f with SMTP id 5b1f17b1804b1-43348986ec7mr23843295e9.1.1732186247483;
        Thu, 21 Nov 2024 02:50:47 -0800 (PST)
Received: from skbuf ([188.25.135.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45f5c33sm51127665e9.10.2024.11.21.02.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 02:50:46 -0800 (PST)
Date: Thu, 21 Nov 2024 12:50:44 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Cong Yi <yicong.srfy@foxmail.com>, linux@armlinux.org.uk
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, yicong@kylinos.cn
Subject: Re: [PATCH] net: phylink: Separating two unrelated definitions for
 improving code readability
Message-ID: <20241121105044.rbjp2deo5orce3me@skbuf>
References: <Zz2id5-T-2-_jj4Q@shell.armlinux.org.uk>
 <tencent_0F68091620B122436D14BEA497181B17C007@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_0F68091620B122436D14BEA497181B17C007@qq.com>

On Wed, Nov 20, 2024 at 05:46:14PM +0800, Cong Yi wrote:
> Hi, Russell King:
> 
> Thank you for your reply!
> Yes, as you say, there is no problem with the definitions themselves
> being named. When I just read from Linux-5.4 to 6.6, I thought
> that PCS_STATE_ and PHYLINK_DISABLE- were associated in some way.
> After reading the code carefully, I found that there was no correlation。
> In order to avoid similar confusion, I sent this patch.

For the record, I agree that tying together unrelated constants inside
the same anonymous enum and resetting the counter is a confusing coding
pattern, to which I don't see the benefit. Separating them and giving
names to the enums also gives the opportunity for stronger typing, which
was done here. I think the patch (or at least its idea) is ok.

