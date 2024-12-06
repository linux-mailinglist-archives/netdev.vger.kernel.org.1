Return-Path: <netdev+bounces-149657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8A39E6AF3
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0742E28577C
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 09:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5621DDA3A;
	Fri,  6 Dec 2024 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="rxh0kMnX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F4E19F115
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478334; cv=none; b=Tav9NbY8hQ3i0FOh2EJYQwP2aNpJIc4fMWdXsSBEmRtG9wH4teXZ21CaQNZX69QQbyotI+OA+bo8EreGf2wCpvO281Vee11Ax0+coYQCwD49tyBKph2Sr7sFX4cmrs2NcySkzA/PtTME4dCu9vqFkcEC2DxiYOzaEbl4YBxdNHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478334; c=relaxed/simple;
	bh=KBvV7N3eYiGd6DaFkKtfRkrpGzqYrNr6HDdJyNT4TIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZEuNd5TabIkOh1w29dCpeby8aUcpV2sRjSkPOzcx4P8h2yNWh4/WuXiW3Opv2nTvZw6z285q3Hz/TAQEeZXYE1hFWTh5LbYCbHS8N2g6FAFNaXi6WTPO+O81I/9VpEmYeZNhI/ZhELX44F2e96RRlfu98Wwnca/BZaxebK+H20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=rxh0kMnX; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa530a94c0eso373588366b.2
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 01:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733478331; x=1734083131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2f6LRWXBbaO0IWNM3IDKbM4jURlGBSHtnIWrgt1bRco=;
        b=rxh0kMnX5URSD6sLerCSoOPs3dORGSa68lYlm2O3AROF2Hh/JTNzc9jMmOKeuY4U0/
         qurqDxsgXDROQZUwFlGw7cWHQKywqRKauGRqAbg5E8N+7SKwE1KdeewsRQDdwebRUTIj
         3zfnktmN5JDY+nHC2uIo88SDvlvn1FAntCVFsxWPr33AgN0O+jABs7o+2Xd80opmtYXf
         Tvf4IozqRVjjyIIKGCadQwNuVHvOy5wK0s3whTKdAzEtZHH6Gr8qnwZWWLL0apysLKU/
         OETHMsDiB2q5wX4KL67KrYv6g8r1GwkrZfqrVdznszNOIC5hu/XIx8FpZTQV5DRvK6IO
         e1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733478331; x=1734083131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2f6LRWXBbaO0IWNM3IDKbM4jURlGBSHtnIWrgt1bRco=;
        b=C0aLjWFwPsUolQetx8HdbJZ176edefpBjktOkL08FdAxsKUVprORA7vyCu6nGSddlb
         XSyJTQ3y7KK7NQrOMvAF1ciOjOBv3W1g4X5v7FY85puFbgMhpQ4YH1dKq3og/l0lcdyU
         YCWnNky4s6lNi/qSBkDQ9mSAEPdbYtcISKjOosvKuXWk0kXZA41EQOSGO3ymOkQn/M6P
         q6/xwFIkQUrrPDMm5hlwmbhKw3myuNxy2xZtaposYBXWGLI6lIyfBMhI7ceeb1xDR5F2
         Lgu+YP1Fe6GAWNn1MqHapnRupzbgSXq8/i7MY8TXRKvbxwhs3iSSwYh9It2stQY47y2C
         OzSg==
X-Forwarded-Encrypted: i=1; AJvYcCU0oDcawWt/CggDIPBIFtPJDZ1LYfJSGEmnP8mA1hvTAsYgBOrIJjLONxpQskIRHsC5F5a7kSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbA2ov/k1FIwxROGWJCUnnNVum+oHRc+4MTvl2BSCuC10WfMCm
	z1paYVqdcKyfK7RrRHWKtKDdsMaGhmgOpOCCA+6cnBlDRIpJCTbNu/yb/wGMC28=
X-Gm-Gg: ASbGncuzQAZvCqaDgSrE2vP4ZyGZZQDmxPqXJFSv/KmSq43FgcxHxh1hFGjMW9vz8st
	qc3GWPHHr2NZrfgGq8M2e/WfevWgwy9mELycvpm0TrE5A55OGVCsmfer1U2qDJ9K9fzQ8i3Ek89
	6+rijlHXxbvVXgOfHdWNJAgHp0QNWnhk/3lsHRx3hPVTQ5I+JP1soTiEorzq8v4ZLBa8Ol42DDn
	4dQkFJ3JF+791YGYOo3WalTP2W5iPU2eXUZ/8NAtd7oTMqAKlS+
X-Google-Smtp-Source: AGHT+IHcJowf+rPUl7sREKmo+aMdXmeURRag+yH5ghKfbN1cEIr0OSS6L/HO7BQf+NLWTdYhvkbhPQ==
X-Received: by 2002:a17:906:2932:b0:aa6:412e:8b50 with SMTP id a640c23a62f3a-aa6412e8f24mr102178166b.45.1733478331505;
        Fri, 06 Dec 2024 01:45:31 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e6290bsm213663766b.17.2024.12.06.01.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 01:45:30 -0800 (PST)
Message-ID: <72040f94-1834-4b4e-a308-a1cfb691e62f@blackwall.org>
Date: Fri, 6 Dec 2024 11:45:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 06/11] vxlan: Bump error counters for header
 mismatches
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, Menglong Dong <menglong8.dong@gmail.com>,
 Guillaume Nault <gnault@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Breno Leitao <leitao@debian.org>
References: <cover.1733412063.git.petrm@nvidia.com>
 <d096084167d56706d620afe5136cf37a2d34d1b9.1733412063.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <d096084167d56706d620afe5136cf37a2d34d1b9.1733412063.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 17:40, Petr Machata wrote:
> The VXLAN driver so far has not increased the error counters for packets
> that set reserved bits. It does so for other packet errors, so do it for
> this case as well.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
> CC: Menglong Dong <menglong8.dong@gmail.com>
> CC: Guillaume Nault <gnault@redhat.com>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> CC: Breno Leitao <leitao@debian.org>
> 
>  drivers/net/vxlan/vxlan_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index f6118de81b8a..b8afdcbdf235 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1721,6 +1721,10 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>  		 * little more security in adding extensions to VXLAN.
>  		 */
>  		reason = SKB_DROP_REASON_VXLAN_INVALID_HDR;
> +		DEV_STATS_INC(vxlan->dev, rx_frame_errors);
> +		DEV_STATS_INC(vxlan->dev, rx_errors);
> +		vxlan_vnifilter_count(vxlan, vni, vninode,
> +				      VXLAN_VNI_STATS_RX_ERRORS, 0);
>  		goto drop;
>  	}
>  

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


