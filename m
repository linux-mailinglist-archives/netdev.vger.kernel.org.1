Return-Path: <netdev+bounces-237942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4092C51DE9
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 12:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4352A3B4DBE
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF6F303A23;
	Wed, 12 Nov 2025 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="bAOysrJk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7CB3009D9
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945578; cv=none; b=IY82qaKygNymicKx0nvTyAsXWj05LKFBAhv43G60JJqo5Bv8rQHbcg/Lg+ClLvFfjQj0huDc6TtgR+vd8F2XMWfphmjKnYGjMTqjwFr2Ct1fSidNtPwUyoB6OTTRTr7b26zLJ1UaVRyZ8078CrDBru7XrubVrXpZ+vaVCfrvma0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945578; c=relaxed/simple;
	bh=tDH5RdXScHosnp3tBgCu6Wo6hK9wWBwFctAls40eQ2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhQ8X9EyrwQ0WUkmRKatCmB3OuNFaL4TkoLzUuc9JbeeQPJG1PMStLqTLILph4eEVfTERsGFI3b4iEIClMC1GVzjgU0/9QzPxRdvR6PweWMQsxFyBeGbRsz4jopDfDn/7mhjBw4uz9mAFwycx4/IMCJaKEhlcpPwiUsszEbvHGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=bAOysrJk; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7291af7190so111605766b.3
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 03:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762945575; x=1763550375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RscwFBq3OyRCWl61Ef104IM+J+P4bfAkKVg6cbBGEEk=;
        b=bAOysrJkB12ud+FOcHW9n3eccs3QzMRt38Mlj7BmSBqmGOsAmSAx1c2w5CIiN3rA4Q
         fJAV0ZxyyBGxk0Z7yMw2utxVzfpdTfqqDlnZtqigk+h/HkNBqHD5AJQD+5T4n14y5aca
         IIkMwhKwP8FpA4eBz20Fd6IfCSsxK2oVaNKFMpYD7uj394yDrRP8I4Gd0a6VOPb2TMkB
         YcGjWdUDMC3bvoh72g8BJK+aNeoya8gsFG+R+264q4GdwBDSQyBLW+KxxEvnzUXzc22k
         QoHL8c1zjKTr5uCLH8XJw89HnG25QRlv83PR9g7Wg1427W3kegingLDHjoMh9CfZnDNT
         Bh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762945575; x=1763550375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RscwFBq3OyRCWl61Ef104IM+J+P4bfAkKVg6cbBGEEk=;
        b=YfkU5GF7AoCASaCFd6fOA46nyiKKpDG7AvAX2sT2qj4O8P8nCW6LtuMjqBXPL/sMFT
         Lb09lNc1FEidS9uzdZDuyFcOGk4qdS63L3swb4H4yK7wOnp1pkgGeh41qhCj1fd8IN4N
         HI/X1ZiZGs3RK5Nzn1LmmQW3a3pB+GdHotYoUGFKSxD/PsX3UZq+nZ6SbAijOk6nXfkn
         mSzcyqFxP2HieZccPDmVP9z3BC1sig5c6140xtiS50mCW7j3HL88JF5BQzCpxi3tpwRo
         VThHFQgu1nYjzl4rC2JL5tekITq+9WIYbPoIuAQRCyXsjkOXjkLiPyZtF5V7tUaKzW9A
         8Zog==
X-Gm-Message-State: AOJu0YxcEmJilIcjnO6u+hYiGF05VnietkV/kavpJiJMQ/eWcmWMV6KJ
	Sx2Imhz1F4R53M1V7SpjQnreo0wNvXuVAl3GXMAF9nesvmG3DuuaD4DlammbWhMb04k=
X-Gm-Gg: ASbGnctxihEII9q3HUix60jXxjaBx8imAl57//g4upnP6G2FQ2/1KoxxSBxjvPHMj0Y
	p+5KWGOyAkzwO+KRm0GVp3nR/oM35wNGIW+bGN6uB/nZQ7j9CQS2yBznmOOq/E0ywexdMwuJJg0
	LBQoOjowP4sZmRfKNbRvdW4WgDpFDa22Xwe1GgftSFBqzOeJsKA8ptjLnxN3vO1I1nMzhs4Sbr1
	WNVQpYagsiZqsv1EWhsTVwlmJwubf2g0Tc4Qfex8FGgi4s6XZ52CH71e6mls083QoG9EwGGuvOT
	A9J7f0FwHPJUO9BKNaTGzJTUtatg2zL7upTWPhMp4aDG1L85cSPDeZaMThxCApUgEDW5N2hFGj7
	YQn0WFOTAkJu7WfsaQK6bRkOzC/H7JV2XZBHHogG8EtC91W8myHYMaInakfknM0B9M9M1cp/0uE
	Lcv5F6Qyy1JOj8QCPmQAlnLWG+sx9e9qw=
X-Google-Smtp-Source: AGHT+IE61k0FNld65Na0gwrWMjkcd6KnQX2WlVWRh2ThOyOuZMLyUreP+xoQ3sjP15lbD78y9IaeSg==
X-Received: by 2002:a17:907:6092:b0:b72:70e7:5b62 with SMTP id a640c23a62f3a-b733197ecdcmr239036666b.23.1762945574535;
        Wed, 12 Nov 2025 03:06:14 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bd741sm1528348266b.57.2025.11.12.03.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 03:06:14 -0800 (PST)
Message-ID: <c042de5b-4167-4015-989c-ef0d34b85c83@blackwall.org>
Date: Wed, 12 Nov 2025 13:06:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] vxlan: Remove unused declarations eth_vni_hash()
 and fdb_head_index()
To: Yue Haibing <yuehaibing@huawei.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, idosch@nvidia.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251112092055.3546703-1-yuehaibing@huawei.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251112092055.3546703-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2025 11:20, Yue Haibing wrote:
> Commit 1f763fa808e9 ("vxlan: Convert FDB table to rhashtable") removed the
> implementations but leave declarations.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>   drivers/net/vxlan/vxlan_private.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
> index 99fe772ad679..b1eec2216360 100644
> --- a/drivers/net/vxlan/vxlan_private.h
> +++ b/drivers/net/vxlan/vxlan_private.h
> @@ -188,8 +188,6 @@ int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
>   		       const unsigned char *addr, union vxlan_addr ip,
>   		       __be16 port, __be32 src_vni, __be32 vni,
>   		       u32 ifindex, bool swdev_notify);
> -u32 eth_vni_hash(const unsigned char *addr, __be32 vni);
> -u32 fdb_head_index(struct vxlan_dev *vxlan, const u8 *mac, __be32 vni);
>   int vxlan_fdb_update(struct vxlan_dev *vxlan,
>   		     const u8 *mac, union vxlan_addr *ip,
>   		     __u16 state, __u16 flags,

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


