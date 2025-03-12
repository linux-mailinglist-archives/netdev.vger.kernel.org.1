Return-Path: <netdev+bounces-174273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF214A5E195
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 17:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8E21697E0
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 16:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1EB1C5D7A;
	Wed, 12 Mar 2025 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGaXHurs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275DC18E025
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741796068; cv=none; b=fH09vQDybn/lmDTsAra4jRlNiIPzOPVIYpEHfHrrJldGv++xpVtX9lrP+lwcqsymzGaKAN48erM7jb2B+v1oZmGYsZ9DqWDJ/rZBHYcyDlcdqOpDFc2yt3a1vhXk3ZLckiGfU4FSgyKOAzA3zKdr5GwxDfcezs3R8z23nKx53vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741796068; c=relaxed/simple;
	bh=+Q8FJLEc/wPqO/B2liJt5338+n1p3oYveSEAcS0Q17k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sa6X5r0BNJi/viK3aKwevsvxis+jx+YNFkg/pnJqxUJgFYAGMPeF53L3QY37aCpYIU1i7kSqg+wxozUYTpaqj8CDgLwJonJdy+VGFK+jQCbKHyiRn4i9Na4mc9KLZjFPzAlb5mJG1aRDJY4tU8d74bk2hOMGyGNj+QrtEP3h2nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gGaXHurs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741796066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pEyG5Mxc0jKLdEJ3OuRdni2VEk2vhW/ID4tTAR/EGKU=;
	b=gGaXHursk0QUN8Uqjw/T3RtXCnjV1/Y/2q8iiKAbFcAnaQV+qEHce8IwSEQRs6oyQJvIhP
	hYFE5rM7qOg+0q4bltNZ4sw3WfimP78f44Wuq9v2/YQV/5imGRDSoW6OK5CQ2THjcCV1B5
	VhUD4TctuyMHvMHaSSoCo3N204Ollpo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-iCcImMsvO0WO8c5T6QKWWw-1; Wed, 12 Mar 2025 12:14:24 -0400
X-MC-Unique: iCcImMsvO0WO8c5T6QKWWw-1
X-Mimecast-MFC-AGG-ID: iCcImMsvO0WO8c5T6QKWWw_1741796064
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so20527815e9.2
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 09:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741796063; x=1742400863;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pEyG5Mxc0jKLdEJ3OuRdni2VEk2vhW/ID4tTAR/EGKU=;
        b=CiMLebTj+rEKGdBRmTzf9KSjEP2EjgtvSQy0eVl0n5Q+bJxEC+zypSEVyJbIvPTTHO
         /m4pKHlSjqieBFmmjBUBMdylOOzNq6TefRGsqNP8tXo6ctJEyHiSZpLIY9K7YguO6ipd
         3UeLC1nUKPa4JPZgJ/1xo/qa6Q9bf59Luy+E71dS7zJSrPB+HFWazhoGIl8WMjoW9pJO
         Qy19w4EHYJE6RzQH+hHavatSNzRuV917AD4GrxWEo9fjmRVyfvnkZn+jbcZptA85QwTz
         WMZU+ctRJX0kcYgtpc7YvL3PnqBz/snBPz4zNeMXQHjDh3pp/+A2rs3IwZ6hTVWnWZrZ
         ybkA==
X-Gm-Message-State: AOJu0YykaiQFlLSmkjhn4KESIrofreZ1rTkBRah0gpMHyoAXxDzSdJXV
	MLkovOBGLbY/DWNFz74tjBjJ4X5kENatGC9XDkN96CYo4wZkAQlpzLTFyNfChNR3szBexn7BJwE
	aCQlRjV7V+dDSQYT4emWZkuE1AA7e8Gk6Jfz/I//qQvoBMqZ7ZwUNhA==
X-Gm-Gg: ASbGncuGRmwHry8/ainijKqRI6LXhK2qIatOr2FRNZG1ifYME9XfkSoqkW2Ir3P49IQ
	fcm1y/s2ZaULBlpf6LgRW/ugmnqb2/IBEWJqLYreFIYLxrGt6DZp/Y7vlPGCzkGPikVLnVobbaZ
	t8YbfRSv/PNO/56stswNeEcC/WLrdUl8TW+TLunsMrY48qv0G9qr7CWfKLXu1x/mk2USytp1uSd
	T6SQrLbfUpItB/mN/q16h+9MfRvMich0OYJXPThc9e1vzBpHp3CU+Gz0tCMyn7E8N+7vtnBWgVe
	vnsHaOtHc3oxljlfVwcgR6Scd4wIKpZPF4S+NFDx0L0=
X-Received: by 2002:a05:600c:3b91:b0:43b:cc42:c54f with SMTP id 5b1f17b1804b1-43d01be6394mr97601815e9.14.1741796063618;
        Wed, 12 Mar 2025 09:14:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECYcAcLHlbX9xrFOI2TA005+2AV9F0TRMF2ShumfHr5Inuga9Bh7rrpQaOGh8z/bhmcrxkdQ==
X-Received: by 2002:a05:600c:3b91:b0:43b:cc42:c54f with SMTP id 5b1f17b1804b1-43d01be6394mr97601565e9.14.1741796063267;
        Wed, 12 Mar 2025 09:14:23 -0700 (PDT)
Received: from [192.168.88.253] (146-241-6-210.dyn.eolo.it. [146.241.6.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d031d1438sm30002395e9.0.2025.03.12.09.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 09:14:22 -0700 (PDT)
Message-ID: <0b1cdac7-662a-4e27-b8b0-836cdba1d460@redhat.com>
Date: Wed, 12 Mar 2025 17:14:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] net: Modify CSUM capability check for USO
To: Radharapu Rakesh <rakesh.radharapu@amd.com>, git@amd.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 kuniyu@amazon.com, bigeasy@linutronix.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 harini.katakam@amd.com, radhey.shyam.pandey@amd.com, michal.simek@amd.com
References: <20250312115400.773516-1-rakesh.radharapu@amd.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250312115400.773516-1-rakesh.radharapu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 12:54 PM, Radharapu Rakesh wrote:
>  net/core/dev.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1cb134ff7327..a22f8f6e2ed1 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10465,11 +10465,13 @@ static void netdev_sync_lower_features(struct net_device *upper,
>  
>  static bool netdev_has_ip_or_hw_csum(netdev_features_t features)
>  {
> -	netdev_features_t ip_csum_mask = NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
> -	bool ip_csum = (features & ip_csum_mask) == ip_csum_mask;
> +	netdev_features_t ipv4_csum_mask = NETIF_F_IP_CSUM;
> +	netdev_features_t ipv6_csum_mask = NETIF_F_IPV6_CSUM;
> +	bool ipv4_csum = (features & ipv4_csum_mask) == ipv4_csum_mask;
> +	bool ipv6_csum = (features & ipv6_csum_mask) == ipv6_csum_mask;
>  	bool hw_csum = features & NETIF_F_HW_CSUM;
>  
> -	return ip_csum || hw_csum;
> +	return ipv4_csum || ipv6_csum || hw_csum;
>  }

The above will additionally affect TLS offload, and will likely break
i.e. USO over IPv6 traffic landing on devices supporting only USO over
IPv4, unless such devices additionally implement a suitable
ndo_features_check().

Such situation will be quite bug prone, I'm unsure we want this kind of
change - even without looking at the TLS side of it.

/P


