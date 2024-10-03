Return-Path: <netdev+bounces-131493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5D598EA51
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 09:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73398287340
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 07:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5864884A50;
	Thu,  3 Oct 2024 07:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ru6IWEF7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B901184A4D
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727940403; cv=none; b=PCSgANDW05QHZte7kFMYz+2BOpm1XYYhfx13e84u/XxhucMcgEbx+ztV0hnSwhQnjKeytY4iu5PA05BEGsv7yLjx9rJoSpSKxfiCsxvGuPMnK8TBpmOKeBPXfcI97759CmotAP0MuEOx8wDUbJ04+zB6RRn2tP6y2as7V3e5qkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727940403; c=relaxed/simple;
	bh=2paca/pF5nvXxEcAs9/qaY3rCSzbHr5aLRs21+43Dmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddpog/HwUnuvzI0Q1gjaBTIf8i0eE0CXvAtMPTcneJv+c2m+lmDsznr5Cd6i/mgEPazZ9wpQKzXSOKUZ2K8VKq8quuDj+coveMbRUljTZZ3Nu9SlvI1qKeMOB7dTJZIMHC1ywQgK9Cu+2iZ2tfLTtCcqlptJFQQRgSZlEPiLYzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ru6IWEF7; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-45b4e638a9aso147861cf.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 00:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727940400; x=1728545200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uf+6YPXyMG3r5IvY5YD1t6/W1qIi8GQrYBRwHAmDs4=;
        b=Ru6IWEF7L6nYTf+aA8MaGQyeeaESGmJb97geblXytppBu8TLLLjgUXgW1uQd/oUB68
         PDliIqnMymZlzqEw5z3vw4qNw/7kgCSYBP5XAzuW1KHB4cTHehGiXmDf8tqaFjuJg8bI
         aEWpKSQWcky+CmkPm2J5nrAKLJC0sfglNBBXaHSrH8IguFfDHrWN/e0IUDknGtQIfBcu
         6xA5E7G23mvxd6wm+ubAc6YvDulCZbLmjMPWw70hZkXY+QryB0nFjyhuHRRhJ7sAF/Zy
         E2rYIBsmELNBliRSZSvGm0ItO/KbpfRXr8EEuQWcEZnmOPFfp2eUeqbA3YU3QllWK46o
         XSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727940400; x=1728545200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uf+6YPXyMG3r5IvY5YD1t6/W1qIi8GQrYBRwHAmDs4=;
        b=Ux+e4SSNwygauJCAA1sJbFK25JGnjf3+SGCii0CixAXXFC6nUf8ztd/Lm1pmfPzbJc
         llQMulT+NOE8Lm6i9pxbOZ2WJ8bqabBz/D0kmoXDd7MN39TAgi0o3CUMwTgN3WKldzwN
         Gwz5/k6ujtnsqHHWhFE93hjR+nvWDkk7lmWkTDWQjlGYd5mXVt1J7t5uEJFf9GrT+t2H
         EW2nWXYn6owGDikYPdsgTeYRFI2t6f6aaRo8kzwyT9HvFmrYdwLYQUazmhLbUnMP+xIM
         nTzf0hAoNvluj6vN+PrafxaUA2+PwH/QGcMq5w3s1kAzcEfmumgLIxCp27WinDXSV3rZ
         X/nw==
X-Gm-Message-State: AOJu0YzfxsjWjlIijDu5sU4bPghLNfO0S5V0rNE1DABvIW9p9sw5vLp5
	svIJ2dgYRCRwUSSVoMtjCL3Jj0bAYtgXtDurR6Po+1NOS+xWMUjngnu9nPtRUAPXq/tfj6LJAC9
	SUdYOwLVxBSxXOIs9kMbMKnrXIS9PpWK60uw1
X-Google-Smtp-Source: AGHT+IFFe6kmCiD55qwG4qWamw7rROeoMgTRcuU+rIs609OKgf0R8diV/x0Ev2WJ49vqNooXc2kHM7DkgfeMMb5u810=
X-Received: by 2002:a05:622a:500d:b0:45c:9c6e:6dba with SMTP id
 d75a77b69052e-45d8fa65770mr1599391cf.27.1727940400382; Thu, 03 Oct 2024
 00:26:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930171753.2572922-1-sdf@fomichev.me> <20240930171753.2572922-11-sdf@fomichev.me>
In-Reply-To: <20240930171753.2572922-11-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 3 Oct 2024 00:26:28 -0700
Message-ID: <CAHS8izNwYgweZvD+hQgx_k5wjMDG1W5_rscXq_C8oVMdg546Tw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 10/12] selftests: ncdevmem: Run selftest when
 none of the -s or -c has been provided
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:18=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.m=
e> wrote:
>
> This will be used as a 'probe' mode in the selftest to check whether
> the device supports the devmem or not.

It's not really 'probing'. Running ncdevmem with -s or -c does the
data path tests. Running ncdevmem without does all the control path
tests in run_devmem_tests(). It's not just probing driver for support,
it's mean to catch bugs. Maybe rename to 'control path tests' or
'config tests' instead of probing.


> Use hard-coded queue layout
> (two last queues) and prevent user from passing custom -q and/or -t.
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 27 +++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selft=
ests/net/ncdevmem.c
> index 900a661a61af..9b0a81b12eac 100644
> --- a/tools/testing/selftests/net/ncdevmem.c
> +++ b/tools/testing/selftests/net/ncdevmem.c
> @@ -688,17 +688,26 @@ int main(int argc, char *argv[])
>                 }
>         }
>
> -       if (!server_ip)
> -               error(1, 0, "Missing -s argument\n");
> -
> -       if (!port)
> -               error(1, 0, "Missing -p argument\n");
> -
>         if (!ifname)
>                 error(1, 0, "Missing -f argument\n");
>
>         ifindex =3D if_nametoindex(ifname);
>
> +       if (!server_ip && !client_ip) {
> +               if (start_queue !=3D -1)
> +                       error(1, 0, "don't support custom start queue for=
 probing\n");
> +               if (num_queues !=3D 1)
> +                       error(1, 0, "don't support custom number of queue=
s for probing\n");
> +

Remove the start_queue + num_queues check here please. I would like to
be able to run the control path tests binding dmabuf to all the queues
or 1 of the queues or some of the queues.

--=20
Thanks,
Mina

