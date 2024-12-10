Return-Path: <netdev+bounces-150871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D8F9EBDAE
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 23:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED11283316
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 22:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F757225A3B;
	Tue, 10 Dec 2024 22:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FH4etZo7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6F81EE7AD;
	Tue, 10 Dec 2024 22:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733868969; cv=none; b=KMY67LkgxIy93Gi4CmsX+EJgJQhj7iG3PdO+4pW5hZhZAO6uZpLJgfNLlBBfb/7rN793EFiEE504RuYUWUOi6MbumkEUfVQs+AfsdjRELztOesKsk6ITOLIyinkDfF+LFDV1+2inBILTBlSqFFIlHnOAqbvtH3JyR4o2Qa51q7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733868969; c=relaxed/simple;
	bh=2xn0RoVYyTCDaWMl1AvIjf+pV1kvTk2UrAnqi4NaGJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgJemn8MZ9oX3zMXxiAmzGKVYTJ3jQ6/40Xco/dENUpkNLvJlTyKKAkJBYvHMKP30oW5AELK2+J/JuONIFC/jRIChhnXXK8EeNVtSV7AwUh4dwPd3j9Oo4b6qxzLwBDT0vctoHvBzScOxWrF5T89oKwQwy3woEC2R2dmk1b8vrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FH4etZo7; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3862f11a13dso429331f8f.2;
        Tue, 10 Dec 2024 14:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733868966; x=1734473766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mRVZK5OKZPQ83NdTd+WsrdVoDb3gZ6fVlrn8U4Yz184=;
        b=FH4etZo7zHe9HXc/7J2mlaVWX6ThtQ4bjdbQ6RDoFJymqOUj62kSw1GHWOTAsXJhri
         W4SPgIVqLRStHY9RChaDcUvMWsVzc6n8PB4K5inKbxULK3USYbTKt9WJp/lHFPxClkyQ
         hodRkcHKF7MKkBtpHqocqecn/aOJv6crbccf/3wFBGJxL37p2YJN88+TN5kOWPU4U2J8
         8lptOxLq9Oa2qjIzWx1+ReO5hpKhHh6GiIz+O+8/6SDSf7a91DntQG42Xs5CGCtFoJga
         W5f3/P3vb3Ar3VkeYkfSIUFS3C3irjyieLCRyEpQMNG1X+P0lONufn7Idn2dbg5qk5eA
         QLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733868966; x=1734473766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRVZK5OKZPQ83NdTd+WsrdVoDb3gZ6fVlrn8U4Yz184=;
        b=uHhbyNmnqlcTcnRiwiK4ao39on3MX+C6SO7j8QV7wNGp4BaMAflbWO7X4DvHAxsKwj
         C2QfYw9usUfolwjIi68lt7y+K+/2yoU7qnVK1uCraQE1xVWiMHUCcqM7HqjU2VStfn1Z
         mpS17bFZEbxZri/9QEvKxHCH0WgiOqY/P89KtE5kqwHKSWw6As6WEK+xwR380TNK2KBz
         ZFs6sghsb1/yXB4bk5e7Qj+84AU70Y5SWd+/vQGUb2hXNgawhsjlZ3oKM+r6Lil7tLS2
         MT5zNQMuGIuy0xHTZWXZa0cxUUS3V/Z+dUXmEGY62Yq5WykpOt+LAlNlDsPwMpe73ArG
         6Ayg==
X-Forwarded-Encrypted: i=1; AJvYcCUXn8mD497hLCTIlO8WEETk77zaMuaQuka286gwspmG+U7nwNjkoFsqFsdUMlek31hrX+1hAMraprP709uL@vger.kernel.org, AJvYcCUjMS8jJy8aJCd13qucY0Z4l9gaB0SiaCoBgiAsHDUF0jgY25ZOeVy/HWRy+AQht4ivoLA5v+RscaZo@vger.kernel.org, AJvYcCWflcnPgQxkt40lBicr7DTTTvqpk8FCthXCtqHEzEBcZBg5Hc6WfXaDcc/gP9IZ1R7B6cGAZwEp@vger.kernel.org
X-Gm-Message-State: AOJu0YzqjupxQ+rGCHq8otLCUFzJkN7ym4lhHHVCEGwXWj/pohLAsH5h
	YbPs9uWjlObH+UKzL0I6yxyDPkgeP85muTSbXvv8nwsigfCUak6L
X-Gm-Gg: ASbGnctugpUZQbjNAopQcuD1waIouDWv4lIneIWFSTwC66+w83wNOaQKWP1g5wubaed
	F2ZGfchNe6ipBxQecCzKkRrr8MAqwW0J4dfd0SuYf31pjdApO8a9lSAmGxMDyzQw61Z/IpThnnQ
	aHx6X/UL81tUMKsi/BZUIKY3Wsco61vTjIm9BZ53tPlTnFPCJxIa6LNnfVhSYD79NxOjlE3OoVQ
	EFLcBxQwFEtGnaxIPKFZz7kaXWxeA2QsVXrUfzOKQ==
X-Google-Smtp-Source: AGHT+IHm1baC4ofneij4gkJ6Um6QoGj/WmZV27xwyGsbgmRhKphYwBRaQXprw6HUiiteXAVqvlr1pQ==
X-Received: by 2002:a05:600c:510e:b0:434:fecf:cb2f with SMTP id 5b1f17b1804b1-4361c3af2bemr1150455e9.5.1733868965555;
        Tue, 10 Dec 2024 14:16:05 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386499a9edfsm2129713f8f.22.2024.12.10.14.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 14:16:04 -0800 (PST)
Date: Wed, 11 Dec 2024 00:16:02 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v11 3/9] dt-bindings: net: dsa: Document support
 for Airoha AN8855 DSA Switch
Message-ID: <20241210221602.ohyzlic2x3pflmrg@skbuf>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-4-ansuelsmth@gmail.com>
 <20241210204855.7pgvh74irualyxbn@skbuf>
 <6758ab9b.7b0a0220.3347af.914a@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6758ab9b.7b0a0220.3347af.914a@mx.google.com>

On Tue, Dec 10, 2024 at 09:59:04PM +0100, Christian Marangi wrote:
> > > +  airoha,ext-surge:
> > > +    $ref: /schemas/types.yaml#/definitions/flag
> > > +    description:
> > > +      Calibrate the internal PHY with the calibration values stored in EFUSE
> > > +      for the r50Ohm values.
> > 
> > Doesn't seem that this pertains to the switch.
> 
> Do you think this should be placed in each PHY node?

Logically speaking, that's where it belongs.

> I wanted to prevent having to define a schema also for PHY if possible
> given how integrated these are. (originally it was defined in DT node
> to follow how it was done in Airoha SDK)

Does compatibility with the Airoha SDK dt-bindings matter in any way?

