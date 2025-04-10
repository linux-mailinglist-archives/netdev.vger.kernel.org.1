Return-Path: <netdev+bounces-181369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E67A84AD7
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 19:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7185C1BA3314
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2631F03F2;
	Thu, 10 Apr 2025 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG3HEWwA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05F31E834F;
	Thu, 10 Apr 2025 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744305718; cv=none; b=fZca5aW//XE5kw87r1WUtSgYY5O0C1KK0Dp6tvJd0ZgUCmmE3zloo6CUkMtELYFt6p0+dVHCpqKppKN7LL83dZ0exUN9sQKeSPG1JIin4gfRtE69iESixTdjFJL3A1TpjiKpBXPmbbSRh0n8ZR7YaSmugxAVJBevcg/YnODd1kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744305718; c=relaxed/simple;
	bh=4wfb8wCA7/jP2pofxzHhgiBSs9bD7EpdRi0HWOXTsMc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aw7WthfS3yCiXpmI2yWWMVnYecsNqEBpCCpDS7eEmQ9dI/uCARolz0tROQ6gvAtJWGsYcrF5g6vvE3D3iCOG2eF9zisF/W22oS+/LJCNaGdl7gUAUa1KxL5/5CFka0EBzEV1uwYn5Yd5lGkT4W0E8T5qdAINtYla5vGuhQLEfE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PG3HEWwA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso12619895e9.3;
        Thu, 10 Apr 2025 10:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744305715; x=1744910515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dAc+8MmXaPw82AK614idcCEM+ZCB9j3mz3cx8QDG7lg=;
        b=PG3HEWwA6375hgqVXdCVy0MMBSZb+SRMcN5qDYqrJbqQ5Smn/Ax9bsXM4xQ67yoT/2
         D/Rv8enGcmMMSjNmvqEOHZZZp0dwe1uYKdFMVuiaupZXbQZgP0EVdLsCEPspcsQ6RaUp
         MidF4Jdi6PJ5+FZYOXmifOnw8g+REqRH8pNNNqstLmvEH7av8OgyRMJ3t5O7yO/vGeyj
         Yq8DRM6yLciBAzkdBDK4tvuV5b1dNNGQR2rcv93+1mBK8AWewdBg+r/PHUDnebS88xBO
         3YcPJrj7XjDulJe82mJL/+3bXANi6ua3LMFLNilNhIntnJv1YXV5SRc7J5irAjcQZSYa
         Tp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744305715; x=1744910515;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAc+8MmXaPw82AK614idcCEM+ZCB9j3mz3cx8QDG7lg=;
        b=upfSiiccrx9YMiGgaYuPsSa6XO97lWKwhHUEwUiaw42ofoYxK8pm2hNOGx3Pc4V1vk
         QlEcijgG6uT49sizh4Lsbr86h8BETBoFMlJ9KB9ftNOkUB9U0eJ9d/CPIykbqSRleKSW
         uKKfNiXAtPj+mVtr1WBSWHtPnhpzXHLc4zXnSz7HZsgKUFMpABn2qCUiWh28Ms2r3U3Z
         nqBfwy04UmDh5ydJkAXNK3yXiB/Xp5CYisp3Y/LIMTO3OLUa8NESWTF0QjjBTU+N7+Jr
         +DmtDwOWUWclr+i9raYpKRPM0qHFhRI+go0otgy1hQm86q2cEv7zWT2pu0yUY3zRY4hN
         Jebg==
X-Forwarded-Encrypted: i=1; AJvYcCVL0BoSRM7ib+cn2pYNYk2CW+wMLu49kepW5Fo7vWYDLKWnPF78hhUjwkMkHw4VOx0JhDvwsLSoLOT+@vger.kernel.org, AJvYcCVuicaRu+ix1uSm3ZmGAZ+pftrHaHCdj2SDWX1X6nNI7wLPOzde7nYp6EfSXJmfK0hQFl9kq0fS@vger.kernel.org, AJvYcCWeCelnG0JasISHEZHV+7nmDWtsorXb3mdlVKkZN63fhVj42buW1wRP4euMjCP9lYIBghx9TK5LKSmXp4VB@vger.kernel.org
X-Gm-Message-State: AOJu0YzHcy++R66RD3EcxE6WsZV0LVSkZIlmthcC9fa+Upqu+Wa6W3Di
	PKKyaluuxMb2hvtysuczz8nHXVpO9A5lQNABMpPs/NUGX+eAfV4Y
X-Gm-Gg: ASbGncu99ptGyzJNfki3qrfKfcKCNLOM/QgN2mV5OvT13jMovNoCYf28Jz07nOpeWTv
	GBaMktfk8FoAqlzJJmY/Glbc4U1iwsvprDkiXr7WL7HAJzY6ich2cyMClHPSe1t4I5CnK9XAKQi
	V0Tfb7c1RTZgRWrTAwh6iIz0BcivPymDkeY48CYzzTbHHgZ9DKv5jGOu9tSF5Z8+QuvPfrcGpS2
	jfd2Ilo1P4tBvlt2rRQwRXDsDppdsi2IBWRd1T8OrO6BlTqTdIGk6xPAzEMZFzEmWWV1F5+b5Xr
	tw47CsYmaGLhSJhDRat6SMWDbA2Q06Stq/RMjTzngFJHt/SW7TyDycHX9F7DDQuZt5Fa38g8
X-Google-Smtp-Source: AGHT+IH9Q8JVxZ+OtPlHUwBVz66fYYqdFxCdjwnV7YZ5WdP6zgznnwKgqIHbad9mCS+gFQ4yfd7yUg==
X-Received: by 2002:a05:600c:35cf:b0:43d:aed:f7de with SMTP id 5b1f17b1804b1-43f2ff9c1c8mr27833405e9.21.1744305715155;
        Thu, 10 Apr 2025 10:21:55 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075fc99sm62515765e9.29.2025.04.10.10.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 10:21:54 -0700 (PDT)
Message-ID: <67f7fe32.050a0220.130904.08f8@mx.google.com>
X-Google-Original-Message-ID: <Z_f-MLd5pX41-Zh6@Ansuel-XPS.>
Date: Thu, 10 Apr 2025 19:21:52 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v14 06/16] net: mdio: regmap: prepare support
 for multiple valid addr
References: <20250408095139.51659-1-ansuelsmth@gmail.com>
 <20250408095139.51659-7-ansuelsmth@gmail.com>
 <fc1ee916-c34f-4a73-bdf6-6344846d561b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc1ee916-c34f-4a73-bdf6-6344846d561b@lunn.ch>

On Thu, Apr 10, 2025 at 07:13:34PM +0200, Andrew Lunn wrote:
> On Tue, Apr 08, 2025 at 11:51:13AM +0200, Christian Marangi wrote:
> > Rework the valid_addr and convert it to a mask in preparation for mdio
> > regmap to support multiple valid addr in the case the regmap can support
> > it.
> >  	mr = mii->priv;
> >  	mr->regmap = config->regmap;
> > -	mr->valid_addr = config->valid_addr;
> > +	mr->valid_addr_mask = BIT(config->valid_addr);
> 
> I don't see how this allows you to support multiple addresses. You
> still only have one bit set in mr->valid_addr_mask.
>

This is really a preparation patch for the next 2 and split from the
other to better evaluate the change for the mask.

-- 
	Ansuel

