Return-Path: <netdev+bounces-107915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F2891D049
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 09:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77EA9281B53
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 07:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49E72BB05;
	Sun, 30 Jun 2024 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/etDPph"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C5A1EA8D
	for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719732626; cv=none; b=iuNOoSduiAG+0Bj/ltvoR0xgWLuXmcv+kxtI/1CxATygYe1Z8/qPY2MLvdUPcfmsllKTyhLNbLlkXdKg6WQWD9ei5/E3m0sQivn/UDEnfrmWbYxk7gSaPoWsnvkVGpnNZmWFzhUYs4wgFNpFdnCy3AoJXoxHs0f0Vq1+k6zhAfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719732626; c=relaxed/simple;
	bh=Q5d+QSnomsrKCWMhYwIm80u3YDJXE992n/zl+uTw9uE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cve4tbEaOrqJNX+/fPRzXelEb4Fi2up0A+qCO0cDUnai+ruy7koVVdjQeSJ2Dwt2QOpE8DhSMjQlDJI9l2BdcZCR/s4YdZR3ynsG9nsNBr/KC/DDQkO38/JBrOmemgQ5kw6xGjcaEUz6ltmVYDU9ybGo7+ZhmSalTTJ2agXxcH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/etDPph; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3627ef1fc07so1181997f8f.3
        for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 00:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719732622; x=1720337422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QjVzg2y+ma4KG382ZIJ2TW0D2QwK4IztK+a+VZcfB6k=;
        b=F/etDPphGGWTAv4B/r2HLrZzZw1rFaJ3mkvHB3ZuN7r7p9IgRGZwiYA14S2Nyhie70
         4Xr2v4yKsI7pLAaqnZAv1ocCujDRsXlxxf7PIdfME+oFbL804NRmNACAqI9sZ8AvCfMP
         Imk3OdlDVCY0ozaJquwFnueiE7oeuClOB+yYWwFg1y9bAF8z1AZn9P2U9yI06J/2WRTu
         Z2Mf8G+udUe7mtaP4GV49RxiG0lEQkSvNjqkgQhKoNyDR3gZpqZ05aHzvqBU86ESHnVC
         r9qJjYwxbSEzw497q7oxzLrPNioQtF1WimBTKptv3W/T4gMCZZDI9ppbeTuZwr454XVT
         V6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719732622; x=1720337422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QjVzg2y+ma4KG382ZIJ2TW0D2QwK4IztK+a+VZcfB6k=;
        b=DvkQKBF+mnaFSkEwtxf3z1EojfmNNnAgYsTlgWv4MqgQ1iHL8wkuhfanqdbSlArJlb
         NYyaFhWf6xUMmT+JVjIUZtBYLt8FPz7x4ljPy2rWWvtudOU8TR9FxZge/anbK/4o4ywo
         GG8dRHi8gnOg3KSFZer0deLQzAmqH0gmg0N+8cPdY6qb1zpWIB8TfwoQZ2M7c/YH9sn+
         v7GyYDfkAa1aUt8Sd2FA3P9ZneU2RZycClL5gZGBGXeQl7oYauNPF9Xq8qcCBRfpNm22
         65lLko3014Q88yBZ2yQgPCWu4cIXd1AJpe7RQzE4OjGHUdATkq7YD5Fye8NeX1lMTFqf
         5RXA==
X-Gm-Message-State: AOJu0YzRFxI3p7qxnZbi+hoe8F5tnwfw5NebwGMw9IVtqr6fdNdCpcXy
	jS2G4XTsFhY7mHT8aSvRp40vcsCk9234Yg/jgdeWMGft0TSH2vsz
X-Google-Smtp-Source: AGHT+IG6EyxYAg8g34DACYp3AavJ8XZOCIQTXYTPf2D6MRGyi6/Y6VGthhahjPCweFaZobQyGNG0Xw==
X-Received: by 2002:adf:f787:0:b0:362:80dd:39ec with SMTP id ffacd0b85a97d-367756c7a96mr1570214f8f.42.1719732621941;
        Sun, 30 Jun 2024 00:30:21 -0700 (PDT)
Received: from [172.27.60.10] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a1108b0sm6683324f8f.114.2024.06.30.00.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 00:30:21 -0700 (PDT)
Message-ID: <1308ffe4-e700-47fc-a6db-217b7206377d@gmail.com>
Date: Sun, 30 Jun 2024 10:30:18 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 1/7] net/mlx5: IFC updates for changing max EQs
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Daniel Jurgens <danielj@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 William Tu <witu@nvidia.com>
References: <20240627180240.1224975-1-tariqt@nvidia.com>
 <20240627180240.1224975-2-tariqt@nvidia.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20240627180240.1224975-2-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/06/2024 21:02, Tariq Toukan wrote:
> From: Daniel Jurgens <danielj@nvidia.com>
> 
> Expose new capability to support changing the number of EQs available
> to other functions.
> 
> Fixes: 93197c7c509d ("mlx5/core: Support max_io_eqs for a function")
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: William Tu <witu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   include/linux/mlx5/mlx5_ifc.h | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
> index 5df52e15f7d6..d45bfb7cf81d 100644
> --- a/include/linux/mlx5/mlx5_ifc.h
> +++ b/include/linux/mlx5/mlx5_ifc.h
> @@ -2029,7 +2029,11 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
>   	u8	   pcc_ifa2[0x1];
>   	u8	   reserved_at_3f1[0xf];
>   
> -	u8	   reserved_at_400[0x400];
> +	u8	   reserved_at_400[0x40];
> +
> +	u8	   reserved_at_440[0x8];
> +	u8	   max_num_eqs_24b[0x18];
> +	u8	   reserved_at_460[0x3a0];
>   };
>   
>   enum mlx5_ifc_flow_destination_type {

Hi,

Please note that this is expected to conflict with net-next commit:
99be56171fa9 net/mlx5e: SHAMPO, Re-enable HW-GRO.

Resolution is

         u8         reserved_at_400[0x1];
         u8         min_mkey_log_entity_size_fixed_buffer_valid[0x1];
         u8         reserved_at_402[0x1e];

         u8         reserved_at_420[0x20];

         u8         reserved_at_440[0x8];
         u8         max_num_eqs_24b[0x18];
         u8         reserved_at_460[0x3a0];

Thanks,
Tariq

