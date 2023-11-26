Return-Path: <netdev+bounces-51179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE26B7F96AF
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 00:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67C4BB20A17
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 23:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA777171AC;
	Sun, 26 Nov 2023 23:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUdtwVos"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED2CFB;
	Sun, 26 Nov 2023 15:56:50 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-285741e9a9aso2113662a91.3;
        Sun, 26 Nov 2023 15:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701043010; x=1701647810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMjUOMBsNx98bSTGJ5OT6pqeZWF3+KxX6/PMEtjSuY8=;
        b=EUdtwVosBaGw+we1I7/f4LYOZ5kn0owCMsQsyv4tMisf4fwTuSsf2HipeIuLJS+a2Y
         qGgqs0LRPxdYVQeLp8rTbUYoYDeqO/nhLJqwNkpssZ0KOmLPTUTRzu2iEo+bnu3rnvHF
         1f942ytOQe9k0n09KrNt8oWMh9w50T/0/AfqOmF5xx95xS+CCZ1M62tsKZdJbBXjXmT8
         gy50ZBFFE/USRJzdbjCQSJiRzmHc7vec5sqJwyvGe0fG4Y29nZbu1N3cLkv5EGTOPh8T
         zEigXXcwEs7U7xKeBI3xRabBhP6+MtdhzybPNPP+WUgPSeblJOH04CMym8Vn2jb3K9aU
         N/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701043010; x=1701647810;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aMjUOMBsNx98bSTGJ5OT6pqeZWF3+KxX6/PMEtjSuY8=;
        b=iS1iaw0j3R8tX1/hxpBH6vWsiSnogDA4ZnzgtpFKSI5j3xrUVdX6JhmR3oaaKgmCWz
         Rs78kl56eQeNAni6fBxJSiEJVWCrGCmGchH2erb+XdL1OJ4/408XlbY6U6KXBhHCOGUg
         lyqN3N0WNgZHA6z2rtsCE0NT/RCXWuqNQ+C90RckUJDU61NaHjrnWOSAF9j5pA8EBQQD
         IR6YRN15b7tUt/SNn10nExNTALNuqnEU5KfYV6tu5zPtkE1ZlItfjEWi7xVpMJxs7apK
         GdCJyK7c/OKbOC/V5i6f0TH3qCnTsFD7uv7VenmYFuSVCA/LMhyOKjhSOPdTXZ53gmi3
         rlYA==
X-Gm-Message-State: AOJu0YzWdYQbtCVMytYajYtYUgNXwPNiNOaewfz+tkLcTivyQXF9bXXV
	TCl/j40xrNu6CjDsDOhxZ9s=
X-Google-Smtp-Source: AGHT+IHVKkJpPd9T6rPx07fJdW8zAr7hZv2NELPnILenSSfcjSGDNDPwUELFAjvztmo8ShoOTQoLKw==
X-Received: by 2002:a17:90b:4c41:b0:285:9a34:5b40 with SMTP id np1-20020a17090b4c4100b002859a345b40mr5740305pjb.40.1701043009832;
        Sun, 26 Nov 2023 15:56:49 -0800 (PST)
Received: from localhost ([98.97.116.126])
        by smtp.gmail.com with ESMTPSA id ij30-20020a170902ab5e00b001cc3a6813f8sm7082451plb.154.2023.11.26.15.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 15:56:48 -0800 (PST)
Date: Sun, 26 Nov 2023 15:56:46 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jann Horn <jannh@google.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>
Cc: David Howells <dhowells@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <6563db3e1d1ef_68d9b208cf@john.notmuch>
In-Reply-To: <CAG48ez3dn7CAfTmfziBUd_aFfcM1LOYsUuYrKykZAvTv=AAodg@mail.gmail.com>
References: <20231122214447.675768-1-jannh@google.com>
 <CAG48ez3dn7CAfTmfziBUd_aFfcM1LOYsUuYrKykZAvTv=AAodg@mail.gmail.com>
Subject: Re: [PATCH net] tls: fix NULL deref on tls_sw_splice_eof() with empty
 record
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jann Horn wrote:
> On Wed, Nov 22, 2023 at 10:44=E2=80=AFPM Jann Horn <jannh@google.com> w=
rote:
> > syzkaller discovered that if tls_sw_splice_eof() is executed as part =
of
> > sendfile() when the plaintext/ciphertext sk_msg are empty, the send p=
ath
> > gets confused because the empty ciphertext buffer does not have enoug=
h
> > space for the encryption overhead. This causes tls_push_record() to g=
o on
> > the `split =3D true` path (which is only supposed to be used when int=
eracting
> > with an attached BPF program), and then get further confused and hit =
the
> > tls_merge_open_record() path, which then assumes that there must be a=
t
> > least one populated buffer element, leading to a NULL deref.
> =

> Ah, and in case you're looking for the corresponding syzkaller report,
> you can find that at
> <https://lore.kernel.org/all/000000000000347a250608e8a4d1@google.com/T/=
>.

I'm a bit slow, but looks good to me as well. Thanks a lot.

Acked-by: John Fastabend <john.fastabend@gmail.com>=

