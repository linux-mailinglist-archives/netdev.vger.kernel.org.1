Return-Path: <netdev+bounces-210707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C6DB14665
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 04:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA302542625
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 02:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AAE2153E1;
	Tue, 29 Jul 2025 02:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AT3A3M0t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3C379EA
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 02:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756940; cv=none; b=ZNlxBeo8hPm3ILTiGmY1OLF17+1xttTSU8or1sl1Sf+w4aIQWaI9wtQeEAVa3XA5/WuNBCBh8sHTBPTz7HmpUufu/O0V0Pch5XdK044hxSX66vBEY79FmVCZZAOtn0ysgLx9l2BnLZsQAuKEgTjQlhLHRuG7Gcq49MPUHeu7fzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756940; c=relaxed/simple;
	bh=Ww2f2ZpyJcTFXUKhLHEBwckLTS8uuClVa/W/yWcnBdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JB/WTl4/q3UDZQ/an/b0NRXAdGcr35Mhmn5kJ0XaIhiTXiP4elmVwSNrkb6XCZVR/wxqOB5g6vXxKT5gIrkR4/DCIh72/CErAb1LsCRiMBpQ39t/VRSa/AyKCGsLIfRimsK+9fKphRm7sTKk82CgQzOrnimgOBHGcLbS+WIk6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AT3A3M0t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753756938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ww2f2ZpyJcTFXUKhLHEBwckLTS8uuClVa/W/yWcnBdQ=;
	b=AT3A3M0tNgzOgLC1SIqduDhekisS0X4PeU/9ioY4GxLlPNk5YbrQmv/MHLOXCGD89XtNuA
	2NJb+iGAPvq4euF8OeMKCk6+ErIz0Js0tDZz4g0Mluex1AW9o3ATAJleTSJkfSrEfvPRg7
	xYtNDghBVlR6Jlz6ETJ/XgPWrUwlgA8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-g95PPq0dM3y_PnQ3c6KzBQ-1; Mon, 28 Jul 2025 22:42:16 -0400
X-MC-Unique: g95PPq0dM3y_PnQ3c6KzBQ-1
X-Mimecast-MFC-AGG-ID: g95PPq0dM3y_PnQ3c6KzBQ_1753756936
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-311ef4fb5fdso5896809a91.1
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 19:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756935; x=1754361735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ww2f2ZpyJcTFXUKhLHEBwckLTS8uuClVa/W/yWcnBdQ=;
        b=hki7hYHYu+Wj8itSRVkLbUE7imo1kF36qobzobBxFTSJDPCCMNtcKiKCwZx6IGPFk6
         t8LFILZsnjyWHn4SIbX4Q4nhLWjsmnFGx/9+IfMP+Qe2FTtYW1nitrJVj+YYqtqzDjCY
         r2cKqFw6EqtYGrG+1N1gsLmRareZnfMpJJNgi75DTJt8yBOmJKIaDT9lM6VT+V9fviDK
         vY+UwCg+r+8G41HhjSv6FrdeKMXETFUUz5HeKY0TUL51rIGVed5/HQfaYORE0LfmVpaN
         EFyASmMgGIinNWpCYpbmyh4msk6iA5tp7yCZKClTpn7qM8F8KBklmFsQaJI6PrcseSNd
         r1jA==
X-Forwarded-Encrypted: i=1; AJvYcCW2UE5jcdaHilJVo/tker989z8CtjrRV/k1lrN8t92I0o2AKztG2eopxyoCpBur65gqQOYZo9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs49KtdU6QoOP7qLWLMaiLcDYbM+iBn44cfRmf2qX8103s6IPX
	7tJZa4JXWVpoligmBjQPHameERjz9y6PkEv+TrOu3fudvDiQusNOQd//O46LM35pgShAq+eb2ow
	vIL3Qx7lwS65b0O60c7Cp63CSzh2iu1PtkYdYzQm/r/NkkCW/34EbCCDrUGrMKusrFmzk+maiQv
	0ie2zn7huINpRPtzFqN7/Ldp/Xb4TAk4C2
X-Gm-Gg: ASbGnctpQd5CliLP1638UwUvFe7gDxaHIS87ofYV6Lt6Nsej7T8PKlSfSaqSEMzjIvW
	NesOSLENUO8HMjuFevXgJPT0Oico4i4xJxzGhqGy1XQi6hed1N0JsRArnRG0xaw8WZ7KDJM/HOh
	v0nDNdN5fptXYXdY4MUCM=
X-Received: by 2002:a17:90b:280d:b0:311:c5d9:2c70 with SMTP id 98e67ed59e1d1-31e7789934emr19500226a91.15.1753756935540;
        Mon, 28 Jul 2025 19:42:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiTrGIt7eoxqCmwJKJyFiSjpEt/y/C2GLW4uxNz1WclVI1OSQpVtk4/Uh3bkfM8enIwqKkmmo/XskQneWdc8g=
X-Received: by 2002:a17:90b:280d:b0:311:c5d9:2c70 with SMTP id
 98e67ed59e1d1-31e7789934emr19500181a91.15.1753756935041; Mon, 28 Jul 2025
 19:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718061812.238412-1-lulu@redhat.com> <20250721162834.484d352a@kernel.org>
 <CACGkMEtqhjTjdxPc=eqMxPNKFsKKA+5YP+uqWtonm=onm0gCrg@mail.gmail.com>
 <20250721181807.752af6a4@kernel.org> <CACGkMEtEvkSaYP1s+jq-3RPrX_GAr1gQ+b=b4oytw9_dGnSc_w@mail.gmail.com>
 <20250723080532.53ecc4f1@kernel.org> <SJ2PR21MB40138F71138A809C3A2D903BCA5FA@SJ2PR21MB4013.namprd21.prod.outlook.com>
 <20250723151622.0606cc99@kernel.org> <20250727200126.2682aa39@hermes.local> <20250728081907.3de03b67@kernel.org>
In-Reply-To: <20250728081907.3de03b67@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Jul 2025 10:42:02 +0800
X-Gm-Features: Ac12FXzBxdqLecuJGApu98LjzbNbf9v9AdNqmCM9700YIpdOZpTnf4cOXXGt-No
Message-ID: <CACGkMEvwAqY2dRYLnUnVvprjoH8uoyeHN9CB9=-xRUE80m6JSg@mail.gmail.com>
Subject: Re: [PATCH RESEND] netvsc: transfer lower device max tso size
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Cindy Lu <lulu@redhat.com>, KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Michael Kelley <mhklinux@outlook.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>, 
	Kees Cook <kees@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Guillaume Nault <gnault@redhat.com>, 
	Joe Damato <jdamato@fastly.com>, Ahmed Zaki <ahmed.zaki@intel.com>, 
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 11:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Sun, 27 Jul 2025 20:01:26 -0700 Stephen Hemminger wrote:
> > On Wed, 23 Jul 2025 15:16:22 -0700
> > Jakub Kicinski <kuba@kernel.org> wrote:
> > >
> > > > Actually, we had used the common bonding driver 9 years ago. But it=
's
> > > > replaced by this kernel/netvsc based "transparent" bonding mode. Se=
e
> > > > the patches listed below.
> > > >
> > > > The user mode bonding scripts were unstable, and difficult to deliv=
er
> > > > & update for various distros. So Stephen developed the new "transpa=
rent"
> > > > bonding mode, which greatly improves the situation.
> > >
> > > I specifically highlighted systemd-networkd as the change in the user
> > > space landscape.
> >
> > Haiyang tried valiantly but getting every distro to do the right thing
> > with VF's bonding and hot plug was impossible to support.
>
> I understand, but I also don't want it to be an upstream Linux problem.
>
> Again, no other cloud provider seems to have this issue, AFAIU.
>

There's a failover module which is used by virtio-net now. Maybe
that's a good way for netvsc as well?

Thanks


