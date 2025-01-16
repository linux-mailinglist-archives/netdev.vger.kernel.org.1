Return-Path: <netdev+bounces-159010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A22AA141D5
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 19:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C31867A42B5
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 18:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABC11DE894;
	Thu, 16 Jan 2025 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HED3D8cq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EAD146A6F
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737053216; cv=none; b=eZxedjmrXIaUTBabxZ4UZ8DRIyx65CrhOHRqaLivFFGUtIyMHO1otzY/arUCcydXNRwszJojESz8RmwcFWEpgVTWjVX5tkFzLZjiXm426WgtdvPBJ4TOJp/CBhfFiWa8jlhSsoRGMG+qivgnGgGJjEFOevwTGgXcxVpkUVmLIrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737053216; c=relaxed/simple;
	bh=HqyzavM0Be6QtnQKHZU1oZ2hQoTllXVXbKzkjvTVh6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ao1b27vkb2j9lD5RkLZQH+OM5E4nbVAHXsck6F6g0RDaZ2IPUw6z+8FR8X86RmnMK2y+QblPhtX4ti9x06GHP8O81DxNP5RRc8Sfd6QmYIKwvJwhMw45mqrcy0s94xEQUuXk/B8Q1qdVIxSnlhaTlAiIjBfYxeZsdlHUyOQnPis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HED3D8cq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaec111762bso259142366b.2
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 10:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737053213; x=1737658013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hn34pIYis1XbpEZH+23P+y9HINFuHXmExfm5PMagOtg=;
        b=HED3D8cqYLyQaTv21M96/Yk8ohS5Fchx1N1N9Ikdzf7r3zto2V0CsZPErQLlY7YbSC
         efhiMB/1w/zPLnevu6mzmYxN3LKlobmAIqaev2XFOo44yYuHst/nWATPEHRJN1CusDzR
         qMsyAwcnwV73QfsbkjmXth+A8vXjRW915H9wLvMNFUzwWldZrlT2cXzia8obSHDE89t1
         BtkLj/jgkajdFw5afOJYtT96dmorc2PDfW2dWCd3DZ0ZloBcxn/ZxUkkBez+GpdjuHjb
         ezne9kyKlUA7LddsQHWQnUuPCB6vKJLKsUOWLVlIOmuUT52K/at+Fxbqi2DGdpmffYWA
         fqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737053213; x=1737658013;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hn34pIYis1XbpEZH+23P+y9HINFuHXmExfm5PMagOtg=;
        b=CVj4xN+/QY34nV1u5gYOxSLWsUVJv980YdKUMiaH5oSeJ8MycBOssRP8BPwCChGO7i
         96l6EN+eZCprEj3PV5rmISt1wIcXohs/pC26yKkcvyuZOaTeSID9HEIRbXavCzIsSTJ4
         KG3XIjk/YEYikG9U4EDa21XQ2ZMYzpz+zjv5JXuZ2U+9UIfpe/VRvczCKP9vq8dPGt3h
         5dGF3RTkic5OW3CqOKyMbCaCOqkg6tU/X6jgUbugEoYE/+N/DviwBBYYrIyw58DI587o
         Ppw2VudccvRCJL6xPb2+rTTktNcSG3ASTDcz+mH6EPRux2TIq0l7IyMjqWpAdHiKTAPs
         k1PA==
X-Forwarded-Encrypted: i=1; AJvYcCX/VKGp/fDXMYPPtyFiQnUemUXPEmSN3mesrXOXVnYJE0eCMQf1+NHBisyVXW56StKyh+Zk4lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFrbWVmj3NCq/YXBfNzch1RDDE2I6QnBkAVhhzxt29bYVKfklI
	Ehm+zgI51gOqqBjS2h2StdZZqFUDtoG8Sbj4sjm0rBNLYtBeHzVLJ0Blkg==
X-Gm-Gg: ASbGncsvduzZ5kCC/wX0jiC2wGHA34GQqc8yKiTNINYIWoVYCU97h6PemvGOGFYChRy
	qJObEovyD5RaINMAbsFZEnR0lb/JFvSUtOnztLIiiOWIYLDsg9jA/YAPqPG/WIDmkK81iflm6tF
	hRX8iPbPMIs1u5IXKj9gKCf33K43NFAnyPRgSHS3BjfXUrxUz3Pa9VZ0Fom+r93Zan9EaByCpFP
	dAedj1DEZqD18+1QM/YTiWbhbvL8S3/5fMm/guvXnp6/9Q49eT+99hJ52kcBc8wB1tKcKFdHlxb
	4eTjnDzE7keBYhnb2FsBpNpy6fWOoOFupw4CehAQr9iXQSb5MbCDE9q5uwtpvBSGOZTyNS7Zigs
	aGVhTZdUj2tq3uisDAT0iz5CXfgyMtOk=
X-Google-Smtp-Source: AGHT+IFg0nlWm6C0R4H6wyRfdIfOLDqbSNy9MULdTVGRjUlUuo6LuvaQXdVDzkFPt5olwDmdWUZf8w==
X-Received: by 2002:a17:907:3f09:b0:aae:fb7c:50df with SMTP id a640c23a62f3a-ab2ab748e82mr3046654766b.36.1737053212971;
        Thu, 16 Jan 2025 10:46:52 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384d2dee0sm33717266b.78.2025.01.16.10.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 10:46:52 -0800 (PST)
Message-ID: <f20c9744-3953-40e7-a9c9-5534b25d2e2a@gmail.com>
Date: Thu, 16 Jan 2025 19:46:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net: phylink: always do a major config when
 attaching a SFP PHY
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <E1tXhIJ-000me6-SA@rmk-PC.armlinux.org.uk>
 <Z4hCiwfLL2q2rIMM@shell.armlinux.org.uk>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <Z4hCiwfLL2q2rIMM@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/16/25 12:19 AM, Russell King (Oracle) wrote:
> Hi Eric,
> 
> I'd like to get a tested-by from you before sending this for merging,
> as this should fix your reported issue.

Tested-by: Eric Woudstra <ericwouds@gmail.com>

It works ok, thanks.

The kernel log shows:

[root@bpir3 ~]# dmesg | grep eth1
[    2.515546] mtk_soc_eth 15100000.ethernet eth1: mediatek frame engine at 0xffff800082300000, irq 123
[   41.406446] mtk_soc_eth 15100000.ethernet eth1: configuring for inband/2500base-x link mode
[   41.414819] mtk_soc_eth 15100000.ethernet eth1: major config, requested inband/2500base-x
[   41.422983] mtk_soc_eth 15100000.ethernet eth1: interface 2500base-x inband modes: pcs=01 phy=00
[   41.431936] mtk_soc_eth 15100000.ethernet eth1: major config, active inband/inband,an-disabled/2500base-x
[   41.441523] mtk_soc_eth 15100000.ethernet eth1: phylink_mac_config: mode=inband/2500base-x/none adv=00,00000000,00008000,0000e240 pause=04
[   42.370423] mtk_soc_eth 15100000.ethernet eth1:  interface 2 (mii) rate match none supports 0-3,6-7,13-14
[   42.380034] mtk_soc_eth 15100000.ethernet eth1:  interface 3 (gmii) rate match none supports 0-3,5-7,13-14
[   42.389698] mtk_soc_eth 15100000.ethernet eth1:  interface 4 (sgmii) rate match none supports 0-3,5-7,13-14
[   42.399441] mtk_soc_eth 15100000.ethernet eth1:  interface 22 (1000base-x) rate match none supports 5-7,13-14
[   42.409348] mtk_soc_eth 15100000.ethernet eth1:  interface 23 (2500base-x) rate match none supports 6-7,13-14,47
[   42.744938] mtk_soc_eth 15100000.ethernet eth1: PHY i2c:sfp-1:11 uses interfaces 4,23, validating 4,23
[   42.754256] mtk_soc_eth 15100000.ethernet eth1:  interface 4 (sgmii) rate match none supports 0-3,5-7,13-14
[   42.800352] mtk_soc_eth 15100000.ethernet eth1:  interface 23 (2500base-x) rate match none supports 6-7,13-14,47
[   42.810541] mtk_soc_eth 15100000.ethernet eth1: PHY [i2c:sfp-1:11] driver [RTL8221B-VB-CG 2.5Gbps PHY (C45)] (irq=POLL)
[   42.821312] mtk_soc_eth 15100000.ethernet eth1: phy: 2500base-x setting supported 00,00000000,00008000,000060ef advertising 00,00000000,00008000,000060ef
[   42.835035] mtk_soc_eth 15100000.ethernet eth1: requesting link mode inband/2500base-x with support 00,00000000,00008000,000060ef
[   42.846675] mtk_soc_eth 15100000.ethernet eth1: major config, requested inband/2500base-x
[   42.854847] mtk_soc_eth 15100000.ethernet eth1: interface 2500base-x inband modes: pcs=01 phy=00
[   42.863616] mtk_soc_eth 15100000.ethernet eth1: major config, active phy/outband/2500base-x
[   42.871966] mtk_soc_eth 15100000.ethernet eth1: phylink_mac_config: mode=phy/2500base-x/none adv=00,00000000,00008000,000060ef pause=04
[   43.590342] mtk_soc_eth 15100000.ethernet eth1: phy link down 2500base-x/Unknown/Unknown/none/off
[   43.607350] brlan: port 5(eth1) entered blocking state
[   43.612481] brlan: port 5(eth1) entered disabled state
[   43.617707] mtk_soc_eth 15100000.ethernet eth1: entered allmulticast mode
[   43.624679] mtk_soc_eth 15100000.ethernet eth1: entered promiscuous mode
[   47.700338] mtk_soc_eth 15100000.ethernet eth1: phy link up 2500base-x/2.5Gbps/Full/none/rx/tx
[   47.700357] mtk_soc_eth 15100000.ethernet eth1: Link is Up - 2.5Gbps/Full - flow control rx/tx
[   47.717579] mtk_soc_eth 15100000.ethernet eth1: No phy led trigger registered for speed(2500)
[   47.734637] brlan: port 5(eth1) entered blocking state
[   47.739782] brlan: port 5(eth1) entered forwarding state


