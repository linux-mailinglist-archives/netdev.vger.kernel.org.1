Return-Path: <netdev+bounces-215426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FC8B2EA11
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6117C179A00
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 01:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3070A1F8676;
	Thu, 21 Aug 2025 01:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMlzIajB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB74E1F560B
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 01:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738543; cv=none; b=S0PlcT232EcG7ueG9bmHdX9dXzRTFR6FwLNu11IVHkxUoTkrgOkllQWm0LAYR6b8fDKr53NeRUDiEnd9ZG1hNIEYxCOL/Gt2MBeQZHEZaH4HLcIgmihjcf5mD4pFwVRS51JuKr3ysZ3O27EBct0yTSEs9akYX3TqOAM8jU9BA5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738543; c=relaxed/simple;
	bh=g/Sl5hh9R1wJFwmzydAjOUTWM9YiDCvHdbtpz2wRKSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMur/fjMC5rZxatgBdZKQInviDaiZJis3pArBanFwIxYcUqA59pXNJYAQ7IhYsQJHKnz0FGHEL+k0/fsS5jAfCLMWho94haDgnNuf8lR4gdv2kSxveYj+DYioRxS/ZA0GTO2IEgLFUBIwwFsq6pkD2WZr4/kJcJW7GMGep3nx5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMlzIajB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755738539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZyMmMLYofSk//dHUJxKe7tFI8PtM0sUCWFTpjRBFFY=;
	b=fMlzIajBs6LFjnwKcohpHLZCNvQk14wuISsuv826uc3pQXWo2TzjQuUgSbb0aDvC4+hQIt
	EnzK+ecERty4R6H2B7IVz7lDEqoJUMOjifRjDqmvrL8E9U9P9t7G4vvOQ7Xlofb0XL4kmI
	Yf2qqABBw427juBhyuuUQiOhid8n08w=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-ltU-tUmhPeyC3aHvHBUhtQ-1; Wed, 20 Aug 2025 21:08:56 -0400
X-MC-Unique: ltU-tUmhPeyC3aHvHBUhtQ-1
X-Mimecast-MFC-AGG-ID: ltU-tUmhPeyC3aHvHBUhtQ_1755738535
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32326e21dd6so1004266a91.2
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 18:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755738535; x=1756343335;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZyMmMLYofSk//dHUJxKe7tFI8PtM0sUCWFTpjRBFFY=;
        b=JiBlhUWVQd4M/E+Qw4KZWx0R6B6/3Q1Mx+Gzb3p7CdCUg12a+RchEnEuBR35CMD0wV
         +x4kW2LNOKr9RwIw6zspdy3MMK/Wxs4YuOuH829hqzfg/3hmI0v/jeCC/+q9CdCg8KpK
         NvE8x+Vdza/MMXh5uyzvmv99iX2DM8b2xWAN5TfJ6z4HLlrjkrZVqcATBDHjTQ1AA2rD
         pDpJawEHG+TE4RpfKtrwib0p0WINZImvEFjyAbL9LBMSzdwrQubaN9E5X13qwMvy8dTs
         v+kW2Nf+7bVzV1CV9bGsnMEjE6f8wUVgq4iqlbwb2nvppwT7ALO9tg6MJTMLqKsdPpgy
         r39Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzdubcqJQHNZsCEBfSDJzTunSTFBHX9ZdE2D4s3uDbtfgoabT3DccILzpOBeCgsHio15OMBvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwON94jTIR5Gq8wovk98nUfk5IbWJoySff8a+I7ANYMvsx5eo6t
	cA8vqPiTPTR+Zxi9QEM12oAly8FGSmd1FC7JoqzhG7lsANzrr101DAg8NbRg+U9O7C7qJlMorLy
	/DnoxIh/SAc8tXeCK4tMYg0KiK/4iRo7VeDGiaTIABcJo3GA7DnyOws0dFg==
X-Gm-Gg: ASbGncv1/8LBbJ0hHKGqNTRzRnde7+6zlV0xe65/id9CyB8YHzKClmZh3C1xy4yFtzw
	/4Xw9BBdJyEKhj80IUsoAwqvxNnUHvaQsBmKGMebbqrC8yDlgn4sMqTVd2D2Klsb9mueSlpVo+x
	A/fPEII7pCRQR4Sqd8u4htJscl6iJ0pV9CGdaLGxFUsSMXCknxtS1JKVsgoISwnvBIluSqvFEfG
	rLBb7zKYeAyGSHxBExnYBab/8BFn6FyanAFVeFQ9z/Gu/MzSy92x1ccvebLbQSxcKZ4E9Vcher/
	1JrgX3k8NWgubFOKeACbHJDGBOmRp/vz6D1x
X-Received: by 2002:a17:90b:274d:b0:312:639:a064 with SMTP id 98e67ed59e1d1-324ed1c0148mr964866a91.28.1755738535294;
        Wed, 20 Aug 2025 18:08:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgyYzuG1LwU7dy5gbKW1Txzu2sQ8ydDSf70h8audCyqBbqLTIblhyIOnbuign2ys27Ik27cg==
X-Received: by 2002:a17:90b:274d:b0:312:639:a064 with SMTP id 98e67ed59e1d1-324ed1c0148mr964834a91.28.1755738534780;
        Wed, 20 Aug 2025 18:08:54 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:be24:11ff:fe35:71b3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fe3047sm3303497a12.17.2025.08.20.18.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 18:08:54 -0700 (PDT)
Date: Thu, 21 Aug 2025 10:08:52 +0900
From: Shigeru Yoshida <syoshida@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, george.mccollister@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
Subject: Re: [PATCH net] hsr: add length check before setting network header
Message-ID: <aKZxpMIkk-oBqK-a@kernel-devel>
References: <20250820180325.580882-1-syoshida@redhat.com>
 <CANn89iJQsEXYR9wWoztv1SnoQcaRxKyyx7X7j_VDfvdJi4cfhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJQsEXYR9wWoztv1SnoQcaRxKyyx7X7j_VDfvdJi4cfhw@mail.gmail.com>

On Wed, Aug 20, 2025 at 11:16:21AM -0700, Eric Dumazet wrote:
> On Wed, Aug 20, 2025 at 11:04 AM Shigeru Yoshida <syoshida@redhat.com> wrote:
> >
> > syzbot reported an uninitialized value issue in hsr_get_node() [1].
> > If the packet length is insufficient, it can lead to the issue when
> > accessing HSR header.
> >
> > Add validation to ensure sufficient packet length before setting
> > network header in HSR frame handling to prevent the issue.
> >
> > [1]
> > BUG: KMSAN: uninit-value in hsr_get_node+0xab0/0xad0 net/hsr/hsr_framereg.c:250
> >  hsr_get_node+0xab0/0xad0 net/hsr/hsr_framereg.c:250
> >  fill_frame_info net/hsr/hsr_forward.c:577 [inline]
> >  hsr_forward_skb+0x330/0x30e0 net/hsr/hsr_forward.c:615
> >  hsr_handle_frame+0xa20/0xb50 net/hsr/hsr_slave.c:69
> >  __netif_receive_skb_core+0x1cff/0x6190 net/core/dev.c:5432
> >  __netif_receive_skb_one_core net/core/dev.c:5536 [inline]
> >  __netif_receive_skb+0xca/0xa00 net/core/dev.c:5652
> >  netif_receive_skb_internal net/core/dev.c:5738 [inline]
> >  netif_receive_skb+0x58/0x660 net/core/dev.c:5798
> >  tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1549
> >  tun_get_user+0x5566/0x69e0 drivers/net/tun.c:2002
> >  tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
> >  call_write_iter include/linux/fs.h:2110 [inline]
> >  new_sync_write fs/read_write.c:497 [inline]
> >  vfs_write+0xb63/0x1520 fs/read_write.c:590
> >  ksys_write+0x20f/0x4c0 fs/read_write.c:643
> >  __do_sys_write fs/read_write.c:655 [inline]
> >  __se_sys_write fs/read_write.c:652 [inline]
> >  __x64_sys_write+0x93/0xe0 fs/read_write.c:652
> >  x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Uninit was created at:
> >  __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
> >  alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
> >  alloc_pages+0x1bf/0x1e0 mm/mempolicy.c:2335
> >  skb_page_frag_refill+0x2bf/0x7c0 net/core/sock.c:2921
> >  tun_build_skb drivers/net/tun.c:1679 [inline]
> >  tun_get_user+0x1258/0x69e0 drivers/net/tun.c:1819
> >  tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
> >  call_write_iter include/linux/fs.h:2110 [inline]
> >  new_sync_write fs/read_write.c:497 [inline]
> >  vfs_write+0xb63/0x1520 fs/read_write.c:590
> >  ksys_write+0x20f/0x4c0 fs/read_write.c:643
> >  __do_sys_write fs/read_write.c:655 [inline]
> >  __se_sys_write fs/read_write.c:652 [inline]
> >  __x64_sys_write+0x93/0xe0 fs/read_write.c:652
> >  x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > CPU: 1 PID: 5050 Comm: syz-executor387 Not tainted 6.9.0-rc4-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> >
> > Fixes: 48b491a5cc74 ("net: hsr: fix mac_len checks")
> > Reported-by: syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=a81f2759d022496b40ab
> > Tested-by: syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
> > Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> > ---
> >  net/hsr/hsr_slave.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> > index b87b6a6fe070..979fe4084f86 100644
> > --- a/net/hsr/hsr_slave.c
> > +++ b/net/hsr/hsr_slave.c
> > @@ -63,8 +63,12 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
> >         skb_push(skb, ETH_HLEN);
> >         skb_reset_mac_header(skb);
> >         if ((!hsr->prot_version && protocol == htons(ETH_P_PRP)) ||
> > -           protocol == htons(ETH_P_HSR))
> > +           protocol == htons(ETH_P_HSR)) {
> > +               if (skb->len < ETH_HLEN + HSR_HLEN)
> > +                       goto finish_pass;
> > +
> >                 skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
> > +       }
> >         skb_reset_mac_len(skb);
> >
> >         /* Only the frames received over the interlink port will assign a
> > --
> > 2.50.1
> >
> 
> You probably have missed a more correct fix :
> 
> https://www.spinics.net/lists/netdev/msg1116106.html

Hi Eric,

Yes, I missed the patch you mentioned. Sorry~

Shigeru


