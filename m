Return-Path: <netdev+bounces-81365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7348876D2
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 04:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9042F1C216B4
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 03:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200AB372;
	Sat, 23 Mar 2024 03:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOfHD43P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6902B7E6;
	Sat, 23 Mar 2024 03:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711162926; cv=none; b=WsHLbOGD+wh6XKvca+pV2+sj3t5PYgye6fbqVPELhHApfbBMnNyPfXL9WWmzz7Blv1aPvUG/ALBdv6SZXW/L2IHwh8QtfOkcIC5Tu/OYs3nxF5LqZSdao+VZEGrwdqBd5yaIo//PNb7HwCEJ+RkaU3UA+k0gLuyIV6uF6Uuxqs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711162926; c=relaxed/simple;
	bh=nFFUCtZFsD63YmCxke9ID8Pora4+GvGIQuyUBFLiGxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEXada6ndCNEoF4R9j29iee8SsFXka/qpsRbU8csXTASJ6dL/8E9g5VYoYfv4a1DWd1pIeFvyAdjALr6cTLgBPiS02AuI7Y/oidOxi1H3HQLgFdANpxtXbBLNjp+V0ng0qwSd3GfmuTt9e3E+QcVDRO/aUs+MBmBzUKpv2MoXpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOfHD43P; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34169f28460so1570683f8f.2;
        Fri, 22 Mar 2024 20:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711162923; x=1711767723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFFUCtZFsD63YmCxke9ID8Pora4+GvGIQuyUBFLiGxo=;
        b=hOfHD43PgkKVmzkL+UyXX3HxBOmcdD1AoYKtpir8sS6t2tAZtfK0rjiehl7oDcDP8Q
         CZkdnVngq1ubELOUQkF6yLHLzKR5MP3mM8ybrjFNkIOZl4OZJn3g0PFvRFYKDbTQYuAT
         5L4opHvPstCjHnz7yvm4lA/dRUnRe8CY9GC10Xp2so6SABskqO3f5ouITzeHFj+i0KPT
         JIOdTVWKWuuYdi+ts81y0euwnL/IwDDlNlIdDO7BwYmpN4exvt6bpOMQyv8utHVDqg6M
         kDXdjY9pEcK4ik9m0iM2BcsxGAKFoa0ibuByCp+J/hmDqp0GYKtiLlyQ59ZEQMTqTUo0
         +Jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711162923; x=1711767723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFFUCtZFsD63YmCxke9ID8Pora4+GvGIQuyUBFLiGxo=;
        b=fRCtDggWsIDRbDccF9EKwcpkuv3df/woGsP8awX5KHLg9D/EhitmYvMs6dxBKZBSaw
         nY8Jm+zGYYOGArHoqV7qR1bYxSX6TFP2QISVMkwGOkp4gMy5qnvetB/dMlTSHa4dSqfw
         jtD8eEROfitL54ixneYVBdoGywvve6aTfh1FwAES+qMmGVC6diK9V20ETLCJ6gIhdWDG
         ZqM4dqB50AGQzLXhsQEtdBAiPvJA92hcADTtewo9m4HlPc0vfjHl49msRr6dOiLrYb0z
         HjfpGnJPjPbHGWeKRgtVHggjqBX9sQdlUyjKYn0+mVY1Q4TnUje/jE78XP2R3IMe4Bk5
         6Snw==
X-Forwarded-Encrypted: i=1; AJvYcCX79oH0GgYe4a5TJFtaYDZVagaSiG369NnB3TYyFE4iDxLMFzVi0cWSUq2BL7RddQBtyoeprsMGRNxXKKgBx1u5o1Bt222Cl7pPodo2sQG+sGVfUyCmDVOcuvuu
X-Gm-Message-State: AOJu0YyZiCNXNHT2mFX0HRQlgHKU4sGrj3zvSGjNEOVifYBnM8yD7a2q
	SYR/xXK7ccgPVSCSXd6EecxK87csgsLnmcKU7wurNSLvenTI/Of400nvUeSnmXMYjtfdAQP4J6u
	3kGpyx0GxOw9LsquUECh8/kAd9Go=
X-Google-Smtp-Source: AGHT+IEdR83Uk3D20YwvMz293JGkNbFM0lLmy07QJ3iwW5OLvpWsek27/245QXpAVv5M7ZLJE1kf0z6SRK8eecAQjsA=
X-Received: by 2002:a5d:4f8f:0:b0:33e:bc7e:cadb with SMTP id
 d15-20020a5d4f8f000000b0033ebc7ecadbmr689158wru.41.1711162922700; Fri, 22 Mar
 2024 20:02:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322122407.1329861-1-edumazet@google.com> <171111663201.19374.16295682760005551863.git-patchwork-notify@kernel.org>
In-Reply-To: <171111663201.19374.16295682760005551863.git-patchwork-notify@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 22 Mar 2024 20:01:51 -0700
Message-ID: <CAADnVQJy+0=6ZuAz-7dwOPK3sN2QrPiAcxhtojh8p65j0TRNhg@mail.gmail.com>
Subject: Re: [PATCH net] bpf: Don't redirect too small packets
To: patchwork-bot+netdevbpf@kernel.org
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eric Dumazet <eric.dumazet@gmail.com>, 
	syzbot+9e27778c0edc62cb97d8@syzkaller.appspotmail.com, 
	Stanislav Fomichev <sdf@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 7:10=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This patch was applied to bpf/bpf.git (master)
> by Daniel Borkmann <daniel@iogearbox.net>:
>
> On Fri, 22 Mar 2024 12:24:07 +0000 you wrote:
> > Some drivers ndo_start_xmit() expect a minimal size, as shown
> > by various syzbot reports [1].
> >
> > Willem added in commit 217e6fa24ce2 ("net: introduce device min_header_=
len")
> > the missing attribute that can be used by upper layers.
> >
> > We need to use it in __bpf_redirect_common().

This patch broke empty_skb test:
$ test_progs -t empty_skb

test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
[redirect_ingress] unexpected ret: veth ETH_HLEN+1 packet ingress
[redirect_ingress]: actual -34 !=3D expected 0
test_empty_skb:PASS:err: veth ETH_HLEN+1 packet ingress [redirect_egress] 0=
 nsec
test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
[redirect_egress] unexpected ret: veth ETH_HLEN+1 packet ingress
[redirect_egress]: actual -34 !=3D expected 1

And looking at the test I think it's not a test issue.
This check
if (unlikely(skb->len < dev->min_header_len))
is rejecting more than it should.

So I reverted this patch for now.

