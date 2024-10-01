Return-Path: <netdev+bounces-130784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D5598B859
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94401B22DA6
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B4F19E7C8;
	Tue,  1 Oct 2024 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fyM34THt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A567C19D8B3
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775011; cv=none; b=nmwnJ0A68urMOCs12qPN6Bk/j1eJGizEqWaOgfD7ob1/HSrip+kxepTJx8juRFeJXELPGWRw6NOlVzcSYU06+koN2ZbkV9xtkgJrpmsCx9GWEgC/AbZ4bJhtMjOojorPEFvM9ahgE481lP8CjncYA9s3/Y4O2WWh4ySw5W5TetU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775011; c=relaxed/simple;
	bh=zUdt3Y3iP7rYP0vvrA+vU/N/qU+YuF1X1kDjHOS4VYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SyURoWgs9+EiL0XViwf1RT3Sp2LHXGeji/rPIERyEiY1qaX95el4sxMoDKo+eL5S3x3g8S/UGVV9NwMWehfNSydRdU4ecyj3uD/7NacP+2ajxWVgWvB6AgS4pxpDpx1eVwfotL9XWwSXYmGvwPcL5yQ5QlrFfs0xpqqdOuYyuck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fyM34THt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727775007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+x1a+GyDQ15EY7q1rmBJO7Brfiu2xmcThN9CzntVvKw=;
	b=fyM34THt/wYrCB8S6qCxF4WawDAcnS7tZLmyuJ2l7sHqVnyHIIqf2/m+szRFHdA1sneKI1
	yHgNHU0ONkEEzKFUE3kgs6kcjUy5X47VDtPi0eWhSHl5tYFyeei3mmivXnYgrtjS5WY9Jz
	Q1UDxoiv2qve/GpNrPcVYdfiLRt4PsI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-jBZgYzU6N6abqq-OEdncRQ-1; Tue, 01 Oct 2024 05:30:06 -0400
X-MC-Unique: jBZgYzU6N6abqq-OEdncRQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb080ab53so40631035e9.0
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 02:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727775005; x=1728379805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+x1a+GyDQ15EY7q1rmBJO7Brfiu2xmcThN9CzntVvKw=;
        b=a0RYIYwBQFTKce8bkpPD9vXSjPQxHSIWKQ+4HMawKnHSoBU3M1OZ6pPdiOEEmvpFfT
         uKxvkIJCC9nucoScPJFmo4bOsI7CPE9ZjiD9q15U1M3bzQa1vhL7bCETcJp16ELpZi46
         sKTJK+04jfx6fAU/mR1uej1ErByXfMAIpvN6JsDgaTrUHyR4cCiu3thPiBG9KHWD9MSL
         VPTGZEx0r590baMHWHfJfzLhpcoJw2ZgGQKgbkK0m44yoz9EEcjPjN+xOfap6zfFKmb7
         c1bYPiuVZAmAdEht5kGnCmcbBeE3SOCQN/LY2QOOk8UDWcu12fdzDrswEZkq3NDXfhn2
         O1yA==
X-Forwarded-Encrypted: i=1; AJvYcCUe91BOc9GaeuOkD7KXvAsNAcaCbHNY1E7ovpM9S9k4Szl+1DXicnRwqSxKYcZ3xcPF4e9WUKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6lVNbUkkq75t6I5CDWYr3bPs6Nj45dTeGtAuduxJROugZNNYv
	ZFnmXLrZEblbmGDKbnScbMD73sb1093xXvvFixA/OK5XzmyuIbdPop7RMoi59PrJHMwDEEnBRmi
	sjsspMhbSxJQD/n4l454US99B2ZMg2FQgwD+x7OGTPfwl6smztCN1UA==
X-Received: by 2002:a5d:414e:0:b0:37c:d20e:37c with SMTP id ffacd0b85a97d-37cd5aec5dbmr8713044f8f.36.1727775005378;
        Tue, 01 Oct 2024 02:30:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwbiZsH84hyENEzuORxWsK74YrRF3pjgnznljoAbtEaBi2LBM3rD+RHdsw3d41YOD2xBg1Cg==
X-Received: by 2002:a5d:414e:0:b0:37c:d20e:37c with SMTP id ffacd0b85a97d-37cd5aec5dbmr8713027f8f.36.1727775004950;
        Tue, 01 Oct 2024 02:30:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c? ([2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd565e767sm11367738f8f.38.2024.10.01.02.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 02:30:04 -0700 (PDT)
Message-ID: <cbed8e5a-2dd4-400f-80e4-307d0cef8f70@redhat.com>
Date: Tue, 1 Oct 2024 11:30:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/35] bnxt_en: Reorganize kerneldoc parameter names
To: Julia Lawall <Julia.Lawall@inria.fr>,
 Michael Chan <michael.chan@broadcom.com>
Cc: kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
 <20240930112121.95324-4-Julia.Lawall@inria.fr>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240930112121.95324-4-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/30/24 13:20, Julia Lawall wrote:
> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
> 
> Problems identified using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

As mentioned elsewhere, please split-up the series by sub-system and 
driver, it will make maintainers life easier,

Thanks!

Paolo


