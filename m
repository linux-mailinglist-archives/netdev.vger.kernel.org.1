Return-Path: <netdev+bounces-234138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FEEC1D1BF
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 21:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07C794E3DA9
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F533655CD;
	Wed, 29 Oct 2025 19:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knuFZdka"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0683644B6
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 19:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767859; cv=none; b=YbubesYe6Pcp6Nv7byjJ1j1HY7TJ1yojk96/57VQjRWizWqEoZp2C5Dr5Dmp9EZCmZD0dDxlv7FKQ3eJJXt1DVFvdVV7FJrTCGTnByRLJJBzJf2YE1EMkSX5btkn92a5qqL4UgCu8IiYAIUcvLAKY45lNpvrt5QM/0Jp+g+DJy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767859; c=relaxed/simple;
	bh=+rNIfhn612wSnJwTsWfa3rI2oXBKL1DitnLLKvmVa24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyLH6B6S/vh+w70FQKLzIc/iIfjLuEYtIlZP/Z4l0d7+mCpKwyn4l32qKGNpAQvC8y73iV0XXRTEkCaTJwugzmXetnFR9k3UrEQzjxHk3xM2PTHjCbg61aSquGptRXah58mAlvUnY65QH1hMO72QbePGU3If/HgPte4Kxy8dGA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knuFZdka; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-781206cce18so369890b3a.0
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 12:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761767856; x=1762372656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5AE88Ciiu4y1L+Whuiba6HLMWI7gvS/KpyPblrUqXI=;
        b=knuFZdkavo3jbuzWz+lLMRxkQuCzsSky2G4PW0+DWx8/yWDaGZChYNV6P2mYA7AzPv
         tp9m/vIfjmCc1zte/F2y5QFwYmww0dntAFzarR7RW652V380u5DAiRBPpo1wK1dWUgqY
         43ZObmpXPXYVD5HLSa8XwJnyvgM38MTujAFadPluslaJCoqcDd5Mst+MUTTyGQCPFyVN
         XXaRmScND7qeRHvwEKeQ1Ybd3xmF0cIjb8J7FHSE59DAaF/6rT2jwbQsZD9cUL3+aYMq
         od6YQpJ5JdNlXErBJJ2U3izfTb5gxulCnKJF36/Mps50lnVL3VD/7rYubSe2ZSRbJvOY
         Mrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761767856; x=1762372656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5AE88Ciiu4y1L+Whuiba6HLMWI7gvS/KpyPblrUqXI=;
        b=e4Mj7ZqxuZvO9OJBjEHImVeT6/wEYplgPjeZg3s4kwX0JKqzlHEy4XyZEgJGYEVspP
         D8IwE8TGClOngHgoC8P/u9YF4ToTDaTV9FEWmKgifxPApd4YfEMcEDqK8eY9ZNJ2KTX4
         z1p88VpetyGvZiOyztA0TowBwCgQmrsymEhuQWHDz2+N93whQel1CzzwNO4YQZ7IZWCT
         c948eOjuncTqEsLfrWiUZVB6EqOo2VUpGYGFYoQvlzJQLggYP8FygyKR3lC6ouNRlB5/
         oePH3ZMtJRGvaz2NOO6LmamFg+qJ26p6piALOriqnrzKSGA26n35lsSQKaGRCYVeDviS
         HCRQ==
X-Gm-Message-State: AOJu0YygOI2U2XS2HHcchgZ3v2i2Z38sul6JEbnF+ROjAWVRBtJZzT37
	HivVba2rpJxtQUJf63rMwUYsfzkcEvjmkky1Nf4X52P/Yri1i2U686CMIKq5hPb5qP7bl+rM2B8
	10tNREVKqL+j8Viv2KfyEUPHWSdSCoXo=
X-Gm-Gg: ASbGnctSrw3iv7oNUzSMwqRbiJBhBC4hTJ/xCnEkg0Xsh/+ADOcah6pcihaG2H0Axdx
	dYnMEXeBIlx1goPdcWhX8IBak/2/4HNBA586quxJ753oYHSHMu8VW5EWRCsYQHZoH34M55F7XyR
	xK11SzCSlNbPEkxXNKVWDQENt+jJjX0EPCLhMCay5kW4BfmQcwQ3DNeiTcl0p/CSaiJcfISty1c
	j5Z/A1I9+ZcZwyQY70Y18x3uVYDlqVV4OCvUZly+bZFwjJyNxGDgvLkSerIi/TI166hOnaYSg==
X-Google-Smtp-Source: AGHT+IFNCX0ckOsChso5kJGqid4SLOaalcmgzvE+F5pb8cfkVkc0r3f/yGGJSksDBL4n2c6XJFS70z/v5MFaLPK0zXQ=
X-Received: by 2002:a05:6a00:3a27:b0:781:1110:f175 with SMTP id
 d2e1a72fcca58-7a61506a504mr866733b3a.14.1761767856388; Wed, 29 Oct 2025
 12:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761748557.git.lucien.xin@gmail.com> <91ff36185099cd97626a7a8782d756cf3e963c82.1761748557.git.lucien.xin@gmail.com>
 <67b38b36-b6fa-4cab-b14f-8ba271f02065@samba.org>
In-Reply-To: <67b38b36-b6fa-4cab-b14f-8ba271f02065@samba.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 29 Oct 2025 15:57:25 -0400
X-Gm-Features: AWmQ_bnwX6EuAJChCufrlpzg_AX6H7XB1Uf5xbfwoMjEpTiQtpfFTcbK0dDvD94
Message-ID: <CADvbK_f4rN-7bvvwWDVm-B+h6QiSwQbK7EKsWh5kTuHJjuGjTA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 02/15] net: build socket infrastructure for
 QUIC protocol
To: Stefan Metzmacher <metze@samba.org>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Moritz Buhl <mbuhl@openbsd.org>, 
	Tyler Fanelli <tfanelli@redhat.com>, Pengtao He <hepengtao@xiaomi.com>, 
	Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
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

On Wed, Oct 29, 2025 at 12:22=E2=80=AFPM Stefan Metzmacher <metze@samba.org=
> wrote:
>
> Hi Xin,
>
> > This patch lays the groundwork for QUIC socket support in the kernel.
> > It defines the core structures and protocol hooks needed to create
> > QUIC sockets, without implementing any protocol behavior at this stage.
> >
> > Basic integration is included to allow building the module via
> > CONFIG_IP_QUIC=3Dm.
> >
> > This provides the scaffolding necessary for adding actual QUIC socket
> > behavior in follow-up patches.
> >
> > Signed-off-by: Pengtao He <hepengtao@xiaomi.com>
> > Signed-off-by: Xin Long <lucien.xin@gmail.com>
>
> ...
>
> > +module_init(quic_init);
> > +module_exit(quic_exit);
> > +
> > +MODULE_ALIAS("net-pf-" __stringify(PF_INET) "-proto-261");
> > +MODULE_ALIAS("net-pf-" __stringify(PF_INET6) "-proto-261");
>
> Shouldn't this use MODULE_ALIAS_NET_PF_PROTO(PF_INET, IPPROTO_QUIC)
> instead?
>
Hi, Stefan,

If we switch to using MODULE_ALIAS_NET_PF_PROTO(), we still need to
keep using the numeric value 261:

  MODULE_ALIAS_NET_PF_PROTO(PF_INET, 261);
  MODULE_ALIAS_NET_PF_PROTO(PF_INET6, 261);

IPPROTO_QUIC is defined as an enum, not a macro. Since
MODULE_ALIAS_NET_PF_PROTO() relies on __stringify(proto), it can=E2=80=99t
stringify enum values correctly, and it would generate:

  alias:          net-pf-10-proto-IPPROTO_QUIC
  alias:          net-pf-2-proto-IPPROTO_QUIC

instead of:

  alias:          net-pf-10-proto-261
  alias:          net-pf-2-proto-261

Thanks.

