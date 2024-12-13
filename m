Return-Path: <netdev+bounces-151772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130899F0D3D
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6E7282F44
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD7D1DFE39;
	Fri, 13 Dec 2024 13:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="KATZTMhv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1C11A8F85
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734096297; cv=none; b=PlDqZBexcxuvdiSyRUckyHJcA19YH2oG/KXD7HdqBNxgGU5fXFvNuL316k1pQ55tAi6muxrMmsF0nn5IvYVVQcAvRfDZgJkn7Hj4yHYIEh8YwWhc5Q2CWIdWLoG8b+9ldtmoHWNcA2QjEu7MTQd/2uA/ZsGqZDLiO74nTTMu7N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734096297; c=relaxed/simple;
	bh=KFvrk7iMDeiRb29yhIQA6RUnqsz7v8+LfUhinDgDYac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bVzqoYGd851NqpRBP8BNFcECj/Wogc/nzYZ5f9y/iDw7XKUCj5jgBgcL6vDqcCvazAUMRIEoXbj2B9Hm0yleuem2kBHnbuKZUT5dZKwdhqkldyY7byEwgxJOnxSY2FrWYM/MEqgf0hx9a9EffP8OG/Ona+jbrL5R+rmeLzpQ0Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=KATZTMhv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-432d86a3085so11676615e9.2
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 05:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734096294; x=1734701094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SjV0sYdlCYEO/0cmEQUxcLhIWhKPNexrhql7ZZKqBxU=;
        b=KATZTMhvedqWujwVTVqDtxX4mektI5oLTiMwaZs+WIDsQCDg5H+OoyHmGG8D37x08z
         J4Fy5VGtJ9bJtm0U/+cN13L304o2vGRFEn4t4HMbvHgpH1hctnP5qipOZ23ITFOyktjS
         fnM3Ut/coxHFVx00yf4Qf5ez3fiyJBRg3htcBUMNvMoC34uj0YqmOvkDJ/Uqj7Czeomd
         EwK5vbXvC8G7t/IMTHZsMNu5m8jYzFN3Pt4HTGBd+I/5Q5l9eaHfo+82k+MDINTc8k0R
         xChT3XE5bnFtBB8zxOTCh2/vHcrGRVQvMiqBEbkIXMHI3KmOHXc4c5ZZIa3Q0ZilvXPF
         nZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734096294; x=1734701094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SjV0sYdlCYEO/0cmEQUxcLhIWhKPNexrhql7ZZKqBxU=;
        b=cL3JM4sZ/JMM3hH+iI0NuHaFVkEDnhx1sm12PYw6rXd+k6HCd3GRrpyU00hNUOFoiC
         WcJn5G6KLq60qiyk6w45CMUUuA3kmxRfOSgrTEa2qUIqogoPmuRdhI00rz145Rb9ElIf
         Az2ZAj4wlkrLY8X+eJxVtcoK52bun66wn9yI2Q1U2wyAflY4ZpqexXGDYGAv8YgM6vgI
         0EKxrZ3BPV+6QIFtL4yS6CcDQnkgrljU0LedThoQDCuJ7eAHlNOSth4Vrc/ZrxbrBE+y
         vfL+HZijwpoRqrql/A8eve63VinAGLnqGbHMh+PUo/MXmTGPKCKcLch5C/U0KCVFyXf3
         WLTg==
X-Forwarded-Encrypted: i=1; AJvYcCUU5N6T29LAMFr9ly7kqYd9oiTrJlVPJIFpPt6MdIdPrxFaoLvekEPcYcXLO795ad6U8SfsYxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YykfkKHlW8YlQVMox7KE5JfAfUn3g4mRnzj+oohtyfu2uVfpT8R
	hGDCciuBhGRQe0oQ+NqRVugtI91NnLRNSNoSTLiYxTlznSHH1dmnM2AC990Li74LuQGcLaJZEXy
	8
X-Gm-Gg: ASbGnct/sphgj+UvRS9fT/Hy2W0Gfax/KhCmG2b1EN1BLG2xEcj15dOw7WRUi7unsHT
	FY9igOPqCUNnj9S9cP1f5ony+UR3D+on8CKjeEq3+hv3Zh/BZuMdMf6bOK6j0+1MTYYFCgxWMHP
	NFh6pcEdvmvbOhdf1VANBu39ICFjkff0sbq5HxzlBzbiP0vGo74Vi2sXGejuJOEu5rElH8PfoJG
	3/bdt9nvulT/xAYSY+SV2rRfVBK+ejZfuwAjNTPn6czKPvJ7wOQthAdtbB2xeg8VgEdgfClNa37
	Mu5KNId7J805
X-Google-Smtp-Source: AGHT+IFOat2R0Ywru98zWRymUpP+3VDb0WkX5ikGdf9OGVD11icxnaTulyC4mVsEMOkO0+/l8mDhNw==
X-Received: by 2002:a05:600c:4e8e:b0:434:a4fe:cd71 with SMTP id 5b1f17b1804b1-4362aa2eb58mr20949405e9.12.1734096293626;
        Fri, 13 Dec 2024 05:24:53 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625553234sm50592785e9.3.2024.12.13.05.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 05:24:52 -0800 (PST)
Message-ID: <4467dd36-50b0-4a7b-b71f-c45210b521b0@blackwall.org>
Date: Fri, 13 Dec 2024 15:24:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] team: Fix feature exposure when no ports are present
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: liuhangbin@gmail.com, mkubecek@suse.cz, jiri@nvidia.com, pabeni@redhat.com
References: <20241213123657.401868-1-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241213123657.401868-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 14:36, Daniel Borkmann wrote:
> Small follow-up to align this to an equivalent behavior as the bond driver.
> The change in 3625920b62c3 ("teaming: fix vlan_features computing") removed
> the netdevice vlan_features when there is no team port attached, yet it
> leaves the full set of enc_features intact.
> 
> Instead, leave the default features as pre 3625920b62c3, and recompute once
> we do have ports attached. Also, similarly as in bonding case, call the
> netdev_base_features() helper on the enc_features.
> 
> Fixes: 3625920b62c3 ("teaming: fix vlan_features computing")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  drivers/net/team/team_core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index 69ea2c3c76bf..c7690adec8db 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -998,9 +998,13 @@ static void __team_compute_features(struct team *team)
>  	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
>  					IFF_XMIT_DST_RELEASE_PERM;
>  
> +	rcu_read_lock();
> +	if (list_empty(&team->port_list))
> +		goto done;
> +
>  	vlan_features = netdev_base_features(vlan_features);
> +	enc_features = netdev_base_features(enc_features);
>  
> -	rcu_read_lock();
>  	list_for_each_entry_rcu(port, &team->port_list, list) {
>  		vlan_features = netdev_increment_features(vlan_features,
>  					port->dev->vlan_features,
> @@ -1010,11 +1014,11 @@ static void __team_compute_features(struct team *team)
>  						  port->dev->hw_enc_features,
>  						  TEAM_ENC_FEATURES);
>  
> -
>  		dst_release_flag &= port->dev->priv_flags;
>  		if (port->dev->hard_header_len > max_hard_header_len)
>  			max_hard_header_len = port->dev->hard_header_len;
>  	}
> +done:
>  	rcu_read_unlock();
>  
>  	team->dev->vlan_features = vlan_features;

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


