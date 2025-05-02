Return-Path: <netdev+bounces-187471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AFAAA7478
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 16:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE003AC9C6
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 14:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1934255F48;
	Fri,  2 May 2025 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zN4+LBjn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D741C255F43
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746194883; cv=none; b=nm2hhE5JFVmPwD2PB1wXFJwm4MyroEnilGnVN0frn57JevsTAInL2pSqmKxfhmKSnlBIpo6SRl4SNmUFP2AQRatXDKv4Pui1+effTidGnrUHrbFiRcMYKFsoGfpT5IwfIsTNnGY+DD2ZJO42F8e/BeYu+8WUXnD+0tbgeBL6GMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746194883; c=relaxed/simple;
	bh=UVrY8f5Cyv14chduVrQZ3t/d79hUTi9W+07ivdjtsbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utlPM0QaLhrBVMj7ho4hTL5w4T464jMYikGl0tw2CJk2m5C9sbFm01ipSN0o0Y/luBC4MHCv6JJZm2+FCZtElgvihZTVzGgqjlioWyJ94tZXVMUed7KTjG3i5ulFNd/I9qEZbULTVfynq7LDZyelrcvAImx21LysZRsYRin15b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zN4+LBjn; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f632bada3bso8116a12.1
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 07:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746194880; x=1746799680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+ralkWtDGcfXchRBqjEDJJfkQsdJ9smPBhVueEpLX8=;
        b=zN4+LBjnP4Cu7vLw76toWXqWKIVwN76veFVgq2/O91Cc3Up/kIE8EbvE8D6qttK2sY
         7wpAGEDAki6Pzr1XJgZztl7CKZZO2e4kjWgYWiDKxnEbbBGTguC8JYRF5ef0xQhQXD6u
         E1G4ccXN7SeYRQ8to5IOS4JvnSIO8h7griPAk/wfz3GiAb/HObZ6d3wY9vo5FGufm8yf
         cip1xI2qJRpZiSGOekImzugKayye8fi+47mdCfN1EuzS0ZKNdMVzMXqB9FqQ3A4BBo+C
         J4YR+1GJKqy//CiZvzSNRnpT7qYTNkwxfPmvMzpTed/yRV6aNWxxt4h+snIkyranUw0/
         SqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746194880; x=1746799680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+ralkWtDGcfXchRBqjEDJJfkQsdJ9smPBhVueEpLX8=;
        b=OCYZuUljdbkbSGP/IVgiW59hPIk+GQ8R20mFWuPPFzj2wl92CsJQmzV1t98040NiGi
         NwiFA9v93iuOXAp1n+f0RBS8fAHXhMYQ6xe86jUyM6nM+gg6mrYgi/agOo6XKKx8ib/5
         rN5AXV8+nFuHZPrB2XNNF+RKJdqH55EKVS9tG23FJcpM6k1opSDu41SA2eBQ7/NqEqT4
         +YTME2Az3gMlAwjhbuET7ZGPXkCuASWXNw9P3A0wO1ElO0wWHYBnmkpMFmape6pqHFRY
         LWFZah8TREdgbpmRncuWOp4g6lFuQ/tDRm89kJxT6gJXuNBVzNmk4k7WfF68yhgjlgJd
         eAsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX7b7I9hlIwBC704L1+HTg/F3zvozMwV/ZMPNciY6HFj7y3tqrYBTVSyPKeaopy1mpa9mfrYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJnqVUxmWS9iIFQh89D3ooD8Jg3EBvRAgiGCTu+/iUq2ImhXuw
	Hi1bLefPQQ2uVZQcoAd/5FoTwlQOkMAfKHp6NuDFLdsN4nKBKDvxj8TI3KwZJ1P3RNiEuLj5ESR
	op929UDMfPW666nYAhfQEitDEONq4v7NHjjE4
X-Gm-Gg: ASbGncsCnqWP1qbiuefMmoV0jBrXcwbZoS1qwTzg6GphRkq5ko09fI+KLqtYDhdduTq
	UUYJrUqiZOCb/jhas5qOfOWLT0y4Oq/EjHkydsa11dbf7HjqaTMpZpOkd6KL5OcK+2zLWl504SJ
	lU2bSqghmQ1hQNnWQZI2lGhnVdNeyaeQ3aYv5rpo1IWPU9MGWJGw==
X-Google-Smtp-Source: AGHT+IH2MgYtnCt0qoRxeEEy4wBAGB4W8/4VBrSSGQAsYhZAqwznZ2l8EUQhrSMm9GTN06zMa/L9rySKK9MxDQ8WHV0=
X-Received: by 2002:aa7:cc12:0:b0:5e4:9ee2:afe1 with SMTP id
 4fb4d7f45d1cf-5f9132eb267mr197482a12.2.1746194879730; Fri, 02 May 2025
 07:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org> <20250502-work-coredump-socket-v2-4-43259042ffc7@kernel.org>
In-Reply-To: <20250502-work-coredump-socket-v2-4-43259042ffc7@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 2 May 2025 16:07:23 +0200
X-Gm-Features: ATxdqUFEoXQsC4OEC4hdmE0Par_5oTsZKTXGKHrZCv9IPMoKZDb_IIBUvPJNHJc
Message-ID: <CAG48ez1YjoHnH9Tsh8aO2SNkJUW=7VUPXAdvxqt7d0B4A8evEw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 4/6] coredump: show supported coredump modes
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 2:43=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> Allow userspace to discover what coredump modes are supported.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/coredump.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 9a6cba233db9..1c7428c23878 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -1217,6 +1217,13 @@ static int proc_dostring_coredump(const struct ctl=
_table *table, int write,
>
>  static const unsigned int core_file_note_size_min =3D CORE_FILE_NOTE_SIZ=
E_DEFAULT;
>  static const unsigned int core_file_note_size_max =3D CORE_FILE_NOTE_SIZ=
E_MAX;
> +static char core_modes[] =3D {
> +#ifdef CONFIG_UNIX
> +       "file\npipe\nunix"
> +#else
> +       "file\npipe"
> +#endif
> +};

Nit: You could do something like

static char core_modes[] =3D
#ifdef CONFIG_UNIX
  "unix\n"
#endif
  "file\npipe"
;

