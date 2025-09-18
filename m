Return-Path: <netdev+bounces-224601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B68B86BB3
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 21:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2ADF464835
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082D42E1EE2;
	Thu, 18 Sep 2025 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAOZGew6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC772E11CB
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224609; cv=none; b=O2VyLdbUD0VJ4PTXrJIHZp5ghn6Dp63VLjijNSyRPnRDFA5+r4CTEoV0vfq5Oyjg4rgR8Mf/WTZcXq5l5pZNJpyjNoOQduUTkY2yG9+9EH4y5WBozSlvsVMEls5np+cIWSzQt+WaI1+26nHBGytMm5Lsm48B7ZcB/NEkQnXZ8x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224609; c=relaxed/simple;
	bh=7oqERi05BDM41kYuRXU/Ce4ZHasAcEi/Km8+BK0j3os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R99T0I+e9SNF/HRE8v1DzlGQuwxQUP3KP84cMrO8WLSIiIgOZ7fS0ZVeZj07K1/xt5ZyU0jLm+vyp1InOoAreS3KRLYMA3n5VjBGNG7bpa3EZbVQHxWjW2EEewNa1DIQQKHpGbXYNrm7O7tVFkHBxSAc0v4486n5gUKpNJUI2WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAOZGew6; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d5fb5e34cso14389097b3.0
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 12:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758224607; x=1758829407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GZVKPpOdFCbsWISOjzAzYr8joLlGjS++6os8dk7SJg=;
        b=IAOZGew6i2oH3bjzAn1zMMjqAMf9T3FWW5OTyziLo+WAkB3F6m0f3fz/UC66nq5oi7
         C8MWkWn1L3DVGmX5gzziLbXMUlKxOQg2XxPvzWIM9/K6YOca5cyh1dbjAE7fZSrdmESI
         DPrAN2BhVvTu9L7pnUxgrYJYk0PmmwgPCLweEG0tZDMngcEBDWmJ+/SqgYtMUCSlxP6E
         YckSyOPaCoCPPdIJE3rm0GR5pI4/gdAI2rxeXc/+b1o9IXP+RaOyrJeQrbsNGDZfwLPW
         LDYMHktekdc525sHqjnO0OESgvnlJyE32CtndV+5DUc0y5I0c1KBQfoyyZABOwEdT0Ci
         m9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758224607; x=1758829407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GZVKPpOdFCbsWISOjzAzYr8joLlGjS++6os8dk7SJg=;
        b=QmocG9A9ZxII5NKKLryJJePTEPFprTFcAK4/cjBxFloNinTiUkOKx8bjnVFUZB51Kf
         GKtbEgxQaiv8zFw6odW0zIQx6RwLQLmuOZpPiy4joQWoqJd/Ib2jXxDTzRwqh4R2gMkX
         sw0TYDtLGI/1HdPOMeKD7yJvKukedvyigzvh8ec2rRV4z7VP5d4rRNF2PBezHp/pcBwJ
         p1MEsLvAq966kOqtKBfzn+ujTC3cY7rNTrkzzJZxHQUFiWdmfRwEQ5jGM8juCB1k6l8G
         4tDJ01yabV+xxLux4yFqfbsPhMTGJxrLOEBsa8vLKSrqP6QwhBh6oVjkrPtfKXEZr271
         EXhA==
X-Forwarded-Encrypted: i=1; AJvYcCUfshUy0ldzEQaMj4IdfHmV9V56sbP90ifGdEXSEBd3WOItmNuUwhW+MoEr6qd1NgC7/840BIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDMi3SJ50p3dc1m07t7OOaodf9EKf7ilOu2WC9JRk46RCCjewD
	FRiteqvRYTEEvIkoE8MlaZ9U5vYY3IRv6bIG4ik3GsXASre2L5QRO7x4SzuCJjgJVjxPGHLHT56
	10kPdrqc0QOqV/xW6ckTDlo1EnzNQxl8=
X-Gm-Gg: ASbGncsfKIgqeGbH1tZF+ezY0Zt3zdyC7egqpQdtPzMmXfQVbJtVO7rp0A/uaDe8L6j
	7GAVb4Vre53mmxjBp/cnuTbPL6tDFZKvFSIylrZUxJQhhOmPcgRqNdGtArAcfQArf5kOmWaOzDr
	b4T8MevC8Mb7izoyoCm36uR53lc+gqp5iBj4k0TpjR0kT5fL7U5eVp0FJ4+YAQpx7taJnqjbUSC
	LH+S6kejDg/NMEGA5cSWa9QnOuV0sTq06V9Ngl4TA==
X-Google-Smtp-Source: AGHT+IErZdK7Wo9oZcaphTc8DlzmrW27709aHRXoe/1ib/I7sJKpdI4x2TK+T8MXOn7iJ+yBVtOTRUNE8TcmbIjZCqY=
X-Received: by 2002:a05:690c:6887:b0:720:8df:f7a9 with SMTP id
 00721157ae682-73cc45b4c49mr10492087b3.5.1758224606716; Thu, 18 Sep 2025
 12:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917225513.3388199-1-ameryhung@gmail.com> <20250917225513.3388199-6-ameryhung@gmail.com>
 <aMvuHBb0+IIiXXuG@boxer>
In-Reply-To: <aMvuHBb0+IIiXXuG@boxer>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 18 Sep 2025 12:43:13 -0700
X-Gm-Features: AS18NWAmywcDsGBkYvYDOTx6VQJxG8PGAz3JxqwO5sgOSloCNddPr-kNmCnoJNY
Message-ID: <CAMB2axNx_NDkC+nZdpOB5kPmq0Sf1=d2g4NjkPnxEURfuV2eKA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 5/6] selftests/bpf: Test bpf_xdp_pull_data
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, paul.chaignon@gmail.com, 
	kuba@kernel.org, stfomichev@gmail.com, martin.lau@kernel.org, 
	mohsin.bashr@gmail.com, noren@nvidia.com, dtatulea@nvidia.com, 
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 4:34=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, Sep 17, 2025 at 03:55:12PM -0700, Amery Hung wrote:
> > Test bpf_xdp_pull_data() with xdp packets with different layouts. The
> > xdp bpf program first checks if the layout is as expected. Then, it
> > calls bpf_xdp_pull_data(). Finally, it checks the 0xbb marker at offset
> > 1024 using directly packet access.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/xdp_pull_data.c  | 176 ++++++++++++++++++
> >  .../selftests/bpf/progs/test_xdp_pull_data.c  |  48 +++++
> >  2 files changed, 224 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_dat=
a.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_dat=
a.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c b/t=
ools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
> > new file mode 100644
> > index 000000000000..c16801b73fed
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
> > @@ -0,0 +1,176 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <test_progs.h>
> > +#include <network_helpers.h>
> > +#include "test_xdp_pull_data.skel.h"
> > +
> > +#define PULL_MAX     (1 << 31)
> > +#define PULL_PLUS_ONE        (1 << 30)
> > +
> > +#define XDP_PACKET_HEADROOM 256
> > +
> > +/* Find sizes of struct skb_shared_info and struct xdp_frame so that
> > + * we can calculate the maximum pull lengths for test cases
>
> do you really need this hack? Wouldn't it be possible to find these sizes
> via BTF?

It is possible. I will use kernel BTF to find the sizes.

>
> > + */
> > +static int find_xdp_sizes(struct test_xdp_pull_data *skel, int frame_s=
z)
> > +{
> > +     LIBBPF_OPTS(bpf_test_run_opts, topts);
> > +     struct xdp_md ctx =3D {};
> > +     int prog_fd, err;
> > +     __u8 *buf;
> > +
> > +     buf =3D calloc(frame_sz, sizeof(__u8));
> > +     if (!ASSERT_OK_PTR(buf, "calloc buf"))
> > +             return -ENOMEM;
> > +
> > +     topts.data_in =3D buf;
> > +     topts.data_out =3D buf;
> > +     topts.data_size_in =3D frame_sz;
> > +     topts.data_size_out =3D frame_sz;
> > +     /* Pass a data_end larger than the linear space available to make=
 sure
> > +      * bpf_prog_test_run_xdp() will fill the linear data area so that
> > +      * xdp_find_data_hard_end can infer the size of struct skb_shared=
_info
>
> what is xdp_find_data_hard_end ?

It is supposed to be the XDP program, xdp_find_sizes. Will remove it
as we use BTF to find sizes.

>
> > +      */
> > +     ctx.data_end =3D frame_sz;
> > +     topts.ctx_in =3D &ctx;
> > +     topts.ctx_out =3D &ctx;
> > +     topts.ctx_size_in =3D sizeof(ctx);
> > +     topts.ctx_size_out =3D sizeof(ctx);
> > +
> > +     prog_fd =3D bpf_program__fd(skel->progs.xdp_find_sizes);
> > +     err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> > +     ASSERT_OK(err, "bpf_prog_test_run_opts");
> > +
> > +     free(buf);
> > +
> > +     return err;
> > +}
> > +
> > +/* xdp_pull_data_prog will directly read a marker 0xbb stored at buf[1=
024]
> > + * so caller expecting XDP_PASS should always pass pull_len no less th=
an 1024
> > + */
> > +static void run_test(struct test_xdp_pull_data *skel, int retval,
> > +                  int frame_sz, int buff_len, int meta_len, int data_l=
en,
> > +                  int pull_len)
> > +{
> > +     LIBBPF_OPTS(bpf_test_run_opts, topts);
> > +     struct xdp_md ctx =3D {};
> > +     int prog_fd, err;
> > +     __u8 *buf;
> > +
> > +     buf =3D calloc(buff_len, sizeof(__u8));
> > +     if (!ASSERT_OK_PTR(buf, "calloc buf"))
> > +             return;
> > +
> > +     buf[meta_len + 1023] =3D 0xaa;
> > +     buf[meta_len + 1024] =3D 0xbb;
> > +     buf[meta_len + 1025] =3D 0xcc;
> > +
> > +     topts.data_in =3D buf;
> > +     topts.data_out =3D buf;
> > +     topts.data_size_in =3D buff_len;
> > +     topts.data_size_out =3D buff_len;
> > +     ctx.data =3D meta_len;
> > +     ctx.data_end =3D meta_len + data_len;
> > +     topts.ctx_in =3D &ctx;
> > +     topts.ctx_out =3D &ctx;
> > +     topts.ctx_size_in =3D sizeof(ctx);
> > +     topts.ctx_size_out =3D sizeof(ctx);
> > +
> > +     skel->bss->data_len =3D data_len;
> > +     if (pull_len & PULL_MAX) {
> > +             int headroom =3D XDP_PACKET_HEADROOM - meta_len - skel->b=
ss->xdpf_sz;
> > +             int tailroom =3D frame_sz - XDP_PACKET_HEADROOM -
> > +                            data_len - skel->bss->sinfo_sz;
> > +
> > +             pull_len =3D pull_len & PULL_PLUS_ONE ? 1 : 0;
>
> nit: pull_len =3D !!(pull_len & PULL_PLUS_ONE);
>
> > +             pull_len +=3D headroom + tailroom + data_len;
> > +     }
> > +     skel->bss->pull_len =3D pull_len;
> > +
> > +     prog_fd =3D bpf_program__fd(skel->progs.xdp_pull_data_prog);
> > +     err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> > +     ASSERT_OK(err, "bpf_prog_test_run_opts");
> > +     ASSERT_EQ(topts.retval, retval, "xdp_pull_data_prog retval");
> > +
> > +     if (retval =3D=3D XDP_DROP)
> > +             goto out;
> > +
> > +     ASSERT_EQ(ctx.data_end, meta_len + pull_len, "linear data size");
> > +     ASSERT_EQ(topts.data_size_out, buff_len, "linear + non-linear dat=
a size");
> > +     /* Make sure data around xdp->data_end was not messed up by
> > +      * bpf_xdp_pull_data()
> > +      */
> > +     ASSERT_EQ(buf[meta_len + 1023], 0xaa, "data[1023]");
> > +     ASSERT_EQ(buf[meta_len + 1024], 0xbb, "data[1024]");
> > +     ASSERT_EQ(buf[meta_len + 1025], 0xcc, "data[1025]");
> > +out:
> > +     free(buf);
> > +}
> > +
> > +static void test_xdp_pull_data_basic(void)
> > +{
> > +     u32 pg_sz, max_meta_len, max_data_len;
> > +     struct test_xdp_pull_data *skel;
> > +
> > +     skel =3D test_xdp_pull_data__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "test_xdp_pull_data__open_and_load"))
> > +             return;
> > +
> > +     pg_sz =3D sysconf(_SC_PAGE_SIZE);
> > +
> > +     if (find_xdp_sizes(skel, pg_sz))
> > +             goto out;
> > +
> > +     max_meta_len =3D XDP_PACKET_HEADROOM - skel->bss->xdpf_sz;
> > +     max_data_len =3D pg_sz - XDP_PACKET_HEADROOM - skel->bss->sinfo_s=
z;
> > +
> > +     /* linear xdp pkt, pull 0 byte */
> > +     run_test(skel, XDP_PASS, pg_sz, 2048, 0, 2048, 2048);
>
> you're passing pg_sz to avoid repeated syscalls I assume? Is it worth to =
pass
> prog_fd as well?

The performance is not too much of a concern here as it is selftest. I
would not add prog_fd to avoid confusion.

>
> > +
> > +     /* multi-buf pkt, pull results in linear xdp pkt */
> > +     run_test(skel, XDP_PASS, pg_sz, 2048, 0, 1024, 2048);
> > +
> > +     /* multi-buf pkt, pull 1 byte to linear data area */
> > +     run_test(skel, XDP_PASS, pg_sz, 9000, 0, 1024, 1025);
> > +
> > +     /* multi-buf pkt, pull 0 byte to linear data area */
> > +     run_test(skel, XDP_PASS, pg_sz, 9000, 0, 1025, 1025);
> > +
> > +     /* multi-buf pkt, empty linear data area, pull requires memmove *=
/
> > +     run_test(skel, XDP_PASS, pg_sz, 9000, 0, 0, PULL_MAX);
> > +
> > +     /* multi-buf pkt, no headroom */
> > +     run_test(skel, XDP_PASS, pg_sz, 9000, max_meta_len, 1024, PULL_MA=
X);
> > +
> > +     /* multi-buf pkt, no tailroom, pull requires memmove */
> > +     run_test(skel, XDP_PASS, pg_sz, 9000, 0, max_data_len, PULL_MAX);
> > +
>
> nit: double empty line

Will add:

/* Test cases with invalid pull length */

>
> > +
> > +     /* linear xdp pkt, pull more than total data len */
> > +     run_test(skel, XDP_DROP, pg_sz, 2048, 0, 2048, 2049);
> > +
> > +     /* multi-buf pkt with no space left in linear data area */
> > +     run_test(skel, XDP_DROP, pg_sz, 9000, max_meta_len, max_data_len,
> > +              PULL_MAX | PULL_PLUS_ONE);
> > +
> > +     /* multi-buf pkt, empty linear data area */
> > +     run_test(skel, XDP_DROP, pg_sz, 9000, 0, 0, PULL_MAX | PULL_PLUS_=
ONE);
> > +
> > +     /* multi-buf pkt, no headroom */
> > +     run_test(skel, XDP_DROP, pg_sz, 9000, max_meta_len, 1024,
> > +              PULL_MAX | PULL_PLUS_ONE);
> > +
> > +     /* multi-buf pkt, no tailroom */
> > +     run_test(skel, XDP_DROP, pg_sz, 9000, 0, max_data_len,
> > +              PULL_MAX | PULL_PLUS_ONE);
> > +
> > +out:
> > +     test_xdp_pull_data__destroy(skel);
> > +}
> > +
> > +void test_xdp_pull_data(void)
> > +{
> > +     if (test__start_subtest("xdp_pull_data"))
> > +             test_xdp_pull_data_basic();
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/test_xdp_pull_data.c b/t=
ools/testing/selftests/bpf/progs/test_xdp_pull_data.c
> > new file mode 100644
> > index 000000000000..dd901bb109b6
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_xdp_pull_data.c
> > @@ -0,0 +1,48 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include  "vmlinux.h"
> > +#include <bpf/bpf_helpers.h>
> > +
> > +int xdpf_sz;
> > +int sinfo_sz;
> > +int data_len;
> > +int pull_len;
> > +
> > +#define XDP_PACKET_HEADROOM 256
> > +
> > +SEC("xdp.frags")
> > +int xdp_find_sizes(struct xdp_md *ctx)
> > +{
> > +     xdpf_sz =3D sizeof(struct xdp_frame);
> > +     sinfo_sz =3D __PAGE_SIZE - XDP_PACKET_HEADROOM -
> > +                (ctx->data_end - ctx->data);
> > +
> > +     return XDP_PASS;
> > +}

Will remove this XDP program

Thank you for your review!

[...]

> > --
> > 2.47.3
> >

