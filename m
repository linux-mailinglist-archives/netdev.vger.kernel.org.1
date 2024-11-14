Return-Path: <netdev+bounces-144974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FDD9C8EAF
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC13281A1C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BCD187347;
	Thu, 14 Nov 2024 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KrT4PnQx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02F013CFA8
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598972; cv=none; b=UvdUS4tNNzwmHmhC+YjrMuo7Ugy5bW1UyxMFQ2xL9XHMlRJhYZ5lDqMB41wjHhPuCKr7FomZLukYv3U0GMfUQS7A4yaRK9cFQjqIsqgOaT6vz48RBXFXo1KuMJQtCld7KNeEUaD4rnpxCEzswZpxd5vZf7O8sfhZyzOED7nDqNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598972; c=relaxed/simple;
	bh=5lKBuQID5A6V/TtMNiFrE0dY9fXYPxM6odgRZVO7MTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVd+mMyp+bE5h2nuujkIHAUSOGjsk03GUfNExe4AuO0OCmeyzBEXD5pZdE+3YzxHurQek5CxkONoImXQAFqZzFYZqACEyU9ZjOjG8TwbCSc+V7b0xwwxPOAqLOszoEVZq9I9TEuHf+Os0iL+QwCUvyd6RM8Yx10Mzg9PCA6RJX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KrT4PnQx; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38221306992so245741f8f.3
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 07:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731598969; x=1732203769; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KX2+fSGUfmeU6/csaLeMCbckFU11xR4X8/Q/gUEL7bI=;
        b=KrT4PnQxoDYvO1FRefk8ODtVOUxQ7ZbFskSH+D2in0nNXs+ZM+MtbiqyT8K1PGBy60
         gmI1AKFwhC+o2KYldz/JTLzgtPqMVXHF0RvOd8hZurBhamyebjwVeKqT00+6VT5Wwu65
         0qFg/bYjbgAaZjlOTWR2PXzQsijT64gY0cKpq0tPErGyu+an2t6foEwmKMv6LJK85Dmd
         doBsrTIXFlxTHINLeCEQgPRWBz3bjEobcQxT60Jt4fB3spsEhG+HlgohZRn48uRYux4V
         /QLl07+UOmTvWa/Tr541buEpS3HsotG9Gau4Oo+zbAm0YC94nV3krLJPGbhlRPnn+S40
         Jd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598969; x=1732203769;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KX2+fSGUfmeU6/csaLeMCbckFU11xR4X8/Q/gUEL7bI=;
        b=gLGKEwIeQpab+B26EbCJ4GM8DGSZVhgaaCMv4fPiMnz6vVb3uWujaUQFiu/5MEu+Mj
         L/7zcpOVxePZqd761JeABE7Ez85FhWK4Do+gWhPFkDB/DkJhos4XACrMDWdZptefpckQ
         PmB64v4iXPJgfFASxw9mVo9dyd8Anv+hT7K9+OpEYFMXj7PUbJT64uEeTGafw+D3zyON
         u+XsgRL6T/2NRl59CVVZjiazV7DIKeEWBexTTAR+ISbyexFsMzT6c2W0+V5ZRrPGlMPU
         4iWnpMDrQsrg1c4AoD10DMDkDX18NE1m50dm3emXYhWC1JQiwD2o5ycAPPqqt9XqGHQ8
         npNw==
X-Forwarded-Encrypted: i=1; AJvYcCV4aBXMBx6ukU6qqNET70uW4dnVbJsNZWnM7LzUjsVVceYe54G4U0K1S06I2J9yerdUAv3dQM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+wYuUqP47dm5iwgFDl7tV2uVBQ0q/BEKOGyNL82lmEvjVLyAk
	9BL+tjPJciXf9VydNrr2yAjw+gJxqVVDHRfSWbGTdVmR0IZfprgKxPeDCEtKeGo=
X-Google-Smtp-Source: AGHT+IFinWny9gPHiwjHi0Xnjp+VmawkDv8LOfWqaLaGRLkw5Fwzg9gT4mhRC/81ZoQXRB3xpi7PiA==
X-Received: by 2002:a5d:5f92:0:b0:378:89d8:8242 with SMTP id ffacd0b85a97d-3821851c3d0mr2406983f8f.26.1731598968872;
        Thu, 14 Nov 2024 07:42:48 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382200fe00esm1093677f8f.42.2024.11.14.07.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:42:48 -0800 (PST)
Date: Thu, 14 Nov 2024 18:42:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Max Staudt <max@enpas.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] can: can327: fix snprintf() limit in
 can327_handle_prompt()
Message-ID: <e5572514-83d7-4b7e-b4f0-5318c6722250@stanley.mountain>
References: <c896ba5d-7147-4978-9e25-86cfd88ff9dc@stanley.mountain>
 <6db4d783-6db2-4b86-887c-3c95d6763774@wanadoo.fr>
 <4ff913b9-93b3-4636-b0f6-6e874f813d2f@stanley.mountain>
 <9d6837c1-6fd1-4cc6-8315-c1ede8f20add@wanadoo.fr>
 <20241114-olive-petrel-of-culture-5ae519-mkl@pengutronix.de>
 <7841268c-c8dc-4db9-b2dd-c2c5fc366022@wanadoo.fr>
 <0c4ebaf0-a6c5-4852-939b-e7ac135f6f32@stanley.mountain>
 <7d4b176b-6b44-450b-ab2d-847e5199d1b9@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d4b176b-6b44-450b-ab2d-847e5199d1b9@wanadoo.fr>

On Fri, Nov 15, 2024 at 12:24:17AM +0900, Vincent Mailhol wrote:
> On 15/11/2024 at 00:08, Dan Carpenter wrote:
> > I'm happy to re-write the commit message.  Changing snprintf to sprintf() makes
> > me so much less happy...
> 
> OK. Let me amend my previous message. I kind of understood from the past
> exchanges that Max will take the ownership of this patch and credit you
> a with a Reported-by: tag.
> 
> If you keep the ownership of the patch, then that's a different story :)
> 
> I do not want to make you sad and I am fine with your preferred approach.

Then I can just resend this tomorrow.

regards,
dan carpenter


