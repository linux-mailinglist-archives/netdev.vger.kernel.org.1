Return-Path: <netdev+bounces-103195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BA7906DAD
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B07DAB227D2
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A75F146006;
	Thu, 13 Jun 2024 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+8vn000"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAB413D614;
	Thu, 13 Jun 2024 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279940; cv=none; b=VmJCXvCEJXxfiw2xDWRFhdfU0//EDkRa82f0S1BLfU0xkuALWZI057mx0TbV3yGF2Q20ZgSf5WNlAyPoHp1rrGjJ4FPVKEAxxkeXvJBgv1hKsOuxuQFtcEjYzLTPJsW9+UdngexPWp/bGKv98LD1H7L4kChs8FRGODKLS/4+sTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279940; c=relaxed/simple;
	bh=8WZYUofqGNBJTme8Y4hlEJGatZHZJId++XvBDRi53kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xn3q+2Ahu5xVvA+LiO6CURxeshFHIgdsmkWzMseQdFPCUH6J4WBglVFHWNe3/tPIw9QIFBWANNumSGYu8aE3rOVogLUlMJKbbbgqGIrNVvC1DXXen6uobRi+MwO/2+tCwjC/9tAX4Hdwqb9RBaRfgN/meeK+SIp0JYvtzEVKLhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+8vn000; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57c83100cb4so841633a12.1;
        Thu, 13 Jun 2024 04:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718279937; x=1718884737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AHo2/PACREZ++y9XZf47QE0TtTVWYm647o+NEVWiCtQ=;
        b=F+8vn000eaP0wTHl8sKxUmvzBHrDI6e2jJkTdY0ZJA7j3Mgcy6Updo7DsdfxMbR81w
         2o9Z23uNMJ8oWIB/pxYC8hFiKmmNUq3JXsvgi8D3mbOw9nhsSpeC3ghJAI9UzBXPsHzB
         KUCcfXVpfOv6HH29xysX+oa41PqhLLymSs2ELUmmltpbOIjgZPYoFk0IYA/mS4We6kzc
         peTE/c7LL29vm3t/eSB3qEmmB2TJGQpZECBrmPuMhkuhvgZyNqImU877axndioY0Bs3B
         ZAOUpB3EZQwJ4SGpQjXVEpB5XvLYTjf9f0HaX7CFL6YnWephEQ7J1tPzL8LGDx+13jsW
         Q+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279937; x=1718884737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHo2/PACREZ++y9XZf47QE0TtTVWYm647o+NEVWiCtQ=;
        b=PQUCdky30yh5IJSrgK95Q52QON57+ZT2MjMqdSMtCqCFMub7aR4H20unDnHGV+IAX9
         QT/R/ZscLmMij/7pTqL8g7Fvc945irPpV8rSilThERurq+NsQa2t5c7k15JC9H2SzaPF
         C982LKI0k7x4hLiJ9TLO3gZk5/cefmHLhGB1Mygs0tqD0ruQBhgR0k1yuEnJSAnRy42z
         p/hZmbXjHAUg60gMjHd+tuM5WATGFIYxBETKPYAkgnKHCI3V4a7ADqQUK8oqIZiEI8QG
         3J4zvtU1+cMQw0PnmBUdGq5aBDIhqeIRfMF+ikAvuzACvgR4XK1nDQ3KH/qMxECOUbrP
         KARQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY0nwAuGc0HWK4dXbKes7866RX1b+MbW0OLc3mrhjYbJiWT6CbRGPQm/ygyJWr1c6/CPUdIvTva6qyjDYd5jWd7o0chr0xX3nmAGvlvCVBhafHYfWKoIo0N8WxJ2ezRfnD/pVSmFwM4RIsWuEtpOgtMNjAhxrGBIDEiygmDgiKYg==
X-Gm-Message-State: AOJu0YywsDwHtSk3jYAsg1LAY4zPFF5Wku+jL5xhaefc1bLx/n7xU9d7
	M+x2Dy2PqkO/99RoEp1ABWTGh2efFQRTkF7bavOIxnv+r9B1uCV9UypLm4roJLI=
X-Google-Smtp-Source: AGHT+IFljb5W7Hda1Ep6bFX8iK9IkYiLimjo3z9KNGaU35uSzOIGDtZKAyJ6JpMHYHeyhjUIxuXBxQ==
X-Received: by 2002:a50:8d17:0:b0:57c:6861:d72a with SMTP id 4fb4d7f45d1cf-57ca97497e6mr3057158a12.4.1718279936524;
        Thu, 13 Jun 2024 04:58:56 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb741e911sm826392a12.78.2024.06.13.04.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:58:55 -0700 (PDT)
Date: Thu, 13 Jun 2024 14:58:53 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 06/12] net: dsa: lantiq_gswip: do also enable
 or disable cpu port
Message-ID: <20240613115853.r264zoqh5neqhwb3@skbuf>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-7-ms@dev.tdt.de>
 <20240611135434.3180973-7-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611135434.3180973-7-ms@dev.tdt.de>
 <20240611135434.3180973-7-ms@dev.tdt.de>

On Tue, Jun 11, 2024 at 03:54:28PM +0200, Martin Schiller wrote:
> Before commit 74be4babe72f ("net: dsa: do not enable or disable non user
> ports"), gswip_port_enable/disable() were also executed for the cpu port
> in gswip_setup() which disabled the cpu port during initialization.
> 
> Let's restore this by removing the dsa_is_user_port checks. Also, let's
> clean up the gswip_port_enable() function so that we only have to check
> for the cpu port once. The operation reordering done here is safe.
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

