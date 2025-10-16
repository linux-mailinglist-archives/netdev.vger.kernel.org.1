Return-Path: <netdev+bounces-230020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7E6BE30CE
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 13:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D88B34E5C11
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9813191B0;
	Thu, 16 Oct 2025 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpMHlhi6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2514B3164B6
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614029; cv=none; b=X3P4GfMOsn0RmdUo29nxdtww5efsJc+2k2pG+lKb+E5aPRw7ZeP4xIOCP4OWaagVG0nF9ux5ny/wAftQeAqfFPx/Wa9vJqzzklhr+hiTtoBfpr/IULnw38G9DR9frpSc+EkfEaE9JA9My/SPIshgXWpjN9Af4Cs7DC5w6LSeonw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614029; c=relaxed/simple;
	bh=FffjNNCkguOw2FRNdvBljUzb26+3JDqT9d6/ywiOk9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaP22RglvhoO83uasrqBcxiPgilIoVcZv4Se+ljqq2n+tC5a3V3nRBST7GfH3bcnI6gMvxQc6+Qah0HEGOOSCKbUr1g7PY7UVqqr69mNu7Itr80LMKggj779iRqonUU/IFEnrzBYfqS7UhHLQnyszXcrbNWRWhMgN0KIzBpxtXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TpMHlhi6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760614026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZDH+eDwmsfKGFwr6xj6Evf3+8bmcwOZMXU0RyYvhDM=;
	b=TpMHlhi6s9OnJdWZCbwfYIagDqWZ8apuV7hjY/08UK87+ryUxYxgdCUYwzyhbmUpp17uVF
	K22P5nAn2WecZtK1b4ddGSbCMjHt2X97cWbDyRYCcsDVA+LWuuIrDhdycW0Ai7Sygujvq0
	5JN9WYQin/bxAD8j7XG+bmItxZzgIRo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-rMCl6utHP2mihU5qFY_-gw-1; Thu, 16 Oct 2025 07:27:02 -0400
X-MC-Unique: rMCl6utHP2mihU5qFY_-gw-1
X-Mimecast-MFC-AGG-ID: rMCl6utHP2mihU5qFY_-gw_1760614022
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47113dcc1e0so3127855e9.3
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 04:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760614022; x=1761218822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZDH+eDwmsfKGFwr6xj6Evf3+8bmcwOZMXU0RyYvhDM=;
        b=Mj0cY55b817QXNvn65srGZdzzvQNNfB/ffE6Sl5CRfdiYEEWL+8a4aesO5vIHMK+hp
         Y+78FC5kEUJBYi10ebDcbaEdxxMesrMewP/gX0MyoyXPwpOwQnyzARagVeD6mMznwjT1
         zF2B7q9DBYOtxEGu8jbl5j7oQSifJX0wGWV+dQB4z6CY9/vHkb22NetnWle8VmZfbH/T
         EIbSjYvswxGEDQnla6mxoGf5nUmyeXaBOW0z2SqO435j1insLzikSoRceN7VfIXOSUUQ
         qwUHAyX325dO1K6FzjZg+54xVkH4tn25iLfYS740th4Iafxrnga92Jv+wnrFSAfHv7bR
         HMwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgFjjGPgo84G6VeVn3vDsukVSeo+J+80w0QEA/RWwPmf0n+80poHYhAEy3OleIb6ucFRefvKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoQyhRaG5KPBMy+1JoALxQILxrRnWzxICDOPm9O6ML0ihDzNfw
	trpDoSfCsoz0vzS9hPTVMin0OzMqYg3Kvgk0gpsbodeRX8hfsRw7VJObeH6xEpqGNXkQOuo3T3q
	sl7jWfhLCPPaM1YCrz8RH5EmT0aKiOiyPLK5NJVeoRV0aDQ0LkxKeAJBC7A==
X-Gm-Gg: ASbGncvgbrA/2KwujO7xyK2w8Rq1C91QpbajOipY2jIPRaybHMzLgwlnA9wMC+r/8yY
	l6ILaE51YdTXCNVg0TRzSV2vKM9/dHQkyGTCjyfJ4inIX0+kfzilTik4IAcJbsA+Zifr3ji18aq
	PhUIy5uKK5tbnehdHN331us4K0KwwYALeHZa5zzndu7xoVjEc0DgpTE9JHwiFZJNx/OJskx0q3f
	z2bg4j6XkZRvP3JDIvCexaaekTRlvv2DfwxHLFGFIKhbWjW47Vwfg+YHI7cCLT3ONFuMKWqAKZC
	t9m9DvzybqV2l0jEWBDj1hHVlPAfsp5+kFDbQNMgguxMhO4GkyG1LUBvQHlH+W1nvqWguvImCMY
	krCJXlpGExHQrkOAWveEmASAzdl7lMCSLY+LHaZxa0jGOoUw=
X-Received: by 2002:a05:600c:35cf:b0:46f:b42e:e360 with SMTP id 5b1f17b1804b1-46fb42ee424mr161362905e9.40.1760614021695;
        Thu, 16 Oct 2025 04:27:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbWYrIdZv9kihyLOsaEPvalF++07/I7Q7vKsLu+WtlVetPElRxA/yPiPiUjyNLh4C6OqC6Mw==
X-Received: by 2002:a05:600c:35cf:b0:46f:b42e:e360 with SMTP id 5b1f17b1804b1-46fb42ee424mr161362665e9.40.1760614021249;
        Thu, 16 Oct 2025 04:27:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47114461debsm24194045e9.18.2025.10.16.04.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 04:27:00 -0700 (PDT)
Message-ID: <34dc4a3b-51b5-400d-90e7-680c2f1dd585@redhat.com>
Date: Thu, 16 Oct 2025 13:26:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 4/7] bonding: Processing extended
 arp_ip_target from user space.
To: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
Cc: jv@jvosburgh.net, pradeep@us.ibm.com, i.maximets@ovn.org,
 amorenoz@redhat.com, haliu@redhat.com, stephen@networkplumber.org,
 horms@kernel.org, kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
References: <20251013235328.1289410-1-wilder@us.ibm.com>
 <20251013235328.1289410-5-wilder@us.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251013235328.1289410-5-wilder@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/25 1:52 AM, David Wilder wrote:
> @@ -31,8 +32,10 @@ static int bond_option_use_carrier_set(struct bonding *bond,
>  				       const struct bond_opt_value *newval);
>  static int bond_option_arp_interval_set(struct bonding *bond,
>  					const struct bond_opt_value *newval);
> -static int bond_option_arp_ip_target_add(struct bonding *bond, __be32 target);
> -static int bond_option_arp_ip_target_rem(struct bonding *bond, __be32 target);
> +static int bond_option_arp_ip_target_add(struct bonding *bond,
> +					 struct bond_arp_target target);

I guess you passed the 'target' by value instead of using a 'const
struct bond_arp_target *' argument to reduce the code delta?

I think it would be clear the other option, it will make the intent clear.

/P


