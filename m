Return-Path: <netdev+bounces-77981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BFF873B08
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CAF2826B0
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E406F135408;
	Wed,  6 Mar 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ZDV7OyGl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C412913172D
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739860; cv=none; b=qo4WC6lEzFrj9GQgKJnA+IeYKhlHBdm5Gh+dWvP32b6Gs57TDsDLcU2MfOzuFqKKyRxnxop+FM4NSny+msexB3IMA+MF041f5iNdyawJJFd9KkAnyln4bwGA0XDSeiPhmgZNiPHesKwINAyMRrM/w7n8GlNj30dnRErIKxtV7CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739860; c=relaxed/simple;
	bh=9m/6Nwp29FMdiAPvoT/uy5FcAHaPgGMnhGx/rL97QP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y46yW9rvo6hZWIV4kSfiURpniqOJxT0CarjbcHAudmaWs30eroSl4s+g/y+TOa7AKZIBsN2u8rwdwPlxidk8hKjln1F3rmWvnwFeDU2E5ALqIpB3uTHYhYbp+kQGb+hts9M2e5prCYvabGAHp78BJegiCH0H2/r6vBcjLcQ4tlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ZDV7OyGl; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28a6cef709so1116164366b.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 07:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709739857; x=1710344657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=avqA9kV3gldH32mZbY07J4EIMmdUpJAHvOc3P95tPWk=;
        b=ZDV7OyGlKy93Rp7lPVh19y3W+6PALkYC5qXGsbgeVTondinjs2Bvtuj4DBPY8xTmen
         v9rk9DZaxScHT1BHDwmZ5jM3Er4Sd8K29bmDMn2z+jPvuIhJ0ahSgU4sksraNVGem0+B
         EK+g3fkDucfQXByBcX4EiITZBcXMcvfbTz7EI9l6wyYCm9LnhoJs/rNQtCo++0yK5aYV
         TNitGsN0a6ySs3FNPAme+L43FUfbS7mbETIBrxGLdFYyGQh6lXBJdSjut54DROgr18AV
         oLu9LN2bLm2XL1NcQDGwqLO0nai4e76dSRW0aB2/Hrn3zlNQNtZE8p3P6co2bWocQG6v
         SSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709739857; x=1710344657;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avqA9kV3gldH32mZbY07J4EIMmdUpJAHvOc3P95tPWk=;
        b=kzwGgBLOds+wvvYlUFWsIk0OKT4gXjNye0nPxzfSl7XmsiO9/GgofzlOdv/6gFDPnm
         nJtyIR5FCld48c8CLV9Ysq5xLg9CYhDpTBZdl1IDFtMAFdEWYyptBXTp762Mq9P6apcN
         xqzQl9lzy0M2pZ0JyDSqy4rROWqr92BPby8GQp+9lboUow801bUVEP3oaM5oQ0EA5+L4
         PR9Ef4Gu1xWW0DRSzuMGpauLrPrlPmMjLnvM7E6QF5X47xEdADIzGeei2UnDeVfZ+B9e
         0sNF3uONbqdY0lTgC48LGcsklfaSiC86toKPfB0o9D6Q1MA/LQkNcIVIGr4s6n9xxvCW
         6sTg==
X-Gm-Message-State: AOJu0Yz2gynE3/4fdVBpEeJzlP0JzqvCPAwWgVu23E3PZyarjF7xxyd0
	ejTor85n5w0GvnEBJUEkSI+JuXYRZmfIMbZHOgtERbwD7TcV7e9TgkvA21HNj7M=
X-Google-Smtp-Source: AGHT+IHSgivLXMjU/AFCQ2FlBDUo9O7BSwwenGkElAcsaJKIIPwhLVZ3De2ntNVdng1GaPro9rzRNw==
X-Received: by 2002:a17:906:f253:b0:a45:7d2d:e313 with SMTP id gy19-20020a170906f25300b00a457d2de313mr5091751ejb.50.1709739857172;
        Wed, 06 Mar 2024 07:44:17 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:2746:4b81:593e:203b? ([2001:67c:2fbc:0:2746:4b81:593e:203b])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709067c9800b00a4528658771sm3971397ejo.31.2024.03.06.07.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 07:44:16 -0800 (PST)
Message-ID: <31c1d654-c5b4-45a1-a8e3-48e631f915ab@openvpn.net>
Date: Wed, 6 Mar 2024 16:44:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/22] Introducing OpenVPN Data Channel
 Offload
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240305113032.55de3d28@kernel.org>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20240305113032.55de3d28@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2024 20:30, Jakub Kicinski wrote:
> On Mon,  4 Mar 2024 16:08:51 +0100 Antonio Quartulli wrote:
>>   create mode 100644 drivers/net/ovpn/Makefile
>>   create mode 100644 drivers/net/ovpn/bind.c
>>   create mode 100644 drivers/net/ovpn/bind.h
>>   create mode 100644 drivers/net/ovpn/crypto.c
>>   create mode 100644 drivers/net/ovpn/crypto.h
>>   create mode 100644 drivers/net/ovpn/crypto_aead.c
>>   create mode 100644 drivers/net/ovpn/crypto_aead.h
>>   create mode 100644 drivers/net/ovpn/io.c
>>   create mode 100644 drivers/net/ovpn/io.h
>>   create mode 100644 drivers/net/ovpn/main.c
>>   create mode 100644 drivers/net/ovpn/main.h
>>   create mode 100644 drivers/net/ovpn/netlink.c
>>   create mode 100644 drivers/net/ovpn/netlink.h
>>   create mode 100644 drivers/net/ovpn/ovpnstruct.h
>>   create mode 100644 drivers/net/ovpn/packet.h
>>   create mode 100644 drivers/net/ovpn/peer.c
>>   create mode 100644 drivers/net/ovpn/peer.h
>>   create mode 100644 drivers/net/ovpn/pktid.c
>>   create mode 100644 drivers/net/ovpn/pktid.h
>>   create mode 100644 drivers/net/ovpn/proto.h
>>   create mode 100644 drivers/net/ovpn/skb.h
>>   create mode 100644 drivers/net/ovpn/socket.c
>>   create mode 100644 drivers/net/ovpn/socket.h
>>   create mode 100644 drivers/net/ovpn/stats.c
>>   create mode 100644 drivers/net/ovpn/stats.h
>>   create mode 100644 drivers/net/ovpn/tcp.c
>>   create mode 100644 drivers/net/ovpn/tcp.h
>>   create mode 100644 drivers/net/ovpn/udp.c
>>   create mode 100644 drivers/net/ovpn/udp.h
>>   create mode 100644 include/uapi/linux/ovpn.h
> 
> At a glance you seem to be missing:
>   - documentation
>   - YAML spec for the netlink protocol -
>     https://docs.kernel.org/next/userspace-api/netlink/specs.html

triple ACK on the doc :) will add more.

>   - some basic set of tests (or mention that you'll run your own CI
>     and report results to us: https://netdev.bots.linux.dev/status.html)

I currently have a small userspace tool (that implements the netlink 
APIs) and a script that by means of netns and this tool runs a bunch of 
tests.

Is there any requirement about how the test should work so that I can 
make it compatible with your harness? I will then push it to 
/tools/testing/selftests/ovpn so that you can pick it up.

Thanks a lot!

Regards,

> :)

-- 
Antonio Quartulli
OpenVPN Inc.

