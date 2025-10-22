Return-Path: <netdev+bounces-231486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD91BF9977
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 03:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 947A2354F01
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49854200C2;
	Wed, 22 Oct 2025 01:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hW6ST/Xr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8657E8F54
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 01:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761095804; cv=none; b=g5GizDf0w1w9tNt2UEBTZOR+6jjeJWm91qoSbtSxJ7Hv56J+58xxDkNEx9BVLyVqAoqTFZUx/BFxfWHdjVjZlTCt99UeWfbEQMNbS8q2+IGSEtvB2ZPDSU8qEV/qjAXHDk/qJr9gams9C6hpqDHXOxX+cCBlR/3Du2Pi9U7Tvf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761095804; c=relaxed/simple;
	bh=JA+/CWiL6xqcP/tbxexwP819PiM1q6Cx21VPpi+okfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYzpwv9mB/5Du+3k2HWciaOBT+ZJaR5RLbGV5FJNRxGoSzcrPpa0vjSCTC3PG6l6wBfe64oVvxqb4Pny+hYqn23thkUzgHey3LAFHwYz+yojBjnSd+fpWxOznIUJ9zz/YCGF3NHAID67rjvqvVy/vjLTf1IwI39jlvHzcoVI37A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hW6ST/Xr; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-430ab5ee3afso56479145ab.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 18:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761095802; x=1761700602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQUXbn7qflXkojUJOY/zHJFQ71N61cCsdsa1hM34EYo=;
        b=hW6ST/XrQTyZEJe6wluz7bC7ClIf7MPJN1jJfpztoTAe4uqPeSmV/MySKBWxwBumoj
         Z4cweIqOT4GmXE3wc2w0tulxR6AFSLJ3PxWJYGlS/q8eeITVMKzKNgo7onhD6QwqtlJV
         pT8L3EgSelBc1xkEJrmcGuL4dVV6LcLhBkNbvQ9YhCp2tWfrB3YtSa3ATmGbjO/gzo1J
         VhXHF4NRN89j9daOXJbh7RxyvMCYJkuWOLsL4lv9etQu2Xz3Bbi6PR5jzTzk/+DGiQYh
         EUdPg3P7Lw3lTeUbDb3spnO68AmjFknyH/yqmZOmDeu1Ktm0O5ySTUUD5/91m2FNC4aJ
         huKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761095802; x=1761700602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQUXbn7qflXkojUJOY/zHJFQ71N61cCsdsa1hM34EYo=;
        b=vu5aAO126KSgi2iIN7W1QBUT4KA/G3sw/qGFG1jDEKulkSiw/WRRssnFe4I+pMg3xE
         vYI/eSwKFmIe6TMK0n8wfj5H0E7OW4fIoMLZiPmTD5Nmbpw/XnRJFlxne9te6gmcLE3S
         kas862qvaVSFqPXf9wf2F16/vHgJoVKJLRmZxZ3U3qafyoV67tQkRyKWQ+c75zdmtbaL
         Tn2jzok3GvJwpe7DBbmiJCBQxISYJ4Wxacq4mp+B/Ahc1XDEOT2TxyPpEDxCP5CX3fFH
         jb5Kd6GuUAN4AHyUMQcqm10zHGECgs3vQi3CTgFme8Vj+G95ls/MhoGJpKOvEZn+koAQ
         wPFA==
X-Gm-Message-State: AOJu0YzHqHVzbWbVIqeZ9tzdHMg9hZKKKAWWDYS/8kVL+8Ip1LPprtx0
	l/1x+ZghavZBHX4LBITSClf+LpmL65Wh1glzCE21kG7Z730T4v8M/vK8fgypwhbgox7Im860z4N
	cRpXhJjl2cQoJoEKa0pEdQu1LIAAfpv0=
X-Gm-Gg: ASbGnct3LvM9xXhqIHRX8eh8IzdN3ChQSsm5k+Al50zQCaLG53+rv5sJsPRuO9tkgyx
	DZYuvwghYR9StzrItbyIxYk4YsH3n8QcspW+rXFSAUcgtwdgMnLhMzD/6bUlJKs27+ErZO5t9eU
	ZwmXRqIOsZbWFDAbKq4L8SqktdW4Uv9qTKKWtbC2nM+PV8WDOPVCYMhoiOG0t9yH9sTu4tbTYHu
	Mly/EOXhMIODrCwbCCMbbtallEuJ4gRI/jrZBh4CaYlGre7iNvvY5v56dPa6mQSRqiycA==
X-Google-Smtp-Source: AGHT+IEbHXlQAp2njb9qcK0BpZjGlGTWVhP1jv3VshBaO2Dh4nKVHOrUBeUQcX+KC5fQBCuatdnHCG/FK9il5ggxW3w=
X-Received: by 2002:a05:6e02:1b02:b0:430:bf89:f7f7 with SMTP id
 e9e14a558f8ab-430c524fb13mr312346925ab.13.1761095801544; Tue, 21 Oct 2025
 18:16:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021135913.5253-1-alessandro.d@gmail.com>
In-Reply-To: <20251021135913.5253-1-alessandro.d@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 22 Oct 2025 09:16:05 +0800
X-Gm-Features: AS18NWAb_Ob-PdVzZ3_IPp0jpPi_R1zhS75gexdupc3ArYqfQ5__T3GrPKbYiuY
Message-ID: <CAL+tcoDqq6iCbFEgezXf69a0inV+cR3S5AVEPi0o18O-eJNHXA@mail.gmail.com>
Subject: Re: [PATCH net] i40e: xsk: advance next_to_clean on status descriptors
To: Alessandro Decina <alessandro.d@gmail.com>
Cc: netdev@vger.kernel.org, Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alessandro,

On Tue, Oct 21, 2025 at 9:59=E2=80=AFPM Alessandro Decina
<alessandro.d@gmail.com> wrote:
>
> Whenever a status descriptor is received, i40e processes and skips over
> it, correctly updating next_to_process but forgetting to update
> next_to_clean. In the next iteration this accidentally causes the
> creation of an invalid multi-buffer xdp_buff where the first fragment
> is the status descriptor.
>
> If then a skb is constructed from such an invalid buffer - because the
> eBPF program returns XDP_PASS - a panic occurs:
>
> [ 5866.367317] BUG: unable to handle page fault for address: ffd31c37eab1=
c980
> [ 5866.375050] #PF: supervisor read access in kernel mode
> [ 5866.380825] #PF: error_code(0x0000) - not-present page
> [ 5866.386602] PGD 0
> [ 5866.388867] Oops: Oops: 0000 [#1] SMP NOPTI
> [ 5866.393575] CPU: 34 UID: 0 PID: 0 Comm: swapper/34 Not tainted 6.17.0-=
custom #1 PREEMPT(voluntary)
> [ 5866.403740] Hardware name: Supermicro AS -2115GT-HNTR/H13SST-G, BIOS 3=
.2 03/20/2025
> [ 5866.412339] RIP: 0010:memcpy+0x8/0x10
> [ 5866.416454] Code: cc cc 90 cc cc cc cc cc cc cc cc cc cc cc cc cc cc c=
c 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 48 89 f8 48 89 d1 <=
f3> a4 e9 fc 26 c0 fe 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> [ 5866.437538] RSP: 0018:ff428d9ec0bb0ca8 EFLAGS: 00010286
> [ 5866.443415] RAX: ff2dd26dbd8f0000 RBX: ff2dd265ad161400 RCX: 000000000=
00004e1
> [ 5866.451435] RDX: 00000000000004e1 RSI: ffd31c37eab1c980 RDI: ff2dd26db=
d8f0000
> [ 5866.459454] RBP: ff428d9ec0bb0d40 R08: 0000000000000000 R09: 000000000=
0000000
> [ 5866.467470] R10: 0000000000000000 R11: 0000000000000000 R12: ff428d9ee=
c726ef8
> [ 5866.475490] R13: ff2dd26dbd8f0000 R14: ff2dd265ca2f9fc0 R15: ff2dd2654=
8548b80
> [ 5866.483509] FS:  0000000000000000(0000) GS:ff2dd2c363592000(0000) knlG=
S:0000000000000000
> [ 5866.492600] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 5866.499060] CR2: ffd31c37eab1c980 CR3: 0000000178d7b040 CR4: 000000000=
0f71ef0
> [ 5866.507079] PKRU: 55555554
> [ 5866.510125] Call Trace:
> [ 5866.512867]  <IRQ>
> [ 5866.515132]  ? i40e_clean_rx_irq_zc+0xc50/0xe60 [i40e]
> [ 5866.520921]  i40e_napi_poll+0x2d8/0x1890 [i40e]
> [ 5866.526022]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 5866.531408]  ? raise_softirq+0x24/0x70
> [ 5866.535623]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 5866.541011]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 5866.546397]  ? rcu_sched_clock_irq+0x225/0x1800
> [ 5866.551493]  __napi_poll+0x30/0x230
> [ 5866.555423]  net_rx_action+0x20b/0x3f0
> [ 5866.559643]  handle_softirqs+0xe4/0x340
> [ 5866.563962]  __irq_exit_rcu+0x10e/0x130
> [ 5866.568283]  irq_exit_rcu+0xe/0x20
> [ 5866.572110]  common_interrupt+0xb6/0xe0
> [ 5866.576425]  </IRQ>
> [ 5866.578791]  <TASK>
>
> Advance next_to_clean to ensure invalid xdp_buff(s) aren't created.
>
> Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
> Signed-off-by: Alessandro Decina <alessandro.d@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/eth=
ernet/intel/i40e/i40e_xsk.c
> index 9f47388eaba5..02f0bc2dbbf6 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -441,13 +441,17 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring,=
 int budget)
>                 dma_rmb();
>
>                 if (i40e_rx_is_programming_status(qword)) {
> +                       u16 ntp =3D next_to_process++;
> +
>                         i40e_clean_programming_status(rx_ring,
>                                                       rx_desc->raw.qword[=
0],
>                                                       qword);
>                         bi =3D *i40e_rx_bi(rx_ring, next_to_process);
>                         xsk_buff_free(bi);
> -                       if (++next_to_process =3D=3D count)
> +                       if (next_to_process =3D=3D count)
>                                 next_to_process =3D 0;
> +                       if (next_to_clean =3D=3D ntp)
> +                               next_to_clean =3D next_to_process;
>                         continue;
>                 }

Upon a quick review, if the packet is not a normal packet,
next_to_clean should be advanced by one anyway, right? If so, we can
only use something like "next_to_clean++". According to what you gave
us as above, only if that condition is satisfied, the next_to_clean
will be synced to next_to_process. In other cases, the next_to_clean
will not be updated. But the packet read by using next_to_clean is one
status descriptor, should we skip it one way or another?

One more question from my side is that since the first packet should
not be a status packet, after your patch gets applied, in the while
loop, 'first' still points to the original position that is
next_to_clean from the rx ring. After calling 'continue', another loop
starts, 'first' is not updated and then will be passed to the receive
function, which might cause the unexpected behavior as you said? So
can this patch prevent such an issue from happening in this case?

I'm not sure if I'm missing something.

Thanks,
Jason

