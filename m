Return-Path: <netdev+bounces-118021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A69950440
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB097284140
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C0A199238;
	Tue, 13 Aug 2024 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJ/A96wu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995671990C7
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550137; cv=none; b=D5OfZ5xCuJEGtQU53jsZsvEByazrpzGGFHp5XMgEJZCY2xmer6jOHIHSTSc9Fqeb57lmvcjbhwg6R37Snj5z6PXz16yzQVdlq6TK6k1JD2yMMrMp2ZgWCSQBu7q/jvjHlZsiM03SnOsh4RCOZ0N6GkY4f7SXULBEt/Q2Cbz3brA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550137; c=relaxed/simple;
	bh=QlzDjE/o3zMuSfqzgLKkznLr+avzFRJAw68euwFk6ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvIeEEKTeujJQof2Vd+73NnLJErL+O1gvpJyETviAyPNv4b148S5KejuU3azWfO/nr34BvGgI326C2YHXeo+UCsd6FQpOzUqKKsxTaK5M+c0FtLuvTp4Qp4se39iMlL6m4EStEGbveVtTEbhvmhAuTofLXK2gA0nnXGbUa7MSAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJ/A96wu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723550134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CcAwW+DWgb5evcGozYhDmJmyDSaGzLsQ43TzbBLLLSA=;
	b=YJ/A96wuKEG3GpZlSRxJZBe8IRvJuuvvkdmwsYxkdSAgRMabY+zY/MJtnyajD42QGti5/s
	SvjoWgj8YY9WHI1jnv9VvMa08akv4F5gqpmJvZqhnWU24sK8YCKNqFYA3FFwi07hyr3FoZ
	WuWWW2Oy3RQPFVil5a7ikJq9lpe7f7o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-MOUFEblWPUSqyc7O_-VqGg-1; Tue, 13 Aug 2024 07:55:31 -0400
X-MC-Unique: MOUFEblWPUSqyc7O_-VqGg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42808f5d32aso10329915e9.2
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 04:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723550130; x=1724154930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CcAwW+DWgb5evcGozYhDmJmyDSaGzLsQ43TzbBLLLSA=;
        b=GzMabfbvGroLEdZX9LnHi24iq19Rwg4DJnqNGSvR01dN0MeeOAttT3KMAXb0WKDhSN
         9WX7Eu5E6yHHOm8uIzE40KrHQg5bLrYY++jEU6D2S2nbCDb0oKJ0/TMgpxm+drxsrc8x
         zXHPizPoDE9vCBk/4p3G4RJ1GRDAQQsbRRH3zSbeTYR57eUmf2owlJvJVkLACVXqcyjE
         r1ST0K7ndbL1ScvVe1caS6WVte/FaKYrnPunCFgSFmUMy+6Q69l7ze4U4NRWkQLE0TST
         jNOfVYOWj034GubqTKlDQcG7SUHHMaOtK9ycWUaptQbZCz93SCZm1bpobHI/0b+hGfWS
         XGyg==
X-Forwarded-Encrypted: i=1; AJvYcCWXiOAKnt8UT255uk2c5XfTjGfULkVEGpCMs+gKqG0+7MOC48Uz8i8f1vo658S78z4lMIm+Y0lWDpnGmiB6ZFTFfnB8Ch7i
X-Gm-Message-State: AOJu0YyFcjacpZ7gOeoFrORvt24iChRXw9g5sgRS22e5S0MOn+RUxMII
	UfkpznYgewrdSwAuGxK62gxaQOK3inWABrpOJTHDSmXrIzmMqUGcOpfneN3mXXyEzFrFnc7WQ9M
	8G4BSIiiJSDqL4SZqvee2bNZyR30+XOA1URKzpc08scY+UVaUbX3KKA==
X-Received: by 2002:a05:600c:4f07:b0:426:6ea6:383d with SMTP id 5b1f17b1804b1-429d75baf27mr9580215e9.2.1723550130040;
        Tue, 13 Aug 2024 04:55:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPVpHO+FtXGY3k00qcP/2M/n0q5DTM2+8EAw0FeDSo7/9C3Rec23QDJYX4wCY7iZPXN7Lffw==
X-Received: by 2002:a05:600c:4f07:b0:426:6ea6:383d with SMTP id 5b1f17b1804b1-429d75baf27mr9580095e9.2.1723550129555;
        Tue, 13 Aug 2024 04:55:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1708:9110:151e:7458:b92f:3067? ([2a0d:3344:1708:9110:151e:7458:b92f:3067])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c74ff9fsm224378415e9.28.2024.08.13.04.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 04:55:29 -0700 (PDT)
Message-ID: <6185be94-65b9-466d-ad1a-bded0e4f8356@redhat.com>
Date: Tue, 13 Aug 2024 13:55:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: netconsole: Populate dynamic entry even if
 netpoll fails
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com
Cc: thepacketgeek@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Aijay Adams <aijay@meta.com>
References: <20240809161935.3129104-1-leitao@debian.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240809161935.3129104-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 18:19, Breno Leitao wrote:> @@ -1304,8 +1308,6 @@ static int 
__init init_netconsole(void)
>   		while ((target_config = strsep(&input, ";"))) {
>   			nt = alloc_param_target(target_config, count);
>   			if (IS_ERR(nt)) {
> -				if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC))
> -					continue;
>   				err = PTR_ERR(nt);
>   				goto fail;
>   			}

AFAICS the above introduces a behavior change: if 
CONFIG_NETCONSOLE_DYNAMIC is enabled, and the options parsing fails for 
any targets in the command line, all the targets will be removed.

I think the old behavior is preferable - just skip the targets with 
wrong options.

Side note: I think the error paths in __netpoll_setup() assume the 
struct netpoll will be freed in case of error, e.g. the device refcount 
is released but np->dev is not cleared, I fear we could hit a reference 
underflow on <setup error>, <disable>

Paolo


