Return-Path: <netdev+bounces-135750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B5599F115
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE7C1C22DB9
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2091D5176;
	Tue, 15 Oct 2024 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzOj6pKh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDFC1D5159;
	Tue, 15 Oct 2024 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005890; cv=none; b=bzvxqivtBUd60kglHHSmPnicu5uM3Sez/YEqy4ei4myjcV/BqsAZnwbD0du9J4CLnVG+KPpJqiqjQ6XN2q+QJEb6RvY4u8MKRXUkVYA/6YrJezanYs0CzuyGFYwTO8B2yy1ZtAdgLeIsZOtnVzhcniapjiqJVNRSVqEusVUJ9bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005890; c=relaxed/simple;
	bh=0GO+Ntik+qxMUBq+Ht4Y4hfxPtM+OaMNPWhzBL1HNJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pDnpDOu6aswkPYsmnjh5/SCsGW9VAc2WM/SFby7qLjpEWf5JMZuDajSXH3/sNScWniHjT/Mk5XpsC8PrZ4frI+Y2Ta1kbviiip0BIQXHkWV73QyqK81YnjXqEi3s4YK9S9LgVtkYXFFaJG4popgoN7J2ICY1/ksRvgcgNNtpUOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzOj6pKh; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso31532971fa.3;
        Tue, 15 Oct 2024 08:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729005887; x=1729610687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZgdUMWEzAk+EG79Tz22s/1CLoW4tYxCgZIaYa3L5yog=;
        b=LzOj6pKhBsOvpZ1wOaYQpI7b7SlidveRuPJId6pgw5255SpkxISqlznu2Xgjljbe91
         SVQQfOL7r22fWBxFy2nVC8v96DCWHhLQ0qHqX/pWNJ4r9EVeeEjIKgfT2zzcxBfzoNv1
         csvlPfaTyKwLan3SdIG0Jd+7Y6N4Lf0jnMICY0Vyl2oLW4MsGzI2m+bR+dYbpXtdImPo
         +vDwoN/C4Q9AzP2Za1QudbioUp06zPmaR2F25YAsQgFA74PFLd13LYz1nW2y2RJuT+fz
         H2GmkO3+zoiO1CxnDoWXIBffZxRae0kpi9QfYa8X1hI112WLXz1kChwrrrxetjnjY69A
         Oq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729005887; x=1729610687;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgdUMWEzAk+EG79Tz22s/1CLoW4tYxCgZIaYa3L5yog=;
        b=ptxMVh34Ld5kWpQDe3ovnn6HMJ9/M3+tkudTulfo2XMjyojdHScf7fOCWYaOMFpqoM
         4nwEIqrxdmT3eDF4CXkMRKuqfF3hc4YyHvjxXJeIO11GtTeaw1EXsScJFQ/qWJyIqEFx
         21wd/LbwD/duMcWtL26k3npYyC4qXE9iPBcnzMxRleg9mGoXoP7pDcVmzUxk7JXHycfv
         BCDP40opDBAZHoK9HqyI1/DrePML5JrqlODGr+ERLlsQpAM2nEU+Q2JoLJzGoRi6ID1J
         pc/j0pf9MowJggNA5hYRXd+PnOW+L48sjCCaIqL3qmZgkr57hiN1MENnyH8u3c1LrHWz
         kKdA==
X-Forwarded-Encrypted: i=1; AJvYcCVEs4PCddzk5qmo2tUU+SouVNMekHt9enZChhxifrtj3yLPkGrCkf8nBxzPs+2WaIZggzW+uuObCvX+7Bo=@vger.kernel.org, AJvYcCX4ALXLR2PUfryOtygfuyrYrLuZONs6Q3Pk0csvzbqktDFOcBr2MCzDOgAcpkSnjf6rotT6iYZ6@vger.kernel.org
X-Gm-Message-State: AOJu0YxIx+AbB8xwHS3P2fTKjJHFEK7DfIphmh1kPWggWsGU7L28821t
	FP+aKWPupigm5NBP62A2awXGf0RScnzilQupCQuz/z+gxHkzm5Yr
X-Google-Smtp-Source: AGHT+IEhXB8Zlg7IkTsA8y8iIL+yFM1Egeas7A6tyYltRKvND4UncFEa35oKJ/d3toA8mwCozQ6E8A==
X-Received: by 2002:a2e:5149:0:b0:2fb:357a:be4d with SMTP id 38308e7fff4ca-2fb3f31053dmr55908261fa.43.1729005886835;
        Tue, 15 Oct 2024 08:24:46 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a297171c1sm83165166b.41.2024.10.15.08.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 08:24:46 -0700 (PDT)
Message-ID: <5de748b1-5963-495e-ab90-6453c1707c39@gmail.com>
Date: Tue, 15 Oct 2024 17:24:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 net-next] net: ethernet: mtk_ppe_offload: Allow
 QinQ
To: Simon Horman <horms@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241013185056.4077-1-ericwouds@gmail.com>
 <20241014085122.GN77519@kernel.org>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <20241014085122.GN77519@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/14/24 10:51 AM, Simon Horman wrote:
> On Sun, Oct 13, 2024 at 08:50:56PM +0200, Eric Woudstra wrote:
>> mtk_foe_entry_set_vlan() in mtk_ppe.c already seems to support
>> double vlan tagging, but mtk_flow_offload_replace() in
>> mtk_ppe_offload.c only allows for 1 vlan tag, optionally in
>> combination with pppoe and dsa tags.
>>
>> This patch adds QinQ support to mtk_flow_offload_replace().
>>
>> Only PPPoE-in-Q (as before) and Q-in-Q are allowed. A combination
>> of PPPoE and Q-in-Q is not allowed.
>>
>> As I do not have any documentation of the ppe hardware, I do not
>> know if there is any other reason to not implement Q-in-Q in
>> mtk_flow_offload_replace().
>>
>> Tested on the BPI-R3(mini), on non-dsa-ports and dsa-ports.
>>
>> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> 
> Hi Eric,
> 
> I see that this patch supports up to two VLANs, both with EtherType 0x8100.
> And assuming that is supported by the hardware, that seems fine to me.
> 
> But I winder if you know if this hardware supports other VLAN EtherTypes,
> such as  0x88a8 which is described in 802.1ad?

Hello Simon,

The issue is that I do not have the documentation. Therefore I submit
this patch as RFC and I hope someone at mediatek or so can confirm we can
implement QinQ as in this patch on all hardware that uses mtk_ppe_offload.

But it does not look like it supports 0x88a8 from 802.1ad.

