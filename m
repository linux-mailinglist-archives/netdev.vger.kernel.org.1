Return-Path: <netdev+bounces-231369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAA3BF7F7A
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 19:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611771899BAE
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 17:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC75034D4ED;
	Tue, 21 Oct 2025 17:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/FboD36"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443A534D4E9
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068990; cv=none; b=GsMeyGCa+b6aNHBOEOsXJchb9KHU2GfTPClb3Te/1jSQa4WeQIImMAGagmA/c1aRzre1aK1262+v0BaBIMXpfRr9CdHIrBTwoEuyHaK0sd5KyXLLCc/MQ7YpMi33Qwd9cxHtdTsll0kjLtDUMdEruzOEwLa2wwF6uuUiygH5gQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068990; c=relaxed/simple;
	bh=qDzlcTloUqpO+I/XqJPhOmpCeUL3ayv4KE9vfDTV9es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwU6QdGO7rpjwqhGTMjzJKzLMjRcCOFDTX7iCvqbPS/2VZlSakX5pqW4gPuOvBv4DI/IQzWHXCoJj6kMhZLJ+KpiDN5veW5IBXj/f37NvdGKhMgqoMQbwBupRD7F/d+UyRzrEZJurQJ4GcnxuMX9CPrOIL7FDV90fyaMJv2I91M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/FboD36; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33292adb180so5851463a91.3
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 10:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761068988; x=1761673788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+q8Os3QV4AiQnNKQL40uNK7bo4U73YgmtqjVFwNJYtk=;
        b=N/FboD36fRPRysCGMLgON3wdGu5jHn+tLrRWNZbEv4TZ+9sajIv6xFsfG8OpEo/A7V
         JrKMOrLq7nG4BHMiIqQLXtyi5rx0gTuNj1DSQ8eey5IoR7NDWMMUoxl2zNJ2waJCd7DV
         69zS/qSjprlZR8RkzfcaI5muwwCf5qoKvAf9OJodBYMWSyJvZgJ3r9GIdfTChvGLCqT9
         eMgr72hSxYpU1bwp1z81IP/zwqkUodw0aeglsW1zUPbq2whFUiW7rjLyIBc7dJhvC1Ro
         DQXz6GZinONa+ynOqArDkbdZVvqaPKUmTmsok4oto4KtBAZ0sFzzxGrtGBilhKP1J7WG
         PQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761068988; x=1761673788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+q8Os3QV4AiQnNKQL40uNK7bo4U73YgmtqjVFwNJYtk=;
        b=w4z0F+qUUx39CEDn5z2QFBan7YeBo3iPigq0+mn9glPll2mQF+UU7PFqRUJpWALR7t
         N9+P6wijnT2AN5Jxn8/fT7o9BtUYCdkcV00wXeEO8Vd1WljQy8t30/9mFtgzrLAm6RN4
         /Oim3t0V7vMsQBbNCD/Ue31jgIdN+duVHybz9ZQucLCcGYSxghFrd2K1tyJjvQ2kHY02
         ZE1d0GX0rIEooAIasENv3mQ96tTfoEmnHOjcztPEiRSk0y5GMF9bpL/ig1+sJ3MELeKA
         3VeSUupB+5QttKPvJCskXvH+bVryq9WJF7B7ZFcvu2PvkomJTxQNZBdedHx2ywgtnkos
         4Vyg==
X-Forwarded-Encrypted: i=1; AJvYcCXyJ3Z9R5vs/T0IYv7RfGNLRTOkCBvbAVBHkEkJ8Gwt9zJZZeTuOuNzhSpBLKF21kD2Fj0audE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr8Ief0ixMnFD3of9+Q6BNbLDnPENK7qv/8jvSV5igPi+FBIxk
	Wq3Q8K0masiQSYhTS9vuyLMADVwM93t+7gzQXLwcXMw4gJDcWVfkRI2xAefDNksnPBnbo4/Jcu4
	u6B6MNCAQvTt7l0FV+pnw8Ae/FWfyyI8=
X-Gm-Gg: ASbGnctHtJjzrNsqq4uJcwfJd4m2fa2Ns4vvr5D7JQUPIqiY3gIZt3vvzMYL5yfHrXB
	o2cGY0rYAdlAi5PgxVTExuqH1LSfx5uKLUaLqRl6flOGOF1kGV/CGA0Eau1Ai192ZzGfIV2ov3E
	K2MrpG7/XryG/qTGxL331Q05+Bn4I0xVk9SbhbodT8k2Bm9SgrdYMYYvXIRQo4AHwrCNw1vqa0U
	7PFySsxtVgxePLDxxYI0eecOymKC2lk2q6rpsi6yXoyzrq7RdHce1VJIB5hUcWpHGrj
X-Google-Smtp-Source: AGHT+IGOXQgu6lQWhFyf+t/CSA1diNM3SwVxnFnjh0utUblYzFhYLfjlWfGOvy2Gt+AOFXij58+2eNPtcHopEifHSlY=
X-Received: by 2002:a17:90b:3d87:b0:33b:b020:595e with SMTP id
 98e67ed59e1d1-33bcf8f78cfmr21160963a91.25.1761068988525; Tue, 21 Oct 2025
 10:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHaCkmc_CrwBRj-Gji_td9S19oPg9U9-n8B4u8yTR4sPm9Vx7Q@mail.gmail.com>
In-Reply-To: <CAHaCkmc_CrwBRj-Gji_td9S19oPg9U9-n8B4u8yTR4sPm9Vx7Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 21 Oct 2025 10:49:36 -0700
X-Gm-Features: AS18NWAsfq3fhmrRaxV6XHiZww58Xefxp9cRzg3SYFrj93L49T-WggbE-aYzrZs
Message-ID: <CAEf4BzaKhqx+5O6k7i5naAxAhpPxBuWgy=ryFwkLzGROJxQbgw@mail.gmail.com>
Subject: Re: [PATCH] Fix up 'make versioncheck' issues
To: Jesper Juhl <jesperjuhl76@gmail.com>
Cc: wireguard@lists.zx2c4.com, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 7:09=E2=80=AFPM Jesper Juhl <jesperjuhl76@gmail.com=
> wrote:
>
> From d2e411b4cd37b1936a30d130e2b21e37e62e0cfb Mon Sep 17 00:00:00 2001
> From: Jesper Juhl <jesperjuhl76@gmail.com>
> Date: Tue, 21 Oct 2025 03:51:21 +0200
> Subject: [PATCH] [PATCH] Fix up 'make versioncheck' issues
>
> 'make versioncheck' currently flags a few files that don't need to
> needs it but doesn't include it. This patch fixes that up.
>
> Signed-Off-By: Jesper Juhl <jesperjuhl76@gmail.com>
> ---
> samples/bpf/spintest.bpf.c                                | 1 -
> tools/lib/bpf/bpf_helpers.h                               | 2 ++
> tools/testing/selftests/bpf/progs/dev_cgroup.c            | 1 -
> tools/testing/selftests/bpf/progs/netcnt_prog.c           | 2 --
> tools/testing/selftests/bpf/progs/test_map_lock.c         | 1 -
> tools/testing/selftests/bpf/progs/test_send_signal_kern.c | 1 -
> tools/testing/selftests/bpf/progs/test_spin_lock.c        | 1 -
> tools/testing/selftests/bpf/progs/test_tcp_estats.c       | 1 -
> tools/testing/selftests/wireguard/qemu/init.c             | 1 -
> 9 files changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/samples/bpf/spintest.bpf.c b/samples/bpf/spintest.bpf.c
> index cba5a9d507831..6278f6d0b731f 100644
> --- a/samples/bpf/spintest.bpf.c
> +++ b/samples/bpf/spintest.bpf.c
> @@ -5,7 +5,6 @@
>  * License as published by the Free Software Foundation.
>  */
> #include "vmlinux.h"
> -#include <linux/version.h>
> #include <bpf/bpf_helpers.h>
> #include <bpf/bpf_tracing.h>
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 80c0285406561..393ce1063a977 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -2,6 +2,8 @@
> #ifndef __BPF_HELPERS__
> #define __BPF_HELPERS__
>
> +#include <linux/version.h>
> +

this is libbpf's public API header, we are not adding linux/version.h
here. Linux version on which something was built has nothing to do
with the version of Linux on which the BPF program is actually
running. And BPF programs are most of the time intentionally Linux
version-agnostic.

[...]

