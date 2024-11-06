Return-Path: <netdev+bounces-142268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682D89BE17B
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C924282011
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046061D0DF7;
	Wed,  6 Nov 2024 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqavcIha"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB76D1D7E41
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883634; cv=none; b=WU2iq3G5BVIyyxy+Cv2bMPhfBOQtd3AApyG7ALxltM7FYIJYVLUy9jm2SP5IL6YqdjaaKtyR5AYau9VbzCiCkF3dBDjyTi5Ni6HvpT8ieP61DuKweE00L8c5RR4Tav9zuRMEdR26gxRh4LwxO1MD0ob0iJv5lMRdKWmBYJIG098=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883634; c=relaxed/simple;
	bh=1wtoUZb7igWwGCo1hay5S1pPcP/6zxMqXWLRqUFMUdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AnzgbOV5lNMtDiq5N9Wowb1Uj1ZsVQS5WAKWRHsIdDMIYJJhdXjfKGXHddNliq/J7THrMYHpwAebWNvWXssNrqHlH+JZmdDo0OdouIANI40uJY82qvo2pyCUMvXLvru8yfMENp49beie2zSr3n/R0LyvCkUwx9JZWZGmrfoZAHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqavcIha; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730883631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=axmudicGVO9Q8nAMhCbiq7Bd/A0GPd5u5/poYVKGHUY=;
	b=JqavcIhagX5kC9T67B3Zy5VLU7h0KX9yqkzljzcmOHe8mBE208WbzQQZ1mpMP1hVJXGYX8
	0FJps2hCOrcc0GQe+OowPFbB9vK+I0wjAQWVJw1r7SUWyxabvtqQsSG3lEUpSACoNLpF8t
	VD2U28axgIFK7tzSBzoLGZsNOH5aP9s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-6RyaLB-QMI6aJS9HHzKiUQ-1; Wed, 06 Nov 2024 04:00:30 -0500
X-MC-Unique: 6RyaLB-QMI6aJS9HHzKiUQ-1
X-Mimecast-MFC-AGG-ID: 6RyaLB-QMI6aJS9HHzKiUQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d589138a9so3108246f8f.1
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 01:00:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730883629; x=1731488429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axmudicGVO9Q8nAMhCbiq7Bd/A0GPd5u5/poYVKGHUY=;
        b=Gbvhy5061AFrrOn+RLKle20y43yL8XsMUKtFUu8oxLM9CUVKOAyZqjexWqkoZUqVA+
         sNTjizNJdThzQTaszqZURhJfXu2JO+nhLjsM3OodNaaaF0DBuKVrfTDr1qXyW7X+Y773
         ssTEYXutmXi9VC91zytU/4LtEQSKq8lGL1OTdq+BBQLIhRE704jchgkNaBaF7A/IBG3V
         H6O/ynBBKhq8JtDPFvEX1Lo5qvD6J4yy5zY82S7AAEMaqc5E6HFfUivITz1nEIZY3N3x
         PkQBCa5vDGNqDkTRuyaN0yHC6rrlD1fKZLz184t6UeQtjL1QwYdXat2MUqrV8UsyfW1i
         9YGg==
X-Forwarded-Encrypted: i=1; AJvYcCW9QhhNFFLvOhfsaggePqlDHdWf6xyS6H4bQ4CJTdzkKIykXg/UuxvXpEKjtT29xQT1L1VZRqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSxKbe/qgIKrqhCfbh+1qKr0qzK2wJk7JbDAOSbEgB2yYSCPPG
	YjX++DNFXb5A/M3V1Nx2A1IvevshfBK+wRjW6M7gcJ10lJAFXD8afyUhBUl1rlbyBhKtO0p+JHy
	oTgRrtQzGt8QWSogg3gKrDLNPnYzar1Qhi0av7O9yomdeH2MNWarbWw==
X-Received: by 2002:adf:ea06:0:b0:37d:45f0:dd08 with SMTP id ffacd0b85a97d-380610f212emr27582136f8f.11.1730883629176;
        Wed, 06 Nov 2024 01:00:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzSve2i8nJTVTdQXB+tYxgDLFKDgtRDiPfZLOVO8eLpftF9UVDzXD5lddlaFIfxonpXuBSXA==
X-Received: by 2002:adf:ea06:0:b0:37d:45f0:dd08 with SMTP id ffacd0b85a97d-380610f212emr27582117f8f.11.1730883628793;
        Wed, 06 Nov 2024 01:00:28 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d4bc8sm18559825f8f.39.2024.11.06.01.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 01:00:28 -0800 (PST)
Message-ID: <0ce3e4aa-a091-4d83-b3f3-222b9eaf05c5@redhat.com>
Date: Wed, 6 Nov 2024 10:00:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 6/7] rtnetlink: Convert RTM_NEWLINK to
 per-netns RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20241106022432.13065-1-kuniyu@amazon.com>
 <20241106022432.13065-7-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241106022432.13065-7-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/24 03:24, Kuniyuki Iwashima wrote:
> @@ -7001,7 +7021,8 @@ static struct pernet_operations rtnetlink_net_ops = {
>  };
>  
>  static const struct rtnl_msg_handler rtnetlink_rtnl_msg_handlers[] __initconst = {
> -	{.msgtype = RTM_NEWLINK, .doit = rtnl_newlink},
> +	{.msgtype = RTM_NEWLINK, .doit = rtnl_newlink,
> +	 .flags = RTNL_FLAG_DOIT_PERNET},
>  	{.msgtype = RTM_DELLINK, .doit = rtnl_dellink},
>  	{.msgtype = RTM_GETLINK, .doit = rtnl_getlink,
>  	 .dumpit = rtnl_dump_ifinfo, .flags = RTNL_FLAG_DUMP_SPLIT_NLM_DONE},

It looks like this still causes look problems - srcu/rtnl acquired in
both orders:

https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/847881/12-rtnetlink-sh/stderr

It looks like __rtnl_link_unregister() should release the rtnl lock
around synchronize_srcu(). I'm unsure if would cause other problems, too.

Please have a self-tests run with lockdep enabled before the next iteration:

https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

The whole test suite could be quite cumbersome, but the rtnetlink.sh
test should give a good coverage.

Thanks.

Paolo

p.s. kudos to Jakub for the extra miles to create and maintain the CI
infra: it's really catching up non trivial things.


