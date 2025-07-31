Return-Path: <netdev+bounces-211109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A771AB169DC
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 03:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DC45A4FA0
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 01:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4A613D24D;
	Thu, 31 Jul 2025 01:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gS166KaG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ABF78F45
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 01:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753924065; cv=none; b=hjHZFA9wtzWDw+yMS2hkAP+cKpoqBgzt25uMJ3b8a6578B6dzDGQHppEfLQSpaWOpLr8WH0T2Bzz72iJ7+nHFGvJaNej1Aww+X1YmeAsTyDxAfHePm4cU3ZGGo0lTB6mACnPKL6Qd3wTt2SvE/TFio2uOhbvDYn/cvDjGEi/n7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753924065; c=relaxed/simple;
	bh=RwCqBhqd4SGtljt8ozavaYhxd2dZWBQTZl0x74OfiRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=teykxFGofpaI48DcuXlVuLG7ZSaYxwuhMLU7VtIfFWwD0mLmE/0dhrAJmGAAflyKeFoI0e6GbxSNAYA1BDSn0Fac3wR5pP33O5fFw8WZX1M+e5WhvRkxsBbYtt8gB1uU7Zoz36xQ7F+aZszM1pwFu7/sd4hSvg68xJQvaQaaWTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gS166KaG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753924062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RwCqBhqd4SGtljt8ozavaYhxd2dZWBQTZl0x74OfiRg=;
	b=gS166KaGpyyu5CZBt6Ly4KJUGXrppjmkRCIL+50O5O06A1mz1lNpdv9B4fOg5CPfzHSHJm
	/OrCAyH2lmbh4K5Wa5wtNDRxiKGd6v1ICJRWuIPk07UnpEdMQsLpZQpwOGflzZK/evOTEa
	ppJkkLAFLj2pjb0/uGwNmyzDWU2p2dE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-phqTXxeeP7-1G_9unGYBAw-1; Wed, 30 Jul 2025 21:07:40 -0400
X-MC-Unique: phqTXxeeP7-1G_9unGYBAw-1
X-Mimecast-MFC-AGG-ID: phqTXxeeP7-1G_9unGYBAw_1753924060
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31327b2f8e4so479766a91.1
        for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 18:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753924060; x=1754528860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwCqBhqd4SGtljt8ozavaYhxd2dZWBQTZl0x74OfiRg=;
        b=RzgPvOMdDyJWS27p/QJuMHlTnz+WoHHN32dknpmjG7aycxHEB8Dzb72KLJaGYlq1/D
         hxl6HGKzedxTOkaxflgE6ozLVdfcBafWwaHyamitGYk079Abe3ATBaKRkPp3rOZywNt2
         mtB17KGYxijeUQUJGY2dKSjlHNK4k+T+a0ql5YYPE5vCtyrbRET/nLpkF94GvcwE1l+w
         f7ocdlcHlxGPcOxJeeKzExpywP03wz2AQQDyktHWH9YjQoD9xhlEexbl0zuYlBkidu7P
         R5m7ee7fDM5sUMA/64gQ7gmCp290C3jf1ZNeNsSMMEH0aettCMLC1mJeoGX8zKXoG3RF
         4w/w==
X-Forwarded-Encrypted: i=1; AJvYcCVVf1wsQBXwsSjudVTCmWOtWjhv+N2UQw49n0uRUPna9D499aMnSb7QfrfKqkqnNAraqOB8DHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJsaEXki5mQ/DYeaQy5awDnivqm5d6mmeEIUINT8TeUwAEAdlI
	1TlqlWyTEJer4eQZdgl+zm/xd/8ae5qAfxYQW0j27vt67mgV0MSkUujIMjRGiCHNKIlBwgYsGDT
	iqYA9Es7PXcdgXSdLpD89kl1XAv8rW4aWiled/6jOt4nRYCFedWd3SfhZE5aoMhdKfcQU1vYIhb
	lxYcljce3p1LUirdaipXeCRWFBm12Gxyz2
X-Gm-Gg: ASbGncsla6/rlIg0Fj3IY1rEAEEO0CohHlxBPWDk8TjGZbrPDo3Z/aXGYi4O1PMNKRQ
	e3tKWJlGzQz4iiXCW0rUhUywntFasK+7TVED6eNiV9gF7GlgxWn85kNvSFmcu4mQqoP/I3lfTmE
	q1GFQgzwMsQ4v2tg5ioho=
X-Received: by 2002:a17:90b:4b11:b0:313:5d2f:54f8 with SMTP id 98e67ed59e1d1-31f5ea6b571mr8104410a91.33.1753924059802;
        Wed, 30 Jul 2025 18:07:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBTkvTlCrxS4KqWqX9J2caauKKosURWKkzL9ddM8eH3KW10NDC7rPZNwPk748PPfO7GuO55un+fWqFpNss2fo=
X-Received: by 2002:a17:90b:4b11:b0:313:5d2f:54f8 with SMTP id
 98e67ed59e1d1-31f5ea6b571mr8104373a91.33.1753924059373; Wed, 30 Jul 2025
 18:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718061812.238412-1-lulu@redhat.com> <20250721162834.484d352a@kernel.org>
 <CACGkMEtqhjTjdxPc=eqMxPNKFsKKA+5YP+uqWtonm=onm0gCrg@mail.gmail.com>
 <20250721181807.752af6a4@kernel.org> <CACGkMEtEvkSaYP1s+jq-3RPrX_GAr1gQ+b=b4oytw9_dGnSc_w@mail.gmail.com>
 <20250723080532.53ecc4f1@kernel.org>
In-Reply-To: <20250723080532.53ecc4f1@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 31 Jul 2025 09:07:27 +0800
X-Gm-Features: Ac12FXyltfKnkJ6WA6PQZrqMC6on4IVMKH4G4mZZ6ShVaStyC948R-LQlIsa18c
Message-ID: <CACGkMEuvBU+ke7Pu1yGyhkzpr_hjSEJTq+PcV1jbZWcBFm-k1w@mail.gmail.com>
Subject: Re: [PATCH RESEND] netvsc: transfer lower device max tso size
To: Jakub Kicinski <kuba@kernel.org>
Cc: Cindy Lu <lulu@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
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

Hi Jakub,

On Wed, Jul 23, 2025 at 11:05=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 23 Jul 2025 14:00:47 +0800 Jason Wang wrote:
> > > > But this fixes a real problem, otherwise nested VM performance will=
 be
> > > > broken due to the GSO software segmentation.
> > >
> > > Perhaps, possibly, a migration plan can be devised, away from the
> > > netvsc model, so we don't have to deal with nuggets of joy like:
> > > https://lore.kernel.org/all/1752870014-28909-1-git-send-email-haiyang=
z@linux.microsoft.com/
> >
> > Btw, if I understand this correctly. This is for future development so
> > it's not a blocker for this patch?
>
> Not a blocker, I'm just giving an example of the netvsc auto-weirdness
> being a source of tech debt and bugs. Commit d7501e076d859d is another
> recent one off the top of my head. IIUC systemd-networkd is broadly
> deployed now. It'd be great if there was some migration plan for moving
> this sort of VM auto-bonding to user space (with the use of the common
> bonding driver, not each hypervisor rolling its own).
>

Please let me know if you want to merge this patch or not. If not, how
to proceed.

Thanks


