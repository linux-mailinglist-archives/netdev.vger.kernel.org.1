Return-Path: <netdev+bounces-224534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEF1B85F11
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82554A1172
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA29307AFE;
	Thu, 18 Sep 2025 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Z9OP20S/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5E5212566
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212333; cv=none; b=tdeu6/xZmh75M++amq8bB/YbDMI1neaO+AyxNX8IHFm7JTw7gISku9mA1C8p+4rJ4tQR/pksvuS+9Pk30Zj1ikS9oK+gu2Uc+bbD0DHOTYuAs1VQSQw8izOLhE5r+5NE3L/jkv3HmK6jIVLl1MIFFSVboxjilQzWhn2YMtbgeDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212333; c=relaxed/simple;
	bh=pT725trLHsFzb6j3PtSFoM1Nlf4Wwd7bd3nQDutkrOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5sijiTG3bBtSeckX+cQ88ULXswb393zwonS/+qOyhvur74jJhj+2ava4IilGHGw9ZmX67qjcERvB1sI4IZPLvncesbESB9Aeh4+Y7PFWou0gIIHhmKaMXHNFy7PQjSJeCtaI9rlRPjiOeNd8N39YHGrU8wgxxSAa36epE9byUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Z9OP20S/; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3601013024aso12589991fa.2
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1758212329; x=1758817129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hn0hHTGqR47ZeFXXfyKJMLyN9yvA5G3Bb4pO4Wvs8Iw=;
        b=Z9OP20S/0ADpd8i8V08DpPSCbNBzinzXEb4mDRO/UtUSDS2gR2+xw+2+KuJKu+uTEh
         eZKCi1r6falKsEFeipDiVp2PPTcAL0XN3dLFd7U1UeBo2sk4XWRdzHCFT/Jp04OaC2LR
         PsnE9T0rynlqke20llMH2MEzXjK/CPUx4bs1NthdX7WfUoFBqudauvLU2r23cnssQPCT
         wVxLBTMtvz6+XQI/SFnDW4sUwrkuXqebepnpnXJZZqMlYVea2CKOkk0rLLUBQJK8UNwr
         CnhC1NHcUbg/VwhOf611R1tI7PlxTXdjPgXWjEBk46VNYkUN3cU61gIyrtU+UtxgNTys
         TodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758212329; x=1758817129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hn0hHTGqR47ZeFXXfyKJMLyN9yvA5G3Bb4pO4Wvs8Iw=;
        b=ofNPyztuihWhKfTLdQqqg9+eAdHt8SMdDQEhIqC9A0Zsx0MFM9qjpEfCs706Q3UaWB
         8XQ0/1a8QZS4ILzV3numIy/GbYdnPfi+FT7GN/jTNsLITkSsxuJcrcKA1GOi9IN6h529
         vGQjUpBPz0JtF91NVgHoEQTsBORW44U6Tq2XEjad6p01eldSs8A0U5FAHJBZdPlW20w7
         p+A+Y85mIFznj1obmOzihDtR8HncQeYvW+DeofIC7MHN3e2eTIKgETLrzaVR9DZpHuok
         1EdHrKI4d84NgBqYTAq8NJrpHHjkjcmXaoBhlNu8DFCuSQxdnzQk3SzYREOeuNdGk629
         iTSA==
X-Forwarded-Encrypted: i=1; AJvYcCVWYCQoHZiKdpsrb55O/I1K32eobcjSKEKazY1saErFoOT4vzx9Xggy4jxBDsufOzHrk+G8ofo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPb3wgD0KjYwAECFjTZlVBREMnx80qkgk6yqVu6PNj/zyJcn3o
	XHmwBmnZG4LA1ktGk2PGRwK6L15ZgGe6RsVxHB+92G+UlRv/NUylw1yhiEV+5jPqSVe6E/Z3aAh
	8/NqhYp0=
X-Gm-Gg: ASbGncsEmwbDNGtPJa8EyS4UBV3Prxm2uHuk+TF7R0v8eS0fB9McYXHCarkk0I4saT+
	XdTeq5VYDvHsJ1X/O38iPBLeCRd8S2GcKYzFOhRh1yEGCpVIihnM/JKt55TjCj52UlS4IQUZmMh
	scUXfT/Ah/n8ALk/sY8UOscMiIUa3Uc5W1XbC4twl9fXzw1B7ikIvWHjVYLcVFEpS063limzqig
	3RkWw4y0Fl1yuIMP7GNMR/Ak8QyYqV7MwEG0jJ+Zq/uVGug6/gDRF9iPkCarUSPmb0Ff6+8rUc4
	bfijy8c5Y2H8zMULsTN2DJWGWeCfl5hYS1n+AS23r8oRjy4EogroAPEK6cvyhzPD/NSpg4h4S31
	wAVp2qBSca/caCyZ7fafznkiubWSKE4Y39YQo8RJuyri4LnHihQEhlxaQdsvsi98rlj/4e6LbEv
	kgg1diPGME19iMMigr8YqE
X-Google-Smtp-Source: AGHT+IErdKLUND9UQ229ACOmVBQ5JcyfC20KVgyLavY53NqXj/MXkRfXB4GF/n8dR84aDf+50gNRfg==
X-Received: by 2002:a05:651c:2222:b0:336:e03d:6f51 with SMTP id 38308e7fff4ca-3641bd67604mr301251fa.34.1758212329222;
        Thu, 18 Sep 2025 09:18:49 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-361aa4810fasm6850671fa.64.2025.09.18.09.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 09:18:48 -0700 (PDT)
Message-ID: <eb9e2d21-b2f7-4a60-bfe1-530d909526d1@blackwall.org>
Date: Thu, 18 Sep 2025 19:18:47 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v3] ip: iplink_bridge: Support
 fdb_local_vlan_0
To: Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org
References: <d23fb4f116e5540afbd564e0e3a31d91eae42c60.1758209325.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <d23fb4f116e5540afbd564e0e3a31d91eae42c60.1758209325.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/25 18:39, Petr Machata wrote:
> Add support for the new bridge option BR_BOOLOPT_FDB_LOCAL_VLAN_0.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
>      v3:
>      - When printing the option, test optmask, not optval
>      
>      v2:
>      - Maintain RXT in bridge_print_opt()
>      - Mention what the default is in the man page.
> 
>   ip/iplink_bridge.c    | 19 +++++++++++++++++++
>   man/man8/ip-link.8.in | 15 +++++++++++++++
>   2 files changed, 34 insertions(+)
> 
> diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


