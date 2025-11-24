Return-Path: <netdev+bounces-241280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B0BC8238D
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 20:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B2A3A8C86
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B2C22FDE6;
	Mon, 24 Nov 2025 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uHlXhYsw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C9886323
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764011084; cv=none; b=qcCXKDx27JJL39tCx1NrZ3+DDYVJzcovDNP1ZjPZfNU3OoQgobbjXKNlUjSKZ/zSzucTOxBfkHK2iqaK1K96ILx4V2iaPxi+WRKSrBm4CwgI38DwgUeGGaSpCWDSRHmKpWC1dNMuUl1iLuLLrg7j9eamenVlkKrSLuTazRlrbp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764011084; c=relaxed/simple;
	bh=CSQKuJk84tG5ZuWblxkRtwsJUOaSkI60JAWLrWLe3bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vm+/Kpa5+g3qD3VBvEETVcvbVNr+KP6l2+5ixP4zpIGVsVKrdc0GkhroU6JTOzbQSJstQ+WmG8w6gHyqBbneLw+EaUK8J17R7DDWWtoflk0Ncef89TI1rKIFPcJFGdeNGsCgshgu9Ln4vRFqkUb/QVz3Z8BjapFVQN0S89WiSNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uHlXhYsw; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so3199336b3a.2
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 11:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764011082; x=1764615882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WR+6r0zKf/drbXIpCKmIt1A8MN9jIT0Qrpcwq+dE+OU=;
        b=uHlXhYswLIxZZc9O+ELh8/kkyszDHsygulhXg5vmgqWPufbMyBhd/X+PacxI8OLiRc
         zC5RrB5LqUVeAWcJd2juQhy7vrXNeknZR56C2L2EsS9LRuu6YSQS/j7YXPLCozJng1VI
         neg7EX5tF7UbjLqc19CqP7jczM2F5REvpSf0CzVy+hQCUbmuDA9j6IZ6XrRG4l/KtdK+
         Xvgc7UyTZeVjWum1MtXcaraqzT/GNXoKefJDg5/5cxIbBlRkVztmvDieyFWcAC2WnlFd
         oMi8FTF9M/Q3nmmi4vAlym6lnLHJhmwEVWy0vt81T/XtLDX+9KJjrb+3PsApg6bcW/Cr
         WCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764011082; x=1764615882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WR+6r0zKf/drbXIpCKmIt1A8MN9jIT0Qrpcwq+dE+OU=;
        b=TqqIGNqKbYzD/fTiJbaVMySib7zpLeSinuYpCEQXXX5KLQhr2bS5+JFoHKdXQQe0x8
         ABiAi8WNNjjvtORLv35HLofPWUOROZFKEc6pR1FxKjNnQMvD3LtB9eznYcMGezqQ8TJE
         g4Tifj/pj0bhu6tW6OQFP3vTN1CSYzymYjLyPFwPMpWi5Qap3g2/lrM1wGZpxliupES2
         Iqt9qU/GCG8urVmdzQGRcM4xh9P+Wjljd+Q8pT4eXC6Hz3Urv1rk/MsPsbTuAsQz08b/
         RyzBdbFEUo/J3uYynQ6VWvBY6orcIFfli8ngX9Cdc+wr9OjiZyrzkF3sfq7c+F7XS9sh
         3n3A==
X-Forwarded-Encrypted: i=1; AJvYcCUVvAzgic6ugv2wyEL6bV0SVUkbIInX4xbSRG3bSN4hRWhXixVhH7hEE8pEr8t3Z6kNCQQ/Lxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpE4Brs7y1nKZE9M9MSo/G33hOEZdGviUXP/HkCkUgw5bhzXk5
	V3Lf1GhoVjSltlMgVEp5HZ+fdyzt81c7EefnHrjUv8MUQ5zwkKkMe2bOjqWhO2Dt6qKwfIYpiue
	h7FtTU0byMv41XvltJ+mrlQbj62NcmaNi25r+QlEi
X-Gm-Gg: ASbGncv13vX9QfrAOlZXfaFLVdx8Hyi8td+y2zn6toV74tU6G98wPBy4qtXW8DpuQ7r
	zLTgWUh9tdNothLgKfX34HvOUs/XN+c3JfKMAVHOwHGa6WDgmx4rIOCgR5FbVnwE8mEy2i0fZDM
	fnwa4gxUpSPKJwTUiCjgFDZVtftPYXyWWPDFFPuKhPkV7Yhb2ieUBXII7CWmudibmyl3r6cXV9Y
	tsi4Xq/kvexpyMGdZcmEQCbstadeDi+euZxssS+Eip9qrmWlExGxwhvRLPQ47WK9LghWggp2o6W
	pLnMESoVbOBB1Q59IMooHy4IaA==
X-Google-Smtp-Source: AGHT+IHh5m3hlVaahpzcudnWQ3fCeNJ3tekhi53iK1WM2SS3hAZv7gdQapj8YFpy6+Ki/IsS63hBQp0tvIEyLcMAXZ4=
X-Received: by 2002:a05:7022:ec85:b0:11a:61df:252a with SMTP id
 a92af1059eb24-11cb3ecc587mr92399c88.6.1764011081678; Mon, 24 Nov 2025
 11:04:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251123021601.158709-1-kuba@kernel.org>
In-Reply-To: <20251123021601.158709-1-kuba@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 24 Nov 2025 11:04:30 -0800
X-Gm-Features: AWmQ_blSdvmtWJwNQ8jGnk9Px5x3RGff27Wq9xqCsiFfSeVUkAeaeoS6umNClMQ
Message-ID: <CAAVpQUDBGYf_2vt3yjYO_vPFyV_bH8rNoNJAAxiSb2OhpXxKkA@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: af_unix: don't use SKIP for expected failures
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	adelodunolaoluwa@yahoo.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 6:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> netdev CI reserves SKIP in selftests for cases which can't be executed
> due to setup issues, like missing or old commands. Tests which are
> expected to fail must use XFAIL.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Good to know that, thanks !

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


> ---
> CC: kuniyu@google.com
> CC: adelodunolaoluwa@yahoo.com
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/af_unix/unix_connreset.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/af_unix/unix_connreset.c b/tools=
/testing/selftests/net/af_unix/unix_connreset.c
> index bffef2b54bfd..6eb936207b31 100644
> --- a/tools/testing/selftests/net/af_unix/unix_connreset.c
> +++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
> @@ -161,8 +161,12 @@ TEST_F(unix_sock, reset_closed_embryo)
>         char buf[16] =3D {};
>         ssize_t n;
>
> -       if (variant->socket_type =3D=3D SOCK_DGRAM)
> -               SKIP(return, "This test only applies to SOCK_STREAM and S=
OCK_SEQPACKET");
> +       if (variant->socket_type =3D=3D SOCK_DGRAM) {
> +               snprintf(_metadata->results->reason,
> +                        sizeof(_metadata->results->reason),
> +                        "Test only applies to SOCK_STREAM and SOCK_SEQPA=
CKET");
> +               exit(KSFT_XFAIL);
> +       }
>
>         /* Close server without accept()ing */
>         close(self->server);
> --
> 2.51.1
>

