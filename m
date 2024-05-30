Return-Path: <netdev+bounces-99414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA208D4CC0
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 15:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5319FB22EF8
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 13:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A4B17C21B;
	Thu, 30 May 2024 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxSJKp4H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0080617C201;
	Thu, 30 May 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717075710; cv=none; b=XZzJaA8GQYkO6hxZ6VLlQmRuDrno4X0ZT9dL9gpbqkr7IKiXMdd2UmjP+AeVod+IjiC+mDTJcZObD38Zroq/RAxXwC8DmzVwnw1tB52OnezMVOGn2CcK+DUeKowmhtNfCNBBZNs0aYCuduDSIMV/yoAuts2SyH6muz50B5D/Eug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717075710; c=relaxed/simple;
	bh=SN+KQQvN1DjuDSNQIMS0RKMVnEHb25UN7zrWuOh5AMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWMjZNZWFoo++QEsc0s6I5ykVXjRDElHUTrJ9FiA4V0yM2z9/qupCyhQC5AZWCU50v+Hf7BOpwquTufefDCWDgXYRmZCr62DY2Yj1G8zAD3DE/wS/TNWhmvNDFqKQNw0HsasA9/7Zt3URLAo6IMU394TeXSOupPnDqe1lDhPo3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxSJKp4H; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e95a883101so11009541fa.3;
        Thu, 30 May 2024 06:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717075707; x=1717680507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IJXB1wPIJB9IUh99ijS9KipVqXbv8x01i+Uwc9/wlh0=;
        b=KxSJKp4HWggGZ8su2LSz2Ud87mqZPEkYAqhg8lRRhxm1oDITbKY76HguXF0sJ4evnT
         VvLr7pYEvJxqQ3l8ESYYZVbYesXk1qaUJfeaM+yT7AfkOHez6myBLuwXAzn9W5jQo5gb
         YVUc2syD0Alv67pQov0cZPMQc3uQCcjw+Hao1j/gIXnLrL4mSj66JZdVWku9Rc41zskG
         tMp3LfN/SQVCjotk2XS4l/Plo6f1E7IeaatMkl7godcRC+qb0mGv3YNklszC0wY8zneh
         BESf3qCyLOO9MfYsJa/ZN3gaLlmE2JCXKbpGmAvc9czWGNd0bVRcmuaXcIiMXclDlvis
         PhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717075707; x=1717680507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJXB1wPIJB9IUh99ijS9KipVqXbv8x01i+Uwc9/wlh0=;
        b=JjKghEGG2MjxXSLWsVNhFh6W+Aw80igB4Rv+4V+exetSGYqNYLAanza4yXQ1F62V8r
         /lgJbaZ+FVlzTwmlC9Brn/TfpBAWOEipLiKdMkd1o8Ct8N/w4YJolPXBq8CNC5IAbqOD
         kRb+mY07Wi3J6zY+LxtCO0qF4sK+p02Ttz6PNCtyjIwdOtLe12rsEIt3DxViLWDxmznM
         AigQP8eI91Sek1bsGmQJWTDXzHRuvxDuky+PbCgNhL+rFAkT8F/3PbHDW7TKOQWaKsmD
         Z+N+kGNORKJV+AbrhQXnJLU1O/aMzHwxjEcGmq+8As63rY0vJHwHDAwtwrIwLmI6jUs/
         Afkw==
X-Forwarded-Encrypted: i=1; AJvYcCV50XC8xbSC3eKzsXpKtUJNR8quiLIyUM0qvNYHcQNX1qjrsw4ncIirBwueK7qHXUd1gvSm7ch5N8qr7pWcLOOiAS9cWcSQ1xTaivk/qLOZlO/kKWtNDclEZd+xphYtRK0NqFPp
X-Gm-Message-State: AOJu0Yz0m6F4E/3z1/I6VhPZnnfVR3Pqr5XjksPmmWGjxNMNDTSECxSP
	hMxEQc3+W4KjzbneK1kt9tez9orGaq/jeP8m3RsGjgCbWtHU2S/Z
X-Google-Smtp-Source: AGHT+IGvOsz1SnMej7/XfLj2txZq8JpOHp8kHZo/N8KHsDxnE8joy9arj1Nc2ImHPzLvxiwmN4tHNQ==
X-Received: by 2002:a2e:9e4c:0:b0:2e0:c689:f8cd with SMTP id 38308e7fff4ca-2ea847b3714mr14910401fa.29.1717075706546;
        Thu, 30 May 2024 06:28:26 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212706c952sm25426715e9.26.2024.05.30.06.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 06:28:25 -0700 (PDT)
Date: Thu, 30 May 2024 16:28:22 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>, Andrew Lunn <andrew@lunn.ch>
Cc: linux@armlinux.org.uk, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net v2 PATCH] net: stmmac: Update CBS parameters when speed
 changes after linking up
Message-ID: <20240530132822.xv23at32wj73hzfj@skbuf>
References: <20240530061453.561708-1-xiaolei.wang@windriver.com>
 <f8b0843f-7900-4ad0-9e70-c16175e893d9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8b0843f-7900-4ad0-9e70-c16175e893d9@lunn.ch>

On Thu, May 30, 2024 at 02:50:52PM +0200, Xiaolei Wang wrote:
> When the port is relinked, if the speed changes, the CBS parameters
> should be updated, so saving the user transmission parameters so
> that idle_slope and send_slope can be recalculated after the speed
> changes after linking up can help reconfigure CBS after the speed
> changes.
> 
> Fixes: 1f705bc61aee ("net: stmmac: Add support for CBS QDISC")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
> v1 -> v2
>  - Update CBS parameters when speed changes

May I ask what is the point of this patch? The bandwidth fraction, as
IEEE 802.1Q defines it, it a function of idleSlope / portTransmitRate,
the latter of which is a runtime variant. If the link speed changes at
runtime, which is entirely possible, I see no alternative than to let
user space figure out that this happened, and decide what to do. This is
a consequence of the fact that the tc-cbs UAPI takes the raw idleSlope
as direct input, rather than something more high level like the desired
bandwidth for the stream itself, which could be dynamically computed by
the kernel.

