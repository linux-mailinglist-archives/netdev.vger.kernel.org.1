Return-Path: <netdev+bounces-87003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522D98A13F3
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 14:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6FF282D2B
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 12:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986A5145FEE;
	Thu, 11 Apr 2024 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8M4zAQl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F1140E3C
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837134; cv=none; b=Kw0nI3x08WwUWfJ9yjtNgK0Dm3FL/ONPmdsqy28SX9NLpagJ1mQvvkoCzZcI1DVOBYi64JX06dWt+CuJtuQpU7S0ZCBg77wrEeUtATh+/odEecX71VQtlQcr5PFyB+oCEnyJYbz5XRquY/cbG7DFoAOJ16oBePv0RAId3Bbd1lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837134; c=relaxed/simple;
	bh=4ArnlgziUqMK060/CRd+B74qBs8mulubYuo1nQ/vk1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnG4n+EOkfoRc8yM89EpJIlcHZfAzGGEkd5hcw6jTrDlSOlM2CYjvVQbdj3wwgyjBK7IvqE+05VGbJlvZ/7nfpqvKIlvTFOXZEx74fNmcwZqsLlJnX2pX5M/VwzRKIOPjo60GibWYXXiSs+Aeo48BcPDvlqLHN/ZJKVzvPpUM1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8M4zAQl; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33edbc5932bso5820319f8f.3
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 05:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712837131; x=1713441931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xs2a28Cg6n+56tdQWFoWyaffNz8jOtKm5y8vlVD8fmE=;
        b=L8M4zAQlTB3BPrEnMByQEvkWMuMmPxY5gZoBQULPFdXmQE18hJlh/BqvjNfPhcH98K
         eCRyL6V5q9IVKlXh2vH79YrjNG570TQsPdUrbV2zbs1KYZD9kYgNaNIveKDU5TPaufI5
         TVdMylR0D1kEcOK+QgQvoUMHs4mzMqj4204900A1n9cCSKJf2Sv1Fm+lyguV8oLJ8xd+
         iwpd1XVF4F1R5LB6sAqbUo8EtjTO9PmVdBP9Uk5AkoDe2fnf8rW7k1Kf9Kl6tMjmiXYu
         6i06gVziv3rsFgXgWI8esln8Yqv2AiVyNvnnXdRheYeHku3R+bPxiqqzo6/8Z7yLRKw7
         MGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712837131; x=1713441931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xs2a28Cg6n+56tdQWFoWyaffNz8jOtKm5y8vlVD8fmE=;
        b=IaLkJkg/sbw4NGnbEcuMBy3YJSKb3TB96GTUgustilRK2mdG5vGhNTxHJ0ScoMi4nJ
         4Ibij0vIMFo/bb3TXKSOLyv549zPZ9yNBGvMBXEQ2yA8uwiMWsANcL4Bj/ljHFfaGEJ4
         hG62QzLRaRK+NJPr/CqeuTXnCkkUvyHJE1omZPZkIr5vAiT6GXT+b0yy7HiW8Q7N7h3X
         aoTcWQlMUlcNVzBhF8t5rELbTWBnBt3KKU5Tixv/MH+jHt6RrEN5yjF37IExLfIINhsV
         DLOhYlac6FOmMx7HjkaNknKqncpnR62r/T+VskueLfhxpNdaHSLP86VG7e16cXNgpWca
         SoLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO+qF+3smUGlash3h3GmEGCO+6rObnyFnziBiyRbW6y1H8BjFVq3AZ/SAiwrerLxUgLzBYdi3Au2tO3w6eSXtzdqNUlxv7
X-Gm-Message-State: AOJu0Yxyh/g9jcNkyh9LkfvDYMyAOMeg1SftBEdHCYu3/SPWzwJQVVIx
	r2Ytn9sNKCAXUJ+2vrpe7QfufhK0yPuOtn0/UA4coHUBXSmu1Ioy
X-Google-Smtp-Source: AGHT+IHlxeEm6M7fj2wjEnjVKK70YqjlRy3wKxtMk7kTRGIQsfvHk/caQUxLViHPzrd40kz29cBLvQ==
X-Received: by 2002:a05:6000:1145:b0:33e:b719:8bec with SMTP id d5-20020a056000114500b0033eb7198becmr3333182wrx.24.1712837131073;
        Thu, 11 Apr 2024 05:05:31 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d201:1f00::b2c])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d6709000000b00343956e8852sm1631310wru.42.2024.04.11.05.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 05:05:30 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:05:28 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 3/3] net: dsa: mv88e6xxx: provide own phylink
 MAC operations
Message-ID: <20240411120528.4fswqnjnnvlkav6x@skbuf>
References: <ZhbrbM+d5UfgafGp@shell.armlinux.org.uk>
 <E1rudqK-006K9N-HY@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rudqK-006K9N-HY@rmk-PC.armlinux.org.uk>

On Wed, Apr 10, 2024 at 08:42:48PM +0100, Russell King (Oracle) wrote:
> Convert mv88e6xxx to provide its own phylink MAC operations, thus
> avoiding the shim layer in DSA's port.c
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

