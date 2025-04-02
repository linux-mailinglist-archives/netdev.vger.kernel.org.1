Return-Path: <netdev+bounces-178901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B726A797C1
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 23:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC6A3B186C
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 21:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1B41F4625;
	Wed,  2 Apr 2025 21:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHrn69Jj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DF31EBFF0
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 21:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743629881; cv=none; b=EJP1X8e2e/aTGkhL/4EgjbQdiXrO8eWIF0HLgeOouQ2Vpcud2FN5+HhnmqCu+5Mr1O/la6GPEdIIyON8dM9rGelj/LDs2epLBWnbjnoA/Y6l2tASaxpulyIjn+z7FNi5Wrs6x1CxzGHlkd5pNRwlvGX2RvrrB9q5UxyvELOS0Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743629881; c=relaxed/simple;
	bh=svpxCJA68zE/ryedpa59s1lH7A2OhofrYrE65Fne2wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZAmAivoDA8c3wZHL6k8SdhmTt22Scvm97xdBa+M1vbXBDVLgorKbbYQjzaR2u2H2qbBP7r0SizoxZAu9xwhOkfp1yUUQhU545bcbh9pbPK7kI3n8BmQGAt6Vv84H2b15nDDdv2xfIVjmnAjdj2853fGgldfpRa1dTCuj64Guog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHrn69Jj; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85b58d26336so16807239f.2
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 14:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743629878; x=1744234678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vc7/MCvbPnhoKI0rzZHC2yFOL/EMYeLP4cx1tTPqyBc=;
        b=GHrn69JjRq4B7V6CiHrhYdTbZOAWPMecTMz4mVvIoQ1t7MXUhIvXDQ3ZTER3aN+rWd
         laD28je6I1dXRwmi0xCtrNsxa5bVyTYCXluM5Ubx+vPWGBDnRa/ZWv5iHMXf3GRkSdAZ
         qtbeQNDXGut1SIebzOI38Vu12W/jvl93KkGioOCnPEIJ8dKsOezWJzA2NmBf7yVGq0ch
         8VsyBRRT+ISOly9BSsw7CyxqD0Sxohaxltr1gSwMvyupRLpSoFvHEntQnGl4SWWz0LW1
         N5VXMna1GyRlT9gbTCogG+FvATYc3bdzyTgXP7thcvhfWh4Z6qcAy6trKjSNTx80fopR
         StUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743629878; x=1744234678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vc7/MCvbPnhoKI0rzZHC2yFOL/EMYeLP4cx1tTPqyBc=;
        b=Ic5+7ky4GqkYHDN1n8a1Eu8iY5pxevFvC4wK/kErEptAOru1mU2D81m7qEebmvXiC1
         sgF7H7sSSNLRCOSKuNzA2lgct4sq46q20+tBJQVOYMyHYfLrb+EMmOdU7u5A9k5qVpVp
         P4QaWDpD3ELx6DDAoepsWMsLjHeXIBipsztajfeCFZoztesWE9KYe7jylbe/RE10yCh8
         poSg9wAc9RyBrv5Xb1I3PnPI0wkn6N9gRfqZFEFshQ1xHzfoZEtNDEtv4LiT8kM+ZmMx
         Q8vCOCfxXzO96gUfFotTR3VNJaMZQjPikTWhuSTqq4HuXKdUSk4Fls4CD3tDQLXJNJFa
         Ot5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpOzALFNq3HG4OE/Z6BtT3UO/lpMVvDq84jHSq7NDViGOsJBIJlNsAc2ySpd1QM+NLpoTvlKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQUsCPjMRsAqU8kirQ/4UYo12/65cs6/2gpEZwocMwhG5TxW4v
	7OibG4gm9325fMU0CKFav6YfFlzuGo+/FYLnIl20UoKibwJtTEFRVPthSC/3a32DRIQcBraKtDd
	mbrKiHDCfbbuIWfoTszYrFO2MslA=
X-Gm-Gg: ASbGnctppFRNkAG2x5B/cPgjf+OSr+ccnJpirSAClfhUmht8CdT+glsRW7K3jTcxjOO
	N1iwwGj1kbZ/U0Qos2QIPVHeKpb773sxq4ae202fVBOm4ctVgQiuk2aPu214lD3AkxCvWB/coTM
	OksCClFiIN4H7ounUJ8YLJAc1TxIbV
X-Google-Smtp-Source: AGHT+IFCd+y5LTv8B2oXflBSu4OArIYPAmNBBp1gSmACEfPqAA+BxUI/NWFeCnptEwCounB4tj1ktbNsAplmhjsgIME=
X-Received: by 2002:a05:6e02:250e:b0:3d6:cc9e:6686 with SMTP id
 e9e14a558f8ab-3d6dd80a6c4mr6426485ab.17.1743629878307; Wed, 02 Apr 2025
 14:37:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402165632.6958-1-linma@zju.edu.cn>
In-Reply-To: <20250402165632.6958-1-linma@zju.edu.cn>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 2 Apr 2025 17:37:45 -0400
X-Gm-Features: AQ5f1Jotjbsspn9izXQ6xKYs1m9auvRLj4h05_bNMHQDAI3qVp5J_tQAin8TK1U
Message-ID: <CADvbK_fGUHNZRguoqi7UBi_83oFvCFmD67hnPpT369UMG82xrQ@mail.gmail.com>
Subject: Re: [PATCH net] net: fix geneve_opt length integer overflow
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, pablo@netfilter.org, 
	kadlec@netfilter.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, pieter.jansenvanvuuren@netronome.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 12:58=E2=80=AFPM Lin Ma <linma@zju.edu.cn> wrote:
>
> struct geneve_opt uses 5 bit length for each single option, which
> means every vary size option should be smaller than 128 bytes.
>
> However, all current related Netlink policies cannot promise this
> length condition and the attacker can exploit a exact 128-byte size
> option to *fake* a zero length option and confuse the parsing logic,
> further achieve heap out-of-bounds read.
>
> One example crash log is like below:
>
> [    3.905425] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    3.905925] BUG: KASAN: slab-out-of-bounds in nla_put+0xa9/0xe0
> [    3.906255] Read of size 124 at addr ffff888005f291cc by task poc/177
> [    3.906646]
> [    3.906775] CPU: 0 PID: 177 Comm: poc-oob-read Not tainted 6.1.132 #1
> [    3.907131] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    3.907784] Call Trace:
> [    3.907925]  <TASK>
> [    3.908048]  dump_stack_lvl+0x44/0x5c
> [    3.908258]  print_report+0x184/0x4be
> [    3.909151]  kasan_report+0xc5/0x100
> [    3.909539]  kasan_check_range+0xf3/0x1a0
> [    3.909794]  memcpy+0x1f/0x60
> [    3.909968]  nla_put+0xa9/0xe0
> [    3.910147]  tunnel_key_dump+0x945/0xba0
> [    3.911536]  tcf_action_dump_1+0x1c1/0x340
> [    3.912436]  tcf_action_dump+0x101/0x180
> [    3.912689]  tcf_exts_dump+0x164/0x1e0
> [    3.912905]  fw_dump+0x18b/0x2d0
> [    3.913483]  tcf_fill_node+0x2ee/0x460
> [    3.914778]  tfilter_notify+0xf4/0x180
> [    3.915208]  tc_new_tfilter+0xd51/0x10d0
> [    3.918615]  rtnetlink_rcv_msg+0x4a2/0x560
> [    3.919118]  netlink_rcv_skb+0xcd/0x200
> [    3.919787]  netlink_unicast+0x395/0x530
> [    3.921032]  netlink_sendmsg+0x3d0/0x6d0
> [    3.921987]  __sock_sendmsg+0x99/0xa0
> [    3.922220]  __sys_sendto+0x1b7/0x240
> [    3.922682]  __x64_sys_sendto+0x72/0x90
> [    3.922906]  do_syscall_64+0x5e/0x90
> [    3.923814]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [    3.924122] RIP: 0033:0x7e83eab84407
> [    3.924331] Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 00 00 5=
9 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <=
5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 faf
> [    3.925330] RSP: 002b:00007ffff505e370 EFLAGS: 00000202 ORIG_RAX: 0000=
00000000002c
> [    3.925752] RAX: ffffffffffffffda RBX: 00007e83eaafa740 RCX: 00007e83e=
ab84407
> [    3.926173] RDX: 00000000000001a8 RSI: 00007ffff505e3c0 RDI: 000000000=
0000003
> [    3.926587] RBP: 00007ffff505f460 R08: 00007e83eace1000 R09: 000000000=
000000c
> [    3.926977] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffff=
505f3c0
> [    3.927367] R13: 00007ffff505f5c8 R14: 00007e83ead1b000 R15: 00005d4fb=
be6dcb8
>
> Fix these issues by enforing correct length condition in related
> policies.
>
> Fixes: 925d844696d9 ("netfilter: nft_tunnel: add support for geneve opts"=
)
> Fixes: 4ece47787077 ("lwtunnel: add options setting and dumping for genev=
e")
> Fixes: 0ed5269f9e41 ("net/sched: add tunnel option support to act_tunnel_=
key")
> Fixes: 0a6e77784f49 ("net/sched: allow flower to match tunnel options")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Reviewed-by: Xin Long <lucien.xin@gmail.com>

Thanks.

