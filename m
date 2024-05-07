Return-Path: <netdev+bounces-94201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B42CA8BE98C
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692B61F21D60
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCA3171E7A;
	Tue,  7 May 2024 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hGI2abu1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73F217106A
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100012; cv=none; b=bqWOfcXnw7bn0+jVcKeo+9cUrLySsBCHwS+nr0kHfqkXgsfMLuuuU8k/+Lr+XiHdNW+MmqnPDDJHnzNrIYGbcuzoEkMm9QVNEfRUlMEvcvtZfknkDFLrBad9N4KWnP+vBRKSbEEz6PxmGxHRqKA4iDWvgFQYII7UGo5wwa4Nkis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100012; c=relaxed/simple;
	bh=lHC1+y+KekmBXlB1tJRRl7+woFnqZdOaCQlqzOHyFQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgdtX6Z6a5+1q+/NLRnxAPITe/zFmWVWmPMyczfDFQEeWlOnY8vVDZ9t1SXpiB06PwRr9bpOctXLkYbO5OL6Z5KvIQei7GjFPCqCTOImBCNlcBYYjpuoCEF5cr4TveyElkYrvtahuK8gdjxXVYCP1zfCTVbcXN6ZmVoOSUav4wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hGI2abu1; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso8a12.1
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 09:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715100009; x=1715704809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIrg31ctyp2ZeQISsms6z9r3scHm/8Noq+iUXRlh4n4=;
        b=hGI2abu1FwrnVYX01Kh/Gck6EQtHnCjj/HKG7evk37FlRlDJ5wbwwWEZ7plnUnYhaz
         wPHdud0DfzUIRV1VRsv15j3vZTCYQ0hwHjQn+49h/Ttv3hHzwm9qX1gDC7IohdwjLQDo
         bxlAsGEFf4T3q/foci0R1wwTE2b7WwnALh+giPiDHq3MS0Bz2puO60N0halYNDmZpKlV
         5Q7/9SBKha2m9sb3DsCYJYZQWyEACraakZzwO38kaotqAfHNCf9g/7LAKVsTIi+NdK6m
         OAH/EXeqy0INY2fZYg//FajNMOYD1SOQNS2mGLo6Np11qRyPPfVscA6rMPu/w5NPiiYD
         AZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715100009; x=1715704809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIrg31ctyp2ZeQISsms6z9r3scHm/8Noq+iUXRlh4n4=;
        b=WWwQC4vvk0oV2HfHsr/bCEtp3/jtVp9CMXs4o5lWniMN5bc5cOhbNiRURt6AgBSGbo
         tryFTY3fEasxZm1CL9dC3ALpQra9+wMrkeyEt7vDtU6/LxB41Dt+q1z4wGEF3rd3sx1K
         wJPf1uoHcefUjwGpyJuEgr7Tw7QjP1SW6pBzaksOltdyoioZmCGXTdyKNILXY/A1WECq
         zzBOnweQ1/0gQacz7icBvEI8K4GomqlH8X3+vUv6xuPnb1vH2s4QEKdpdqcNSlDWMNJk
         InWYMOnJaQSU7EPpzUxggYNBPYgmZBFyrQ84YbyY7mZu7X0ezGFXG6SS5PtAvDNZERFH
         iKFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIssEiqvMl7NGTVREADaQt/5LzJwhsdauRTxzZURq2yACgdwyI0nZv0OzIcnRK2z1qFe60i7N0//SPeWKURjYivFP8WUzY
X-Gm-Message-State: AOJu0YxxEVHQflvgtRLKsd1fXqVXljL5Ddof7ytKl95+E+5+PxeAH8WX
	qReC8JuA42xWmsI6K6YrYfoi9dBQDgBskNorIJKURUln3ltJKj2VrfOvC8Ze5ByqZjALRKw5hGe
	u1fWcQKasUEMXxYZPgpdc4C9SM8rSo+xzYJ9gbQg6D48HjEP6k4Zb
X-Google-Smtp-Source: AGHT+IGWjqjLWwh9XUyjWE4Y2MX3KlsKaHsn43J47r1rz0C5gSLKrdVPWbHmk3yO7vBVM4ieT0HilMDdXk8cntQD66s=
X-Received: by 2002:a50:cddc:0:b0:572:988f:2f38 with SMTP id
 4fb4d7f45d1cf-57311e083efmr234399a12.6.1715100007575; Tue, 07 May 2024
 09:40:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503192059.3884225-1-edumazet@google.com> <20240503192059.3884225-6-edumazet@google.com>
 <20240505144608.GB67882@kernel.org> <CANn89i+ZKZrbmqxKU33XgN_ZyqqkFa7+BqAqFWCYdj3He1Xy8g@mail.gmail.com>
 <20240505150616.GI67882@kernel.org> <CANn89iJO6mAkw5kDR5g7-NvpCZOGh9Ck1RePmXps60yK+55mSg@mail.gmail.com>
 <20240507163814.GE15955@kernel.org>
In-Reply-To: <20240507163814.GE15955@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 May 2024 18:39:54 +0200
Message-ID: <CANn89iLB9qZ77AY8ZMBST2FMqie8sPfHDUPUcg-GXMtkmAaoWw@mail.gmail.com>
Subject: Re: [PATCH net-next 5/8] rtnetlink: do not depend on RTNL for many attributes
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 6:38=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Sun, May 05, 2024 at 05:14:58PM +0200, Eric Dumazet wrote:
> > On Sun, May 5, 2024 at 5:06=E2=80=AFPM Simon Horman <horms@kernel.org> =
wrote:
> > >
> > > On Sun, May 05, 2024 at 05:00:10PM +0200, Eric Dumazet wrote:
> > > > On Sun, May 5, 2024 at 4:47=E2=80=AFPM Simon Horman <horms@kernel.o=
rg> wrote:
> > > > >
> > > > > On Fri, May 03, 2024 at 07:20:56PM +0000, Eric Dumazet wrote:
> > > > > > Following device fields can be read locklessly
> > > > > > in rtnl_fill_ifinfo() :
> > > > > >
> > > > > > type, ifindex, operstate, link_mode, mtu, min_mtu, max_mtu, gro=
up,
> > > > > > promiscuity, allmulti, num_tx_queues, gso_max_segs, gso_max_siz=
e,
> > > > > > gro_max_size, gso_ipv4_max_size, gro_ipv4_max_size, tso_max_siz=
e,
> > > > > > tso_max_segs, num_rx_queues.
> > > > >
> > > > > Hi Eric,
> > > > >
> > > > > * Regarding mtu, as the comment you added to sruct net_device
> > > > >   some time ago mentions, mtu is written in many places.
> > > > >
> > > > >   I'm wondering if, in particular wrt ndo_change_mtu implementati=
ons,
> > > > >   if some it is appropriate to add WRITE_ONCE() annotations.
> > > >
> > > > Sure thing. I called for these changes in commit
> > > > 501a90c94510 ("inet: protect against too small mtu values.")
> > > > when I said "Hopefully we will add the missing ones in followup pat=
ches."
> > >
> > > Ok, so basically it would be nice to add them,
> > > but they don't block progress of this patchset?
> >
> > A patch set adding WRITE_ONCE() on all dev->mtu would be great,
> > and seems orthogonal.
>
> Ack. I'm guessing an incremental approach to getting better coverage woul=
d
> be best. I'll add this to my todo list.

I sent a single patch about that already ;)

https://patchwork.kernel.org/project/netdevbpf/patch/20240506102812.3025432=
-1-edumazet@google.com/

Thanks !

