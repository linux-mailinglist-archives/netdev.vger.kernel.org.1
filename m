Return-Path: <netdev+bounces-148719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E12C59E2FFE
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 00:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C91FAB23168
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 23:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807C2205E2F;
	Tue,  3 Dec 2024 23:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fskpg0aS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E23205E1C
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 23:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733269357; cv=none; b=G8fnm7Bt80nAcvXs1hL07asN3VRYkmFQaWUztVKtFzBCXy8lPD8jspBnBYJxnD5PH2naA2jLQqluOGtRo1zaykTL73ZGBi727bFU2JRpNtMZ8Mgiq6ZpjqPjMj2ZkvDrsikT47KpaJ2JNRzJ5/ld7tXLkIjZ3tai/x0e0dAjwcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733269357; c=relaxed/simple;
	bh=fwI9/XXyR07AUzN+HgR3bkUmeQ54geMVvf1nDdfSlxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qjOsHbgYisxL8Xo3Wu7RkboNT+PgKbxdq6OOc6LFfQDiDYncsP/Z/WbLrIcdp9+CsjWh6WS/ZbPKljE1Ub918nyjXLTr34bUQDoexlyfvWoYQvANBRv4+haQlLGqUtnrH/DpWga2a33yTfgioCRsa3Gln0K4kRXYlxrdsaxv9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fskpg0aS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733269354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jP48oirP/jzjdp4wMbHddClH0gdVYnkWZ6E1SNHGDBg=;
	b=Fskpg0aS9wAxw56lNY1MqeS7Kdeauj2Z/UVKf7rasmSgDG3fpxQl7Z1fe7J5OFgK7n2OMt
	CzWgdhV3saDiMjRJLD0vBU8s4KoHBv1K21pb37friSUc84FlBDnpqkX1dMOPKPJEIf9ZkS
	n4mAmiCYkKtlxwN+AXouAqt9uY7NjHU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-JcvMmrA7OcuIYDBHjBhQYg-1; Tue, 03 Dec 2024 18:42:33 -0500
X-MC-Unique: JcvMmrA7OcuIYDBHjBhQYg-1
X-Mimecast-MFC-AGG-ID: JcvMmrA7OcuIYDBHjBhQYg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e3cbf308so1521015f8f.2
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 15:42:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733269352; x=1733874152;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jP48oirP/jzjdp4wMbHddClH0gdVYnkWZ6E1SNHGDBg=;
        b=oHbF+vTQmnyd6Yy0JeSseDbpBsMfspugL2oscUULvv0q/3c651whyDSHXn1XnsVlg4
         qs6JrSrl/MZ0OHqmFgfk6wFp9yfiDGWvq++lXs0KsgbRu9G3DwwGom4CQvV8ZFiZWN2K
         ilUNRwEo7sekSwC2j6kZ70E9hcXEL5K09+9LpKyB+q//bGWEya939oX77X5eVWFiXOLv
         doHQd15/kIyIFAEaDNhWFrjGeRuRQKBGmxqNjfmtJKioKDRCEI4gjkLnn8gdONi7v6fy
         vYFXcvpF6qiB7j0IXEuKG+xIxd4ocBwEKF98wdqqHdU+UIKayVN3g9qT96Vp/ynkqyN9
         b3ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfOYm/BkWV7Xj8sgflnUoje0t/UUA2VQDvY6HRVFWpHnxlV3JJd19yBZV7pMYnCUpZ+DZnyiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7liIo7fAK+7bXirFCU/sAud8uOpwaql7covBaMYXfcxKmvv+W
	t0Y3vrRHGPddaTpdH0xabRxSj495m9MKsbKgkIq3zPqrABndtMwJJMQXcIe0mo6hOs3s2cWCAks
	sfs9CswJLfpYlhEQhxI/qpAf1Tby1ludRbD3yNu4eDoumeOQPwphzJg==
X-Gm-Gg: ASbGncva1as2e3/T/aZc0vl0tNw6pfArgBnKqP2wTDTjzV/nHi3qPfMJpmNU2HB8/Aa
	D1ifVYuMWPyLFRfPXsXZ7rosPrqiKKdetonFBoepSBVIHrK8B4LNoTKxE8f6NtyQIOCh+9e0PbF
	k9K5FaxhAuGHZRNg5LYdHk3hhnI1Xy0KkYINYJoOJSy2qhUCUd5OgVmIV6AamZVo0s7I71PEE4s
	aG9UZA3rGdcwLmqNCWiPWoj1cWaOXz9HAbaBA2j94dt0X8wNno3czdG8riI9Q==
X-Received: by 2002:a05:6000:78d:b0:385:fd26:f6e0 with SMTP id ffacd0b85a97d-385fd3cd5c6mr3847496f8f.18.1733269352010;
        Tue, 03 Dec 2024 15:42:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0+v53JLyM1Av8MjEVc8Nf5aoaK9LA2PxpXQ5fbV4iaNRezFQvJ9czSUvt2SY01b7Fb/oTmA==
X-Received: by 2002:a05:6000:78d:b0:385:fd26:f6e0 with SMTP id ffacd0b85a97d-385fd3cd5c6mr3847482f8f.18.1733269351691;
        Tue, 03 Dec 2024 15:42:31 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385eed2510esm8374572f8f.69.2024.12.03.15.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 15:42:30 -0800 (PST)
Date: Wed, 4 Dec 2024 00:42:28 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot+3ec5271486d7cb2d242a@syzkaller.appspotmail.com
Subject: Re: [PATCH net] geneve: do not assume mac header is set in
 geneve_xmit_skb()
Message-ID: <20241204004228.0a18cfe6@elisabeth>
In-Reply-To: <20241203182122.2725517-1-edumazet@google.com>
References: <20241203182122.2725517-1-edumazet@google.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Tue,  3 Dec 2024 18:21:21 +0000
Eric Dumazet <edumazet@google.com> wrote:

> We should not assume mac header is set in output path.
> 
> Use skb_eth_hdr() instead of eth_hdr() to fix the issue.
> 
> sysbot reported the following :
> 
>  WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 skb_mac_header include/linux/skbuff.h:3052 [inline]
>  WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 eth_hdr include/linux/if_ether.h:24 [inline]
>  WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 geneve_xmit_skb drivers/net/geneve.c:898 [inline]
>  WARNING: CPU: 0 PID: 11635 at include/linux/skbuff.h:3052 geneve_xmit+0x4c38/0x5730 drivers/net/geneve.c:1039
> Modules linked in:
> CPU: 0 UID: 0 PID: 11635 Comm: syz.4.1423 Not tainted 6.12.0-syzkaller-10296-gaaf20f870da0 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
>  RIP: 0010:skb_mac_header include/linux/skbuff.h:3052 [inline]
>  RIP: 0010:eth_hdr include/linux/if_ether.h:24 [inline]
>  RIP: 0010:geneve_xmit_skb drivers/net/geneve.c:898 [inline]
>  RIP: 0010:geneve_xmit+0x4c38/0x5730 drivers/net/geneve.c:1039
> Code: 21 c6 02 e9 35 d4 ff ff e8 a5 48 4c fb 90 0f 0b 90 e9 fd f5 ff ff e8 97 48 4c fb 90 0f 0b 90 e9 d8 f5 ff ff e8 89 48 4c fb 90 <0f> 0b 90 e9 41 e4 ff ff e8 7b 48 4c fb 90 0f 0b 90 e9 cd e7 ff ff
> RSP: 0018:ffffc90003b2f870 EFLAGS: 00010283
> RAX: 000000000000037a RBX: 000000000000ffff RCX: ffffc9000dc3d000
> RDX: 0000000000080000 RSI: ffffffff86428417 RDI: 0000000000000003
> RBP: ffffc90003b2f9f0 R08: 0000000000000003 R09: 000000000000ffff
> R10: 000000000000ffff R11: 0000000000000002 R12: ffff88806603c000
> R13: 0000000000000000 R14: ffff8880685b2780 R15: 0000000000000e23
> FS:  00007fdc2deed6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b30a1dff8 CR3: 0000000056b8c000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   __netdev_start_xmit include/linux/netdevice.h:5002 [inline]
>   netdev_start_xmit include/linux/netdevice.h:5011 [inline]
>   __dev_direct_xmit+0x58a/0x720 net/core/dev.c:4490
>   dev_direct_xmit include/linux/netdevice.h:3181 [inline]
>   packet_xmit+0x1e4/0x360 net/packet/af_packet.c:285
>   packet_snd net/packet/af_packet.c:3146 [inline]
>   packet_sendmsg+0x2700/0x5660 net/packet/af_packet.c:3178
>   sock_sendmsg_nosec net/socket.c:711 [inline]
>   __sock_sendmsg net/socket.c:726 [inline]
>   __sys_sendto+0x488/0x4f0 net/socket.c:2197
>   __do_sys_sendto net/socket.c:2204 [inline]
>   __se_sys_sendto net/socket.c:2200 [inline]
>   __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2200
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

Oops. Thanks for looking into this.

> Fixes: a025fb5f49ad ("geneve: Allow configuration of DF behaviour")
> Reported-by: syzbot+3ec5271486d7cb2d242a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/674f4b72.050a0220.17bd51.004a.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Stefano Brivio <sbrivio@redhat.com>
> ---
>  drivers/net/geneve.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index 2f29b1386b1c81640562e6ce91d6e8d88f0ffe1c..bc658bc6088546d5d1f116988b93d4dda915a799 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c
> @@ -895,7 +895,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
>  		if (geneve->cfg.df == GENEVE_DF_SET) {
>  			df = htons(IP_DF);
>  		} else if (geneve->cfg.df == GENEVE_DF_INHERIT) {
> -			struct ethhdr *eth = eth_hdr(skb);
> +			struct ethhdr *eth = skb_eth_hdr(skb);

Now, while your patch clearly looks better than the alternative, I
wonder: if skb->mac_header is not set...

>  			if (ntohs(eth->h_proto) == ETH_P_IPV6) {
>  				df = htons(IP_DF);

does eth->h_proto contain anything meaningful at this point? Is
there a more robust way to check for the IP version of the
encapsulated packet (assuming it's IP at all)?

Or should we rather *not* touch 'df' at all if
!skb_mac_header_was_set(skb)?

Unless you have the answers, give me some time to check that.

-- 
Stefano


