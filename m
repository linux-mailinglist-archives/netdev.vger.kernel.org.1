Return-Path: <netdev+bounces-50274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AA37F52E3
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 22:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7022812E2
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 21:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529531C2A0;
	Wed, 22 Nov 2023 21:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pUzFtiWW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC5FB9
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 13:58:51 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so4126a12.0
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 13:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700690330; x=1701295130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AK1pw28z/HaK2fY8cE0EMmoeTfAqUXqCdbrdN/RymPA=;
        b=pUzFtiWWFZDpZCwS1gIRqq9UphFRB4nDwESEaZw8dP4ThzzHBRN+GYx2MOBeJdBOr/
         YZ1Azvb0AfjBvJ1r7GkCklsxEr8kaikoZSYqwFuOHwP7K3sPiJLJy+qNg5DA4ANfXY6s
         g/XZtf5rX4A+36XL/um4JoY3JSpj3OXi0FdNMkTfDxN3/mkzH1/1FdIHqu/aJKPcSh0W
         actNsoJ4h8TX1CEbdcu0/1d5fElGTtxCocP7HPYAF3gBCVI/ji8GC5jM2fB+T1cF1N+J
         Ed4qj1vu+ZHYtecdy6LR0F39/Accl4+Zr1X9/g3dJcAu59phaXDeoN3Eew4/NVzajvoj
         N+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700690330; x=1701295130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AK1pw28z/HaK2fY8cE0EMmoeTfAqUXqCdbrdN/RymPA=;
        b=YIOS8VS7F8Wvt3GJj5wSmsJAm6hs7PKayh8RHoQvKhKuRHs4Iqc6KFRtK5n53FvDlS
         KtGABhHIm4J78PWt5wHXSsoxlpx4AhGs1uQ+mQgQIT7dz8ncA5l/7qfA5UavrgcX9q/y
         f0tv2ts5RyhDI/+X2iR3wvDfZ3+UHHi675QF20V991EyJhDPRCtwUAH7hlKDwPxfdcqR
         K2yyYJvYzmTSX2DMn0uIojPiEft4EM87OOecfjS9fTDVEFCfYQdf81pGleFN7Tn9r3Aw
         GoVv/lK1Cn5hthG4SghzgohaGkRovBexRSBDjkC+u08F/bglQ4kFatEgyKHgf+VppRha
         pdAA==
X-Gm-Message-State: AOJu0Yx0Yaa0bpLWDr5mcGFv4RORLtV/8d+76esfFa9XIoMiWtmeKXFH
	s8pHdoj4V09a6XUgGzkuQ/a27hgsZMYvT7WuW3i3lw==
X-Google-Smtp-Source: AGHT+IERHVdSXfcSI9zAEB8ij5FiDwSSR+1fzQBPD+GC4e+8LIFAScmcdHp/gGoUuBLQleX1qtB4O3DpkYAU4Y2pYdU=
X-Received: by 2002:a05:6402:540a:b0:545:279:d075 with SMTP id
 ev10-20020a056402540a00b005450279d075mr212819edb.1.1700690329979; Wed, 22 Nov
 2023 13:58:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122214447.675768-1-jannh@google.com>
In-Reply-To: <20231122214447.675768-1-jannh@google.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 22 Nov 2023 22:58:13 +0100
Message-ID: <CAG48ez3dn7CAfTmfziBUd_aFfcM1LOYsUuYrKykZAvTv=AAodg@mail.gmail.com>
Subject: Re: [PATCH net] tls: fix NULL deref on tls_sw_splice_eof() with empty record
To: Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 10:44=E2=80=AFPM Jann Horn <jannh@google.com> wrote=
:
> syzkaller discovered that if tls_sw_splice_eof() is executed as part of
> sendfile() when the plaintext/ciphertext sk_msg are empty, the send path
> gets confused because the empty ciphertext buffer does not have enough
> space for the encryption overhead. This causes tls_push_record() to go on
> the `split =3D true` path (which is only supposed to be used when interac=
ting
> with an attached BPF program), and then get further confused and hit the
> tls_merge_open_record() path, which then assumes that there must be at
> least one populated buffer element, leading to a NULL deref.

Ah, and in case you're looking for the corresponding syzkaller report,
you can find that at
<https://lore.kernel.org/all/000000000000347a250608e8a4d1@google.com/T/>.

