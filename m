Return-Path: <netdev+bounces-236066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713D8C382C3
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 23:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1402D3B7BF5
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 22:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5562F12C5;
	Wed,  5 Nov 2025 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e11MUsmK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBD12EFDAF
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 22:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762381247; cv=none; b=CO2ZnGhpaTamnc2MqxvgbpKM4/2l11p6uUlTH/hO6EaM2CF1fmN+jkU0H54DXULWw8E3YXflSPy6cnHh2vhL4nABeLSoJnAKmiifGmSFxNUoeuUYE0smcA9Icgqy8Pyh/qeeNhSxaSHsCtAoe+0VT42SSedDRElr5qvn34haPqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762381247; c=relaxed/simple;
	bh=I2Hsg/B2GBcgQ3xLGmh7nx19s9mgd3/8xUEED7dpNHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9udhuO8/ye8Lt/+RpGE+fkS/E34WQP6SAjNB0PMkGblY6/HVMAaz9VBJVuw7agsGcMXVI4Nh7PuRE0XIDB0nuudftmOoGMK54hV3S/p5wxlXPaDd2cG7lwlBhD3GWeSy3KYxAFKSzIxdlCyVIZC9NHseNIgtrzRx3nm946So20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e11MUsmK; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34182b1c64bso252172a91.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 14:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762381245; x=1762986045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2iC3i/NABlxjjFozwtUiIBPGgmouctXhyOdEE/QiTU=;
        b=e11MUsmKnRZBbWPMOZX+kAWrlpzLPaRe+zIOUZecpS149AfOpEDaMpsxdsGWFt9inu
         hGRjtivH7t8m5XwkOiEF67KwEdqb57daKsJPuNYlSWZUMHa5Y8P5ki5mpzlGq0UvkIbu
         ponjqaK0B4pX9Vr2XzT0zu8gNIHoYAJRUTK4qwt2CTHVscN3O9Fv+1H5nxTJEzHl5VCx
         FqRT39yPPaKHL5SRXqjgaF/9h7Wc9kGAiUeLvwAbCDNoHPnEIG2VeJfOpBJ6KJL4jEHJ
         VwGynUz6IohPqXaeFFs/zpPCQPo3pdkCk4bwX3cVZWeHGTY0Zx/Ay65//RSGdy8YA8qB
         mk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762381245; x=1762986045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2iC3i/NABlxjjFozwtUiIBPGgmouctXhyOdEE/QiTU=;
        b=ZJAGobDvr04ULay5X2A2HEhEACsC+oug2HbEgOs3HvXiaEAra+v8raJBjt1nFuFvcw
         lyfa9syyKfEEMJ1A1Jpl7dRMkvAbf+0SYezhuiiT9xN4aHZ5pCAnxqGi3QqlEW+tKaoW
         AdTahSbTGPFi90XWCyrN+XICeteIgeBWpOzRqTo3EIrl0dAlG1m6irh7tKMmTNTZYC2T
         eDHIO/NV2EoMdkwZKozpOt7OE8G+RK1RkllDLlMNYmTHQCP1kIrZVV23JNYXC8xR63Su
         TH4ZDb9oyme4BsN8Zfx2toK3hvREC+zWpMPVDuFTgaeTH8j8Q2kn6HSioPhdJ6D/QALu
         NeXw==
X-Gm-Message-State: AOJu0YzE1Ikc7eXh+YnyFyIj4QwBY0txpcTRIzQY0wSw/VaacMfInqhD
	AHRIKAKwwItM1hlLmp3Xr6c2d3Ht3Mvunyefulgu5bW2Sk5SEYxoyEHDoW0vriOu9cC/YFdrEcJ
	KKeu+SPpuBwXuKVkNndnPUogb+BA13kM=
X-Gm-Gg: ASbGncuKVuJRofU1bk43NZA3WfkGdSOUuYnUxqGQvtaSdfOFh/EhqjpWNr6JEYuyvy+
	sr+pchpV9BRpEckgN3DIa9HI5xytPvRDjbb/QecsMy3TX6NdKppk8tEZbBi7EakqL2qPHgg7MYJ
	hhSePaGDWo9XjmxRqqOCGZaDyhc/pj/q19i5c0Y62f8y0Z4rbGbS/DvYuqYKF19UYA8Yy8wZtu7
	SOVziSCybtWJXdcaGTFyH9KBfrRpcgKU8bFOw8xLNJ0l26tZXPy4wfVCX2+
X-Google-Smtp-Source: AGHT+IF9huOMB6L9BBqEVqTdSAoOXtne1VO5JWHa16xjKf9IxuOLvUQRWxxDT69nj5IfkbHYDZVPmIIL4ocNXonBxEc=
X-Received: by 2002:a17:90b:48ca:b0:340:bfcd:6af8 with SMTP id
 98e67ed59e1d1-341a6bfb6bdmr5773377a91.4.1762381245005; Wed, 05 Nov 2025
 14:20:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761748557.git.lucien.xin@gmail.com> <91ff36185099cd97626a7a8782d756cf3e963c82.1761748557.git.lucien.xin@gmail.com>
 <ffe0715b-7a60-49a4-802a-a2bd75c7dac4@redhat.com>
In-Reply-To: <ffe0715b-7a60-49a4-802a-a2bd75c7dac4@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 5 Nov 2025 17:20:33 -0500
X-Gm-Features: AWmQ_bnm5UfKvMR91-3ijvc6b8x8StJ9v75fS15sCmi9yT7hm61wUIVxJ8Ij89E
Message-ID: <CADvbK_e=UbsN2W7zqsRRHzbwZcSzR7GwZ9-YPrPcxvaHZ0ZjMw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 02/15] net: build socket infrastructure for
 QUIC protocol
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

On Tue, Nov 4, 2025 at 4:38=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 10/29/25 3:35 PM, Xin Long wrote:
> [...]
> > +static struct ctl_table quic_table[] =3D {
> > +     {
> > +             .procname       =3D "quic_mem",
> > +             .data           =3D &sysctl_quic_mem,
> > +             .maxlen         =3D sizeof(sysctl_quic_mem),
> > +             .mode           =3D 0644,
> > +             .proc_handler   =3D proc_doulongvec_minmax
> > +     },
> > +     {
> > +             .procname       =3D "quic_rmem",
> > +             .data           =3D &sysctl_quic_rmem,
> > +             .maxlen         =3D sizeof(sysctl_quic_rmem),
> > +             .mode           =3D 0644,
> > +             .proc_handler   =3D proc_dointvec,
> > +     },
> > +     {
> > +             .procname       =3D "quic_wmem",
> > +             .data           =3D &sysctl_quic_wmem,
> > +             .maxlen         =3D sizeof(sysctl_quic_wmem),
> > +             .mode           =3D 0644,
> > +             .proc_handler   =3D proc_dointvec,
> > +     },
> > +     {
> > +             .procname       =3D "alpn_demux",
> > +             .data           =3D &sysctl_quic_alpn_demux,
> > +             .maxlen         =3D sizeof(sysctl_quic_alpn_demux),
> > +             .mode           =3D 0644,
> > +             .proc_handler   =3D proc_dointvec_minmax,
> > +             .extra1         =3D SYSCTL_ZERO,
> > +             .extra2         =3D SYSCTL_ONE,
> > +     },
>
> I'm sorry for not nothing this before, but please add a Documentation
> entry for the above sysctl.
>
Sure, will do, thanks.

