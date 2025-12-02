Return-Path: <netdev+bounces-243151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C93C9A1CD
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 06:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B3554E185B
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 05:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7772F6597;
	Tue,  2 Dec 2025 05:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlxgzXLR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB94E2951A7
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 05:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764654269; cv=none; b=mjMtyGTLNsn5pghsylj6rwaAm0mCwf+/jYHRcV5uZ+MIJffaLxmc+ryKzDYr4u2+f43V2t3s5yg4lPsY+qrIIWXfW45ZPG87i12kUlxC1DYLjFhgZHnagiI5tdhayzWoil8DiMXCQoOcEbf3QBpnsFuh6QJoOgtiapLq1qIBHF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764654269; c=relaxed/simple;
	bh=dzrBE3HLiNUn17L3mS+Ea0RIJoVSv75RSe2d72/j3Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMtpArpBrq5Aph0iWRy0T5UG/RHZkC92OumBQ95z6Y/KrfXQ3gY4kb1b8HFGUY8sBR6aRMx6UmRJNxw+vOGY5uPUg4Dde6GyWcZ5JoAFski0YwLV5o2J/SQs3d/zUFipGGPQ4Ywtg3CnhrEqwjmwfMapdnGU1oUZMDmZ9CeFRgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlxgzXLR; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-641e942242cso4552612d50.1
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 21:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764654267; x=1765259067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzrBE3HLiNUn17L3mS+Ea0RIJoVSv75RSe2d72/j3Q8=;
        b=QlxgzXLR690rCMbJnETibgk69L4eFRbRRgK/wq8b0gyPTZ3dWAeFn52p6xqBuTbyz3
         BW+84ET9tfgoKluqAWAhuMZlAo+UbY4z+D4KqLDcSiC9Vo3pbHqpDDUtlChfKTPtb4Aa
         SuHIH2tEJmZsKpL4g++B6bTgcH6JvVP9AZc4OzAFLX9kQ/jVgc8LSHK4BP9AEKP49Y4z
         YEF4H/Zl9qFa6kad+5vqRBTwRT+7vfpJz0o0PRtGP8Tvej8HvX9qwXlqrQH27E5ELM7A
         hCXjXw9JMVtE2vqq3eYWst9VOP0NLrxVoNi6zclzF67KwJp2kk9SXhKYGXDE3aIWYZTI
         k2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764654267; x=1765259067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dzrBE3HLiNUn17L3mS+Ea0RIJoVSv75RSe2d72/j3Q8=;
        b=XsMK/Pm4p/3ors37PeULRFfbjsOOtWm7rHhd7+jBCBbXub7Yo1j2KziLtm3QCesZwl
         wbssr6tzkLiWZbeYKo0KFI+vIjOK8FRksF3/76Cq9xiunnxRGMYsaKaOgJ5TyYNjYyyF
         UkJ3WGvObwUtrxseBTkIE/5PGxWy3aeG+AyInkEHEERbfYfap8bL2NNclTjPe0vL7xUj
         P4FX6BsIg/H0tz8ATyD9H9Cc/DnKcNvWp8CyBTTe+8xIgA1WRydpgnnllGBICwiH2rKC
         mE7/5R/jjOgtZH7BvhzlxS3OonPigvlv3DfXxIH8t3X1TfWvSvy42d4hUCIjXsekEDT8
         UqKw==
X-Forwarded-Encrypted: i=1; AJvYcCXM2irCXJDpxb9yd+X9fepi6d2aSbfZiDkLneTWNnImVmRtKXikrI3sYDsWwWhkTFyfobnniDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwScUCQR9XkuB7tfyI0sn2sErr/hO3DGqNwd/1/ErRUsX3qRaWH
	xMJJYjnqOJucE3KDtXpfFYH0cVsrd0FNBVGXu2aycBhXWPIfp2MbIDt+qmgwqPkyAwDJmRt9bsb
	XRIRC80wjA8b1sUxqFRzWavA89KS4A0G6ew==
X-Gm-Gg: ASbGncuhxcy3QwdM/1+M2iV5JrygLOkwZ3EUbZp77Xy8WwM5Rrd1YPEUzVBRp3h/qCg
	o6Bt4Xzr/6z5GQFZYWOeEQ+LBroTph4uj/X3TTvtBt6m6zWjPYQUh4XtWCQakvwf7MFqblvJHZ2
	584XtuMi/x8arPBC6VrMpKHsT8UVzD46nX4oqAg8mZy2XpfoOLs0L2uCw4grJK4h5meJ+P02q7p
	SpD6gHfZEtnvoh6ASdofRXfHjOif+w4TmBTeDFr/xpz2kqhrWEoSl2aRX1zdxuRId4Idiw=
X-Google-Smtp-Source: AGHT+IHuUHMhLE/nocoGIHCdFzqfP8W2AeAsbPg0efL2+PhESyew/pc6r9wR5ERF6r5GC6P1VqvwkLJIBGv0OT75Rps=
X-Received: by 2002:a05:690e:d0f:b0:640:e6aa:b2bf with SMTP id
 956f58d0204a3-64302af07f6mr26362966d50.43.1764654266984; Mon, 01 Dec 2025
 21:44:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202001822.2769330-1-ameryhung@gmail.com> <20251202001822.2769330-2-ameryhung@gmail.com>
 <8da95cbd0f554e3ab62a40116f8fd08201a1d593.camel@gmail.com>
In-Reply-To: <8da95cbd0f554e3ab62a40116f8fd08201a1d593.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 1 Dec 2025 21:44:16 -0800
X-Gm-Features: AWmQ_bmKk84M7vxFOLjErxPn7U6_d6BSBJDqPc8BMD49He9DgGjgo26wnebBkRE
Message-ID: <CAMB2axOBJ-BceMjGwT4=E6h+Jh2ba70s70fFJvL4u9Bq389UXA@mail.gmail.com>
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Test using cgroup storage in a
 tail call callee program
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 5:08=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2025-12-01 at 16:18 -0800, Amery Hung wrote:
> > Check that a BPF program that uses cgroup storage cannot be added to
> > a program array map.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
>
> Hi Amery,
>
> Mabye I'm making some silly systematic mistake, but when I pick this
> test w/o picking patch #1 the test still passes.
> I'm at ff34657aa72a ("bpf: optimize bpf_map_update_elem() for map-in-map =
types").
> Inserting some printk shows that -EINVAL is propagated for map update
> from kernel/bpf/core.c:__bpf_prog_map_compatible() line 2406
> (`ret =3D map->owner->storage_cookie[i] =3D=3D cookie || !cookie;`).

Thanks for the double check! I simplified the selftest too much and
introduced the false negative.

There should be another program using the prog array and the same
cgroup storage in the first place so that the check here passes.

I will fix and resubmit.

>
> [...]

