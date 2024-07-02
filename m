Return-Path: <netdev+bounces-108555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1748C924349
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 18:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD648286D64
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 16:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD1A1BD032;
	Tue,  2 Jul 2024 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lc62SOFE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6BD148825;
	Tue,  2 Jul 2024 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936540; cv=none; b=u4cm+vZwU1OLxRKpM2NUWhUJrGBtitcBKzWaOkW2N3ixSqePGaJ6NHL9XGyCH+fPmrT0hDN59kpcC8b+beEIlolEy/TSPzVV6gfdkp/l5uZvechJXZmWieBTfcRfosbbxHaCkordTmk2+bWKRyMQg70G/YsdiG4Z8sN38e1rCD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936540; c=relaxed/simple;
	bh=xlcPS1jnTtNgexDDW/DTDoMLyO1sLfSFiwE097gAjqQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=D5H29VT7DOASlsSzq7HJCRyDID6FmLoiRP9e2PZG4DZmRlTdB8A+9qszSSpjTIA8EnM5HS7BVl1dab5Hn5fiyUAYfzYDr3EpxOCtwzTWkddJaD8nnPbMSNbk4+YDHc7JtMaLrNJhzJhXpWfTPld86YYvwauUruNdAvR1hgdKd68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lc62SOFE; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6fe81a5838so424558566b.3;
        Tue, 02 Jul 2024 09:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719936537; x=1720541337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlcPS1jnTtNgexDDW/DTDoMLyO1sLfSFiwE097gAjqQ=;
        b=Lc62SOFEdNihkCz2bZ2tcktDGDOxCxrUkerXu1CFJovMdSfFXUv1VUriLtrWb+vHqF
         5vGswm+y8EYYeFTTPwpKllBE8jT01sX4ucOYNkWr0ISh01kDxkjEQtx4onZ15fgmdF3j
         xm9NSdR+0ylMlLMVS73m1BV830gU0Xts2z+ZBH48Edgw4mk8gRl6hEFiymiTT1CUe7uO
         tvYZ7Royt+0Emn59EuH23GPoCoExA7b6JuM0bBIZ+Hg2kwksUNwa4qsmMeWYZ3OqaOi6
         pVbT1E3D0bnF+P1w5Z6tOSw+iTS+i/7DwpP+tZyZ/8OPFDdmEKsW49hcfWelOfd4V2XF
         IE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719936537; x=1720541337;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xlcPS1jnTtNgexDDW/DTDoMLyO1sLfSFiwE097gAjqQ=;
        b=CeNz8fzI5chEWjqWKWz8VT5R/nyBQsgqzbyGBV72QL2WrqMH5P1eylvuTGfO2o3Sej
         yTgMrN6cPsyJ9qN5oZJAEILAloLx/UonheQbiYCtUFCIMUCvWdoiZdrVp+nUa5mH1i2D
         rLYI86ABj3AhmKA/c8HYFAseGTDwCeUnj2teyx0RxIiZmqtxKqcZQ7vnw93Oy+iozScM
         om5K1TDzIb9jY72XS9K2hEDzRIxTSIi5guVnBnof9hQN/trgLzpxoLJ7u3G7cqqHUPUv
         uVLMBkW2aIbrlJIjnhM0UncUhE1ZqhwSQjIyHnNC7vIE982FcHsNVVtXN3i22DAxM2T4
         X80g==
X-Forwarded-Encrypted: i=1; AJvYcCWxp0bUA8Awy2W14JpgIHg3PerZS6CHWwzZkU4RI5PLo4QZVWqc5iLYD3RoYdUg9crqdSHu4biTYbWrtyYfx/2dOXpAz8lR+V/do6spbr+UOIrygbZ5geiRtIhJR/I80FaqAitZ
X-Gm-Message-State: AOJu0Yyi6ElOQRgwNgZMeg11eyEjWxG7WzGsY2Qyk1X0+TlfjcRKtOcJ
	DEMMHsgsSqLQdj+4Xm58IH80kcqmxwl6EyFE7GlTSyyrenJBAIb2OejvskaY
X-Google-Smtp-Source: AGHT+IEy4VgezlxefYAVni8scdJcmLyU3H21M53/hOdC651ZbKpQ3CxsaCwq1+FVaAKCUYVhI55+PQ==
X-Received: by 2002:a17:906:594:b0:a6f:e77d:e273 with SMTP id a640c23a62f3a-a75144f6363mr518957366b.51.1719936537163;
        Tue, 02 Jul 2024 09:08:57 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7533357c88sm147473966b.185.2024.07.02.09.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 09:08:56 -0700 (PDT)
Subject: Re: [PATCH net-next 1/5] netdevice: convert private flags > BIT(31)
 to bitfields
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew@lunn.ch>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240625114432.1398320-1-aleksander.lobakin@intel.com>
 <20240625114432.1398320-2-aleksander.lobakin@intel.com>
 <20240626075117.6a250653@kernel.org>
 <e0b66a74-b32b-4e77-a7f7-8fd9c28cb88b@intel.com>
 <20240627125541.3de68e1f@kernel.org>
 <c561738f-e28f-9231-af04-10937fac61da@gmail.com>
 <20240628185947.4e8cec02@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <890eccba-f3c9-4008-99f6-cec86b18f865@gmail.com>
Date: Tue, 2 Jul 2024 17:08:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240628185947.4e8cec02@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 29/06/2024 02:59, Jakub Kicinski wrote:
> Speaking of which a new bit just appeared there, for the SFP module
> flashing. I'm gonna merge your series because it technically doesn't
> impact it, but could you follow up and move that bit to ethtool state?

Sure, can do.

