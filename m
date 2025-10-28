Return-Path: <netdev+bounces-233626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F056C167C2
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 19:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F013BFD78
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 18:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508F034403C;
	Tue, 28 Oct 2025 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YTz29piu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6996429BD9B
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676109; cv=none; b=T/QKb5Zpe9C9CjxJUk/E6+dkJ6S4VqSsiyd8aIYPYZDtFZeH6pVd1Wx1FgUQ0yslYUmy6VozoYNWqpFFfX4VjFB1YtfTM5dcNdtrsjyr/nSdLmi9qxW10ThJiR0LkSpgaEcHH3dQW2IbA8gD/B3wIBl8uhcmB/KtrqYHi3kG2Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676109; c=relaxed/simple;
	bh=2a2XJVs9ZstRVlMwHGaX/LzLjoMWBC1o41QfM3zzQls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjaXI0+mmdHD+xKkoNFuuNObqCU8GThnLu1Irwc99+rcdGvjyeyNrgRHhH/FFi8hnMgP2u5Pvr1mfZUW7ld0TvaDOYKX8pcPLSk4wHKL4JeimBaO1pZzdNqORFQp+bAdbzeGAxYubDgKCtL8DSSBByD6Lup7IBU6Q5iLD6hpUqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YTz29piu; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso4782325a12.2
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 11:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761676106; x=1762280906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwwqbizLme2jEhCIP8tyn9yg6ZUbIw3HVu7qFcIaTlE=;
        b=YTz29piuOCg+8uK1h4ozQLgivuKvzIO25hPhFzPkYaX5xPUEUUMT0NYzUsDmmGUxHZ
         ZSi7gE9C7lM0TlthlA6J0SP5nZFf9jGfnlBChuWp5j1RVqZhEU5ncZP3K4EAAM2S63ed
         xqVeFB4DCZohSuFyemHTIXxF3BEz/PwiAISzH5EsBYtfWx6kSWN5kj8alm4UMmSSq3HF
         gPm7wv47cOqU2Cdra0q8yJb3fDLoaFqOvQFvGztG3vmUols6ihFm8KMb0PdCPWcOtquw
         4WVzTcZUQWRGS/hGpcEsZP2iaBXr0sJOD5excu3lSq82RPPnYTGS/neZHMf7rphoFUcd
         UIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761676106; x=1762280906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwwqbizLme2jEhCIP8tyn9yg6ZUbIw3HVu7qFcIaTlE=;
        b=BsgOUTSzkt1kb9nSRUF0rZGZfSpNk9JkIFLP4SVOy56iLF5sMXwCrGfMK6GsX8V7W4
         D2cfnWPw5YXOQbPkh3jKT1qXlBhbKTPtjocOSC2RpIQOcAilqKvUNjw+ChH5l2NQBz2j
         Tt5+cE1fscrp4XeG1ynHfwFVcwymENjpZ30H+Ch2wVqEyT3yN9SY0E5oEAPAgmCMGVVq
         Ji4pXF+095X7vCZMdZUwHom8TXkMO7vO57xZivPYyilqJG15NuMGV587jhA9btiExDba
         cNRaT2DUOXmjrdtCR2h+vXwVmRgT8wi+DAIY/oCC2/S3LEuR+Kg0gmnIySyG3vguVPSL
         /hGA==
X-Forwarded-Encrypted: i=1; AJvYcCW/wNyxvdUN1X0VssrIl9+rztJVxgl2pd4+IYKvODbqRfgrjGFiKdQE4qfQNu/TMu8caAgXcoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSIt31ugx2DAvT/uDzSiP5BWTHsqhF/7MRVS7Ct8GYs0LpKeLR
	MdNBbASyXOm5do4/Hd7qv1vA0z9JeBpZ/gFE+X4a/ae2q7FHd6jaPwwLTeomeeNxu/fYrl6VjWn
	uYmzGtv5WddPfFONn6v/M0BaaRTFsWgWGSzIRgWjz
X-Gm-Gg: ASbGnctTaUpfUNB9vU615HGfmHB0xJotHdke4eulCB9y8Ls6dmZKEiPm2X2zMVP3s0K
	HgqQggXw2mjil7+NgsribB+EJXJ/5vOU7s/Cl5ca9hWIh/vCnlcUvIfgbdtD+xvfblDHFTvqhVi
	3EGwz7KveArP2zmqIvxN1VhoSe0TsyvpbS5AjurdMEfp80cp3n438RIE1g8exP51yB/12RNkGYw
	hFhPEHhd/kD65mVgyO3WNQKH+9RHAWSyKjIt/r7MlhVXO0BM0626S47R1YNN8BuVtQVeUNtvZUW
	UeLS9KWuHLB37Zg=
X-Google-Smtp-Source: AGHT+IHGQgiHurQaRm5BB7XlGFbutHXsTrKesjHVFoO64zS/IwuXtf9Zc3l3Dd5HGQS+OWR2w/kG1Uyuv84suWGXdkw=
X-Received: by 2002:a17:902:e802:b0:279:fa:30fe with SMTP id
 d9443c01a7336-294dee25c62mr1768945ad.26.1761676105954; Tue, 28 Oct 2025
 11:28:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025190256.11352-1-adelodunolaoluwa.ref@yahoo.com> <20251025190256.11352-1-adelodunolaoluwa@yahoo.com>
In-Reply-To: <20251025190256.11352-1-adelodunolaoluwa@yahoo.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 28 Oct 2025 11:28:14 -0700
X-Gm-Features: AWmQ_bnalw5IhlnCx13TaCPkqkExXAVy8q757FeR1BQMDD21F7CRcXs2Z3K0uq0
Message-ID: <CAAVpQUAbDfaiAZ_NCppGE5vsafWoU7V1xvnqtQQM44cwv6jHsA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: af_unix: Add tests for ECONNRESET and EOF semantics
To: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Cc: "=David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	David Hunter <david.hunter.linux@gmail.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 12:03=E2=80=AFPM Sunday Adelodun
<adelodunolaoluwa@yahoo.com> wrote:
>
> Add selftests to verify and document Linux=E2=80=99s intended behaviour f=
or
> UNIX domain sockets (SOCK_STREAM and SOCK_DGRAM) when a peer closes.
> The tests cover:
>
>   1. EOF returned when a SOCK_STREAM peer closes normally.
>   2. ECONNRESET returned when a SOCK_STREAM peer closes with unread data.
>   3. SOCK_DGRAM sockets not returning ECONNRESET on peer close.
>
> This follows up on review feedback suggesting a selftest to clarify
> Linux=E2=80=99s semantics.
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
> ---
> Changelog:
>
> Changes made from v1:
>
> - Patch prefix updated to selftest: af_unix:.
>
> - All mentions of =E2=80=9CUNIX=E2=80=9D changed to AF_UNIX.
>
> - Removed BSD references from comments.
>
> - Shared setup refactored using FIXTURE_VARIANT().
>
> - Cleanup moved to FIXTURE_TEARDOWN() to always run.
>
> - Tests consolidated to reduce duplication: EOF, ECONNRESET, SOCK_DGRAM p=
eer close.
>
> - Corrected ASSERT usage and initialization style.
>
> - Makefile updated for new directory af_unix.
>
>  tools/testing/selftests/net/af_unix/Makefile  |   1 +
>  .../selftests/net/af_unix/unix_connreset.c    | 161 ++++++++++++++++++
>  2 files changed, 162 insertions(+)
>  create mode 100644 tools/testing/selftests/net/af_unix/unix_connreset.c
>
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
> index 000000000000..c65ec997d77d
> --- /dev/null
> +++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Selftest for AF_UNIX socket close and ECONNRESET behaviour.
> + *
> + * This test verifies that:
> + *  1. SOCK_STREAM sockets return EOF when peer closes normally.
> + *  2. SOCK_STREAM sockets return ECONNRESET if peer closes with unread =
data.
> + *  3. SOCK_DGRAM sockets do not return ECONNRESET when peer closes.
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
> +/* Define variants: stream and datagram */
> +FIXTURE_VARIANT_ADD(unix_sock, stream) {
> +       .socket_type =3D SOCK_STREAM,
> +       .name =3D "SOCK_STREAM",
> +};
> +
> +FIXTURE_VARIANT_ADD(unix_sock, dgram) {
> +       .socket_type =3D SOCK_DGRAM,
> +       .name =3D "SOCK_DGRAM",
> +};

Let's add coverage for SOCK_SEQPACKET,
which needs listen() / connect() but other semantics
are similar to SOCK_DGRAM.


> +
> +FIXTURE_SETUP(unix_sock)
> +{
> +       struct sockaddr_un addr =3D {};
> +       int err;
> +
> +       addr.sun_family =3D AF_UNIX;
> +       strcpy(addr.sun_path, SOCK_PATH);
> +
> +       self->server =3D socket(AF_UNIX, variant->socket_type, 0);
> +       ASSERT_LT(-1, self->server);
> +
> +       err =3D bind(self->server, (struct sockaddr *)&addr, sizeof(addr)=
);
> +       ASSERT_EQ(0, err);
> +
> +       if (variant->socket_type =3D=3D SOCK_STREAM) {
> +               err =3D listen(self->server, 1);
> +               ASSERT_EQ(0, err);
> +
> +               self->client =3D socket(AF_UNIX, SOCK_STREAM, 0);
> +               ASSERT_LT(-1, self->client);
> +
> +               err =3D connect(self->client, (struct sockaddr *)&addr, s=
izeof(addr));
> +               ASSERT_EQ(0, err);
> +
> +               self->child =3D accept(self->server, NULL, NULL);
> +               ASSERT_LT(-1, self->child);
> +       } else {
> +               /* Datagram: bind and connect only */
> +               self->client =3D socket(AF_UNIX, SOCK_DGRAM | SOCK_NONBLO=
CK, 0);
> +               ASSERT_LT(-1, self->client);
> +
> +               err =3D connect(self->client, (struct sockaddr *)&addr, s=
izeof(addr));
> +               ASSERT_EQ(0, err);
> +       }
> +}
> +
> +FIXTURE_TEARDOWN(unix_sock)
> +{
> +       if (variant->socket_type =3D=3D SOCK_STREAM)
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
> +       if (variant->socket_type !=3D SOCK_STREAM)
> +               SKIP(return, "This test only applies to SOCK_STREAM");

Instead of skipping, let's define final ASSERT() results
for each type.

Same for other 2 tests.


> +
> +       /* Peer closes normally */
> +       close(self->child);
> +
> +       n =3D recv(self->client, buf, sizeof(buf), 0);
> +       TH_LOG("%s: recv=3D%zd errno=3D%d (%s)", variant->name, n, errno,=
 strerror(errno));
> +       if (n =3D=3D -1)
> +               ASSERT_EQ(ECONNRESET, errno);

... otherwise, we don't see an error here

> +
> +       if (n !=3D -1)
> +               ASSERT_EQ(0, n);

and this can be checked unconditionally.


> +}
> +
> +/* Test 2: peer closes with unread data */
> +TEST_F(unix_sock, reset_unread)
> +{
> +       char buf[16] =3D {};
> +       ssize_t n;
> +
> +       if (variant->socket_type !=3D SOCK_STREAM)
> +               SKIP(return, "This test only applies to SOCK_STREAM");
> +
> +       /* Send data that will remain unread by client */
> +       send(self->client, "hello", 5, 0);
> +       close(self->child);
> +
> +       n =3D recv(self->client, buf, sizeof(buf), 0);
> +       TH_LOG("%s: recv=3D%zd errno=3D%d (%s)", variant->name, n, errno,=
 strerror(errno));
> +       ASSERT_EQ(-1, n);
> +       ASSERT_EQ(ECONNRESET, errno);
> +}
> +
> +/* Test 3: SOCK_DGRAM peer close */
> +TEST_F(unix_sock, dgram_reset)
> +{
> +       char buf[16] =3D {};
> +       ssize_t n;
> +
> +       if (variant->socket_type !=3D SOCK_DGRAM)
> +               SKIP(return, "This test only applies to SOCK_DGRAM");
> +
> +       send(self->client, "hello", 5, 0);
> +       close(self->server);
> +
> +       n =3D recv(self->client, buf, sizeof(buf), 0);
> +       TH_LOG("%s: recv=3D%zd errno=3D%d (%s)", variant->name, n, errno,=
 strerror(errno));
> +       /* Expect EAGAIN because there is no datagram and peer is closed.=
 */
> +       ASSERT_EQ(-1, n);
> +       ASSERT_EQ(EAGAIN, errno);
> +}
> +
> +TEST_HARNESS_MAIN
> +
> --
> 2.43.0
>

