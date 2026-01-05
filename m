Return-Path: <netdev+bounces-247111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1BACF4AB1
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44909300D90D
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571D4346FDF;
	Mon,  5 Jan 2026 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ayzv1Gkz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578D0346FCA
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767629780; cv=none; b=q55x+USqEosDlp0jY/oioOla7tSQwO9rjNzlmEXCzf2FS3ZoBsOvhTqPJZKRQK1rKIK0ZlOFbs+xs33r5SAtmV0BjvluxlDm3/6ooa/1P6py51wjG9R4RlTXemYJ3qEivWb0TPIqfz91QNBo+g2GNtZH3vTDcrNo7a8RpiOttq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767629780; c=relaxed/simple;
	bh=24fnI8nAhGfjPILK+YRYQGQ1kkNBuj50/yvXc6+sXfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDstM7x12MPVyPfHgPwJ54J+7cO6Z/sW2ltCyvW5x86w8hKnFNytRvQ2LI24tDbWFQcgYCX2RAFXEv9qu+WlVvt8nG7ucwjCbTTiUr8qsG2eqGPa3yNqAVeArrxbQnhZeV+zi3uetQlCI/TsNJ0HrjDy2mZYE97JANfvnSpJl9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ayzv1Gkz; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b3b0d76fcso10080f8f.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 08:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767629777; x=1768234577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24fnI8nAhGfjPILK+YRYQGQ1kkNBuj50/yvXc6+sXfw=;
        b=Ayzv1Gkzgv8qiuwgV4detegm0uhyRyOQQG3S1ylZuywG5CHrNIocYC18Sjl9YrsYnB
         0/zplZpddcHF18xU5TfwWX76rrOetP5V/9zcJloerjYutjLiv354+GXu1qW+0A9mYS4S
         jLKa/b+g4C//SI8va05PnhWUQupsqxZBjaRzYpsvo1X4RBsKKP9rOb8Q3IuBu/Hf9ZSd
         Y/IW2yS6EJorer+HS2CtpZhfQtdkpRCgx2hbapqNvAZDOanyzoL6gqIaoXqRIOkFneLg
         3WfrJGgZTUTEqBnuDAUscMpghu9ZvQ9zILsnwIfOSM0un9GeUfIodtUHIeHM4Tk1IEEe
         pGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767629777; x=1768234577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=24fnI8nAhGfjPILK+YRYQGQ1kkNBuj50/yvXc6+sXfw=;
        b=wWqGTn8+/pDqe0okUCY7JtlKZNR05HvuuOLdntYsazMFM2AaKW6T7R4fXys4C4KV21
         B41l5ZlGgv7ncsAhbE5AgJTLHrIiPemArGCVazdmomk2GSTYbyXTLBP6iltvOKyKieiN
         pMK8r4xYQFEW2yhmM1Q5iHWV3SQFOf0Nyiw33SZFojU0wP0u3AVj86HNh70kbHlRYLf2
         37i6qvyECm4zIj0HvMpXqwOo8/gON+I8lOcpTM+QPgXFfkqxi7yeD0YSLNMph6FL9YsO
         R9EZh+XTtbp7ifEUOsEp/SZJ1emkjPeIYcj6DfRiNJxmJqe0egkAZhRpoDZBLTAjKT3x
         Sw6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCn/dTgYxfGyMqNYEz8prDnYsHutvIlbH8qZ9H1lMIk2QPUITOfYhpoJctPjzNpvbPWrzAFOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ynJ7sO7rlYMsvJTdAt34IKyHRByemsLefmAZ8zfhh8StjwdR
	MAqLA7nksSNgteQ3ysOwx81WkhojOXT4xHiSFPm39T2Vc2yNiN/4gIuXaYdhzB4q7kWyKqikIbh
	G0+yyPkVUR/uPKs0069T1YQpCnFcnUXo=
X-Gm-Gg: AY/fxX7xybgsfnXL12Rn/tQGwkYc65MnivCkvd9wpi4/Yo8AvOUY+zwGitx+j0m9o+h
	0XTRZKNji8VVvlYQbQZMLRR+aVHXnMhN/SOeU5FubNpDD8sOnGTa14w/ofns9qwedYiaP7iTdQf
	XrR5ys/5T/Itkf0H3fUYTenheGi3e8SLLHyoVEv5RkQayml0YcTRL7efRAPEkZJxr9UcVt2eZ2G
	X0QrBsExIkzv7Slr5Y1ZjKcVK8LZ4BsSSzRuJr9H5iERnENwtefkC2ZYsVgc9mmV7X7IvmeBWQb
	KISlu38wvRGm64iSi3LUgj2H4b+4
X-Google-Smtp-Source: AGHT+IESHgflPXvOIachn8Weu/Gj1rT+55EATQkV3//kOCtswflw/4k0GsKSLk6uxqw29XlNeXlkKp2z/dgKR9Squ1U=
X-Received: by 2002:a5d:5f55:0:b0:431:abb:942f with SMTP id
 ffacd0b85a97d-432bc9f60c8mr395235f8f.54.1767629776203; Mon, 05 Jan 2026
 08:16:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126221724.897221-6-samitolvanen@google.com> <6482b711-4def-427a-a416-f59fe08e61d0@redhat.com>
In-Reply-To: <6482b711-4def-427a-a416-f59fe08e61d0@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 Jan 2026 08:16:05 -0800
X-Gm-Features: AQt7F2oB28_RiadtNKU61c30UF9BbaZnytAxnF0RGG3ahLw-g3EBYxabF3xNxQg
Message-ID: <CAADnVQJVEEcRy9C99sPuo-LYPf_7Tu3AwF6gYx5nrk700Y1Eww@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/4] Use correct destructor kfunc types
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf <bpf@vger.kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 5:56=E2=80=AFAM Viktor Malik <vmalik@redhat.com> wro=
te:
>
> On 11/26/25 23:17, Sami Tolvanen wrote:
> > Hi folks,
> >
> > While running BPF self-tests with CONFIG_CFI (Control Flow
> > Integrity) enabled, I ran into a couple of failures in
> > bpf_obj_free_fields() caused by type mismatches between the
> > btf_dtor_kfunc_t function pointer type and the registered
> > destructor functions.
> >
> > It looks like we can't change the argument type for these
> > functions to match btf_dtor_kfunc_t because the verifier doesn't
> > like void pointer arguments for functions used in BPF programs,
> > so this series fixes the issue by adding stubs with correct types
> > to use as destructors for each instance of this I found in the
> > kernel tree.
> >
> > The last patch changes btf_check_dtor_kfuncs() to enforce the
> > function type when CFI is enabled, so we don't end up registering
> > destructors that panic the kernel.
>
> Hi,
>
> this seems to have slipped through the cracks so I'm bumping the thread.
> It would be nice if we could merge this.

It did. Please rebase, resend.

