Return-Path: <netdev+bounces-150425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE529EA31E
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BCC818872EE
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 23:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DCF19D88F;
	Mon,  9 Dec 2024 23:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfBBUUV/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4866D1E48A;
	Mon,  9 Dec 2024 23:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733788138; cv=none; b=HSrIm6vu5r/t2d+b8RkG3/LckmzRpnY4HVerr3f/jH1VnKrqQbD9Mw7rSThu3CH4PKXfCS0cYSpedMyIaiLB0SX2kK4ootZIT33jVOSDGSB6EppfdM4WL0RN5Uben8LIBWU1vYjFa2bwWqRqwxXXCavKhXlNrJYr1pBOT0Ivn7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733788138; c=relaxed/simple;
	bh=+zGoOp+VflwoGhsgDRcJK53Yg7vYXCoriYkgA8emnjg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zya6zvBbIzY4cdn0w76rADVdOmE82wxaj/znyqlo/6E/XHfVgp0Gqzl9H9myfgksmcIDK/o4z4mvmPPdL+RpPtWjCKUGuhGlP2gUWLajDEw2k20OU0dQ2FMTo3aRnuCCNJixFRKojG8Omkin0Z+2d8cCdnaWCyk9T1AWdPxDoCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfBBUUV/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434fa6bf744so9028415e9.2;
        Mon, 09 Dec 2024 15:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733788135; x=1734392935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2+opuRzsTQ7K1Ei5kmbovGQpDBWvV453DJpnISWYK7E=;
        b=hfBBUUV/NRDEkEWhrzFaneDwPd9qOItT34kcO0c9K5h6+258UH8pRfHOen32E7mKuK
         IkIvCTlNjCr4fkWMEWd/rzO/L8dECt48Er1po09NQmuTfXTLFcLOZwHkYhVZ7oRqvv5X
         CUvTkVLlrKQmOhDexpxiBzc2LlggrnBejjWIHjsmvIBRFFRPBWeGv0QPEvWTogAFBLk/
         i1Gpex8eAK/ZZEJySGfxVkaqOmAjLS99zF+V4rCukBAuXGnWJlKM85brFCRjQA6LIutC
         Bw1OCsp9ivpBjkUAOUgvtHNfp/VHNkxUID7TTQiNXE7Hb2zBx3dciAkhk1sYM28n411e
         z0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733788135; x=1734392935;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+opuRzsTQ7K1Ei5kmbovGQpDBWvV453DJpnISWYK7E=;
        b=mqaysp5zR1N42SwmYI+wzq5uHVqQre/NSfrCOYDkaYdSONvljbNDBzB+dbQunMaSbW
         06EpFqneAodKrogMTsp9plBLggFlaBTqueVYmi66kIyKkWPuH/9xuu+2CxnMM0sfM0Fa
         GTdLoGWvuIthna8IefTTL+SUZT/HTWuUXq+nH5icU3dPJyZSr0xTGIN3ZNlhdF9r2KUc
         Lg4Q8Sn6mTFH5pxo4HVIJ8rntqSOiDnegyCDfHtAthpIBxEYid19Aq0/G/MYt5tTFEnu
         s1IVWImgT/6EgUA0L8emHZamWtPq5YHvL6AKt7YGaNCfNRoO9sHyVfltO8oPM5QCUSu7
         3ENw==
X-Forwarded-Encrypted: i=1; AJvYcCUhDGr8fGx/bLTJDNiHnncHJVRvOlQUG4tFzUBQFfCWAUufPD61+3AW6CDNE00bnQ382gLqLEyQ@vger.kernel.org, AJvYcCV0nlSHozvG1vfeoHDNN3Z3lT2usps2PJzsgkx3cA8OIIopIPuYn4hg4NLpGA1Be6eUUgYd/siZ2RNJfiD9@vger.kernel.org, AJvYcCVVyRmmnCXxCWDxGLqSX9WDhLcANpvk0xBA7q1B0FAOHfxGSiUr9rR4nYc6TEDsZ1LYnCo7DLOB8T0J@vger.kernel.org
X-Gm-Message-State: AOJu0YzrfypjnNvCw+rlMaBAFn6z1YxZdtRCX2FyD57njIN3hpD5Iq3n
	meUJ+hydU2RkKr6F8tZwBuoDxxuyGILMNwVXO8eI4rjDurpXvRFk
X-Gm-Gg: ASbGncuy2hQOVxpujhlCYCxYc7sTN2WX5QojERDbu8bD1cG6AmMqFz7VOoJex+VFDGQ
	H/IZQggksVcVImeAFbjWlwMtJ3A94p3ImasBjQWH+AeJO+ttgqqtr+jnc+wiO3MA/VJFLkaPXZI
	5hR/QUBrAMSHQTl7vEvGkqrAQ6lzRZbXajB4u2KBL3ibbQCWk4cEGmcoYqbkAI0YnJJkZWYOAOF
	aZ9JmVtyTswMmodVdLlsTJekUihlvX+h+xJZHD+Yplcsfn67FausxCkMfeYC4kPhfR7HheaQr5i
	DoTzM8r5Ig==
X-Google-Smtp-Source: AGHT+IH9/KxJN7tPNyH97Gbd1yzXNSTFzl3Ym7oZH/K0A2GTk2oxeudvtllbhttHCkYsV4UVpV6MwQ==
X-Received: by 2002:a05:600c:45c7:b0:434:f297:8e85 with SMTP id 5b1f17b1804b1-434fff69f57mr25414345e9.10.1733788135304;
        Mon, 09 Dec 2024 15:48:55 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbea8sm14345085f8f.97.2024.12.09.15.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 15:48:54 -0800 (PST)
Message-ID: <675781e6.df0a0220.3c3d71.7a51@mx.google.com>
X-Google-Original-Message-ID: <Z1eB4tGzFOvn7ME4@Ansuel-XPS.>
Date: Tue, 10 Dec 2024 00:48:50 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v11 5/9] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-6-ansuelsmth@gmail.com>
 <20241209151813.106eda03@kernel.org>
 <67577bd7.7b0a0220.1ce6b5.fe93@mx.google.com>
 <20241209154030.0f34d5dd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209154030.0f34d5dd@kernel.org>

On Mon, Dec 09, 2024 at 03:40:30PM -0800, Jakub Kicinski wrote:
> On Tue, 10 Dec 2024 00:22:59 +0100 Christian Marangi wrote:
> > Also hope we won't have to request multiple stable tag for this multi
> > subsystem patch. Any hint on that?
> 
> Sorry I haven't payed much attention to earlier discussions.
> Why multiple stable tags? AFAICT all trees will need patches 
> 4 and 5, so we can put that on a stable tag / branch, the rest 
> can go directly into respective trees (assuming the table tag
> has been merged in). No?

Yes in theory only MFD is really needed (as it does export the page
symbol)

- NVMEM can go in his own tree. (no need for stable tag)
- mdio (require stable tag to correctly compile)
- dsa/phy (no need for stable tag)

So you are right, only one tag needed.

-- 
	Ansuel

