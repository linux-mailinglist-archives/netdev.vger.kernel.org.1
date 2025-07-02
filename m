Return-Path: <netdev+bounces-203390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B379BAF5BED
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 16:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0564A67FD
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 14:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC6130AADD;
	Wed,  2 Jul 2025 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vfx/KsYX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF0230AAD1;
	Wed,  2 Jul 2025 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468318; cv=none; b=aRDBVVNDjg8QaRjbhUKnJ4luSiCnw4eztnA0Hww6TRPfvGm1aRwNNFXssQGnKLaesaGk2u2L+RA8/+WPdghwqt2DdHyS65GLgDC97UHjTs9OO+SFPiWxoWoEhSQCCylvZaS0DF8K+asEcQUp/79jmnnr5zp+Pu87hSmDTgdLWSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468318; c=relaxed/simple;
	bh=oX/ZAtWzwJdsQhtNvalvhpcwa8JeOFlisMtV8cvuNIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J3KSujmNWkbU6uUda6vCdZ2ewoeYTwNTbXuXGLAH5CoGHo1CnEV9OLBltL7jLx7xl4QaurjwWZ5e/UwLIX6omEJhZe80WB8PWyCI2/plU9pNZzHk4J2QvlOmi7uYoqKciHfaeygHwHT/FeJkEgXMDXuufJDbHldr/ydsdSzPDMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vfx/KsYX; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e897c8ca777so1195032276.2;
        Wed, 02 Jul 2025 07:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751468314; x=1752073114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1WkFzcqoZ9zfZk6rKFoEV4a3LB4LFCO7cfh2fSf18M=;
        b=Vfx/KsYXuvVLuESzF8oqtv5MeUX9ouWcH2RsUgPsN//qn6aWgIhjf1oJdicaOPMwKl
         +gu9rIbKTP7tgvj9ymrWc/ZGgRHhZEDM6fK0DB9za6EYWmHnppZIBuKaBaEWsBu+twXA
         +rW2z/++D57u/HZVgC5/ztmxeDfYy6at6SanHtmTyuJuibNkYOEorrIGsSyA+DqVmrJG
         DYTZU4JhX6eofDm4MqLeiuSI3/Pj9fOWA2rEufcqDfLbHCBK6YUfQ/JC0reiUyBYcyCb
         8eHqtQCWKJqqPeoPKFIfF4bMqrOQw9hSnOnWci/dggeGHb0r/7jGNptFTsYwkbM9gyl3
         I7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751468314; x=1752073114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1WkFzcqoZ9zfZk6rKFoEV4a3LB4LFCO7cfh2fSf18M=;
        b=P3x502jqfgVMs+s9EqURKCHmuFD3TW4T4V3vytCA/lDS53m/WUsOc8zsgyyNJ7ySTI
         OpblIvp8Zc8dieEzR/1eMQ8Oo+8NPEAaL8k6H9vfjm0vjyhm5/TGmBKQ/hJkilX/JPLN
         KfoXB0AY0WgDiPTh7ZJFvXwmb1I4XuA+dKlxWSrcbOh3nKLzv5V5w3QZSmroQ/9ik6+s
         0dQI3SROKgdRuhtfhlNgb2dq1prckmOS9TxLMPiFZB6oeUZc+xqopPQm7f+9wuj71FPw
         XeS2fF4gpn00DJTbI0/s8N9ZuPyrDcD3RJXgjMqvOH+0thmHX3FAzVPhJL0hT53oar9P
         LvUg==
X-Forwarded-Encrypted: i=1; AJvYcCUv/fv8vftjzD24Ac4X+8b3V1yYPz2iy6JOoMgFEe4D+L793Z3AC2RVVGF644PVORzQRc8PEE6C@vger.kernel.org, AJvYcCXcJ/EWnO3z35VvWWysY7RXfQme80/+xIYUY7xhTfRvd/4WJv/edYEoIIHMfihXK8glLfJbDyJD1JcVn1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8YkgM7LbFH45/HZnE7Nz8D/I+FWPINQnSAe5VTwjLZZ+Ssd0Q
	LbTZkwBagU8LmefrX4/ibg30X29R5VU9slWlVAbIvt6dadPREFnnk9QS
X-Gm-Gg: ASbGncsxcUjvzjLNNVgq17e/jp2/ua4BJxBiB7BUXbD22YAGtTKl8XpcXwTUxRlTlW5
	VaFSpVQRluNIi+/FBGodwHN06QTVhVN7SUiQ1OCW0gvl1seLLrAqgiSG2XerUYHXPIgYEvLNhie
	g1rKiGrsKr5+nJ/Z+RD/2uCQn5lHTijS9Bjk0nB/1cVMi4rWhtx3UUUgxKS1s96mXIbS1jQtKSq
	MOreXsp+YGqi3+zTweXSE6XK4juK8QiYOwofb4Fr6u8aRnxhU6TuPKmTSZAA1MQEWmrBeGogtUS
	5Xe/WYhGG1XtfDfQ+t4I2vaC/WDzXX6seg7JeHO0H1AZW10r3tR/uN12xldrEmvAT4LLQR9OL8L
	t0YaAHurg
X-Google-Smtp-Source: AGHT+IGlSboF2WeQ17XUS4xFc2PW/wJIU1k/DVuD4yqPbLcGVoiUFPieioZSCcoMk0Qg2yQY9vZcjg==
X-Received: by 2002:a05:6902:728:b0:e89:8cc2:8082 with SMTP id 3f1490d57ef6-e898cc2856cmr885356276.41.1751468314365;
        Wed, 02 Jul 2025 07:58:34 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8980a99c80sm480883276.56.2025.07.02.07.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 07:58:34 -0700 (PDT)
Message-ID: <9c43747a-f73d-476d-a1dc-1646fcfb771f@gmail.com>
Date: Wed, 2 Jul 2025 10:58:33 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: Do not offload IGMP/MLD messages
To: Tobias Waldekranz <tobias@waldekranz.com>,
 Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250701193639.836027-1-Joseph.Huang@garmin.com>
 <87a55nyofq.fsf@waldekranz.com>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <87a55nyofq.fsf@waldekranz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/2025 4:41 AM, Tobias Waldekranz wrote:
> On tis, jul 01, 2025 at 15:36, Joseph Huang <Joseph.Huang@garmin.com> wrote:
>> Do not offload IGMP/MLD messages as it could lead to IGMP/MLD Reports
>> being unintentionally flooded to Hosts. Instead, let the bridge decide
>> where to send these IGMP/MLD messages.
> 
> Hi Joseph,
> 
> Do I understand the situation correctly that this is the case where the
> local host is sending out reports in response to a remote querier?
> 
>          mcast-listener-process (IP_ADD_MEMBERSHIP)
>             \
>             br0
>            /   \
>         swp1   swp2
>           |     |
>     QUERIER     SOME-OTHER-HOST
> 
> So in the above setup, br0 will want to br_forward() reports for
> mcast-listener-process's group(s) via swp1 to QUERIER; but since the
> source hwdom is 0, the report is eligible for tx offloading, and is
> flooded by hardware to both swp1 and swp2, reaching SOME-OTHER-HOST as
> well?

That's exactly what's happening with my setup.

Also, IIRC, the querier port (a.k.a. mrouter port) is not offloaded to 
the switch (at least not for DSA switches). So depending on the 
multicast_flood setting on the (querier) port, the Reports may not even 
reach the querier if they are tx offloaded.

Thanks,
Joseph

