Return-Path: <netdev+bounces-109561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888FC928D9A
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 20:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47BBA2834DD
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 18:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E4716C87B;
	Fri,  5 Jul 2024 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="elqokpdL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9E281E
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720204961; cv=none; b=LujlzGpwR2jmotiKTOLnx97P8Cnm9UMZNeD4n0JYNVKy8KsGs30TLzz5tE4ftbjZa1eFndjjqlgjme+tCGnTFdIXa2KQFZ3BcsEjXlihkjjFkvMM6t8aOLoVBY9t1jJMhWcHOd8INZCUSFPqLrea/gjBTGi0OcHBWB25UmBN0rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720204961; c=relaxed/simple;
	bh=gNZKuI5Rdk9eOuppPB3/Sw93HRub2msB3pi/0b0psyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfW4ENIgGaAIOGjqKG+AKibyF1/iIXAqLlFuaalK8vYRcKSytXGDeWtq1U4T1Qv1AX5aLuYX6G+3mEzxm9x8awczyiypMpEJCy63Zj7WIKLZyaMYnIf4p+2NNvnfKbLRvPGDW2FVR6jj2iTULU+MXSuda0aq/Utrmt3HW3Cib7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=elqokpdL; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-70df213542bso1074155a12.3
        for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 11:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1720204959; x=1720809759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=365s+OOpeGLX38mp/s9fwwXO1Xbubh83KH7yyJikVI8=;
        b=elqokpdL/hsHo58Chy/y9sGK6DAIrRgMGM2ToYIXZk4OXrPJtNXDHr3lqz/x6YydtQ
         lPtVyOf4BBLmtr7aXe18I3wzO/7baphB3mbhCQPXNVA8LFZ1/yjbu9Q91VBWp2uRUwgD
         Nk/Sh37p3r0RKWGGXdLP3N3TW3oxrPmo6X/rx7xJCIRiifd3KbCfGN2KRUf1HJilEQBt
         OHYPrZoyjlgGNaPR7ZLqZu8pcqPAA2vjenRV38XxStOuQcm4q1T1T3nfkZk1RX4NM/jE
         3ocHaTX8HqziUj6vKvYyvxWgYSDA0k5hrmlE5Z4WPTIZcHR0Bs0YywrQthVABLAXsOfB
         GNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720204959; x=1720809759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=365s+OOpeGLX38mp/s9fwwXO1Xbubh83KH7yyJikVI8=;
        b=gUcqCpFwrqV2BA2GiGoS6NuQ7utRvhdslF/REHK2/a87c0du/V037LVyIhBU1OPyYZ
         prAbiw3irbvOwAc48IThnc7pvVRjco0O53kfucvRuyr4qSNj0SOjI9rDzQpWQ3gjv2lp
         8jk5RREUdwng//wApCEADCDYuxsE5vNX7ZGCWQc6CByUiXVhq1IQ7v6vjFabpr4Iq0Dd
         SuMgfwNzajkNSs+aE9o8ROHysg2aOWGitGBImF+3ACIzp7F/cglPZy8hFc9BO4PvO6N4
         Qdmqgvyt+R2nD9SNkOH0WM3cT19N43fc7AaHlbmFBO7UIcgDO8PctdfF3eVoRpa67rme
         T6vw==
X-Forwarded-Encrypted: i=1; AJvYcCVbj1TPDMCIu56kNficDb26Ykh0oSO+9g4lNoQsD8Tk25iFE48VwjwBji5iaMNL7UZW83JSowZkAULcUh3JCrc8aUq96j6I
X-Gm-Message-State: AOJu0YztE7vNivHbO80ulbh/mQQi3igM6C6zJEa4iDddWpGeDOITgmI5
	bfLkiG1s7WHliFxY5xGArb0JxH/WtONK6sVSAbm3Sb1dqeeRmy6JKDFR+lCjjOI=
X-Google-Smtp-Source: AGHT+IEPGJ0Rz9fgjmd8xiRuK6L+nvC2o0gcWxVIKQln77diNSr9XCjPi9O7kfEwobUiuH8SdKMDhg==
X-Received: by 2002:a05:6a20:6a11:b0:1bd:2555:a4fb with SMTP id adf61e73a8af0-1c0cc73920emr5485933637.4.1720204958797;
        Fri, 05 Jul 2024 11:42:38 -0700 (PDT)
Received: from [192.168.1.13] (174-21-189-109.tukw.qwest.net. [174.21.189.109])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb18b1fde8sm53938615ad.297.2024.07.05.11.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 11:42:38 -0700 (PDT)
Message-ID: <d4b341f3-7c0c-47cd-b7cb-81f9fccd3d0f@davidwei.uk>
Date: Fri, 5 Jul 2024 11:42:37 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bnxt_en: fix kernel panic in queue api functions
Content-Language: en-GB
To: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, michael.chan@broadcom.com,
 netdev@vger.kernel.org
Cc: somnath.kotur@broadcom.com, horms@kernel.org
References: <20240704074153.1508825-1-ap420073@gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240704074153.1508825-1-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-07-04 00:41, Taehee Yoo wrote:
> bnxt_queue_{mem_alloc,start,stop} access bp->rx_ring array and this is
> initialized while an interface is being up.
> The rings are initialized as a number of channels.
> 
> The queue API functions access rx_ring without checking both null and
> ring size.
> So, if the queue API functions are called when interface status is down,
> they access an uninitialized rx_ring array.
> Also if the queue index parameter value is larger than a ring, it
> would also access an uninitialized rx_ring.

Hi Taehee, I deliberately didn't do a check as it is too defensive. The
caller of the queue API e.g. netdev_rx_queue_restart() should be the one
doing the check instead.

> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 1 PID: 1697 Comm: ncdevmem Not tainted 6.10.0-rc5+ #34
>  RIP: 0010:bnxt_queue_mem_alloc+0x38/0x410 [bnxt_en]
>  Code: 49 89 f5 41 54 4d 89 c4 4d 69 c0 c0 05 00 00 55 48 8d af 40 0a 00 00 53 48 89 fb 48 83 ec 05
>  RSP: 0018:ffffa1ad0449ba48 EFLAGS: 00010246
>  RAX: ffffffffc04c7710 RBX: ffff9b88aee48000 RCX: 0000000000000000
>  RDX: 0000000000000000 RSI: ffff9b8884ba0000 RDI: ffff9b8884ba0008
>  RBP: ffff9b88aee48a40 R08: 0000000000000000 R09: ffff9b8884ba6000
>  R10: ffffa1ad0449ba88 R11: ffff9b8884ba6000 R12: 0000000000000000
>  R13: ffff9b8884ba0000 R14: ffff9b8884ba0000 R15: ffff9b8884ba6000
>  FS:  00007f7b2a094740(0000) GS:ffff9b8f9f680000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000000 CR3: 000000015f394000 CR4: 00000000007506f0
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   ? __die+0x20/0x70
>   ? page_fault_oops+0x15a/0x460
>   ? __vmalloc_node_range_noprof+0x4f7/0x8e0
>   ? exc_page_fault+0x6e/0x180
>   ? asm_exc_page_fault+0x22/0x30
>   ? __pfx_bnxt_queue_mem_alloc+0x10/0x10 [bnxt_en 2b2843e995211f081639d5c0e74fe1cce7fed534]
>   ? bnxt_queue_mem_alloc+0x38/0x410 [bnxt_en 2b2843e995211f081639d5c0e74fe1cce7fed534]
>   netdev_rx_queue_restart+0xa9/0x1c0
>   net_devmem_bind_dmabuf_to_queue+0xcb/0x100
>   netdev_nl_bind_rx_doit+0x2f6/0x350
>   genl_family_rcv_msg_doit+0xd9/0x130
>   genl_rcv_msg+0x184/0x2b0
>   ? __pfx_netdev_nl_bind_rx_doit+0x10/0x10
>   ? __pfx_genl_rcv_msg+0x10/0x10
>   netlink_rcv_skb+0x54/0x100
>   genl_rcv+0x24/0x40
>   netlink_unicast+0x243/0x370
>   netlink_sendmsg+0x1bb/0x3e0
> 
> Fixes: 2d694c27d32e ("bnxt_en: implement netdev_queue_mgmt_ops")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
> 
> The branch is not net because the commit 2d694c27d32e is not
> yet merged into net branch.
> 
> devmem TCP causes this problem, but it is not yet merged.
> So, to test this patch, please patch the current devmem TCP.
> The /tools/testing/selftests/net/ncdevmem will immediately reproduce 
> this problem.
> 
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 6fc34ccb86e3..e270fb6b2866 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -15022,6 +15022,9 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
>  	struct bnxt_ring_struct *ring;
>  	int rc;
>  
> +	if (!bp->rx_ring || idx >= bp->rx_nr_rings)
> +		return -EINVAL;
> +
>  	rxr = &bp->rx_ring[idx];
>  	clone = qmem;
>  	memcpy(clone, rxr, sizeof(*rxr));
> @@ -15156,6 +15159,9 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
>  	struct bnxt_cp_ring_info *cpr;
>  	int rc;
>  
> +	if (!bp->rx_ring || idx >= bp->rx_nr_rings)
> +		return -EINVAL;
> +
>  	rxr = &bp->rx_ring[idx];
>  	clone = qmem;
>  
> @@ -15195,6 +15201,9 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
>  	struct bnxt *bp = netdev_priv(dev);
>  	struct bnxt_rx_ring_info *rxr;
>  
> +	if (!bp->rx_ring || idx >= bp->rx_nr_rings)
> +		return -EINVAL;
> +
>  	rxr = &bp->rx_ring[idx];
>  	napi_disable(&rxr->bnapi->napi);
>  	bnxt_hwrm_rx_ring_free(bp, rxr, false);

