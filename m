Return-Path: <netdev+bounces-90578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6608AE8CB
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 15:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8821C2143A
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C00136E07;
	Tue, 23 Apr 2024 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7z5+3jX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE23135414
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880630; cv=none; b=O/qkX6reKfdc6Cxh/5bV4SV13Quu4UaacSWhRgx80sho2Jq4pisp7KaaEzfRp+xTvpnLrXiTev27yjRX68tnMKOBFqPMehgKsGsWgahkWFQ+OsSPFV3px3S0BVJiE+NMVVvLOr7/RzpPwXMuIwd7AWwdhuSnn5AOfA/pCDVHPr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880630; c=relaxed/simple;
	bh=CqQcnm6wIIDRAWq3qsa9KUK4TMHUOqvVmU/P3kdaNj4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BZEnEPADRDvgqTFBWM25gsjD9tj5WwsutSi6hMfRhRIMq/8U8HmUs1WhbWMz64Xu5e23PNbICS4FFNBrqqkUkmLXGTmC2MIEDQFzDFocBgjbbMbqYyfVODrXkSPekFK9D+W5GyjdzaAbVXjfh2TkVF+1M6FSRrOLxGxoghDdSds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M7z5+3jX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713880627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s6W1B/kXfqUFXSdSIZbAmneyvU7EfoNGHSZoiDPzmX4=;
	b=M7z5+3jXpoVU98SekmFoSnbxo6iYddi8b22G5ZiFY8jbu5tCWa2wULmCZHuPhmayxTdZIs
	CZPhefQDiyl0OOIirijvzyscT049p5po3IXog2xJ9dBXEjmkNXew1SZ8BAD+kd1wyrRFNw
	M4fA1amn7hilfm0e9Vx3yTA4AgrApC0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-StRONN_tOVuoH_mGB_0yDA-1; Tue, 23 Apr 2024 09:57:06 -0400
X-MC-Unique: StRONN_tOVuoH_mGB_0yDA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-349a31b3232so760253f8f.2
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 06:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713880625; x=1714485425;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s6W1B/kXfqUFXSdSIZbAmneyvU7EfoNGHSZoiDPzmX4=;
        b=OLXwnGwFBGPLY6JQX0A0WYsy4Vi7OGRQuZsXvOpKEZGtS457a5FhIGNQfHYy1i4P5g
         xTcIXLyspJ7OF7KoSLmaAERB5WywLZU8EluFIkqRxwsGtoJdCJS/m8ftnLdHgKdYNvTs
         QmJRgkJmKc5Wp7m72BHAETHpvLMKxphp2Pa3BD8RPT/bdAPEj4aUonVFGJDdI2XJS/1A
         Bm5h91l+hEnloCziK1jwuqYsIbK1nvhDI4EkGfBF3Um+Fnj9lgYPQgrrTEI0swFBnG0t
         xLM19C1oiSFCyO2YjdIMKdx1umQSAMZu8dOucZG74Cr6l1dME4MyrL5REr6g2yN03JdF
         bDSg==
X-Forwarded-Encrypted: i=1; AJvYcCXyjnfHRmC2/N4bH6oeZ8zSE+YA4LHhAEOqioSPJuSzNkmc9IeQOcZ9inRCRq42uSfuYcs7CObAFjj/o1pMaHN4KZkpXcRa
X-Gm-Message-State: AOJu0YzcfiKoSnBtSOlZf/nuMTz8u1yxFVEkX/ijpHXg0sWWD9y9ZL+9
	053ZyUUjWLNVTxniHy40U5WXU3qjVMVuj8ipy1SlyebWzIgRUq11tp0f4YKVguzdLDtcLfE4Hgt
	M+x0rBVtDjNVc+wZW1VutNEmnDnST0DHyHU3kH4M7Yh+AMwvUvobzXlGZWHW2Qg==
X-Received: by 2002:a05:600c:1c90:b0:41a:b9a1:3ecc with SMTP id k16-20020a05600c1c9000b0041ab9a13eccmr1309134wms.3.1713880624862;
        Tue, 23 Apr 2024 06:57:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDBgPTQ0Qklcw6sB9Gf5q6QwteCm+9hlG7CTfM/eVuXyOMWiyPxZEaWunkkXvqoYnEcP6wjw==
X-Received: by 2002:a05:600c:1c90:b0:41a:b9a1:3ecc with SMTP id k16-20020a05600c1c9000b0041ab9a13eccmr1309126wms.3.1713880624474;
        Tue, 23 Apr 2024 06:57:04 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:172c:4510::f71])
        by smtp.gmail.com with ESMTPSA id s7-20020a05600c45c700b0041aa570bcd3sm3260236wmo.35.2024.04.23.06.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 06:57:03 -0700 (PDT)
Message-ID: <3a6412ee6a4faf6f6107217c67ef5aad9532f89a.camel@redhat.com>
Subject: Re: [PATCH net] ipv4: check for NULL idev in ip_route_use_hint()
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
Date: Tue, 23 Apr 2024 15:57:02 +0200
In-Reply-To: <20240421184326.1704930-1-edumazet@google.com>
References: <20240421184326.1704930-1-edumazet@google.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-04-21 at 18:43 +0000, Eric Dumazet wrote:
> syzbot was able to trigger a NULL deref in fib_validate_source()
> in an old tree [1].
>=20
> It appears the bug exists in latest trees.
>=20
> All calls to __in_dev_get_rcu() must be checked for a NULL result.
>=20
> [1]
> general protection fault, probably for non-canonical address 0xdffffc0000=
000000: 0000 [#1] SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 2 PID: 3257 Comm: syz-executor.3 Not tainted 5.10.0-syzkaller #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
>  RIP: 0010:fib_validate_source+0xbf/0x15a0 net/ipv4/fib_frontend.c:425
> Code: 18 f2 f2 f2 f2 42 c7 44 20 23 f3 f3 f3 f3 48 89 44 24 78 42 c6 44 2=
0 27 f3 e8 5d 88 48 fc 4c 89 e8 48 c1 e8 03 48 89 44 24 18 <42> 80 3c 20 00=
 74 08 4c 89 ef e8 d2 15 98 fc 48 89 5c 24 10 41 bf
> RSP: 0018:ffffc900015fee40 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff88800f7a4000 RCX: ffff88800f4f90c0
> RDX: 0000000000000000 RSI: 0000000004001eac RDI: ffff8880160c64c0
> RBP: ffffc900015ff060 R08: 0000000000000000 R09: ffff88800f7a4000
> R10: 0000000000000002 R11: ffff88800f4f90c0 R12: dffffc0000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff88800f7a4000
> FS:  00007f938acfe6c0(0000) GS:ffff888058c00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f938acddd58 CR3: 000000001248e000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   ip_route_use_hint+0x410/0x9b0 net/ipv4/route.c:2231
>   ip_rcv_finish_core+0x2c4/0x1a30 net/ipv4/ip_input.c:327
>   ip_list_rcv_finish net/ipv4/ip_input.c:612 [inline]
>   ip_sublist_rcv+0x3ed/0xe50 net/ipv4/ip_input.c:638
>   ip_list_rcv+0x422/0x470 net/ipv4/ip_input.c:673
>   __netif_receive_skb_list_ptype net/core/dev.c:5572 [inline]
>   __netif_receive_skb_list_core+0x6b1/0x890 net/core/dev.c:5620
>   __netif_receive_skb_list net/core/dev.c:5672 [inline]
>   netif_receive_skb_list_internal+0x9f9/0xdc0 net/core/dev.c:5764
>   netif_receive_skb_list+0x55/0x3e0 net/core/dev.c:5816
>   xdp_recv_frames net/bpf/test_run.c:257 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:335 [inline]
>   bpf_test_run_xdp_live+0x1818/0x1d00 net/bpf/test_run.c:363
>   bpf_prog_test_run_xdp+0x81f/0x1170 net/bpf/test_run.c:1376
>   bpf_prog_test_run+0x349/0x3c0 kernel/bpf/syscall.c:3736
>   __sys_bpf+0x45c/0x710 kernel/bpf/syscall.c:5115
>   __do_sys_bpf kernel/bpf/syscall.c:5201 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5199 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5199
>=20
> Fixes: 02b24941619f ("ipv4: use dst hint for ipv4 list receive")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Thanks for fixing it!

Acked-by: Paolo Abeni <pabeni@redhat.com>

syzbot took surprisingly long to spot this, I guess the race window is
very tiny? (or syzbot learned new tricks...)

Cheers,

Paolo


