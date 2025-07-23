Return-Path: <netdev+bounces-209209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23070B0EA46
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C67B3A333C
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 06:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62E11F0991;
	Wed, 23 Jul 2025 06:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZ43+Gzf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB47D4685
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753250465; cv=none; b=pQypUwNsjtZDfOT/cPfAggUhjXkK4kVphZOrZg9wPtPLkZJk1iDiegWDjU1Tlbxoc0v3GB3bGXLlZepKeYzh/otwCOKW/vUVysp3Q1lXVZUHd/jsA63etefhJxsHTCPFBaq+pMCG4s59mtnWYFadYwVrjJYFqi6QB3PvWxL0R8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753250465; c=relaxed/simple;
	bh=W3OEZPSUScGaKIkoKNcKNemh+3UB9G5qvWLv5ZR7u3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlAw7mtt2UsG+PLd7Pc+8+o2kiwGgMJo03rNRDHmfmbHcIujPCuCiQJiKXgBabKRISj5EpCHLzOPayTslPGlYMKjUvdWRsTRRsDPHh+Uae2FqUANQWZxJ0JhTv4i86Irm1/2e9Wnps3PKzXcRL2AD+m4G6dQ2kMhy4HHypXZqi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NZ43+Gzf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753250462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W3OEZPSUScGaKIkoKNcKNemh+3UB9G5qvWLv5ZR7u3g=;
	b=NZ43+Gzffc6HWvzBF1z1tPjVn6iX4fjcqfxHjitMEtcyS9qd7DO2NFdrufq98KcKPmxSp2
	C4CqS5yUykAbHvyXKGwikciBlsBl0D0PJwqU5mL2tu5bN16+x0TgQPv5FKys5v7DprUgtK
	kbqVDGRdP4BYnCfgWTpqgNgetcij7sA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-AweV28KDMz2c2s4RxaVOmg-1; Wed, 23 Jul 2025 02:01:00 -0400
X-MC-Unique: AweV28KDMz2c2s4RxaVOmg-1
X-Mimecast-MFC-AGG-ID: AweV28KDMz2c2s4RxaVOmg_1753250459
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31cb5c75e00so576315a91.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 23:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753250459; x=1753855259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3OEZPSUScGaKIkoKNcKNemh+3UB9G5qvWLv5ZR7u3g=;
        b=lj5bWvB0aYu7lozuTnDTO5c9rZiIW3vC7cJq4g4TYy+eFgu9j488nopPIQKcrGnpqE
         +ejDYeDyn6qXAQUL1EUiic5dQ7I7cIggmZk6/4QQ219LIJji6wonzKgLXOGNW6ys/VxN
         gfJNza/plCrnFGRcLGVZyiNHnmiB86BV+iIxwHgFS0h87pNMykNp2LovXcK+asl+g9pK
         7q9t1aAarFEjo65E/EvEj5MqwqPlMagO63N5bz5A1DwkSFdwW1hSh10aMzCl1Lrpn6fg
         qcocCPSSp0V8WeH2SKQfn3hfdyCNo8zzjk8SFrcNR7yhC9f04DdJEfUJcYOkOZl1+TvD
         r1EA==
X-Forwarded-Encrypted: i=1; AJvYcCULNXw6baEF1AT7yYYlIFnzFM+vJKeU2z4H0U85BxaVDW/APotgNiShwlwCe/4yRRy7JmdQqno=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGRBKmqb9f/rqrCND0gspdckUcsbOcG1b324me4XDI6gXmyvbx
	51m1i+OYifuvoryI+rjaliQuAdUTTTwuAc/zOyhDSUWRHneuAj3NAMo1dnKdBApHqMD8DEXJJ4s
	ixbzzOO3Q/as8MYrOcB+Dq6jHRM8tFWiW3snML3oCX7cGZEQFqwbFBLYtaLAJIPj9SOddhLaExR
	4/I6dDpxQ0qC1nlNQmVPWZ90NjTdC95MMD
X-Gm-Gg: ASbGncsdAsxWBBrdfTXt42BKsKa4UFmomRkbpRp1V1em1syFgt1rbP54K3z+eWELAMf
	J9zO6no8I1QvqUDtroY5dzP+VZxrUQOjC7sZEd/2e0arGAkn0cn+KhBlPr3yxfDyhX9yOzLchVh
	T7V2AHWEqJqLSm9Tav284=
X-Received: by 2002:a17:90b:1c8d:b0:31a:8dc4:b5bf with SMTP id 98e67ed59e1d1-31e3e218aaemr8741149a91.17.1753250458804;
        Tue, 22 Jul 2025 23:00:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfliq5NGtPU/ziGbtu8YM4b/iq3mmjjPMpvlbkNtkuESyW0l9icnltubphyWJS/Lk+K+taORz5U6WVf0EI7c4=
X-Received: by 2002:a17:90b:1c8d:b0:31a:8dc4:b5bf with SMTP id
 98e67ed59e1d1-31e3e218aaemr8741094a91.17.1753250458228; Tue, 22 Jul 2025
 23:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718061812.238412-1-lulu@redhat.com> <20250721162834.484d352a@kernel.org>
 <CACGkMEtqhjTjdxPc=eqMxPNKFsKKA+5YP+uqWtonm=onm0gCrg@mail.gmail.com> <20250721181807.752af6a4@kernel.org>
In-Reply-To: <20250721181807.752af6a4@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Jul 2025 14:00:47 +0800
X-Gm-Features: Ac12FXwsu5AMgm40YID7nIeVAKGIxY3SiYvCb26wbwKJM0nbVKa8OQafZHUHruE
Message-ID: <CACGkMEtEvkSaYP1s+jq-3RPrX_GAr1gQ+b=b4oytw9_dGnSc_w@mail.gmail.com>
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

On Tue, Jul 22, 2025 at 9:18=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 22 Jul 2025 09:04:20 +0800 Jason Wang wrote:
> > On Tue, Jul 22, 2025 at 7:28=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > On Fri, 18 Jul 2025 14:17:55 +0800 Cindy Lu wrote:
> > > > Subject: [PATCH RESEND] netvsc: transfer lower device max tso size
> > >
> > > You say RESEND but I don't see a link to previous posting anywhere.
>
> Someone should respond to this part, please.
>
> > > I'd rather we didn't extend the magic behavior of hyperv/netvsc any
> > > further.
> >
> > Are you referring to the netdev coupling model of the VF acceleration?
>
> Yes, it tries to apply whole bunch of policy automatically in
> the kernel.
>
> > > We have enough problems with it.
> >
> > But this fixes a real problem, otherwise nested VM performance will be
> > broken due to the GSO software segmentation.
>
> Perhaps, possibly, a migration plan can be devised, away from the
> netvsc model, so we don't have to deal with nuggets of joy like:
> https://lore.kernel.org/all/1752870014-28909-1-git-send-email-haiyangz@li=
nux.microsoft.com/

Btw, if I understand this correctly. This is for future development so
it's not a blocker for this patch?

Thanks

>


