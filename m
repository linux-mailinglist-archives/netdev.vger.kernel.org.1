Return-Path: <netdev+bounces-201524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3242CAE9C49
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17E83B03F2
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 11:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E18221FAC;
	Thu, 26 Jun 2025 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adJnGZSC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C2F15B971
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 11:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750936583; cv=none; b=H5GQVQyCMmQmU5miEgVN9hpY2DT9YIWcuh0Iw2RDsPN6171fAjUq5UhGqozTf2fuU4YJx2CEJ2DvEeveqkvLElrarrz5Dq5X+TCd1zR9YZQezb0Q1FpHuQLWvvDtd96F14GoQ9FfohKt2KzXwEs6gamxYYUfJ5dj2xnReQen3gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750936583; c=relaxed/simple;
	bh=qo57L2poMKEW9s/gtHUWVGRS2cjnbaT1DTc/MIZCKIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qky/5s+Pn2TQLBFvQx3J26fCV+uODs0KJ6fn3oUyna8Az4OXChBB/jjB042HiJ3idFOFfaxp9eudbPUKvD2Ob78wSHHoN1PQBel1PZ86dST5+uiQfm0xQ1dbaqAlJhD1Hu2CBUrZYAb42N3Hb4FJXd8OwVfFWVPusvyPSaDjkOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=adJnGZSC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750936581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qt+IC84k+uvypp7MYDVb4qf5SesrTfkp1AakZl9oWt8=;
	b=adJnGZSCIlX87jPNleO0WAIRNaCrrxTplT1rucTL/v5Hi4lmtjFRlukfs7lGXA401mrbkm
	CPckjHXAJ0nF5szz/M0h5vbHOvOx7rLpHLWA+bNN/UVoCze6GEAP4J3xx3hL6n7Ty5xY3+
	P8B/KaZBHdyCcsMEYJbuEBcMTBkTkY0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-DdBn6GK0MPCcpYhE2AncVw-1; Thu, 26 Jun 2025 07:16:19 -0400
X-MC-Unique: DdBn6GK0MPCcpYhE2AncVw-1
X-Mimecast-MFC-AGG-ID: DdBn6GK0MPCcpYhE2AncVw_1750936579
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450d244bfabso6950375e9.0
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 04:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750936578; x=1751541378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qt+IC84k+uvypp7MYDVb4qf5SesrTfkp1AakZl9oWt8=;
        b=PQYDOH0CPN/WzDfPGZRhuKFhfabmQNjD7L78/d0MN4nPSVijxshWA1QrYEo/gXOA53
         sXiRLXUV1Cnkqzfr8N1q3oQHe0wheOzw6qJXxw+u+LOEV26nLiRmK6Qa5WZOciYePu/U
         PVSuMdgHm1ysmApliRUWLtyu5vXk6ILY7DE5/owpCpCncFeEbc9vf0cZLn3+yUZbgQaJ
         OdVv7OYpz+UciPFND03y+RwkC5ZzFLM9PLE0EJIzFp6uBnhM6gzOh8vgbLau40Vq2KiF
         85BVytWE5XRNMROjUdchFuC/uG3diKGumXYbMbbeT441gj3kST3gRHwUaXohy4ElYck2
         5EZA==
X-Forwarded-Encrypted: i=1; AJvYcCV2i1Yk3fRqJq01pLei4Npwc6LCEXDUpR5mc+EgWSylE4Shvgs+nygw9ZDkM8zC1dbv6QBO/Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIB9FqgMMmjXc2YL0pIwSpnMkTY3YkfAf9UavUeA10uY7vl22f
	Zh8Fomn9lPYbdR6THoYkTZhqMb9kaTDEP7ZP2fcMJnHBm6JPrlvRd6VoFG1JY9EovGs/TIBocGE
	6BogrhHNyjOgZjEBS+RHlDFuHSjuhXjeHp4V3SzDVKkXGRut9NyxfU8U5cg==
X-Gm-Gg: ASbGncudut1XsEYM8G1WsRdIz4k90k894z+O9YG/vwQ42SHmRPXRWPRcVhYZLMUo0Z5
	BpEgtByV2H/G/CknqihWDeE85LzKMTkLzGAe+m3545iSOqsKb+e8GknVFsjtVUK1TQhZvAPs3jv
	Tn7AMvW5AgswRyhPPxjxDXBIl8pyP5OUG7TDE1HR3+GcAPGaFcCqGRTYsg5+8ClVxj5egoeXu1h
	5I+RrtmWt6z9HpAzeEWH7JQ9nOWTv++0HSwjp+IJZ92jWN/Saplzv2qeEGKhTKLs/Ggsx8X+vnq
	78bcK6DiZCrrRhY/hd0iv0DEbCe8gR9ztFLJ9yNL8WwNyXGc/5eNisIjgz4M9kz/7QqZEw==
X-Received: by 2002:a05:600c:190b:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-45381ae45d4mr61914145e9.19.1750936578493;
        Thu, 26 Jun 2025 04:16:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELheAaXQfvye5T5ZvYEmsfRA51eC3zONjLwCjk5zzEtvEtwkgx9UeXhpI3yg0cR9+RHQ3iYg==
X-Received: by 2002:a05:600c:190b:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-45381ae45d4mr61913825e9.19.1750936578046;
        Thu, 26 Jun 2025 04:16:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:bd10:2bd0:124a:622c:badb? ([2a0d:3344:244f:bd10:2bd0:124a:622c:badb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a407743sm16374375e9.33.2025.06.26.04.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 04:16:17 -0700 (PDT)
Message-ID: <77694cec-af8e-4685-8918-4fd8c12ba960@redhat.com>
Date: Thu, 26 Jun 2025 13:16:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v7 3/3] net: bonding: send peer notify when failure
 recovery
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>
References: <cover.1750642572.git.tonghao@bamaicloud.com>
 <6965bf859a08214da53cad17ea6ed1be841618fa.1750642573.git.tonghao@bamaicloud.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <6965bf859a08214da53cad17ea6ed1be841618fa.1750642573.git.tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/25 4:18 AM, Tonghao Zhang wrote:
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 12046ef51569..0acece55d9cb 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1237,17 +1237,28 @@ static struct slave *bond_find_best_slave(struct bonding *bond)
>  /* must be called in RCU critical section or with RTNL held */
>  static bool bond_should_notify_peers(struct bonding *bond)
>  {
> -	struct slave *slave = rcu_dereference_rtnl(bond->curr_active_slave);
> +	struct bond_up_slave *usable;
> +	struct slave *slave = NULL;
>  
> -	if (!slave || !bond->send_peer_notif ||
> +	if (!bond->send_peer_notif ||
>  	    bond->send_peer_notif %
>  	    max(1, bond->params.peer_notif_delay) != 0 ||
> -	    !netif_carrier_ok(bond->dev) ||
> -	    test_bit(__LINK_STATE_LINKWATCH_PENDING, &slave->dev->state))
> +	    !netif_carrier_ok(bond->dev))
>  		return false;
>  
> +	if (BOND_MODE(bond) == BOND_MODE_8023AD) {

I still don't see why you aren't additionally checking
broadcast_neighbor here. At least a code comment is necessary (or a code
change).

Also the related selftests are still missing.

Thanks,

Paolo


