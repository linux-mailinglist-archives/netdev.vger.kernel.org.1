Return-Path: <netdev+bounces-158181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0EAA10CBC
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 17:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6078168540
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 16:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3A21D63DC;
	Tue, 14 Jan 2025 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mv7tXBHR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5EA23245F;
	Tue, 14 Jan 2025 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736873599; cv=none; b=rRAH+K8nNYrSJxKYDDeWEo4P2LRb30C8AJ4lC1gv3CI6S7favBDoF8HEOmWWNUcN3ACnO4j4v7Zhl1EN3as7E6yCEwq3sgaU33/xlRdtjiS62G/Y0deOd031znj6AokZrubAwb3OyEtv/RyztDTk2K6ou22Ucc6xf66e/o7aD9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736873599; c=relaxed/simple;
	bh=vu1/lKO4P2wk17+PTFiRBH88bLbNcFY6EKVCKaANTpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arszkd5KP1jICWFW494uDivU6+oQEqD292S+ARi20G1yo6jRD6wE1gB4Se2ecKhr40oJY21qZyyFiDN+bdg48mIGfBuv80SYTvsu8J9mfUODv2mvEfnPehnpN+KpfaSNunX/C0slgW3DnFvn2xRTJhg8n/DvAFq4OEEqObs1Zv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mv7tXBHR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43658c452f5so5073125e9.0;
        Tue, 14 Jan 2025 08:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736873596; x=1737478396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vu1/lKO4P2wk17+PTFiRBH88bLbNcFY6EKVCKaANTpM=;
        b=Mv7tXBHRP6D69T84J2F/FPwEgAPut09/VhN2JiK+tCyv7gxe/NpMnsYLQqeUy3B2An
         1mBbA3O4lDs6qv8poFXSZ7j3hI59sMmkyVeKySN9KQvKmtRjZOzFsUlTeCpEES2+GmhP
         jx4YJ2lgNPgybje6rvTjeTANOmz91HdqTfmtnyo36Jm1mrkPc4OSLYUBe1Xw/cT8eGWU
         wZ3U9n5YY1Ne5oIm9wC2FyuP3tsW06HgFZez9hnI6/67NaXFrTUz5jciW04MNkcHapUm
         Up+LUOVALeA329I2qYleFvq3dhPdf5J+zS91sYUE2SrnXoyPVrhM9t/KQA/IlVYU1qo1
         aoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736873596; x=1737478396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vu1/lKO4P2wk17+PTFiRBH88bLbNcFY6EKVCKaANTpM=;
        b=gGOb+UuZTwhytnXTQEDEEZfF+f6ZWHtpkVwuvktUksKYenllOrCKLA4K9H3W8w0MqT
         tOIGFo/3bAFbYsEVpeYVri00intELtHTG1qlyb+yne52IE8eksnN1SfSRXs4pfVfgrzK
         yqhvuWHIOvJghefJwTsKyI1J/6mR8oKUcTWY625/3vZ2JaUd/L7zARJtKnrCbV+jJg5m
         MHXjxNjiUPTliJX4qAyh3HXC4baIWesSU9CVddUEHM+cIszT0suAjVxO1aDV4rc5CTZ/
         FpHVbwNc6Fnwv0f6Tu5ClAlfMat68phJS4b+ADqpx03fOwyrQY569okHNnP4kbOJmZoh
         sv+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8+GO4X/Wc4n6DeKqG3eTvUymc1rNwnwR+JBmZIvp4sL3qn0ZRmK983arrzubgS8FVBf2RMtzJ@vger.kernel.org, AJvYcCWvl4WQ9ZTb6MPgpwtLnirBZ0Wyc0zw+a6FjjtF9CjJbSUYEN8OyvGY5frTOzKoWPdIvUeZhOTZ2At4AyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRy7bmEGF3P8BVB9QBCLJCrCOwiSfZSMdXlnWUYPnkTIzeqC0P
	CRUtk92PWDVEk5kxfbbujE03+KifYiKCB/t21gApAc5PogEDPuDi
X-Gm-Gg: ASbGncvRzAgJLs8R8BpIKa4QXfAG3xhElFdprfL5uHiTlr45ROOndq7/YX6noZMm8JR
	UQIfVgzOYruW5F/49dV47hVHTY9/ZXI5gsMBEiDtyrtIohlYLndbpQPP+G6z1qFEeymvr64LvkG
	FBHbsJfuou8DJVrEE9x03tlqkXDukRvgjuAZap6ydN5CmZV5jyVd5YiRicaX5bs2l4+pHJLWqtn
	RSnJ3oSQXU3HT4IZde0ep+D4GznNUQq2gptzcPMhOb0
X-Google-Smtp-Source: AGHT+IG5kfIyOEwl1MjdXLkyW8M7Sfqc9SY00TNDKu9nE6rTRdfeIvsXv85CXElHhPxjXBpffhJ0Ew==
X-Received: by 2002:a05:6000:2a9:b0:382:4e5c:5c96 with SMTP id ffacd0b85a97d-38a87303e57mr8516976f8f.8.1736873595484;
        Tue, 14 Jan 2025 08:53:15 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d8fc51sm183317915e9.7.2025.01.14.08.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 08:53:14 -0800 (PST)
Date: Tue, 14 Jan 2025 18:53:12 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Message-ID: <20250114165312.zfsozrtud5wqjn5s@skbuf>
References: <20250114024704.36972-1-Tristram.Ha@microchip.com>
 <20250114160908.les2vsq42ivtrvqe@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114160908.les2vsq42ivtrvqe@skbuf>

On Tue, Jan 14, 2025 at 06:09:08PM +0200, Vladimir Oltean wrote:
> There is way too much that seems unjustifiably complex at this stage,
> including this. I would like to see a v3 using xpcs + the remaining
> required delta for ksz9477, ideally with no internal PHY simulation.
> Then we can go from there.

You might stumble upon this issue on net-next, which you've helped me
remember I should upstream, so I posted 2 patches just now:
https://lore.kernel.org/netdev/20250114164721.2879380-1-vladimir.oltean@nxp.com/

