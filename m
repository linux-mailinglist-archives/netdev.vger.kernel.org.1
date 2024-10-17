Return-Path: <netdev+bounces-136694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAC89A2A8A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93CC281CC1
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF3C1DFDAF;
	Thu, 17 Oct 2024 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaVIDepg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548111DFD9B;
	Thu, 17 Oct 2024 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185409; cv=none; b=H39e9zGkQNoBqQ6oUo1iwKcZvb5ouOXWBKYnukPDWo/oNTx+YgP86pmErQi0n9kR8P71+bSfmM7y8Rq3gh6volLcdCc+Suy/CHTh04s/QuAzDpTFYuDCn7aDHhL0bxPTmzBIBT8gg1Rvb8T1rTBS7qmjV1MeWw698dCGD8D7xfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185409; c=relaxed/simple;
	bh=CHTkMCTOi4KADRR0Qt2Niy3JkOX6fjvWm/vnn6ueic8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/XfvIG2e0QCpYE4jfwO23B/gEXHaIUrJbQ9Xjfq4zjazFSZyAW2+Iqd8Hx8P1GMc2/PxGy05lFpV/6v0igI9GqxTFQcfxt2R35N+zkm2DHeSi4oqPkEhz967WSoI4V4Lfdhl0HCgyDZmglGWjTqhxsjEtR7TeuW9XpAaRPutoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaVIDepg; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4dbb4a89so137424f8f.3;
        Thu, 17 Oct 2024 10:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729185406; x=1729790206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CHTkMCTOi4KADRR0Qt2Niy3JkOX6fjvWm/vnn6ueic8=;
        b=HaVIDepgEW5Nz2F12YuISEirQri48FD5I59SGB/g8jUtbiqxVWFv7RDLfIhEcxGWT5
         /D1fimx1c495coiA7uwHhxzvU0e1isnPYQYw1VTqNS9DuuWj4nvuHKjMkf7c5JciXaGy
         L/Ec8LCteX/cGMWEhwlkWHHeLGy7PNyEN+e4YVS2G2Dz4zbyLp7NgvjI7ENrY6MkJgGm
         KClqg6d1s1GsRbhYs73gGe60Xlu4RcEOe46TPp2xJ+rWtzLrwo/JL7szHhBhyCcvRm6r
         G0jdN0YxB9AsL3joNb+WE1Z8/7iaGvXmoXGflGco6y6bA/EyBK9LmZ1wu194QWIUzY/u
         YHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729185406; x=1729790206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHTkMCTOi4KADRR0Qt2Niy3JkOX6fjvWm/vnn6ueic8=;
        b=XzCYV90LdC5YpmzwnOe4oUQUKZH130G95hcTrv5Py+/sQHkHY8fAIsK7pfAlkwUnD7
         ZKfO1TGObSQqqOBmPg743FpL4YOOujrxw/IMHgwC3MdAWcY/rfN5qkoucYRaiPXucUzY
         qW2c1CP7T/2mxeEm0AyjQkvayPHLp2wQYfY0HvJeVxKQsQhwzLzgrhswqE17Wggm4yHk
         do9b9lqvFAwrBj8Gdj3xgQLKt/AieLo7dnx2JpoSqSYzMuV9p2ikvUORH5/4gB3anjnx
         0D0RXK37GwgG5DO/ba4WoPVgFkwEdLY6Cw/d+pTYPtyy5bxvqSvuoYgKJYFOEFK7iP9P
         vqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3i9jwh+4fIpDJAVMYb/DpB8I1klymPuDCWEHEtUk52ImqhnPMrvv98iKeo3TeXlViOPk7oAXOre/OWts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3bkRjhzkjDvzhjJIvpxayqzySf+AuwXPVWsF8hYoDwi8pCzev
	qc22TxKLdlB6qWKIz8UdPjTTVfP0HPCV4LMz1UU/vyH32J4OC6Fz
X-Google-Smtp-Source: AGHT+IHybU/ZmFXrzf4w9xc8BacfuSn5MWDGIn00ngDmgGYyYXsHgb2X+ig6bMR+mxD9CZpdU0D5RA==
X-Received: by 2002:a5d:6c61:0:b0:37c:d0d6:ab1a with SMTP id ffacd0b85a97d-37d939bd9cbmr1387179f8f.12.1729185406268;
        Thu, 17 Oct 2024 10:16:46 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a09dsm7938351f8f.23.2024.10.17.10.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 10:16:45 -0700 (PDT)
Date: Thu, 17 Oct 2024 20:16:43 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v1 3/5] net: stmmac: Rework marco definitions
 for gmac4 and xgmac
Message-ID: <20241017171643.kmg7gvemmedl74r7@skbuf>
References: <cover.1728980110.git.0x1207@gmail.com>
 <94705afa1d2815e82c27d3d1a13b2ad6ada8952f.1728980110.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94705afa1d2815e82c27d3d1a13b2ad6ada8952f.1728980110.git.0x1207@gmail.com>

On Tue, Oct 15, 2024 at 05:09:24PM +0800, Furong Xu wrote:
> Rename and add marco definitions to better reuse them in common code.

s/marco/macro/ (twice)

