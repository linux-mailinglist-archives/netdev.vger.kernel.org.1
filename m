Return-Path: <netdev+bounces-106480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0F4916924
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094A628A0BC
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 13:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B385A15ADBB;
	Tue, 25 Jun 2024 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2UPltvg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B67158A00
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322768; cv=none; b=cIFknNJ5yX2NavJOJ1ikcY0g4v0dLv5iXAY0I4eb4lAM86woWYg34zOoCBjifiwq+VcmZWS3eNBLruz3FI23qGQnOI8ndYRlbcdgpHQ4jA+byW5cfeBVBbnmmDMDqiUVgh6WWBGpWTMhpFDq+dKbbHq+CiMQfL45zxdgatvEJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322768; c=relaxed/simple;
	bh=Ygy7YvjL/YBrd4ZfHOfOhiX1Ps72Uoqv9OJUVkcv8dE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lVgzTelaozwIn3DMI/0mxmB+Sub9/KjDFqV871WDYEA+crQQ3zS+XLwHpHD2CpSdLNY2RlLl6qHw1yUNvkaeDUBdCyBbvJcWlHI64ndI5Wd0cij5iAsaboionmP/EtGsuHEdwlDx5giW0MK+WkgtAyB72Bu247Ve2QUzQ6SY/Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2UPltvg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-424798859dfso46211155e9.0
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 06:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719322765; x=1719927565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmARxAwbTgARa8YGilJiFQri9wlZJovYq5pB5v08REw=;
        b=A2UPltvgTx4CM0VIOcZkpICKO12bJKe7m8GRqbo1zENWn6l+3tIsp2z7QQTflEYnZ+
         Vobmr7AGdFzelMfcIxLgD7AivvulOqZrtrJqxWfZuW50whFgVJaSeCOdrjNl6abJIJaH
         DyZk0oZPZVdyw1giW8ciZ/d/hXT0yvvxE0C0Tv4k51eoHEH+Bg43SP8WlX2wiyNSZsZa
         n7WDxMjkUHHt4JHKB5wYJZ4CNLToDuHMWvPet6cbMhnG+EFWaQvBALSspY7Zid7taaff
         FI5o8Qpj9mI65Qf4HA6fxY5Zsx/0bj3Qwh2HCPIFvsTAI9+FzxFIgCdiOTAkfllFt9AW
         dZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719322765; x=1719927565;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmARxAwbTgARa8YGilJiFQri9wlZJovYq5pB5v08REw=;
        b=UPzmpTuxcvhV0CK/dolKt5XxgoeU+aniaiia7xVER7sOvHmijbakzGS/X/I6nZdIFe
         f959BHQsImtgkwNRSaWt1RDWW3yB/rILlgjx7/0qM24Oo7vHNDglLyvpRJDz49287k7V
         ux5i2G634clJN99nzFfxCRFe52yt3AoTANfOlmObU0SRlw2kQ3suSllQzixxgx680cju
         0QBtOcLc4URUj4stO92aTcZ0WtqxaOp9xzapT5U90I0F2QnSd3M1Gj3zZ3VsN5DqJ3WW
         Ix3jRU43T2fvQi4IwTvWMR5GVLwS+MVw+PatQrqIIBm9mFFbqFye7w8jdlb7Z07RAAet
         OimA==
X-Forwarded-Encrypted: i=1; AJvYcCUB4pJ5bBi1sLU9VhwyDtRJHnH1xjhMJDm0AYa5VhjcEPJaScPt/fFG9jDijbq6N1LTOQRLRv9nYNIABBw+REIFFFboysC+
X-Gm-Message-State: AOJu0YxNvKLXjhdO36QhkLchS+kBwr5noVjeCTt0mopVb7fZyNhb/IyD
	VayN2qc39plPfbXKxDfaY8oFP5KQrmGlJ1ldJBbMAVzOtv1/CxWQ
X-Google-Smtp-Source: AGHT+IFZCd9NuNMhcrbxqmv5d0QKgA+Krlbj5xF24O/n0nDJm908AC2Ong4dA3rRxcO9GMiqZ5xMXQ==
X-Received: by 2002:a05:600c:4808:b0:421:2a43:6518 with SMTP id 5b1f17b1804b1-4248cc66934mr44579565e9.33.1719322765100;
        Tue, 25 Jun 2024 06:39:25 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7bdfsm12962931f8f.102.2024.06.25.06.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 06:39:24 -0700 (PDT)
Subject: Re: [PATCH v6 net-next 3/9] net: ethtool: record custom RSS contexts
 in the XArray
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, edward.cree@amd.com
Cc: linux-net-drivers@amd.com, netdev@vger.kernel.org,
 habetsm.xilinx@gmail.com, sudheer.mogilappagari@intel.com,
 jdamato@fastly.com, mw@semihalf.com, linux@armlinux.org.uk,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, saeedm@nvidia.com, leon@kernel.org,
 jacob.e.keller@intel.com, andrew@lunn.ch, ahmed.zaki@intel.com,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com, pabeni@redhat.com
References: <cover.1718862049.git.ecree.xilinx@gmail.com>
 <e5b4739cd6b2d3324b5c639fa9006f94fc03c255.1718862050.git.ecree.xilinx@gmail.com>
 <ca867437-1533-49d6-a25b-6058e2ee0635@intel.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <5ac63907-1982-0511-0121-194f09d9f30a@gmail.com>
Date: Tue, 25 Jun 2024 14:39:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ca867437-1533-49d6-a25b-6058e2ee0635@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 20/06/2024 07:32, Przemek Kitszel wrote:
> On 6/20/24 07:47, edward.cree@amd.com wrote:
>> +    return struct_size((struct ethtool_rxfh_context *)0, data, flex_len);
> 
> struct_size_t

Yup, will do, thanks for the suggestion.
Don't think that existed yet when I wrote v1 :-D

>> +    /* Update rss_ctx tracking */
>> +    if (create) {
>> +        /* Ideally this should happen before calling the driver,
>> +         * so that we can fail more cleanly; but we don't have the
>> +         * context ID until the driver picks it, so we have to
>> +         * wait until after.
>> +         */
>> +        if (WARN_ON(xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context))) {
>> +            /* context ID reused, our tracking is screwed */
> 
> why no error code set?

Because at this point the driver *has* created the context, it's
 in the hardware.  If we wanted to return failure we'd have to
 call the driver again to delete it, and that would still leave
 an ugly case where that call fails.

> 
>> +            kfree(ctx);
>> +            goto out;
>> +        }
>> +        /* Allocate the exact ID the driver gave us */
>> +        if (xa_is_err(xa_store(&dev->ethtool->rss_ctx, rxfh.rss_context,
>> +                       ctx, GFP_KERNEL))) {
> 
> this is racy - assuming it is possible that context was set by other
> means (otherwisce you would not xa_load() a few lines above) -
> a concurrent writer could have done this just after you xa_load() call.

I don't expect a concurrent writer - this is all under RTNL.
The xa_load() is there in case we create two contexts
 consecutively and the driver gives us the same ID both times.

> so, instead of xa_load() + xa_store() just use xa_insert()

The reason for splitting it up is for the WARN_ON on the
 xa_load().  I guess with xa_insert() it would have to be
 WARN_ON(xa_insert() == -EBUSY)?

> anyway I feel the pain of trying to support both driver-selected IDs
> and your own

