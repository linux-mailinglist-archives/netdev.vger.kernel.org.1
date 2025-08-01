Return-Path: <netdev+bounces-211327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313BBB1801C
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 12:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C77C560357
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 10:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C34233714;
	Fri,  1 Aug 2025 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="sKkEAK+q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E61221723
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754043896; cv=none; b=a2BuY5yb2MoMNH8MiMP8pYED3t+z0HMMV2iOIyQKrIyT7+3wbf31RYWDXvLAnSeDBA13XCu/AknR31gW7f6zFBXQFKThAAOrvD7ljtm2bZGleoXUNz7IqLMoFnktjDoPUblBCYH1SKMFxeSbAIWBChLlUOZX5Q9akhROPGuGJac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754043896; c=relaxed/simple;
	bh=6Mq6oAQNk9G2vGUWKhNW/phyNRM7m+km9IU16P/sDMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbPYF6vpPvvqNrbTp6wlNUhYfSFi5ORBYegznUwWHfL1kcWoaFCbzQw6vKHVvagqmaqKnUuRUPGYuv0mlfuBreVv3mCMEU2qFpVpYcqlVDwc4xExnQ6hRO0d5whHEagpUn0zJfbQjFpZtBkp5hTcJoHkaWqH5ibjVq22za3Fsqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=sKkEAK+q; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-455b002833bso6933105e9.0
        for <netdev@vger.kernel.org>; Fri, 01 Aug 2025 03:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1754043893; x=1754648693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RXz5l43BuR/bYmJ36qm34Ab7vEbhJOs7yXXKOmMn1Pg=;
        b=sKkEAK+qwgcnmGX7Nl4kr4iTyARkvQfcQQeYGF0MXK3w7xSzD2IKsv3uIvwYc3OUWc
         l+s+x0WitM2PuX3Ky8OMmE0MFY+pAA7Q9NaqbkbnNFZcM/u00FXeVEHpM+LkUBedLU70
         eptSGjA+AYFTth+thjYHN0/kE6NNoO+X5Ko5HsiBEPSgCuWF/HiXdxFO3BiF+V8/NS5A
         B4x2B+B4HBIdfZUNpicLM+ZaDW+m81Uem7cTKNtK/MG90ALaOqXze2W5Ax1a54JDo/RE
         bKHxNv2s4H3WKlLD1lS5VHsCqfm4AbrvRIyD6+VJZ1NccOR/POMXJpQ9oINVyoufuBiQ
         JeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754043893; x=1754648693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RXz5l43BuR/bYmJ36qm34Ab7vEbhJOs7yXXKOmMn1Pg=;
        b=uvnPKHTwLQl9fxjjhUxWT/KT7YuB81f2Nz4g8mwYzVpd6ysrS1P10+DxUEKKcsj2Nv
         SJOBZz443TQsPo7EFSb2pzwHdjqegBCZNQuv+fFriLarKJaQykiZWQXHWRhiqHw7ApXE
         kaNX69tOjp76iNK31q4K0oQtLjoS8hdnLgbQELwhJM3blUhMTKazVydj7hsm2aYWoJYb
         BoT/BTQrSgBfSs3qoeM8gvk2JuEpVRxPAl7n1P8bcYTWvvpcCPKt/EcxuauxGPaiQtM+
         Y+COkbV83xMiCx9t0dproOyy7jgqUtqwrKyuektd6iKuXhkNbLdaqyCIcAzfhfh1qKtt
         ra3w==
X-Gm-Message-State: AOJu0Yz66xWpl1Xq7XRcXsakh4cYcoNgveQ6bsX91IHLc5rQnhL4pJpq
	207xB9GLixGqJVke+cO0nfJt9cJm0FiZQv61Z1J6BKD1Eupzi9TewVTJgjtRh2Jws1o=
X-Gm-Gg: ASbGncs64pWO0x/06zc3h93ZDYY4ZrVwuhOYf3z4pjfdmVspiLb7GzMM3kvjLLIuoM7
	mqFTa6aHR2qRyLTY0mQgsJCiVixgVhu9Yoh+W5cUHjQucLvlyy2yPIByBbBbNiJjaylknoD7d2C
	xb1t4nsFhoRWXVUUOrZb9rBHiiU7jYRvIgXgu50Ta5/ns/pqdwPLITsHXy0o4niRZNzFYVoFR6N
	leWtSCvHOX2hed1f6VU3pygsTRlo9vMpm1pByzDT8YthJkZAIQmNoCxqYnxGchmgT17xVg6GD3A
	h2TukgbehbWPWT/g0ViUTJfx/0hc1Wqo1CEm1ofomQqB0VwIqToQatWO9LR/OqKg6kFGCIKT19D
	71cyUGXCu2tsk0ZN6O0tkY1QwNo8M6aRlqnHi9sbJW3bg1pGb3ock3Tf+8Uk5z93U
X-Google-Smtp-Source: AGHT+IHrrBxuIk4uMp4NxvYRpxZVKZWLA6LtZYbX6EDGswGHHdVdl5ACmSynIRjCaNFs0Uyzw63xyg==
X-Received: by 2002:a05:600c:518d:b0:442:f97f:8174 with SMTP id 5b1f17b1804b1-45892bc6f5bmr105851345e9.18.1754043892507;
        Fri, 01 Aug 2025 03:24:52 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c4beasm5292931f8f.30.2025.08.01.03.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 03:24:52 -0700 (PDT)
Message-ID: <04b0f2b9-1aa5-49e6-9522-80df7a8f1a45@blackwall.org>
Date: Fri, 1 Aug 2025 13:24:50 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] benet: fix BUG when creating VFs
To: Michal Schmidt <mschmidt@redhat.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250801101338.72502-1-mschmidt@redhat.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250801101338.72502-1-mschmidt@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/25 13:13, Michal Schmidt wrote:
> benet crashes as soon as SRIOV VFs are created:
> 
>  kernel BUG at mm/vmalloc.c:3457!
>  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>  CPU: 4 UID: 0 PID: 7408 Comm: test.sh Kdump: loaded Not tainted 6.16.0+ #1 PREEMPT(voluntary)
>  [...]
>  RIP: 0010:vunmap+0x5f/0x70
>  [...]
>  Call Trace:
>   <TASK>
>   __iommu_dma_free+0xe8/0x1c0
>   be_cmd_set_mac_list+0x3fe/0x640 [be2net]
>   be_cmd_set_mac+0xaf/0x110 [be2net]
>   be_vf_eth_addr_config+0x19f/0x330 [be2net]
>   be_vf_setup+0x4f7/0x990 [be2net]
>   be_pci_sriov_configure+0x3a1/0x470 [be2net]
>   sriov_numvfs_store+0x20b/0x380
>   kernfs_fop_write_iter+0x354/0x530
>   vfs_write+0x9b9/0xf60
>   ksys_write+0xf3/0x1d0
>   do_syscall_64+0x8c/0x3d0
> 
> be_cmd_set_mac_list() calls dma_free_coherent() under a spin_lock_bh.
> Fix it by freeing only after the lock has been released.
> 
> Fixes: 1a82d19ca2d6 ("be2net: fix sleeping while atomic bugs in be_ndo_bridge_getlink")
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> ---
>  drivers/net/ethernet/emulex/benet/be_cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
> index d730af4a50c7..bb5d2fa15736 100644
> --- a/drivers/net/ethernet/emulex/benet/be_cmds.c
> +++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
> @@ -3856,8 +3856,8 @@ int be_cmd_set_mac_list(struct be_adapter *adapter, u8 *mac_array,
>  	status = be_mcc_notify_wait(adapter);
>  
>  err:
> -	dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma);
>  	spin_unlock_bh(&adapter->mcc_lock);
> +	dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma);
>  	return status;
>  }
>  

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


