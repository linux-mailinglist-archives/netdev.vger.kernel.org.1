Return-Path: <netdev+bounces-134112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75F399808F
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D961C276A7
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 08:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4522E1A0B0D;
	Thu, 10 Oct 2024 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XdT3OqvN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5907B1E573E
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 08:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549040; cv=none; b=grzgVxiKC3qFgNY54JpDUM2/PVRjVZXgs8USV+FGZLjBgqIesGcs3LBU61zaV9QMspTRnPqdoQzfXgv37UOrKx+usL0g0cy6zKaLktSDqmqIq9Lw9GjzLAdIZc4vxrn/VcPtkgRGUGk7VvzAyzHfZiiX+0OGYBmAi5TWMyvREwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549040; c=relaxed/simple;
	bh=81ZjBvLUwY6eeqLyJYGD5q162fu/lz7B7IRHnVgSMbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZK6T3gYu2OwmAQhzzcMtpRTMAVp40cg8oGRCEEUgwVykgYaI6052PVebpweyS3Jp9TuN9B50FgbnN17vY+uPLYXGY9kFjbLvMomSx7prKFuB7iQIlHposq8YiVJUEnDJO4LsL6pSNdfZz/jSIQJKjBIxvlmF/bocE5c6N0/ophE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XdT3OqvN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728549037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNbzRipITp2ZX+tjoP83fC53vO8P93j48ZH+sfRT9Js=;
	b=XdT3OqvN2G8neZii/tqlb3sWVXeuyaR2bDLYYAml58zBkwtcM0jUGQ4MvG0FGlaDCN27lV
	S5+85Mb2sDwJUsTVxxn4COirGvMDsWkYgh3JwWS8mp69y3yGPSctfF09sUMKv+c1u8Sqnj
	DzBqSs8tqqp/GwA1Ig8EAbKu4DMcKR4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-Q-gbsFaCMXe-dtAxUVtAyA-1; Thu, 10 Oct 2024 04:30:36 -0400
X-MC-Unique: Q-gbsFaCMXe-dtAxUVtAyA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-431159f2864so3151725e9.0
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 01:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728549035; x=1729153835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNbzRipITp2ZX+tjoP83fC53vO8P93j48ZH+sfRT9Js=;
        b=Q5uBAsV2ddxJ7URszrk3EbY+6XWD0S55orINogGeGnH3zaUbPkAfXDEuyJ6v5+Im+V
         YEviNAt+4q1C65+nmuzFAVW6e7qk11k6F3kCHFS109zVcrMnIdicVLFry2dM22GGUch6
         XO7G4Kx+XGxwWmjllXxE35FhFa3IflFyFy4gxUKk5hiwSRFl5pokWhugZofjfRIQuG1Z
         xM5M36JbERSflyydwiJv8Cow9Hio+HOrCMtVRdWBr3Gf0HndT7WAf5G4snA3ulHIcgyG
         YBhJThwGe6zsBqfp8MOk53aLGqWXV7IXWlBWFnGT4hSqbwLTcCu5D46eyVxGyeGnzVgI
         /AHA==
X-Forwarded-Encrypted: i=1; AJvYcCU4wuwZNQ1v8McnfExP6P8lRQRP7xa7neIecRwU8eO3xnnmP4Qzz6zLtfmiQSBhrxA1MA8rPQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0PPyntlC0XHcjfb0kEPOL/HmWQrOdD9jkpg2EIkYWhssGkynC
	UcNM7Fq13tU/nyxBQPGaRNAs7bZwQEGEf/YpL55BfJ0rx4coJZb11SxmgQp7KnoPzeRpw+S8aMi
	FHG0wO9+LarEogYRo1uko3fxubo7b8IWY2nqjJ3JkyeLwv8US9Rgx6Q==
X-Received: by 2002:a05:600c:19d4:b0:430:54a4:5b03 with SMTP id 5b1f17b1804b1-430ccf089fcmr38015285e9.6.1728549034889;
        Thu, 10 Oct 2024 01:30:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeQK3ESd3VwoQDVpFI6ih7FY4v1pI7Ubmg/YooSwZcbyZPfJMPk+upbulnUHJyo4gp+F3rfw==
X-Received: by 2002:a05:600c:19d4:b0:430:54a4:5b03 with SMTP id 5b1f17b1804b1-430ccf089fcmr38015025e9.6.1728549034560;
        Thu, 10 Oct 2024 01:30:34 -0700 (PDT)
Received: from [192.168.88.248] (146-241-27-157.dyn.eolo.it. [146.241.27.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf51c69sm41070265e9.28.2024.10.10.01.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 01:30:34 -0700 (PDT)
Message-ID: <3c2ad895-3546-4269-8e6d-6f187035f4b5@redhat.com>
Date: Thu, 10 Oct 2024 10:30:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/7] net: ip: add drop reasons to input route
To: Menglong Dong <menglong8.dong@gmail.com>, edumazet@google.com,
 kuba@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, dongml2@chinatelecom.cn, bigeasy@linutronix.de,
 toke@redhat.com, idosch@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241007074702.249543-1-dongml2@chinatelecom.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241007074702.249543-1-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/24 09:46, Menglong Dong wrote:
> In this series, we mainly add some skb drop reasons to the input path of
> ip routing.
> 
> The errno from fib_validate_source() is -EINVAL or -EXDEV, and -EXDEV is
> used in ip_rcv_finish_core() to increase the LINUX_MIB_IPRPFILTER. For
> this case, we can check it by
> "drop_reason == SKB_DROP_REASON_IP_RPFILTER" instead. Therefore, we can
> make fib_validate_source() return -reason.
> 
> Meanwhile, we make the following functions return drop reasons too:
> 
>    ip_route_input_mc()
>    ip_mc_validate_source()
>    ip_route_input_slow()
>    ip_route_input_rcu()
>    ip_route_input_noref()
>    ip_route_input()

A few other functions are excluded, so that the ip input path coverage 
is not completed - i.e. ip_route_use_hint(), is that intentional?

In any case does not apply cleanly anymore.

Please answer to the above question and question on patch 1 before 
submitting a new revision. At very least the new revision should include 
a comment explaining the reasoning for the current choice.

Please, include in each patch the detailed changelog after the '---' 
separator.

Thanks,

Paolo


