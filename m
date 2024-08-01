Return-Path: <netdev+bounces-115071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA946945060
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB521C20D3C
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A121A4F03;
	Thu,  1 Aug 2024 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qv1QDul0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCA313B590;
	Thu,  1 Aug 2024 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529053; cv=none; b=bpkSlzfH1THAe1WiI90pFI2mm6zNeeu20qzLHzeTVsFD3tvaWOQ/Iv3hiLcIDI+l9dh+9n6ss5PyHh3W1XsE3DcVGo+Ep6v2wAP7UoAMQX12gGJpqItTbatgsfmgFE2EDbptiF75W1BWMd0CEkjB+lyFYzux7NZaAfOTrYOVIR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529053; c=relaxed/simple;
	bh=w/Lchd6acSPY3kYVpTQ6vee+f1StWE9wgHFpNEC4tv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYiLO1PziOCDcFZCuyFzbwdLskJeikAH0a+hsdTL13KY0Zvf4IcWZlBpqohWgbZLhxIeZluutWv2HzV6hVFfCjKZsncOS/l1+tfe3huEX9jO6Fahd2T+6hlFza2CxOqyhtpOEg/MdDh7aqBGc3s2Pr/JgfGstC2JtqQM2Mdsszs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qv1QDul0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4280bca3960so48054475e9.3;
        Thu, 01 Aug 2024 09:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722529050; x=1723133850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wQTuU6qR13EFs2NHQ6BL0OXr6g/v/sER4c6CH9DF12Q=;
        b=Qv1QDul0A6zL+wXXEypQrDuEeQgrUgvGQnMlhjmgMX/wqAgMrhIY5j5JWwPLmaoKD5
         FV4Ky9Cm7OV5RKuQes03Yvfhm82WhghTl7oF4LiQP3HNo+Q89i2hzC/HzYoKf+bNjljx
         HVu33lR9jvQjIAcUJpPNU5TZ/zv0ElI/wmd9j8XAW3ZrZrV3ZMrxre6IbByUEUgpUbGw
         dW4dg5TAhmugioTDlzt/14iPcGQvgN7DxwSBeZjN5KzlPphvtX7n1vdBlUj6hnHyxghj
         iWMLmue1Y//JYtNk8QyW+GtDk151ZOTqElPwhBoj8vrTQI9D+KE5gflFyD15TroZbPe4
         ftbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722529050; x=1723133850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQTuU6qR13EFs2NHQ6BL0OXr6g/v/sER4c6CH9DF12Q=;
        b=Q4uVoDgjNiGYdsyiKzBbw9+SsWsu59eQzGofeiMBiPj1CsQYq4Pa5jwm5Lhi4bMaza
         kTS6gKxz9Nhdd09ceduXBpx5mYe+HeVhe4WpDxbSuGu4ZZsfW7QTMVGovqd7bwHZwX8A
         UIjj4f9jZmpf5HC7U38XePIhrgvtaHWlBkuyHbRWM9OtvrpCTK3KxYjiEbKXJDomPHfT
         SCxxhVET8g4WtOUFnrm4qZMlv2l5cLjktAVgdarEfWdegDzf74waHvDD48NWc2KZ/gIy
         mqF/dp0KsyC8hgu8fhKCZ7V71IKAI86W9YeSmXpw/9q1zxgjaJ0u7rKL/IqPFlT8OYna
         dvAA==
X-Forwarded-Encrypted: i=1; AJvYcCUdW81aSBTgJSEDMmX4JNqKBGUVS6ZFCkdiiWyn62LF6xgc/Wh2QFJVPJDw38y3F95D6uPalEknBy4MNVH8T1N1YBL5HbzbgXdLhFiyhbAp6F2uh95669ggthrfIOtSLfrxjmxV
X-Gm-Message-State: AOJu0Yzx+yn72N7cZTJL11jac0n3JiF5XFDuKICr7U92y6zpHe/RVeZe
	ZjgZ5vpFz7E5kqA9TEohTwholSEHaFt3ylgi2qg4j3/ryzIvwgFq
X-Google-Smtp-Source: AGHT+IGuLHUEFnctKFyPwjPEKmH5d3EB5yKodwzaywc+e/ly12Fwykc2aBaSwkWpDaN1Zd26GPaDsw==
X-Received: by 2002:a05:600c:524f:b0:428:14b6:ce32 with SMTP id 5b1f17b1804b1-428e6aefb96mr3406355e9.9.1722529050114;
        Thu, 01 Aug 2024 09:17:30 -0700 (PDT)
Received: from skbuf ([188.25.135.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6d6b935sm2036285e9.6.2024.08.01.09.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:17:29 -0700 (PDT)
Date: Thu, 1 Aug 2024 19:17:26 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1 0/5] net: stmmac: FPE via ethtool + tc
Message-ID: <20240801161726.mhyv6af43ync7q56@skbuf>
References: <cover.1722421644.git.0x1207@gmail.com>
 <20240801160224.4f54tanxs5dz5hwq@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801160224.4f54tanxs5dz5hwq@skbuf>

On Thu, Aug 01, 2024 at 07:02:24PM +0300, Vladimir Oltean wrote:
> Hi Furong,
> 
> On Wed, Jul 31, 2024 at 06:43:11PM +0800, Furong Xu wrote:
> > Move the Frame Preemption(FPE) over to the new standard API which uses
> > ethtool-mm/tc-mqprio/tc-taprio.
> 
> Thanks for working on this! I will review it soon.
> 
> On the DWMAC 5.10a that you've tested, were other patches also necessary?
> What is the status of the kselftest? Does it pass? Can you post its
> output as part of the cover letter?

Can you additionally test FPE across a suspend/resume cycle, in 2 cases:
- FPE was enabled before suspend, make sure it runs again automatically
  after resume, and that there are no deadlock issues (to be confirmed
  with CONFIG_PROVE_LOCKING)
- FPE was disabled before suspend, make sure it can be enabled successfully
  after resume

