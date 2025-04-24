Return-Path: <netdev+bounces-185501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32127A9AB5B
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD2B83B0EC2
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB1B205ABB;
	Thu, 24 Apr 2025 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZDGJhD4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F068634F
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745492669; cv=none; b=YFVbOedvJVTFToy6Serj/sHkdi+TSpcfXTAHU9qZc5OFd1oxJb5aPDe2MRSjJwQDqMunDI+eFe/lm3aX2PX4KcQ3CZ7Ko8gZktbs1jnD7ZzjCQxJ5+6ye5qmrzM6s6UYFHNBWKcXlLpp74M6PxRULUMlBlZKVtvKB8qhzV2epWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745492669; c=relaxed/simple;
	bh=2U/DZ98nyb43Zevabrjr+i1gak+2K8H1G+KpXSGgK/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SbXYSQ3DVc0pWbxp2nXs1pJPDxyQo8qFNe3TgSi6UibVYWEucP98EAW/Haat0XyyMWFcWRmo18MHnupL+QZkgffH/sGdoX1STqUmNFxDZjlZLvBp1BDkeWHv1nbsCpLasZLz8yVB1FUxml50vZepmGndtDmXm78m4lWNWv88Jmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aZDGJhD4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745492666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lyu9hNwObLGr+KhrEDmYPVh+6IL5Ud0sbGGYl34RVrU=;
	b=aZDGJhD4KS797PojGlOJkuvFgocIG5jA5LHTwhkhuz/hHtrkN1MZVm6pKQJn327XHsN0BN
	cF9TvhRY1I6QaFXWfSgmUmAwJDd1bM52QdTrcb/oXcip7G6G3gpUdNg0yXbo+GJd1cO5RA
	5VdfQPpJhrTqfPxqwxDsHZL3BoyF+cY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-YzPxQ9q9Omaibo9HFBFiEA-1; Thu, 24 Apr 2025 07:04:25 -0400
X-MC-Unique: YzPxQ9q9Omaibo9HFBFiEA-1
X-Mimecast-MFC-AGG-ID: YzPxQ9q9Omaibo9HFBFiEA_1745492664
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912b54611dso431202f8f.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 04:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745492664; x=1746097464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lyu9hNwObLGr+KhrEDmYPVh+6IL5Ud0sbGGYl34RVrU=;
        b=LuLC2btLRt4PV/2lFOoOJpsWbf9veJZbvtzalEoXsNzgRzUij0i1fkAhjpk/DbHAtN
         M5GFLYtl3U8aQjPxlsy/SoXEdvBK8s9zZpKYidQJHptUfN3g0JwOCPqqQQywFkSVGs11
         LAse+CLv2aDXbBlveN0q+l1ANJxA3DBnoN0OJuK9e0Cxkfh8v/p2CYB5eS2y36qBD/U6
         IcovzG/4OPEFkA0cwazRWzsV3llgeRjCUUrzzeVzbwancO4meMxH0r+yRFpVLOE0DDV8
         AFsA6zO0IRZzuuhFU31k0UVbLp7E7aTu847WgWFqZAszdujtRHLL64EkIz2jlKSg35hY
         2Y5g==
X-Forwarded-Encrypted: i=1; AJvYcCWDjQ7Is2c1FI/30gOPOefwg8+riOhX0yvUResTFZ2xl/MyAusxXUu+Z8ttxmX3JNOGTbpc+Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZFb5bPfBngJoOTK7OM9N/BGZ3adJwg1bU22QqWvHofy4g3O7s
	fcarFx25Y3f95AS/Ell2Qh0CDieRlY5odZnuL6KDO6kq5AgTBuGwV85akQoepf+xrET3sp5UKZL
	YtTfxu0mgIXSqh/4OmbGwCAkP6215/5QKVAt96DbMncdmvom6ssnzbZZuzepo1w==
X-Gm-Gg: ASbGncsmxQlLMTCuzBhVcHTz/4+Tc4wAl4Fg1h+gm9mF9BS924ymmdk9sPVLEhResj1
	RXOnm7ds+q4Yf+/OOdVJCvNixKn+HI9esywZ8F8OwHV7BXaJYjthu1Wy3Y28GI284sZwQ40MwsS
	83XPAw7yQEsau1RwUDBLP0TBewbYN51p47yIN/R6+GqepvN1KIK18+hkH0JDQo1jtjJdQHe8BDF
	fe58LvtS05Dg8VEDi1pgILFDu1oXL82MguWy7Q6liUomFHJy9kWHO1KDWxkdXauiRAIsqpurrYS
	/wRb/8iKu00bV2Aw1jQ9Ve44SbFtD/iMeZ0QTMI=
X-Received: by 2002:a5d:47ab:0:b0:39e:faf8:feef with SMTP id ffacd0b85a97d-3a06cfab965mr1636782f8f.56.1745492663903;
        Thu, 24 Apr 2025 04:04:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHolj4jAkXWZgjgiY9g67zZ4iSrWcvdEryaUkNLkRqtxvRgz/PM71yD5V2etIdvFtP43ygB4A==
X-Received: by 2002:a5d:47ab:0:b0:39e:faf8:feef with SMTP id ffacd0b85a97d-3a06cfab965mr1636744f8f.56.1745492663418;
        Thu, 24 Apr 2025 04:04:23 -0700 (PDT)
Received: from [192.168.88.253] (146-241-7-183.dyn.eolo.it. [146.241.7.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d4ae0b8sm1735217f8f.32.2025.04.24.04.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 04:04:23 -0700 (PDT)
Message-ID: <4e7227ef-a1d6-409f-a21b-5b1f26cf52b7@redhat.com>
Date: Thu, 24 Apr 2025 13:04:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] net: fully namespace net.core.{r,w}mem_{default,max}
 sysctls
To: Danny Lin <danny@orbstack.dev>, Matteo Croce <teknoraver@meta.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250418070037.33971-1-danny@orbstack.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250418070037.33971-1-danny@orbstack.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/25 9:00 AM, Danny Lin wrote:
> This builds on commit 19249c0724f2 ("net: make net.core.{r,w}mem_{default,max} namespaced")
> by adding support for writing the sysctls from within net namespaces,
> rather than only reading the values that were set in init_net. These are
> relatively commonly-used sysctls, so programs may try to set them without
> knowing that they're in a container. It can be surprising for such attempts
> to fail with EACCES.
> 
> Unlike other net sysctls that were converted to namespaced ones, many
> systems have a sysctl.conf (or other configs) that globally write to
> net.core.rmem_default on boot and expect the value to propagate to
> containers, and programs running in containers may depend on the increased
> buffer sizes in order to work properly. This means that namespacing the
> sysctls and using the kernel default values in each new netns would break
> existing workloads.
> 
> As a compromise, inherit the initial net.core.*mem_* values from the
> current process' netns when creating a new netns. This is not standard
> behavior for most netns sysctls, but it avoids breaking existing workloads.

AFAICS leveraging the above and any protocol without memory accounting
(e.g. UDP for tx) child netns could use an "unlimited" amount of kernel
memory. I'm wondering if it would be safer to limit, for child netns,
the maximum value to the corresponding initns one.

/P


