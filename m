Return-Path: <netdev+bounces-221229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CDEB4FDA1
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138255E71E4
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F423337687;
	Tue,  9 Sep 2025 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gq/relHw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1816333EB12
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425067; cv=none; b=aDYadB3NImqDh9yfL/v+gdjBLvavSzy7R6SKTGVAV/4/t5/tywiieneV43rCQ0Cy76+OtPtP2CGlHS0BKcFC/o8WtA8S8zc1ytl+bJoIe++NNhUfDEjHK/fzc2qlPUyWQVsbyWbdLoDkRNQw+WUMPx5MRlYBY+5lk6YMibxTwzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425067; c=relaxed/simple;
	bh=e+SuR4WtDHS81LI26mtHYEgiZXDo7lkNjrvBEZPigsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MW6pXqyYuQljP3wtB1amcc4CszoJCbFq4g2Fi8GNATFaqgTaB0dFxQ9oY5Gu7tZ4gnZRFWnigFMdccgDGT1BzCYIalmuUmg2e04o4xLxr7jpRfJcFp2Fm4pFAOeGTP+8N251HJiRLvr5EKwFTvr7pbj56bJem6tbGx1z9JL5tEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gq/relHw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757425064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uZRgHX/SAbYBCBAOP7R/FI+WHkbaP9SNjlCYgEWEHOA=;
	b=gq/relHwrZY3z9VOn7PXxGKO8COxzaH2cUPlo/x3a6fKexgOuaJBmdTiTUwlqcsvDn8Y94
	m1jUK7M1AP3FEBy7NdTTFby3GKNA3ve0LPZJC/PwSsNyN2jCqHcSkKhHpTZoM+Mt3y5zRR
	6c+prngc3BzpElc3A9jxtr9yal/aJ4M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-ku-qxrBhNa-PlYzBEeYKhg-1; Tue, 09 Sep 2025 09:37:43 -0400
X-MC-Unique: ku-qxrBhNa-PlYzBEeYKhg-1
X-Mimecast-MFC-AGG-ID: ku-qxrBhNa-PlYzBEeYKhg_1757425062
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45dda7c0e5eso34879795e9.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 06:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757425062; x=1758029862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZRgHX/SAbYBCBAOP7R/FI+WHkbaP9SNjlCYgEWEHOA=;
        b=ki4d0iUNYLFYfcdyV4XDrn3vk1wRzATw2kP7KZsgG76HKLySNszxLUWob3SHlMYbEb
         jyIalq9cvtZVqZcD/W7QbcpNcBXgygnKRu5M25rMcbBJHh52aftoCK1ax4SSOqntlnZB
         Heen9nDKnVM9CHgQ1Qb1LDbE14zgAQp90xN4pR2Ix9IaofiAojCayXy/3VR3G9L0NnSE
         452N5WFYm/eaU7lBkzm9XGpImu/9AiMcerqOEpVV461CGD/Jh8szqRhyg0CVYdgoF0wt
         +MvSps5W2SHPxWfyOeLtzmz0XopD2ettubYfRJRbXhPmmycCC7S7JV+yKACo8hffdzKK
         VBCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbOeKFceU+LXHYU0dRU3JURVp8Nvk22s+pS6h5/HqeEMJHVExvNPQw67c0Ja30GznjhBnzX5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxseCCONzitbZhow2KGkEbRxroMaHVopsiSV1PcXiwM1GGda7hp
	Xw4z75HSMWV8Lksfe7++WqbxvNF/EZd7gi05/63xqBXuOFTfFL75whdRYCFwQh2FzgBTA0J0cM7
	GHZdUOEUgElX3tblK0Q2EuKXbV6bNn79AUwyxiLUOpauVaGpYXc5RX3DhoQ==
X-Gm-Gg: ASbGncvapEjCAqULn3pEVd9ZTFo2Sph7S0rZZXUcG9bt7Od3bGSod7BLnpCbCMZ8jJE
	2v3vVvYViG0l1QGpdNHxKeM9tpI2E5wCrwnm8opDrLkGMyjb4sAsgK5X4QAD4orZqdswbdPheRl
	mfVx+4EL2N12u1pI4NQqxaQZgChnKaLOiHs7wqP4XInHHnzAURQ0aVyFRM8jd5rGH84vUUdZLZ1
	RSHv1SbD0vZVom5AOPMQTYBsoc3Jf9unbVBvh/HUDsSW5TH9xEoWwhlgjMFowPvIG3EgqsHVZ9f
	bRzg85vPElSh1uuXAWB/3pQbSp8ITfv4Eltatdb3HdLtF6iD6JdNj1gK3X6BPKxgxsvwaHW93Hy
	bpdFWed0hJt8=
X-Received: by 2002:a05:600c:3149:b0:45d:e326:96d7 with SMTP id 5b1f17b1804b1-45de45f2bb7mr70230985e9.13.1757425062292;
        Tue, 09 Sep 2025 06:37:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEg6ssa7jHrIiSMVqBM8YoksOuD57V8eF8Zjb7YdqXHWp4PGJ6JM4tgLBv9g0nI6cfXMlMtw==
X-Received: by 2002:a05:600c:3149:b0:45d:e326:96d7 with SMTP id 5b1f17b1804b1-45de45f2bb7mr70230665e9.13.1757425061834;
        Tue, 09 Sep 2025 06:37:41 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521c9cb9sm2888421f8f.20.2025.09.09.06.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 06:37:41 -0700 (PDT)
Message-ID: <86d55600-3714-4394-a39d-eaff6847a6f0@redhat.com>
Date: Tue, 9 Sep 2025 15:37:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 4/7] bonding: Processing extended
 arp_ip_target from user space.
To: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
Cc: jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com, pradeep@us.ibm.com,
 i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
 stephen@networkplumber.org, horms@kernel.org
References: <20250904221956.779098-1-wilder@us.ibm.com>
 <20250904221956.779098-5-wilder@us.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250904221956.779098-5-wilder@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/25 12:18 AM, David Wilder wrote:
> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> index cf4cb301a738..61334633403d 100644
> --- a/drivers/net/bonding/bond_options.c
> +++ b/drivers/net/bonding/bond_options.c
> @@ -31,8 +31,8 @@ static int bond_option_use_carrier_set(struct bonding *bond,
>  				       const struct bond_opt_value *newval);
>  static int bond_option_arp_interval_set(struct bonding *bond,
>  					const struct bond_opt_value *newval);
> -static int bond_option_arp_ip_target_add(struct bonding *bond, __be32 target);
> -static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target);
> +static int bond_option_arp_ip_target_add(struct bonding *bond, struct bond_arp_target target);
> +static int bond_option_arp_ip_target_rem(struct bonding *bond, struct bond_arp_target target);

Above and elsewhere:

'struct bond_arp_target' -> 'const struct bond_arp_target *'

Side note, I replied by mistake to older revision of this series:

https://lore.kernel.org/netdev/dbc791a9-7b87-42a8-abba-fa63e5812008@redhat.com/T/#u
https://lore.kernel.org/netdev/8c0b5b0a-60ee-4ed4-b439-11d5c106ac6e@redhat.com/T/#u
https://lore.kernel.org/netdev/add4dcf4-b3c2-40dd-bc2f-de80619e7c6f@redhat.com/T/#u

but the comments there apply to v10.

> @@ -1214,30 +1216,77 @@ static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target)
>  			targets_rx[i] = targets_rx[i+1];
>  		targets_rx[i] = 0;
>  	}
> -	for (i = ind; (i < BOND_MAX_ARP_TARGETS - 1) && targets[i + 1].target_ip; i++)
> -		targets[i] = targets[i+1];
> +
> +	bond_free_vlan_tag(&targets[ind]);
> +
> +	for (i = ind; (i < BOND_MAX_ARP_TARGETS - 1) && targets[i + 1].target_ip; i++) {
> +		targets[i].target_ip = targets[i + 1].target_ip;
> +		targets[i].tags = targets[i + 1].tags;
> +		targets[i].flags = targets[i + 1].flags;
> +	}
>  	targets[i].target_ip = 0;
> +	targets[i].flags = 0;
> +	targets[i].tags = NULL;

The above chunk of code is repeated elsewhere. Possibly factoring out
the initialization in an helper could be useful.

/P


