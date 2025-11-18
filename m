Return-Path: <netdev+bounces-239532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B601C6963F
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 13:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 781084E38C4
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 12:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6EB34DCEA;
	Tue, 18 Nov 2025 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9u+Zopz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwqCrtrg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F06337690
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763469156; cv=none; b=Rnc2ZWcgMnJl8UM/vVbQJlGyKno9QH/yCj4iF5L42wp2rpQIpTZl4vtpvSN2WP6yxvIktuyTKI/OF4+vl3VjVDdxqk6e03IIU2SIcQgXMmzmyx+WZNpJhvWYqKTJyEj8ScWCzzfKRO6q6kiZkyIJe2210A1uC7MZtGkSONPjpLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763469156; c=relaxed/simple;
	bh=DTaU0Q9eSCt9Q5BWyjMoRvlzd8ouWytjAvoYZ3iv3cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y2IaGzdpUNSznLUJ+QQ6/UlVBtiQ41rOi9H8F9eX3pEiLF6hC2szkKVn5gj8nMT/HPRfS51/hnJLvAPKTU4PtKeC7k2fnrruFNBLTFir3RIW/IJg/EL8TNFNzqWkglA6gyCTfAMC44mCrHdJDxyjl2wl3XKJA1ovDmjoCmenfmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U9u+Zopz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iwqCrtrg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763469154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8bFq98UfncIM6fG2qDwD7snvwH11yQoURKT7uFfWCO8=;
	b=U9u+ZopzuetLY3x7AyM+7zlxNP0uf5Ti3/G7CR278Bvysr5/886HWj4YA1R7O4K9GbulBw
	zIGq/GnTuGBb6zYUDb7POJYF8/KfzJZl0/RTJNrruQbf9Oj7gd1XUA3T1FvrAf10HrKq9v
	vjyZeREnASE2Osix317aT0zGlqENCtA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-_YUDK_GvOMa8KkILtQLzrg-1; Tue, 18 Nov 2025 07:32:32 -0500
X-MC-Unique: _YUDK_GvOMa8KkILtQLzrg-1
X-Mimecast-MFC-AGG-ID: _YUDK_GvOMa8KkILtQLzrg_1763469152
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b2fb13b79so2597978f8f.3
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 04:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763469152; x=1764073952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8bFq98UfncIM6fG2qDwD7snvwH11yQoURKT7uFfWCO8=;
        b=iwqCrtrg7psXJc5aG3UI3sOmVFNyH8/zw6dP4ZJjQXT7mjUf0MpCi68UwMPZZqqdBm
         PK9WF3u++OnG/K4TJXffXrrR5Xp1C1Szg6pQFVwPTcG4FsO65agIiO5PFfwtNuDuYkKr
         rMAsZfiJ/owxxHYSo8LJFkoaxlW1pjwmsKsbwbrL7prPLhmq2UDhUiu85FywogOJtHyy
         1i8EJj30NiQgJD/CwXAMvbrGYW6PBUJvEzMdgwmdp/3VMeEYmT+6dpTFGf/CxYTya4h5
         PO4aZXQfR10+O3XTEQ/nBpihDWQdwMjc3yIE8Ne8OvJlzOWUxaNYvGsPCkBaWFs7ZWVt
         zANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763469152; x=1764073952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8bFq98UfncIM6fG2qDwD7snvwH11yQoURKT7uFfWCO8=;
        b=fSFAQsbkNb2C6dhb/4JlnH77fayeW9nPG6Ukh8BVOfHAq08fB8JJQB8ujCOcOYJ5lp
         4zpcme4aVgtzqtgeuMFy6/dji9icxfyN/lXvHUZggTKYQfDrNo3sssmDSodHADe0RQ57
         nLOX0MQBjS1rt2S5HMYNKbzievsliLWOVAcpwC3fiZ6Lkg4NniN9Jf5oj/3h+gLei/EF
         GUbKUYpv6//mlIfVgS1zRSR0y7BQW94IUs0neVqr34nKRbGD+bZ6BMsAmNZxC4NZN1cP
         /16IJum+GlMoiIX+lRaIigKVbLBtXUc8TbdbLFpzM0UeFs1qFinYL5HXcflXmHBdMSlT
         sqhw==
X-Forwarded-Encrypted: i=1; AJvYcCULOsV4jQyuHS2CRgxq/f9M5OUQDMVnHI3uu4np2ClUHHjDHJ97xAfaz63QRDka/IZEAyW0oqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy57qBsbJiBGnFp3v5Fi9RyHIOwaHfWbWKQrRFG4gzJRQj+uCnQ
	LZoW+7mmnoGGZ1z2gCrZSiUn15fLyhVn/nPmX6HP7AsH/x5DDY/K7xxXDZpwuc3MyJvxd0ua6mJ
	njYnp15QEbzGJ+1TeMrvfy3WnR4mQrZERsOPke/P5E7OyuqMgwLaEzFYF5A==
X-Gm-Gg: ASbGncsj6++6h/kyNES7LhfIIxwZY40fU9t4jTMz01C+01NYDwkkbI64klFn6snwD+u
	XnSwdWB02/KWoGu1geuVmffmTnskmzlECmX91i7rIKtKJvbE2of/v53qaVEdbvCLLVIhVS4+NPB
	k3si0ET3EiKnsLaAbRq6Sk0Wh8orxqisB8yq+0LniPXv46TKnanFBKpLJc7mafiY+e5az/Gz0KB
	5lBe6CrFWczfg4d/aPtRjaPQyPrncVDeD3+540y1qRv+MODDppRRjhjWV8J1LVXj3P8kXjDiC1G
	IK3HroZyW76dorQfvhCpFJhMWVzaZmzzlz0guOW1hf8dT+jdukYX7ZJHD1xATDaiH8j/FA262hh
	uvgWHljNCPm8X
X-Received: by 2002:a05:600c:46ca:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-4778fe4f06dmr157483325e9.3.1763469151615;
        Tue, 18 Nov 2025 04:32:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHFPZWLtIKBW62/sV/sykL4J1KL6tvHkeTFz5Ymr6cDp9e0U+MBYs0Z/GsHEyfY0VQ+h19FA==
X-Received: by 2002:a05:600c:46ca:b0:471:14af:c715 with SMTP id 5b1f17b1804b1-4778fe4f06dmr157482965e9.3.1763469151084;
        Tue, 18 Nov 2025 04:32:31 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779a2892c8sm187622705e9.1.2025.11.18.04.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 04:32:30 -0800 (PST)
Message-ID: <6332df88-2d49-4dd6-8089-567129f1ef83@redhat.com>
Date: Tue, 18 Nov 2025 13:32:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 09/14] tcp: add TCP_SYNACK_RETRANS synack_type
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
 <20251114071345.10769-10-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251114071345.10769-10-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/25 8:13 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Before this patch, retransmitted SYN/ACK did not have a specific synack_type;
> however, the upcoming patch needs to distinguish between retransmitted and
> non-retransmitted SYN/ACK for AccECN negotiation to transmit the fallback
> SYN/ACK during AccECN negotiation. Therefore, this patch introduces a new
> synack_type (TCP_SYNACK_RETRANS).
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


