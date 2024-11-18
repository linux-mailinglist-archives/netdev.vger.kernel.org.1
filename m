Return-Path: <netdev+bounces-145878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5063B9D138D
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB9F1F22827
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 14:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68A21A0B00;
	Mon, 18 Nov 2024 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ER1Zc8yg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8D3186E2F;
	Mon, 18 Nov 2024 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731941346; cv=none; b=CwPjg2+OYuV6ENb4YARAYBxHhz9KdvYdUZvbNsRdtAc9sLTjhYdIIA8/xClFQAkf78tuFVq6quDu9kIyUIkAk9ZxFgZZpD0tkOHgDYJUWfVaym8VgGFxD7zIuh5SzzMeK0UIVJXQ5K7DvdN1Oyt5CMEiBR9cVecm/OEuzXhI+i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731941346; c=relaxed/simple;
	bh=jq2kdpRsEvipUj2yLaKB6TVHsx3WzL+SIjcjXghaeT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQgR+5+hc/2QiFnppXwrDBl/5LYW2qsDyG3+STo7CB1INB1dRR4qAJTe9Tl3KwKP7IHMiFU0MdN1vzdg8dW2qiMeTS7IY9hggF4hiuL7AjmER1PHSbmpz0FFkF6DY548eOQA9L1Oqy1MQrLjrUXeB4NeS5qyWo0l8naySAhdCf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ER1Zc8yg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43158124a54so2872425e9.3;
        Mon, 18 Nov 2024 06:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731941343; x=1732546143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sKPU7OueWbmOZ0vLDtsCLawk5Pg/j927rqgWt1B9QqA=;
        b=ER1Zc8yglF4kpWG18MwRnydkbjt7Qwt9Ypc4GJvTerWWJXNMokslQ63ji9JICVSQE0
         fqaRiO3SU7xv63rtJbC4N+VMJMAcwCf9ZCQGR+WsHm/Bqz1SGTI7+KEB8MuS7mx8xaWW
         IxKhDCZRTR0EyNR+qBrx+yLrWDMkz1Zmb2105r1XBVXOyTbWIO4Rn6FdaAFUWMzkKcJE
         CMaUXnRM9xHmj/IXx518uh7l15emc1xWkgHOMyTIDQp7O/r2iFLW2M3P7AjMwIjYg3gV
         36Mzn53gOtgIpqKeiH208fzCK4qBVky+mlL5khiFZ8KClEb0YOqq9gmMTTb9STkz4vZZ
         1vOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731941343; x=1732546143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKPU7OueWbmOZ0vLDtsCLawk5Pg/j927rqgWt1B9QqA=;
        b=m5E8r/l+juzHzuwqtqjT6rz52AKk6aUDVfV3Nld0REhQwSTmKIKxXUkjZUzW+IS9Jk
         M/eI8/Zp/kIOQvRoiz00wNeGhw3cWrCt6hQ0Mhzp5KGk+MWh25NCdqgf2pzE4f2qIDJV
         VOCXiuCcTWzKe4k1TSIMuJzY20jMYaYaOQUAVrzDXdtICvPrUUqrvjMfDNpyBjaYdHDD
         y8BznAQY7XQn5mouhC8Ln26vlD+aNjmf8gMRKYzh58YZSUGExtsuLhscN/OP3/n2om+u
         rWZOW/tI2uht+fJ2VthfXIBJuKP/l1ti9cyOpVKk7DO8rRN4eIyV6StCVqLLanUz1Zf1
         UYuA==
X-Forwarded-Encrypted: i=1; AJvYcCUg2dy6n0D71iyM45wH1L9TVUJbx35occSuxPNjGW3A9QsNTfl8E94KrH0Jfabdrp8OgvRKm0Xa@vger.kernel.org, AJvYcCVBdCTkJfEsVQWO5K/8eu4ZP9mvRwEsOFYCpUbwuqIm4Vx1nlVoS/AV8/7GTc8HbdYd5l8iaY2m/GY3X/S1@vger.kernel.org, AJvYcCWPK+AuMUGbFuDUdzL3S02NqY8mAuBnldh745TCt84N/OSn+tkV8ZTbEmqQoUUHd9mfjQv1YeFs8fAC@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj2/UvV8IO6bAk/1wGQSdDVAvYOnXPhnFxdWC/jl20DRHBq03e
	kZvNOq+J91/DyU6w3ro3hagCCScqq4B0cPYSK8Cn4SXtjSTL9hYr
X-Google-Smtp-Source: AGHT+IE012wnk28ETZsyQ8SITxH5vWI1jMJO1ED40DmOrjl3fn2iD7Eo7QE/jKPdNaugtPxI9JxYbg==
X-Received: by 2002:a5d:598f:0:b0:382:4378:464b with SMTP id ffacd0b85a97d-38243784b86mr1535185f8f.10.1731941343057;
        Mon, 18 Nov 2024 06:49:03 -0800 (PST)
Received: from skbuf ([188.25.135.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adad619sm12908879f8f.27.2024.11.18.06.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:49:02 -0800 (PST)
Date: Mon, 18 Nov 2024 16:48:59 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v7 0/4] net: dsa: Add Airoha AN8855 support
Message-ID: <20241118144859.4hwgpxtql5fplcyt@skbuf>
References: <20241117132811.67804-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117132811.67804-1-ansuelsmth@gmail.com>

Hi Christian,

On Sun, Nov 17, 2024 at 02:27:55PM +0100, Christian Marangi wrote:
> This small series add the initial support for the Airoha AN8855 Switch.
> 
> It's a 5 port Gigabit Switch with SGMII/HSGMII upstream port.
> 
> This is starting to get in the wild and there are already some router
> having this switch chip.
> 
> It's conceptually similar to mediatek switch but register and bits
> are different. And there is that massive Hell that is the PCS
> configuration.
> Saddly for that part we have absolutely NO documentation currently.
> 
> There is this special thing where PHY needs to be calibrated with values
> from the switch efuse. (the thing have a whole cpu timer and MCU)

Have you run the scripts in tools/testing/selftests/drivers/net/dsa/?
Could you post the results?

