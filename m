Return-Path: <netdev+bounces-60807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCD6821909
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 10:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A521C212C3
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 09:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BA46AB7;
	Tue,  2 Jan 2024 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BjLTsR99"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E836AD9
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso96599a12.0
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 01:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704188787; x=1704793587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OT4NBXZq4lOggwhVs0E7dfGjIT8JkDgRgI6TtvFVyKU=;
        b=BjLTsR99yvK8JiL4LBdEFrIPA14PKnw6nKIyNx8h6Qt/1xgB7wl5UfwptrXnF7mMCZ
         u6YrjAjSpCMZcMxS1YgsQbG/ELzu3z4r8JAzfk9ds81cHYpttHdyos82IfAQl0O7FYnk
         mAw/2Q+rhjqiNuEfIX4SarI6WB7cu2+SZ1x6Z+XvnrLgbZQJG+V/2LitslLliISaRPk7
         gXpoBazCI0CiYWAZBFzckE8XOLT5JuHCTDuoKs9yiZafgWAZyPZnE0Gl+NsNWOAG/qPE
         SzvHZaS57x8h9zkDb6Y/wBlR0Nsh9aTulMa+XHalN4maWKjflqG129sZp+dU1X5jjZGu
         xVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704188787; x=1704793587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OT4NBXZq4lOggwhVs0E7dfGjIT8JkDgRgI6TtvFVyKU=;
        b=fPz0gH55PFmj68t0LgA2Tck+wPcfz2gA8QtQ2NPyqqN/SlbD4nXVvlvn/KuuxmrkGq
         6vyuxTWL4jnP7By+XFQnrUKv+bu8Qu9VzbDXH98CRawRLgtbio2DB0qmThxZPk1P1x7N
         wC2IUixfkdjsu9lNPicUrOVixcrPT1X9xCc/ZI/f7JAuOJPpyn2gJELXzJpT73g/exwI
         kF377klmDhdP40GolKLeLLRmITXWiTd2wNdDOifKFr102H7nt1crzT9tEpPl1uoAGzuE
         SuTRwy7xvLuIbL3FRTCZ3PiFQgnNVpvg23RABQxrntP+fA2ASmkM8sW9wwWF9c4ZJS+e
         b6cw==
X-Gm-Message-State: AOJu0YwHNLiSXxRqkZowsZ+AeOsRYJfHDi+JNzhUBUtOFw0PFqrlCStO
	/O8QV19dlE+T+vJrFHC+cKRMzfmeszGMXvJJ2vOMJxiDwaUB
X-Google-Smtp-Source: AGHT+IGrClHnNGqZiyCyQZMzV6DlaaL+Rd9MS4p+o0RpPIcdB0T0ds43BAYx7vdC16NmdLYMLgqlK+2i+TdG9E58U8I=
X-Received: by 2002:a50:cd8a:0:b0:553:ee95:2b4f with SMTP id
 p10-20020a50cd8a000000b00553ee952b4fmr1062422edi.3.1704188786687; Tue, 02 Jan
 2024 01:46:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <14459261ea9f9c7d7dfb28eb004ce8734fa83ade.1704185904.git.leonro@nvidia.com>
In-Reply-To: <14459261ea9f9c7d7dfb28eb004ce8734fa83ade.1704185904.git.leonro@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Jan 2024 10:46:13 +0100
Message-ID: <CANn89iLVg3H-GuZ6=_-Rc5Jk14T59pZcx1DF-3HApvsPuSpNXg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Revert no longer abort SYN_SENT when
 receiving some ICMP
To: Leon Romanovsky <leon@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shachar Kagan <skagan@nvidia.com>, 
	netdev@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>, 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 10:01=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Shachar Kagan <skagan@nvidia.com>
>
> This reverts commit 0a8de364ff7a14558e9676f424283148110384d6.
>
> Shachar reported that Vagrant (https://www.vagrantup.com/), which is
> very popular tool to manage fleet of VMs stopped to work after commit
> citied in Fixes line.
>
> The issue appears while using Vagrant to manage nested VMs.
> The steps are:
> * create vagrant file
> * vagrant up
> * vagrant halt (VM is created but shut down)
> * vagrant up - fail
>

I would rather have an explanation, instead of reverting a valid patch.

I have been on vacation for some time. I may have missed a detailed
explanation, please repost if needed.

