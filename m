Return-Path: <netdev+bounces-296645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TQzoEp/nJmpumwIAu9opvQ
	(envelope-from <netdev+bounces-296645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:02:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9A665876A
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:02:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fZhQ0KOG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296645-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296645-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 692E93389A78
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 15:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5BB3CDBB7;
	Mon,  8 Jun 2026 15:39:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD2E2C11EF
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 15:39:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933159; cv=none; b=M8OTl7eWiKjdb/s2fGF8GIL3aLo4TEohzYQe3dTFAzmpTe0ySwOSrQvVrAwGUARV80Nk10ZCmYpnXaJU5uz6hzcjZNHlAO0aU30mn6imGRfN1atXkXw2cIwKqBlXi8U/51OKzoLJ2UtLhAuzyUpZgBXJnp11BSx+96L5xM4/wPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933159; c=relaxed/simple;
	bh=LLVg4FmqZkKdgZcwRYLdfQnscGZdiauG0kJ5C7q08u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIYiT5Fvytf8rqY7vHEhJJKz0731OEAFq8b3LqTAKr0S5sfZw6G5dnt1K5vh37pPyb5HamEkah1l2lZ2VDDVScdj/TD8hQb/Az2b2yP5s32ojZifS3frXpzW6zNeBxYx8K/MQf96c3EFCYEISyxzrFtGgtI133NmKpk6BG6JYwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZhQ0KOG; arc=none smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bf22d29dabso29737085ad.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 08:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780933157; x=1781537957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mawist4o70KGBP/fKYY4VHSuIdYkQXArJFQYlfxYh4E=;
        b=fZhQ0KOGBGZ96yInjZYJnO5k25M9+cPe7Kh0izgxGY3UcUtGpN59HayTFWEA81L/qF
         TVcCIeuizzQ/zkBUNKN6GkpaGytdzwdViRJq7mLhYImgKlb85V34aBHVyWB624G5Pt90
         TWRY6RXz3L6/qPgCiye8pRzR3yy7vudb2qyLGbnG3qP9jNn5CeREjBdgzZevJ5x2hbgO
         9esRuojvx7Nq98/CrConpZecUzkhVRQL/DBGbyz2/A/W9uRtzCrJx3swpkPi0hAjHZN6
         uEVUwwh6mg8u9KROQcxDBIutS71HXOBctZutYLUqfmgOGKUxn46btHvGyJ9HsyW6pY1p
         nG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780933157; x=1781537957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mawist4o70KGBP/fKYY4VHSuIdYkQXArJFQYlfxYh4E=;
        b=M5/EOVqdWFt33l40cswWFTHnLryKkfdJMI+INMc1mnYkWl7n4hj6iKaAEERh0VVBaT
         3oHEv3TX09lzTqBWOXL29AsJNLx/iz9uyeywAALRU5jYC+n8PhvQMqHRNtFyD8cIshnF
         ZOrIuEeKDXAlQuY9XYyPT3a/ugM2M8w9XK2Wee0c9uAqc2p/0CChQZC6IoZNycshyYIx
         8O2C9fuuncg6yN+WFqA0Xxh7CTGmUOPWaRqkUCC9xzO0GCQa2mJb9tpaoZMDbncO9Wtp
         j7hre4kIBrIUajHetFx3ecNN9pB7mgq4E4MDze7/Ujz2YjOJzLSSviT0hde8Y51MRnuK
         ctQg==
X-Gm-Message-State: AOJu0YwtmYRmCAMR4Y9DnhgolTrUM6EkwGzgNO9TMLRq2ojxWpG/HXl6
	Ceu9XFMHv1PZqkFw4hzTu6uILH0Aud+wBT0uPbImW/NWmrApHTRoKuq/G9dtgnDDlRQ=
X-Gm-Gg: Acq92OGeQdfMeYGkIVEbx7XQnqYCNQrogBlsaa8nFAx793d6c/HACYBDaG7WMbXjHQu
	QS74gebuGjeuSH2B9N0POe4gV7ZKcDJSEjZo6yrnlkwzeMyIrFTxDXFIT318aBTGWXKsaRKyuWy
	5mq/J06Ck1A0liTbBeU45jBzTO9dQAt+qFGeEOtQoD74FuZeJeAJFYT3sDxCtw8tbeXg0aoitoG
	tPUHEXhICTdpnSQakrFRW0P22tkQWPjYAOkuFKGpn2Q5yWUhmSsHOsWcbrLocXG/CEc1ci1Pe8N
	U9nOHaayZGxikONR6okszDwz3TCYkmoldOGacfbuSUdtzP+BgdDaYRdXcRRq92BHK6aWTe9tGfr
	7ossDM4l0ikz9QyQ4lU/SZB4RqhcxHd2J6huvzz/NuOAknBeAgasobrOAJ0h8GDqB7EJptduLyz
	7Cuorg55w8T2B005itvrQZ6AikxNykHx2jn3yyNEEixFQ5B9HNMvJrQw==
X-Received: by 2002:a17:902:ea06:b0:2c0:abd3:32f1 with SMTP id d9443c01a7336-2c1e8220b2bmr180715925ad.24.1780933156825;
        Mon, 08 Jun 2026 08:39:16 -0700 (PDT)
Received: from DESKTOP-19IMU7U.localdomain ([125.242.148.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e627sm190772475ad.52.2026.06.08.08.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:39:16 -0700 (PDT)
Date: Tue, 9 Jun 2026 00:39:13 +0900
From: Wongi Lee <qw3rtyp0@gmail.com>
To: netdev@vger.kernel.org
Cc: Willy Tarreau <w@1wt.eu>, security@kernel.org,
	Jungwoo Lee <jwlee2217@gmail.com>, davem@davemloft.net,
	dsahern@kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH net] ipv6: account for fraggap on the paged allocation path
Message-ID: <aibiIYMAwUErTw5U@DESKTOP-19IMU7U.localdomain>
References: <CAOfhic1BeK7VxznrsEcsoNMuSMWRsRxNuXSVYjnf5oWGPWKvXA@mail.gmail.com>
 <agrEZozdi1PDiakb@1wt.eu>
 <agyR0bR5kwehfEa0@DESKTOP-19IMU7U.localdomain>
 <agy4We9Rz-jO58EH@1wt.eu>
 <ag9BWOr3N/W2NZm9@DESKTOP-19IMU7U.localdomain>
 <ahm3otvuvZXWDdna@DESKTOP-19IMU7U.localdomain>
 <ahnHXfvtfqSil8QW@1wt.eu>
 <ah7gEKGas+MgbjlA@DESKTOP-19IMU7U.localdomain>
 <2026060220-spied-preformed-6b89@gregkh>
 <ah8VQnoL2IyygAAd@DESKTOP-19IMU7U.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah8VQnoL2IyygAAd@DESKTOP-19IMU7U.localdomain>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[1wt.eu,kernel.org,gmail.com,davemloft.net,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-296645-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:w@1wt.eu,m:security@kernel.org,m:jwlee2217@gmail.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[qw3rtyp0@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qw3rtyp0@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E9A665876A

On Wed, Jun 03, 2026 at 02:39:19AM +0900, Wongi Lee wrote:
> On Tue, Jun 02, 2026 at 05:44:52PM +0200, Greg KH wrote:
> > On Tue, Jun 02, 2026 at 10:52:16PM +0900, Wongi Lee wrote:
> > > On Fri, May 29, 2026 at 07:05:33PM +0200, Willy Tarreau wrote:
> > > > On Sat, May 30, 2026 at 12:58:26AM +0900, Wongi Lee wrote:
> > > > > Hi, 
> > > > > 
> > > > > I'm reaching out to check on the progress of this issue. Would it be possible to get an update on where things currently stand?
> > > > 
> > > > Let's wait for the maintainers to breathe a little bit, they get
> > > > multiple reports like this one every single day. It's also possible
> > > > this one fell through the cracks, so let's wait for their response
> > > > first.
> > > > 
> > > > Thanks,
> > > > Willy
> > > 
> > > Hi Willy,
> > > 
> > > First, my apologies if I came across as pushy.
> > > 
> > > The reason I'm following up is that this bug is one of the bugs used in exploit, so from my perspective it would be good to get the fix applied sooner rather than later.
> > > 
> > > I also recently read in the documentation that bugs found with the help of AI are encouraged to be reported on open channels such as netdev. If the security team sees no problem with it, I'd like to ask whether it would be okay to post the details of this bug to netdev.
> > 
> > Do you have a proposed fix for this issue?  if so, has it been sent here
> > in a format it can be applied?  If not, can you work on creating that?
> > 
> > thanks,
> > 
> > greg k-h
>

The maintainers have been busy lately and following Willy's suggestion 
on the earlier thread to resend this to netdev with the maintainers in Cc, 
I'd like to submit the patch here.

As requested, I've removed the PoC from this submission.
So the message below only describes the issue and the proposed fix. 

If the maintainers need any additional information including the PoC, I'm happy 
to provide it.

> 
> For now, I'll send a summary to here.
> Below is the summarized email previously sent.
> 
> Subject: [PATCH net] ipv6: account for fraggap on the paged allocation path
> 
> In __ip6_append_data(), when the paged-allocation branch is taken
> (MSG_MORE / NETIF_F_SG / large fraglen), alloclen and pagedlen are
> computed as
> 
> 	alloclen = fragheaderlen + transhdrlen;
> 	pagedlen = datalen - transhdrlen;
> 
> datalen already includes fraggap (datalen = length + fraggap), but 
> the fraggap bytes carried over from the previous skb are copied into 
> the new skb's linear area at offset transhdrlen by the subsequent 
> skb_copy_and_csum_bits(). The linear area is therefore undersized by 
> fraggap bytes while pagedlen is overstated by the same amount, and 
> the copy writes past skb->end into the trailing skb_shared_info.
> 
> An unprivileged user can trigger this via a UDPv6 socket using
> MSG_MORE together with MSG_SPLICE_PAGES.
> 
> The non-paged branch a few lines above sets
> alloclen = fraglen = datalen + fragheaderlen, which already accounts
> for fraggap because datalen does. Bring the paged branch in line by
> adding fraggap to alloclen and subtracting it from pagedlen.
> 
> Fixes: 773ba4fe9104 ("ipv6: avoid partial copy for zc")
> Reported-by: Wongi Lee <qw3rtyp0@gmail.com>
> Reported-by: Jungwoo Lee <jwlee2217@gmail.com>
> Assisted-by: Xint
> Signed-off-by: Wongi Lee <qw3rtyp0@gmail.com>
> ---
>  net/ipv6/ip6_output.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index c14adcdd4396..265502caa44b 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1667,8 +1667,8 @@ static int __ip6_append_data(struct sock *sk,
>  				 (fraglen + alloc_extra < SKB_MAX_ALLOC ||
>  				  !(rt->dst.dev->features & NETIF_F_SG)))
>  				alloclen = fraglen;
>  			else {
> -				alloclen = fragheaderlen + transhdrlen;
> -				pagedlen = datalen - transhdrlen;
> +				alloclen = fragheaderlen + transhdrlen + fraggap;
> +				pagedlen = datalen - transhdrlen - fraggap;
>  			}
>  			alloclen += alloc_extra;
> 
> 
> 
> If there are formatting issue or needs additional information 
> please let me know.
> 
> The bug was triggered on v6.12.85, also found that the same code
> pattern is present in v7.1-rc3.
> 
> KASAN
> 
> [   12.504958] Oops: general protection fault, probably for non-canonical address 0xe008444848484848: 0000 [#1] SMP KASAN NOPTI
> [   12.508187] KASAN: maybe wild-memory-access in range [0x0042424242424240-0x0042424242424247]
> [   12.511796] CPU: 1 UID: 1000 PID: 212 Comm: exploit Not tainted 6.12.85 #1
> [   12.513507] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   12.516423] RIP: 0010:kfree_skb_list_reason+0x18a/0x610
> [   12.517848] Code: 3c 18 00 0f 85 97 03 00 00 4c 89 7c d4 58 83 f9 10 0f 84 24 02 00 00 48 85 ed 0f 84 33 01 00 00 49 89 ef 4c 89 f8 48 c1 e8 03 <80> 3c 18 00 0f 85 25 03 00 00 4d 8d af dc 00 00 00 be 04 00 00 00
> [   12.523857] RSP: 0018:ffffc90000d47b90 EFLAGS: 00010216
> [   12.524957] RAX: 0008484848484848 RBX: dffffc0000000000 RCX: 0000000000000000
> [   12.526917] RDX: 1ffff11001893159 RSI: 0000000000000002 RDI: ffffc90000d47c68
> [   12.528739] RBP: ffff88800c498ac0 R08: 0000000000000001 R09: fffff94000063d56
> [   12.530599] R10: ffffea000031eab7 R11: 0000000000000008 R12: 0000000000000002
> [   12.532545] R13: 1ffffffff5b8660d R14: ffffc90000d47be0 R15: 0042424242424242
> [   12.534509] FS:  0000000032dfd380(0000) GS:ffff8880be100000(0000) knlGS:0000000000000000
> [   12.536828] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   12.538500] CR2: 0000000000492c7a CR3: 0000000003dfa000 CR4: 0000000000350ef0
> [   12.540694] Call Trace:
> [   12.541484]  <TASK>
> [   12.541959]  ? __pfx_kfree_skb_list_reason+0x10/0x10
> [   12.543622]  ? srso_return_thunk+0x5/0x5f
> [   12.544613]  ? srso_return_thunk+0x5/0x5f
> [   12.545511]  ? __wake_up+0x44/0x60
> [   12.546501]  ? srso_return_thunk+0x5/0x5f
> [   12.547913]  skb_release_data+0x4c6/0x7f0
> [   12.549113]  ? __ip6_flush_pending_frames+0x1c0/0x340
> [   12.550973]  ? __ip6_flush_pending_frames+0x1c0/0x340
> [   12.552584]  sk_skb_reason_drop+0xf1/0x320
> [   12.554091]  __ip6_flush_pending_frames+0x1c0/0x340
> [   12.555458]  udpv6_destroy_sock+0xfa/0x280
> [   12.556456]  sk_common_release+0x65/0x370
> [   12.557501]  inet_release+0x109/0x270
> [   12.558522]  __sock_release+0xa6/0x260
> [   12.559475]  sock_close+0x15/0x20
> [   12.560331]  __fput+0x2f7/0x9d0
> [   12.561188]  __x64_sys_close+0x7c/0xd0
> [   12.562221]  do_syscall_64+0x58/0x120
> [   12.563422]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   12.565122] RIP: 0033:0x41aad4
> [   12.565831] Code: d0 0f 05 48 3d 00 f0 ff ff 76 f3 f7 d8 64 89 06 eb ec 0f 1f 40 00 f3 0f 1e fa 80 3d 8d c5 09 00 00 74 13 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 3c c3 0f 1f 00 55 48 89 e5 48 83 ec 10 89 7d
> [   12.570848] RSP: 002b:00007ffe399fe088 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> [   12.572320] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 000000000041aad4
> [   12.574150] RDX: 0000000000000000 RSI: 00007ffe399fdee0 RDI: 0000000000000005
> [   12.576095] RBP: 0000000000000000 R08: 000000000000001d R09: 0000000000000000
> [   12.577821] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000257
> [   12.579842] R13: 00007ffe399fecc8 R14: 00000000004b1868 R15: 0000000000000001
> [   12.581780]  </TASK>
> [   12.582451] Modules linked in:
> [   12.583352] ---[ end trace 0000000000000000 ]---
> [   12.584584] RIP: 0010:kfree_skb_list_reason+0x18a/0x610
> [   12.586156] Code: 3c 18 00 0f 85 97 03 00 00 4c 89 7c d4 58 83 f9 10 0f 84 24 02 00 00 48 85 ed 0f 84 33 01 00 00 49 89 ef 4c 89 f8 48 c1 e8 03 <80> 3c 18 00 0f 85 25 03 00 00 4d 8d af dc 00 00 00 be 04 00 00 00
> [   12.592262] RSP: 0018:ffffc90000d47b90 EFLAGS: 00010216
> [   12.593601] RAX: 0008484848484848 RBX: dffffc0000000000 RCX: 0000000000000000
> [   12.595543] RDX: 1ffff11001893159 RSI: 0000000000000002 RDI: ffffc90000d47c68
> [   12.597252] RBP: ffff88800c498ac0 R08: 0000000000000001 R09: fffff94000063d56
> [   12.598934] R10: ffffea000031eab7 R11: 0000000000000008 R12: 0000000000000002
> [   12.600850] R13: 1ffffffff5b8660d R14: ffffc90000d47be0 R15: 0042424242424242
> [   12.602617] FS:  0000000032dfd380(0000) GS:ffff8880be100000(0000) knlGS:0000000000000000
> [   12.605271] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   12.607401] CR2: 0000000000492c7a CR3: 0000000003dfa000 CR4: 0000000000350ef0
> 
> 

