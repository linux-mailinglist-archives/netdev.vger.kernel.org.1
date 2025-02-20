Return-Path: <netdev+bounces-168085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 736ADA3D4FC
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 10:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D323189CF01
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ADF1EFF8D;
	Thu, 20 Feb 2025 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r6pi+fn4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E5E1EFFA7
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044485; cv=none; b=cFp25+Qpm621+BQAMm4l25IJ6I3yyZTPYQTe3SkgZoJNnmByjo81vdYC7udBwcQsnyagHfWSKse8DTdFxahOyB4dCl/r9IkA7oSnqpmDrM1u4AAkATBZzfiebxqmbjU+Y+vPeUbVIxKs5siNgGgHlrOMyAuaATuVDiMj4kT2tfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044485; c=relaxed/simple;
	bh=rPdLAfSQk4cwpPalPpnF+RXKc09D5F1aQGJMUJBjYGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TcmJooz5aFBlwuO+/SusfRCfbo450//3nnj7wSBaLHHa9+fJQREl11z4UibQJxrWiK/iEEwpKLa/mLewRZjIVd2UyKiFesvnrT7HUFGHfcRs6QkbfmxM3inVzztHHU3Vpvoo0X+W1A2zfeyGdbgweE3wovWxsu4eyJkvhqNrRZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r6pi+fn4; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5ded46f323fso930274a12.1
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 01:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740044482; x=1740649282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQaDHAapbeI/D57wO3IdW4MbVxGS+jMPNtMBxPIKge0=;
        b=r6pi+fn4UC8+X5QRgLrKHrmN4M9GxW3FQDioaZTLbNrjYUkuXLuivMYOCOWfrvOC2+
         ERb0VNqsg6sKvBJcB+ojfvB6FpG7/Gh2dKIBqkoTMoxhz6SXLdysZHhgoQKweH4gDObI
         eBGywU0EamfdMfuWo6FUTzSBjm2LtBJs0ad1LiEBcG8ffITmzQ7Rsn2NzuyHmTFoeQx/
         F6PF98sE7uukx9Q8FiWzEzshYhyOmp8hR9OhXTo5kzkrRhmGR2Q4FfffWl++ktGJOpiE
         IoY+I3b+cHDMUFKkeaUHuVVDmcuOv8CIrSrqllbsw0+hEDZTjqkVbMOuLvs3cHF4xrWW
         lrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740044482; x=1740649282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQaDHAapbeI/D57wO3IdW4MbVxGS+jMPNtMBxPIKge0=;
        b=Ng2HJqjZi8Omy3hxoFrio0Up0K165vFqac3iUu4vnJNoHtoqVjk8CliUCMfl1cJAoi
         koHeqTgbyCmRZUbOL2M+w89QjTkQDR6uIbTlP2z+Pt2OhawklxOjy64jkud3NgmDP7Sw
         AuibcEKvVHaCWtJw+4gTckFLqHhEyzJEljICRz9Yx7WXKXh9wpCn02QT/xNJnNLCPHTV
         6LKSG6uWwQdRh2FWbGqlHB7Ifrn1IaaRWFtoZwbowMPj7ancKzw3N1SmvwXUHCyv2/4o
         shXcLxhd0c6UKUgFzc5+mxrv56gywkFXMMw/4xqWmvr8ln2BjHvVeNriHsaPy9+xwJwx
         7lAQ==
X-Gm-Message-State: AOJu0Yw0tsGFM/YyUNZ6eADufz7U/ZGAbEb7gCfx7QDPtNJKyYR7IiVR
	rXr05CGHK+8ijENxdQmWC+wFwdMI2iu4MG9wFcs+TCnQs4AgMF+jnofxAacVHJCZYNP14eAdyKX
	rjjZuNwHTHcwwSjL466AGHfPpvqYPS2krdeyy
X-Gm-Gg: ASbGncudT14TKa44H+CSfwCVGltQJXwsYYGpxbqUf5ZlXFakIxKWGCDa23Pdfjyu/p4
	WhXdP/hAymY4SlkrA7hBFYCyk9FQzjuG2Km79ABSUnhM5U/8M1D46DSRQjy9Eq2rWoNj7c6/LMG
	6KL16Ue0r4WEQs2DBJATB4724dbr9j8g==
X-Google-Smtp-Source: AGHT+IER7fAjwsiX2VEknqUM4hP9v8bDlNZ2gEpU6v5LjnI0XFGZSO8GLYLpXpKPP1Xco78BT3k8T71hn64yjOMglvY=
X-Received: by 2002:a05:6402:2807:b0:5e0:2974:c20c with SMTP id
 4fb4d7f45d1cf-5e089d2ff46mr6961655a12.22.1740044481871; Thu, 20 Feb 2025
 01:41:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739899357.git.pabeni@redhat.com> <7c6b33e4d6e6f2831992bb4631595b1aa1da35c1.1739899357.git.pabeni@redhat.com>
In-Reply-To: <7c6b33e4d6e6f2831992bb4631595b1aa1da35c1.1739899357.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Feb 2025 10:41:10 +0100
X-Gm-Features: AWEUYZllvTB0S77uZdaBsgRcXZA4hCovjJE4BHwQTYp0-ZcRsC-sz9O-z0ykU2w
Message-ID: <CANn89iKQOnxa=OLKhg=RQTf02E0OiQeY_PhaddnC0oEF=hCStQ@mail.gmail.com>
Subject: Re: [PATCH v2 net 1/2] net: allow small head cache usage with large
 MAX_SKB_FRAGS values
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Alexander Duyck <alexanderduyck@fb.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 7:32=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Sabrina reported the following splat:
>
>     WARNING: CPU: 0 PID: 1 at net/core/dev.c:6935 netif_napi_add_weight_l=
ocked+0x8f2/0xba0
>     Modules linked in:
>     CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc1-net-00092=
-g011b03359038 #996
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linu=
x 1.16.3-1-1 04/01/2014
>     RIP: 0010:netif_napi_add_weight_locked+0x8f2/0xba0
>     Code: e8 c3 e6 6a fe 48 83 c4 28 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc =
cc cc cc c7 44 24 10 ff ff ff ff e9 8f fb ff ff e8 9e e6 6a fe <0f> 0b e9 d=
3 fe ff ff e8 92 e6 6a fe 48 8b 04 24 be ff ff ff ff 48
>     RSP: 0000:ffffc9000001fc60 EFLAGS: 00010293
>     RAX: 0000000000000000 RBX: ffff88806ce48128 RCX: 1ffff11001664b9e
>     RDX: ffff888008f00040 RSI: ffffffff8317ca42 RDI: ffff88800b325cb6
>     RBP: ffff88800b325c40 R08: 0000000000000001 R09: ffffed100167502c
>     R10: ffff88800b3a8163 R11: 0000000000000000 R12: ffff88800ac1c168
>     R13: ffff88800ac1c168 R14: ffff88800ac1c168 R15: 0000000000000007
>     FS:  0000000000000000(0000) GS:ffff88806ce00000(0000) knlGS:000000000=
0000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: ffff888008201000 CR3: 0000000004c94001 CR4: 0000000000370ef0
>     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>     Call Trace:
>     <TASK>
>     gro_cells_init+0x1ba/0x270
>     xfrm_input_init+0x4b/0x2a0
>     xfrm_init+0x38/0x50
>     ip_rt_init+0x2d7/0x350
>     ip_init+0xf/0x20
>     inet_init+0x406/0x590
>     do_one_initcall+0x9d/0x2e0
>     do_initcalls+0x23b/0x280
>     kernel_init_freeable+0x445/0x490
>     kernel_init+0x20/0x1d0
>     ret_from_fork+0x46/0x80
>     ret_from_fork_asm+0x1a/0x30
>     </TASK>
>     irq event stamp: 584330
>     hardirqs last  enabled at (584338): [<ffffffff8168bf87>] __up_console=
_sem+0x77/0xb0
>     hardirqs last disabled at (584345): [<ffffffff8168bf6c>] __up_console=
_sem+0x5c/0xb0
>     softirqs last  enabled at (583242): [<ffffffff833ee96d>] netlink_inse=
rt+0x14d/0x470
>     softirqs last disabled at (583754): [<ffffffff8317c8cd>] netif_napi_a=
dd_weight_locked+0x77d/0xba0
>
> on kernel built with MAX_SKB_FRAGS=3D45, where SKB_WITH_OVERHEAD(1024)
> is smaller than GRO_MAX_HEAD.
>
> Such built additionally contains the revert of the single page frag cache
> so that napi_get_frags() ends up using the page frag allocator, triggerin=
g
> the splat.
>
> Note that the underlying issue is independent from the mentioned
> revert; address it ensuring that the small head cache will fit either TCP
> and GRO allocation and updating napi_alloc_skb() and __netdev_alloc_skb()
> to select kmalloc() usage for any allocation fitting such cache.
>
> Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRA=
GS")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

