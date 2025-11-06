Return-Path: <netdev+bounces-236126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDD5C38B49
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 02:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171CE1A23320
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 01:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B38224AEB;
	Thu,  6 Nov 2025 01:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoqHcPYo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C512236EE
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 01:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762392504; cv=none; b=A3Q6SU5IA74qZ9PPqTxdsroX5jkoh9Izpzb9z1i8u4mDYl0TZvB/rzzn+C2XTg+TmWrdN16HM8wdiQddhiM+6NqKx+S55c/uf5Dsmwd/7ZkP0e0inNcvddL6id8Z9ASS9uMCMPzNcwGPdbnPlNnaqh362jg9UBFN4HZr9+1NzRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762392504; c=relaxed/simple;
	bh=8JeJb5xG4/s5U4bPcvUBg29et4g0wO08cvyhmJHqqzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNS2xWsfch90U7WhNTxuEfNHdNMu/v7TVUjwzDO5gwoHFy6Q7Fyz+APEwTDxn3rkho8bnmrCM+BsTL0+YWcYX8qb5pyuR4mfqPSkfyipnRuB+gnpQBBgg0F1WxYtokspJ3rpNISs7JfkpmdIkQ5xBRkRCcHNN8MpHbfb93aQNfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoqHcPYo; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-934f0e9d4afso150327241.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 17:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762392500; x=1762997300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wg1fDGVNhVSvLHI8UtrXbUR95hQdkRLxiyxAEDl4tvA=;
        b=hoqHcPYofKuU7Hn8K+JHW07uAHj0k9cCNSjxTfQY+mbjTprMBwUVQOEQZ3PTq8lazh
         IbBJu+xLpwg/sNT9gR3IDdgP99NTDbawgHqzDTNW7WLe054865l/MXq7ePslLdMuDAPd
         ++7lNt1qFAqxRC+MuSeev+M8geUauTsEciezg8KPAqP02zq69yL43lMt1wgvPli2252B
         VwZZdGtmNrfBt1B7BexcDlAE1s2aXKmepCNh9DEerQgx6FOWv/3RaYSlPSeGQafj3LTu
         a/s2aw+KuEEMoAKZ8F+OVrLw9LsPhF7MwYeIXqPStpLtJaPTgcfpKA7ps8ttw0JWCdHi
         6B/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762392500; x=1762997300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wg1fDGVNhVSvLHI8UtrXbUR95hQdkRLxiyxAEDl4tvA=;
        b=M680DwfePLw3Dm/Akn9JrMpq0ZXLX/01sRLKcqpUhx8pnoyDx73AC9A87jekKlRWKU
         JBtHIHqa7XK6Oai4N1x9hLytvQemZd/kH0Sf1PGHtLOoaVbS6OaHc2+ZvnSSWCPPbka/
         tcZ4+R1pD3j4p5RO/b5d7pMsL2rDK9+1G8A8Jxg0bic76CUaQ8o9qHeayf4Nk7lGJe+y
         m68OFRx3tm3Jsof99dPc/fAATMlwL3HsLqLZtG+IfLQ0r0eoYEQMjmurBY+2nwg5L8O3
         JitwqfFPqi/PPadMx8IsBO0cLpZhJ37+28cFq8eTofbpiVXSvsquWYC2syx0paI//62+
         ZcgQ==
X-Gm-Message-State: AOJu0YzXAlk63UOT0e19V2QNBhPV+fMSvvXtGD+z/8GNygIE6Phr/kQh
	sk6X0pLUYQnwLogxOg9eVlYsexA4tlB6cwydQu8NyXl7It83zkxbYx/BKlQxE4uNIzsMihqFiBJ
	029htWjLXxQk2wJuOytNMUzggPcU5CnI=
X-Gm-Gg: ASbGncvRT6xlbndFfUJ+xoeyCb/ALPtkfahJXQ1JcY71TPeukC6qNmKBN5/wUQkug2r
	AjtL8uBkpqTdNMbaEFlUO3ACFnIU/riw7HNz7KnkZ/ZBZg64KDFq5nYGLdHdfeXYDqfqHErrIGX
	RxWON9xnrqD9OKUo52347sSeQ+kNgBuFVtM+GwdOPbPrizucL1KUnAnN/XJ0fzjl13YhNROCEpI
	d9jKYcYOzgkVH7FOU+iT6eV8PPAiHLjZUl4h6HnlvuT348jpl8fQO7wjJTec4C97HhzUQIeu0Az
	/qWHNnGXTy2iHE7mluOCSSNqWHYkYg==
X-Google-Smtp-Source: AGHT+IFAfsz2Zqzln6j7be0SXtzx+REd9Kb2WswFj06vVEvMuigO74T2v/7feYEPVzfhUHtS1CEmTfOB6DSeH1kFlos=
X-Received: by 2002:a05:6102:6c9:b0:5db:ca9e:b588 with SMTP id
 ada2fe7eead31-5dd892c2b52mr1963957137.26.1762392500379; Wed, 05 Nov 2025
 17:28:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761748557.git.lucien.xin@gmail.com> <0ccfc094d8f69e079cc84c96bd86a31e008e1aaf.1761748557.git.lucien.xin@gmail.com>
 <914b0331-8fab-4ad6-a6a8-e511a4352cea@redhat.com>
In-Reply-To: <914b0331-8fab-4ad6-a6a8-e511a4352cea@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 5 Nov 2025 20:28:08 -0500
X-Gm-Features: AWmQ_blK1NNu_ykARGiZM3a2YMxLJcnC4eKQDvjkKcFDiJVQwG3h2Rwk05Ot31I
Message-ID: <CADvbK_dDMA5UkS8LDqSkFwg-H2p1DNqqP_4Tv7ie1hqNp-Yrrg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 08/15] quic: add path management
To: Paolo Abeni <pabeni@redhat.com>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Benjamin Coddington <bcodding@redhat.com>, Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, 
	Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe" <alibuda@linux.alibaba.com>, 
	Jason Baron <jbaron@akamai.com>, illiliti <illiliti@protonmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Daniel Stenberg <daniel@haxx.se>, Andy Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 6:50=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 10/29/25 3:35 PM, Xin Long wrote:
> > This patch introduces 'quic_path_group' for managing paths, represented
> > by 'struct quic_path'. A connection may use two paths simultaneously
> > for connection migration.
> >
> > Each path is associated with a UDP tunnel socket (sk), and a single
> > UDP tunnel socket can be related to multiple paths from different socke=
ts.
> > These UDP tunnel sockets are wrapped in 'quic_udp_sock' structures and
> > stored in a hash table.
> >
> > It includes mechanisms to bind and unbind paths, detect alternative pat=
hs
> > for migration, and swap paths to support seamless transition between
> > networks.
> >
> > - quic_path_bind(): Bind a path to a port and associate it with a UDP s=
k.
> >
> > - quic_path_free(): Unbind a path from a port and disassociate it from =
a
> >   UDP sk.
>
> I find the above name slightly misleading, as I expect such function to
> free the path argument. Possibly quic_path_unbind?
>
Makes sense.

Thanks.

