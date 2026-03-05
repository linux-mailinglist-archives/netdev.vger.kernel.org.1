Return-Path: <netdev+bounces-264211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOCcEl83qWlk3AAAu9opvQ
	(envelope-from <netdev+bounces-264211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 08:57:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8D320D071
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 08:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54EEB300AB13
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 07:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8B333AD87;
	Thu,  5 Mar 2026 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEHco10t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E4B33A9C9
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772697423; cv=none; b=KvfPF+LgyPxwB2vMZ6j8NLBoeLozCj1ufQ21sov9xD/e27LUvUo9ykhm1msFUIe9/Kw2jy/XhDsbaapcmhghBY6fVFodsN329qm8zMJcEDZVlmGBbl1/8jVB4t/P3OTayKnzJ5ESDRviOecROzsSeZ3Rfuku3t+UUMEEK0wunco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772697423; c=relaxed/simple;
	bh=4wIxeVTtUPRh42TWlTdhNgCgomVeyReKlBgjR5dJ2js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHag92LmaAUjfWvAThNionq4yuwGgKD7A2+0fPImhh51CsPrml9lHavyKutwCOss8eArcL1zM2MihoCBE1o++AyCr5/kzw1UI2UqBSHYLL1TbDGM7JcJeTUJNfOq1PWxVToBBUlmzxHlyYHVN+pG5w0EUjW+GrnsHeYQOFly75c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEHco10t; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-483487335c2so63652015e9.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 23:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772697419; x=1773302219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VLoLFtQnBLuT+MV5dFOmu6NN10b/asgsiLccSm2U4ts=;
        b=bEHco10taJSnYvPwnxuD+kIz+NYB6VxwovQeBraNNHDnrOVfgA9wI7t8wvQkHHZHua
         W6jYrIvNdN4B1n3pNfcPVz9GtvzYvvTzfSl0Dgyh0rpzyizBAMe2ZjP5oN328a8I6aei
         4iU97xIoe4rC/m63EL3WTFyDWEWPd6+jM/6O9GQvdE4DxA45rOtVcjYRHBEC2Ikx0Qel
         2Zi1ZlVbh/kzKX6//yZHY1w0pTFB4isOPEPwg6v5ocaoKfPabKHMqeeVY/6xSUVSmHyy
         3aZBtUD6mAbauP3kPhEcugYBEcma4Nl29Eb0m4Hro0TixXExEkWkMN9jH3C+43/I0RcR
         3Thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772697419; x=1773302219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLoLFtQnBLuT+MV5dFOmu6NN10b/asgsiLccSm2U4ts=;
        b=n/7kqIQF5kl/YpKh1iB/BmC+aJLK2FPeaHIjj02aOsYHiLn7ZJeXiZGdOHgSgu2f2Z
         iV1bcYBDCC5csgyfwQW68F+w/7n74sc4Zn+M6Cr5h2mBW86Dv09lP38a6Moiax7w/SYi
         IvxGbJRfzMpYcOJxqGhdhK6DrbyUWBxICjXTyKJu/ZvYZZHFdvTxurW+OXg8UvGopdx/
         GV44F1nPUMCtavrEENcdF93WSXbqJ1GzFH9dQbdirztPmNk0yTNbvAGCZ4nCfBKjwn4y
         /fYtTQpKehSVgwycX+L0osibzKJ3vVRnyHhIQmn8sXVh2taanJTKdXVun9wzGGK1vm3E
         DNwA==
X-Forwarded-Encrypted: i=1; AJvYcCXWh0G45sp9BdmJkw36f277EZPCQXNkcqB+/ebjbZa8BQhZow6/kYdnSMChQWjlJRno2LWOnrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwckOv0JvjrWW7DNuuXaRZEnHGOGXIfFu0TCwqaizfeZTOrb0mq
	rIEzdpaawO3UJeJ5Xa+gQnnXBuyknoF6tjKmj733yObw48yM6Tjia3tD
X-Gm-Gg: ATEYQzwh4zEcUG0RxatDVYEaaq89uHBknjI2703ZVx4cz6v2pHAWR8wN0HZHy3JyMa8
	1tRvoXX14Vg+lsCh8P0s8Jba1S0VKXR2CIrT1DPZSCnAem0k3D3NchrSsnttNb9UC3Yc2AugQsB
	bPX49LMaHCtSsN6FxY8nM0QaomSSZi9AUymr+HbvULSSINia5F/tt+bD0PfAMttrYN/7/mhC9mw
	v2/rWqdgnfcelatIEWHIpHZ/lgL+6XDYWVhBKMCc6xRtyD8Af8IEir4Bna7i+KbmZ4St1ik7/AD
	m9+EAaG5pCH7toRGeeVvCUFYoylYZ341pBFd7bd55te2lTarNkbT40HuGvp0UjhEgwqP8NA4on8
	My3RuyL8PSeH8FBxNupSB+yC2TzzNqQS0WYKd+SwN5xPXKvl3DOEfJwHSsQX7XhBRErv7lVJ1e3
	v71SxNKqFhDgDrehSJsdojDqu5/TcY2NpnbCsJ/5/d3/c21NxnuA==
X-Received: by 2002:a05:600c:1d09:b0:483:6f37:1b51 with SMTP id 5b1f17b1804b1-4851988366bmr83224505e9.23.1772697418510;
        Wed, 04 Mar 2026 23:56:58 -0800 (PST)
Received: from [10.221.137.160] ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fadf67bsm36856295e9.6.2026.03.04.23.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 23:56:58 -0800 (PST)
Message-ID: <d6fcf417-87b1-4bbe-9ec1-cabb2b2ed1a6@gmail.com>
Date: Thu, 5 Mar 2026 09:56:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: Allow asynchronous probe
To: Gerd Bayer <gbayer@linux.ibm.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Alexandra Winter <wintera@linux.ibm.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20260303-parprobe_mlx5-v1-1-18194f2a1a3a@linux.ibm.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260303-parprobe_mlx5-v1-1-18194f2a1a3a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DE8D320D071
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264211-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 03/03/2026 12:33, Gerd Bayer wrote:
> Announce that mlx5_core supports asynchronous probing.
> 

Hi Gerd,
Interesting patch.

> Tests on s390 - where VFs can show up isolated from their PF in OS
> instances - showed symptoms of "mlx5_core: probe of 00e7:00:00.0 failed
> with error -12" when booting a system with a large number (> 250) of
> Mellanox Technologies ConnectX Family mlx5Gen Virtual Function
> (15b3:101e) PCI functions.
> 
> Turns out that this is due to systemd-udev's time-out supervision of
> "modprobe" killing the sequential initialization of additional functions
> if probing exceeds a default of 180 seconds.
> 
> According to [1] device drivers could (slow ones should!) opt-in to have
> their probe step being executed asynchronously - and interleaved. With
> the mlx5_core device driver announcing PROBE_PREFER_ASYNCHRONOUS as
> proposed by this patch, we've measured 275 VFs being probed successfully
> in about 60 seconds.
> 

Nice.

> [1] https://www.kernel.org/doc/html/latest/driver-api/infrastructure.html
> 
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
> Hi all,
> 
> this patch helps to speed up boot times when there are a large numbers
> of Mellanox/NVidia VFs in a configuration. Although we've seens real
> issues, I'm hesitating to declare this a fix of commit 9603b61de1ee
> ("mlx5: Move pci device handling from mlx5_ib to mlx5_core") primarily
> because the concept of asynchronous probing with commit 765230b5f084
> ("driver-core: add asynchronous probing support for drivers") was
> introduced only later.
> 
> Thanks,
> Gerd Bayer
> ---

This is an interesting problem, and the proposed solution looks 
reasonable. That said, this is a very sensitive area and there may still 
be hidden assumptions or corner cases we haven't considered. This needs 
thorough testing across a wide range of real-world scenarios and 
different system topologies before we can be confident in it.

We'll take this for testing and report back once we have results.

BTW, as you probably know, a possible workaround is to increase the 
systemd-udev timeout.
What timeout is required for it to succeed without this change?

>   drivers/net/ethernet/mellanox/mlx5/core/main.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> index fdc3ba20912e4fbc53c65825c62e868996eff56d..b53fc3f2566acf5a07cb8df649124c4a87f3e043 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> @@ -2306,6 +2306,9 @@ static struct pci_driver mlx5_core_driver = {
>   	.sriov_configure   = mlx5_core_sriov_configure,
>   	.sriov_get_vf_total_msix = mlx5_sriov_get_vf_total_msix,
>   	.sriov_set_msix_vec_count = mlx5_core_sriov_set_msix_vec_count,
> +	.driver		= {
> +		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
> +	}
>   };
>   
>   /**
> 
> ---
> base-commit: c69855ada28656fdd7e197b6e24cd40a04fe14d3
> change-id: 20260303-parprobe_mlx5-d10d2a746d3a
> 
> Best regards,


