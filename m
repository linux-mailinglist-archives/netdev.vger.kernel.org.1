Return-Path: <netdev+bounces-127342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD4A9751DF
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C1E1C21A33
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 12:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E47185B7A;
	Wed, 11 Sep 2024 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htt+uc7F"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E462176ADE
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057256; cv=none; b=WW6aK56rJXY8wPfO7UW95KR2l2Abf08/qoSuPV41WDorgg5idiZyK5cAC/gEgMyoNMgHqjv91IGeKBLASrqn0rUOruzF7KWsAX2O2K1Uew8wNX8Kxi2Eaxp3TvuprtjdfB5N9gMy2xLBybeWIiXLXmXl0/f/uLdyP87zZXYlqgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057256; c=relaxed/simple;
	bh=+OtcHmKqOaBrLslEHoDVuszHtt0pMfNdMC/JAAqio6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQTJZ//boHNwQv+NiJLTzj3GFWbirfEyvomTSInEaYPKJKHZOwMUsLetGjoJdumYay/LD9cKQCglszIWs/wgph8SpbzIqaSjLXUHUF8SEjTtnt0sjAj7A1jyMe9TBS9qK5zlvI7BtokN6K8MMr9JptIHJaM8cExgPYttmZ6iOpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=htt+uc7F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726057253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3lZx7MOn0cvUlutwjGz/taR5dti/49PxN0KWJf8nvQ=;
	b=htt+uc7FawBknmj+/gAVNMAaOSOMhA65rcwT+vA1p+iYQx+z+Gch/R1+20hzjPkrTyo2mL
	cESKq6w3H9WafGaFuOYfGdagRI1rIt7ZQVBDP4ATsLGpwhILR9TE6hScqaC4e1wQB3TAEf
	HcwNwNoh4rPLM+wEfJPaiN/R3sNTshI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-ECZ_282RP2eTjmRTOki_iQ-1; Wed, 11 Sep 2024 08:20:52 -0400
X-MC-Unique: ECZ_282RP2eTjmRTOki_iQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a870f3a65a0so484399466b.0
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 05:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726057251; x=1726662051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3lZx7MOn0cvUlutwjGz/taR5dti/49PxN0KWJf8nvQ=;
        b=veDGFBStDQjV5ufltySHv8OMs9vdeJEY1hCEKNgvy/s4wuf0Nyn8jMCn/ilTd1oLuw
         kQr7AC+m2NBZij1F9WfIOLtAx1BRpzT5i4N1cR7hyjO3QNLW3UqyAkOVNfBHrmhHcczj
         pU1m6WvAHrzP21o35u3ycaaxwwWs6B9p03GRJuv/iyoZqWCENMInr9GdlWDgrdEHnlPd
         XDR2iVOqw1cmHRY1mNzxayjYJcr0UsBQRjyLM1b3JF160K2MOMf8zPO3L99tnadxPaax
         /KL/IOFxbbRhf8S61o/TQrGRA3BTHm3g/YfAiiR+n6Jt/k4aRlPtad4LeL8681wp3/AB
         hImQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQnt16Bj4bHFSV8Tr6gJoedRjIYalemVVVzJesAI6eiQotDB1fmWWQKEgkkRZYL4NhPb1hgzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5M16ws/lMSqmwQ3VL4oUPobz3zYKFWfYPMdQypmwpOsBtuyt/
	yhGEB6Q4XotXtRhdWWcOBkZxYE7bRSxzjWpD1+pji/6j5opd4qMFyQDLa4otWwvtu4pjZo1DPOf
	EcLpd2L39jRs8FaMK8d/D49OOrsI1dvR78/3+p4s8TTSXS8PBHoXXZw==
X-Received: by 2002:a17:907:c27:b0:a7a:9a78:4b5a with SMTP id a640c23a62f3a-a8ffad9da29mr446884766b.52.1726057250861;
        Wed, 11 Sep 2024 05:20:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEse7/q3fks/g38TDGilxuqdMvvKGvYQPRWSe7VE2frNIQ+csBboiwxRmv/9sL6IOGSSY5V2w==
X-Received: by 2002:a17:907:c27:b0:a7a:9a78:4b5a with SMTP id a640c23a62f3a-a8ffad9da29mr446880566b.52.1726057250314;
        Wed, 11 Sep 2024 05:20:50 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d259c76e2sm605309766b.79.2024.09.11.05.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 05:20:49 -0700 (PDT)
Message-ID: <1d0478b2-efdf-4c1f-bf2c-a5cb2214168c@redhat.com>
Date: Wed, 11 Sep 2024 14:20:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2] platform/olpc: Remove redundant null pointer
 checks in olpc_ec_setup_debugfs()
To: Li Zetao <lizetao1@huawei.com>, mchehab@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, wens@csie.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, heiko@sntech.de,
 yisen.zhuang@huawei.com, salil.mehta@huawei.com, hauke@hauke-m.de,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, wellslutw@gmail.com, radhey.shyam.pandey@amd.com,
 michal.simek@amd.com, ilpo.jarvinen@linux.intel.com, ruanjinjie@huawei.com,
 hverkuil-cisco@xs4all.nl, u.kleine-koenig@pengutronix.de,
 jacky_chou@aspeedtech.com, jacob.e.keller@intel.com
Cc: linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, platform-driver-x86@vger.kernel.org
References: <20240907031009.3591057-1-lizetao1@huawei.com>
 <20240907031009.3591057-2-lizetao1@huawei.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240907031009.3591057-2-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/7/24 5:09 AM, Li Zetao wrote:
> Since the debugfs_create_dir() never returns a null pointer, checking
> the return value for a null pointer is redundant. Since
> debugfs_create_file() can deal with a ERR_PTR() style pointer, drop
> the check.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> ---
> v1 -> v2:
> v1:
> https://lore.kernel.org/all/20240903143714.2004947-1-lizetao1@huawei.com/
> 
>  drivers/platform/olpc/olpc-ec.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
> index 921520475ff6..48e9861bb571 100644
> --- a/drivers/platform/olpc/olpc-ec.c
> +++ b/drivers/platform/olpc/olpc-ec.c
> @@ -332,9 +332,6 @@ static struct dentry *olpc_ec_setup_debugfs(void)
>  	struct dentry *dbgfs_dir;
>  
>  	dbgfs_dir = debugfs_create_dir("olpc-ec", NULL);
> -	if (IS_ERR_OR_NULL(dbgfs_dir))
> -		return NULL;
> -
>  	debugfs_create_file("cmd", 0600, dbgfs_dir, NULL, &ec_dbgfs_ops);
>  
>  	return dbgfs_dir;


