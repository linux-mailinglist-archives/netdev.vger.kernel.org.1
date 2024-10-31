Return-Path: <netdev+bounces-140825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0CC9B85F2
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 23:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B7C1C2139A
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 22:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30EC1CEE86;
	Thu, 31 Oct 2024 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhBAv5GE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230F31CC16B
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412829; cv=none; b=kIQr3/ZbYaPEBvq3Cmkok8t3bXXzLR7xjIDK0fmGbrxKI/kSyg/252aLAE56rCxPxdJVA816aJy+R39a4B7QIfcyEe+uopHpJaqNEARHfHJIdKLtmUVMwXK9HJ4Q+bSH6wMY04dixrVzoIDPwCR+SBVLORhIcHw7Qp+6uLYRwIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412829; c=relaxed/simple;
	bh=OZ9PqEYxURrLAvUM7vO0DTaefO+S2bxcANQLjbtoXdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYDUpTzqkE9xKdXGiTMVWg+ghRx5S2lrlYWv5fumfjw4HIofbZILUd+HZI0zh7E13m5TtHpNldP9eMs+0cvvCInYFjPl5XNX/UkYhQliamp749HgLENmYgYynGzx59S+KFEjU7w8HFOyQCN6IqPqNAsq9EbHTMIHiag/oanVy54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhBAv5GE; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-720d01caa66so26317b3a.2
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 15:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730412823; x=1731017623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yuJsu0BgB+Eg9HTDtI1avclDFI5OW2VcEJ2KCfMr3BE=;
        b=EhBAv5GEo/HsyizUiV89a3JwW2LaGmOOD2NUWWD64S0zQO8juoID7omnMYt4VWjuWJ
         dHyzehUbvcYLhL65FBiU0lhml1YbpP59cD6P/nFWBB4IyR9teYITabnbBGAhTBxWiG3X
         KEPR74vDC+VLR8BoeoWmNDmnoAcTl7tmemWvNJOjU5dyVV7zHuJzk9RhCvpd3DUHJzwu
         m5inIWe85aZfpVmhO94g0/ww3SZO4FyE4Lk788QJa3qAbbdXdDVTofoAQZtmIT7XJtiF
         /8LvmJscJFzIvAhUG7oWQ5jmA5Elr2XF8WJLJb1caU5/9etBNXe4VWgiui1MTr+uXiE3
         CHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730412823; x=1731017623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yuJsu0BgB+Eg9HTDtI1avclDFI5OW2VcEJ2KCfMr3BE=;
        b=BcHF7bPPgQTvguRqXlO0Tlr7ANjILOp3jdfdZEiZW3x1NQIpkk1kVeHqpPDS+fclzU
         SLRsZr7JT8wlmQpTVl3Bi95OdpSjSQ6A1BIxd/PcenULwnOif0wWxTrK7QSTxfz06F+T
         bDrnCAjKYNHcwSVq/d8VxfgL7so/CiD+n+dzkN62G1oHWnRtI3iVoMmMTKESOdu+z9hv
         rGfvXeb6fXFBsok7AIW28twhzOplVodC7o5BHPv/ut2Is8tUK/3gTpRlLDUsZFZ71wel
         FCGgVMJXYqarjGlAZ4j/bKDssKF8Hr7ICCj08gF5n8WZ97T6mzula+Zg9vevhIw9ZWej
         /dHg==
X-Gm-Message-State: AOJu0Yzozpz0opB6qgaiaJ6//bUdUPy5N8mLsl0dWIVj6T5MBFRofE93
	gONsWmqdluK2xbrtRkiipfMRnz0Gsyx6JQJO1X5vO/RRhxoqGz15
X-Google-Smtp-Source: AGHT+IGdeYhZdREsE9YYfW57vN7jNJd9SmdxLWCmv0tOsR9Zhc39MaWG5Ys7drbGE2kA6Om712UHEQ==
X-Received: by 2002:a05:6a00:2e96:b0:71e:594:f1ef with SMTP id d2e1a72fcca58-720b9c2ce5fmr6852497b3a.16.1730412823189;
        Thu, 31 Oct 2024 15:13:43 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e8::1094? ([2620:10d:c090:400::5:671f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45a11cbfsm1450532a12.89.2024.10.31.15.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 15:13:42 -0700 (PDT)
Message-ID: <e2c12a98-acf3-46df-8831-4b898387bfa0@gmail.com>
Date: Thu, 31 Oct 2024 15:13:40 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] eth: fbnic: Add support to write TCE TCAM
 entries
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, kernel-team@meta.com, sanmanpradhan@meta.com,
 sdf@fomichev.me, vadim.fedorenko@linux.dev, hmohsin@meta.com
References: <20241024223135.310733-1-mohsin.bashr@gmail.com>
 <757b4a24-f849-4dae-9615-27c86f094a2e@lunn.ch>
 <97383310-c846-493a-a023-4d8033c5680b@gmail.com>
 <4bc30e2c-a0ba-4ccb-baf6-c76425b7995b@lunn.ch>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <4bc30e2c-a0ba-4ccb-baf6-c76425b7995b@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/24 5:43 AM, Andrew Lunn wrote:
> On Wed, Oct 30, 2024 at 05:51:53PM -0700, Mohsin Bashir wrote:
>> Hi Andrew,
>>
> 
>> Basically, in addition to the RX TCAM (RPC) that you mentioned, we
>> also have a TCAM on the TX path that enables traffic redirection for
>> BMC. Unlike other NICs where BMC diversion is typically handled by
>> firmware, FBNIC firmware does not touch anything host-related. In
>> this patch, we are writing MACDA entries from the RPC (Rx Parser and
>> Classifier) to the TX TCAM, allowing us to reroute any host traffic
>> destined for BMC.
> 
> Two TCAMs, that makes a bit more sense.
> 
> But why is this hooked into set_rx_mode? It is nothing to do with RX.

We are trying to maintain a single central function to handle MAC updates.

> I assume you have some mechanism to get the MAC address of the BMC. I
> would of thought you need to write one entry into the TCAM during
> probe, and you are done?
> 
> 	Andrew

Actually, we may need to write entries in other cases as well. The fact 
that the BMC can come and go independently of the host would result in 
firmware notifying the host of the resulting change. Consequently, the 
host would need to make some changes that will be added in the following 
patch(es).


