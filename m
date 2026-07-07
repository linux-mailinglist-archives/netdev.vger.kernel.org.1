Return-Path: <netdev+bounces-305566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /l6DHq9FTWpXxgEAu9opvQ
	(envelope-from <netdev+bounces-305566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 20:30:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D00C671EA3D
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 20:30:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dIYUo1Fj;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305566-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305566-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01E7B300E609
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 18:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BA043E9FB;
	Tue,  7 Jul 2026 18:30:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB473FC5CF
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 18:30:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449004; cv=none; b=VlR++8rq0i0iSxsMN1f8fW1Njm6yKRciKqtYknJAEC+OkgdEsuoWXts7VqGdYXwG52xaIo6uQ20AwpyCDRmFLD69zHpMXIDsChzzrF5ctkjFzvOcadYAJY1Vg47kaI+Ah79gYeACiTp7WES8Wu6cJx9cBOxKE+lT3gYrJU0qdaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449004; c=relaxed/simple;
	bh=BC4hsNu1Ymw7Ru2UgY5LJ4zKQ7w97jP2orYIw5ekKU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KmhJyso/01AmxYZVoyt3xo44kraHq14zhiThd6wRAMma/FMy/Lwn7lu4T+Y0NsE+xAW/2srLfZP1UpGQUAYfAO08vhiuVxarssW32rpIxT4Z8B7AAgc8STlWYXdZComrH5PMKjnliAbI2GFD1R89hjH2lJUsV2/ps90wJ4mWBc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIYUo1Fj; arc=none smtp.client-ip=209.85.219.48
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ee88fce476so42690016d6.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 11:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783449001; x=1784053801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CyPIHfNf3UfKvOML8iyzORC7dRkgEzIxIf93zJCMmMk=;
        b=dIYUo1FjPh6U0U4vtqQ2emtre9QaFLdfVI8ni25pnfWxLGiBtJrTgBSo642/iL10fb
         U6lw2EyKq7e6rKhKGs0G+mjtzUAcLI8FTi6O8STJjzxROh+LxkLCVJr0Vm1jEvK3nB8/
         wdVyNS+ggniWX9wfTWMte2bg59UaAemeXXU/yYYKaBYUTuO80Rd8QVRtZphumMohrJdt
         sggksQkW6Ayl8cLfkKTbVmfhfNlOpeYpTcHC9ukUsy+0j5KwBqdzw+qM9vsJQ5N7Mu5U
         JYD6WkRo+LvThDfBnDfr/K1RwbXNm+idgzH9CyX7X9S9cJu0v58feCw1OMJNW0HkgIif
         HrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783449001; x=1784053801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CyPIHfNf3UfKvOML8iyzORC7dRkgEzIxIf93zJCMmMk=;
        b=MYQeVMeNSmQvpjp1a9HObfWs3d1+kCTrcSQGRAUJyLKiDTEO0QkXn2/7v3wu05SghO
         5dAIu9TYThhTfiy+W1rCHc04KdLBn+/WYaigt2BIOSle2/3erwIYUWcrsR5cL9xNev/c
         trKgm8WI1VNUz6QQk2weJr8PFDSFFdsAI6zQlCjzXd+L/z++NhFnidL8hCreQeO7sBOf
         7n0t/gQ1Sh3W7htspNpAQn8ONpi6FIIvtL7Ap6ep+5mk5XuDn8Z/wtOFfFFuBM2MtKGX
         +NlafszzvTrADIKuPAnDGjV9aOXZ3GpZFW7VbOKv4KysnFSDEpOyDO0SemfrA2M5OQWh
         gPDA==
X-Forwarded-Encrypted: i=1; AHgh+Rrk/T/4UNhKtgpmjy0CWj/pNwcJYNeHaiA1N2Kbii2TVtNVhOcjKE3SsfHEqjaWM6pCMpq97cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG55AGiSEpG5CV4h6SzpGzKRmdBuwiNizDfLAHXPCN97J18T1U
	UPaLVM3BZrBHhe8PiRJ2tDxK2Ii/RI8hfN1Sv372nPp0tXZYtud3WgZD
X-Gm-Gg: AfdE7cm45AUQl2zgDqpp9BWSzKJ10qRsqN+CnWMhZyq/pjVXe0ahcKHR8sd7ZtijNQ6
	o/aMStVgc8KD6i5rITN5l0aFU8/NtCP7W6oObCO0TQyls3DmVssBKkyJcH1DwLpStV/vuYGlsCX
	DD5hv2EFE4NAfFyBOh56Izuw08DsLF7oAOifMMbwqKlEkcKqMtnfJaycpwa7gWT2UyD8m+RYdqV
	CEjwsVYNPvttyTGTHrGuhBwCXlJQze3TyFGZ8MNEX34EV4/Q9WVx2J7fOJc1GSilK26qr9hVpA5
	Y/aBlEgm1oOXmory3bj7qhhZiBK4MgHCsFfwfBj6vyhW7RHxxQ3NiPcRXO7ZRB6KOOHDBZrRvQW
	YCBNLBGWmT1GgBuRcjRvl5HvR1b9vW3WfpUhkFJKy0n8OejLwSBLPU7iygcO5sZOrGlpOy42VH8
	eTAePuzU4JhNBVHzlGGhFnu8qI4mbyg7eJMZTwwK5ITwo=
X-Received: by 2002:a05:6214:e4b:b0:8f2:f32c:6bbb with SMTP id 6a1803df08f44-8fcb628f719mr77752796d6.51.1783449001234;
        Tue, 07 Jul 2026 11:30:01 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:d844:20d:e589:1800? ([2620:10d:c091:500::3:f3b7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46aecc908sm168889176d6.0.2026.07.07.11.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 11:30:00 -0700 (PDT)
Message-ID: <0dfe5f6b-dbc8-4104-8883-e88e8e59ab58@gmail.com>
Date: Tue, 7 Jul 2026 14:29:59 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] net/mlx5e: PSP cleanups and improvements
To: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Boris Pismenny <borisp@nvidia.com>, Chris Mi <cmi@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Jianbo Liu <jianbol@nvidia.com>, Lama Kayal <lkayal@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
 Raed Salem <raeds@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Stanislav Fomichev <sdf.kernel@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20260707130858.969928-1-tariqt@nvidia.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260707130858.969928-1-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305566-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:aleksandr.loktionov@intel.com,m:borisp@nvidia.com,m:cmi@nvidia.com,m:cratiu@nvidia.com,m:dtatulea@nvidia.com,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:jianbol@nvidia.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:raeds@nvidia.com,m:rrameshbabu@nvidia.com,m:saeedm@nvidia.com,m:sdf@fomichev.me,m:sdf.kernel@gmail.com,m:willemdebruijn.kernel@gmail.com,m:andrew@lunn.ch,m:sdfkernel@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[intel.com,nvidia.com,kernel.org,vger.kernel.org,fomichev.me,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D00C671EA3D


On 7/7/26 9:08 AM, Tariq Toukan wrote:
> Hi,
>
> This series by Cosmin refactors mlx5 PSP support in preparation for
> HW-GRO support.
> There are almost no functionality changes in all but the last two
> patches, which address a long-standing TODO in mlx5e_psp_set_config().
>
> Regards,
> Tariq
>
> Cosmin Ratiu (15):
>    net/mlx5e: psp: Rename the saved psp_dev to 'psd'
>    net/mlx5e: psp: Remove PSP steering mutexes
>    net/mlx5e: psp: Remove unneeded ref counting for PSP steering
>    net/mlx5e: psp: Merge rx_err rule add/delete with ft create/delete
>    net/mlx5e: psp: Use helpers for steering object manipulation
>    net/mlx5e: psp: Factor out drop rule creation code
>    net/mlx5e: psp: Remove unused PSP syndrome copy action
>    net/mlx5e: psp: Rename and consolidate steering functions
>    net/mlx5e: psp: Adjust rx_check FT size and use a drop_group
>    net/mlx5e: psp: Add an RX steering table
>    net/mlx5e: psp: Use a single rx_check table
>    net/mlx5e: psp: Flatten steering structures
>    net/mlx5e: psp: Make PSP steering config dynamic
>    net/mlx5e: Return errors from profile->enable
>    net/mlx5e: psp: Report PSP dev registration errors
>
>   drivers/net/ethernet/mellanox/mlx5/core/en.h  |    2 +-
>   .../net/ethernet/mellanox/mlx5/core/en/fs.h   |    7 +-
>   .../mellanox/mlx5/core/en_accel/en_accel.h    |   19 +-
>   .../mellanox/mlx5/core/en_accel/psp.c         | 1007 ++++++++---------
>   .../mellanox/mlx5/core/en_accel/psp.h         |   18 +-
>   .../mellanox/mlx5/core/en_accel/psp_rxtx.c    |   13 +-
>   .../mellanox/mlx5/core/en_accel/psp_rxtx.h    |    3 +-
>   .../net/ethernet/mellanox/mlx5/core/en_main.c |   23 +-
>   .../net/ethernet/mellanox/mlx5/core/en_rep.c  |    8 +-
>   9 files changed, 516 insertions(+), 584 deletions(-)
>
>
> base-commit: 31816fc5d9acf8cdf226cdd0dc296e8cf15cc033

Thanks. Excited about the support for mlx5e_psp_set_config(). Jakub and 
I had a test case for psp_dev_ops::set_config() that we were waiting to 
upstream. I just rebased it onto net-next here: 
https://github.com/danieldzahka/linux/commit/b58e9a99573cf6b884e5fe3227c9af7a1f0d80b0

I ran it with the series but am seeing an error trying to catch 
undecrypted PSP-UDP packets after disabling all versions with set_config()

TAP version 13
1..30
ok 1 psp.data_basic_send.v0_ip4 # SKIP Test requires IPv4 connectivity
ok 2 psp.data_basic_send.v0_ip6
ok 3 psp.data_basic_send.v1_ip4 # SKIP Test requires IPv4 connectivity
ok 4 psp.data_basic_send.v1_ip6
ok 5 psp.data_basic_send.v2_ip4 # SKIP Test requires IPv4 connectivity
ok 6 psp.data_basic_send.v2_ip6 # SKIP ('PSP version not supported', 
'hdr0-aes-gmac-128')
ok 7 psp.data_basic_send.v3_ip4 # SKIP Test requires IPv4 connectivity
ok 8 psp.data_basic_send.v3_ip6 # SKIP ('PSP version not supported', 
'hdr0-aes-gmac-256')
ok 9 psp.data_mss_adjust.ip4 # SKIP Test requires IPv4 connectivity
ok 10 psp.data_mss_adjust.ip6
ok 11 psp.data_send_off.ip4 # SKIP Test requires IPv4 connectivity
# Exception| Traceback (most recent call last):
# Exception|   File "/root/ksft-psp-set-config/net/lib/py/ksft.py", line 
420, in ksft_run
# Exception|     func(*args)
# Exception|   File "/root/./ksft-psp-set-config/drivers/net/psp.py", 
line 608, in data_send_off
# Exception|     udps.recv(8192, socket.MSG_DONTWAIT)
# Exception| BlockingIOError: [Errno 11] Resource temporarily unavailable
# Exception|
not ok 12 psp.data_send_off.ip6
ok 13 psp.dev_list_devices
ok 14 psp.dev_get_device
ok 15 psp.dev_get_device_bad
ok 16 psp.dev_rotate
ok 17 psp.dev_rotate_spi
ok 18 psp.assoc_basic
ok 19 psp.assoc_bad_dev
ok 20 psp.assoc_sk_only_conn
ok 21 psp.assoc_sk_only_mismatch
ok 22 psp.assoc_sk_only_mismatch_tx
ok 23 psp.assoc_sk_only_unconn
ok 24 psp.assoc_version_mismatch
ok 25 psp.assoc_twice
ok 26 psp.data_send_bad_key
ok 27 psp.data_send_disconnect
ok 28 psp.data_stale_key
ok 29 psp.removal_device_rx # XFAIL Test only works on netdevsim
ok 30 psp.removal_device_bi # XFAIL Test only works on netdevsim
# Totals: pass:19 fail:1 xfail:2 xpass:0 skip:8 error:0
#
# Responder logs (0):
# STDERR:
# #  Set PSP enable on device 1 to 0x3
# #  Set PSP enable on device 1 to 0x0

I recall this working on an earlier prototype of this feature for mlx5. 
Are the steering rules setup to drop PSP-UDP packets when the 
corresponding psp version is disabled?


