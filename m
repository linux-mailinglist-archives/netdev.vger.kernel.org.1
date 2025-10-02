Return-Path: <netdev+bounces-227535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E62FBB2334
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 03:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4229E7AD344
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 01:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA12F25776;
	Thu,  2 Oct 2025 01:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0IU2CV5s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482C8EEBA
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 01:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759366974; cv=none; b=H5dc9HUEYmN7MRQGYUoiS09iVNGR8KvwSAyG4iRf09gft8uIA/Y9hdJTpJL2Sr+tpMKAx14Rf78AVERa+6vdTUViGQE3EQEeAhdBgOELpIoJx3NYInjCx8VTtBC2I/CtYsX/LJ3P0OH4ThLuQGVIyvzqqbK/rr1qMuFKINe4oJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759366974; c=relaxed/simple;
	bh=fJCwtgPNSFcKZik/xWzuJ2Nl9DLm4510nRoTtppN+sE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDyR1gTqfQyVlS3QXEdJP/5R8WS0C3wdpwTugQ1UzsO8VbVJGY0hxE8LHwSg84ndwNiMin1CKAgSlRqT6uZxGsQ2w8Fr3vl/RuaPqcYlOxYvARcuMlUzhWSqwIX+LUjtSs5Otwzb7/pJZo1nhbhS176+AZthMKv2gWCw7mFcNoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0IU2CV5s; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4de66881569so230911cf.0
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 18:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759366972; x=1759971772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBSLRY4fID/cBiXqIe6h5ynAijHxdNPdDw4ZDrWAVg0=;
        b=0IU2CV5sj5hPfnBH2FVtwOIbgIdQUoYdtcCFPwpBrJ10zV/5kuT72lUi+fx/SrJPv6
         Kswxx202dz+07bb2iSREeC2PVRfT0XHW+tYTs7Y+YLnkWrsCmwcJqoiDQOWpuz+GhbjJ
         6m184GmROfBvUVBj4FhfwMkA2ZbEJmEwAcDAmO5VF4OSMROCXCIywjqApxYBvOXPuatL
         lQEcrn1RI8Rl4e61tKFu/29JIAhk828YPDSTuNBRGFEt/o2HuF94YmGIF53f3lTvmeD/
         hxbCkoHBJ5nN6TVmJ3yiOPsbyP4RMJ3UZ+O+z2Q4m7e4EpYmVasgNhZaodb68380hY6o
         CzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759366972; x=1759971772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBSLRY4fID/cBiXqIe6h5ynAijHxdNPdDw4ZDrWAVg0=;
        b=wLkVd12LEOs5SbkRDAFD3ztDC8T+73B/uyDaRVZVwZ6I64nLylioRs+lDxG7FVMLQ9
         eZyGpNoy0Zkcbl238vtDyW5SQPkcNZXdJ41VOJ7JhFjTdKFMHQNsU3zyBzVmCU7j2yyz
         z2qbI377QUHXH35J2ry2rCbCrz4gdeHIDb4UhsDxlvbSwBZ9rp14+8n/ZjgS2utqTWX5
         /3E3LhJ4uk84pjANYEI40tyKJrHVOiHXuut1pJLGTUe1vhKPO2hSYJ7j85wmmA9poTV6
         /FtArMXZPG+gUKiaO4qiyi8KrLsSPYb5qcWlw+aJuDuKv28VLauQFcHlZACCBFvPOilm
         2vwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZpC6jEwpXao0dqSAnOTHnyo6DQDrH5AGPu4cIPUXabp6F2FZuuasWrA9n4LwprNFof4TPRDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN3UBLU/RvcyIfz4CHmon33En5Xg8d9cgV7MU0x2RgH9l3/TxZ
	Eif82v34zSRrJZvhVBIL8mFpiQH0rpO/q8enBmHPmdGiw9NrzeqES59OJF2TSVhfnnM0EF0snuT
	QbURzaLr6Wup8vyAAjhDi9Q9tG5mxp5vxTk5EzUZR
X-Gm-Gg: ASbGncvYVRbPMHU6zRY+T8Y3o65gaN3uyN99i8Lu0MspyV6NudqXEt1DqtxHtelwqv0
	IPS+kpQ2Dp7qwYu914Itx1Vm/4W0i0VJmwO8A09x75ee+cV3x0J5iU9zJeiHXWnY546YxTjUB6n
	UJEgmMBbzo0V2UpT42+5+uf3K18nuWoE7gkYx36BjEM3XAZqPC6G2aICS85+x+Nxfg0fFZ3SYSH
	Kv7OGcmlKmdI5aGSzS1vHIU7OO+BUC6/0/2LFlSEgvhuCUyU6tBOxqJkO4W3nt7TC3j29w=
X-Google-Smtp-Source: AGHT+IFKtuOO3BtBnInFtghLuT5oaAytbfqlQqxfSONe+I5mErf4jp5CofBK43lV+XX895cBXqbbRtKUWjZVcfWVw4Q=
X-Received: by 2002:ac8:5d0b:0:b0:4b4:979d:8764 with SMTP id
 d75a77b69052e-4e56c85df41mr1485761cf.19.1759366971654; Wed, 01 Oct 2025
 18:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001074704.2817028-1-tavip@google.com> <5af7b3b9-3ee1-4ef6-8431-72b40445eacd@linux.dev>
In-Reply-To: <5af7b3b9-3ee1-4ef6-8431-72b40445eacd@linux.dev>
From: Octavian Purdila <tavip@google.com>
Date: Wed, 1 Oct 2025 18:02:40 -0700
X-Gm-Features: AS18NWDZeq6U-ZXXr8a17ILJl2kRgvXE7gR_7txM0W8s-hT-w__IrWCljO_KFB4
Message-ID: <CAGWr4cQ6g5xw_iJK2KbyTbSszsf2gacUZ9v0wKAVWnyBAYz9nA@mail.gmail.com>
Subject: Re: [PATCH net v2] xdp: update mem type when page pool is used for
 generic XDP
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, kuniyu@google.com, 
	aleksander.lobakin@intel.com, maciej.fijalkowski@intel.com, toke@redhat.com, 
	lorenzo@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 1:26=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> Hi Octavian,
>

Hi Ihor,

> This patch seems to be causing a null pointer dereference.
> See a splat caught by BPF CI below.
>
> You might be able to reproduce with:
>
> cd tools/testing/selftests/bpf
> make test_progs
> # in kernel with this patch
> ./test_progs -t xdp_veth
>
> Reverting this commit mitigates the failure:
> https://github.com/linux-netdev/testing-bpf-ci/commit/9e1eab63cd1bcbe37e2=
05856f7ff7d1ad49669f5
>
> Could you please take a look?
>

Thanks for the report, it looks like dev needs to be set in
xdp_rxq_info. The following fix works me:

diff --git a/net/core/dev.c b/net/core/dev.c
index 365c43ffc9c1..85b52c28660b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5449,7 +5449,9 @@ int do_xdp_generic(const struct bpf_prog
*xdp_prog, struct sk_buff **pskb)
        struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;

        if (xdp_prog) {
-               struct xdp_rxq_info rxq =3D {};
+               struct xdp_rxq_info rxq =3D {
+                       .dev =3D (*pskb)->dev,
+               };
                struct xdp_buff xdp =3D {
                        .rxq =3D &rxq,
                };

But probably Maciej approach is better.

