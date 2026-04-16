Return-Path: <netdev+bounces-279004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +It1ED/E4Gm8lgAAu9opvQ
	(envelope-from <netdev+bounces-279004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:13:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B346C40D32C
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01FAB3097181
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 11:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23BC3A6EEE;
	Thu, 16 Apr 2026 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dywgjzal";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/t8Ciqh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009963A640C
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776337660; cv=none; b=kt+1aHcMCXBCurJhHZ0xtabZELOjyaBFmHa0R0i17OUKoXT3TD5WL4oJrCMncHdhRYWSGgo9F1y1zdF9dAaiZ3d+NADxvnQ2MFwFcdiHBenUOcYCkDOfblDuJczcz+0aIlTbPqL+82qZCZhYu42/O5zzUAbrkw1uIZXKuG0E4A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776337660; c=relaxed/simple;
	bh=Mhl7VFLlNqbRmIfras34wIl2ZzIGKqWjhlH0JEJS4Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2KvB3TGIwrumfAv1VmX7usiQ1DJ9YyeYQlhLr7Q/mK2D+/PMmJxCYEah7mVUtZroTlrq4IKGtzZQGXEGASUzGtZOPhwQt+aJ+DXTsOq7mKRXunUUV/gU61+O0xPi+RonbpR/BDIGplS9qQQFDxdrfW2ofyK4ucOSMnhlr27xpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dywgjzal; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g/t8Ciqh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776337657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HUTt3csFTfC3dI0z3fyCkSSTe3g6lb6Iqtxx21jWaHk=;
	b=DywgjzalWyGbqWZr90z68izH2rjPC/uBCtNUO6g6Y6D17ddWn4d9yQfKgNBcisiXKs4f1p
	K6xveZLA3dQ36aBRYgSeSwOMjRURzCaeIZLqyVmRiWlVCxYvF2ywJfnk+PMMnlEtk4NaJi
	5G1MTK6BjVfMJwd5nKu6XWCBMFWzRZI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-s97IvnTxPnKJoMHZIDJS7w-1; Thu, 16 Apr 2026 07:07:35 -0400
X-MC-Unique: s97IvnTxPnKJoMHZIDJS7w-1
X-Mimecast-MFC-AGG-ID: s97IvnTxPnKJoMHZIDJS7w_1776337654
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488d9e1e61aso43259575e9.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 04:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776337654; x=1776942454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HUTt3csFTfC3dI0z3fyCkSSTe3g6lb6Iqtxx21jWaHk=;
        b=g/t8CiqhVNOtPiga02YD39q71p7hCBeZ1LUvPpIPMVOsyr1wdrODAP+3PJ9wo++DN1
         LRYc70yhL1uiMxgFyIOXnxvi9+5r6X9lGdocS0dEiefd9+lJXsXbLhW/GjkfwbUSHYSw
         HgVeKIMLjWzsNDtjw0L+mF+e2kkkUiMWXf+OmARh5E7B4f5nwyYR+tLNycsxuYcJz8VY
         viJLdPpuZh1JkrPDrRXhuKcrkzt8ZHRN+yY9BSkg+Pn7e2pev6+y3R8JvGaakyEznWr1
         htKpOnp8yIBXSqFALRT5dZ+s3OzSO6f+Nrgswrp/Q24ObwTIQPU7S42RzjrhfVE8+uqk
         zC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776337654; x=1776942454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUTt3csFTfC3dI0z3fyCkSSTe3g6lb6Iqtxx21jWaHk=;
        b=YjeEPhh3IdZ3iRUa1P1CRLKLeBWWC7rwf2ntNxMy1wTocg1KQq5pCfl30PohbCfqH/
         GjiU6Fgguwg8sD28iGgpT4S+0UrJlwxqFE8Z7pEoFY5AyYi7BLzraSiYMtRAZZe7/lNG
         3tZ2MxRDAnlJRXGGiYF5oga++H40OxDOTr8Yv2K/SbhnOYUdzYzB5GxmQnO7N90osaUT
         uhF7BTOY/JS0TaxSqxX9uIRCdFiboRDLogccr7izzPNb8tdU2erjXhvk5nTFtSocMXSP
         pxA6FWaecc18DLiKnceVHiwwpFVYcSRAMFyEEZrWyT5xzCgAiXWNEEhhaVK94LarOnds
         P7aQ==
X-Forwarded-Encrypted: i=1; AFNElJ9/VOWCZjkExKtUMzo7sPzn73Hc5E+mikJm45ZPUNovoF7mHllvcNTqtiRJdG7vG1aJmeB3kYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAYgBiaM0X05qFY0r4dHxnZhUz6V4fyJsd+tVYe/guUM+of3ow
	mXA3DxDR4x4l1MbFlXhUyjkeLKyp/rcD0N9qhMJDqGGG+C2vE6o+uNOYYeLGHvXoNpbx2XKfwtb
	ReSjUAe1c4aLePnuu0bBt7M96efj8RznSDEDkfHpSD8QNAGJX2ZAYGVXaKg==
X-Gm-Gg: AeBDiesaaQN1AyQ0JIDCmUEfEOpwH1wWqeeOFqLMV2uAUXEH0uVyGUOk2T7f8XmWMs/
	dZNWS12fvr/KeMXyOsAcV8Uygj1rXYmsiYRugec0FetUFocDFVI3jyGnz+P9XmOIcStbTAzejzn
	h5t386/t/6vdwqgIOsENStO76YA238XcOZStFbDP3R2cB2tr7e15RRP0m7VzAQVRBu8otkkcGRz
	m2/dlbSaj6y7AcILTPW2C86UMncDldSuXfu+lrE1EHiX4lpuFgzYNAUzRZ3Mju1iPEuSorHAwFV
	jD+1pCJdB6T/GzkPYcbZPq2/f5ciy2QZiT7CMGHKVke9LAJiK48/hRbDa3aoEvJ2TjEH8Qu7X5s
	i66kxEXnab+m9Ac01mbZOUYgRPJuxpYuCxKh8Fuk2ynQOwK6VYxkP6BJ37RjtGWEH5mA=
X-Received: by 2002:a05:600d:d:b0:488:c14b:201b with SMTP id 5b1f17b1804b1-488d67e737amr275117875e9.10.1776337654381;
        Thu, 16 Apr 2026 04:07:34 -0700 (PDT)
X-Received: by 2002:a05:600d:d:b0:488:c14b:201b with SMTP id 5b1f17b1804b1-488d67e737amr275117285e9.10.1776337653839;
        Thu, 16 Apr 2026 04:07:33 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0ea65b9sm70716885e9.5.2026.04.16.04.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:07:32 -0700 (PDT)
Message-ID: <b429c6d3-8f6a-41fb-a9e6-9867a8ee1ad8@redhat.com>
Date: Thu, 16 Apr 2026 13:07:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 3/3] net/mlx5e: SD, Fix race condition in secondary
 device probe/remove
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Shay Drory <shayd@nvidia.com>,
 Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
 Parav Pandit <parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20260413105323.186411-1-tariqt@nvidia.com>
 <20260413105323.186411-4-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260413105323.186411-4-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279004-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: B346C40D32C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 12:53 PM, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> When utilizing Socket-Direct single netdev functionality the driver
> resolves the actual auxiliary device using mlx5_sd_get_adev(). However,
> the current implementation returns the primary ETH auxiliary device
> without holding the device lock, leading to a potential race condition
> where the ETH device could be unbound or removed concurrently during
> probe, suspend, resume, or remove operations.[1]
> 
> Fix this by introducing mlx5_sd_put_adev() and updating
> mlx5_sd_get_adev() so that secondaries devices would acquire the device
> lock of the returned auxiliary device. After the lock is acquired, a
> second devcom check is needed[2].
> In addition, update The callers to pair the get operation with the new
> put operation, ensuring the lock is held while the auxiliary device is
> being operated on and released afterwards.
> 
> The "primary" designation is determined once in sd_register(). It's set
> before devcom is marked ready, and it never changes after that.
> In Addition, The primary path never locks a secondary: When the primary
> device invoke mlx5_sd_get_adev(), it sees dev == primary and returns.
> no additional lock is taken.
> Therefore lock ordering is always: secondary_lock -> primary_lock. The
> reverse never happens, so ABBA deadlock is impossible.
> 
> [1]
> for example:
> BUG: kernel NULL pointer dereference, address: 0000000000000370
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP
> CPU: 4 UID: 0 PID: 3945 Comm: bash Not tainted 6.19.0-rc3+ #1 NONE
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> RIP: 0010:mlx5e_dcbnl_dscp_app+0x23/0x100 [mlx5_core]
> Call Trace:
>  <TASK>
>  mlx5e_remove+0x82/0x12a [mlx5_core]
>  device_release_driver_internal+0x194/0x1f0
>  bus_remove_device+0xc6/0x140
>  device_del+0x159/0x3c0
>  ? devl_param_driverinit_value_get+0x29/0x80
>  mlx5_rescan_drivers_locked+0x92/0x160 [mlx5_core]
>  mlx5_unregister_device+0x34/0x50 [mlx5_core]
>  mlx5_uninit_one+0x43/0xb0 [mlx5_core]
>  remove_one+0x4e/0xc0 [mlx5_core]
>  pci_device_remove+0x39/0xa0
>  device_release_driver_internal+0x194/0x1f0
>  unbind_store+0x99/0xa0
>  kernfs_fop_write_iter+0x12e/0x1e0
>  vfs_write+0x215/0x3d0
>  ksys_write+0x5f/0xd0
>  do_syscall_64+0x55/0xe90
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> [2]
>     CPU0 (primary)                     CPU1 (secondary)
> ==========================================================================
> mlx5e_remove() (device_lock held)
>                                      mlx5e_remove() (2nd device_lock held)
>                                       mlx5_sd_get_adev()
>                                        mlx5_devcom_comp_is_ready() => true
>                                        device_lock(primary)
>  mlx5_sd_get_adev() ==> ret adev
>  _mlx5e_remove()
>  mlx5_sd_cleanup()
>  // mlx5e_remove finished
>  // releasing device_lock
>                                        //need another check here...
>                                        mlx5_devcom_comp_is_ready() => false
> 
> Fixes: 381978d28317 ("net/mlx5e: Create single netdev per SD group")
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en_main.c  | 18 ++++++++++++++----
>  .../net/ethernet/mellanox/mlx5/core/lib/sd.c   | 17 +++++++++++++++++
>  .../net/ethernet/mellanox/mlx5/core/lib/sd.h   |  2 ++
>  3 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 0b8b44bbcb9e..11f80158e107 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -6657,8 +6657,11 @@ static int mlx5e_resume(struct auxiliary_device *adev)
>  		return err;
>  
>  	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
> -	if (actual_adev)
> -		return _mlx5e_resume(actual_adev);
> +	if (actual_adev) {
> +		err = _mlx5e_resume(actual_adev);
> +		mlx5_sd_put_adev(actual_adev, adev);
> +		return err;
> +	}
>  	return 0;
>  }
>  
> @@ -6698,6 +6701,8 @@ static int mlx5e_suspend(struct auxiliary_device *adev, pm_message_t state)
>  		err = _mlx5e_suspend(actual_adev, false);
>  
>  	mlx5_sd_cleanup(mdev);
> +	if (actual_adev)
> +		mlx5_sd_put_adev(actual_adev, adev);
>  	return err;
>  }
>  
> @@ -6795,8 +6800,11 @@ static int mlx5e_probe(struct auxiliary_device *adev,
>  		return err;
>  
>  	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
> -	if (actual_adev)
> -		return _mlx5e_probe(actual_adev);
> +	if (actual_adev) {
> +		err = _mlx5e_probe(actual_adev);
> +		mlx5_sd_put_adev(actual_adev, adev);

Sashiko says:

---
If _mlx5e_probe(actual_adev) fails, it frees mlx5e_dev but leaves the
auxiliary device's drvdata pointing to it. Furthermore, mlx5e_probe()
returns the error without calling mlx5_sd_cleanup(mdev), leaving devcom
incorrectly marked as ready.
If the primary device is later unbound, mlx5e_remove() will see that
devcom is ready, call _mlx5e_remove(), and blindly dereference the
dangling mlx5e_dev pointer.
Is there a missing cleanup step here to clear drvdata or reset the sd
state on failure?
---

Please try to address AI comments (i.e. explaining why not relevant)
proactively.

Thanks,

Paolo


