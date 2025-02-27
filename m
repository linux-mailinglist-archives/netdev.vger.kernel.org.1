Return-Path: <netdev+bounces-170212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE47A47D58
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3E33A51C7
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 12:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8946E22F3BC;
	Thu, 27 Feb 2025 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQYD2imR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB9522F17A
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658425; cv=none; b=qoDkyc9g/wbaTsXHoLJC69qUS7829kt1LZEXLNZrWX7d6sb+KA4LKep1887e/nO8CAtKiODZQT3lxRJGgeXSr+g83E90IPaUgDuSWpXDClAlSlhnOqVQuwASixHmyNLI8rqW4yFhSACHxPR6SOZ5LBwh2LD7FJrEPuVyvhXUxL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658425; c=relaxed/simple;
	bh=zu5zZyBnN3ry9IQ+Jn6HYG0wRqc9j641WfB32TvRN88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gnJcrzy7xB3n4Bn7lyOaE4DjOWSp8fXOFJCaSOAFAMNI6m7P7W3/dHDQPyQ/KKH4IBKfQUzXAhUXyvpZ0zX9CQCKXAk2iOpB7CmDM0u1P+ZsX5qgLDOeFlW0e48Y8wPrxQWQg/LURuDVDh1QEfPNmC4av0ZNYOYMSW5MTUdePl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VQYD2imR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740658421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+MXJ/yo/wY9z4Kh8ojEu/aUMRrlN5xvGKyO57GV+hi4=;
	b=VQYD2imRrx2XdaqSUEjym6RLtviAmrwiU7/ntBLPGjcIv4ejoy09F64LsueDyTGcsqRXLZ
	g7QnyA0YFQChf9r4jGiNcjwxgE8ylC2IdL3Crd5F2J1dCT9GU+CeZUqkBY3C4WVyi8dFZs
	IX029JA/CBIcmyuRnMC7JlQnwG94Rys=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-YcguA6cbNiOa08eMPLTe_w-1; Thu, 27 Feb 2025 07:13:40 -0500
X-MC-Unique: YcguA6cbNiOa08eMPLTe_w-1
X-Mimecast-MFC-AGG-ID: YcguA6cbNiOa08eMPLTe_w_1740658417
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-390ddebcbd1so497505f8f.2
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:13:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658417; x=1741263217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+MXJ/yo/wY9z4Kh8ojEu/aUMRrlN5xvGKyO57GV+hi4=;
        b=de9TUZs7tIKYU24q1F/44Wk8k8NskorGRXIcfK4tXKkpuXeUhxXKTtnwXHYFp5ZNmn
         4kPhw8yADmLtdE+YTIWYTcdrmY5uQfE6jFh4K69Lxr1fX+z2y6E2HIL5xPJWBG0tf+1U
         3FCpvcBQ6Pw54VHSihklSWmnL2xErMtZ/qZqnKYA6x9+aUWwKF8cHwGa5uXhbDbayx1J
         gUZdcljD1hAz6noWeLsKFPzJwsDLx88z+fldv67ZgTWtG7SAKq/uyVt+X7/QVhu4vXA8
         znl5zxCBrp0Yn5W1sdd+TsA340EEYSseokUc8mH6K/cHIZ9KOhkboU1U0xj+3Ew0RRIO
         vjWw==
X-Forwarded-Encrypted: i=1; AJvYcCV/PKCJBIBWXM0UJHt9zuyWPpVtzQYKSep+FH8XrShdxfwd+GRNIS79k8t+eg23QmRdTIC3TP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhaE6848YKZDUcFHv6Vhz5lGI6HUZndHoZYLxRd1pA8NXR7FES
	j4EXVe+VUaa+Ald96o8DNrQCRPG35wv1E3Zq30rFY5D8z8vyJ3HqTSe0E5+zShEJqjE1RbeGRRJ
	+Hv45e4q+tyAPnX0uyZ2QQHs3wxj6pUL3Ay9tt1esHuf2YanYiIs1Hw==
X-Gm-Gg: ASbGncuvR/bbe7QIR/zIpW1GgVuguqzvb+B8ln/JFsbC3t0PQhYJedzUWav2JGj3Jbb
	zfSKn65nx9nELkMEng0/GV8UMgHBIlpRndRs1Cy8Z5sr1biegdKJ0ILyd+CvXfBEAsHunh7yb0i
	A/7EQa4cvjYpJtVDAjXj3dSi2MfGsk03nq+7fHh2A4Wp4zuEoVLD0FBnLnuxnu8ItBhDiBXcKVO
	iHAOYFGNnyTY0osIKikAyJCdBzsgGwmIuqcECZikn1xuRVjnbYQ72920dIHauxsgtDIh7H4N/kp
	/shNV3BpJZuvS+QslWlvXElMHBU88jo++jFLotxRSgnkyQ==
X-Received: by 2002:a05:6000:1a88:b0:390:e7d7:9669 with SMTP id ffacd0b85a97d-390e7d7991emr1408592f8f.21.1740658416783;
        Thu, 27 Feb 2025 04:13:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGl4hPeu0HygbnTFHg+/9ohJ4IMxJNzWuCdzZ5zOQx0HggSdzuuB4mlslYm75dEMyalE9ssA==
X-Received: by 2002:a05:6000:1a88:b0:390:e7d7:9669 with SMTP id ffacd0b85a97d-390e7d7991emr1408572f8f.21.1740658416421;
        Thu, 27 Feb 2025 04:13:36 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7d1dsm1865163f8f.56.2025.02.27.04.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 04:13:35 -0800 (PST)
Message-ID: <d33b1587-f401-4400-9205-01e45d0f41a8@redhat.com>
Date: Thu, 27 Feb 2025 13:13:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: 802: enforce underlying device type for GARP
 and MRP
To: Oscar Maes <oscmaes92@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, viro@zeniv.linux.org.uk, jiri@resnulli.us,
 linux-kernel@vger.kernel.org, security@kernel.org, stable@kernel.org,
 idosch@idosch.org,
 syzbot <syzbot+91161fe81857b396c8a0@syzkaller.appspotmail.com>
References: <20250225141709.5961-1-oscmaes92@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250225141709.5961-1-oscmaes92@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/25 3:17 PM, Oscar Maes wrote:
> When creating a VLAN device, we initialize GARP (garp_init_applicant)
> and MRP (mrp_init_applicant) for the underlying device.
> 
> As part of the initialization process, we add the multicast address of
> each applicant to the underlying device, by calling dev_mc_add.
> 
> __dev_mc_add uses dev->addr_len to determine the length of the new
> multicast address.
> 
> This causes an out-of-bounds read if dev->addr_len is greater than 6,
> since the multicast addresses provided by GARP and MRP are only 6 bytes
> long.
> 
> This behaviour can be reproduced using the following commands:
> 
> ip tunnel add gretest mode ip6gre local ::1 remote ::2 dev lo
> ip l set up dev gretest
> ip link add link gretest name vlantest type vlan id 100
> 
> Then, the following command will display the address of garp_pdu_rcv:
> 
> ip maddr show | grep 01:80:c2:00:00:21
> 
> Fix this by enforcing the type of the underlying device during GARP
> and MRP initialization.
> 
> Fixes: 22bedad3ce11 ("net: convert multicast list to list_head")
> Reported-by: syzbot <syzbot+91161fe81857b396c8a0@syzkaller.appspotmail.com>
> Closes: https://lore.kernel.org/netdev/000000000000ca9a81061a01ec20@google.com/
> Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> ---
>  net/802/garp.c | 5 +++++
>  net/802/mrp.c  | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/net/802/garp.c b/net/802/garp.c
> index 27f0ab146..32ab7df0e 100644
> --- a/net/802/garp.c
> +++ b/net/802/garp.c
> @@ -9,6 +9,7 @@
>  #include <linux/skbuff.h>
>  #include <linux/netdevice.h>
>  #include <linux/etherdevice.h>
> +#include <linux/if_arp.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/llc.h>
>  #include <linux/slab.h>
> @@ -574,6 +575,10 @@ int garp_init_applicant(struct net_device *dev, struct garp_application *appl)
>  
>  	ASSERT_RTNL();
>  
> +	err = -EINVAL;
> +	if (dev->type != ARPHRD_ETHER)
> +		goto err1;

I agree with Ido's comment on v1, I think this belongs to
vlan_check_real_dev(). The fact that you have to write the same check
multiple times is a IMHO good argument against placing the check here.

Please move the check in vlan_check_real_dev().

Thanks,

Paolo


