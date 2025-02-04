Return-Path: <netdev+bounces-162639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E33A27742
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7F4164A1B
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D9E2153CE;
	Tue,  4 Feb 2025 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="YCEqn8II"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896F520D4F2
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687028; cv=none; b=oJv/uhpSKdzIp59F60XCcx0N+Qz1TQQG6Y0vqrB8Z5QieZ46XZXfJLzA7c/nipBR/mTOsvL3uwMHqXtD0YXaykSVV2/5a++10mHkHEPc9MXmCzY+UDOR65gIg1QlcagZM2jrQwzM3JoTbgPGbDTieF8LQ1Aw6ip9PjRleKoruxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687028; c=relaxed/simple;
	bh=EBXZi95by9V9OigxiUKQ/7DSXH2Zc0+NQK4A72QNs9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=shHtAe6/mJdWJEIf/e50yVcolTEMSWoffvNNN/gkhrnooFYHTUmalNHBYm82et8OvzBhD8wgNSJDIuxQKAqZUXeb6MXRZigIpok76LYNruAriG4HneNQDGns5mFjwbdPiFmRv2JxFIfv8Vjv0AI1ZPoRpt4JLykb/2UfWoWEncI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=YCEqn8II; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7430e27b2so301661766b.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 08:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738687024; x=1739291824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cjj7QrDFvIhC83+rVOR8RRPHU212oqHCYeQlojhGTLI=;
        b=YCEqn8IIIYn7HBOmxeu23u5NaSjfVB1YCl+qdHD4O+toJuTBKnPno+KD9HoGWzlhPp
         u3+1eX2nV+o95yJV3hiz+MBT4+C/pAFxoivVbG723NTttZmdcg/98PnOQlwAmMlWGhH4
         mRKBGch9EdwaGR3yuDQOLJy0D2HGQ8/tSXEPVat8gCMWKFGXhenlhDipWxGZMLtxzsVu
         aOapOuSEhBq5w7g2gpQZFiLHXSInfdO6OfEXADG+WmBFwe7aYsbDi2ylGBSrUB58XI0c
         9q4vY/YcHCR4LFwFPOu7ZTZRil4QrexA9PIKjSracvLj1dQN1qAPw1ln6MNXTicBeBCJ
         MbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738687024; x=1739291824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cjj7QrDFvIhC83+rVOR8RRPHU212oqHCYeQlojhGTLI=;
        b=qH4hXDMh0LHrbNV9YlwmHCihKSb1y65CRwsudVBAYVifVWTRdxNeRq3GY+rEMOgE1H
         xC6cOoqfc8h1AOpQPAbc1VEbohdEpFVMV57pCj2xxXoe8gOimV11tcoh1shmuThfiNae
         QsNTcsntAX2j+qaOA+TYPN25CmQWSj9vem2paCyaFQV6xsTABCMUgrLo0wywXd0aDQdO
         iLHWoM2KQHCV/uOilE6nWYBk4olN0F7dpcixgCIImPBQoTZ7emw8S/MYVcAVG6YYxIBS
         LtTJgk6mkOIFGjxKPBp1pUY47cyccNeVen6ibGA3195C35KRxeJ+/fsGmcYzxbndt0r5
         qj+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzPbFvyuyXXjqAj+Wr3+gBjLGf0dz1SheTSozf6sXQeeS9JddVLL0GmyJ3UFGUNCp/p2jR9f8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSrCNjk5GqIpEsc3om92rxSfdnTwkk2h1TwsqxqR6XTd/OoA5i
	dvb7VMmhq9eO39P1rGLo06sd/kFP7FgCrvf2/fXhyzSYVE9cZAFvnGaJpvl7vP4=
X-Gm-Gg: ASbGncsbwbjcb0g8VgvVdRn625Gi7o/ptpCJZFxDdXXnktuzd0OImrUqEcswr49qGVD
	1FFX+5LzSxTh7M6MH5/RpBHnZI7C4krIeZFuaKiExyDvaB4YeYiFBvlMszy7LmRG1SOMBAIcRWA
	r1XLD9EPgnJnsJCTCTWOwIVymgazKCGLvHhgH7uDMN6dWCJb7oYuL68oD3/CHUc41t4Sb/BFewf
	rd2TUaKD9DLCxUy3BFFZVzrylA7Bdkf7TkfD1g/fzWPWaoliFc6kA4BtwcSCWZYcBmUHTwKnT2F
	WcyrPslz8UqEkt5dK+dsxUeKUl3yT969IbZAxU3+QmkA2HQ=
X-Google-Smtp-Source: AGHT+IGMQZB4gA45obsnhfdb9jR3rrmf4b3gakL1D2pu2rZAxM8l8tz9S4E0+HJhvze2RjQZEtzdtQ==
X-Received: by 2002:a17:907:cb87:b0:a9a:bbcc:5092 with SMTP id a640c23a62f3a-ab6cfdda479mr3401448966b.39.1738687023575;
        Tue, 04 Feb 2025 08:37:03 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a560afsm932573166b.163.2025.02.04.08.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 08:37:03 -0800 (PST)
Message-ID: <44a9513b-ad8c-43df-b4d8-969644c7cdeb@blackwall.org>
Date: Tue, 4 Feb 2025 18:37:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/8] vxlan: Always refresh FDB 'updated' time
 when learning is enabled
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 petrm@nvidia.com
References: <20250204145549.1216254-1-idosch@nvidia.com>
 <20250204145549.1216254-4-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204145549.1216254-4-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 16:55, Ido Schimmel wrote:
> Currently, when learning is enabled and a packet is received from the
> expected remote, the 'updated' field of the FDB entry is not refreshed.
> This will become a problem when we switch the VXLAN driver to age out
> entries based on the 'updated' field.
> 
> Solve this by always refreshing an FDB entry when we receive a packet
> with a matching source MAC address, regardless if it was received via
> the expected remote or not as it indicates the host is alive. This is
> consistent with the bridge driver's FDB.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


