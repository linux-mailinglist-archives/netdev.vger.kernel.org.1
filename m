Return-Path: <netdev+bounces-243123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC4EC99B54
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 02:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF743A4315
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 01:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9CC1C84CB;
	Tue,  2 Dec 2025 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaIZxlsG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFBD19DF8D
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 01:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764637785; cv=none; b=trOeQ0YeY1y8c6gsn2QXHuGRCXAz5W7D5S7EZr8Tld5OMe5pCkqULKv8f41CREcI2htB38PCXU4POryBwgMB4i2j09AiiuxHB+yUiYGDbx5RlzO5kQ8Co9467zSyfxdBcHtE3GmzFAWDTZvnLl/H71Ud8tx/6+++7VDrrUhNwDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764637785; c=relaxed/simple;
	bh=fx8Slcay7ujvA9t2WKlgcE4Vi+TvaCX8okT/+Nw/SE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTHoLp1m1RFvAxHeAIRDib9Xtw/MzEvKi+tJ8+q0k2tyXg2yOnnKqq8FO9PutwzS75CnsEAL5GqPIdZqzGLQUBLZcwaHQckLRqKOFpgDCOyfjRYRZLenU38zo+lvRuL8+1Y4P8pIG2AHQMti+TIlTysDox+t3G1bepJ3E/2V6ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaIZxlsG; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42e2b80ab25so1194833f8f.1
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 17:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764637782; x=1765242582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Szt2Mtf04VJJMA3huw3LwkNpjgtBKPYS4MiQjEEj3rs=;
        b=FaIZxlsGL+kZM9X6nwgABfGz2MVORILF0FQxKdzkmSG+0N1N1hperWj0NWJjRZ3tNc
         1nmutl7lYZCFT+DKMkW23Kk+QFJKT3aw8LuM8ZwCvfv9caFtIYoqA+KDkejoKI7vaskO
         XJweuKW4qCOX8Yc7xmg1wuWjKQ5dJTv5lHnsnOgzcADgTc5msgr/HMS91tEewl0QvkAO
         IxD/CdIHER2JS5t6Fbn4EK5twVs5FJsmqc5RDj4qq84aGcsBngM12KXN55aZklZwrYdu
         HmKtZy/Scb2VDQ+1lotJZlTW/RM49Qi6Oo6/S0R8+zKKsRhU2i1SaMA3yAovcK8rtHK7
         P/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764637782; x=1765242582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Szt2Mtf04VJJMA3huw3LwkNpjgtBKPYS4MiQjEEj3rs=;
        b=pmPxpAsfKZBaXwN0G31DMfN7pdb2ndpHU7ZHmICfhpV7KXaPrdatiHZtZABFZyuEze
         VXaHb7YNoKw/eItBKevAxZKWejyK/fCXp0pcKA0SkGunm7p6Azods55XnzOOXW/LsKha
         sB6mB9j7TBpWlxLCOVsqOgxCwv7qLUjDODwsepgBiu9vNvOi4fI+mw2PjNay7DeGILFq
         jrCAQtAroWUTBjviL7XufOM0Wle7XJSQSsmDOxiF0t49WeO38Pe44yIwgGDsEUhPm1JQ
         CHkm+3m4MrkoLX5YQ75AiPhvXyIURJHq9wLfGK3bD1hJbIlBJD9jh45b60MEoPqQG/Ti
         Tl7A==
X-Forwarded-Encrypted: i=1; AJvYcCVubyGXWihczolTMj2AS/jd45LhrFECKIW/aRcGZ5slmgJXpwEF0HETiSjTeaGH5VcdKHKg6HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrw8rN9HOHkFXIjuGaUxnDlTDw6BGLP327MbfMoNJpNwJD0TOn
	nMcV1UZS0dRe+EbCl+O7X8wiNeiIl0tOsYd5spwhy+0wx9c7RCRuxVyf5C4es+yEnLab14w9okf
	I5sxksxlcuJbj+aVnTc2+0dYhY2Gzv/A=
X-Gm-Gg: ASbGncv18THsMdfBWzHZz3qjMd7sBK4BgCSLMsPrC59i0BopgZhL3cggFBatpz71INw
	yZTqH+3AqgEuxB5wAbd962+PQ24r83rUm+MuQQDmGs/hrts4X/vFq6493R/llVPzW5LIhy96ok0
	qvdD7BQeL2dH6nU7kFu9VFj9cp8LqtA+wV2pOvKcf31v6Xb7vHg6FtaspjTJzXBg50PLeCXhsl+
	wiqJpI3Ztw0ujg/DQoVzK72OvRIFaS0fFold7hXLsmWnQhWiLh0B8YEPkEkdzS0dE1R4zbq/Q3k
	iPc1uRoIOGaTKj+OconMs3k43Jr+
X-Google-Smtp-Source: AGHT+IE4QVmBkAfuhCz9noFv4cBjzecOoS4F++oIbkbPwpzoHJ5MqtEUFeVwmn42unH0JLpt69vgN69hzdtzHdyfJ0M=
X-Received: by 2002:a05:6000:2dc5:b0:42b:3023:66a6 with SMTP id
 ffacd0b85a97d-42cc1d35666mr41384040f8f.40.1764637782125; Mon, 01 Dec 2025
 17:09:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202001822.2769330-2-ameryhung@gmail.com> <d396eeba7daf48c871d9690857c060e4080489c5f5da9841ca186c6442bc205b@mail.kernel.org>
In-Reply-To: <d396eeba7daf48c871d9690857c060e4080489c5f5da9841ca186c6442bc205b@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 1 Dec 2025 17:09:31 -0800
X-Gm-Features: AWmQ_bnkjn40mxBMuaQluzKzlmlBZEfXO_2GtsOKaYjenGQw8pmHxRcFUBpL_KM
Message-ID: <CAADnVQ+NHPc03DEFfB0Txaza8r+vWSM=jivKg=KApKzF+qvzcw@mail.gmail.com>
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Test using cgroup storage in a
 tail call callee program
To: bot+bpf-ci@kernel.org
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 4:35=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools=
/testing/selftests/bpf/prog_tests/tailcalls.c
> > index 0ab36503c..e4a5287f1 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
>
> [ ... ]
>
> > @@ -1648,6 +1649,28 @@ static void test_tailcall_bpf2bpf_freplace(void)
> >       tc_bpf2bpf__destroy(tc_skel);
> >  }
> >
> > +/*
> > + * test_tail_call_cgrp_storage makes sure that callee programs cannot
> > + * use cgroup storage
> > + */
> > +static void test_tailcall_cgrp_storage(void)
> > +{
> > +     int err, prog_fd, prog_array_fd, key =3D 0;
> > +     struct tailcall_cgrp_storage *skel;
> > +
> > +     skel =3D tailcall_cgrp_storage__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "tailcall_cgrp_storage__open_and_load"))
> > +             return;
> > +
> > +     prog_fd =3D bpf_program__fd(skel->progs.callee_prog);
> > +     prog_array_fd =3D bpf_map__fd(skel->maps.prog_array);
>                      ^^^^
>
> Should the return values of bpf_program__fd() and bpf_map__fd() be
> checked before use? Other tests in this file validate these return
> values (see test_tailcall_1 and similar tests which check for < 0).
>
> Without checking, if either function returns a negative error value,
> bpf_map_update_elem() could fail for the wrong reason (invalid FD),
> and ASSERT_ERR would still pass, potentially masking issues with the
> actual kernel restriction being tested.

Chris,

note... AI is wrong here.
We don't check FDs returned by these getters because skeleton open_and_load=
()
succeeded.

