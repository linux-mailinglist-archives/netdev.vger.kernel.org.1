Return-Path: <netdev+bounces-253130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L9CLEC8dWnFIAEAu9opvQ
	(envelope-from <netdev+bounces-253130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 07:46:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E34B27FE70
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 07:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9321A3008521
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 06:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926503161B1;
	Sun, 25 Jan 2026 06:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZngNz8Zf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F825220698
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 06:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769323581; cv=none; b=WHjkp83JKP8TPyjkd0w9vVPeKE5rwgK/7T/kv7WER5RNTRKzEz+RCVyfR64zHe4jA7s1YlMV8AI4TwIXH1weCN6cbACDwJ2YXI2+tHg0j5mxEjW+byM8jUfHyRopm6ooYqSpj17NUEIbR/cE8ZNSS7Me1+do4qV05Ry75KqYaKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769323581; c=relaxed/simple;
	bh=LDOrL8XlWQvOL0JePynnRBgKzjJjjdkMvGsbnlKQOGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRSVipNPL4EDBZaalUQcabpKsBML9Q9rHRJmPXpHOVeI/5DjBew8/ilIKq6GM9g0Sdz+F5Zl1lcB9ItLvaAnx1qWKxH0eCVL/hlFlodcB99Y7c2fVNa3bXsLrPuZqVqVMi32eBGb81rSoQbnl5xxjbTyfhgjZRn6nEJDCoWMBs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZngNz8Zf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so25483375e9.0
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 22:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769323578; x=1769928378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LUe25BLM5rjKQ7ExOwmVjq1ZKK3cmoNWIWE22T5uU3Y=;
        b=ZngNz8ZfORwY6BSQOfqICrj9sedgpqqyBdrdNajPFEMUBWVmLRM5pqPoVMd6/FKK/L
         UyOcZrsoOolKYFDVGeRcITz9lPBl0W6fs2vSSe7rWF/93pjjU+tSE/QbNkM5+CYh3F8v
         puVcOvYH0Czc01YZ0AYqsZQ8N5iQP93BbG9lC3UknBEpXeS7PEmBXXt3qC9FlcGv5h1f
         7bO+RNJmhoSAmQX/mVtO/uMmJSX2nvfiLwJ9BMZMoftp/y8VENO1kMh4xXChtVuq4tKC
         5rmTnthmawio9NCCeL5GoYcpQjwFLPcAKXkMhLT+cXLip2fJRYIM7OcBpsDua9fCyALk
         2Qdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769323578; x=1769928378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUe25BLM5rjKQ7ExOwmVjq1ZKK3cmoNWIWE22T5uU3Y=;
        b=vRFq4bM0d16EShudhqMySD07mlgZe9uL0/xh+V6V4ksybdqrM1wwIJiQ5l5yUsA+vQ
         oinRN02vwLsFFSYAA0M2/VF7uyUVG2KmTNWFCQRF8jcGlWGBWKK2iBzz1SCrNIN1QZ93
         2Cr0/8oCgH+c3jSFrlIYHYZZgCoS6jg63P89/6ttLbGJuBRUPBVj1lgyr0K9Zris4jrq
         WpdvLXdCxGLgAQEpDAEW621CL++fW08VLCsukXF65+m6dTp6mzmeQcBj0QdP6qQ00C0v
         oKx9ZAaGQUEO1JuhLFp2be4MKMXRgDHQ9Z/SB6KU+krKrmgBmh9lZNWa83FxtAhCGH/f
         6Z2A==
X-Gm-Message-State: AOJu0YwAZMiXp2KwWUKNokCGRBkYBr/OGmWJcey3Q560Xq0l8PZcey2k
	ARqv1GSVS15fyXsFUUojQVsuWhNmhtCFtLoulWC910P7/Mdo7jgGAbMN
X-Gm-Gg: AZuq6aKK6MlsMdHE6x5/1Xu83lhgOS77OmLYvZXpzpsM/Sd/7CcabsaPybw1hPpeDfX
	0+CPBxI0OzaJb919/w9vjZT76gLAavoRUz7uM7MDu6c1IDxfp8OAukz+8/mlZeVvODqgIL/eFJI
	aTf8YIMADQllgGgPi/pSso4rE1JaBHLuPT3iV/0ndZntkeiRWocVf49zB/5rFesGORXfDF5Gn83
	AhLSCcFok1mTkT2ZYpubRwYgDBQn1WzKf7SfHTlo4X2rM43dDpWhpFDrDMYUlqiEvf/gm69QF8v
	M1dXIXnSBftSppiGe9j2WW5KnVdQ601dVuKxtCKfh0Q8BgTguSQNor2Wf/XSFS5eVzwRP7elB+p
	k6WMkvVBOMsgI6kHJH3qV5fjrHLcw69poE0GT4MNHnjYslcWkCxA3HN5LJ1fj0byTl0fdwNnh8J
	CsyNkLSKtXTS4OVi1L0PNW94fcGVzqS4YPaM4=
X-Received: by 2002:a05:600c:621a:b0:47a:81b7:9a20 with SMTP id 5b1f17b1804b1-4805ce42517mr13353345e9.9.1769323578100;
        Sat, 24 Jan 2026 22:46:18 -0800 (PST)
Received: from [10.221.200.179] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804dbd4630sm65540735e9.17.2026.01.24.22.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jan 2026 22:46:17 -0800 (PST)
Message-ID: <56f850d0-efbe-462d-9034-d1c11453cff2@gmail.com>
Date: Sun, 25 Jan 2026 08:46:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net] net/mlx5: Fix return type mismatch in
 mlx5_esw_vport_vhca_id()
To: Zeng Chi <zeng_chi911@163.com>, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, mbloch@nvidia.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, feliu@nvidia.com, parav@nvidia.com, witu@nvidia.com,
 ajayachandra@nvidia.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zeng Chi <zengchi@kylinos.cn>
References: <20260123085749.1401969-1-zeng_chi911@163.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260123085749.1401969-1-zeng_chi911@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253130-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com,nvidia.com,kernel.org,davemloft.net,lunn.ch,google.com,redhat.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,kylinos.cn:email]
X-Rspamd-Queue-Id: E34B27FE70
X-Rspamd-Action: no action



On 23/01/2026 10:57, Zeng Chi wrote:
> From: Zeng Chi <zengchi@kylinos.cn>
> 
> The function mlx5_esw_vport_vhca_id() is declared to return bool,
> but returns -EOPNOTSUPP (-45), which is an int error code. This
> causes a signedness bug as reported by smatch.
> 
> This patch fixes this smatch report:
> drivers/net/ethernet/mellanox/mlx5/core/eswitch.h:981 mlx5_esw_vport_vhca_id()
> warn: signedness bug returning '(-45)'
> 
> Fixes: 1baf30426553 ("net/mlx5: E-Switch, Set/Query hca cap via vhca id")
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
> ---
> v2 -> v3:
> - Shortened the commit ID in the `Fixes:` tag to 12 characters as suggested.
> - Added a `Reviewed-by:` tag from Parav Pandit <parav@nvidia.com>.
> 
> v2:Added the required Fixes tag and specified target branch net in subject prefix
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/eswitch.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> index ad1073f7b79f..e7fe43799b23 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> @@ -1009,7 +1009,7 @@ mlx5_esw_host_functions_enabled(const struct mlx5_core_dev *dev)
>   static inline bool
>   mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id)
>   {
> -	return -EOPNOTSUPP;
> +	return false;
>   }
>   
>   #endif /* CONFIG_MLX5_ESWITCH */

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>


