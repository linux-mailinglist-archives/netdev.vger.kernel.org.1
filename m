Return-Path: <netdev+bounces-208763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB08B0CFDB
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 04:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CD71AA7EC1
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 02:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D2D270ECF;
	Tue, 22 Jul 2025 02:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sc8Ovpcm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B7627146B
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 02:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753152438; cv=none; b=gdxDveNjZAzfnl3iEGLfd9IPciWsFderlDRoHZJEYQNVjmhlOxaBBhFfnr+rRsSpvWK8kQBWtbNpge/OVfeXBU/6NPEg0UFi2MqrykUYtiEpOnZywwtcx0U86Ipvh8h4BO3DznGpBkPry6YT+3GwDdz7G6dLIM81M2q7ip9fmCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753152438; c=relaxed/simple;
	bh=kCKyEvyaME9w7wWZPjOrMFKwm0hXVrCcUoazmS1Oke8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bt2dKm2vqBAog5H4sxdsVKO/wSvokmFr60ZWsfRe8SBMqeq+n/8i58j5EXeIkLpPcS1/Lhbe2+0jjQWbDWXjTVw0nujmTFm0yyQvJK5/BHRWoZEqHW4MwvTe/krJiqZKRERmEGI++8AoAS84dpNASoQ1s7M3FIChCKHrvV0IYVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sc8Ovpcm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753152435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kCKyEvyaME9w7wWZPjOrMFKwm0hXVrCcUoazmS1Oke8=;
	b=Sc8Ovpcm5JMq3fCjg5vzDNfeF5GyBB/2iglH8gKWxtbammGMX3SMI3/yrgzIt1b8ElUjkk
	NS7YugsNoq8C3GUyTv2oU7N+Ijalf1/70GEnIuYBcrssXwFaSo8c4Ld+kX/YJWVWcOjsiG
	kgww5ClZB5STvcj38TM2fL7XNK9x9c4=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-cL0zNs8xMGSbEnMfkyV7vg-1; Mon, 21 Jul 2025 22:47:09 -0400
X-MC-Unique: cL0zNs8xMGSbEnMfkyV7vg-1
X-Mimecast-MFC-AGG-ID: cL0zNs8xMGSbEnMfkyV7vg_1753152428
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5331c1d1683so1045436e0c.3
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 19:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753152428; x=1753757228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCKyEvyaME9w7wWZPjOrMFKwm0hXVrCcUoazmS1Oke8=;
        b=ZMPZUloBGEo9SAZ6RNGmLtPjue+SfEHkGpRajUN84MVB+YmyJOaUOwv7bB3dCk3nxL
         7HpIP93pOz+cdtKV/zYfnA5lm2ykykJ1c0zp3U76M+Pvk/w0a9rqdzDO6vCLgNzfr+hx
         W/jjWLMMKIVxbaWqufHVz92FoWP69LDY9l3ykNM71kXjnozckCCvW91NrkQaJBad6gvg
         i1EaTELahqt4rAPKJD+IZhBxm5+n9lD2G2WMt6vhIemhJ9xWzmYx7ZRPYekZh1qIrgk5
         yFfyDEsJvfzRKvdmcWUf3k3WwwNQC8Dcq6fBk4TvE94IfBsvBES271luxCPz4d524PPj
         ltWw==
X-Forwarded-Encrypted: i=1; AJvYcCXrHKj3+I8ioxyj/y5cb38BPQmMGn+VVST5qZuTVyTXV0WJ+xuCGTOrE5wbsSFHHdJPR4CHHiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqakwqjyv1QiTogSKmPz9XyvoppCHCe+YxPnNbxWtvN+qMf0kV
	FAVR5+ic65cpYwLTRMmxZGSk289Yfm1CRG0rKd9NFp633svVip0husvIzDKi5bOnmltS5mi1cdx
	n3zzyCJWAQPlw+fYv62Tl6RipQTz0aI2wTU+FaqsP4eyC1FP6HbQfPzK0GRDGY5I7/k/0QArx06
	1zb+xYVCaKLE/jXXrr24m39WmZrUwhl4KP
X-Gm-Gg: ASbGncvwgG5k6zrDJ5gT2C+2Ndg8iLZDaSTon3LfyOfQkAWQKFkgEzvmLU65XCX8CTT
	HShcudNudXUUoDkwiv38l6pAD0dlhcR4oRMg43vLgBQf4+//02Slr4fj01bJ+ddxJGAfupulSAW
	2NiSv42LzE8ug1lTdAViiGWA==
X-Received: by 2002:a05:6122:3d10:b0:537:3e5b:9f66 with SMTP id 71dfb90a1353d-5376482147bmr5706735e0c.12.1753152428498;
        Mon, 21 Jul 2025 19:47:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV65GEf/DyozjXmm0Me0cAGFvEFM6aRW6c2q/EOZGLutJWdB5Vun7O3DOic039V936BGNXEekLH8idxFs57TU=
X-Received: by 2002:a05:6122:3d10:b0:537:3e5b:9f66 with SMTP id
 71dfb90a1353d-5376482147bmr5706727e0c.12.1753152428170; Mon, 21 Jul 2025
 19:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718061812.238412-1-lulu@redhat.com> <20250721162834.484d352a@kernel.org>
 <CACGkMEtqhjTjdxPc=eqMxPNKFsKKA+5YP+uqWtonm=onm0gCrg@mail.gmail.com>
 <20250721181807.752af6a4@kernel.org> <CACLfguXG7Mpsp=z4zCE7H4CMA_s9qV86SkeL7Q=WxChXcFpNfA@mail.gmail.com>
In-Reply-To: <CACLfguXG7Mpsp=z4zCE7H4CMA_s9qV86SkeL7Q=WxChXcFpNfA@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 22 Jul 2025 10:46:29 +0800
X-Gm-Features: Ac12FXz8Hsd99YwjuM8V3mxzon1LCiQIo6XR6UICD1OlRmKkbYUpCVM_dl99qBs
Message-ID: <CACLfguVi=+ZtikBwu-5ThEa095gDuCW8bVPo0QGdt6ja3xZjhg@mail.gmail.com>
Subject: Re: [PATCH RESEND] netvsc: transfer lower device max tso size
To: Jakub Kicinski <kuba@kernel.org>, Long Li <longli@microsoft.com>, stephen@networkplumber.org
Cc: Jason Wang <jasowang@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
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

On Tue, Jul 22, 2025 at 10:04=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> On Tue, Jul 22, 2025 at 9:18=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Tue, 22 Jul 2025 09:04:20 +0800 Jason Wang wrote:
> > > On Tue, Jul 22, 2025 at 7:28=E2=80=AFAM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> > > > On Fri, 18 Jul 2025 14:17:55 +0800 Cindy Lu wrote:
> > > > > Subject: [PATCH RESEND] netvsc: transfer lower device max tso siz=
e
> > > >
> > > > You say RESEND but I don't see a link to previous posting anywhere.
> >
> > Someone should respond to this part, please.
> >
> Hi Jakub,
> sorry for the confusion. I previously sent this mail
> (https://lore.kernel.org/all/20250718060615.237986-1-lulu@redhat.com/)
> to the wrong mailing list, so I'm resended it here.
> I've also submitted a v2 of this patch:
> https://lore.kernel.org/all/20250718082909.243488-1-lulu@redhat.com/
> Sorry again for the mix-up.
> thanks
>
> cindy
>
> > > > I'd rather we didn't extend the magic behavior of hyperv/netvsc any
> > > > further.
> > >
> > > Are you referring to the netdev coupling model of the VF acceleration=
?
> >
> > Yes, it tries to apply whole bunch of policy automatically in
> > the kernel.
> >
> > > > We have enough problems with it.
> > >
> > > But this fixes a real problem, otherwise nested VM performance will b=
e
> > > broken due to the GSO software segmentation.
> >
> > Perhaps, possibly, a migration plan can be devised, away from the
> > netvsc model, so we don't have to deal with nuggets of joy like:
> > https://lore.kernel.org/all/1752870014-28909-1-git-send-email-haiyangz@=
linux.microsoft.com/

I'm also including Stephen Hemminger and Long Li in this thread and
would greatly appreciate any suggestions.

Thanks
cindy

> >


