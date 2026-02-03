Return-Path: <netdev+bounces-256296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHJcIh38gWk7NQMAu9opvQ
	(envelope-from <netdev+bounces-256296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 14:46:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9685DA197
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 14:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF6F730D2051
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 13:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A319E3A0B01;
	Tue,  3 Feb 2026 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K78sVli6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xotwh4wY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D964539E6C3
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770125882; cv=none; b=Q16GO+ao7liMmEA+ZJBtzM674Z8KZjafoxfZ5+RJJQVx+MIFZIJiLGrHChzwHY1Jglg6DutofzeFrQMHyapwMbVbm7ytfgYzSqy/jQ+Gioek4da2JZu8zt9zp8MNRJUleqhky16AZX6+y0gp5T1UUSEyMgM00pXi1i1WEMofZ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770125882; c=relaxed/simple;
	bh=gwD7VbE0DKjB0WTf9FF9Z7SZhzE6MbUt/oFWkuJ01Bo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FF4b+TY6FLOxe9s5lCNVxuss/AK2oE/ux7zwG8d92d0HXyKjdBr8IYhlngBDU8BB/IXyoeWt/QCDP79NNK4AIl3uBoYdpbtsyQ87HC1VlRcaFD8B/+mI2Hmp8NZgoRW4Rnfs2kVZV85WGOWNvCgBF9WhsDsz4+SvNKNDk5nL9bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K78sVli6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xotwh4wY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770125878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtmJ0MecevVOkqmQ0sbIYbbzUt1IRFmbl82qHWlUp74=;
	b=K78sVli6c9hrVLQMAZWmUkAewly7Xl7BjMIpgfvxao7mFt6dieHleWi7hn9fwVW/O/c2HE
	diGqnhR3Y8uvZCP0DlxgDfuiN/g/s3CHHsrFycwZsmA78Ize9eKmwYMXlAxLE7uJ35rGEX
	b+D8odSgGaPxL0Yw9M1VjAiooFOwI4Y=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-TOzyKncSN_K5Gqs6i8HZZQ-1; Tue, 03 Feb 2026 08:37:57 -0500
X-MC-Unique: TOzyKncSN_K5Gqs6i8HZZQ-1
X-Mimecast-MFC-AGG-ID: TOzyKncSN_K5Gqs6i8HZZQ_1770125877
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-659444abe90so233984a12.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 05:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770125876; x=1770730676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtmJ0MecevVOkqmQ0sbIYbbzUt1IRFmbl82qHWlUp74=;
        b=Xotwh4wY+C0gmtsgZoesJSHdQkTzPve65vX+fhlNCtgqNAyfYnk93kbI4JXY3/UUbb
         Fg02PH6THa1QtMEWFvnVRMUjrvFoly+QAFMyy0S+bu/3DSWqaKVU5Y/I7spceJfA2xqu
         iFOs/ytg30t4P+2l6JVEyF6QTiGwUVgEfLnhMBtzXEg0t/C7rHgVfDnA3txrOJVeKZYE
         fbZ0D7Uzd4nyu7cmJ34R7rm7oGJtYrtXGlJuA9A7a/mdDb5JE6SJrlNo6hlim2/5nh58
         N4+ysGPSmm0iK/QK1tBYsduUt3xFqwYnQiBnCtKYGXLcS9fRlTEIYfUXtaIhpRDDmxQt
         j5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770125876; x=1770730676;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZtmJ0MecevVOkqmQ0sbIYbbzUt1IRFmbl82qHWlUp74=;
        b=C2Q3AygqkODpFQQO2KX3lHd/lbR3iAczM+fRB4nrtphaDbl43Xal56cD/dF5N4FXQD
         zPV4Aw0ACTAwt3QpqRVqNMZzfGKd3vNjlJod+1eZMXa1RPZU5S52vfamL7E5SzxIcTXA
         8DaAPkQ+ULR7g7tjZ459qID+bogu5UKFrODf6Hs3fcAbdMem4YlEb+15B9ANQqE2eey/
         9YEQDw1Se9wsgf32peCvm0rQ4xaJGMfXR/F+xicbQtcuLRREZo5IAcgMKUBeYNEn7SlB
         unO+6ti7Q+Iw9KMxLmfe2kAUDzCN4vyNsKgfPUCp3jFIMm6GNAZuO5ciXlvbMOv/rHAT
         //Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVKZQQgvt5nXMYCQ4x6bSqy7XFwuA9KfCaUdhFYvn0ldT3o6dHN1OkLVIeZgTidCsjT4g9eL+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh3hC1aTzbD5RFWjX8RlZdKZQ/xZQWPqDcwrXchpPS/eBIcTyO
	ah0+fZXI8uOlk5d8sdEXQZPBz186JZT5x7wLIaZ6KfbwPDM0KFT+dcEigQqEdSjO1qRphCXIW99
	iapQhwrfJq0IGV8SXFho+9JQKktN6k2STcA/qZbX7/Tw/jj0ZOnvQ37PSjA==
X-Gm-Gg: AZuq6aLEig/FyDMYCWI6UYUQvQ/WWofUwYc/IlRnGSc8tfwQsN+7tUK6COEA7omiCmz
	3Hbst+w+kqISX1yfS+iRPQGacihROWwXeZJvGFfMv9aPRHzoT/Ap00pkKUYsXA008dYn9fpj0Lr
	7YDGkSU4dWIWtIptbClBThupPqHdDxQjIC3/bm+h+N1HPR0+V/WLAVX1e11HgqBQSK11tTD3gqa
	WnQJLIpH0eUZW5hNVRIWz1k789UuMj0YyPwL7rHfn7DGXNAtPN9xudd46Po0fpTE4Bsg8LZfBdF
	EW6Fj6ctXD+MN055tygZ7BPFPuBzJT3HCsM+1hl6c5x0EnhbiWswp41m0eFeeXXX1UOGs/wyNJ9
	U0IBmrB8PgtWUZFNcm/nqahwFl2qPh8pfpQ==
X-Received: by 2002:a05:6402:520b:b0:64b:416a:cb48 with SMTP id 4fb4d7f45d1cf-658de5ac5b8mr9740671a12.19.1770125876451;
        Tue, 03 Feb 2026 05:37:56 -0800 (PST)
X-Received: by 2002:a05:6402:520b:b0:64b:416a:cb48 with SMTP id 4fb4d7f45d1cf-658de5ac5b8mr9740648a12.19.1770125875931;
        Tue, 03 Feb 2026 05:37:55 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b4691d0asm9527874a12.18.2026.02.03.05.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 05:37:55 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B21574D0E3A; Tue, 03 Feb 2026 14:37:54 +0100 (CET)
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
In-Reply-To: <aYHwDlDwN0ZniMev@soc-5CG4396X81.clients.intel.com>
References: <20260203105417.2302672-1-larysa.zaremba@intel.com>
 <20260203105417.2302672-2-larysa.zaremba@intel.com>
 <87zf5q109e.fsf@toke.dk>
 <aYHqtxtg3uNXO668@soc-5CG4396X81.clients.intel.com>
 <87o6m60zoo.fsf@toke.dk>
 <aYHwDlDwN0ZniMev@soc-5CG4396X81.clients.intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 03 Feb 2026 14:37:54 +0100
Message-ID: <87fr7i0wy5.fsf@toke.dk>
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
	TAGGED_FROM(0.00)[bounces-256296-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,lists.osuosl.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email];
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
X-Rspamd-Queue-Id: E9685DA197
X-Rspamd-Action: no action

Larysa Zaremba <larysa.zaremba@intel.com> writes:

> On Tue, Feb 03, 2026 at 01:38:47PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Larysa Zaremba <larysa.zaremba@intel.com> writes:
>>=20
>> > On Tue, Feb 03, 2026 at 01:26:21PM +0100, Toke H=C3=B8iland-J=C3=B8rge=
nsen wrote:
>> >> Larysa Zaremba <larysa.zaremba@intel.com> writes:
>> >>=20
>> >> > Many ethernet drivers report xdp Rx queue frag size as being the sa=
me as
>> >> > DMA write size. However, the only user of this field, namely
>> >> > bpf_xdp_frags_increase_tail(), clearly expects a truesize.
>> >> >
>> >> > Such difference leads to unspecific memory corruption issues under =
certain
>> >> > circumstances, e.g. in ixgbevf maximum DMA write size is 3 KB, so w=
hen
>> >> > running xskxceiver's XDP_ADJUST_TAIL_GROW_MULTI_BUFF, 6K packet ful=
ly uses
>> >> > all DMA-writable space in 2 buffers. This would be fine, if only
>> >> > rxq->frag_size was properly set to 4K, but value of 3K results in a
>> >> > negative tailroom, because there is a non-zero page offset.
>> >> >
>> >> > We could return -EINVAL and be done with it in such case, but due to
>> >> > tailroom being stored as an unsigned int, it is reported to be some=
where
>> >> > near UINT_MAX, resulting in a tail being grown, even if the request=
ed
>> >> > offset is too much (it is around 2K in the abovementioned test). Th=
is later
>> >> > leads to all kinds of unspecific calltraces.
>> >> >
>> >> > [ 7340.337579] xskxceiver[1440]: segfault at 1da718 ip 00007f4161ae=
ac9d sp 00007f41615a6a00 error 6
>> >> > [ 7340.338040] xskxceiver[1441]: segfault at 7f410000000b ip 000000=
00004042b5 sp 00007f415bffecf0 error 4
>> >> > [ 7340.338179]  in libc.so.6[61c9d,7f4161aaf000+160000]
>> >> > [ 7340.339230]  in xskxceiver[42b5,400000+69000]
>> >> > [ 7340.340300]  likely on CPU 6 (core 0, socket 6)
>> >> > [ 7340.340302] Code: ff ff 01 e9 f4 fe ff ff 0f 1f 44 00 00 4c 39 f=
0 74 73 31 c0 ba 01 00 00 00 f0 0f b1 17 0f 85 ba 00 00 00 49 8b 87 88 00 0=
0 00 <4c> 89 70 08 eb cc 0f 1f 44 00 00 48 8d bd f0 fe ff ff 89 85 ec fe
>> >> > [ 7340.340888]  likely on CPU 3 (core 0, socket 3)
>> >> > [ 7340.345088] Code: 00 00 00 ba 00 00 00 00 be 00 00 00 00 89 c7 e=
8 31 ca ff ff 89 45 ec 8b 45 ec 85 c0 78 07 b8 00 00 00 00 eb 46 e8 0b c8 f=
f ff <8b> 00 83 f8 69 74 24 e8 ff c7 ff ff 8b 00 83 f8 0b 74 18 e8 f3 c7
>> >> > [ 7340.404334] Oops: general protection fault, probably for non-can=
onical address 0x6d255010bdffc: 0000 [#1] SMP NOPTI
>> >> > [ 7340.405972] CPU: 7 UID: 0 PID: 1439 Comm: xskxceiver Not tainted=
 6.19.0-rc1+ #21 PREEMPT(lazy)
>> >> > [ 7340.408006] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.17.0-5.fc42 04/01/2014
>> >> > [ 7340.409716] RIP: 0010:lookup_swap_cgroup_id+0x44/0x80
>> >> > [ 7340.410455] Code: 83 f8 1c 73 39 48 ba ff ff ff ff ff ff ff 03 4=
8 8b 04 c5 20 55 fa bd 48 21 d1 48 89 ca 83 e1 01 48 d1 ea c1 e1 04 48 8d 0=
4 90 <8b> 00 48 83 c4 10 d3 e8 c3 cc cc cc cc 31 c0 e9 98 b7 dd 00 48 89
>> >> > [ 7340.412787] RSP: 0018:ffffcc5c04f7f6d0 EFLAGS: 00010202
>> >> > [ 7340.413494] RAX: 0006d255010bdffc RBX: ffff891f477895a8 RCX: 000=
0000000000010
>> >> > [ 7340.414431] RDX: 0001c17e3fffffff RSI: 00fa070000000000 RDI: 000=
382fc7fffffff
>> >> > [ 7340.415354] RBP: 00fa070000000000 R08: ffffcc5c04f7f8f8 R09: fff=
fcc5c04f7f7d0
>> >> > [ 7340.416283] R10: ffff891f4c1a7000 R11: ffffcc5c04f7f9c8 R12: fff=
fcc5c04f7f7d0
>> >> > [ 7340.417218] R13: 03ffffffffffffff R14: 00fa06fffffffe00 R15: fff=
f891f47789500
>> >> > [ 7340.418229] FS:  0000000000000000(0000) GS:ffff891ffdfaa000(0000=
) knlGS:0000000000000000
>> >> > [ 7340.419489] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> >> > [ 7340.420286] CR2: 00007f415bfffd58 CR3: 0000000103f03002 CR4: 000=
0000000772ef0
>> >> > [ 7340.421237] PKRU: 55555554
>> >> > [ 7340.421623] Call Trace:
>> >> > [ 7340.421987]  <TASK>
>> >> > [ 7340.422309]  ? softleaf_from_pte+0x77/0xa0
>> >> > [ 7340.422855]  swap_pte_batch+0xa7/0x290
>> >> > [ 7340.423363]  zap_nonpresent_ptes.constprop.0.isra.0+0xd1/0x270
>> >> > [ 7340.424102]  zap_pte_range+0x281/0x580
>> >> > [ 7340.424607]  zap_pmd_range.isra.0+0xc9/0x240
>> >> > [ 7340.425177]  unmap_page_range+0x24d/0x420
>> >> > [ 7340.425714]  unmap_vmas+0xa1/0x180
>> >> > [ 7340.426185]  exit_mmap+0xe1/0x3b0
>> >> > [ 7340.426644]  __mmput+0x41/0x150
>> >> > [ 7340.427098]  exit_mm+0xb1/0x110
>> >> > [ 7340.427539]  do_exit+0x1b2/0x460
>> >> > [ 7340.427992]  do_group_exit+0x2d/0xc0
>> >> > [ 7340.428477]  get_signal+0x79d/0x7e0
>> >> > [ 7340.428957]  arch_do_signal_or_restart+0x34/0x100
>> >> > [ 7340.429571]  exit_to_user_mode_loop+0x8e/0x4c0
>> >> > [ 7340.430159]  do_syscall_64+0x188/0x6b0
>> >> > [ 7340.430672]  ? __do_sys_clone3+0xd9/0x120
>> >> > [ 7340.431212]  ? switch_fpu_return+0x4e/0xd0
>> >> > [ 7340.431761]  ? arch_exit_to_user_mode_prepare.isra.0+0xa1/0xc0
>> >> > [ 7340.432498]  ? do_syscall_64+0xbb/0x6b0
>> >> > [ 7340.433015]  ? __handle_mm_fault+0x445/0x690
>> >> > [ 7340.433582]  ? count_memcg_events+0xd6/0x210
>> >> > [ 7340.434151]  ? handle_mm_fault+0x212/0x340
>> >> > [ 7340.434697]  ? do_user_addr_fault+0x2b4/0x7b0
>> >> > [ 7340.435271]  ? clear_bhb_loop+0x30/0x80
>> >> > [ 7340.435788]  ? clear_bhb_loop+0x30/0x80
>> >> > [ 7340.436299]  ? clear_bhb_loop+0x30/0x80
>> >> > [ 7340.436812]  ? clear_bhb_loop+0x30/0x80
>> >> > [ 7340.437323]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> >> > [ 7340.437973] RIP: 0033:0x7f4161b14169
>> >> > [ 7340.438468] Code: Unable to access opcode bytes at 0x7f4161b1413=
f.
>> >> > [ 7340.439242] RSP: 002b:00007ffc6ebfa770 EFLAGS: 00000246 ORIG_RAX=
: 00000000000000ca
>> >> > [ 7340.440173] RAX: fffffffffffffe00 RBX: 00000000000005a1 RCX: 000=
07f4161b14169
>> >> > [ 7340.441061] RDX: 00000000000005a1 RSI: 0000000000000109 RDI: 000=
07f415bfff990
>> >> > [ 7340.441943] RBP: 00007ffc6ebfa7a0 R08: 0000000000000000 R09: 000=
00000ffffffff
>> >> > [ 7340.442824] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
0000000000000
>> >> > [ 7340.443707] R13: 0000000000000000 R14: 00007f415bfff990 R15: 000=
07f415bfff6c0
>> >> > [ 7340.444586]  </TASK>
>> >> > [ 7340.444922] Modules linked in: rfkill intel_rapl_msr intel_rapl_=
common intel_uncore_frequency_common skx_edac_common nfit libnvdimm kvm_int=
el vfat fat kvm snd_pcm irqbypass rapl iTCO_wdt snd_timer intel_pmc_bxt iTC=
O_vendor_support snd ixgbevf virtio_net soundcore i2c_i801 pcspkr libeth_xd=
p net_failover i2c_smbus lpc_ich failover libeth virtio_balloon joydev 9p f=
use loop zram lz4hc_compress lz4_compress 9pnet_virtio 9pnet netfs ghash_cl=
mulni_intel serio_raw qemu_fw_cfg
>> >> > [ 7340.449650] ---[ end trace 0000000000000000 ]---
>> >> >
>> >> > The issue can be fixed in all in-tree drivers, but we cannot just t=
rust OOT
>> >> > drivers to not do this. Therefore, make tailroom a signed int and p=
roduce a
>> >> > warning when it is negative to prevent such mistakes in the future.
>> >> >
>> >> > Fixes: bf25146a5595 ("bpf: add frags support to the bpf_xdp_adjust_=
tail() API")
>> >> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> >> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
>> >> > ---
>> >> >  net/core/filter.c | 3 ++-
>> >> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/net/core/filter.c b/net/core/filter.c
>> >> > index 616e0520a0bb..9715d957e3c5 100644
>> >> > --- a/net/core/filter.c
>> >> > +++ b/net/core/filter.c
>> >> > @@ -4149,12 +4149,13 @@ static int bpf_xdp_frags_increase_tail(stru=
ct xdp_buff *xdp, int offset)
>> >> >  	struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(x=
dp);
>> >> >  	skb_frag_t *frag =3D &sinfo->frags[sinfo->nr_frags - 1];
>> >> >  	struct xdp_rxq_info *rxq =3D xdp->rxq;
>> >> > -	unsigned int tailroom;
>> >> > +	int tailroom;
>> >> >=20=20
>> >> >  	if (!rxq->frag_size || rxq->frag_size > xdp->frame_sz)
>> >> >  		return -EOPNOTSUPP;
>> >> >=20=20
>> >> >  	tailroom =3D rxq->frag_size - skb_frag_size(frag) - skb_frag_off(=
frag);
>> >> > +	WARN_ON_ONCE(tailroom < 0);
>> >> >  	if (unlikely(offset > tailroom))
>> >> >  		return -EINVAL;
>> >> >=20=20
>> >>=20
>> >> Why can't we do both? I.e., WARN_ON_ONCE() *and* return -EINVAL?
>> >>=20
>> >> -Toke
>> >>=20
>> >
>> > It would be redundant, offset is always >=3D 0 here, so with tailroom =
now being a=20
>> > signed int, offset is always bigger and -EINVAL is returned.
>>=20
>> Oh, I see. OK, may be worth calling out; I read this paragraph in your
>> commit message to mean "we don't bother returning EINVAL in this case,
>> we just warn":
>
> Worth changing 'could' to 'are supposed to', if there will be v2.

Yeah, that would be better, thanks!

Other than that,

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


