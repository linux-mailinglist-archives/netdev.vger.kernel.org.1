Return-Path: <netdev+bounces-179703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E40A7E36B
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EEA6440085
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 15:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725CC1F8AC5;
	Mon,  7 Apr 2025 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMDak6Nr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755041F8BAA
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744037969; cv=none; b=ENTXCJ97UFXxhFjPjn8X4lFFBb8rSaoRW/Fn7KIBWR/KaIZUXoiS7o7ylSSzS75MFB4mXxSuNoeYFsGWSicoJ24NJB2ictYATWo0pBhj62Su1JCc8J8uk7ofXmZ32B8VbNa95J6KZl8YruiTBKjUh3ERg4iurnXsjJs+opU3Vw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744037969; c=relaxed/simple;
	bh=kZuHZ+0loOCA/2m6muM5dN6rIKUmLHS0ad/Ky7Juru4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FNGZeTD0DdALFpk/WV2RXxoI56GUQe+4u0RAztuQXnXN88ruEI6VmFkCA2sVPcJtHCZYORawnbfN3nL91XUD7PSnqgpnb2oOO6tCmG+emuMzh5xq5mYebZ0T4aH5MAgh9PotQNDQXvcnu1t59YL9PAbG6+Gc7Nw1Nbo+2V4EvL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMDak6Nr; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8ec399427so37579376d6.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 07:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744037966; x=1744642766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihPzZ5jJ9Vi744c9LkGZDR4f1HOBQyJ2c6amNCfadao=;
        b=YMDak6NrG01A9uXB/py0u9GUJjEC63pcbbBaleO4LoYKw0jsMJNjGjNC9xb++uDI1U
         4vRBYYSSX2EtKVvMhoWBgM1mgcFLP1Z0azrwT3argz1BL5vHR/fTtK4nTVXyXGvAgJ81
         TE8idcM6eyQv0oxqFqyMQaxmwAJUrwr9pfKO/whBWGaqAjBIH90bgOh+F9BqtwDVUq6j
         sGDZcqwBhHuiXF0kVmn67pcY5FRP9D0X08nHuGDNQ9yH/SQTGB6eHctOnB5HfeN1NStO
         BF1Ahg8bI1RRPSmIE91m+waeiluA78MbTBDH/aCLj8j05ybzR4MzMzweY12285jr2mBm
         O7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744037966; x=1744642766;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ihPzZ5jJ9Vi744c9LkGZDR4f1HOBQyJ2c6amNCfadao=;
        b=aLMnRDYNVz492KC1c/x6Vb0Fpownj68q1c10qFKOg1+V4mm4Iga8d6hMag1JtkKIf/
         ubwwWht+cOdUASUZmHTp6guAT0V1kcMhThzcwbwdkZoZ83SVWfYJPDu5/HoZhehoxTyn
         144m5AdVTGa1FTRJjuX3gmap9qXO/g2L052UU6HHbMGy39crpR46aIgpzspWpB9M59NQ
         N2Vd0fg0I2jZb1ZzgcsYPhEUejzlHVfppWczDhF21/zG9IbaXLCkabjFLJW7oLyMu+oq
         ndkNhYn3bOU5y5t/0c2MctUPzkrLTgXf1G3oTIzgTqmI43VQ5AYqwjSypIjHschzdpxa
         NRRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBo4ZZkY1irqR0a9NkUT/JsHkWFBWBQY4mGz0PPBiL9Kefx8FfsBWDq79woaDUe0PkEP8xpHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEynMoDUopCUVjkDozxqYuyYxZsV0mZ1o4HKkAMcsMItIfB2Sb
	Uyk/wGQr4Izm3eu/6D04H9OAWGRe/VctNf1jWQa2iePSdVi1WlU5
X-Gm-Gg: ASbGnctk7yL+w7pkGIrbbnRvMyO7EDXAaL9b1DDIdlXMon1T6wMGMhX+lQy18R/Rwwj
	4kH3Oo1/WTUEaL9CaJ+RwuQfK0OLL19Xv5zLjap47g17rkYmRQMMqixv9zVYfzgEVIQWP93Lb0p
	pDEbdULD2GRHUDp9pUlg5whRSe3Mj5gstV4F+DtyEzdmDKWt3CVIN5w19J6K4h//BAMkC4v1/iS
	nN6anhA9buHW3PNDUpVH7QAMHnlDeUbinxsi6wZ//DaGDJ8imPQQxV10EsEow8OctmGx2Q/Wii8
	4U9ggd8liewM6n5hwqjJ57OMaDjHXlqDLG8msRXCfPDb7MOSCGqBa700VkTSZDmPv0kp6CkvcqV
	73EwIeB0XVM87iObj+s+zrg==
X-Google-Smtp-Source: AGHT+IG8gmN7rp7V26rOMIYis9IRAcJfHIcu/feMysVr+u1Z02XpV9ATG2soGUZypZG7U4y55/2ZbQ==
X-Received: by 2002:a05:6214:622:b0:6e6:61f1:458a with SMTP id 6a1803df08f44-6f0b7449965mr110816786d6.14.1744037965843;
        Mon, 07 Apr 2025 07:59:25 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f00e585sm59575546d6.27.2025.04.07.07.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 07:59:25 -0700 (PDT)
Date: Mon, 07 Apr 2025 10:59:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Qiyu Yan <yanqiyu01@gmail.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org
Message-ID: <67f3e84d8304_38ecd3294aa@willemb.c.googlers.com.notmuch>
In-Reply-To: <36566e86-57df-40f3-80ff-7833f930311d@gmail.com>
References: <36566e86-57df-40f3-80ff-7833f930311d@gmail.com>
Subject: Re: [bug?] "hw csum failure" warning triggered on veth interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Qiyu Yan wrote:
> Dear linux network maintainers,
> =

> I'm encountering consistent |hw csum failure| warnings during system =

> boot. Here's an example from a recent log (running stock kernel =

> 6.14.0-63.fc42.x86_64 from Fedora 42 pre-release):
> =

> [=C2=A0 =C2=A074.128126] (NULL net_device): hw csum failure
> [=C2=A0 =C2=A074.128149] skb len=3D545 headroom=3D98 headlen=3D545 tail=
room=3D61
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mac=3D(64,14) m=
ac_len=3D14 net=3D(78,20) trans=3D98
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shinfo(txflags=3D=
0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=3D0))
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0csum(0x9edfcad =
start=3D64685 offset=3D2541 ip_summed=3D2 =

> complete_sw=3D0 valid=3D0 level=3D0)
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hash(0x5c58e98 =
sw=3D0 l4=3D1) proto=3D0x0800 pkttype=3D0 iif=3D3
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0priority=3D0x0 =
mark=3D0x0 alloc_cpu=3D26 vlan_all=3D0x0
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0encapsulation=3D=
0 inner(proto=3D0x0000, mac=3D0, net=3D0, trans=3D0)
> [=C2=A0 =C2=A074.128178] skb headroom: 00000000: 00 00 00 00 00 00 00 0=
0 00 00 00 =

> 00 00 00 00 00
> [=C2=A0 =C2=A074.128188] skb headroom: 00000010: 00 00 00 00 00 00 00 0=
0 00 00 00 =

> 00 00 00 00 00
> [=C2=A0 =C2=A074.128197] skb headroom: 00000020: 00 00 00 00 00 00 00 0=
0 00 00 00 =

> 00 00 00 00 00
> [=C2=A0 =C2=A074.128205] skb headroom: 00000030: 00 00 00 00 00 00 00 0=
0 00 00 00 =

> 00 00 00 00 00
> [=C2=A0 =C2=A074.128214] skb headroom: 00000040: 72 30 8d ae 4f 32 e2 a=
4 be b5 59 =

> db 08 00 45 00
> [=C2=A0 =C2=A074.128222] skb headroom: 00000050: 02 35 d2 65 40 00 33 0=
6 da 7e a3 =

> 7d eb 05 0a 58
> [=C2=A0 =C2=A074.128230] skb headroom: 00000060: 00 04
> [=C2=A0 =C2=A074.128239] skb linear:=C2=A0 =C2=A000000000: e5 80 72 46 =
8c 57 20 0f af 05 eb =

> 53 50 18 04 04
> [=C2=A0 =C2=A074.128247] skb linear:=C2=A0 =C2=A000000010: c3 91 00 00 =
4b 75 31 58 8e c6 71 =

> 48 84 68 65 07
> [=C2=A0 =C2=A074.128255] skb linear:=C2=A0 =C2=A000000020: fe a6 6f e7 =
cd 8c 64 a0 4e f6 2b =

> f3 eb 61 d7 68
> [=C2=A0 =C2=A074.128263] skb linear:=C2=A0 =C2=A000000030: 8e a9 0f b6 =
67 66 be 92 c1 11 f9 =

> 72 58 38 21 1e
> [=C2=A0 =C2=A074.128271] skb linear:=C2=A0 =C2=A000000040: c3 93 b6 3d =
73 ec 70 46 a6 cf 56 =

> e6 c2 eb 02 26
> [=C2=A0 =C2=A074.128280] skb linear:=C2=A0 =C2=A000000050: 1e 61 9c 28 =
70 15 b3 d3 8f ba e4 =

> b0 7f b7 3a 43
> [=C2=A0 =C2=A074.128288] skb linear:=C2=A0 =C2=A000000060: 5f 18 6e d2 =
1c 1a 6d 31 f1 02 70 =

> 01 3e b8 b8 da
> [=C2=A0 =C2=A074.128296] skb linear:=C2=A0 =C2=A000000070: ed 17 c8 be =
1c ae 94 c0 90 54 e2 =

> 5d 6b f0 c4 d1
> [=C2=A0 =C2=A074.128303] skb linear:=C2=A0 =C2=A000000080: 02 96 d1 e8 =
3e 9a df b3 42 a3 c6 =

> 36 4d 01 67 61
> [=C2=A0 =C2=A074.128311] skb linear:=C2=A0 =C2=A000000090: e2 41 ed 42 =
27 fe 53 78 8c fa 27 =

> eb ac 6d 8d ba
> [=C2=A0 =C2=A074.128319] skb linear:=C2=A0 =C2=A0000000a0: 78 9c 86 75 =
92 ae 72 8d f7 bb d4 =

> 08 e1 27 56 79
> [=C2=A0 =C2=A074.128327] skb linear:=C2=A0 =C2=A0000000b0: ec 2e 0d 30 =
77 bf fd ae 4d 8e e0 =

> 5c 85 65 23 7c
> [=C2=A0 =C2=A074.128334] skb linear:=C2=A0 =C2=A0000000c0: a6 ba 32 5f =
0f 87 f5 d8 96 56 9a =

> f2 70 9b 96 de
> [=C2=A0 =C2=A074.128342] skb linear:=C2=A0 =C2=A0000000d0: 51 47 e6 2f =
d3 9a 9b 4a 1c 39 95 =

> 17 bb 80 8f fd
> [=C2=A0 =C2=A074.128349] skb linear:=C2=A0 =C2=A0000000e0: d4 19 5c 0e =
7d ce 6f 7e 67 9b a1 =

> 5a c1 08 2f 76
> [=C2=A0 =C2=A074.128357] skb linear:=C2=A0 =C2=A0000000f0: 59 b6 02 a8 =
05 37 34 33 41 22 cf =

> 86 19 67 d8 27
> [=C2=A0 =C2=A074.128364] skb linear:=C2=A0 =C2=A000000100: 4a e1 8c ea =
a4 2a e9 66 b2 b3 70 =

> a9 9d 14 2a 2b
> [=C2=A0 =C2=A074.128373] skb linear:=C2=A0 =C2=A000000110: 4e a0 e9 01 =
d3 3d d0 53 04 73 15 =

> 10 66 c2 06 e0
> [=C2=A0 =C2=A074.128380] skb linear:=C2=A0 =C2=A000000120: 4f 39 4a 5b =
4b 44 6a 78 bf c6 90 =

> 48 cc 67 8e e4
> [=C2=A0 =C2=A074.128388] skb linear:=C2=A0 =C2=A000000130: 76 30 21 a4 =
06 55 77 91 ac 51 f0 =

> 1d 69 38 22 12
> [=C2=A0 =C2=A074.128396] skb linear:=C2=A0 =C2=A000000140: 2c 49 1f c9 =
3c c3 fa 9c d5 fb 87 =

> 9d 16 aa 63 89
> [=C2=A0 =C2=A074.128403] skb linear:=C2=A0 =C2=A000000150: 1b 8b 34 f7 =
66 26 32 d5 83 e6 e7 =

> 15 eb 72 32 a4
> [=C2=A0 =C2=A074.128411] skb linear:=C2=A0 =C2=A000000160: 2a 3a 92 9c =
3d 50 a1 ba 3e 7a df =

> 12 43 85 b1 01
> [=C2=A0 =C2=A074.128418] skb linear:=C2=A0 =C2=A000000170: 83 dc aa 64 =
ba 59 08 07 cf 5a 82 =

> 61 b4 18 41 7e
> [=C2=A0 =C2=A074.128426] skb linear:=C2=A0 =C2=A000000180: 8f 34 2c 3c =
17 93 68 ba 40 6c 1f =

> 0e 1a 9f 81 36
> [=C2=A0 =C2=A074.128434] skb linear:=C2=A0 =C2=A000000190: f6 49 09 51 =
cc 95 02 10 d9 d5 49 =

> 67 8c d1 54 88
> [=C2=A0 =C2=A074.128442] skb linear:=C2=A0 =C2=A0000001a0: a3 5e 73 11 =
92 33 56 84 24 f9 d0 =

> f9 64 a1 da 0f
> [=C2=A0 =C2=A074.128449] skb linear:=C2=A0 =C2=A0000001b0: be fa db 28 =
62 83 27 d6 e9 7e c5 =

> 90 3b 45 75 aa
> [=C2=A0 =C2=A074.128457] skb linear:=C2=A0 =C2=A0000001c0: b0 e1 f1 84 =
75 d9 74 01 32 48 79 =

> 3a e9 32 c5 74
> [=C2=A0 =C2=A074.128465] skb linear:=C2=A0 =C2=A0000001d0: 22 18 a7 50 =
45 ca 7f 42 47 7d 7d =

> 44 88 1d ab cc
> [=C2=A0 =C2=A074.128472] skb linear:=C2=A0 =C2=A0000001e0: fc e5 2e fb =
8a 2c c9 17 b1 82 a2 =

> 3b 71 fb 49 4d
> [=C2=A0 =C2=A074.128480] skb linear:=C2=A0 =C2=A0000001f0: 69 cb f6 31 =
3d 13 12 3c 3a fb f9 =

> ec 3d 01 ff d6
> [=C2=A0 =C2=A074.128488] skb linear:=C2=A0 =C2=A000000200: d0 91 b1 df =
97 d5 5d af eb ce d4 =

> 63 c4 a4 6e 82
> [=C2=A0 =C2=A074.128496] skb linear:=C2=A0 =C2=A000000210: dc 3a 4f 33 =
11 06 e9 ad 0b 20 c2 =

> ee 20 98 77 b0
> [=C2=A0 =C2=A074.128504] skb linear:=C2=A0 =C2=A000000220: 74
> [=C2=A0 =C2=A074.128511] skb tailroom: 00000000: 00 00 00 00 00 00 00 0=
0 00 00 00 =

> 00 00 00 00 00
> [=C2=A0 =C2=A074.128519] skb tailroom: 00000010: 00 00 00 00 00 00 00 0=
0 00 00 00 =

> 00 00 00 00 00
> [=C2=A0 =C2=A074.128527] skb tailroom: 00000020: 00 00 00 00 00 00 00 0=
0 00 00 00 =

> 00 00 00 00 00
> [=C2=A0 =C2=A074.128534] skb tailroom: 00000030: 00 00 00 00 00 00 00 0=
0 00 00 00 =

> 00 00
> [=C2=A0 =C2=A074.128545] CPU: 26 UID: 0 PID: 0 Comm: swapper/26 Tainted=
: G =C2=A0 =C2=A0 =C2=A0 =C2=A0 =

>  =C2=A0OE=C2=A0 =C2=A0 =C2=A0-------=C2=A0 ---=C2=A0 6.14.0-63.fc42.x86=
_64 #1
> [=C2=A0 =C2=A074.128554] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODU=
LE
> [=C2=A0 =C2=A074.128557] Hardware name: To Be Filled By O.E.M. To Be Fi=
lled By =

> O.E.M./EPYCD8, BIOS L2.52 11/25/2020
> [=C2=A0 =C2=A074.128562] Call Trace:
> [=C2=A0 =C2=A074.128567]=C2=A0 <IRQ>
> [=C2=A0 =C2=A074.128579]=C2=A0 dump_stack_lvl+0x5d/0x80
> [=C2=A0 =C2=A074.128594]=C2=A0 __skb_checksum_complete+0xe8/0x100
> [=C2=A0 =C2=A074.128605]=C2=A0 ? __pfx_csum_partial_ext+0x10/0x10
> [=C2=A0 =C2=A074.128611]=C2=A0 ? __pfx_csum_block_add_ext+0x10/0x10
> [=C2=A0 =C2=A074.128620]=C2=A0 tcp_rcv_established+0x4da/0x770
> [=C2=A0 =C2=A074.128634]=C2=A0 tcp_v4_do_rcv+0x165/0x2b0
> [=C2=A0 =C2=A074.128643]=C2=A0 tcp_v4_rcv+0xc72/0xf40
> [=C2=A0 =C2=A074.128655]=C2=A0 ip_protocol_deliver_rcu+0x33/0x190
> [=C2=A0 =C2=A074.128664]=C2=A0 ip_local_deliver_finish+0x76/0xa0
> [=C2=A0 =C2=A074.128671]=C2=A0 ip_local_deliver+0xf6/0x100
> [=C2=A0 =C2=A074.128682]=C2=A0 __netif_receive_skb_one_core+0x87/0xa0
> [=C2=A0 =C2=A074.128693]=C2=A0 process_backlog+0x87/0x130
> [=C2=A0 =C2=A074.128703]=C2=A0 __napi_poll+0x2b/0x160
> [=C2=A0 =C2=A074.128713]=C2=A0 net_rx_action+0x333/0x420
> [=C2=A0 =C2=A074.128737]=C2=A0 handle_softirqs+0xf2/0x340
> [=C2=A0 =C2=A074.128747]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [=C2=A0 =C2=A074.128760]=C2=A0 __irq_exit_rcu+0xc2/0xe0
> [=C2=A0 =C2=A074.128768]=C2=A0 common_interrupt+0x85/0xa0
> [=C2=A0 =C2=A074.128777]=C2=A0 </IRQ>
> [=C2=A0 =C2=A074.128779]=C2=A0 <TASK>
> [=C2=A0 =C2=A074.128783]=C2=A0 asm_common_interrupt+0x26/0x40
> [=C2=A0 =C2=A074.128792] RIP: 0010:cpuidle_enter_state+0xcc/0x660
> [=C2=A0 =C2=A074.128799] Code: 00 00 e8 d7 23 00 ff e8 62 ee ff ff 49 8=
9 c4 0f 1f =

> 44 00 00 31 ff e8 03 6c fe fe 45 84 ff 0f 85 02 02 00 00 fb 0f 1f 44 00=
 =

> 00 <85> ed 0f 88 d3 01 00 00 4c 63 f5 49 83 fe 0a 0f 83 9f 04 00 00 49
> [=C2=A0 =C2=A074.128803] RSP: 0018:ffffb8bd003dfe58 EFLAGS: 00000246
> [=C2=A0 =C2=A074.128809] RAX: ffff9ecb4cd00000 RBX: ffff9eac82e5a800 RC=
X: =

> 0000000000000000
> [=C2=A0 =C2=A074.128813] RDX: 00000011426107f1 RSI: 000000003152c088 RD=
I: =

> 0000000000000000
> [=C2=A0 =C2=A074.128817] RBP: 0000000000000002 R08: 00000000000d5a5c R0=
9: =

> 0000000000000001
> [=C2=A0 =C2=A074.128820] R10: 0000000000000003 R11: ffff9ecb4cd217c0 R1=
2: =

> 00000011426107f1
> [=C2=A0 =C2=A074.128823] R13: ffffffffb8b15140 R14: 0000000000000002 R1=
5: =

> 0000000000000000
> [=C2=A0 =C2=A074.128841]=C2=A0 ? cpuidle_enter_state+0xbd/0x660
> [=C2=A0 =C2=A074.128853]=C2=A0 cpuidle_enter+0x2d/0x40
> [=C2=A0 =C2=A074.128864]=C2=A0 cpuidle_idle_call+0xf2/0x160
> [=C2=A0 =C2=A074.128875]=C2=A0 do_idle+0x78/0xd0
> [=C2=A0 =C2=A074.128883]=C2=A0 cpu_startup_entry+0x29/0x30
> [=C2=A0 =C2=A074.128890]=C2=A0 start_secondary+0x12d/0x160
> [=C2=A0 =C2=A074.128901]=C2=A0 common_startup_64+0x13e/0x141
> [=C2=A0 =C2=A074.128918]=C2=A0 </TASK>
> =

> What caught my attention is that iif=3D3 points to an interface that is=
 =

> not connected to the outside and, as far as I can tell, should not be a=
 =

> source of any errors.
> =

> Through testing, I've observed the following:
> =

>  1. Disabling all Podman containers eliminates the warning.
>  2. Disabling only containers using macvlan/ipvlan (while leaving other=
s
>     running) still triggers the warning.
>  3. Booting with a limited number of containers also reproduces the
>     warning =E2=80=94 the example above was captured in such a scenario=
.
> =

> The skb dump includes this line:
> =

> skb headroom: 00000040: 72 30 8d ae 4f 32 e2 a4 be b5 59 db 08 00 45 00=

> =

> This appears to show the MAC address of the skb, which I was able to =

> trace to:
> $ sudo podman exec -it systemd-qbittorrentEH ip a
> [... unrelated ...]
> 3: eth0@if12: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc =

> noqueue state UP qlen 1000
>  =C2=A0 =C2=A0 link/ether 72:30:8d:ae:4f:32 brd ff:ff:ff:ff:ff:ff
>  =C2=A0 =C2=A0 inet 10.88.0.4/16 brd 10.88.255.255 scope global eth0
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0valid_lft forever preferred_lft forever
>  =C2=A0 =C2=A0 inet6 fccc::4/64 scope global
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0valid_lft forever preferred_lft forever
>  =C2=A0 =C2=A0 inet6 fe80::7030:8dff:feae:4f32/64 scope link
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0valid_lft forever preferred_lft forever
> And the other MAC:
> $ ip link show podman0
> 9: podman0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue =

> state UP mode DEFAULT group default qlen 1000
>  =C2=A0 =C2=A0 link/ether e2:a4:be:b5:59:db brd ff:ff:ff:ff:ff:ff
> =

> This seems to suggest the warning involves traffic between a veth pair =

> used by containers, raising the possibility of a bug in the kernel.

Can this be a packet coming in over the physical NIC, forwarded
through veth to the container. Either using ip_forward or some
redirect.

Do packets arrive encapsulated in a tunnel and what does the
decapsulation?

> For completeness, here is NIC information from the system (2x ConnectX-=
4 =

> MCX4121A-ACAT):
> $ ethtool -i mlx-p0
> driver: mlx5_core
> version: 6.14.0-63.fc42.x86_64
> firmware-version: 14.32.1900 (MT_2420110034)
> expansion-rom-version:
> bus-info: 0000:c1:00.0
> supports-statistics: yes
> supports-test: yes
> supports-eeprom-access: no
> supports-register-dump: no
> supports-priv-flags: yes
> =

> (and 2 unplugged i350 ports)
> $ ethtool -i board-p0
> driver: igb
> version: 6.14.0-63.fc42.x86_64
> firmware-version: 1.69, 0x80000df4
> expansion-rom-version:
> bus-info: 0000:45:00.0
> supports-statistics: yes
> supports-test: yes
> supports-eeprom-access: yes
> supports-register-dump: yes
> supports-priv-flags: yes
> =

> Please let me know if further debugging or logs would be helpful. I'd b=
e =

> happy to provide more detail or try any suggested patches.
> =

> Best,
> Qiyu



