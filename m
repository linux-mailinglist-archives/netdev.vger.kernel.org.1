Return-Path: <netdev+bounces-141958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8BC9BCC7F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B575EB23457
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF891D5145;
	Tue,  5 Nov 2024 12:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1PJrv7e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9A61CEAD3
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730808917; cv=none; b=Ft3BmnJ0alFKq8uJhYh4SCP19CUv2J71e2gjlnfnAO3fT81wbQ+nvsuHRxauIchdllwiOuVKB4vxS0W7PCa1PLmQW2eh/xhe9cuasfFgwxZm43XPkfPd1ZMWwiQp3Zt8MRU7t9FLaeoKHfFefA+5Hz+haac7qE3lOiUuLiESrEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730808917; c=relaxed/simple;
	bh=6SOWALvb/rmcnknrQKAEU4o3rVJRfUQk/xpDgjFQ6uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFZ+XWzE4UhRb3IF+W96XQ+KEHpMdinoKkGSGhcJ+C+hPI9+QDwXJBnY2XRT62gslWHxCAO2bQfrbtmMeOX8dU+2gLjTrKfuEDxlJFBJ0A3LobzGwbeJJ5pYv+3xZH9KFGzf/PkH4Jwv1YlZFDOH6GGrFptYbkVtDz9VcpqRBjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h1PJrv7e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730808913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wWGHnib2xNRsQbzTbd5SqdXSSG2cKuA6kf9pCmuI9a4=;
	b=h1PJrv7eEO7S9JTzQAcueHc0zuYUB661dlmy8vuUaCuQD/xy3C/rKSwE+TpSNBSJAEGvBJ
	6BcQfmb+RfSjb4E+pOi0/EhdEK5TtsypsVcDTrw+4/dUTGYNbbs3ILFXHksgYLnIkx+ryf
	RZDvK+Ds/w9VoIGqoU8Fh//IBjypHB8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-SJdDL2q3Om2PS-S9VLONgA-1; Tue, 05 Nov 2024 07:15:12 -0500
X-MC-Unique: SJdDL2q3Om2PS-S9VLONgA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d45de8bbfso3732146f8f.3
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 04:15:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730808911; x=1731413711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wWGHnib2xNRsQbzTbd5SqdXSSG2cKuA6kf9pCmuI9a4=;
        b=IGzoZvDdom/fcRbep4NWw4ZN2HjkWILIBnuWhimfOTqoVxDc/KLW35URGvBAE5AkWe
         xbFHdgasEGs7tECbaVnKGfLYjXGbTanvTaoZXXj2Jpbr0D6XIzMRHPSTlpigf6LZI5/C
         7I/GqNwn8jN9cYCRgHXya/DgzxuZgqrpkjyCdJNtIJXPEPqfB0NiuPfZSnttzY5xZmWq
         qatGJh65d0sl3ocRf8iQ5UQhP/4m32Noo31v25H23ZLPIwOq8Atddda1NnoDxACR2ICT
         fDJQIRXK5R0avRcv6oXjdIx/Q98EzhxHRIcQS7s7Z6CdXJ6/W9j1LUHDTocqiFFLqQeg
         aL+A==
X-Forwarded-Encrypted: i=1; AJvYcCUCTMus43wH3BMLc+0XHO6Ob6l2PxU+Z79+r6tBcStGJQ4yIV/wecvDJDbVf+gBsQjo8+WNAm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6PeiKHfxUbeO1dSm4CYdrd/i7QjpZmXoEQNwFBVoBRtlYMxLE
	FcAWckEBLSiztbM+9GXjwFKybtZMkBoC5LPahmA7nHLhHXsk9P42GA6/o/4YFzPLIuionBNRTkk
	1U1xQP1Wk+8wPrA2fi5/xhwnS6y96kzMM2Sq50uXGq96xyLCswtxrBw==
X-Received: by 2002:a05:6000:1566:b0:37d:43d4:88b7 with SMTP id ffacd0b85a97d-381c7a46499mr15231860f8f.3.1730808911508;
        Tue, 05 Nov 2024 04:15:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjIhzzWnjBB1LTytDQ/IYggoKk7/3RofeXVHVpLfnqnMaMrg4QqjZP07vh28lKzyB7j6D9ng==
X-Received: by 2002:a05:6000:1566:b0:37d:43d4:88b7 with SMTP id ffacd0b85a97d-381c7a46499mr15231837f8f.3.1730808911120;
        Tue, 05 Nov 2024 04:15:11 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e734csm16003501f8f.60.2024.11.05.04.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 04:15:10 -0800 (PST)
Message-ID: <be9b4290-1927-4353-8a15-bffe84769d23@redhat.com>
Date: Tue, 5 Nov 2024 13:15:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] enable port after switch
To: chengyechun <chengyechun1@huawei.com>, netdev@vger.kernel.org,
 j.vosburgh@gmail.com, andy@greyhouse.net
Cc: vfalico@gmail.com
References: <20241031023408.31008-1-chengyechun1@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241031023408.31008-1-chengyechun1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/24 03:34, chengyechun wrote:
> After switching the best aggregator,
> change the backup value of the corresponding slave node to 0
> 
> Signed-off-by: chengyechun <chengyechun1@huawei.com>
> 
> ---
>  drivers/net/bonding/bond_3ad.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> index b19e0e41b..b07e42950 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -1830,6 +1830,8 @@ static void ad_agg_selection_logic(struct aggregator *agg,
>                                 __disable_port(port);
>                         }
>                 }
> +               port = best->lag_ports;
> +               __enable_port(port);
>                 /* Slave array needs update. */
>                 *update_slave_arr = true;
>         }

The above has several issues:
- does not apply
- does not include the target tree in the subj prefix ('net-next')
- the commit message does not describe why such thing should be needed
- Only the first port in the best lag group is enabled instead of all of
them, as done a few lines later - but only if there is an active partner.

Thanks,

Paolo


