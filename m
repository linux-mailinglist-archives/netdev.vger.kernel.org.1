Return-Path: <netdev+bounces-238253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC54C565C3
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 09:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72AB9354926
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 08:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F983321AB;
	Thu, 13 Nov 2025 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kHKKqH0n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECE22550BA
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023429; cv=none; b=J+dgkykDIYiogMV5lMLtCfwuwMkh3DiR7yMmsNyyKLa5732mdwsgKjaZZP1suYBd2bLbn/4Nc0MbXw+WApwSEjBHI/yDoqnMJUknNPxjoYrK1sgxJGYeAm/3Rr6uF7UbdmuFXj1oOEMAMq4oMXFk0GEdWhvB5vyxgUyKjshRlqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023429; c=relaxed/simple;
	bh=jse6Fvf91Bj1D9bHF1Cetv+Q41yOk1kjQNQ2qIrFsdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jx0YvaUW3g6aY2fFVwcOXpOYrIGJkwyWd6sKIs6/dRUJQDz+yMI5/tD5Ur+muhnsGQ5g/sxerXzUpJD4+CImSk+PSTdLRCcCHukDTgOT7vKmUsDRtV08tithICHQtZwUflHnw/55HQpbRf93IbuaXT7uQr2a5qp4ta1lm16bohU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kHKKqH0n; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bc09b3d3afeso354596a12.0
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 00:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763023427; x=1763628227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j82bvNFvImNkIdmXcdyCuYEbPQ6AAn6vtq3RYsevuB0=;
        b=kHKKqH0nIZQDG3eGZSTEvADc0dv1b0ssYMvK/EUBTSW2DVRHed9bVoB0vHnFVeHhSf
         UXXWTBiuklCMyLYAXH8B2rvn0zuElNu+dIvJc95oclMSAYb4L3iOkWojjcKFXiB+q7VR
         GvS92wgIE9kbReQSKH+Ph9TOxLZ5EQ7ltWdtmTzQC6NL5hUMwt34/sTS+nneMRy3PMfJ
         agj22d2Q2DKSFvQGPSC55NrYTVTP6ewrdNui0YR5Il+JtTeKoBUZEwW3AmieIPe8vryw
         5NKr7QhGfbzUv4buQdj37Dw40htvafdf93b7pdLiMINKqKZcVloSoN1gv1kW0Pxi1qKE
         kOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763023427; x=1763628227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j82bvNFvImNkIdmXcdyCuYEbPQ6AAn6vtq3RYsevuB0=;
        b=EckZWNAngMN+3n/pf6q3BVavLpQnQBYNlEoEsZDl03ZBtJS3cWm+40b9p9n5ASDBo9
         uziIWu5A9stUaUu1Flnvhw55RCNCInpv/VESEwuTf5ijPPs/Rw9c7yskzZX4gycbbsTF
         sVBjAx/NHvNXMMqosOVEDaHrtvBf8UKwaXZTKMSpPCdP9txUHsJJXOnw5sSBGCxcf0u/
         0bDBXSsJIy0EGi8KPAcl/L1nvnwkQELO+yp3kDVizSScSaONfUvEX9MXBYl/lLFZvIn3
         3D/40u72hlvgAJTGS036MKsnoi3wgR2LxOdf4Cxa+ISc416J61ys2YgLZRTRMV2EKn5z
         EGBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoTHdngm0ej1Bcq9TfIw3yMpSLl4Q/XENapj/rYjPz514SJLcxEeykJqiipFlmSuRPFfy6bDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWFE97nnakYW3EWVn8gl1LSZ3evM5hNhutlEA3t/5sTLx3Lnaz
	6KJE4hox7MxsKxTyZprGh5oTnbLHri3x6PhRmm2zJNhVPLMgLus0vN7tGLK8ST3ZmhzF0aoFYDF
	k4wwdLdDOqgO4/O/0x+c1qLMUUI+wCUwGrNj2hBSp
X-Gm-Gg: ASbGncutCM9MRoT/mwjMlMcdTzafakSeUNq621fC3Q33OLj1ZncQ0WZ+nD4HN4K62kw
	bAVu40dJGbed3pHCP8rJ5VWgB9gr7IL1KmAqVFQEgBCA8mW0+9v9hApwdm9FS1dz+6g7+EBFHDM
	hhnkBiCzJlfCh27T2mFEnGyFUlP1Ub53EB53tcb14yjWb/dS2489WaBfDsqojpmFHX87f52/um2
	2VevZG8+BV14sTRkL623M42irAupcGtA7Mi6SXZGTitwKcpr4MLpePTVDZs9+eIiBIQfhq/MMoM
	4xREgsvB3nxxzHG3SJzd1iczpK/V1ZaJgR+75ao=
X-Google-Smtp-Source: AGHT+IFRjxtEMxqTf2ZiPcWD+w/6WxiFP8vWz2ry+bgq6jmCqzkoz3cIoI/9FBit5SMj949e5QZd1XphprmQPlN7Kao=
X-Received: by 2002:a17:903:2c04:b0:295:68dd:4ebf with SMTP id
 d9443c01a7336-2984ed347bemr84532525ad.16.1763023426416; Thu, 13 Nov 2025
 00:43:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113071756.40118-1-adelodunolaoluwa.ref@yahoo.com> <20251113071756.40118-1-adelodunolaoluwa@yahoo.com>
In-Reply-To: <20251113071756.40118-1-adelodunolaoluwa@yahoo.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 13 Nov 2025 00:43:34 -0800
X-Gm-Features: AWmQ_bledBDMon-7jfxD9YyY1CjbXYKMvQ22CAf96HxnEGlMpnIBxJ-QLZCGer0
Message-ID: <CAAVpQUBvLN=sRVb8cbMngwm3o=KZkVOeCYdyi2p5sYjjZQU=HQ@mail.gmail.com>
Subject: Re: [PATCH v5] selftests: af_unix: Add tests for ECONNRESET and EOF semantics
To: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 11:19=E2=80=AFPM Sunday Adelodun
<adelodunolaoluwa@yahoo.com> wrote:
>
> Add selftests to verify and document Linux=E2=80=99s intended behaviour f=
or
> UNIX domain sockets (SOCK_STREAM and SOCK_DGRAM) when a peer closes.
> The tests verify that:
>
>  1. SOCK_STREAM returns EOF when the peer closes normally.
>  2. SOCK_STREAM returns ECONNRESET if the peer closes with unread data.
>  3. SOCK_SEQPACKET returns EOF when the peer closes normally.
>  4. SOCK_SEQPACKET returns ECONNRESET if the peer closes with unread data=
.
>  5. SOCK_DGRAM does not return ECONNRESET when the peer closes.
>
> This follows up on review feedback suggesting a selftest to clarify
> Linux=E2=80=99s semantics.
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
> ---
> Changelog:
>
> changes made in v4 to v5:
> 1. Moved the send() call before the socket type check in Test 2 to ensure
>    the unread data behavior is tested for SOCK_DGRAM as well.
>
> 2. Removed the misleading commend about accept() for clarity.
>
> 3. Applied indentation fixes for style consistency
>    (alignment with open parenthesis).
>
> 4. Minor comment and formatting cleanups for clarity and adherence
>    to kernel coding style.
>
>  tools/testing/selftests/net/.gitignore        |   1 +
>  tools/testing/selftests/net/af_unix/Makefile  |   1 +
>  .../selftests/net/af_unix/unix_connreset.c    | 178 ++++++++++++++++++
>  3 files changed, 180 insertions(+)
>  create mode 100644 tools/testing/selftests/net/af_unix/unix_connreset.c
>
> diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selft=
ests/net/.gitignore
> index 439101b518ee..e89a60581a13 100644
> --- a/tools/testing/selftests/net/.gitignore
> +++ b/tools/testing/selftests/net/.gitignore
> @@ -65,3 +65,4 @@ udpgso
>  udpgso_bench_rx
>  udpgso_bench_tx
>  unix_connect
> +unix_connreset
> diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing=
/selftests/net/af_unix/Makefile
> index de805cbbdf69..5826a8372451 100644
> --- a/tools/testing/selftests/net/af_unix/Makefile
> +++ b/tools/testing/selftests/net/af_unix/Makefile
> @@ -7,6 +7,7 @@ TEST_GEN_PROGS :=3D \
>         scm_pidfd \
>         scm_rights \
>         unix_connect \
> +       unix_connreset \
>  # end of TEST_GEN_PROGS
>
>  include ../../lib.mk
> diff --git a/tools/testing/selftests/net/af_unix/unix_connreset.c b/tools=
/testing/selftests/net/af_unix/unix_connreset.c
> new file mode 100644
> index 000000000000..9cb0f48597eb
> --- /dev/null
> +++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Selftest for AF_UNIX socket close and ECONNRESET behaviour.
> + *
> + * This test verifies:
> + *  1. SOCK_STREAM returns EOF when the peer closes normally.
> + *  2. SOCK_STREAM returns ECONNRESET if peer closes with unread data.
> + *  3. SOCK_SEQPACKET returns EOF when the peer closes normally.
> + *  4. SOCK_SEQPACKET returns ECONNRESET if the peer closes with unread =
data.
> + *  5. SOCK_DGRAM does not return ECONNRESET when the peer closes.
> + *
> + * These tests document the intended Linux behaviour.
> + *
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdlib.h>
> +#include <string.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <sys/socket.h>
> +#include <sys/un.h>
> +#include "../../kselftest_harness.h"
> +
> +#define SOCK_PATH "/tmp/af_unix_connreset.sock"
> +
> +static void remove_socket_file(void)
> +{
> +       unlink(SOCK_PATH);
> +}
> +
> +FIXTURE(unix_sock)
> +{
> +       int server;
> +       int client;
> +       int child;
> +};
> +
> +FIXTURE_VARIANT(unix_sock)
> +{
> +       int socket_type;
> +       const char *name;
> +};
> +
> +FIXTURE_VARIANT_ADD(unix_sock, stream) {
> +       .socket_type =3D SOCK_STREAM,
> +       .name =3D "SOCK_STREAM",
> +};
> +
> +FIXTURE_VARIANT_ADD(unix_sock, dgram) {
> +       .socket_type =3D SOCK_DGRAM,
> +       .name =3D "SOCK_DGRAM",
> +};
> +
> +FIXTURE_VARIANT_ADD(unix_sock, seqpacket) {
> +       .socket_type =3D SOCK_SEQPACKET,
> +       .name =3D "SOCK_SEQPACKET",
> +};
> +
> +FIXTURE_SETUP(unix_sock)
> +{
> +       struct sockaddr_un addr =3D {};
> +       int err;
> +
> +       addr.sun_family =3D AF_UNIX;
> +       strcpy(addr.sun_path, SOCK_PATH);
> +       remove_socket_file();
> +
> +       self->server =3D socket(AF_UNIX, variant->socket_type, 0);
> +       ASSERT_LT(-1, self->server);
> +
> +       err =3D bind(self->server, (struct sockaddr *)&addr, sizeof(addr)=
);
> +       ASSERT_EQ(0, err);
> +
> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> +           variant->socket_type =3D=3D SOCK_SEQPACKET) {
> +               err =3D listen(self->server, 1);
> +               ASSERT_EQ(0, err);
> +       }
> +
> +       self->client =3D socket(AF_UNIX, variant->socket_type | SOCK_NONB=
LOCK, 0);
> +       ASSERT_LT(-1, self->client);
> +
> +       err =3D connect(self->client, (struct sockaddr *)&addr, sizeof(ad=
dr));
> +       ASSERT_EQ(0, err);
> +}
> +
> +FIXTURE_TEARDOWN(unix_sock)
> +{
> +       if ((variant->socket_type =3D=3D SOCK_STREAM ||
> +            variant->socket_type =3D=3D SOCK_SEQPACKET) & self->child > =
0)

Sorry for missing this one, but NIPA caught this.
see: https://netdev.bots.linux.dev/static/nipa/1022816/14311938/build_tools=
/stderr

+unix_connreset.c: In function =E2=80=98unix_sock_teardown=E2=80=99:
+unix_connreset.c:92:68: warning: suggest parentheses around
comparison in operand of =E2=80=98&=E2=80=99 [-Wparentheses]
+   92 |              variant->socket_type =3D=3D SOCK_SEQPACKET) & self->c=
hild > 0)
+      |                                                        ~~~~~~~~~~~=
~^~~

I think you can simply remove the "& self->child >0" part
because you don't check that for self->server below anyway.

Thanks


> +               close(self->child);
> +
> +       close(self->client);
> +       close(self->server);
> +       remove_socket_file();
> +}
> +
> +/* Test 1: peer closes normally */
> +TEST_F(unix_sock, eof)
> +{
> +       char buf[16] =3D {};
> +       ssize_t n;
> +
> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> +           variant->socket_type =3D=3D SOCK_SEQPACKET) {
> +               self->child =3D accept(self->server, NULL, NULL);
> +               ASSERT_LT(-1, self->child);
> +
> +               close(self->child);
> +       } else {
> +               close(self->server);
> +       }
> +
> +       n =3D recv(self->client, buf, sizeof(buf), 0);
> +
> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> +           variant->socket_type =3D=3D SOCK_SEQPACKET) {
> +               ASSERT_EQ(0, n);
> +       } else {
> +               ASSERT_EQ(-1, n);
> +               ASSERT_EQ(EAGAIN, errno);
> +       }
> +}
> +
> +/* Test 2: peer closes with unread data */
> +TEST_F(unix_sock, reset_unread_behavior)
> +{
> +       char buf[16] =3D {};
> +       ssize_t n;
> +
> +       /* Send data that will remain unread */
> +       send(self->client, "hello", 5, 0);
> +
> +       if (variant->socket_type =3D=3D SOCK_DGRAM) {
> +               /* No real connection, just close the server */
> +               close(self->server);
> +       } else {
> +               /* Accept client connection */
> +               self->child =3D accept(self->server, NULL, NULL);
> +               ASSERT_LT(-1, self->child);
> +
> +               /* Peer closes before client reads */
> +               close(self->child);
> +       }
> +
> +       n =3D recv(self->client, buf, sizeof(buf), 0);
> +       ASSERT_EQ(-1, n);
> +
> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> +           variant->socket_type =3D=3D SOCK_SEQPACKET) {
> +               ASSERT_EQ(ECONNRESET, errno);
> +       } else {
> +               ASSERT_EQ(EAGAIN, errno);
> +       }
> +}
> +
> +/* Test 3: closing unaccepted (embryo) server socket should reset client=
. */
> +TEST_F(unix_sock, reset_closed_embryo)
> +{
> +       char buf[16] =3D {};
> +       ssize_t n;
> +
> +       if (variant->socket_type =3D=3D SOCK_DGRAM)
> +               SKIP(return, "This test only applies to SOCK_STREAM and S=
OCK_SEQPACKET");
> +
> +       /* Close server without accept()ing */
> +       close(self->server);
> +
> +       n =3D recv(self->client, buf, sizeof(buf), 0);
> +
> +       ASSERT_EQ(-1, n);
> +       ASSERT_EQ(ECONNRESET, errno);
> +}
> +
> +TEST_HARNESS_MAIN
> +
> --
> 2.43.0
>

