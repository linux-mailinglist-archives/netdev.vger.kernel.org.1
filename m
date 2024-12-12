Return-Path: <netdev+bounces-151506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F339EFCB8
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 20:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B40E2897EF
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 19:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A157F18991E;
	Thu, 12 Dec 2024 19:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fv8Ra6tg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25E725948B
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032939; cv=none; b=Ez/mav4WVanYec/hjqROZm7dUrGhDe4ZYY1juxjVw9kiZPWqHd3aYrDPNkvVomGvdbXGolbnK+BtERpE3KUP0aQPbMhKEFYkZJbq5Taz3Y8eOozFjXdsyUkwFouMiFJSYIHgiAXRZkft9oQ7CsXm2m/UQRJ7oMAitJGjDFeCR2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032939; c=relaxed/simple;
	bh=AkCiv213PTw8QuRE8ZdLWbEVXn8W69YiTnWeHHdFSH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qalMr5hYXOIXkkKIeGNehTgSSB6bi2d+GiMOi6BWO2mZXPtvkGQDyDkNX+BYn8AH0Xx/fkG/7sjypz4Mslys5sECrYKNzhRk3dzgz+08ceafXVixl3UOurQyPHQZbEd07vWJvEPx3IQam8sPAvzNba9YZ1ABzptMBbTgUV+0AQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fv8Ra6tg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43616c12d72so1195265e9.2
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 11:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734032936; x=1734637736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CHruyszuz95c0mRitg9VM8Egb5g0n0g0sJi7jTF5p28=;
        b=Fv8Ra6tgesGTQpbwKN456TFaqEesCa3uFscyC8KjgwHMjZ7epm3Qa5bv3Pjvn+8LmW
         ybfOoBcKkL2ZCgBmXpfrnaIe/Rg4jg/BZ+Dd8HfjZBXd5uvrcCIOYBv92a6+UvWPTbqV
         +sc5VMrFROSYsPyUTdcFeZChWMGIhumDUjaYMAjYAP12fw6S19mDx9xBDLriGKTDGupw
         rtAV9fjO29Cr04zKyH3TltUM0HGuF1/vpc7UwSvl80x1p7NaWGvy57gqnpORKG/M3NfF
         1vJNAnnaNIEg6FvJ/04X8UlhVOyxVXt4LjsXtBkuGsVlIe4EwLkuKRfbgR8MtRC1Oi/l
         JgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734032936; x=1734637736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHruyszuz95c0mRitg9VM8Egb5g0n0g0sJi7jTF5p28=;
        b=vg0A6Ow6YUC2AIzSok7kt0+AeAuXKWBqix2ii54dPBhQramk+8cNbKWF/M3LVebeov
         8pHaoI9f2ymgfH8g5g1jYY6ZrYWyaysePV+B4qmQzZGlTS1WqisXNMOSnXBiE0fNWPMX
         OykNeXf7+RaGHGGxGI9q7BfDP5nrBjEWlmVHZaglxBAdOj7k2EVX1Nn6DaesKrMg314s
         Ff830+SZoij7MIpjWFk300NJk3L+kdtB7K5n8/9X6H3jiGdwRuAbchBdQplRClNSPn4m
         vrrOZu7DXbYZ8Vsao0w76vY2Q7Mqrw1b7xxX62QGjLkBl6lYfJsiRSWX7DgFrfS5wE87
         05Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWRrnsujq4EuJMf9LZ4KnkznCW2gfS65cnu4jbqPEckWWwHsg/G5C2QMKIcU+F7yxS5YZS0ruo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM5XgBdvRfFYe08tE/ZmcyGhcTrmCP2SSBNLS5b48RIhQWJl7H
	+u/M5hm5UuPrFX83yG1tSzDXnFLVB/v8yenJid4h9zUTN+g5cT4Z
X-Gm-Gg: ASbGncsBc3TBHqd9qD1MgzP4Zi8/Kaigq7k31bTPq3sI37+XwEGzuySl1y0yhws/3sD
	3O8/hq3s2M0t9hw6bd2msmHvkI7XUPmbKnhBX2XunpM1cUwTw3JNSS0sr/vBB2xNed5swgPTg5y
	bPDGAGIkfXPyz30D5fIGWYQndGaD0TxeuhxR3qnaIYud+M6BI1enn1iZ39kU9BEfKV1iZLSZ4wp
	/M98HHKG90KvTWmdOLxNkx3B6GirFs5RLf6si3gg6H1
X-Google-Smtp-Source: AGHT+IGei/ytsU0uz3R8nln0ahy4Ty3JSxlUh9dJSh74Wf0F9twwANiVA6L8VjLQkUfs9PPGqTcXXg==
X-Received: by 2002:a05:6000:1a88:b0:386:1cd3:8a06 with SMTP id ffacd0b85a97d-3864ce985b3mr2625805f8f.9.1734032936087;
        Thu, 12 Dec 2024 11:48:56 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387825296desm4830219f8f.111.2024.12.12.11.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 11:48:55 -0800 (PST)
Date: Thu, 12 Dec 2024 21:48:53 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Woojung Huh <woojung.huh@microchip.com>
Subject: Re: [PATCH RFC net-next 0/7] net: dsa: cleanup EEE (part 2)
Message-ID: <20241212194853.7b2bic2vchuqprxz@skbuf>
References: <Z1hPaLFlR4TW_YCr@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1hPaLFlR4TW_YCr@shell.armlinux.org.uk>

On Tue, Dec 10, 2024 at 02:25:44PM +0000, Russell King (Oracle) wrote:
> This is part 2 of the DSA EEE cleanups, and is being sent out becaues it
> is relevant for the review of part 1, but would make part 1 too large.
> 
> Patch 1 removes the useless setting of tx_lpi parameters in the
> ksz driver.
> 
> Patch 2 removes the DSA core code that calls the get_mac_eee() operation.
> This needs to be done before removing the implementations because doing
> otherwise would cause dsa_user_get_eee() to return -EOPNOTSUPP.
> 
> Patches 3..6 remove the trivial get_mac_eee() implementations from DSA
> drivers.
> 
> Patch 7 finally removes the get_mac_eee() method from struct
> dsa_switch_ops.

I appreciate the splitting of the get_mac_eee() removal into multiple
patches per driver and 2 for the DSA framework. It should help BSP
backporters which target only a subset of DSA drivers. Monolithic
patches are harder to digest, and may have trivial context conflicts due
to unrelated changes.

The set looks good, please don't forget to also update the documentation.

