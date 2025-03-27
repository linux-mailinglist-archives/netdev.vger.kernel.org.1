Return-Path: <netdev+bounces-177981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFA8A7370D
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 17:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5781A3A1DA0
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 16:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413251A8F71;
	Thu, 27 Mar 2025 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vpu9Jmu+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A246A1586C8
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743093577; cv=none; b=ojMgTYCIa+rEr/UgHl5jY5VPBFheTA0TUkcoHzJarQ9Q4SvYUwKquiFdRamTyFRmtDVN/2DiOmaLkSjQRjOAZ0FY8xAH4oJ/vIa2j8/SqE/z5lQKS5WnQ34/kEcyVR4a8QB68KqRsupIe8NsulK9b3ic4SbiWQolwu4F8HWkFzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743093577; c=relaxed/simple;
	bh=qz6O0SvqKj7hMIlLSGDzunh1fQcQPurnuyv/+kOFiRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZkB1d62ouuGF8ilpHdoXi1bFaPIMcaSrWJwoxAhlaDG2IK2f/EKxsm81C/J0Q/jtCISLxGLiYiYLeyV2ML7cBIjYTXQYyclNJFFety09hSGbuWoyFtHazU933Cd+O8eBzJxTUcz05nRpQYlLPmWQHJbngFzeWSKXAEgA1Lra8h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vpu9Jmu+; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2242ac37caeso186685ad.1
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 09:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743093574; x=1743698374; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QK11PngRwoXYrD50CS9bj8vLd8pDCH8MaXxGy2Uilg=;
        b=Vpu9Jmu+6kZWbuSLzvv1r5Gpr2J2iknjgXd5lvDxuE7+B1X6g0xIT5CSL/XVAzUseB
         TZh4eSYaw/DxfQKVl7fDoavSfGCb95zNa3eO99l1k2TtT0e3I0wF3aJ8e3jPRUylBsvv
         eXGhCm0EcECMGHyvoiCic3+zmMHiVFsyu4Ed1j9E/iU44Ke8TTExTbkBGTS1v/CuGjGe
         wSiU8fI4IFsVO/u2lso6uB6P313eP0UDAv2k4aeCW3ndiBs0uRM0Ql2UlVzZesjikIk0
         Jb42/pBbsgfRP1as4W12dcGdBqCm5zlg97J+I3qcgOiW2sk1d1zj0W8y01xfTXNWY2lW
         +jYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743093574; x=1743698374;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QK11PngRwoXYrD50CS9bj8vLd8pDCH8MaXxGy2Uilg=;
        b=DZFabrrH4d1G02EnITUxsSPWG5xKeKgbCB0KO1EBLCpAQbQiTyn00LYCFj2iVIg2Yy
         VXf0C96+LHRsNFNG09wxcJoEPXlwHEQ91sHRh4bE1WhzdbuS7HqAQy/E2E3tBfD32AuZ
         s7nxHm10+Dl+8bIluQ0MqWb7RzYWb+FacGDtB+Gii+foKY69dj0f8SRvamykN3gnzzhu
         1w46sZVxHpucPCeaC6/92rXgLNZXFymk6nUVRdi5ELftXky2GbvbOTUd9MiLkGJehZjN
         BQ60KFuwwKIvJZC4ze5R5YbCAKnc14Tvypb52NE3NiJ+UYK9DxQCT/JCdBHmSv5Pg///
         IYkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNFEJ/PTe22aMU2gEO6VycpsmlHej0bIlelJUczFcV7mWCDhJgfkqsf+Z1vbgntch0sJ/YVWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzkOzq+H7PMA7uVB5XsDvlMZk2OMaGH/wBn6nzLH47Q+7NSOy+
	fy3ovCt25FUHnIr14GnRPWgqm80CMv5YM+zhBxxyfSE1aS1XY/aqT5zj5vQoYH8l6r/SkAoHB9O
	FVbo5tsxozP/kn2YitlOyvoAtjl9t2gr6/xqD52mDD5DCIeCGgf0X+SA=
X-Gm-Gg: ASbGncvHInPcRrbS3y+0hQrBgtJY0mNrGmqBqXgxla/Q7dsfPdJoAs7lq4fDS24fviy
	jhKYIFlHp4YfoMxAxLAYGOUIvQj085gviMOukZETc82M3geeCMcOCvliNV+Cdup/IFoUpeFXjZz
	qAuvOHYs4IkD2lmgNlOsl/Jts4P06uDOczKcfrUEw7Bhcam/JDCr4kzFsBbw==
X-Google-Smtp-Source: AGHT+IHnbgbgCrJP+lW8o6NedtQH7SjyJwd31vGWlQsyDkGsEXRBURbyFDhhSQoTVGsCGI3heCmeFLH3Yz7IthGe6QI=
X-Received: by 2002:a17:903:189:b0:21f:631c:7fc9 with SMTP id
 d9443c01a7336-2291f96f668mr130775ad.0.1743093573466; Thu, 27 Mar 2025
 09:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321021521.849856-1-skhawaja@google.com> <20250321021521.849856-4-skhawaja@google.com>
 <Z92kRKwkDmcRbc41@LQ3V64L9R2>
In-Reply-To: <Z92kRKwkDmcRbc41@LQ3V64L9R2>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 27 Mar 2025 09:39:21 -0700
X-Gm-Features: AQ5f1JqyPfxEPi2Nk4kkmDkr6NTw1N758q464XwKeqoJ4IBRVYvevzejruZ65w0
Message-ID: <CAAywjhQvC2gzCyJSzQaiw68UdL0nK++8BgVgh5=vywF4fcrytQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/4] Extend napi threaded polling to allow
 kthread based busy polling
To: Joe Damato <jdamato@fastly.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 10:39=E2=80=AFAM Joe Damato <jdamato@fastly.com> wr=
ote:
>
> On Fri, Mar 21, 2025 at 02:15:20AM +0000, Samiullah Khawaja wrote:
> > Add a new state to napi state enum:
> >
> > - STATE_THREADED_BUSY_POLL
> >   Threaded busy poll is enabled/running for this napi.
> >
> > Following changes are introduced in the napi scheduling and state logic=
:
> >
> > - When threaded busy poll is enabled through sysfs it also enables
> >   NAPI_STATE_THREADED so a kthread is created per napi. It also sets
> >   NAPI_STATE_THREADED_BUSY_POLL bit on each napi to indicate that we ar=
e
> >   supposed to busy poll for each napi.
> >
> > - When napi is scheduled with STATE_SCHED_THREADED and associated
> >   kthread is woken up, the kthread owns the context. If
> >   NAPI_STATE_THREADED_BUSY_POLL and NAPI_SCHED_THREADED both are set
> >   then it means that we can busy poll.
> >
> > - To keep busy polling and to avoid scheduling of the interrupts, the
> >   napi_complete_done returns false when both SCHED_THREADED and
> >   THREADED_BUSY_POLL flags are set. Also napi_complete_done returns
> >   early to avoid the STATE_SCHED_THREADED being unset.
> >
> > - If at any point STATE_THREADED_BUSY_POLL is unset, the
> >   napi_complete_done will run and unset the SCHED_THREADED bit also.
> >   This will make the associated kthread go to sleep as per existing
> >   logic.
> >
> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> > ---
> >  Documentation/ABI/testing/sysfs-class-net     |  3 +-
> >  Documentation/netlink/specs/netdev.yaml       | 12 ++-
> >  Documentation/networking/napi.rst             | 67 ++++++++++++-
> >  .../net/ethernet/atheros/atl1c/atl1c_main.c   |  2 +-
> >  drivers/net/ethernet/mellanox/mlxsw/pci.c     |  2 +-
> >  drivers/net/ethernet/renesas/ravb_main.c      |  2 +-
> >  drivers/net/wireless/ath/ath10k/snoc.c        |  2 +-
> >  include/linux/netdevice.h                     | 20 +++-
> >  include/uapi/linux/netdev.h                   |  6 ++
> >  net/core/dev.c                                | 93 ++++++++++++++++---
> >  net/core/net-sysfs.c                          |  2 +-
> >  net/core/netdev-genl-gen.c                    |  2 +-
> >  net/core/netdev-genl.c                        |  2 +-
> >  tools/include/uapi/linux/netdev.h             |  6 ++
> >  14 files changed, 188 insertions(+), 33 deletions(-)
>
> I think this should be split into two patches which would ease
> review and bisection:
>
>   - First patch: introduce enum netdev_napi_threaded and
>     NETDEV_NAPI_THREADED_ENABLE and the associated driver changes.
>
>   - Second patch: introduce NETDEV_NAPI_THREADED_BUSY_POLL_ENABLE
Agreed. I will split this up and send again.
>
> I'll have to take a closer look at all the changes here after I've
> read the cover letter and have reproduced the results, but one issue
> stands out:
>
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 3c244fd9ae6d..b990cbe76f86 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
>
> [...]
>
> > @@ -2432,7 +2442,7 @@ struct net_device {
> >       struct sfp_bus          *sfp_bus;
> >       struct lock_class_key   *qdisc_tx_busylock;
> >       bool                    proto_down;
> > -     bool                    threaded;
> > +     u8                      threaded;
>
> Doesn't
>
> Documentation/networking/net_cachelines/net_device.rst
>
> Also need to be updated if you are changing the width of this field
> from bool to u8?

