Return-Path: <netdev+bounces-220053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAF6B444F6
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD85A41EB5
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C9C1BC3F;
	Thu,  4 Sep 2025 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="kmv05GTW"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2697D322775
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 18:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008923; cv=none; b=V//ZjtjtRDVIKjMaREkEvT3y45OX1Mzr6eKxdaiwgKXvGW8M/8fkHsrulgKAyuTHRmToPn+PES3Jc4mQTly/GLk5T6VRLvZkC/QjnZ8VMqz9yqLyioRh5ez6oVyxN+E4Ty+9mzx9n3RptniIGflXCKR4vLjYTHoWyWdzZ3KgqeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008923; c=relaxed/simple;
	bh=hvzoltZOaVGiVcZvsR/TaiLtetdo1Pq5nrgn7tZnD/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKYqldQtKY9grRZq7kHngkgHl77QCKzekq5ELqsjr+5xKGbuo9YPVJeDLgRYkY6Shhnzet4Cniviah0MUSG5yyxshnBrOfxSxX++1LS5cRupHD3f4BCLu+/FyzaZ7+KaF7D7yIDbRdpUlc17hVHj69kbwyIToQqXZeUtWJ4Chbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=kmv05GTW; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1757008904; x=1757613704; i=wahrenst@gmx.net;
	bh=qlAbyoyjGgLUTV0kGYydzoxSqdR6vVMn5w3CbFC8mXI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kmv05GTW1fbuw7IslAoyJHwb4JExdyB5ka6hpKGOvf2LlcPkz9xg5Z1K/AG7tF50
	 u9GJsF+x0Ph/xecEc/ItwEdupvojM+ww1B6FJy7uMNt70n1oVtun8Vq+upJSf3AIO
	 LViX5TYhFM+gIfAPyTb5ltoh1soSF0ScY1Z9cyG1MaDtrgyZumtomwulxs8PT86pP
	 KV8AeKRQ7uoBBFNGq3ZXFoYJHEOcepaCUTsWA2iKnX5bKQVuuMipe02ijbE3FIHPU
	 nH++AX5heHXNWsSlMG3Iqu5xafhORpDpSq4xZw0yNlphC+8HXCMME9L4Fk7XP/HvJ
	 oEV0oPaDWmZQnFd7Cg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([79.235.128.112]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZktj-1uzx4Z2Gwx-00Z32N; Thu, 04
 Sep 2025 20:01:44 +0200
Message-ID: <0ae16ef0-45d7-4775-a825-87a352fc03e0@gmx.net>
Date: Thu, 4 Sep 2025 20:01:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: fec: Fix possible NPD in
 fec_enet_phy_reset_after_clk_enable()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, imx@lists.linux.dev,
 netdev@vger.kernel.org,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>
References: <20250904091334.53965-1-wahrenst@gmx.net>
 <20250904065836.5d0f4486@kernel.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20250904065836.5d0f4486@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pnUMh0C2vBwTT6CzYjtYcDCM8qG3Xb0LE4CZtMgRS7uTEJ7aCiv
 zBj98roRmie9w6CluWowYE0r9Ez6RJWoTOe/fBlA7QJkYHiZsEOiuPEHKW6W04st4m9iimD
 +MOjODNV4nq54fc2EzEzOeSXmK+VVb98vT9wien9Xpr39GD2EwyCoeHDfUQiAjfL59JUM68
 OrxO2Ns3KhVHe4FzMuU/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FiPGjVJP6Cc=;T9UrLn0ipMLiiTUCECyVqRXdCnH
 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

Hi Jakub,

[drop bouncing address]

Am 04.09.25 um 15:58 schrieb Jakub Kicinski:
> On Thu,  4 Sep 2025 11:13:34 +0200 Stefan Wahren wrote:
>>   		phy_dev =3D of_phy_find_device(fep->phy_node);
>>   		phy_reset_after_clk_enable(phy_dev);
>> -		put_device(&phy_dev->mdio.dev);
>> +		if (phy_dev)
>> +			put_device(&phy_dev->mdio.dev);
> Looks correct, but isn't it better to also wrap
> phy_reset_after_clk_enable() with the if()?
since phy_reset_after_clk_enable() have an internal check, i thought it=20
won't be necessary. So this variant has fewer lines.

Best regards
> Up to you..


