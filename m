Return-Path: <netdev+bounces-151153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6AE9ED0A7
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 17:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1CE51886C88
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 16:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED3D19F131;
	Wed, 11 Dec 2024 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIh/vd+S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBA324633F
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932867; cv=none; b=sENs4kaQ5MaYuBvuhtOfvyLduSXhL6Ai5NeXmOqeLaJSGSUrdIkLweAL0TDf8WZjZPLWsXBcT684x/A8UwfNX9rKfxE/wizxCSarZj1IuTxc9Wb19m8RpUwCgrd9PoQujZ3UJrVfEJ6QtQYnBAWUusGLH4TGIp7c8f/ITsh3wtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932867; c=relaxed/simple;
	bh=2eiLZxyAdC236sk/Nqx7Ju43ISHYNk16b5WIFQxB0EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohcMkwGaoBo67686HHZmcGo1FeWr/SBao9hXIvOANEizBD1LK8mhp86kjbPhCr0ef6te5JctrXUyYPzdDwMsgFvNYhnvw2qOhR8+shzhpkQz0KIcVNlpgxxGxOtUJcm13G+Ek1aB9bCqgJQ+Fi5Cfa1J8bQGbLddDQmyxDQdwyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIh/vd+S; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3c0bd1cc4so623564a12.0
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 08:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733932864; x=1734537664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2eiLZxyAdC236sk/Nqx7Ju43ISHYNk16b5WIFQxB0EE=;
        b=TIh/vd+Sh5xt3MppUZQAOCx2YQa+C7nRqLsCK73QeBlFYtp6RtawbVFCV0YEwRI8wb
         uL2n5V8R1DLGSXqBZcvQyWcjPqvOJB/b6k0pm8KQSzGrKkml5Bbhz4QY6KaddpdKxFMc
         4bfCUB2sZNcRyqn7JVdkx7T7hmUTCYIkB1v/OtrA0zcgPXSZd/5bMI52bO7Y+lvC6bz6
         RAueTLFeWDObaVt9KKy+VP7E8zMOUIUvrbmEOvIm9YHAkKNTD/DkYEw31yjN/LJKjIqI
         4P9397XidIhtLjOon/NbZLKHIpDGnTPAWMUCN337vVRhBTDKzobzL8D70tGCBRZcSc5l
         mucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733932864; x=1734537664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eiLZxyAdC236sk/Nqx7Ju43ISHYNk16b5WIFQxB0EE=;
        b=iswbuAldRWwUMsxRe/sn29CwkNuVJxpYmHfyIijuNGYohCSbavYEIqXuk81aEnXJVv
         La1bCbj1hCUeA9r0HaEMOf608tucN/mvGJO4O1g0jAo3wkEelkyYxrb9bt75G1qVMAO1
         IPNL29kTLwjumuvZ/4/QgIhZo5rtrIKnzShmXLgiG+BENh4+5uZjGAtAmSizQCtssfZw
         7XX5WWwBEoGn2rIwqjuxVPnDjcy9OZnkbZhbcV1Ngt1/MX2lnvM0nQmBX8ibkAhaRVAq
         wOnoOrn/CDQWidZIhu9wpmcCRqtftz+JzOmXyEKaT7NOLb7bINgiOVDznnlNlQlHTLPB
         CI3w==
X-Forwarded-Encrypted: i=1; AJvYcCXmsbV9u/uIWeO4i8d9dNm6gOoie4IdZs+5wt4v4YlyfXqtBrU7mgywbImNPnNXYG8UrcmyKsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGGPFwt/JhFulu3Jzwdi90OdJGOR+DoDcQwic64JfAMHKNvcrh
	oCI7Bf//vOtbuuuVPuNkFn5JHQsR9LHfRCTzlwLvryoiJ/KasxiY
X-Gm-Gg: ASbGncujkvsDNJLMXQxZBeyJgt/dsLyM9v7C5l5Jh3+9mBGKG+GCS3Sq8LTshYAzwhN
	CJhgREhxgP5hvKuxWiuL9FO1RbC+oE7ZPJNGJR7V0VZ3ttii0XmceAU0TtKwPZKcMMlzasFUlY+
	D/T6AS52vfPn1o78O2TcGLJbosfLU/oTGMbk0okbq9RP0oChrsqDJZsDxzxe5nwcJNEjno2moxG
	wkBOane/H4ScWksdVqqjpiLlYIobNpGjYmC43tVGw==
X-Google-Smtp-Source: AGHT+IGpHZ7duPMWiLF14rljsFoBTbUsF6ObaJbe99GJ62pMOFoPQ178gwFizB5Dr+oYjlRztVrq1w==
X-Received: by 2002:a05:6402:5193:b0:5d0:bf79:e925 with SMTP id 4fb4d7f45d1cf-5d43314d34cmr1136018a12.6.1733932863555;
        Wed, 11 Dec 2024 08:01:03 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3e7349b44sm6244827a12.71.2024.12.11.08.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:01:02 -0800 (PST)
Date: Wed, 11 Dec 2024 18:00:59 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>, UNGLinuxDriver@microchip.com,
	Woojung Huh <woojung.huh@microchip.com>
Subject: Re: [PATCH net-next 0/9] net: dsa: cleanup EEE (part 1)
Message-ID: <20241211160059.ypcydtoenlfc2wog@skbuf>
References: <Z1hNkEb13FMuDQiY@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1hNkEb13FMuDQiY@shell.armlinux.org.uk>

On Tue, Dec 10, 2024 at 02:17:52PM +0000, Russell King (Oracle) wrote:
> Part 2 will remove the (now) useless .get_mac_eee() DSA operation.

Thanks for the work. For part 2, could you also include changes to
Documentation/networking/dsa/ to explain the new usage pattern?

