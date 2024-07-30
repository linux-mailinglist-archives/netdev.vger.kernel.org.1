Return-Path: <netdev+bounces-114107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB94F940F81
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E1F1C209AD
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D794B166300;
	Tue, 30 Jul 2024 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PD9tY4PT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494A140BF2
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335412; cv=none; b=YAczcH1fzOfqKqaZZyDFlbNfZx/3BoQ/Aj1Mfxhd/wLn9JSKW2atXG7Rr0SnV4AoLXZyfu1Iyeb1bDAUVXeY9+xwyzha5eveJw8rcj0zlDBq7JjGx0gYflb8lu3zRUTPX/J80T+9OQPFVpBDR4xIJoJbqWR/yafveiezJQwZadc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335412; c=relaxed/simple;
	bh=O9SbpH6gaHIzGnpq5yhKSvdFI//O+nZc1t9nY3SdA0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eO8HfRmvByLofz+pnTlL2tspPS9kUufHanR8uFsAGciWy38lvpqIjy9SSQRZLyJxek3URGAIL8kHwYPt/k0lugPgR3sFslZYq6P1dby66/ynw8LtDKIxIi8h5/D9URbawiaJSxCvfrENJJj/lpfzfAuaYwEH3uOXuZnCnEjEkOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PD9tY4PT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722335409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71oJ12BexAxBLwTBNsEMg163ErQlFG2G4IQL0JA3vsQ=;
	b=PD9tY4PTVeaASgSiURSw0LbigeW2TvU6Xx7+7XEvAE+mYM1C7pZC7O9UsOspPA5QyMNIcp
	30oxJeN8vHOMlzWbCNk6FQnH0g1qhy7smn8ic9/1IrYmpEHuHAzUojWpL/Kw+VQPL8jH1G
	JlnIcTPR7GvDVdGfa/ETWQgsYVzq+YY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-zv-mnwr5Orqa_27JB6czKg-1; Tue, 30 Jul 2024 06:30:07 -0400
X-MC-Unique: zv-mnwr5Orqa_27JB6czKg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42809bbece7so2185305e9.0
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 03:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722335406; x=1722940206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71oJ12BexAxBLwTBNsEMg163ErQlFG2G4IQL0JA3vsQ=;
        b=EHts2MjPgQ0olTzFPgvHbIO654A1Pzau+qccY0Jzk9/5Lup1ahGfZ0AkAda+/61ZkZ
         j1gk1kLI/acoXGbS/CijZWO+2U8Tav4z4htNslE92Unn4iPg4R8HhQVwgZogIgNj2jHf
         CDAZUBBoQ/E2skfNz0xuopG7q1RTC/jIB5E6Rk06Fnp0oFhR7HRd/Qq8u1Ln1N5skcFl
         pDwBZtfrEo+4RnTfVPHHsuxkR7ppUUwmwGn6ehPbbP3bcnR250rHZLElQcdtnHNDPUh/
         RSQ0dNns4UmkeEyIO/DlwKzmdPZxEaZ80MhtzQ7Tp1OEd7jNdRqIR8BKnR9zCH8Smevw
         5b9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBtDYowMEmhT7oGMmzDDMIefYEfggBO2QWAaTq4XsNZXgQJ9MfbX2kBCtxe/qgoJsX3tIRQI9IP52hAJeVW9KnBAnM5qsS
X-Gm-Message-State: AOJu0YwjMdozUcnG/CUBgz1+iYloTN6EVar8IdiSWHD0edveruCV1vYY
	0RKOa5jGebEUVqMc4afr68Wp4dRhscAowHPa8U55NCpLdrZuU3biOlh/ATt+k/nEHYc836hY504
	poYZEzFvSYVO5JwjuIvnGINtcUAlzZgmy6EUwJdduznNpUMcdMWGV9Q==
X-Received: by 2002:a05:600c:5113:b0:428:18d9:4654 with SMTP id 5b1f17b1804b1-42818d94831mr34713975e9.6.1722335405984;
        Tue, 30 Jul 2024 03:30:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE78IgR8WxTBbit7KcSMrv8J8w859v4JL3/v1Vk6XrSheVtSe3hh+vqkGPAcKITQxqhvXEW6A==
X-Received: by 2002:a05:600c:5113:b0:428:18d9:4654 with SMTP id 5b1f17b1804b1-42818d94831mr34713765e9.6.1722335405555;
        Tue, 30 Jul 2024 03:30:05 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410:9110:ce28:b1de:d919? ([2a0d:3344:1712:4410:9110:ce28:b1de:d919])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857dc2sm14269596f8f.77.2024.07.30.03.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 03:30:05 -0700 (PDT)
Message-ID: <37af317c-a40c-4af3-840a-5bbedad2e31b@redhat.com>
Date: Tue, 30 Jul 2024 12:30:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ethernet: mtk_eth_soc: drop clocks unused by
 Ethernet driver
To: Daniel Golle <daniel@makrotopia.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <5f7fc409ecae7794e4f09d90437db1dd9e4e7132.1722207277.git.daniel@makrotopia.org>
 <20240729190634.33c50e2a@kernel.org>
 <738f69e6-1e8d-4acc-adfa-9592505723fe@redhat.com>
 <Zqi-zr32ZXl0AyzR@makrotopia.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Zqi-zr32ZXl0AyzR@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/30/24 12:22, Daniel Golle wrote:
> On Tue, Jul 30, 2024 at 10:53:19AM +0200, Paolo Abeni wrote:
>> On 7/30/24 04:06, Jakub Kicinski wrote:
>>> On Mon, 29 Jul 2024 00:00:23 +0100 Daniel Golle wrote:
>>>> Clocks for SerDes and PHY are going to be handled by standalone drivers
>>>> for each of those hardware components. Drop them from the Ethernet driver.
>>>>
>>>> The clocks which are being removed for this patch are responsible for
>>>> the for the SerDes PCS and PHYs used for the 2nd and 3rd MAC which are
>>>> anyway not yet supported. Hence backwards compatibility is not an issue.
>>>
>>> What user visible issue is it fixing, then?
>>
>> Indeed this looks like more a cleanup than a fix. @Daniel why net-next
>> without fixes tag is not a suitable target here?
> 
> There is no user visible issue. I didn't know that this would be the
> condition for going into 'net'. I will resend the patch to net-next.

See:

https://elixir.bootlin.com/linux/v6.10.2/source/Documentation/process/maintainer-netdev.rst#L68

The main point here is the patch looks more a cleanup than a fix.

If so, please also drop the fixes tag when re-posting, thanks!

Paolo


