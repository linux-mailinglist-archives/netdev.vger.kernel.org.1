Return-Path: <netdev+bounces-225888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6527DB98E5B
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2511883565
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B538E28489A;
	Wed, 24 Sep 2025 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SG1Tkhwm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6832848A9
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702664; cv=none; b=Zzv0HgVJvMPNMDE6apfhwJLEHHBiKsp8LeDxWoRbLw1f/5fJKZeqWeCFXIsAgtSSMcImeLM/tdj2p+Q8b+757eJ9+/wND7ZNk4V1kjBP7ixYdHXls5Mh011CIICzdgx2VbnC4Or7ZeHpzCE/PO7QT/NxJQ2f1FtBK8uog1Utxus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702664; c=relaxed/simple;
	bh=tvDkOCfsuaQ7GYS4gx1Mnhg3p9IRHU5mftTan4zgXSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=giOCd6Z4WMXzq506nF1oMWt+k5Pzj25aSeFNgVnq2qVw3K6yoPQgt8ERODq5r/DkSGa0CTNny1Hi5WaO+biwxn1N02W7Jwt22YlHU0gYc994XAfQJ47jZmBbOFPcHNfySjqcA+IF4NsNfNyqbUyQT4tYlidCVKcxEYerImBbKaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SG1Tkhwm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758702661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tvDkOCfsuaQ7GYS4gx1Mnhg3p9IRHU5mftTan4zgXSM=;
	b=SG1Tkhwm4UYRiyBY500S4/WptnGq3MR52y1BXR8dgpkh7QKnHiE3FniUoGy+EuxqrNWWsh
	MhChkB8qQj2mksCkAjuJmvows9SBoZtdC6DWHCme2f+gMpuYLsFD8bX3W5aj+ADiFbmb/1
	Sg4pbExS2DLFCfKvR9aZ8GzCniTYHKw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-wB3Q_L6GPKGWRcjgpW9PCw-1; Wed, 24 Sep 2025 04:31:00 -0400
X-MC-Unique: wB3Q_L6GPKGWRcjgpW9PCw-1
X-Mimecast-MFC-AGG-ID: wB3Q_L6GPKGWRcjgpW9PCw_1758702659
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32edda89a37so6346955a91.1
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 01:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758702659; x=1759307459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvDkOCfsuaQ7GYS4gx1Mnhg3p9IRHU5mftTan4zgXSM=;
        b=nfaMzMhvGvWbJ4bJKQ+iGGJcg4x1pBeiMlBT+IDB8Jw0HJks2vAnLiRsl4rn40m+Ea
         U5jDDIaD0/KB5SQxeswcpmiz8M68uLh27ZG2teKU7Ih+wGhlLmTYbXVHNnD/q1iEuvi6
         BxGUusHQ+JQX42tFpBmsc04BWMwaJ1YQZOuWvGJFWqPvDmtMnUCvc8ISsCDgKg/ysAeR
         QiBtqYiKpZ3vhVA+G53dTemb8NKX6aqDjtKVtiD27nvLDUHkUwpJFguwUwjXIXWWtVad
         +crgCQFz6WYkQIqgwkTSQItSLmJZ1Zxzrm7T8hsvUBhw/wkZAIdPkax8JeYRJbTVDCSR
         e8Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWoP1q9s2nulf0Llh1t6qGYr7/uMI/tG+n3jgSJESSzMaUupdHdgndETVdMzGP3NOsOoiFOfLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCeOh2TFzylXUekgjHdnUaSqm5mYhsBk0itVUfAUrV7KSUfTyg
	8q04m1LyCifhbv148F4/tFT3wc5IVikYHSduvT7jVFG1FFV7Ez1mzeZf6x2D7yZMJ3R7I0R4/da
	3gxFKefwEyTZ/Pw/O0new8Uh6HtmHOF02UtGLS6SAl6vX+irwQau0kcNEm5ThlBKUGrhhh0auJH
	2lnHeK091EBSMOAyey0l+av9cgKHS3FmR8
X-Gm-Gg: ASbGncurSGhVZd2Ya1byj7+XzikISzPsJ4WW0YMPLFeuNBjRz21Uyzbag7TH+rKRIEo
	F7PKNyuQZC9UCTXNSke/X9r3lObvcqOG42LG5bgc3gFmqYrI/yOt/PpZ7OfBhLoPTM2Ep1+l5M4
	WUHl6jv5QpcER6ZE6aZQ==
X-Received: by 2002:a17:90b:54cb:b0:332:250e:eec8 with SMTP id 98e67ed59e1d1-332a9513715mr7286797a91.15.1758702659072;
        Wed, 24 Sep 2025 01:30:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSuHUP7PGnJisv3R6suoi7mEFCXCrr7ybnyTOFly8Wrp69Kyr1dy9P3+Fdf6NLo31cwCaZ5AfWhe2/V/RdhQ0=
X-Received: by 2002:a17:90b:54cb:b0:332:250e:eec8 with SMTP id
 98e67ed59e1d1-332a9513715mr7286747a91.15.1758702658536; Wed, 24 Sep 2025
 01:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
 <20250924031105-mutt-send-email-mst@kernel.org> <CACGkMEuriTgw4+bFPiPU-1ptipt-WKvHdavM53ANwkr=iSvYYg@mail.gmail.com>
 <20250924034112-mutt-send-email-mst@kernel.org> <CACGkMEtdQ8j0AXttjLyPNSKq9-s0tSJPzRtKcWhXTF3M_PkVLQ@mail.gmail.com>
 <20250924040915-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250924040915-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 16:30:45 +0800
X-Gm-Features: AS18NWC70PosrkMr5g8LAeoMZx5xvquUOdY0YTAw2VzbuPvii9GWMNdWpFU8UFA
Message-ID: <CACGkMEtfbZv+6BYT-oph1r8HsFTL0dVxcfsEwC6T-OvHOA1Ciw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/8] TUN/TAP & vhost_net: netdev queue flow
 control to avoid ptr_ring tail drop
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>, willemdebruijn.kernel@gmail.com, 
	eperezma@redhat.com, stephen@networkplumber.org, leiyang@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 4:10=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Sep 24, 2025 at 04:08:33PM +0800, Jason Wang wrote:
> > On Wed, Sep 24, 2025 at 3:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Wed, Sep 24, 2025 at 03:33:08PM +0800, Jason Wang wrote:
> > > > On Wed, Sep 24, 2025 at 3:18=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Tue, Sep 23, 2025 at 12:15:45AM +0200, Simon Schippers wrote:
> > > > > > This patch series deals with TUN, TAP and vhost_net which drop =
incoming
> > > > > > SKBs whenever their internal ptr_ring buffer is full. Instead, =
with this
> > > > > > patch series, the associated netdev queue is stopped before thi=
s happens.
> > > > > > This allows the connected qdisc to function correctly as report=
ed by [1]
> > > > > > and improves application-layer performance, see our paper [2]. =
Meanwhile
> > > > > > the theoretical performance differs only slightly:
> > > > >
> > > > >
> > > > > About this whole approach.
> > > > > What if userspace is not consuming packets?
> > > > > Won't the watchdog warnings appear?
> > > > > Is it safe to allow userspace to block a tx queue
> > > > > indefinitely?
> > > >
> > > > I think it's safe as it's a userspace device, there's no way to
> > > > guarantee the userspace can process the packet in time (so no watch=
dog
> > > > for TUN).
> > > >
> > > > Thanks
> > >
> > > Hmm. Anyway, I guess if we ever want to enable timeout for tun,
> > > we can worry about it then.
> >
> > The problem is that the skb is freed until userspace calls recvmsg(),
> > so it would be tricky to implement a watchdog. (Or if we can do, we
> > can do BQL as well).
>
> I thought the watchdog generally watches queues not individual skbs?

Yes, but only if ndo_tx_timeout is implemented.

I mean it would be tricky if we want to implement ndo_tx_timeout since
we can't choose a good timeout.

Thanks


