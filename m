Return-Path: <netdev+bounces-241707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EF4C87880
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 00:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E10F94E118D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA45B2F1FD2;
	Tue, 25 Nov 2025 23:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htghQKs1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3721F2EC081
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 23:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764114974; cv=none; b=i0mYhX0p24cbiDamtdSAUXm/F1NP2/EF/5hPrE7D7Dmw+xiOWV4s/9V4z3Owyl8KRRxiFmYqAzT72/7nSywPlDMmyVLaBhh55TtsyZWCvVwDWfZS9z8LmI0OgqLufMvo98Mq0Ggfwb6gcuFLDJnCvENZcpIus+qoV1vfyxPTHEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764114974; c=relaxed/simple;
	bh=H080vX4YurB5e93JDeizK6QEgeZAn2gtt/NXqmFBQSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYAFIMWzNLGKKCYtrrwO37b0nh+hCYvu4zDimxfCTXPWHaMMo0uMY3U53R3ieCE6nSJKnaLw0rBRG2/Bn8UVlBM1IOECzgHUjvFg5kMB00pVwrJqlygDKPiYuJmlIi3TpSMJ4RhDy9yHZSk/KRa1WBI+6i9zEqRXiSvrc6AWpM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htghQKs1; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-641e4744e59so6407581d50.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 15:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764114972; x=1764719772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3yKf+aQFxA29RhHDmXYa/mJ/7wBlN0n3BsJhs0SU+s=;
        b=htghQKs1o6lVdWePmHEsaoW04NPQh4PU8thWP9et4xqaaYzlCXbc9xMQyXz8a95cK+
         jFN3/cslTwSM5AmX+MXHrpA+XcoXaB+jdQYZGgaXDLomsGvMvEeQh9du1jBgMEWxqHBb
         Oc0Mo16xSHHAWLhcS5naA8LIps29hLHVrTndsX1bQrQ6cwyIUWyECGHSwMp4nhp25JEo
         cpd3mGemdfayAnwB6P8DiT7lbhnkzYNovbVhdos0gVwc3ZRMNC3h5AjBg52om5ak0tOY
         ZhK3/bphY9EQEk4Soz69aiN3LV4xVI1a1ikGtdDpJcuXQNIPigXvqheC7VXlDOUBS0G6
         WPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764114972; x=1764719772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M3yKf+aQFxA29RhHDmXYa/mJ/7wBlN0n3BsJhs0SU+s=;
        b=DqeAmlUExG2EEuZukOAHAvPxAzx2+8BAD86rAqwFy72mQMxwrNgHPZQiFs954rQTXm
         KIeQ4P+VYPPOdoCa93TYkeJ4jR7W+BusgyHxRFXzhD0BiNS0ULSw5Oi+PgNrOsqWnU1b
         qsR6mSEvs7togsFdticm2NYRRFNv6rHIzBlRVZV+PStYLweIJG+eFSYrJTftU2FSWMqk
         vHskMqfIe41izHl7T73B4AYo0PvoGmQoDBJv7AGl1WNMncCywUA3TP5afkpev+re4OMe
         01msovhDAh/WXiA9cPz/OTMapB4ks9ubg+GZJEac22ZknX0RvT1o+ee4okr+oWOUsbNY
         BQdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO8CKl2iBjBlK6jyTmHz4n6uU+tbWb1Azn9BV7djVC6E5cGI+uSXVhYy6geBYMuIHLNVxYEEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj27+QeE8XMo0dPr2s4jitZNnTITY8BQLB35cbsbi94eJmprGB
	DbBqw/o4Kdibth7p8YPNsNsBlgyEfDLpU/6v0NHMJSZBHKILPH92OCfW9jogAFV8tdPw+01yJ2t
	4k3j9r+/dQS2AVD80pPkHAb5jh0FPfhk=
X-Gm-Gg: ASbGncvihdQRcWiHZ/weCChhuoObXeKzlFyQQwgqKMzIQlweUR+bA4ieOpNjP+iYc0F
	5hWkqjCWuEloBSAwtueDrsUAIm5ACQjFk/Af5KLp1vsbewMjNmb19gcSe5F0l5vg7QQCTFQYW0n
	jcpCo/3rq8EMJ2+LssQk1lgq2nYoYh2vOGpqBRXuUpVaan+FsObtJDRMHjUBasf+9os96/ymd16
	ZA2XJpOMs++9Ow6ahCALP82jvL/TW8FjYwo2K+w0O80ppOh5vUXX46lLw8HWX6jnl6cb30=
X-Google-Smtp-Source: AGHT+IEic9zmDmvcE15t3xCWiKuGR2APwNflrHos7ck77oDFQcZ9/oT6oLEOYKdagZp7FUMds3nir+ULf0C6CgLTvH0=
X-Received: by 2002:a05:690c:4c01:b0:788:20ec:aeda with SMTP id
 00721157ae682-78a8b575346mr145573287b3.68.1764114972176; Tue, 25 Nov 2025
 15:56:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121231352.4032020-1-ameryhung@gmail.com> <20251121231352.4032020-4-ameryhung@gmail.com>
 <CAEf4BzYaiBYKEvLZk78MMj1R1yjeTZ5P=C7QCrUquh250ENcpA@mail.gmail.com>
In-Reply-To: <CAEf4BzYaiBYKEvLZk78MMj1R1yjeTZ5P=C7QCrUquh250ENcpA@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 25 Nov 2025 15:56:01 -0800
X-Gm-Features: AWmQ_blueJoNaHDbkSWa9ZhNdTnuWW5-CSJtpifO2oD7UFCm-wvvXP5NsZCD7Xo
Message-ID: <CAMB2axMFJFub4G5j_a0vTdY778r61KLcxxuWG0z9ftktqLbQgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 3/6] libbpf: Add support for associating BPF
 program with struct_ops
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 3:54=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Nov 21, 2025 at 3:14=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > Add low-level wrapper and libbpf API for BPF_PROG_ASSOC_STRUCT_OPS
> > command in the bpf() syscall.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  tools/lib/bpf/bpf.c      | 19 +++++++++++++++++++
> >  tools/lib/bpf/bpf.h      | 21 +++++++++++++++++++++
> >  tools/lib/bpf/libbpf.c   | 31 +++++++++++++++++++++++++++++++
> >  tools/lib/bpf/libbpf.h   | 16 ++++++++++++++++
> >  tools/lib/bpf/libbpf.map |  2 ++
> >  5 files changed, 89 insertions(+)
> >
>
> [...]
>
> >
> > +int bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf=
_map *map,
> > +                                 struct bpf_prog_assoc_struct_ops_opts=
 *opts)
> > +{
> > +       int prog_fd, map_fd;
> > +
> > +       prog_fd =3D bpf_program__fd(prog);
> > +       if (prog_fd < 0) {
> > +               pr_warn("prog '%s': can't associate BPF program without=
 FD (was it loaded?)\n",
> > +                       prog->name);
> > +               return -EINVAL;
>
> This is an error return path from the public libbpf API, please use
> libbpf_err() everywhere to ensure errno is set. Missed this in earlier
> revisions, sorry.

Will fix this in the next respin. Thanks for the review!

>
> > +       }
> > +
> > +       if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) {
> > +               pr_warn("prog '%s': can't associate struct_ops program\=
n", prog->name);
> > +               return -EINVAL;
> > +       }
> > +
>
> [...]

