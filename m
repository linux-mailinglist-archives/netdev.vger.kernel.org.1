Return-Path: <netdev+bounces-238499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C8CC59DC4
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 20:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 640CF4E1AD4
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 19:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D413191C8;
	Thu, 13 Nov 2025 19:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZacZZ0i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226493161A7
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763063666; cv=none; b=E0tC9Zyqwx69ONRMWy7a+feNLmR/5SNzTNVa/te8eGebPguXto3d1QJEmNQLCHy+XgiB+1A5uJ/x/micDUmtVol1UkHYGiYbWAD6jBzTMzJnVIzKQizS6b1RhefNFZYNrhINOYgmJU2EVN9wkPQNh7BiFum5gDKTZ2JFD5TpU3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763063666; c=relaxed/simple;
	bh=ZyjV2zlsY/WOAoLtkkIIvmgL/cI2LzWDSXHVZ4vJByI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=au8XWLaATbYB9UtuVpO5DOARszOuxfkmOjkAVYJClVSFyt9ZMgtlcEdSxAD/eKNg7p5K6suMbl1q1haf3rHffFytxI2/K2WGWvPeSo7Rsc5o75Nrg2CbcQeoAT4nTDRrOObavBSztQmYO8jPvr3fDlB8+t36WwWQ1QE0ueIVfVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZacZZ0i; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429c7869704so956402f8f.2
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 11:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763063663; x=1763668463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5uYFQBdMWcIjFGr35Hs8SoiXsZLoaRgbd8GnG/6s5g=;
        b=lZacZZ0iMyIhr6YIqRJ+mCxtBwNgWsjmHF9kjNOIti1QcWydYOo1KuGy+4s3AvZ3rS
         zI3/+EDb6MK+FlSMhE0KCycl3+12BV/HZkZQvhws1JGxdyVIqQTeAOZ3LTGtWZajdNRp
         4NvmVqmmttuT8c/MapM5gZUmzcQCyeCp9V0D57gZxa8ezCghN6+KCJyYzdmh5AvxtRYq
         JWeRnGdh1cAoPrwmQSe0bnjeWp1PCFMzsffyPKAfSshgGLGB30dumg6RGiWXQicexOhj
         ZeEsq/LagrvN8BxYqGmsXWeqg1+zlJemmllMBY1qOsQUGaymY9oSyoyc+9abuQeoE/Hy
         zJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763063663; x=1763668463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5uYFQBdMWcIjFGr35Hs8SoiXsZLoaRgbd8GnG/6s5g=;
        b=MC7Ty+3kjdA2qj/OUSoQZxBK/mkUMZOpcYcv0VZdkW+QalQWUFXaPJNAaMAZNEbfH3
         kOkkc3EVG0s0GiGgb2xHFOPYFH+RJYKQ7TDjpKEHUfLSwrgYuc5E6v2a65Y6xioSaAuG
         e6yjZqUHyMfIWOXvq3aA8vFrZufXmSYCZSssEsvPSF7cXKXmiYOzxw/imfFTUtrBbqil
         Ksyyoi8u/Ax4dq5OnPfMNJ6QtKjX92J5MFojWQzvWA4sLfZP0v0RF5F+F+GVwj+dhY/0
         8pGD9eLW2qJYx5Ka7qekmXCZaCfsb3P3ObvnVBCnRc5WRromOrCVygF7OYsRE6w8w31+
         NMmA==
X-Gm-Message-State: AOJu0YwOPSCioMV7190tND5RtQ3c8xHfF2YXnePil0JAyBRl1gnJCORu
	Paueu8Llh3OmcGEu56wAP/fXgz9A7CTib0N1+8ZRH6DkWKVYSuIwiD6q
X-Gm-Gg: ASbGnct91rorRa/Q2SpQnFSy/RgNGgqosDgI1lw1BfFfYcN7TtVehYG+UMibEqEztTh
	7yxhT7CVaXmfpUnOrvl07Xjl8s5ws0nHc/0DPmUlYA0h0nedfoj0rrKqAHFy+52oPWdaxWR+7AR
	vQlODUNG4ztAXsDuty3hdNKogQTyR/I4CxXd8Lv5dgues4XXbDsPL+9pJXPwaH44PHkKLsr/Ek9
	qu7P0k5NWtGFmQX6Mr0a/2v0JnKvkn3OK3TIRr+djAzIdioK7TXlsdqOToxRKAz80rJVCoDWO82
	6kfexEqe7n+AqqLlmSXU13ymEUdaSGPtgmJ8XkHw7QkJaDP3VDJEeVOk5IK0KKQw4b0zPcq5wgM
	W/V3bKxodHxZDemSaA+6Vu/v12BBpPDUEOG6dHPlXScQF529t0c1v3GxH0FELfcRaZfup+WqKk9
	yvW3lDFd38dLVh8CwnEaCaLzd8lcvvStNR+YVWqqZWA8mxXt0hjJzv4sI5Zyefgkz8xt0REV1LT
	QWesNPcYJHcxxBOGSrISgNuXt75pu6nfdlsj8wd
X-Google-Smtp-Source: AGHT+IEipqfeC6tnR4E+RYRLZQ2qkZIf7SMyeSRFtEeLv72w+gK7Zn/6tP4YjNStULDMG+h+pb3+PQ==
X-Received: by 2002:a05:6000:25c2:b0:42b:39d0:6377 with SMTP id ffacd0b85a97d-42b593494b7mr565151f8f.17.1763063663227;
        Thu, 13 Nov 2025 11:54:23 -0800 (PST)
Received: from ?IPV6:2003:ea:8f4e:1a00:f17f:a689:d65:e2b2? (p200300ea8f4e1a00f17fa6890d65e2b2.dip0.t-ipconnect.de. [2003:ea:8f4e:1a00:f17f:a689:d65:e2b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f1fd50sm5527838f8f.38.2025.11.13.11.54.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 11:54:22 -0800 (PST)
Message-ID: <67c7ccab-2377-46bf-b59d-01a6d8d7e8f4@gmail.com>
Date: Thu, 13 Nov 2025 20:54:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RTL8127AF doesn't get a link over SFP+ DAC
To: Michael Zimmermann <sigmaepsilon92@gmail.com>, nic_swsd@realtek.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAN9vWDK=36NUdTtZhPMu7Yh15kGv+gkE35A93dU0qg01z5VkbA@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <CAN9vWDK=36NUdTtZhPMu7Yh15kGv+gkE35A93dU0qg01z5VkbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/2025 6:30 PM, Michael Zimmermann wrote:
> Hi,
> 
> I have a RT8127AF card from DIEWU:
> https://24wireless.info/diewu-txa403-and-txa405 .
> The card is detected just fine:
> [125201.683763] r8169 0000:08:00.0 eth1: RTL8127A, xx:xx:xx:xx:xx:xx,
> XID 6c9, IRQ 143
> [125201.683770] r8169 0000:08:00.0 eth1: jumbo features [frames: 16362
> bytes, tx checksumming: ko]
> [125201.688543] r8169 0000:08:00.0 enp8s0: renamed from eth1
> [125201.715519] Realtek Internal NBASE-T PHY r8169-0-800:00: attached
> PHY driver (mii_bus:phy_addr=r8169-0-800:00, irq=MAC)
> [125202.277034] r8169 0000:08:00.0 enp8s0: Link is Down
> 
> This is what ethtool shows:
> Settings for enp8s0:
>         Supported ports: [ TP    MII ]
>         Supported link modes:   10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>                                 1000baseT/Full
>                                 10000baseT/Full
>                                 2500baseT/Full
>                                 5000baseT/Full
>         Supported pause frame use: Symmetric Receive-only
>         Supports auto-negotiation: Yes
>         Supported FEC modes: Not reported
>         Advertised link modes:  10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>                                 1000baseT/Full
>                                 10000baseT/Full
>                                 2500baseT/Full
>                                 5000baseT/Full
>         Advertised pause frame use: Symmetric Receive-only
>         Advertised auto-negotiation: Yes
>         Advertised FEC modes: Not reported
>         Speed: Unknown!
>         Duplex: Unknown! (255)
>         Auto-negotiation: on
>         master-slave cfg: preferred slave
>         master-slave status: unknown
>         Port: Twisted Pair
>         PHYAD: 0
>         Transceiver: internal
>         MDI-X: Unknown
>         Supports Wake-on: pumbg
>         Wake-on: d
>         Link detected: no
> 
> and `ip a`:
> 10: enp8s0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc
> fq_codel state DOWN group default qlen 1000
>     link/ether xx:xx:xx:xx:xx:xx brd ff:ff:ff:ff:ff:ff
>     altname enxXXXXXXXXXXXX
> 
> And that's it, the link never comes up. The 10G Mikrotik switch on the
> other side sees that the module is inserted on its side, but doesn't
> show any change when I plug in the RTL8127AF.
> 
> It works in Windows 11 and it also works with the r8127 Linux driver
> downloaded from Realteks website:
> https://www.realtek.com/Download/List?cate_id=584 :
> 
> [129318.976134] r8127: This product is covered by one or more of the
> following patents: US6,570,884, US6,115,776, and US6,327,625.
> [129318.976175] r8127  Copyright (C) 2025 Realtek NIC software team
> <nicfae@realtek.com>
>                  This program comes with ABSOLUTELY NO WARRANTY; for
> details, please see <http://www.gnu.org/licenses/>.
>                  This is free software, and you are welcome to
> redistribute it under certain conditions; see
> <http://www.gnu.org/licenses/>.
> [129318.988293] r8127 0000:08:00.0 enp8s0: renamed from eth1
> [129318.997092] enp8s0: 0xffffd49ec9140000, xx:xx:xx:xx:xx:xx, IRQ 137
> [129319.421629] r8127: enp8s0: link up
> 
> ethtool with realteks driver shows something quite interesting:
> Settings for enp8s0:
>         Supported ports: [ TP ]
>         Supported link modes:   1000baseT/Full
>                                 10000baseT/Full
>         Supported pause frame use: No
>         Supports auto-negotiation: No
>         Supported FEC modes: Not reported
>         Advertised link modes:  1000baseT/Full
>                                 10000baseT/Full
>         Advertised pause frame use: No
>         Advertised auto-negotiation: No
>         Advertised FEC modes: Not reported
>         Speed: 10000Mb/s
>         Duplex: Full
>         Auto-negotiation: off
>         Port: Twisted Pair
>         PHYAD: 0
>         Transceiver: internal
>         MDI-X: on
>         Supports Wake-on: pumbg
>         Wake-on: g
>         Current message level: 0x00000033 (51)
>                                drv probe ifdown ifup
>         Link detected: yes
> 
> auto-negotiation is off, even though it's enabled on my Mikrotik
> switch. "ethtool -s enp8s0 autoneg on" (or off) on the realtek driver
> succeeds but doesn't change what ethtools status shows. "ethtool -s
> enp8s0 autoneg off" on the mainline driver does fail with:
> netlink error: link settings update failed
> netlink error: Invalid argument
> 
> So while I have no idea why things are not working, my best theory is
> that auto-negotiation isn't supported (properly) and the mainline
> driver doesn't support disabling it.
> 
Realtek uses a proprietary way to deal with the SFP and hides it
behind the internal PHY. The SFP signals aren't exposed.
When in fiber mode the internal PHY doesn't behave fully compliant
with clause 22 any longer. E.g. link status isn't reported by the
PHY, but only via a proprietary register.
To cut a long story short: Fiber mode isn't supported by r8169
at the moment.

> Thanks
> Michael


