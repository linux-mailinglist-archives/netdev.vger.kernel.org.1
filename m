Return-Path: <netdev+bounces-151759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A75C49F0C7C
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52541188DCB6
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8941DFE20;
	Fri, 13 Dec 2024 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="K+C5v8Y3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F251DF99C
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093434; cv=none; b=Nov/Phj8eQZ0F9+Cp5ytIUMtQKRyJnfEHKn9PkpoDQrZkCMrWWNtCZXVKmpxWIkXeVPOFllG2TSMEFcxIu2BssNNbcMgXJC5wF/a8J0PVUuDHdCs/zzDqSh0h3DRtZlqbYOFT3pqzYdOOxRRaunNwRTfHPva0jy5atjJmI5gV34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093434; c=relaxed/simple;
	bh=Nmi9GyDGQHCmYPBPOfLMTtqurvXheZhg9NmNBo3YxcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oo9eaY1mvI9jNY2tf8YdT247aqzDJOSySlfMW9HtcDGG4O3FlnelZWRVBRwKAulk3SLZmztWTuHqTiwBnbJ966/YukNeZvHhMwEtygReGc/gm2AdK0JJ4OGSgSQ7PkxJDomr1oXpzEj73dnfqG+S4+W/NkpmBtfY73CpAzFt3ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=K+C5v8Y3; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa5f1909d6fso309907166b.3
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 04:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734093429; x=1734698229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ltuE2+W/QkL0PmrBT7zRDBDtGcXVxn3gh0L5g4K6QKk=;
        b=K+C5v8Y3W75xxgrONXSxelRLWCApWJehMQThBj1A1AywLFKDulVzQJMVa3Oa0aO9pQ
         of2IJ5//2U5fGMSy5XCXGgj+tYEkKEpu6YtHCV8gC9t+vdJGyRKR1rtGp8d4LIIGBeYJ
         eotPoHzGKu4Q1BXPnJTJheGWv0Sooc6ev0Rcsv+bmAq1XeoJTSNyPvAER44uPnuOg8rj
         kY6eUAvvLz3nSTUURECk/sKJLsT1eptTxCVZE5cOJ11HFwJtTcgINPIhPvsT01ISPx8K
         WtIHCS90fL4XfItYWiBCP3bL5uct7WCNfyROdd1akHvmPqvkKZcsY3M1/jXU9DqBGvzC
         dXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734093429; x=1734698229;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltuE2+W/QkL0PmrBT7zRDBDtGcXVxn3gh0L5g4K6QKk=;
        b=ghHwtjpn/CCGrV9eqYnfVEywxTOJ+PbfxnqVt8HZptaZUhjaIoPljZzNJaadMaCoqU
         agUIUWZB0sCTLoCCuiLuMOVS7pRBp6u/nRVPb2TeUUa0qQ+tLByKVykLBClPHc5MRX6Q
         q2zOASvPW57LdWb5PWbfe6labnIXywjA/9N5IIxNr6HOcqdpvl/Ig5AI1D0xl43YUcKX
         tcx+1Z7Q+f2wW/D1zfhOB8B9MAjHRjqTrtQ+xINglVCwvog3H2tenZcgp8Q7hNizB1/L
         0OfJzJ0CGTJNYUypDnpkC7hlv5s6qv437qJ2VOV6Jvkle0rqlxUV9O4QzuqqxT4YrFaS
         2F1w==
X-Gm-Message-State: AOJu0Yz7ZZOwXvaeQO2CpQmlJRdZQVV0koXadrAHogHkX8pQPvglYRRQ
	jNj0Nvrvled5oz/xOtDE/vAGoNOqo41cBfHixPc+4MTaMnCuREskcan1flgLSkPe3dck39elnbF
	X
X-Gm-Gg: ASbGncup6k3CLPRzRpZmRCZ0TIU5bzYDjmnMbjNSzMvyOgDAuxx1nDu0qh8p6rxrgm+
	CEyTlO8oI+meuwPdjUZQcWl34V1vGaXOLNv5Albrk6e8U7lYStzoECZ5YZOWIn/QShsHiETO343
	CneWMR7P6+FUOevNWYwoLByW7cxBC0VFBuiaiVPy77fNfYygsfjkL2lbc01fkvr0BDppOH1zbpI
	3JX1MV1iI+7dIv9qT4GJtZ46sJHw6v7rPP/shZ2XkKj7iUJ4qhk3a02eCPzYm248FE+HX5hIuLn
	pC5jiF6njuw6Gk2OAZU=
X-Google-Smtp-Source: AGHT+IEzo7yOAMIbo+2ZeO9KjOvgByarMKbpvTYUgjdcE+ovUy0pWk7Akq3CzcQvJ/6fvAVrohq13Q==
X-Received: by 2002:a17:906:3145:b0:aa6:3f93:fb99 with SMTP id a640c23a62f3a-aab779d16aamr245324866b.36.1734093429329;
        Fri, 13 Dec 2024 04:37:09 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:b5f9:333c:ae7e:f75e? ([2001:67c:2fbc:1:b5f9:333c:ae7e:f75e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c7aa3besm11388409a12.75.2024.12.13.04.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 04:37:08 -0800 (PST)
Message-ID: <8db525b6-3384-4e12-b16c-47b0a2898f1e@openvpn.net>
Date: Fri, 13 Dec 2024 13:37:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 03/22] ovpn: add basic interface
 creation/destruction/management routines
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Xiao Liang <shaw.leon@gmail.com>
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
 <20241211-b4-ovpn-v15-3-314e2cad0618@openvpn.net>
 <CAD4GDZyXK6rBH_ccHkYrA4h71bDkKxVy_B5o-bj0ezzdHTJKxQ@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <CAD4GDZyXK6rBH_ccHkYrA4h71bDkKxVy_B5o-bj0ezzdHTJKxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/12/2024 13:32, Donald Hunter wrote:
> On Wed, 11 Dec 2024 at 21:32, Antonio Quartulli <antonio@openvpn.net> wrote:
>>
>>   static int ovpn_newlink(struct net *src_net, struct net_device *dev,
>>                          struct nlattr *tb[], struct nlattr *data[],
>>                          struct netlink_ext_ack *extack)
>>   {
>> -       return -EOPNOTSUPP;
>> +       struct ovpn_priv *ovpn = netdev_priv(dev);
>> +       enum ovpn_mode mode = OVPN_MODE_P2P;
>> +
>> +       if (data && data[IFLA_OVPN_MODE]) {
>> +               mode = nla_get_u8(data[IFLA_OVPN_MODE]);
>> +               netdev_dbg(dev, "setting device mode: %u\n", mode);
>> +       }
>> +
>> +       ovpn->dev = dev;
>> +       ovpn->mode = mode;
>> +
>> +       /* turn carrier explicitly off after registration, this way state is
>> +        * clearly defined
>> +        */
>> +       netif_carrier_off(dev);
>> +
>> +       return register_netdevice(dev);
>>   }
>>
>>   static struct rtnl_link_ops ovpn_link_ops = {
>>          .kind = "ovpn",
>>          .netns_refund = false,
>> +       .priv_size = sizeof(struct ovpn_priv),
>> +       .setup = ovpn_setup,
>> +       .policy = ovpn_policy,
>> +       .maxtype = IFLA_OVPN_MAX,
>>          .newlink = ovpn_newlink,
>>          .dellink = unregister_netdevice_queue,
>>   };
> 
> You need to implement .fill_info to add IFLA_OVPN_MODE into get / dump ops.

Ok, I'll add it in v16.

Thanks a lot.
Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


