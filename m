Return-Path: <netdev+bounces-89010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C846E8A9397
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84DD42812A3
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 06:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EA436AFB;
	Thu, 18 Apr 2024 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tKNIwxdG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633322D057
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 06:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423419; cv=none; b=l66D9ihDGJXRfXvzHWIFWoG3HfYmcK6+/bWe2R3NRn02HP4wrOGsDJOY4ZDJ7t4p26j8r1jQKNbaUsHSqi18SaM9PAxuD8L7+l2KtM2dor9ZNhlYlLzi6P3kLLNnc/hEsd19IkA6RtDbieN68L42rX0Z+UhH8FhK7kPCLy8ZTps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423419; c=relaxed/simple;
	bh=FkiONaaSfg15j7j0QfFyOq+w9xjh3wwRlMurFlu7AIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcD4oQCooDSDSoOzNcDmIWuxpxKL/8Rey30uTyy0OqK0icl0zuj2abMSza6BWTwPndG921Obhe4yNxl1tAzk95utFrQhqbhCHFfIhC7rapzsO9c7JZ0K2cte0y5czhXHSnuWcm2+cn4U1/WZApnDqkAsKkh325E7Dc9CUypTq/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tKNIwxdG; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56fd95160e5so5055a12.0
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 23:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713423417; x=1714028217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkiONaaSfg15j7j0QfFyOq+w9xjh3wwRlMurFlu7AIM=;
        b=tKNIwxdGMHOI8M7OAOB7zEXcmf+Jm3sLKQbM9gLCfFoeOFMju0fwOClkFcUGcYpsWC
         1+OGQuqxIxl2sfDF571mWGbOGefnuIwV0F62QCrEcjs+K0g4sgp1zdIpv0Vz3BQlttWr
         ISl+cCKAydEKJaNqx7vcwun6pkdp9b4yGHoFKf2jJi1ajwEYZPO9aZM67BauGTPUxfwW
         GRM8sKNBD4M2vXI94MvRdtkLKjejlUey7foSiBhd93HkYsyHJFxEAZ+609q5LhCZQIRd
         2o8CdXr35QqhwRyE0XIvWVLFasfL8s9G4zmgXToJoq9+m+gMCRekSzyF6UXoeFRvbbHh
         omYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713423417; x=1714028217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkiONaaSfg15j7j0QfFyOq+w9xjh3wwRlMurFlu7AIM=;
        b=TCZiimGfWmLhA5uNcjkK1/52cDzM7akhzif9GGlKov720cxWdwTHojsOqzmG+yBGKg
         8JunXzywDS+RJLE10ba4xDl2Pc6L3/OCwFK2uLGFbNXiNUNZMiBSM9ExqKEQLoCSnywV
         1J+B7Sha+OQ0LIPf39x2P4C+IjjXLlE8NBLjn11VGYbGxGZ2thJbAJ38OSu/IRiMUN1S
         cIzXL6gni1eOxsuO6Ry4pRL1aaQfmogUlvxiYlsavty1jAI558UHHeq9RV8+JPLvXoHN
         bIrVDdcCwNVwB1qQPYeDqtnvNcy761zxQyUorgC9AdY9kvlpkKOtxlazkOiOo+igEaE/
         5V0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTgf1Vr7YxnvhH8AxkG6uNhQucEgmElwgXswphIbJpr6gPZJfKsFJXTmPFgyA4hCxtkgoI5HIk/H6MYTyLIJnHxffba346
X-Gm-Message-State: AOJu0YyMFR50x2gzx55JHS5EaFFh4/N6AYlkVsmgYkuhc+F5YtP2V3PV
	T80FXYGEhPePHfHFNMlM5pdrwT14rxBSOP0G95KJI/TI2+iEswNWSQxI/T3kJ+LHgD1/psgZ8wM
	oclzKEigmniLjcOLptcK8B+Ea13LDIP3j+VYe
X-Google-Smtp-Source: AGHT+IFG0aQioFFiJzn2yOBEB47RnERJzFsIr8ky0Zr96UgDShoqZQI+2jXVwnqVVkK2WpdErEVr1LviFLw1sP+PZGc=
X-Received: by 2002:a50:ff08:0:b0:570:5cb3:b98 with SMTP id
 a8-20020a50ff08000000b005705cb30b98mr114332edu.4.1713423416447; Wed, 17 Apr
 2024 23:56:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417190432.5d9dc732@kernel.org> <20240418033145.35894-1-kuniyu@amazon.com>
In-Reply-To: <20240418033145.35894-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Apr 2024 08:56:45 +0200
Message-ID: <CANn89i+y8yqXZ3OHdzo5FxgwNs-j24-4wiNZKr8pSG+tvbYV9g@mail.gmail.com>
Subject: Re: [PATCH v1 net 1/5] sit: Pull header after checking skb->protocol
 in sit_tunnel_xmit().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: kuba@kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	herbert@gondor.apana.org.au, kuni1840@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, steffen.klassert@secunet.com, syzkaller@googlegroups.com, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 5:32=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Wed, 17 Apr 2024 19:04:32 -0700
> > On Mon, 15 Apr 2024 15:20:37 -0700 Kuniyuki Iwashima wrote:
> > > syzkaller crafted a GSO packet of ETH_P_8021AD + ETH_P_NSH and sent i=
t
> > > over sit0.
> > >
> > > After nsh_gso_segment(), skb->data - skb->head was 138, on the other
> > > hand, skb->network_header was 128.
> >
> > is data offset > skb->network_header valid at this stage?
> > Can't we drop these packets instead?
>
> I think that needs another fix on the NSH side.
>
> But even with that, we can still pass valid L2 skb to sit_tunnel_xmit()
> and friends, and then we should just drop it there without calling
> pskb_inet_may_pull() that should not be called for non-IP skb.

I dislike this patch series. I had this NSH bug for a while in my
queue, the bug is in NSH.

Also I added skb_vlan_inet_prepare() recently for a similar issue.

