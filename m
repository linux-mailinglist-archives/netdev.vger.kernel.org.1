Return-Path: <netdev+bounces-223892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFE9B7D72C
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85AFC7AAA56
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 07:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264492F618A;
	Wed, 17 Sep 2025 07:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inLILgKO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2462DE202
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094819; cv=none; b=ax/fTGq4ZVwtutJNLZC2Py4oiLhC79HT1Muj49IaHcw3wQj2JMHbfCtEWL5LuJ1unjK1RbZ9zj9/QnV/cUwwKEDd5sLux6LLJGM9kARBTN04SObmvWt8cnd+1RKSZ7DGbUfpJLXKHQ3+CpPQq17WiTbeFvPUyvO838QNBgcGM0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094819; c=relaxed/simple;
	bh=HxHsHvcdKs/v1qm12ibX90gBBGUFIvSLbkIVYD3OTX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiC+mIN3FJYLwc1SSBhAMsFYlHsPf7Okgb8r41h+xGBs1GtoM2n65WQNLVFVvVoCNHFYuzhf5nzr1QaQR5PY/aT4Lv5ChdL+JQzX2Cj0hm6ecacPOm5K0P1heCU8T0mLxN2nuLrqo7d8usefMCwCcf/cjnCY6IrcyH21f2ft5zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inLILgKO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45de5246dc4so13604815e9.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 00:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758094816; x=1758699616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0/XIt5NtVraCB5MTYAooGz9WbJEZ2DnkRKVJdNOYFJ8=;
        b=inLILgKOok0/HmI48V5f31us3L2NM3sS/hlWNVYAle3PNiGKSfqOSMbxauL5ndTYpV
         XLRQv0Wad+qQg9yGzJU6stlEVlfkcQRRMlMt18lnyfZjWDXX2fsG5fwO8dnROTb3uZ8M
         qCL+2LmOOih40TVvatOxnztBVXMplORGGmD+yBfC70Y3BCFpxE7VqrQDqeSdjFRJS7yy
         W3UNj7KB5MWIAMu7pSB9FqFaMqa92lIVfO8y1KYjo1q0mTv9XIUhk0gnaDS2cd64uYIg
         oVEu+TU128el7sT62y903b+ydHhcAHGUWH6aNjKH84/7SCu9Tl/fKwCxYS38UnPaJWY6
         ZY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758094816; x=1758699616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/XIt5NtVraCB5MTYAooGz9WbJEZ2DnkRKVJdNOYFJ8=;
        b=eStqjM/lFFIOacH7r64ZoPtqoosuTZGcjLi3TIn5JPh16wr7GPfee2CGgiz7Y9YxWa
         5HtgZNZDB0UsBnMndELpTguUV5L/JuqoccXueWcjAVaoZdktJ5a0KcCF24S9NDBfg9P7
         AosrB9RPH9k9DGVoNE3v5tM/V4X9C1tiIC64ohBKV8Fx9m5SO+Ubve9o4LvUElomQRcB
         bfc+J/lwj+lADtmOYOS3RzNN9zjqZ4FivGTQz/173PR8cQ+sjJDyVlt992VYk5Z3G4TW
         21XwxCtN9n4nbnLbnbXNs+MK0LmIAW8Dhs9dyniPIVogWtVWW/MBySgjHvDmqpXP0bbp
         S1iA==
X-Forwarded-Encrypted: i=1; AJvYcCUCo8bRoTUvMAYDJ9eHcbEjbpu/O1qMpJevHysexIU4TlJGva9EAGtfvatub+yh4izLKzygVnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwsCqMr+XRK7DrACD4qdcD2wbX8CE4vGTKLKdMDDN8fG3qYzM5
	cTwTLQuKCj90HbX76sINY019EpHE818nASQDhN2XcO2FOWQeBBdG84Ph
X-Gm-Gg: ASbGncv8XIP4+3aaGEOMYla+H80/A2C6dj4vM3liVhyJ9kS+dBFK1bqiqaKmrTUpBzH
	TxrFws7lXC7Xfria4JOrdUwhFPDu4nNSP1H8NDn8xoDaDAaGTGz5SbWaNiiM9oyUCxuJBN1+fcg
	VvccdrD1OdNDICsSThbAjLr5v8GQNBO9RlVCvGMAFGKa5ErQpWB8XVdbn/HkKZKKjTdsKUDf5cs
	FYezdM7nDM1BR+oleokl+VLg9iflcg941tS6FtUXFqSgcNv5FMKbYFjKZjKIuU0C4YsXMsY9yIB
	bVq6JOl+p7OBgKKfCd0VtLbbb93erxZViSLoVNjvVofTPZrEzFtPc9G3sRDJCVm3BuGUjpr+ZVY
	rqX0kQXT/TTcHzVo=
X-Google-Smtp-Source: AGHT+IH+aEDsquFwI7j5oPZLBieB2+/7Sfb48d409ushmu9h1HOa1q5tHuGixHUOK8v4Xcq5CxkBMA==
X-Received: by 2002:a05:600c:1c18:b0:45f:3263:762e with SMTP id 5b1f17b1804b1-462fef540a0mr19185e9.3.1758094815316;
        Wed, 17 Sep 2025 00:40:15 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:8bcc:b603:fee7:a273])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-461eefee9f3sm14717025e9.1.2025.09.17.00.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 00:40:14 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:40:11 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: dsa: dsa_loop: remove usage of
 mdio_board_info
Message-ID: <20250917074011.zjh6lhxz7zwzohlo@skbuf>
References: <4ccf7476-0744-4f6b-aafc-7ba84d15a432@gmail.com>
 <da9563a4-8e14-41cf-bfea-cf5f1b58a4b7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da9563a4-8e14-41cf-bfea-cf5f1b58a4b7@gmail.com>

On Sat, Sep 13, 2025 at 11:07:08PM +0200, Heiner Kallweit wrote:
> dsa_loop is the last remaining user of mdio_board_info. Let's remove
> using mdio_board_info, so that support for it can be dropped from
> phylib.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---

Thanks for the conversion! It looks really good.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Tested-by: Vladimir Oltean <olteanv@gmail.com>

