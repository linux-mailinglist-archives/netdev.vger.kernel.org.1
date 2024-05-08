Return-Path: <netdev+bounces-94593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7823A8BFF30
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91BD1C21CC2
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9C784A3C;
	Wed,  8 May 2024 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFI04Y7D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEB184FCE
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175862; cv=none; b=QroQ2bZ+bDz4Kdi9igsDUA7Hjee1lA2l9wnEVFbqyrq3BEzZug9P6/VrTK72akPwtatdtF69h2g3ZH5q0LoK8QpCP6+yG6yWzY7bCi2SQfMLEKv02XTGoPJWAV7gXSlG+1Y0i52+b+68R/Rur/xyxIVe8xMlxKNI6BWxeOaXyzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175862; c=relaxed/simple;
	bh=erw5+TilexHHZK8g63T5uV0Aj5QypqRI73uZx0O70/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtwoH7JXcn4edv6maY4c2125BvmJb+5lqokZZHzUDspy4LT3+Pfe4bVjMYv73BbywkTlzdw+vwCS2vmkVyW9adq7N1vlvQ1A4IU8zdjijiNBaB4ZLotO3mVKr+yukdK7b9ynnKaFRbSVjbw/QxDQRkySu/jX2TMacW2OZKKCNU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFI04Y7D; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so954798466b.0
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715175847; x=1715780647; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=erw5+TilexHHZK8g63T5uV0Aj5QypqRI73uZx0O70/M=;
        b=aFI04Y7DvVKWChqMbJLW2mXgi0zEVAn0XjIUZ9ttYzDAjsO460z2F2uFK+EIvkb+uM
         h/fzOX1LyandrM1RK8Q2u1+jP08iD+Atg0a7P2to9oHLe1sOKscA0iHRJv9Mcnv6QV7K
         dWL7FR5WXaxkpM4fJUnTYQHO+pc/g0CEe489jLTZke/RL4g9FHC+NCR8s7WZl3pAQCLq
         6EW6Iu399wATvBJp0wcfrSCvck+urGJju8cfjAvtLu2cNmQV4pH3TwsKsTqQHF0TnJdp
         IUCZ2pSxelefVTbT7PuBs+9BjKV7CvkwEUILUD2Fvns5ufQnr3SPHzfPBMuVgSsGT0wp
         7VVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715175847; x=1715780647;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=erw5+TilexHHZK8g63T5uV0Aj5QypqRI73uZx0O70/M=;
        b=Az+Gtk/Rnb45Hfp0sLpU5U70l58hUJoU2HwWipoX2eWwIdC2KdudV9MlZdQmMOwBIy
         KH0caJxX3xzc5NmZfkchnf3spFifp81IFnP8kCRcjZHZefde1BJWwg+4s7f08h1G7GoS
         eiXvGjmmWg6FesTyak5MxpqZI5RyL6Lc9chZifjaEGULPehAyI4O2gLqQu/skTb/U5pD
         APccbVx8W+hV8TfcRfbRm0ssLjKyXGiR1UPz4B9BEkJRJq7rYl670zNHOVGMVZvhnjta
         Ta5o3suLY8/ibU1Tv+aQ7BRdZBSgxB/pg1Etn99Ek9FQNV/MlXTTMRmAzvT1UA72C29s
         P8kg==
X-Gm-Message-State: AOJu0YwwIDot4XJUu5tPMuh0UaGsdxmPyeM3EirMk3otJaoFs7n/5oSK
	8ixPie1UZ3osdwDpix6/yRHtPEmzcs0plyj59Bu52VDJJVMhEMaiNph88z9A
X-Google-Smtp-Source: AGHT+IHWy5jBUcSYPuDnK5hCdjACECGe+uCMVBDxXQmnCnV27Vrf5oHOXp3Rojt/IlVZo5NIJkKMfg==
X-Received: by 2002:a17:906:5618:b0:a59:c941:e5e5 with SMTP id a640c23a62f3a-a59fb959245mr238935766b.45.1715175846637;
        Wed, 08 May 2024 06:44:06 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id x19-20020a170906135300b00a599e418208sm6067087ejb.9.2024.05.08.06.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 06:44:06 -0700 (PDT)
Date: Wed, 8 May 2024 16:44:03 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: update the unicast MAC address
 when changing conduit
Message-ID: <20240508134403.kr5btyx6iekkxjf7@skbuf>
References: <20240502122922.28139-1-kabel@kernel.org>
 <20240502122922.28139-1-kabel@kernel.org>
 <20240502122922.28139-3-kabel@kernel.org>
 <20240502122922.28139-3-kabel@kernel.org>
 <20240507201827.47suw4fwcjrbungy@skbuf>
 <20240508111328.ya4ydnmd6w764q5k@kandell>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508111328.ya4ydnmd6w764q5k@kandell>

On Wed, May 08, 2024 at 01:13:52PM +0200, Marek Behún wrote:
> I did send this to net-next. The question is whether I should keep the
> Fixes tag.

Well, sorry, I didn't notice that. Yes, please reference the commit in
some other way which does not appear to automated tooling that it fixes
a user visible bug.

