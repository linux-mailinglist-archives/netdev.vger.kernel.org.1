Return-Path: <netdev+bounces-208840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 452E9B0D5B7
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AAFC3B68EB
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 09:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD7223A564;
	Tue, 22 Jul 2025 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="xRhYhWVS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC76F2D9793
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175993; cv=none; b=VKuyUzK6xH3IA9xclIlemcxzGb4cU5sqv+M1wi5SXsD75dYVkxXHLddSX6RQsTcrRW/634MW/0HE+JoTKYg7Sufa/BkTXzSIyoxGkVg0duMEl1jOXxf47SrYFvoxqoza5IQZL2Z2ItlkILVDrp1IQ5Ig1eJKUUuuL9HOy0JyONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175993; c=relaxed/simple;
	bh=Nc5LsYBLDXrRSjWDibQSsMSXJGDOtTLIeSfPdkJxZWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6ihW7poTLCqfOuRARedANuUOAvcoNGT/7UbUSngm7WiFxR0B78o6ybSjfOlzWpwH+3QgkEDHAMlnAo4M1YxWlcZGF8kd8EttqwMJ0ZM4hipxF7Y7LoKcYq/2hPN09nuCoDLItam1blJwfBALGHoNujsn7TvbdnMep4Jezk2LV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=xRhYhWVS; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-611f74c1837so10084481a12.3
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 02:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1753175990; x=1753780790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5CkWrUi8y/EeZjQzOxkKkRJZhHj+VflbRA1dCfIf7WA=;
        b=xRhYhWVS8QeZaBQINDkLcin1O8O6Ccql0ujdbSE6TdX/PAzWOkP3NviIeEhit3nmJ8
         ByehyUmgABAcwdJ1RY1JrFRsVtg4Fi9XO4z2CGB/7SASHcV3uGaQ6uFX6XVtfJXIT8V1
         VSkY/MbcNMv29/kx0ut1fE4Uc31uYxsrqwpPuG2tSUrnVeyEUqDdyCo5wKPd2h1IvHOv
         QosXQSR8ruuxzOUz+HWOgUsSwlXtd3Kqp3b/VIsp+NEtrmUBJv5l279qOmAkS8sPrB7s
         NpxvxXVbc8l8LB+m53jGdOlpiRAoHMYGsZflXU+eeGIIRLOuYwbXzyqhQ6qoxzxWoxRG
         h5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753175990; x=1753780790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5CkWrUi8y/EeZjQzOxkKkRJZhHj+VflbRA1dCfIf7WA=;
        b=rKwvfMe5BiT3hA4O6IcJcZAKDNeSy99WE0YI9IRUhqSLD6VohKR6UdP2CkMlfHVVvQ
         zF/XuNwmDVTYWmRjzGzv5//LN3WDAR3dqYep9IapZVoLtS/+FWfw/irG3l1TJjYZX3we
         7TRKLZBDxk8SDKvRcKzF0O/EynjowjFU+iDO8vlu5UZI7uRy06SxycMaVkxdebcjVlyH
         Th8Y3SIDOQbrqn+0bw2tXIz6nq4W8h9g5IOxkah3/iH/lS1/70MI8W+11m6QNJ0lcDqz
         bAWqR8JtVFZE0K7xIEUPpyu+LRvTVhQG6E4AL9wtYxdDW/V6ODDCQSFw9uIa5DyW3bBV
         Ay9w==
X-Forwarded-Encrypted: i=1; AJvYcCXewj9VAqBio8TsrV/b5pkB2uxnfq5OtIjhzfJgo66kkaU0FnrA7QjRkue7KDL9P/kgcRKUeX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKGZQqpcm0JlyLyPPiJ+t8HtUhkGFpQabc2YZ4ZTaQXfk38W+F
	cgdAPEE2J35nSOR1V3SUlqgvUJ/M5GMw7lsrumahS9Po1hIPqcoX1Y97ABQj+I4Hf8w=
X-Gm-Gg: ASbGnctC3KKZInGJKBTrImaZmHSSEGd2g2gNbCC83X8yjpK0sOZn1pTzgZZXkX99M7q
	ft5clhjaLt52mRVJ7v4mYmRdJlQmoIY46Bb7myoNdiCB1VTetopbalyn/OyqA0/eLAKnIroHTmq
	/vVDmnvZL93CC+ER7g5uscSK3xCI7OHHAF22AvI+702KFXHXw9SD75WPiyUTpBlCvP9BVyIwUM7
	TJuqWBlIiWa01z0DkIyFmAb9N2nEUnP/RxYTXhGNWi0f+kJYCA0kK0TvgXki3hLebHBXW3TXFrL
	sPnHJG4LEwf7zq3gaAWvzRnCXV6sOjdHa5klrF+GmvgPDW6EAQYhVVf9+UQRIxlpTkQiiv0LXhU
	f+KA6kYTPK62sOzgXtwq27pPEir7n8Aej/BvenUwQD1CWrC2gALvEsA==
X-Google-Smtp-Source: AGHT+IE/B2CTrIdQjnB1vPNgmhIwDU5QOPxOiUS6LHTb8kkqvCAeLFSRTFWBar5inQPkIGesfWAM1A==
X-Received: by 2002:a17:907:6095:b0:ae3:bb0a:1cc6 with SMTP id a640c23a62f3a-aec6a4e0c16mr1346682966b.16.1753175989485;
        Tue, 22 Jul 2025 02:19:49 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aecd96537d7sm729370066b.18.2025.07.22.02.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 02:19:49 -0700 (PDT)
Message-ID: <97be4c1a-f097-4780-b5e6-71c0530f3f49@blackwall.org>
Date: Tue, 22 Jul 2025 12:19:47 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] vxlan: remove redundant conversion of vni in
 vxlan_nl2conf
To: Wang Liang <wangliang74@huawei.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, idosch@nvidia.com, petrm@nvidia.com,
 menglong8.dong@gmail.com
Cc: yuehaibing@huawei.com, zhangchangzhong@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722093049.1527505-1-wangliang74@huawei.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250722093049.1527505-1-wangliang74@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 12:30, Wang Liang wrote:
> The IFLA_VXLAN_ID data has been converted to local variable vni in
> vxlan_nl2conf(), there is no need to do it again when set conf->vni.
> 
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 97792de896b7..77dbfe9a6b13 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -4036,7 +4036,7 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
>  			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_VXLAN_ID], "Cannot change VNI");
>  			return -EOPNOTSUPP;
>  		}
> -		conf->vni = cpu_to_be32(nla_get_u32(data[IFLA_VXLAN_ID]));
> +		conf->vni = vni;
>  	}
>  
>  	if (data[IFLA_VXLAN_GROUP]) {

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


