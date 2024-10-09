Return-Path: <netdev+bounces-133405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDD7995D11
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 03:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF2C1C21CAC
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5951D545;
	Wed,  9 Oct 2024 01:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWVsC8JT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766B9DF5C;
	Wed,  9 Oct 2024 01:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728437865; cv=none; b=U74IQttCSBb6j2QtVGiR+301wjccfn2qNs5WSVQzThes/08tB+1PYhQnnDK1/sh2BUvS8vlQyWKBuaVyy6F0RNKRVJMh/gwB6BoCJ2BNhCP+1svrRVMEPlgirYmwGJvmAN04FzchL6JBbSFxWc+b2/IPByh8oG/zyn9L3id/BkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728437865; c=relaxed/simple;
	bh=AC8IwYKlZAhnwoZcAD6OoeZEyUqbSufuj24gP/xiK1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKs6ub/TC6tBO59RByz8Z2eqI84fKJB7JFEButkk3D7+coxaIP387TpOVD7/hnZP3t0QOHPr2FakheBu6WlVerSj6NDwAWjBY7Nl5cuq1tbueAzLMDMRyvs+JH6JYzYYwlStA8aMjrD5SFBRj3hh0ujbOxGhVr0V/AfgSXXd73I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWVsC8JT; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e25cc9e94eeso5473419276.3;
        Tue, 08 Oct 2024 18:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728437863; x=1729042663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RS25rCHgbp954RpgJrtXdePW+X6k0WGqVouYZKkE5ds=;
        b=RWVsC8JTIbohMqHdLult+vB1jMHsi0zMOkeuLSqgBOzzCVJtvwk+eVc1gzyCj4Cp5w
         lTXVmT1P/Roih6qLPnF/MRexHFapJQ1lFrS1Vspxh4JNPDdryajbKlt1gCGXdkFpR/Cn
         ghF7GScjZyKEjyMWDtqA+QuLqUaS4TpHSSB0rDR/pugxw7HC2oe4MkRenOOYop6F4ei1
         1dQDAz1z5lY0DFS+tF9BywkyTTpqS++PP2X/Iw6VrhQT+LFosV6b24XOB7DmeCAt1M7G
         Vjh0w9kWOlvrmToVaGAw1bwBWfZaWrpRGSMGJB88I/MR0L+MBY5YBq7OfQNyAoS/xcmY
         B9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728437863; x=1729042663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RS25rCHgbp954RpgJrtXdePW+X6k0WGqVouYZKkE5ds=;
        b=wLmCcyiSKkmigVwty5hLWSihfjC1B5gtgXSV4rZWQq19b84tZ5ILPzV1UQHfw/w1N3
         WYkYi1mnWBR1FEtqDqhyRszI5vmzboWUz2iByk6WDiVoacvPgY6VEfFxz/uOn779z4S2
         Hmhi7V7ORcX8ARXAWN3jG9n7fRz9Zx1SRpB93Bw4Ch6RJLNzxmQazYPAvE6d3trXwU29
         2iA/hU1v0z5YVBZ9r4v9/yRXEmPDzQIyfP0GHuuiWldCTDoMeH3dSxr1T5QRXY9yQnhW
         ZLGgfnYvI+T0m1mKMN5eQb8tRd39+SMhc3HAx9NyJmTSbsYShTV3awSEwB9hDILfwMrM
         C86A==
X-Forwarded-Encrypted: i=1; AJvYcCWmwVjmUklAL25F0sE95NrqO665sxM4NI5Y97fjxsmEv/8AvlhrjhRO438bR5E1k97M6Z5DD26g@vger.kernel.org, AJvYcCXJQEjnsDE9frWVgdtuLfErzB0iuXfiJ9Ofk2tmvGYAwV98i5vKk89liy/AlvG3H4Eoz6VpJKMpyk/dF4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdnBRzcWVkX7G+J9PesXl18LvK34SGftGOFEk5CthudgbfeTuY
	btLWA0CQThkPe6co0DgT/5ZEuuMuDOWTLXIP63OmAbBmvDz5uwtOlqfsslEibzFGaqjzgsCErPE
	egHsYz58PSaLLsGPkyx7O7lMc5Y0=
X-Google-Smtp-Source: AGHT+IGXqaXDkVzInEgcQTMSVlyW15Rolm0VIc13duHSVUbMuqDQh02Kb0C6MXj1H4s8yqIRAGRoflEkHZOm9lc/kfE=
X-Received: by 2002:a05:6902:150d:b0:e26:3701:71fe with SMTP id
 3f1490d57ef6-e28fe409162mr816393276.42.1728437863317; Tue, 08 Oct 2024
 18:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008142300.236781-1-dongml2@chinatelecom.cn>
 <20241008142300.236781-9-dongml2@chinatelecom.cn> <ZwV0cjdg2x67URMx@debian>
In-Reply-To: <ZwV0cjdg2x67URMx@debian>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 9 Oct 2024 09:38:24 +0800
Message-ID: <CADxym3ZDkjuu9TJQ_vmbky75T+bn32XMrMhQRi=rVtxgRXC_Zw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 08/12] net: vxlan: use kfree_skb_reason() in vxlan_xmit()
To: Guillaume Nault <gnault@redhat.com>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com, 
	horms@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com, 
	bpoirier@nvidia.com, b.galvani@gmail.com, razor@blackwall.org, 
	petrm@nvidia.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:05=E2=80=AFAM Guillaume Nault <gnault@redhat.com> =
wrote:
>
> On Tue, Oct 08, 2024 at 10:22:56PM +0800, Menglong Dong wrote:
> > Replace kfree_skb() with kfree_skb_reason() in vxlan_xmit(). Following
> > new skb drop reasons are introduced for vxlan:
> >
> > /* no remote found for xmit */
> > SKB_DROP_REASON_VXLAN_NO_REMOTE
> > /* packet without necessary metadata reached a device which is in
> >  * "eternal" mode
>
> That should be "external" mode (with an "x").
>
> > +     /**
> > +      * @SKB_DROP_REASON_TUNNEL_TXINFO: packet without necessary metad=
ata
> > +      * reached a device which is in "eternal" mode.
>
> Here too.
>

Oh, my eyes!

I checked this document one by one, and I'm sure there
are no more typos besides this one.

And I'm sending the V7 now.

Thanks!
Menglong Dong

> > +      */
> > +     SKB_DROP_REASON_TUNNEL_TXINFO,
> >       /**
> >        * @SKB_DROP_REASON_LOCAL_MAC: the source MAC address is equal to
> >        * the MAC address of the local netdev.
> > --
> > 2.39.5
> >
>

