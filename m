Return-Path: <netdev+bounces-239295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A6679C66AC9
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7327935F126
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE1C2EBDFA;
	Tue, 18 Nov 2025 00:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdhhXM4X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074B52EBBBC
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 00:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763426370; cv=none; b=FrBSS8zCs075dKSfuxmi+67289wYoAI7lrAZTrqZuHhnLkzdyex9e84TYVxVIPrtrhJLYmGVcntM73Wu1xd4OsuXA85Qo34oDqRCKR5Us/Wg+J4gjSJpb3P5wpZcT04hyKoNP/BAAiKxlsnP+vHOGwgUWVPc8gPFxHZv60kc3tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763426370; c=relaxed/simple;
	bh=pcLM05SHl/RWX25C4jxHSyCtuAgCDcQTfwrmW4KgBeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNZlcQxqW63YuU8fu/qcuRJFodFx5ur9Faqay1xW5T7G7OdYD5zMPJSb94wsZrjuR/5AcURhnOnDo3tLlPdCVSB0K4RFBj7fTzqYQXvrvUOLzcpWeNT5ccS38jl3MQSN+cXVjYNMfNQeLlhjTK6LElwkcEtBcX65l1FLe/3IL7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdhhXM4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546F4C116B1
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 00:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763426369;
	bh=pcLM05SHl/RWX25C4jxHSyCtuAgCDcQTfwrmW4KgBeM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VdhhXM4X4fjia8Nfj8ThGjSJMri+5hSujJHVcB3J67kv5zLvIKK7skIcdb1PdqY45
	 MuOA+E/sWpHuxXin4uVGdB8pawPQYHsM0thgFOSgb95abSS1K0+GfKZ04s3YlovPak
	 11pQP7aItKXZvpJQuPsYtGzU9h+u1F5jeqU+u+KwZ2zfskjzaAgnxZ6ZIsc+o3DgAo
	 YWr4bafEts/HyJ57xjyg3ovge8Yc+TNoYNltBHxz1mOkA9dhflmPdAWlbbrwGenRnR
	 ORxwqtCJk9oIqXZhjb9cd3dl9B/nzeCwqky1tyVOeGNR/nJR+9QdTzvpiG52IXHQ1I
	 py1IWKj4hWJWA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so7931575a12.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 16:39:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUK42uOfIIT4nmmjcZkGhodwnHBBs16ToFbzfcBhAy8mGrSoSSAarGZiZgpNHQdbKLUuFBBIj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRWgURoLnW+ob896n1nP/iKuiS1qOWx5Gf9T4EP/ZKoi2BfO4R
	ZElSaHYkHKmV8k3VB95iv8HwttH3Y7K3D2CKI/OiJKG7y8ZqXLQT6xsEgu165wbppMxYLFlMlDL
	9ohO5zLELCtsxp5KT1uMLeKLbb6qYB9U=
X-Google-Smtp-Source: AGHT+IEmITrgzrMOnFZyB9tom2bJhAotJB3kGeRr2VlFkPS2uy6a/uNw2t+hwIqJ+HAXO4Iom3hs2wJs7yaPWlzwn70=
X-Received: by 2002:a05:6402:5112:b0:640:a356:e797 with SMTP id
 4fb4d7f45d1cf-64350e2092amr12359076a12.13.1763426365124; Mon, 17 Nov 2025
 16:39:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117085900.466432-1-dqfext@gmail.com> <cc80596c-f08d-465e-a503-bdb42fddbbae@samba.org>
In-Reply-To: <cc80596c-f08d-465e-a503-bdb42fddbbae@samba.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 18 Nov 2025 09:39:13 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9S4PPG_7Ea82=d5sRjNw5iPgv2MDNWBO7QnzP27poxnw@mail.gmail.com>
X-Gm-Features: AWmQ_bmSqRhcfSPj_YSi5UCaQGoPt-lC8rMJ8v-0AXAJTriZmKI3nEuS_p29C64
Message-ID: <CAKYAXd9S4PPG_7Ea82=d5sRjNw5iPgv2MDNWBO7QnzP27poxnw@mail.gmail.com>
Subject: Re: [PATCH v3] ksmbd: server: avoid busy polling in accept loop
To: Stefan Metzmacher <metze@samba.org>, Qingfang Deng <dqfext@gmail.com>
Cc: Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, Ronnie Sahlberg <lsahlber@redhat.com>, Hyunchul Lee <hyc.lee@gmail.com>, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 11:52=E2=80=AFPM Stefan Metzmacher <metze@samba.org=
> wrote:
>
> Am 17.11.25 um 09:59 schrieb Qingfang Deng:
> > The ksmbd listener thread was using busy waiting on a listening socket =
by
> > calling kernel_accept() with SOCK_NONBLOCK and retrying every 100ms on
> > -EAGAIN. Since this thread is dedicated to accepting new connections,
> > there is no need for non-blocking mode.
> >
> > Switch to a blocking accept() call instead, allowing the thread to slee=
p
> > until a new connection arrives. This avoids unnecessary wakeups and CPU
> > usage. During teardown, call shutdown() on the listening socket so that
> > accept() returns -EINVAL and the thread exits cleanly.
> >
> > The socket release mutex is redundant because kthread_stop() blocks unt=
il
> > the listener thread returns, guaranteeing safe teardown ordering.
> >
> > Also remove sk_rcvtimeo and sk_sndtimeo assignments, which only caused
> > accept() to return -EAGAIN prematurely.
> >
> > Fixes: 0626e6641f6b ("cifsd: add server handler for central processing =
and tranport layers")
> > Signed-off-by: Qingfang Deng <dqfext@gmail.com>
>
> Reviewed-by: Stefan Metzmacher <metze@samba.org>
Applied it to #ksmbd-for-next-next.
Thanks!

