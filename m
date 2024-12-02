Return-Path: <netdev+bounces-148041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7AF9DFFCB
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 12:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC42281F23
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 11:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0302C1FCFF6;
	Mon,  2 Dec 2024 11:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="CbdEhWDn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F7D1FCFE7
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137789; cv=none; b=sOSyeF0aQKbR+souuUSVaoUBp51GEQdNs86HT9TztDH+eJ8jGSC82aVqLVfF3CcUBtqlb/Avb3b5LkJnXH8xkD3dfsls5C8XALxejjcYrenT0W7wiPsAm2Sqjdva5QUOUPx5uUugY6Pty35SMnHxhkcJcvv6rHGH5jSF/KwWWyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137789; c=relaxed/simple;
	bh=qUcESZ0YUaBtbhD+aoGet9WbGSp2Qo1gyt7ZDRohhNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWPAHDdyodtFL+gIf3YLbxn6fIlGOwM3Aw+pLxXDPEloac3FbR119bLKXpXgKOzT/rqC47VpFxQCHZnfiG6VNBqw0Cx302D9OqTvWQ7+7Wue7v2rxd+fjna1VbJXreUKtmqVnpxCaFUlaCbgsHBl/nhn0zeuH1c7sYutVhvnm8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=CbdEhWDn; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffc3f2b3a9so52125381fa.1
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 03:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733137786; x=1733742586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JIz3utMm0/sU5BMr5sIEd+mlpszlZQSMeIY1+TfyJxY=;
        b=CbdEhWDnrF5LHf8ong5EQLwqU++3HIUr6JWW9UhSDEUGeGqZ1xZpkSy1qV+nUgc1GQ
         KmrqeSUDUCn/TbP0SDiCtPDWuOLbf9F2g2v459mK8+QXP08G1cfQPpJ4sfeMjdMMNLlr
         GC5fhshN6b4Gk8kUr1KOpMGYsHuiga5QmPo7XkxTFcXoEwqlL+pqL96d9SaF1mRrn9L9
         A3HkCbMu9C/7P21fQmV6R3gjdhrsY2gNVWrzI+3BZn5ami3i/P8xwuQXsKsnAFo2HV69
         LsZzZjeVo5ZlLZrVBl859FG3+auRIp+a/cKGfXK/KROWiDMPaXbBRNs5rCqbOGEQK7Kr
         g5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733137786; x=1733742586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JIz3utMm0/sU5BMr5sIEd+mlpszlZQSMeIY1+TfyJxY=;
        b=a7lyMylJjOegQVAeSUMOUPkht/2m4sVi3lvAKRbeuaqjnB9X18UKokaLa1Ids1AAwX
         I430m3o+lj6VXh0E2g7pa8eAz/HvN0k23jPZQmr1sPezoQcuYLAtqyKABkobW6XK7oS0
         /PgrruIjNi3cUZTlkJPeYpCI4IOhPwKbfKTrRHeKdvIE01sBigWsID/4nDhPvbcTxpSO
         f7TZdWgx3vojVkGrQI76p7y5q38uUn85/jHfgn/3KnFeXCKGr7YfTc8A5GCOf/zyr39r
         LUn5NzXWDDto4RJ5SkWMAd7heHMNcz7woN+PMDZorqhM0OVQ1bArq6hsBc/U7CqPbi4H
         VZTg==
X-Forwarded-Encrypted: i=1; AJvYcCXcqmg8nVInQcS/EpJVRd5bcOvqa936BDQvH37bIbyP9wlDJlDJTbCXCltSvUTmuVSKfX4oPgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT8DckMSBolE7f325SEGToTGjPN9KSkRGVlYwJqE4IHygVJHSu
	M2hnm3/lFMC6XjMLKACJzLYaGim2YBRnh9H7rKfe5ztQhfJM43bFlnNvK7phhos=
X-Gm-Gg: ASbGncsu0YGvTmM0lxd2u7dT5OnboX1xPcHfjgatjGulQrJNSzN67+PfvleS4fKD+0F
	V/SrNHbA57jTk7Mtwfp4cu/ibbF5FbzkjJHa++DxfDECpNJkktO5NQykbAiXTb/+wp9wMwvLftu
	InqvKgA/uJ+jbYFxoQrcjAu8jHdmSD5lpT7rX034pE1vAbYqJOgRaA/xMn0r7Y7W19CxYv97w8j
	yPf3AM7FRUcUkxmf2D0e8tIR4xeoOVlH+qGwuf4Ic+jW55mjgJK/TRbKQiEYFxAera8eA==
X-Google-Smtp-Source: AGHT+IHAvBtf0OQXFo4WX8SQik/WEe881XNPtRWavelPBjYiw87rg6F4KhsnlxUq7isC2k5Va1zqnw==
X-Received: by 2002:a05:6512:3e1e:b0:53d:eced:f634 with SMTP id 2adb3069b0e04-53df01171b4mr16308916e87.48.1733137786215;
        Mon, 02 Dec 2024 03:09:46 -0800 (PST)
Received: from [192.168.0.104] ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df649f6dcsm1421513e87.243.2024.12.02.03.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 03:09:45 -0800 (PST)
Message-ID: <c1296735-81be-4f7d-a601-bc1a3718a6a2@cogentembedded.com>
Date: Mon, 2 Dec 2024 16:09:43 +0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: phy_ethtool_ksettings_set: Allow any supported
 speed
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Dege <michael.dege@renesas.com>,
 Christian Mardmoeller <christian.mardmoeller@renesas.com>,
 Dennis Ostermann <dennis.ostermann@renesas.com>
References: <20241202083352.3865373-1-nikita.yoush@cogentembedded.com>
 <20241202100334.454599a7@fedora.home>
 <73ca1492-d97b-4120-b662-cc80fc787ffd@cogentembedded.com>
 <Z02He-kU6jlH-TJb@shell.armlinux.org.uk>
 <eddde51a-2e0b-48c2-9681-48a95f329f5c@cogentembedded.com>
 <Z02KoULvRqMQbxR3@shell.armlinux.org.uk>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <Z02KoULvRqMQbxR3@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> Right now, 'ethtool -s tsn0 master-slave forced-slave' causes a call to
>> driver's ethtool set_link_ksettings method. Which does error out for me
>> because at the call time, speed field is 2500.
> 
> Are you saying that the PHY starts in fixed-speed 2.5G mode?
> 
> What does ethtool tsn0 say after boot and the link has come up but
> before any ethtool settings are changed?

On a freshly booted board, with /etc/systemd/network temporary moved away.

(there are two identical boards, connected to each other)

root@vc4-033:~# ip l show dev tsn0
19: tsn0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
     link/ether 3a:e3:5c:56:ba:bd brd ff:ff:ff:ff:ff:ff

root@vc4-033:~# ethtool tsn0
Settings for tsn0:
         Supported ports: [ MII ]
         Supported link modes:   2500baseT/Full
         Supported pause frame use: Symmetric Receive-only
         Supports auto-negotiation: No
         Supported FEC modes: Not reported
         Advertised link modes:  2500baseT/Full
         Advertised pause frame use: No
         Advertised auto-negotiation: No
         Advertised FEC modes: Not reported
         Speed: 2500Mb/s
         Duplex: Unknown! (255)
         Auto-negotiation: off
         master-slave cfg: unknown
         Port: Twisted Pair
         PHYAD: 0
         Transceiver: external
         MDI-X: Unknown

PHY driver is out of tree and can do things wrong. AFAIU it does nothing more than wrapping Marvell 
setup sequences into a phy driver skeleton.

Still, with the patch in question applied, things just work:

root@vc4-033:~# ip l set dev tsn0 up
root@vc4-033:~# ethtool -s tsn0 master-slave forced-slave
[   83.743711] renesas_eth_sw e68c0000.ethernet tsn0: Link is Up - 2.5Gbps/Full - flow control off
root@vc4-033:~# ethtool tsn0
Settings for tsn0:
         Supported ports: [ MII ]
         Supported link modes:   2500baseT/Full
         Supported pause frame use: Symmetric Receive-only
         Supports auto-negotiation: No
         Supported FEC modes: Not reported
         Advertised link modes:  2500baseT/Full
         Advertised pause frame use: No
         Advertised auto-negotiation: No
         Advertised FEC modes: Not reported
         Speed: 2500Mb/s
         Duplex: Full
         Auto-negotiation: off
         master-slave cfg: forced slave
         master-slave status: slave
         Port: Twisted Pair
         PHYAD: 0
         Transceiver: external
         MDI-X: Unknown

root@vc4-033:~# ip a add 192.168.70.11/24 dev tsn0
root@vc4-033:~# ping 192.168.70.10
PING 192.168.70.10 (192.168.70.10) 56(84) bytes of data.
64 bytes from 192.168.70.10: icmp_seq=1 ttl=64 time=1.03 ms
64 bytes from 192.168.70.10: icmp_seq=2 ttl=64 time=0.601 ms
...

