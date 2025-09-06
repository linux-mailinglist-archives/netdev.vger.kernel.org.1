Return-Path: <netdev+bounces-220574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DC3B46AA7
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 11:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7633A6A7F
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 09:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A100285CB9;
	Sat,  6 Sep 2025 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uo4szKVP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD71222594
	for <netdev@vger.kernel.org>; Sat,  6 Sep 2025 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757150233; cv=none; b=Q2glKC2ZahxU11XyILqvdbAu4DtlTko2ah55mlDgjGkvGCL548LoGO5vIVnn6lFPG2aJS+JCLEVdZ9PUfDJ+V8HnidmltI04UhBKKwNue6QICrcmqP6rcfke2MQBWYSbWmOL4K5qatThzSC7tVTVg3H16OFzYXOF3nXCRPd88Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757150233; c=relaxed/simple;
	bh=4tcf+x1bAGP5gLbbX2/0mJXn6QiSKzTB0gWtNPgyCvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y70QqsLfmAXVyzxZYAwyZdAmnqsH3Aq75bRbH6KLSQ62Scpxh9rBR8+kiF2ub8b92wjybNISftF6562M2+4aSrHUSBee9aKMaeoaUDx3OB2dkBX91MciPFC3pn9nz/DPyjaDy8doxxfcxi0PUfpilub2oZOc3CAF8gOMUSzySa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uo4szKVP; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8072bb631daso288413785a.1
        for <netdev@vger.kernel.org>; Sat, 06 Sep 2025 02:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757150229; x=1757755029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyTsTWBfEVvg2d8Q116wig3LF6X3zwSWXkw8iB2bvBY=;
        b=Uo4szKVPKNwugn/xYEwclUxWlsz/wfzT0y9wtG3my9pHhhcL8wsOsbrRJZDfUE+9Vd
         qvkuh+VnfzmX76DBCPWCv1gaIuMdie+q6XRHbVKvwhgAe8WqTMih8rf3oXo7MtKzOqzv
         zAst9Dxnbkk5NC16gEv0aSMfZ3MJDI0sFkA9l8xteaGy0z0HpvS0fLcq95u0c7ypFFNQ
         j8dNe66mdVCav+vJOz/byabyP+13IqJQ3Uz4R8+GqF7Stt0cbNPrzcKvjbGXyQkw8ttk
         XjEfxfTytfyVaULVheLtxif9fxFABEp5m+r671ggybaYPoo5GD/jplvX+UVy0Jn/Pn/v
         C+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757150229; x=1757755029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyTsTWBfEVvg2d8Q116wig3LF6X3zwSWXkw8iB2bvBY=;
        b=SQqPvXSZ+dGCOk8/kGIRFSvMTvc6x3q7Xp70UK8yHzPLyzoYe+TzLWtDDxHQvAbf8h
         2hmobAOaOOLdd3cumgf7P/PdlFi7aWtgaeQASQtXK1Y22/u1uaHHTJ+cJQVr8w3ADfd6
         SG5cPDkUnZRRB7c4A3AKBsSapPgeZbvsnLY2c2ID9ZGiEIizui2sV17l6ASpiJkN/6EO
         tD1k39HcMDZMoW9749I/suU7FZkjwGaCC/XKHRXV3d88d8P5SGEt9ECtQU3pV86FZxbj
         pDrPOMOQ8Q2jAVpGHy9nNA8IUN/pdG8vx4ou2Ia6gahYozlZyJbuenBOVMOwj7DUxNps
         g+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeCVBSG19QGpjSbnScRq9yhmwLPTn8PHphvBcQ+faijmpjK3yDBb+rO3ATe3+IjXbgwffba6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ10nv+tYG8fHhhBsid7WJloMzJ5vDdcvuyF8lupxFnsHWTyRg
	4lhua0i+SBNkAiAoWvn4RLo8v+CRqoMTUdrdYJRzbS5hjZ0oGH1Z7rESjavvwX6gyAZJRyDTGJZ
	WBgMjxhJhmKfDJ1ZHjVM8MByqWIkhHvVEQB8Ypoz6
X-Gm-Gg: ASbGncsxVVHMLv+XmkBLdyAiCxnpEJHC6tVpUbFhJh2U1JcbZHVxstlHs+auyKS1OnZ
	cIntQypteryFJQVW38/T+i712ZmoB6k/ftyls8X+zGjyCzccRZdN03smRlO7P0i7E9KXNqdtylO
	Rn1bUceMSHZh3zHi4fZUFxApxLugiAkdbidLUx4ZPJcTHFVEhAMAKt8kBBggCKIopSbPTq2GcUF
	el1gmiIVFFnHGwNXLItLJc=
X-Google-Smtp-Source: AGHT+IFNHk3o12uxwbf6OpMNI0I53ugLfIK2NXUHGthDfhTNjq2NSap4D+GDM5PavZ580+AiwTooTru70iUwX14qHME=
X-Received: by 2002:a05:620a:440f:b0:806:7c82:fd2f with SMTP id
 af79cd13be357-813c33dbd99mr153395285a.75.1757150229022; Sat, 06 Sep 2025
 02:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68bb4160.050a0220.192772.0198.GAE@google.com> <CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzBcQs_kZoBA@mail.gmail.com>
In-Reply-To: <CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzBcQs_kZoBA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 6 Sep 2025 02:16:58 -0700
X-Gm-Features: Ac12FXxOqkfzxU_8v9kW7s_ChUAwPmKMRLy0TrO1zWLZ0WwxfLDIRZs52c2CrbU
Message-ID: <CANn89iJaY+MJPUJgtowZOPwHaf8ToNVxEyFN9U+Csw9+eB7YHg@mail.gmail.com>
Subject: Re: [syzbot] [net?] possible deadlock in inet_shutdown
To: syzbot <syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc: davem@davemloft.net, dsahern@kernel.org, horms@kernel.org, kuba@kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.lei@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, thomas.hellstrom@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 1:03=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Fri, Sep 5, 2025 at 1:00=E2=80=AFPM syzbot
> <syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com> wrote:

Note to NBD maintainers : I held about  20 syzbot reports all pointing
to NBD accepting various sockets, I  can release them if needed, if you pre=
fer
to triage them.

>
> Question to NBD maintainers.
>
> What socket types are supposed to be supported by NBD ?
>
> I was thinking adding a list of supported ones, assuming TCP and
> stream unix are the only ones:
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 6463d0e8d0ce..87b0b78249da 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1217,6 +1217,14 @@ static struct socket *nbd_get_socket(struct
> nbd_device *nbd, unsigned long fd,
>         if (!sock)
>                 return NULL;
>
> +       if (!sk_is_tcp(sock->sk) &&
> +           !sk_is_stream_unix(sock->sk)) {
> +               dev_err(disk_to_dev(nbd->disk), "Unsupported socket:
> should be TCP or UNIX.\n");
> +               *err =3D -EINVAL;
> +               sockfd_put(sock);
> +               return NULL;
> +       }
> +
>         if (sock->ops->shutdown =3D=3D sock_no_shutdown) {
>                 dev_err(disk_to_dev(nbd->disk), "Unsupported socket:
> shutdown callout must be supported.\n");
>                 *err =3D -EINVAL;

