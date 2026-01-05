Return-Path: <netdev+bounces-247177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E86CF5428
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 19:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 703D9302B512
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 18:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C065340262;
	Mon,  5 Jan 2026 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/qZ2CdX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753DA2773CA
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767638711; cv=none; b=YTS6TPN0KNn4rhBxssF+jYoHsYKtJz7E/E1q2picp2sq0jc9UImLUhyhlhN9CZe39x9pUyrBjNYubv3r26kB05BCx/yCCLShTFKjVVtZ7TD6zity0LSZWOS4YYaKu/ol3dRICjl1EC1vaK/tDlfbnY+wNSjG4leVKXsfjh1hG3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767638711; c=relaxed/simple;
	bh=rbGQR7bO1U/wYSEHJnMVpstTwl+5uqG5xkcl2l9kdRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gb5Vt7RUqA2m9+rejV7BLT6NyMcE0XP0kfLJaYDg3IN97kTEA0fxW6GP9JaZWDSQQ/6ZEzAOnBc9/rR2erMW67W98J9tc/YlaCidU0PPBljBrwS7hUHbYpEua+YKiV9bHF5EDaxwWpgrqTJgIdb6BSZPwUSc4Fz5Gl8lwdk3mBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/qZ2CdX; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6446c924f9eso191461d50.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 10:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767638709; x=1768243509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Deiy2zBp/meQvwwK8ioSdUXRTHiuTJjk9tCLAnefkCw=;
        b=D/qZ2CdXV0Cv07j5pptwm62kH/CBh8VdzCD86SUZof/vuKAL+10VCJFuO6HTbC2Pw/
         NYLiBa8htDKD5RR7E4STOQlEl2oxtxs9QIYhU0ZhjG1hPcMuADZKGd0bg3uhF6q/0JnL
         DC3O1TkV6dkXJij6ozeAu0HVwGXnxMB7Y9vtdDcAYfAAAAcLnO/wWsxK8RNWHdP7ZQUt
         z+yYZOZ4GJSIVctE4JIwytd71/CrUAC/mFr9ox1VZRzdeN9CTg2+RxcHZ6H9k6YG/ZGm
         NkTnRgZ9wEhwLLVe4Yhk5NMQwDyQkOCZilKYHEMCSJW/JXgqC6OjzNHPMcglwelycoG/
         V0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767638709; x=1768243509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Deiy2zBp/meQvwwK8ioSdUXRTHiuTJjk9tCLAnefkCw=;
        b=ZiDA4/xdV+Vs86Z/9gI8TNADhwa4RPG5HgiJpl/PdlYLdFq8sLpCnX9FvK791+kctB
         sALZZ4ASX3qsvUc4In+QE4xWJzIrJPL3kFs+K3ju/iIrKQSFJEXLRgmagaO4X6OLwjXD
         TGETXcfX9EUEvFfMJEMKxWluDe1XzAGPYjjUkun3uS8oFFDrom5wUaBYbg2yLCV4h1lk
         PC0IBS1GUyuM1iGSGrZRIlXnKIs2v4wTAzW3PkMg1Nm1t4rX7I833WO6pspi2ZJiCF7w
         1JuzwOB6mtGGliX7gcHkPZztn1UEVHvkxrZVJ9vZzt2jIIrqAswIOAUJ43ECCeWESEYj
         alww==
X-Forwarded-Encrypted: i=1; AJvYcCUoLh/x8j9pGWxxqFSNXLXgRXo8NOKd56ofwqZyF/csbwepB60ddvz+XDu3lvHXtMvIXAFmRD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6LrA17IxnrVgefa2MNSS5gkkopZOVuTDHqhnavFlHtSGA6GpC
	DpBmhcPT5Ol7xjhEDbyd1BwmtRMLWHohkRAO9YKPUO3yiWKyYcwusvUrH1XpFX4CXasHPre9WRu
	gcBWJfLmR6LR/L4c7Jcik0YOE1CTqvBM=
X-Gm-Gg: AY/fxX5H91dTerT9+hlRqD6wKIbf53TOzyKB5ZjCe4hKmRSXVAtiQvtFkGnyHRq6j3x
	MHhhypkrjDmm50g1etetC/pzN+vPvIdLWa340lbZGT1FY5QvPwjKoZ8KLVgxXxPGlU7udM1W9/e
	X2v41sK0ejFZXiDiscvnIaxcNkzFTFlanQGim/J0FKmkPoxx0D8JAMJxY4LfXnOHQpxiViHykNJ
	S/S/HyTRcwdycXZNtqS4DvTdkQ0UwrhM+kQL8exlvf1acCFXW1SfbofQ9Umyz8n0UnwYUP7UOk7
	iRNHZdF3cuU2uJ3s+qR2Mw==
X-Google-Smtp-Source: AGHT+IF7MCnUxaifG8cLP9WvTe9fklhXXwOq1Y3xCMxCHq/dKm5YGoPlK6+Gw72xWukbHnjjKx7ncGcIa79gfBsbwWc=
X-Received: by 2002:a05:690e:404:b0:645:5cd9:cb42 with SMTP id
 956f58d0204a3-6470c96ad70mr267607d50.91.1767638709302; Mon, 05 Jan 2026
 10:45:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105114747.1358750-1-toke@redhat.com> <20260105114747.1358750-2-toke@redhat.com>
In-Reply-To: <20260105114747.1358750-2-toke@redhat.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 5 Jan 2026 10:44:58 -0800
X-Gm-Features: AQt7F2pSKANzcDxnmmuWEb_gzUDCI4KyK278dYJazOaIftJIcy3IhE2tYOFarqo
Message-ID: <CAMB2axPO7VENB-XUSUb5eU1ae7h0NBjbVukzxaObBDMMmkGYAw@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Update xdp_context_test_run test
 to check maximum metadata size
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 3:48=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> Update the selftest to check that the metadata size check takes the
> xdp_frame size into account in bpf_prog_test_run. The original
> check (for meta size 256) was broken because the data frame supplied was
> smaller than this, triggering a different EINVAL return. So supply a
> larger data frame for this test to make sure we actually exercise the
> check we think we are.
>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  .../bpf/prog_tests/xdp_context_test_run.c          | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.=
c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> index ee94c281888a..24d7d6d8fea1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> @@ -47,6 +47,7 @@ void test_xdp_context_test_run(void)
>         struct test_xdp_context_test_run *skel =3D NULL;
>         char data[sizeof(pkt_v4) + sizeof(__u32)];
>         char bad_ctx[sizeof(struct xdp_md) + 1];
> +       char large_data[256];
>         struct xdp_md ctx_in, ctx_out;
>         DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
>                             .data_in =3D &data,
> @@ -94,9 +95,6 @@ void test_xdp_context_test_run(void)
>         test_xdp_context_error(prog_fd, opts, 4, sizeof(__u32), sizeof(da=
ta),
>                                0, 0, 0);
>
> -       /* Meta data must be 255 bytes or smaller */
> -       test_xdp_context_error(prog_fd, opts, 0, 256, sizeof(data), 0, 0,=
 0);
> -
>         /* Total size of data must be data_end - data_meta or larger */
>         test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32),
>                                sizeof(data) + 1, 0, 0, 0);
> @@ -116,6 +114,16 @@ void test_xdp_context_test_run(void)
>         test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32), sizeof(da=
ta),
>                                0, 0, 1);
>
> +       /* Meta data must be 216 bytes or smaller (256 - sizeof(struct
> +        * xdp_frame)). Test both nearest invalid size and nearest invali=
d
> +        * 4-byte-aligned size, and make sure data_in is large enough tha=
t we
> +        * actually hit the cheeck on metadata length

nit: a typo here: cheeck -> check

> +        */
> +       opts.data_in =3D large_data;
> +       opts.data_size_in =3D sizeof(large_data);
> +       test_xdp_context_error(prog_fd, opts, 0, 217, sizeof(large_data),=
 0, 0, 0);
> +       test_xdp_context_error(prog_fd, opts, 0, 220, sizeof(large_data),=
 0, 0, 0);
> +
>         test_xdp_context_test_run__destroy(skel);
>  }

Reviewed-by: Amery Hung <ameryhung@gmail.com>

>
> --
> 2.52.0
>
>

