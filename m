Return-Path: <netdev+bounces-190361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A74AB67A9
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 11:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5376C1668DF
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB59C22129B;
	Wed, 14 May 2025 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="SD2CBK+h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15368204592
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747215386; cv=none; b=BVjY/NEz/aO5y8unM+Q5fXpVtBdR3wB8sX5DPdKdRt1Gf5LHOVbBUUNjGwv01/KCrVlFhkjy4XkhalcDEHNwwsOi+oJBKAoYE6v+8tk/dutFjC+oLreixxD9uMNvp6CDLR2QmrXPpd8TOAZyitxd2Y0dfL/2waYvWzp3OMS1/2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747215386; c=relaxed/simple;
	bh=BIHdlotQ0X2tjSd4WLZWFKSbJttUJ6JGld3rnxhLh/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ne85bGi89LNM3qm2uMizDaJKE/VQ/dNFi76VjV3S8SyhQEE50uWYQSozaCXNIiqmgC204rrjYoHS1MeBvZgRS9QV7rq8JHRIrUfxVbHTvwZLziEgzcyAqm+YXQrsaz2nsGaIsFu4TTpI40kAQGsZdaV81BEbQda/UK9xcKc+KvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=SD2CBK+h; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43ede096d73so45518765e9.2
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 02:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1747215383; x=1747820183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0SFkJPi1+3wW+UAH5kTTHbK8a5+UCTexFOWToCmOeFo=;
        b=SD2CBK+hoDG+2CuWXPcKAnrNRDgqJeorAH9A/YbH70VeeZUznxeRo/j8MtUxAe7JYh
         rmBUbOf3MeqCKZ53q8uuL9XGjug4Lhq9n+znRHoVwfMKbPSbmtMSSNoxOx5fJlkghQ16
         zk5AhsaHty1Zl6vlKh1d2xPYGkeeuNkAOr9q796IhLSJVyd7/ALFxjNcSFJeU3IG7Dy+
         vzH7X56weHqGxsZxKGlA2pOP0hLUJKbCx05ICpqaEdIkCl8yavTSKQTWQivt2x2PxEMD
         xAipqGG5S+9WHIJtZRLRrNaai7+ETd89HNbtguQMw5iagFFbNXGKizNgHMLafKwu2K3m
         B97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747215383; x=1747820183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0SFkJPi1+3wW+UAH5kTTHbK8a5+UCTexFOWToCmOeFo=;
        b=vyV20PKGt4piswtyqdChv+nw2BH0TvPM06Zk5SMC9To3kQLDvTX0L8dv1GBCe9YNB7
         zsYzQJs1uro43OILN7FC3y+vRhuCTv6RYq0Wdh9dkIRHJnUA7JGkODw4BH34uRWAImdN
         rK05jXHnJw33ti5GyRsnUZRoOq67e86ej4EV3/gaqfdkxPJPZnwmWPpyovmOQbZnSvK4
         7zOLFgaD1WfQdlH3mkQL/SaU3Uji0PO1swcb6+4ON3AsiP8I/1jbM15uqbxRcfIuNWUG
         lwImXph73hJxgJ8fI8g5kBphmQMMd/WNOK4nJxVIZ56yeDseWDy8z8SpxyW+vonPMwJa
         18CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW7PAw8BuNzg2rbZPlCCcG8LOUotUCYB1eqtb6iAsB325Inppj7itL/2c941t+ktCMCT0InsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOl8zwdBIp1cKEzyzd6cK8YZ3OlpAf6zP+7Lfy8B5k6+4pviA5
	A82UqqODrJfNuLDNXFiPP42LY9eWD7yCHqyxszic4c1YxwMdoW3cTm0BNHH2REg=
X-Gm-Gg: ASbGncsuYIyp5v3vpD/LdAnRmYjDnMzfM/CI6ZIdcMmOpS3yPd1HICl+MYNLEZSmdQ6
	lyFodI100VG04mhqRXf3JaU995gxrXoFY+e3nLX7rQNO68wJEv0COicEyUD4AlbeAusCpa0nPr6
	GKIusBSAf6vukRCpexvGhTHgAX2+pVIqRqpUmJd+Y8kgbPsWZZDNyDMB9sKjrrZEyxo85m4BfH3
	MFSMqrAT+WbV5ENTIHcanxGBgEw0RpQH2X0Pc0K1BmeK0/FA0+h2gyt8V/iDRVbHsvQ9qA/QnNp
	q7LY5VamZPiHoCK7mw9HRJ1X9acz6R+T9149qaGjSst8jMiVJRFul0UlFRd/AeOU5SwG2rIRBK8
	VLlfpXKVN7rSxMP7Eyw==
X-Google-Smtp-Source: AGHT+IFcnLPaMEFfuaP+U1Ft+6YWbXUglqBveyMKxx9MT3KEtml05ZamygjNl2MvlcxIVrJaOsI2VA==
X-Received: by 2002:a05:600c:609a:b0:43c:fc04:6d48 with SMTP id 5b1f17b1804b1-442f1dd31f4mr27715485e9.0.1747215382972;
        Wed, 14 May 2025 02:36:22 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3979275sm22296075e9.34.2025.05.14.02.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 02:36:22 -0700 (PDT)
Message-ID: <7522bff2-eba5-40fd-8136-31392dac3e96@blackwall.org>
Date: Wed, 14 May 2025 12:36:21 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/4] net: bonding: add broadcast_neighbor
 option for 802.3ad
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Zengbing Tu <tuzengbing@didiglobal.com>
References: <20250514092534.27472-1-tonghao@bamaicloud.com>
 <8D7575EB8AD0B297+20250514092534.27472-2-tonghao@bamaicloud.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <8D7575EB8AD0B297+20250514092534.27472-2-tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/25 12:25, Tonghao Zhang wrote:
> Stacking technology is a type of technology used to expand ports on
> Ethernet switches. It is widely used as a common access method in
> large-scale Internet data center architectures. Years of practice
> have proved that stacking technology has advantages and disadvantages
> in high-reliability network architecture scenarios. For instance,
> in stacking networking arch, conventional switch system upgrades
> require multiple stacked devices to restart at the same time.
> Therefore, it is inevitable that the business will be interrupted
> for a while. It is for this reason that "no-stacking" in data centers
> has become a trend. Additionally, when the stacking link connecting
> the switches fails or is abnormal, the stack will split. Although it is
> not common, it still happens in actual operation. The problem is that
> after the split, it is equivalent to two switches with the same configuration
> appearing in the network, causing network configuration conflicts and
> ultimately interrupting the services carried by the stacking system.
> 
> To improve network stability, "non-stacking" solutions have been increasingly
> adopted, particularly by public cloud providers and tech companies
> like Alibaba, Tencent, and Didi. "non-stacking" is a method of mimicing switch
> stacking that convinces a LACP peer, bonding in this case, connected to a set of
> "non-stacked" switches that all of its ports are connected to a single
> switch (i.e., LACP aggregator), as if those switches were stacked. This
> enables the LACP peer's ports to aggregate together, and requires (a)
> special switch configuration, described in the linked article, and (b)
> modifications to the bonding 802.3ad (LACP) mode to send all ARP / ND
> packets across all ports of the active aggregator.
> 
>   -----------     -----------
>  |  switch1  |   |  switch2  |
>   -----------     -----------
>          ^           ^
>          |           |
>        -----------------
>       |   bond4 lacp    |
>        -----------------
>          |           |
>          | NIC1      | NIC2
>        -----------------
>       |     server      |
>        -----------------
> 
> - https://www.ruijie.com/fr-fr/support/tech-gallery/de-stack-data-center-network-architecture/
> 
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
> ---
>  Documentation/networking/bonding.rst |  6 ++++
>  drivers/net/bonding/bond_main.c      | 42 ++++++++++++++++++++++++++++
>  drivers/net/bonding/bond_options.c   | 35 +++++++++++++++++++++++
>  include/net/bond_options.h           |  1 +
>  include/net/bonding.h                |  3 ++
>  5 files changed, 87 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


