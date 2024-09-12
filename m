Return-Path: <netdev+bounces-127951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDF59772C9
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 22:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0FE31C20F20
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 20:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F56619048C;
	Thu, 12 Sep 2024 20:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A1q3Myjx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013E51B9853
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 20:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173414; cv=none; b=XlrqadguDQBluv0KHIwMhJjPfAk3Xah0tUE6avQC+7AnOxwqYUdMv5CE1s6Sx6oTRPV8+8ylC/pxyXIpLO6mawOdbSCNzYy58XYOWX1SSe+PV+t951XgRXMly0B2/f7FNS9sYOklb/BMDOEdqwvawcSFjUjHShhFQeNgBWmhyf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173414; c=relaxed/simple;
	bh=vYSmvhVzTb/ojA8zFaO4mqc/pMpDbvp6SukfIutnTJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgzCZQZO+SUpWMlFfHtjMsrrFaC20LRrndFj54FH1nlE7n1uq+ycINdJNqw1tu+2VHHUtAxAPGxjfe0aAcdR88uh0xlXZmt0FqAW2U5vkkYl6fWP8QaX2vBOw6/p8Z3ZrPW08I+UwHqHSCieDev3PvY083457bFjSAbjM8/91tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A1q3Myjx; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4581cec6079so77421cf.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 13:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726173412; x=1726778212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw5LJsO2czgWcpyERZkhXuWq3KG/XH01vCRDOf6gWew=;
        b=A1q3Myjx49U8kOBYfhgxgFSGqAd1QLGVkFKzIeXkLyhgI+ySSfaogFFB+xn9JNXcjN
         m8egLs/c1X5iVxOt7gSuIhgBOefjj3TXvtTguMWx5FocG9YAESLSloMG0R1y/I3BXXYq
         muxznn8pQgkKzsAXf6Ela9b/HIZ7JfwBJhjeVq5DOqww2TJ43+fH+oKkjQZOCWDz7ppy
         NtRrvNvUQls1DfwuW9uu9mppWXXuSNjDXZvmgBYRa0hf06Lv4BKWOKGUJoMxfau7HAQJ
         IckdJsUC+exUC7zGXjsFf3wqkR3tRPqdWuwPlfc09VJ1dd2OHIpVa5jG8QCQlcL4/dWi
         FsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726173412; x=1726778212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tw5LJsO2czgWcpyERZkhXuWq3KG/XH01vCRDOf6gWew=;
        b=JI/5cVAXRPx8WV1Wkt6gNCineGP6vuOcN6KIgiJt/0V8Obr3oRdFiuImOE3uf/YW2K
         pJaw03SONKElYbXFTxO/liygeTkhqHw1/kKLuK8oQEM8Nsh3dO/lBm6PuudvNseNw7tw
         nVY+SbXZd9vwM4uyhWdHX1GXAcFEOs545t4NmQzkNwNV7zXtf4lb4yU31orsg4Kv9wQ6
         OrJzo9YtaokTgxTaxlQPb3lhQo8nfxUMJkEiuH2EN1vyzxrdkqZHm9jC5nFSqmdhKQQg
         Odyqasr2lmIpbIs4Z6jLeygM64eCUNuIG6JuqlprAlX5l38JAwJ5AINfeCfSXnsDKJ4S
         zSpg==
X-Gm-Message-State: AOJu0Yw1DymLadyq8lYQFQCUJXSb2lYoZLb3eM90vQcoEQyMc+KjLyTX
	Zkr5aQ9Qajf0JL55DEB5hXVrMFYnbTOJ5ua0q5vxP1X4D7srL0d5/K2LHqOLTpl3JY86G06mXhJ
	FCZsm5oR3JWX/KI5Bb4cksoDltYVYkiNnaT+w
X-Google-Smtp-Source: AGHT+IFi+TRD8cbKw52SKSp/m7Cn0nCkwTJBGCJgdwAA9oozrEb9bLB0qNrqT/UvMEECoGAfsM+nKDguBXu0yKxj3Cw=
X-Received: by 2002:a05:622a:1312:b0:456:7740:c874 with SMTP id
 d75a77b69052e-458643fe57dmr4042151cf.1.1726173411504; Thu, 12 Sep 2024
 13:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912171251.937743-1-sdf@fomichev.me> <20240912171251.937743-2-sdf@fomichev.me>
In-Reply-To: <20240912171251.937743-2-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Sep 2024 13:36:39 -0700
Message-ID: <CAHS8izNzP_-CS2FyuUo6xRzumMAFRbkE00DOzmHpjBSkMUP3PA@mail.gmail.com>
Subject: Re: [PATCH net-next 01/13] selftests: ncdevmem: Add a flag for the selftest
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 10:12=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> And rename it to 'probing'. This is gonna be used in the selftests
> to probe devmem functionality.
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selft=
ests/net/ncdevmem.c
> index 64d6805381c5..352dba211fb0 100644
> --- a/tools/testing/selftests/net/ncdevmem.c
> +++ b/tools/testing/selftests/net/ncdevmem.c
> @@ -523,8 +523,9 @@ void run_devmem_tests(void)
>  int main(int argc, char *argv[])
>  {
>         int is_server =3D 0, opt;
> +       int probe =3D 0;
>
> -       while ((opt =3D getopt(argc, argv, "ls:c:p:v:q:t:f:")) !=3D -1) {
> +       while ((opt =3D getopt(argc, argv, "ls:c:p:v:q:t:f:P")) !=3D -1) =
{
>                 switch (opt) {
>                 case 'l':
>                         is_server =3D 1;
> @@ -550,6 +551,9 @@ int main(int argc, char *argv[])
>                 case 'f':
>                         ifname =3D optarg;
>                         break;
> +               case 'P':
> +                       probe =3D 1;
> +                       break;
>                 case '?':
>                         printf("unknown option: %c\n", optopt);
>                         break;
> @@ -561,7 +565,10 @@ int main(int argc, char *argv[])
>         for (; optind < argc; optind++)
>                 printf("extra arguments: %s\n", argv[optind]);
>
> -       run_devmem_tests();
> +       if (probe) {
> +               run_devmem_tests();
> +               return 0;
> +       }
>

Before this change:
./ncdevmem (runs run_devmem_tests() and exits)
./ncdevmem -l: runs devmem tests and listens

And I plan to add, for the tx path:

./ncdevmem -c: runs devmem tests and does a devmem client.

After this change, running ncdevmem with no flags just exits without
doing anything; a bit weird IMO, but I'm not opposed if you see an
upside.

Is your intention with this change to not run the devmem tests on
listen? Maybe something like:

if (is_server)
  return do_server();
else if (is_client) /* to be added */
  return do_client();
else
  run_devmem_tests();

return 0;

?

But, I'm not totally opposed if you see an upside. Maybe use -p
instead of -P for consistency.



--
Thanks,
Mina

