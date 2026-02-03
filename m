Return-Path: <netdev+bounces-256282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MBXAGHtgWkFMAMAu9opvQ
	(envelope-from <netdev+bounces-256282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:43:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA4FD928E
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA2C0309A1E0
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 12:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBA63446B3;
	Tue,  3 Feb 2026 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPKYO3kf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n8IJvjZr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43870343203
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122335; cv=none; b=QRyFixnEvQctL0Nkaoh/64BtsuRGjwTQx4wjW2JEePw/bVlzWN1BqdotqUjnDDYJlkGkFxfkorAcqI5/an8rn2KRV/0Ca+BroBJCJQI8kzEepfHUgPcaOUKotBUlRku2JgW8BSFewzzvOHzahiP6Bd2Gopoz+5DHzoBvUP4sPMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122335; c=relaxed/simple;
	bh=QX+Hpl7OXNh+1VgDASXZvRVQuKuV8U6NKtAmZyOHEdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aifcYOLuUWRNyjB7pSvoNBZwmsz8GMZwq6r/4Sphf92cAOiu1fc9oLaiv2HwFEpUGemthHYu0xpii1bywd4qERF50biW2zqejnKPvSRm8pnjjRBBH622ygwcjs/XZOtv+MH2jSn3P2B84bAG01CLwHhI5+GFmwN6+MrvmP3o0qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPKYO3kf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n8IJvjZr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770122332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LbQBBbVCLYemf9DoIdcP8e631qoC+n0erfLRmUwOYuY=;
	b=CPKYO3kfI2jHIn1+btlDk0262jp0TPgihMVerQ2xpiNA+RmD5KjSSkmdlDzbmOmmVzxEpm
	ooiZN9ja9IJ08Ykz4Skq1skxQ3X7WBimnwElvHDNMNbchvTE3xtubnOHbak5dndvcDKFXQ
	d+7tVDjxXcVCWbGIrBwPQx9RbVnAuAo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-cBgvlPykOi2pLVCmUADBng-1; Tue, 03 Feb 2026 07:38:51 -0500
X-MC-Unique: cBgvlPykOi2pLVCmUADBng-1
X-Mimecast-MFC-AGG-ID: cBgvlPykOi2pLVCmUADBng_1770122330
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b88632ba0b5so524858666b.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 04:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770122330; x=1770727130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbQBBbVCLYemf9DoIdcP8e631qoC+n0erfLRmUwOYuY=;
        b=n8IJvjZrleAZwrof0k44Aob1qfZvlaF/MwxGlyLCyzSa3D8BJp+7dzwy4bHRs15dGU
         ztEt66wCbCncsLEAiz9whPQBfyt22ci5snwyz19hZbfc2d+R/fMcsmYAGMQ4ytTjDoqT
         6MuCSO7I3pWTfRs09JqhtjzTTRu6+pMg3M1hYi757wPr3schG0FhhKfla7TejOrsoUh6
         ENBh0aGjDmUZBi5jZYdonbBkGgAAbZjZKSmRpgykvLSULhWyBQHa0/UcP+lBGF6qkpOO
         t7gquAsLNUCvnEVTdDLPiwaylEaPVn/m3VfgN2zK2ypWZ3ZxfIQykjAN/qoLdj+S6+86
         Wvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770122330; x=1770727130;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LbQBBbVCLYemf9DoIdcP8e631qoC+n0erfLRmUwOYuY=;
        b=kEny4xmWCA+EvTisIaB2Ok9rlvw+CxCAXiV2EvXE/5e/cyFNDXOgKadmPdPXaGJ30L
         YrpKXy8WgKNolnjMqgTd6xHZu1DSXJTOjE1v82l9bFhd9R2TRsnAP+h0TsR0pSMfsawX
         3EdYbvdhXM2EtM3VndQGdf/89Tb++vzyNUsRDpcZHI8NC6JSCNMx183tj3Ua+/bbqRb6
         /wuMMtzOH4KahzoN8twEUPALcWeZU8NeALmx9JmXseSy0Q2FSEtS9JnWdfe8Fdib9SBp
         qtHTz9J2uaRWPjh+XaynskDn9yHeNl4FS2OTBnp2pd2z2104FM/kDRMkpRGOhZWWNRdR
         YsVg==
X-Forwarded-Encrypted: i=1; AJvYcCVVK0psghJKj3Ybp3vsmUgtiDwMUIx7X77AN6ZPpBSpP0MQsQPP7Dd/co8fueQOF6wqi29J174=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/KhkzyzSTfD5TqYYhN/20Y9rPCY26th7Wa30tPzHgByn0a/me
	x3WxW+ldz8RikE9tDa/BrzzCHvOnI2GgvZb4D6Vbz/DfLHd8JhkPohDSq394Q50v0XYoJOIGOg9
	cn+f7XFJ1RwOjQOwhBnqKbJCl7Y7x9FBOGZhDU6qDssYY8Y9AMceKIq/Svg==
X-Gm-Gg: AZuq6aLSpCml1ciyKIeS1tfgq90/lsFbQvn2k192X2r20X2lQ1H/JHb1Yz15w4E5PpO
	ziEyEuVjBH4DLOAGxUgpVLJJoX3gOq2GWAdp54RMNrFlEpbrjls00CMN9v1cGk8j6xSXTglflBK
	E8SCZGhyXFCY19bFD9a3CU2umL3R1hvmBxtmW2CDCo2p94TzdgOUPOag35aSzpNaIHvFjByDEFk
	qmeH4MQ1tsN1dqyGf9486I2jNfyWY0Y44HtgABZv5ruE/aiThdyOssQiUCBNPSNrsynTRQBLeCp
	xE51an7X5wohZ2N+vDisb16bYWIQDJfwmAeQmZRtBHf+GtDgOBOxAqSV5D06nBRaK4L4hY0mDd8
	/hjy0ykCeGYcxIjpZTHyYXxiGzx4cwD+esI2y
X-Received: by 2002:a17:906:c10f:b0:b88:411c:fcbf with SMTP id a640c23a62f3a-b8dff506ec8mr944491566b.12.1770122329684;
        Tue, 03 Feb 2026 04:38:49 -0800 (PST)
X-Received: by 2002:a17:906:c10f:b0:b88:411c:fcbf with SMTP id a640c23a62f3a-b8dff506ec8mr944485766b.12.1770122329039;
        Tue, 03 Feb 2026 04:38:49 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbefc6995sm1011619066b.24.2026.02.03.04.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 04:38:48 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E3EFC4D0E25; Tue, 03 Feb 2026 13:38:47 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, "Bastien Curutchet
 (eBPF Foundation)" <bastien.curutchet@bootlin.com>, Tushar Vyavahare
 <tushar.vyavahare@intel.com>, Jason Xing <kernelxing@tencent.com>,
 =?utf-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>, Eelco Chaudron
 <echaudro@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH bpf 1/6] xdp: produce a warning when calculated tailroom
 is negative
In-Reply-To: <aYHqtxtg3uNXO668@soc-5CG4396X81.clients.intel.com>
References: <20260203105417.2302672-1-larysa.zaremba@intel.com>
 <20260203105417.2302672-2-larysa.zaremba@intel.com>
 <87zf5q109e.fsf@toke.dk>
 <aYHqtxtg3uNXO668@soc-5CG4396X81.clients.intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 03 Feb 2026 13:38:47 +0100
Message-ID: <87o6m60zoo.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256282-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,lists.osuosl.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,toke.dk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5EA4FD928E
X-Rspamd-Action: no action

Larysa Zaremba <larysa.zaremba@intel.com> writes:

> On Tue, Feb 03, 2026 at 01:26:21PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Larysa Zaremba <larysa.zaremba@intel.com> writes:
>>=20
>> > Many ethernet drivers report xdp Rx queue frag size as being the same =
as
>> > DMA write size. However, the only user of this field, namely
>> > bpf_xdp_frags_increase_tail(), clearly expects a truesize.
>> >
>> > Such difference leads to unspecific memory corruption issues under cer=
tain
>> > circumstances, e.g. in ixgbevf maximum DMA write size is 3 KB, so when
>> > running xskxceiver's XDP_ADJUST_TAIL_GROW_MULTI_BUFF, 6K packet fully =
uses
>> > all DMA-writable space in 2 buffers. This would be fine, if only
>> > rxq->frag_size was properly set to 4K, but value of 3K results in a
>> > negative tailroom, because there is a non-zero page offset.
>> >
>> > We could return -EINVAL and be done with it in such case, but due to
>> > tailroom being stored as an unsigned int, it is reported to be somewhe=
re
>> > near UINT_MAX, resulting in a tail being grown, even if the requested
>> > offset is too much (it is around 2K in the abovementioned test). This =
later
>> > leads to all kinds of unspecific calltraces.
>> >
>> > [ 7340.337579] xskxceiver[1440]: segfault at 1da718 ip 00007f4161aeac9=
d sp 00007f41615a6a00 error 6
>> > [ 7340.338040] xskxceiver[1441]: segfault at 7f410000000b ip 000000000=
04042b5 sp 00007f415bffecf0 error 4
>> > [ 7340.338179]  in libc.so.6[61c9d,7f4161aaf000+160000]
>> > [ 7340.339230]  in xskxceiver[42b5,400000+69000]
>> > [ 7340.340300]  likely on CPU 6 (core 0, socket 6)
>> > [ 7340.340302] Code: ff ff 01 e9 f4 fe ff ff 0f 1f 44 00 00 4c 39 f0 7=
4 73 31 c0 ba 01 00 00 00 f0 0f b1 17 0f 85 ba 00 00 00 49 8b 87 88 00 00 0=
0 <4c> 89 70 08 eb cc 0f 1f 44 00 00 48 8d bd f0 fe ff ff 89 85 ec fe
>> > [ 7340.340888]  likely on CPU 3 (core 0, socket 3)
>> > [ 7340.345088] Code: 00 00 00 ba 00 00 00 00 be 00 00 00 00 89 c7 e8 3=
1 ca ff ff 89 45 ec 8b 45 ec 85 c0 78 07 b8 00 00 00 00 eb 46 e8 0b c8 ff f=
f <8b> 00 83 f8 69 74 24 e8 ff c7 ff ff 8b 00 83 f8 0b 74 18 e8 f3 c7
>> > [ 7340.404334] Oops: general protection fault, probably for non-canoni=
cal address 0x6d255010bdffc: 0000 [#1] SMP NOPTI
>> > [ 7340.405972] CPU: 7 UID: 0 PID: 1439 Comm: xskxceiver Not tainted 6.=
19.0-rc1+ #21 PREEMPT(lazy)
>> > [ 7340.408006] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIO=
S 1.17.0-5.fc42 04/01/2014
>> > [ 7340.409716] RIP: 0010:lookup_swap_cgroup_id+0x44/0x80
>> > [ 7340.410455] Code: 83 f8 1c 73 39 48 ba ff ff ff ff ff ff ff 03 48 8=
b 04 c5 20 55 fa bd 48 21 d1 48 89 ca 83 e1 01 48 d1 ea c1 e1 04 48 8d 04 9=
0 <8b> 00 48 83 c4 10 d3 e8 c3 cc cc cc cc 31 c0 e9 98 b7 dd 00 48 89
>> > [ 7340.412787] RSP: 0018:ffffcc5c04f7f6d0 EFLAGS: 00010202
>> > [ 7340.413494] RAX: 0006d255010bdffc RBX: ffff891f477895a8 RCX: 000000=
0000000010
>> > [ 7340.414431] RDX: 0001c17e3fffffff RSI: 00fa070000000000 RDI: 000382=
fc7fffffff
>> > [ 7340.415354] RBP: 00fa070000000000 R08: ffffcc5c04f7f8f8 R09: ffffcc=
5c04f7f7d0
>> > [ 7340.416283] R10: ffff891f4c1a7000 R11: ffffcc5c04f7f9c8 R12: ffffcc=
5c04f7f7d0
>> > [ 7340.417218] R13: 03ffffffffffffff R14: 00fa06fffffffe00 R15: ffff89=
1f47789500
>> > [ 7340.418229] FS:  0000000000000000(0000) GS:ffff891ffdfaa000(0000) k=
nlGS:0000000000000000
>> > [ 7340.419489] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > [ 7340.420286] CR2: 00007f415bfffd58 CR3: 0000000103f03002 CR4: 000000=
0000772ef0
>> > [ 7340.421237] PKRU: 55555554
>> > [ 7340.421623] Call Trace:
>> > [ 7340.421987]  <TASK>
>> > [ 7340.422309]  ? softleaf_from_pte+0x77/0xa0
>> > [ 7340.422855]  swap_pte_batch+0xa7/0x290
>> > [ 7340.423363]  zap_nonpresent_ptes.constprop.0.isra.0+0xd1/0x270
>> > [ 7340.424102]  zap_pte_range+0x281/0x580
>> > [ 7340.424607]  zap_pmd_range.isra.0+0xc9/0x240
>> > [ 7340.425177]  unmap_page_range+0x24d/0x420
>> > [ 7340.425714]  unmap_vmas+0xa1/0x180
>> > [ 7340.426185]  exit_mmap+0xe1/0x3b0
>> > [ 7340.426644]  __mmput+0x41/0x150
>> > [ 7340.427098]  exit_mm+0xb1/0x110
>> > [ 7340.427539]  do_exit+0x1b2/0x460
>> > [ 7340.427992]  do_group_exit+0x2d/0xc0
>> > [ 7340.428477]  get_signal+0x79d/0x7e0
>> > [ 7340.428957]  arch_do_signal_or_restart+0x34/0x100
>> > [ 7340.429571]  exit_to_user_mode_loop+0x8e/0x4c0
>> > [ 7340.430159]  do_syscall_64+0x188/0x6b0
>> > [ 7340.430672]  ? __do_sys_clone3+0xd9/0x120
>> > [ 7340.431212]  ? switch_fpu_return+0x4e/0xd0
>> > [ 7340.431761]  ? arch_exit_to_user_mode_prepare.isra.0+0xa1/0xc0
>> > [ 7340.432498]  ? do_syscall_64+0xbb/0x6b0
>> > [ 7340.433015]  ? __handle_mm_fault+0x445/0x690
>> > [ 7340.433582]  ? count_memcg_events+0xd6/0x210
>> > [ 7340.434151]  ? handle_mm_fault+0x212/0x340
>> > [ 7340.434697]  ? do_user_addr_fault+0x2b4/0x7b0
>> > [ 7340.435271]  ? clear_bhb_loop+0x30/0x80
>> > [ 7340.435788]  ? clear_bhb_loop+0x30/0x80
>> > [ 7340.436299]  ? clear_bhb_loop+0x30/0x80
>> > [ 7340.436812]  ? clear_bhb_loop+0x30/0x80
>> > [ 7340.437323]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> > [ 7340.437973] RIP: 0033:0x7f4161b14169
>> > [ 7340.438468] Code: Unable to access opcode bytes at 0x7f4161b1413f.
>> > [ 7340.439242] RSP: 002b:00007ffc6ebfa770 EFLAGS: 00000246 ORIG_RAX: 0=
0000000000000ca
>> > [ 7340.440173] RAX: fffffffffffffe00 RBX: 00000000000005a1 RCX: 00007f=
4161b14169
>> > [ 7340.441061] RDX: 00000000000005a1 RSI: 0000000000000109 RDI: 00007f=
415bfff990
>> > [ 7340.441943] RBP: 00007ffc6ebfa7a0 R08: 0000000000000000 R09: 000000=
00ffffffff
>> > [ 7340.442824] R10: 0000000000000000 R11: 0000000000000246 R12: 000000=
0000000000
>> > [ 7340.443707] R13: 0000000000000000 R14: 00007f415bfff990 R15: 00007f=
415bfff6c0
>> > [ 7340.444586]  </TASK>
>> > [ 7340.444922] Modules linked in: rfkill intel_rapl_msr intel_rapl_com=
mon intel_uncore_frequency_common skx_edac_common nfit libnvdimm kvm_intel =
vfat fat kvm snd_pcm irqbypass rapl iTCO_wdt snd_timer intel_pmc_bxt iTCO_v=
endor_support snd ixgbevf virtio_net soundcore i2c_i801 pcspkr libeth_xdp n=
et_failover i2c_smbus lpc_ich failover libeth virtio_balloon joydev 9p fuse=
 loop zram lz4hc_compress lz4_compress 9pnet_virtio 9pnet netfs ghash_clmul=
ni_intel serio_raw qemu_fw_cfg
>> > [ 7340.449650] ---[ end trace 0000000000000000 ]---
>> >
>> > The issue can be fixed in all in-tree drivers, but we cannot just trus=
t OOT
>> > drivers to not do this. Therefore, make tailroom a signed int and prod=
uce a
>> > warning when it is negative to prevent such mistakes in the future.
>> >
>> > Fixes: bf25146a5595 ("bpf: add frags support to the bpf_xdp_adjust_tai=
l() API")
>> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
>> > ---
>> >  net/core/filter.c | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/net/core/filter.c b/net/core/filter.c
>> > index 616e0520a0bb..9715d957e3c5 100644
>> > --- a/net/core/filter.c
>> > +++ b/net/core/filter.c
>> > @@ -4149,12 +4149,13 @@ static int bpf_xdp_frags_increase_tail(struct =
xdp_buff *xdp, int offset)
>> >  	struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(xdp);
>> >  	skb_frag_t *frag =3D &sinfo->frags[sinfo->nr_frags - 1];
>> >  	struct xdp_rxq_info *rxq =3D xdp->rxq;
>> > -	unsigned int tailroom;
>> > +	int tailroom;
>> >=20=20
>> >  	if (!rxq->frag_size || rxq->frag_size > xdp->frame_sz)
>> >  		return -EOPNOTSUPP;
>> >=20=20
>> >  	tailroom =3D rxq->frag_size - skb_frag_size(frag) - skb_frag_off(fra=
g);
>> > +	WARN_ON_ONCE(tailroom < 0);
>> >  	if (unlikely(offset > tailroom))
>> >  		return -EINVAL;
>> >=20=20
>>=20
>> Why can't we do both? I.e., WARN_ON_ONCE() *and* return -EINVAL?
>>=20
>> -Toke
>>=20
>
> It would be redundant, offset is always >=3D 0 here, so with tailroom now=
 being a=20
> signed int, offset is always bigger and -EINVAL is returned.

Oh, I see. OK, may be worth calling out; I read this paragraph in your
commit message to mean "we don't bother returning EINVAL in this case,
we just warn":

> > We could return -EINVAL and be done with it in such case, but due to
> > tailroom being stored as an unsigned int, it is reported to be somewhere
> > near UINT_MAX, resulting in a tail being grown, even if the requested
> > offset is too much (it is around 2K in the abovementioned test). This l=
ater
> > leads to all kinds of unspecific calltraces.

-Toke


