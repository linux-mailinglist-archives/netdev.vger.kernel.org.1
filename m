Return-Path: <netdev+bounces-241645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7F6C87168
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 21:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF363B08A3
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 20:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D4C29E0E6;
	Tue, 25 Nov 2025 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0QRS2hQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2021A9FA4
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764103342; cv=none; b=auOblBnyz8bpYluj08P/RhgD55xzK/fDFKj9wgwp/uOGF1vNFFK4XiH7ZpzjMfDcUURXF51YORRspzv/mdUx7c4nmXDa9Ror+ZOMO0cU8veZUa+qNl/Il1hCh+8VeMrdPMQJYi4VOIB35YFc9db0kGB7UXVN7NPWRLRm+ritjNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764103342; c=relaxed/simple;
	bh=rAwu7od3Ig4NqIN7e2uSUs1FVPZ+2Q7sQSsIkrvJzeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncIdImTxqUoPm4w6TtWAWcCoPix3wzQt2DCw++VQ8ryXfVEQFcUUc2jLUsC/uY3pIqHbpHbDLRblx92Q3kPyu50sn/bAxB01IZv4OoMtNdpUh0epE/Co8iacJFitlcW9kgxZS3P+8rqnqx52XLHI47uliPNs1pM5xTeV/MDEptw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0QRS2hQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429c8d1be2eso679662f8f.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 12:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764103339; x=1764708139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g/AUE+w4FR4w7EMLBkAOfRzsYhVrT0p72HoCrpmdLCo=;
        b=b0QRS2hQm67bVPGSTSmH54qqfUVLqLzFloe49+w3W5Z/XmohG/rrL/6dxgD6WyHb6f
         K7cODg2etfBgU6AciC43CaGt/ZGeGqr/2lNvu9OIaih25U7pd7Bc7CF9Y1d2yB6gz2ts
         vm19rwniiAVp57hzxnUP35AgT+OELeRD8JFR8E9TPBVnhIrh1j1AN852yCXvteO+c4wR
         lu7y4dNBMBhMxaw27EmTmaVoyjZvej2qhIWR5MmEYiF7nEWpaX/sDupd10eVl7BvbktC
         nQE//JgJKnD/8X3U2sBPGlnmkXXgip1OtJOnBmid+tN0hprOtxzHoSRXnqb/gQUx1vZ3
         GPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764103339; x=1764708139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/AUE+w4FR4w7EMLBkAOfRzsYhVrT0p72HoCrpmdLCo=;
        b=bNeW61uoS5vQuTihZWE5ooMYPrWnakuDLpcyh4WouZNCudny8LtwvpB23KUho1D3tc
         vksYTz9bV0wMbQ69nfYs0wcsfwUAbMaw9pK+K1/6NhzEojL2QcVZWbt1nYMzFFYDA7BC
         w+WIZoeSnwTjBFTW6lkDWyFgndAO2vMr5ZJGDXeApWErllUnsnwR94eTwQPVx5SMRnwo
         G1M8RyFRhiBafuaYdTLvYGNJ3cgQmkhz+n28wQTmaZaB0R7mDwFm4KR8yQINLXONTbdg
         LCCRX+ZHmQN2WpJnyCuRQk8N56OGqufzo1U+PLTmpnWOy0pw52imGW19ltrepXksiC5/
         GP4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5ZNFzf8bwduXTuCd81WnjeVsBrNPs7aFrj1Tu7dLyBHtdqkEzAQ7nKnU8a2YNalg0fR4LpMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5MkIIgW4v5j1FQRFPn6mrYWxknDCxRU8vraaG8tDMkVZnNuJi
	Q8bOPgYpY0DXMJ7w3wW2uW3NjULsBSn/zKE6fEOHrSXb3wehIYlGma8t
X-Gm-Gg: ASbGncs2AdNPnSmu0Hkz4s8NGb2Gli0321/0jqjSPVecpOsx6711fhTC0Gq6AsNt0aC
	l9krIoIXXsUo/JJb8bA2rD8IBLMob3i4r/gmdB3NH7nW5WZUZF0kXiKo/o5ICXuHtJu1i8HF4vm
	z8gdXobw80cLThClVA70MDsgGRCHrxqAgnh2BpQZCJ9L74QAPv8mfcHLVmBn/0tXuHeZrX2I3+n
	zoxyB5mjEuFP2HSpej2JegkOOUi7f8xZ12WvM+Mke75YC2ay+xLoIdSaWBCEroGuD6DzaoluBcc
	zu7Qzxf1xM341jaelWKUKyWuT1dSlBqz9x8eSXJaLsueUIKrOKhA2nBNJuGRcGA61Pn0e3dcMRb
	hXEgOS3YKbhNfXErLH46AyjCesWS/PnNBWRKrilPOrsYJ8FAgL0b+iG9YK+761m7SkuhDI2tc6c
	R0x0Nwzd7b1S94rg==
X-Google-Smtp-Source: AGHT+IHgNnBm5YWUVW6u0g8PR6nFQpSwsxhpHokFNGnunRVwV83McGAhdoS0yK0tHPys4trkbLZE7A==
X-Received: by 2002:a05:600c:1551:b0:477:9f61:8c20 with SMTP id 5b1f17b1804b1-477c311cdd1mr102602195e9.2.1764103338948;
        Tue, 25 Nov 2025 12:42:18 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:a04c:7112:155f:2ee5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790ab8b21fsm8353315e9.0.2025.11.25.12.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 12:42:18 -0800 (PST)
Date: Tue, 25 Nov 2025 22:42:15 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/7] net: dsa: b53: fix CPU port unicast ARL
 entries for BCM5325/65
Message-ID: <20251125204215.2lz44qdegapgncn5@skbuf>
References: <20251125075150.13879-1-jonas.gorski@gmail.com>
 <20251125075150.13879-1-jonas.gorski@gmail.com>
 <20251125075150.13879-5-jonas.gorski@gmail.com>
 <20251125075150.13879-5-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125075150.13879-5-jonas.gorski@gmail.com>
 <20251125075150.13879-5-jonas.gorski@gmail.com>

On Tue, Nov 25, 2025 at 08:51:47AM +0100, Jonas Gorski wrote:
> On BCM5325 and BCM5365, unicast ARL entries use 8 as the value for the
> CPU port, so we need to translate it to/from 5 as used for the CPU port
> at most other places.
> +	ent->port = (mac_vid >> ARLTBL_DATA_PORT_ID_S_25) &
> +		     ARLTBL_DATA_PORT_ID_MASK_25;
> +	if (!is_multicast_ether_addr(ent->mac) && ent->port == B53_CPU_PORT)
> +		ent->port = B53_CPU_PORT_25;

Why not use is_unicast_ether_addr() to have a more clear correlation
between the commit message and the code?

