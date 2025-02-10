Return-Path: <netdev+bounces-164851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5606FA2F5F6
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 18:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D2C07A1310
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 17:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4C125B681;
	Mon, 10 Feb 2025 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpuaa0yf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7079A25B67C
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739210034; cv=none; b=D1SLHdjrpkwqLXQadGJpkLAngS/QD6yGxEYI6bNymdoQcl1PlC0ZDDRA8bwu76t39BgErqRdmDUQafVnhzGdjNK+/bYyEPdRmu3CGmEtbwpAYQMiw3IuI8VavstkPanoXsqaVbVS7aHcrEAQw/1rfNC1f20R4lWl9J7Gn2kHUp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739210034; c=relaxed/simple;
	bh=bgeZpMFHhz62bjvqjwJBaVQNpGJqGN7TfZxGrwLKInE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NRpexKvKHva0H90GrcZDCmAI7BJVqxp3AN9+K24wFopl5YaNlCq6D1F1mwzcSBXYutihe0fpL2W7HLdnZqADnELuwkdQvHX83zQV3d2OxuStNkBoQz5LTq2xn3pYPMOvn5uUlvI4+TMTcO7xZBmNN78KG6rE9NtBM/s7vcCCWpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpuaa0yf; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e46349b7daso10736376d6.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739210031; x=1739814831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLjYymE8tVGDqk5DHyDcLICzEkzNaB9NUHnfroBa+1k=;
        b=gpuaa0yfdiB4/po+IFgS/Um0zNgBA5ehRJ39M2ErEdrjh4hOm4P670qBiahzDici8Z
         Adug18uEWPIbz2/0H5wZOPnLp4HBSSZBW98Un7nr2WDNtGClqYLeJFJ/tgaepUjS60zD
         twioXjZCMS0ZOc98r7kKJhiTegjpIiKGjiXrUlO4XsVJI1c1jWhPabtofT9MkiVHPVbB
         d9/Gc6n5aR9a3mtnmlHtt1CpsZkyMxkTlUttBgm9OabWIvefaFr+vYElM4chhY6+30VG
         bbqOxynbcHRf4hBKma5hSu2fjA57LWwE4r2rPH8Gf+KGosduvuggAL1sDZCM9PA/djuk
         +jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739210031; x=1739814831;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VLjYymE8tVGDqk5DHyDcLICzEkzNaB9NUHnfroBa+1k=;
        b=oHU+VXt8LDOn1XmPsydb9n8BRiC5ZQO8eqjRzxMllfhnYi1xenNT7WYTg80AtBoAPy
         YiTLcjWiqdAWm2rtcHlQ3QqEs5PCcUMjv1TMeUpCXzdfTpvDg3eGtSPUJrZzb7oViQlY
         /ywrC7gWd422LfqHmIFPZgkXmvlVQyoyp4zWwjtkAzbattmauKCk9tMqyg0YTTc3vUe9
         1rjCow9m5YtrIu+8Jl8DdmS+lvw6PLZF6rEwkDGTqTkZ12qiO6Lc/TvcYu9G9Sf+X0X2
         XfMHTI/QZj8/fTfDt23vMoMQ98tUpH3+7HhX6I7NXrpHOgev4BFgS72KCJENFatLk4+F
         uLXg==
X-Forwarded-Encrypted: i=1; AJvYcCULIPtBH/GySS1RS/Jyn3YAgIXZD05CQFDz/I59prUHpxBEVAJ1eILikC5+uJUVc6PDu2roYWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycw8GtTU0IbCH/z4wZ9EO9UQYECnI04mXCOtL/E4W+pJeMbuvo
	3TulLiQeFGtve0hiVUYMssNmWEOL2Dx5V6+5RUnjo0uE2aZCyfDo5uiamw==
X-Gm-Gg: ASbGncuGuKTZoYgfs3CwHdpHEjUUFfTuFmTQZShfuvE9e8fqGvNybIx4KMTNBL5rOWI
	VXwlxPVtjPwoQL/5Zl8TB1wL3Ukp3nbvsIDbCRKvQQ8IsDoojbgbHD9UIvGDq+HeQ0xXWDoUFPV
	c7VoNcBuDiiUlRsI/NOLhPEjp08HtrhKJ38tMx5GW2RG1KuCj02ehIu+EsgaK9RnnVfrigV4F+Y
	X1yRrt99kDysu91T61Anu5lSycOtSrqaJVR6QXjoWkdcIXYA8lQ8TvoB5AvYrkaLJ1n+nN776Ze
	HcsiabWJtm61WRmxKBwvuW1rS6NpOJNSbA761Cwo/fv3xm7rBWLB+BxV9ratQJ8=
X-Google-Smtp-Source: AGHT+IEpnTilfxIXc+0Yk1Eab8ecYq3JRrHkUM/r8Pp2uQQk5zGZTtCiTx0QkgzXR3BkIIk+7CM1hQ==
X-Received: by 2002:a05:6214:1c42:b0:6e1:a45a:f8d4 with SMTP id 6a1803df08f44-6e4455c940cmr264006956d6.7.1739210030287;
        Mon, 10 Feb 2025 09:53:50 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e444eaa762sm41454766d6.90.2025.02.10.09.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:53:49 -0800 (PST)
Date: Mon, 10 Feb 2025 12:53:49 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>
Message-ID: <67aa3d2d6df73_6ea21294e6@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANn89iLaDEjuDAE-Bupi4iDjt4wa90NA8bRjH8_0qWOQpHJ98Q@mail.gmail.com>
References: <cover.1738940816.git.pabeni@redhat.com>
 <67a979c156cbe_14761294f6@willemb.c.googlers.com.notmuch>
 <CANn89i+G_Zeqhjp24DMNXj32Z4_vCt8dTRiZ12ChNjFaYKvGDA@mail.gmail.com>
 <1d8801d4-73a9-4822-adf9-20e6c5a6a25c@redhat.com>
 <CANn89iLaDEjuDAE-Bupi4iDjt4wa90NA8bRjH8_0qWOQpHJ98Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] udp: avoid false sharing on sk_tsflags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Mon, Feb 10, 2025 at 5:16=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >
> > On 2/10/25 4:13 PM, Eric Dumazet wrote:
> > > On Mon, Feb 10, 2025 at 5:00=E2=80=AFAM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > >>
> > >> Paolo Abeni wrote:
> > >>> While benchmarking the recently shared page frag revert, I observ=
ed a
> > >>> lot of cache misses in the UDP RX path due to false sharing betwe=
en the
> > >>> sk_tsflags and the sk_forward_alloc sk fields.
> > >>>
> > >>> Here comes a solution attempt for such a problem, inspired by com=
mit
> > >>> f796feabb9f5 ("udp: add local "peek offset enabled" flag").
> > >>>
> > >>> The first patch adds a new proto op allowing protocol specific op=
eration
> > >>> on tsflags updates, and the 2nd one leverages such operation to c=
ache
> > >>> the problematic field in a cache friendly manner.
> > >>>
> > >>> The need for a new operation is possibly suboptimal, hence the RF=
C tag,
> > >>> but I could not find other good solutions. I considered:
> > >>> - moving the sk_tsflags just before 'sk_policy', in the 'sock_rea=
d_rxtx'
> > >>>   group. It arguably belongs to such group, but the change would =
create
> > >>>   a couple of holes, increasing the 'struct sock' size and would =
have
> > >>>   side effects on other protocols
> > >>> - moving the sk_tsflags just before 'sk_stamp'; similar to the ab=
ove,
> > >>>   would possibly reduce the side effects, as most of 'struct sock=
'
> > >>>   layout will be unchanged. Could increase the number of cachelin=
e
> > >>>   accessed in the TX path.
> > >>>
> > >>> I opted for the present solution as it should minimize the side e=
ffects
> > >>> to other protocols.
> > >>
> > >> The code looks solid at a high level to me.
> > >>
> > >> But if the issue can be adddressed by just moving a field, that is=

> > >> quite appealing. So have no reviewed closely yet.
> > >>
> > >
> > > sk_tsflags has not been put in an optimal group, I would indeed mov=
e it,
> > > even if this creates one hole.
> > >
> > > Holes tend to be used quite fast anyway with new fields.
> > >
> > > Perhaps sock_read_tx group would be the best location,
> > > because tcp_recv_timestamp() is not called in the fast path.
> >
> > Just to wrap my head on the above reasoning: for UDP such a change co=
uld
> > possibly increase the number of `struct sock` cache-line accessed in =
the
> > RX path (the `sock_write_tx` group should not be touched otherwise) b=
ut
> > that will not matter much, because we expect a low number of UDP sock=
ets
> > in the system, right?
> =

> Are you referring to UDP applications needing timestamps ?
> =

> Because sk_tsflags is mostly always used in TX

I thought the issue on rx was with the test in sock_recv_cmsgs.=

