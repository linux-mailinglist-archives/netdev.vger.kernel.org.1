Return-Path: <netdev+bounces-219824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 918ACB432C8
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 08:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0745C1883730
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 06:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9065F28541F;
	Thu,  4 Sep 2025 06:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFFtKopd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F61285069
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968585; cv=none; b=YDPEPKFYba/HcCryuKqdgy9dbDUkvr+wATvOxBpgR4q8Yw+2MqDIU7ysbmYbsB/FPdAIFC8bi80LoI1xqXxtYk170j8aP+NDhLgmI2YXLbUYgsZkMvxrxBZrR5njqStNOVZjl7XGG9zwukp2WISOL+m3vD1R95F5S9otqDCANKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968585; c=relaxed/simple;
	bh=Mjve9as+XeiIpu4AGRqn4u8NIiTcc7YxtMIECHZ8YKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+PtadHo84Gm98DN/4HCer+xT0W3twb1haGKxgd/alMdTKQDddXSmFRjNdcg7nBUTKkoXh7yBPiqXuHHLq2p4tPo9dfJ8aRJbFkleR0JTxpgtwI5R17xiQdsf9nkZxdBDyOOnHXqYiZxgfvR9FbDsE8kINescx0pSztURvQTJWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFFtKopd; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3f663225a2bso5605985ab.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 23:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756968583; x=1757573383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mjve9as+XeiIpu4AGRqn4u8NIiTcc7YxtMIECHZ8YKE=;
        b=IFFtKopdNnN5qCxZH79CpW3iG+0jrW1BiIZqGTqZJ3rWQTBz7SQWq3ef4CQBJqnIPM
         oyLYiuO9YiKctaNygzgbfywQX+pB7ThlgaYxq8p+wFQcPT5CtZwl21CJ6cf5MUk6rtsj
         cEwi67oi3FVSNVEuIhe4eoxnxxlVqjTVJwKrXwWhXaD8/JgDhfgGnp+QefnbHbkZ5TCh
         JF4DTdGgQHQow+o7sVl46ELEFhpprT2cwKfDheKMIly+GPYDnrxUbhN7jYnjft2YBM8r
         72yNgfrSmvmHvzcimrXBljPUwBW5osSm7xONXoeoO5wuTDufed6Bmfd1tBwfO+X1TGcZ
         tK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968583; x=1757573383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mjve9as+XeiIpu4AGRqn4u8NIiTcc7YxtMIECHZ8YKE=;
        b=RTivkE1fWBZJwfxHPPcIgf3rjAaE4exBYGZFXY0lhMfivh6OXjuGcGkaxLqqiPobN9
         1K1NgKIrTjieQLR1AXwT84wSnpzrt74veDiX/O6ESGKGthCKhLBi2kVGKHbVveNcZCHo
         MhLFJxSNfZ3537hkHt4+2FTiz02T+kMk/De/um0l+c4IB/Po6IY4mJ5yamOmgrOCOuTd
         N8xm3EDEMOWfqWLA6gOYPifyY+jjCFc2nxHGlHAc0Y6lDBufpo18dYiJ1Wo9mWqE+xQ6
         8R0NrVZQ7KGPm1n7FCRnYot1dOcKiU115VEshEfL9k1iRXRqauIZHqxCW1E2vh2icQjR
         znuA==
X-Forwarded-Encrypted: i=1; AJvYcCXNqQagAVPMWunnxfdbKw/d6w5HkxNbzY3Z8eVk7oQabfpkToz6eMP0UEPkQRA8gR+jFLzAGCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxd+O/4VMrg5WzozWh4mlVCgHNQbVpGdWHEZxgUaH7JHus+I1S
	mn5IliJx3URBh8ZD6IVD5BHiCM/yMvKUJtQ5PXaKWZPFu38x2OL8CrHoLMwGWPJSM5dtJUwieqh
	5q3IIsxLRDMKQ5bh7v5+ajUwmX11SwaA=
X-Gm-Gg: ASbGncsHBxUTyhf6EH5G+Ve6xFxDvIcXaNoSH7c2gsgx18nl3HUCEUx1u6lr5vjSkRs
	qC7xsLwyBMQgeaBefoWfrv9u31Vqo724HNUw20NTVCCFVhD4ZW7zwjxLqc0I3mXyAKFDrVEfqxW
	hGfjA7W4dIXFlw+TO6azYmEO8priNVuF+cyAQfsrrda1kjLs1Iz7sD+pZYhF6sfuR2kM+AXt+Vd
	BbTcVc=
X-Google-Smtp-Source: AGHT+IGEeJyHTblpykuHQu4g3FUHHuhXizIB5I/cX8I++TYM3nF2bQWsC8dz5vgCxjpcdjZrFOVjFGE+fqVSAh7PCDk=
X-Received: by 2002:a05:6e02:144c:b0:3f3:cd20:d7e4 with SMTP id
 e9e14a558f8ab-3f3ffda2be4mr313977075ab.1.1756968583123; Wed, 03 Sep 2025
 23:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903084720.1168904-1-edumazet@google.com> <20250903084720.1168904-2-edumazet@google.com>
 <CAL+tcoCqey97QW=7n_S8V9t-haSe=mu9iE1sAaDmPPJ+1BkysA@mail.gmail.com>
 <CAAVpQUBgCyC+y+2M7=WKJVk=sivgeZtE2kwCxDLFCrgezycjZg@mail.gmail.com>
 <CAL+tcoBJxe6GkosVCS5Vzwk_z8W1WmxqLFELzXNwCRSYkQUyHw@mail.gmail.com> <CANn89iLO1JOw8LKoxAYm5M_tXDFyiSVhEovOPsSf9H08gPwj_Q@mail.gmail.com>
In-Reply-To: <CANn89iLO1JOw8LKoxAYm5M_tXDFyiSVhEovOPsSf9H08gPwj_Q@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 4 Sep 2025 14:49:07 +0800
X-Gm-Features: Ac12FXwMWZ5vK3YAHtyRE0U3uRDuNk6V1hWJ7W7gu6NgzxQL7NOu8q3d5SzZG_c
Message-ID: <CAL+tcoBT8=w9qHZC+P3nV5F2p7q4-r--aDFSn-TnQLMLkavLwg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] tcp: fix __tcp_close() to only send RST when required
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 2:44=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, Sep 3, 2025 at 11:19=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Thu, Sep 4, 2025 at 1:32=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> > >
> > > On Wed, Sep 3, 2025 at 10:04=E2=80=AFPM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > On Wed, Sep 3, 2025 at 4:47=E2=80=AFPM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > > >
> > > > > If the receive queue contains payload that was already
> > > > > received, __tcp_close() can send an unexpected RST.
> > > > >
> > > > > Refine the code to take tp->copied_seq into account,
> > > > > as we already do in tcp recvmsg().
> > > > >
> > > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > >
> > > > Sorry, Eric. I might be wrong, and I don't think it's a bugfix for =
now.
> > > >
> > > > IIUC, it's not possible that one skb stays in the receive queue and
> > > > all of the data has been consumed in tcp_recvmsg() unless it's
> > > > MSG_PEEK mode. So my understanding is that the patch tries to cover
> > > > the case where partial data of skb is read by applications and the
> > > > whole skb has not been unlinked from the receive queue yet. Sure, a=
s
> > > > we can learn from tcp_sendsmg(), skb can be partially read.
> > >
> > > You can find a clear example in patch 2 that this patch fixes.
> >
> > Oh, great, a very interesting corner case: resending data with FIN....
>
> Linux TCP stack under memory pressure can do that BTW, no need for
> another implementation :)
>
> tcp_send_fin()

Thank you, Eric!

