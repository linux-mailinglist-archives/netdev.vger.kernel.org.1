Return-Path: <netdev+bounces-172186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EEEA50A60
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 19:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4F118829DF
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 18:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2972512ED;
	Wed,  5 Mar 2025 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPrOZII1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586F01A5BB7
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200923; cv=none; b=GQfHkiYmzQqdq8Q95qw9xvqi93RUEpXR5aNl5UJIAgx+Jyi0iei/bWfcDVX0QQtwpweClFLqvofGKNl3aRFm+itCx/F8SvB2f1+wT+Y9pToI1ubx73a/Q3giIkKJs6ZDU8OFnW5b7aQoR1uNzsgVnvH3cKXhJQMTnLX5h2+Sg+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200923; c=relaxed/simple;
	bh=nwwW/QeW1eHgxcud62duI7ohY+tVqcIWeARHosTrE58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=af9dbf27z8ylL9D09Aurb3Z958veWkozZIQBsrbSkQIpuac6rFx3TRl54JNxDRMOVWHB0T9vItyA1cP6R9H2dAJg8prsocZu8xbap+B1B1U1HALdJ3eGO3JBbKBMVvBHhP4ZQ0ANPXpQkKVC7avJGo7hG+EHtMe+nbV7iL/lBD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPrOZII1; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39129fc51f8so39656f8f.0
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 10:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741200919; x=1741805719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zqdujPzjEoggBMoGjM1zPVAuTiDGq8HjdDHoaMJWW2M=;
        b=OPrOZII1RZTyogWZwvsStcaoaaIXDWM+Kj6+Is8HyjGjgFIXFYf/H2uzR+LHadzKcy
         tUKTa5Ds7smn34y9b5h+xReuAEe6VJcrvmL/rlets9MmvKqH02tia54vaBxTF7JqXaiR
         n5BdJjkq19p9IEdRK66CZ9z99knANn1mnEAIFbCBCSVgH/0LlnqRCTK+HsEaKINCXH5y
         CUIxIUWrLXxmiu436M86ZULxPnoZE6PFNb8aynQQUhqSy1fXHi1zPB965jmpj4NYoEdf
         av6Kr7noVA8OjLnWR9taRFvfokC2oVEUTA5JUkKUD0TU88ri5PaAzvXDnd1Weich2ZWo
         2fzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741200919; x=1741805719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zqdujPzjEoggBMoGjM1zPVAuTiDGq8HjdDHoaMJWW2M=;
        b=LUOnQyoqbGro3ZfCII5cj7pwf40x6rspiQG+uzJ+B3yV+Qk8GSwkl0gR5XT2R9EdkT
         F4N3vn/KEoA87yg9vnM4jKtUlEiepIoIzeNREiHxiGj/Sb9rnBJ6w4ZXLW1CyItAsbRf
         DXksTdE3gDe2okGIfY1+bw8B8WdwdM4xqMpDYH3XV81pVyxWCGJJ8J59z5YatkOo220U
         myqe2KmrFPwscQb6rQaRWjTKJ6C99WPcK0g9Rl6hvCIjoiFD7PPJw+ZdetRy274rHDye
         OePakaVs2+dw2moC7rzbI4idZEkQ3e1gR9LbgHrotNp/DSSHoY6HLC4tXEqWGIBkaFiN
         1Kmw==
X-Forwarded-Encrypted: i=1; AJvYcCU2CMDXhbd6Bym9X2Q8HcVS8SQBpRyw2FZ9fHYh6SLniAkUCxjv6xb+dLIqltpkhYYgTKVdXbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywry6+3AMtuTdlGPnji9A4VZlR1g2y62WCwSs64i+bn71lFFvtS
	bRCZtTqS4cmF9tN+42oArI4kh4Zc8Rde6ODdH4tc6jQpG1j4q3d/
X-Gm-Gg: ASbGncsXldx80Hh502uIROnZrte6Y6pbMI8Jyx9EuKu9lfBBTpAAlKFJBMoYhjj6kLv
	ylOXaVnKBaC1ut7w087ftPF+oJQib1wUTorEaBpHNq2OqQ0CCcdXhSoTKrdllPtGhwGbcKSPqN7
	cOQ+ZTY5f/AqLHDQmpKm3ZC9FuGGcFNdoFwOBu9arYwrLceyp9VcdYS32pIvbeKeyXXpkT4e3dK
	ib4sJ+hz7mRnWD6NnycFEtlb9uJXc4avdMhveiCq1aTnUn2ENPM50ErgIywTyWyUlmZX3TbSoj6
	++4SOaHga+sLALpYYk6TjVWqEfpDbzXoFRkCwObEP09+vbKS3YN6wBks+XdbpHMKbA==
X-Google-Smtp-Source: AGHT+IHAo0Hxu6wpXRvbEjPPIbCo24sMvGPV4AFI7OGhkyc7fyyqXnOD2oQm4hIfSJ9vFwikSGOSFg==
X-Received: by 2002:a5d:59a5:0:b0:390:f1c1:d399 with SMTP id ffacd0b85a97d-3911f7bb9b8mr3754983f8f.41.1741200919032;
        Wed, 05 Mar 2025 10:55:19 -0800 (PST)
Received: from [172.27.49.130] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd42e6c4esm25387335e9.30.2025.03.05.10.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 10:55:18 -0800 (PST)
Message-ID: <53c284be-f435-4945-a8eb-58278bf499ad@gmail.com>
Date: Wed, 5 Mar 2025 20:55:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Fill out devlink dev info only for PFs
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch
References: <20250303133200.1505-1-jiri@resnulli.us>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250303133200.1505-1-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/03/2025 15:32, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Firmware version query is supported on the PFs. Due to this
> following kernel warning log is observed:
> 
> [  188.590344] mlx5_core 0000:08:00.2: mlx5_fw_version_query:816:(pid 1453): fw query isn't supported by the FW
> 
> Fix it by restricting the query and devlink info to the PF.
> 
> Fixes: 8338d9378895 ("net/mlx5: Added devlink info callback")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/devlink.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> index 98d4306929f3..a2cf3e79693d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> @@ -46,6 +46,9 @@ mlx5_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
>   	u32 running_fw, stored_fw;
>   	int err;
>   
> +	if (!mlx5_core_is_pf(dev))
> +		return 0;
> +
>   	err = devlink_info_version_fixed_put(req, "fw.psid", dev->board_id);
>   	if (err)
>   		return err;

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

