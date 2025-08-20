Return-Path: <netdev+bounces-215381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C96B2E4C1
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 20:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB5DA01B70
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693D7257851;
	Wed, 20 Aug 2025 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Asf2mDMM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8792475E3
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713796; cv=none; b=TtKmg4jLk0o89usefiozxAp/myCyPM4N7rhicviDO2QxXQqjMkp5TW8gZPIS8hi9D+lmtSr4h+kMZsMNmOcDhnHQb3+youe6RGPXIqLDdA5yR0cDfJMJ2HfP7ZbpYUrY8o4QlOhLKoFqjshGAZHUeuRtSw8Pt+3SbCHIofkNxoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713796; c=relaxed/simple;
	bh=CbcXRxEjqlY+FIZilCkgQEsHL1NlhDQHnuKavFYRcZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQKy5eMOLoADXoGStY4fZo8agHf5o1OIqU67CLM8R6NFqJA/iIPyt0Gmb00SxQgGBv+O6Ue7N83t9VZnEswO7uVtVKXifUPH/7CtoADnRUHMwOOh/fxXzZdRQlVWJM//02kTpdWucd9GgzxwvhA5jJGR28Txgytxf4vxrW5yVUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Asf2mDMM; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e8702fd3b2so10275385a.0
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 11:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755713793; x=1756318593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzjBhj3K6a6cnfNlIDVsAZiz2XcZgs11336NDc4gm7Y=;
        b=Asf2mDMMcafH4nKU1mSAt9dFA4CWZm8SR0IHc2nFQQiDqAFKEsKPZ2i1ckfVrOxIBf
         WIHRNiEmXIucPtTN5ziwjF6E54cR2unzStJLLbZV1OyJJ64N2/KOW36EYf+fV//lGy2e
         lPoFMf92gk3SIrFd+Hjph/wdC3s8mB+I277LJPtcjpnzIn3LUjZwP7tJNb9r3y8XVstq
         TGqu3g/RDOPxtMH7K49KcuO3qMNGod8bfQnKM9yQqcd1rtwxlhx879trHzJFwAzU885L
         fpvmitKTcsXVemzcvut7kYuf2srO1h9dI9/qFHs0OT03pQUNhnTOPbk2gz0zYFRBc82E
         PB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755713793; x=1756318593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzjBhj3K6a6cnfNlIDVsAZiz2XcZgs11336NDc4gm7Y=;
        b=EIxgEf40Z3Wz3casw78s0mxvalFXeHxGHn8pwl1h+VvMabr98qZ7msSZQFK0UR3XG/
         CeAjAblPFQ11kaRnnLBjmgvMSceF1+qWvgwQ+UGTpp/+4jCZpw3fQzgigYzvlXtVgajI
         TpMMoi81GIu5Z0KqTc66W5xJBVidvyNnSO2hJh05Wgep2917sufevA0ibes8y15+0mp5
         x2NmYL6po7xQvCDmjXMWfmeEcJzd9Ohp03bj9npNZ29sI2ttZjpbkLfkUk0vSLTswWs/
         t5UKwoZMhtnpQcw2ykFDqVNUzbIttqwjiNWsUDdMiFVRv4bVa2daIRFuwqjZn200fJ7A
         N8eA==
X-Forwarded-Encrypted: i=1; AJvYcCXv9GvtuGv/2h3zW9Moq2j4QvlAGigdSoeIwySSmK/C9znZ1f7X65lFR3ezHg6GMoEAUp+Mrzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaG/Zcx/8Jnh5nSMKNubV/Dzva0L6d9lrJfmDBU3tXYnCATWW3
	iZnp38qVNjH7PLTpbGbE3GFsb6aUg4ZcLQS605jDY1Pc2qgyRqqKNRH/6PI59GfW9t0XgUaF+fY
	7g3uF23aJ5qjR/uGHE5RKIn1MBVElXH9fFi5PdW0wgvv30OnZ50v1X4DVPtM=
X-Gm-Gg: ASbGncuodqV0pyc85/ttm4ZZBln+IM4i2lEzAP44BOS8FedQdzMKOW7IRLSTbnjwTwR
	6eJUHTjeZ5punC1uqfxwlZRPZrWChn3MleF7mKDW1ndWGTlouyLpKtxm+jV0s8ZprguTL2nYDaz
	wKmf+afsI4p8QIxKdCRGW6s53NVKkRGDWZWkIjQSvJFiBJQuZjbziaiW6BswDhGI8NSaZ/H/ADF
	rqEJT7BFaAIw9EHe5AH9j5tkkdbNp0p1v77
X-Google-Smtp-Source: AGHT+IGVzgSbWk+BJqCL9u53n+H+daMu/OLvXaZ1ieD3LIK62515U+KXfB96Vi9fq/Z0Zof8fIVvjCx2Tb0+S2B1kfk=
X-Received: by 2002:a05:620a:318f:b0:7e8:2cb:b9a3 with SMTP id
 af79cd13be357-7e9fcb597f0mr372651285a.66.1755713793140; Wed, 20 Aug 2025
 11:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820180325.580882-1-syoshida@redhat.com>
In-Reply-To: <20250820180325.580882-1-syoshida@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 Aug 2025 11:16:21 -0700
X-Gm-Features: Ac12FXz1kZbK0EN8u1kjmIuwmJRixs0T0M4rVtV_MhHPG88matHAstO3pjOQ8kM
Message-ID: <CANn89iJQsEXYR9wWoztv1SnoQcaRxKyyx7X7j_VDfvdJi4cfhw@mail.gmail.com>
Subject: Re: [PATCH net] hsr: add length check before setting network header
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	george.mccollister@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 11:04=E2=80=AFAM Shigeru Yoshida <syoshida@redhat.c=
om> wrote:
>
> syzbot reported an uninitialized value issue in hsr_get_node() [1].
> If the packet length is insufficient, it can lead to the issue when
> accessing HSR header.
>
> Add validation to ensure sufficient packet length before setting
> network header in HSR frame handling to prevent the issue.
>
> [1]
> BUG: KMSAN: uninit-value in hsr_get_node+0xab0/0xad0 net/hsr/hsr_framereg=
.c:250
>  hsr_get_node+0xab0/0xad0 net/hsr/hsr_framereg.c:250
>  fill_frame_info net/hsr/hsr_forward.c:577 [inline]
>  hsr_forward_skb+0x330/0x30e0 net/hsr/hsr_forward.c:615
>  hsr_handle_frame+0xa20/0xb50 net/hsr/hsr_slave.c:69
>  __netif_receive_skb_core+0x1cff/0x6190 net/core/dev.c:5432
>  __netif_receive_skb_one_core net/core/dev.c:5536 [inline]
>  __netif_receive_skb+0xca/0xa00 net/core/dev.c:5652
>  netif_receive_skb_internal net/core/dev.c:5738 [inline]
>  netif_receive_skb+0x58/0x660 net/core/dev.c:5798
>  tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1549
>  tun_get_user+0x5566/0x69e0 drivers/net/tun.c:2002
>  tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
>  call_write_iter include/linux/fs.h:2110 [inline]
>  new_sync_write fs/read_write.c:497 [inline]
>  vfs_write+0xb63/0x1520 fs/read_write.c:590
>  ksys_write+0x20f/0x4c0 fs/read_write.c:643
>  __do_sys_write fs/read_write.c:655 [inline]
>  __se_sys_write fs/read_write.c:652 [inline]
>  __x64_sys_write+0x93/0xe0 fs/read_write.c:652
>  x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:=
2
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was created at:
>  __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
>  alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
>  alloc_pages+0x1bf/0x1e0 mm/mempolicy.c:2335
>  skb_page_frag_refill+0x2bf/0x7c0 net/core/sock.c:2921
>  tun_build_skb drivers/net/tun.c:1679 [inline]
>  tun_get_user+0x1258/0x69e0 drivers/net/tun.c:1819
>  tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
>  call_write_iter include/linux/fs.h:2110 [inline]
>  new_sync_write fs/read_write.c:497 [inline]
>  vfs_write+0xb63/0x1520 fs/read_write.c:590
>  ksys_write+0x20f/0x4c0 fs/read_write.c:643
>  __do_sys_write fs/read_write.c:655 [inline]
>  __se_sys_write fs/read_write.c:652 [inline]
>  __x64_sys_write+0x93/0xe0 fs/read_write.c:652
>  x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:=
2
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> CPU: 1 PID: 5050 Comm: syz-executor387 Not tainted 6.9.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
>
> Fixes: 48b491a5cc74 ("net: hsr: fix mac_len checks")
> Reported-by: syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Da81f2759d022496b40ab
> Tested-by: syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  net/hsr/hsr_slave.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index b87b6a6fe070..979fe4084f86 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c
> @@ -63,8 +63,12 @@ static rx_handler_result_t hsr_handle_frame(struct sk_=
buff **pskb)
>         skb_push(skb, ETH_HLEN);
>         skb_reset_mac_header(skb);
>         if ((!hsr->prot_version && protocol =3D=3D htons(ETH_P_PRP)) ||
> -           protocol =3D=3D htons(ETH_P_HSR))
> +           protocol =3D=3D htons(ETH_P_HSR)) {
> +               if (skb->len < ETH_HLEN + HSR_HLEN)
> +                       goto finish_pass;
> +
>                 skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
> +       }
>         skb_reset_mac_len(skb);
>
>         /* Only the frames received over the interlink port will assign a
> --
> 2.50.1
>

You probably have missed a more correct fix :

https://www.spinics.net/lists/netdev/msg1116106.html

