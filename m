Return-Path: <netdev+bounces-221033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5E7B49EAE
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 03:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81B8D7A6575
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 01:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72781209F43;
	Tue,  9 Sep 2025 01:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="dNR5ffp6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21571B4236
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 01:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757381370; cv=none; b=HfyreRa4vv8D4ZGqEgBKhiVntSOCETVxo4e0VW886U2nYh8syFW3QmBCc9Z2OULjEhFKYK+W585lrp726BMt77Rh2nPJuJyQ2MT7CAJ6MVxTf5dSqmb4AfGStE2qtxwdj+Z4khzWteClEQJ6Hhxal2vTSJ2wUjTV8FatyF5JJAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757381370; c=relaxed/simple;
	bh=ZKoeUU823s3dZ0r5Bf8rKKvuaP+8FHcqdrcVRN7BOjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qy+6B47ZvlxS8J0v76UvuMu/1BReW6qknsKNr/VxGMTXm7OyesLdkkEirLXuDE+x/0TqJf8vnPkQoX40YtZgvERbZnKk36BevjgviIfqDjkjxC6ycVfkLxVBGQYEkU43pCeS94WX62BU8B0OpslJdyte4o9dqSXkUoo9h2LZOV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=dNR5ffp6; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32da4f36572so141507a91.3
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 18:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1757381368; x=1757986168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IufIVogrUx5W0Cl3Z4URgdEyzv6FmhILTyi/wZgHmg=;
        b=dNR5ffp6GUEiUeLikvZ+7FDh50/xHQXIoHmgUsJxA1EYu5WON/fN9BAHErAxWfDB6P
         MpVpMO2CPKvfnNAbdkqrg3BfAz9n5RHHs3yqpMMm2Cx5VWna6ZrghzhzPN1GcBjVNY28
         qYRLTaYsISh4hLeM/Q9lTNMi4X0Ev47rCVymcNhygNIgvtTEIDt/CSjiwBJxvKfAFPin
         z0zQKe3UPMZ7OGlFky1kY4FbY3PssChrFfbjFBz03rtGW+CADLV2qBROe7YBI10J/+1c
         DzxtDQqnzbNmyQbsMSgG9TFR4yo/MatNW/QFwcfW0/vlZk6DxSbZdecglqZEOw3toe3T
         g26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757381368; x=1757986168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IufIVogrUx5W0Cl3Z4URgdEyzv6FmhILTyi/wZgHmg=;
        b=U3kr0ClnEBiNvfzaLEUefY4jcKB+sfRcecoWv5TBHTcEbg4F+BsafC6j/4RQvgLpbv
         8+vQV/H6Te7apZ0aD+dWcX6ewJ7L4fydXdoHWxRlcKdMziDFWftK9U2Z+9HkiEpFcSj9
         2zCQ/BQxzX9s3VPBgQID81pyPvOmaE819qHT+m/loKEk71rNeA8Usx6WqX0teGtcT544
         vZ8Hjma0J2FecxWOmRa+uZhU2eFfC+7s18WFWcWYTgchHCt/plRaEgo5WndR5sjt6cER
         4boGJdcEmusxHMYbZN+ZXVh0S6PpWScl4ApG1MFBmSRfHfIiikiGkPmIK0j/fJ7XHD/T
         v+FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoP5jLe48QiPnzZ10iXurIGxfaCYgEP1j94erSHJQUeLQUOX2/CzPMGcZlUe/XvGKGguAPFKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD5VveZKV1siZd5Bc6P0xvIsu2iPVNcgnL06PRy/grrkiV1jiE
	pI1QIBa+KPPfyUEk5S0LyHN1wghWMXDcH2Qpayd/+VgJl88rRhKKeEYlj0v7mjrmFecWNyaq739
	Z8GkfHSAT1EDqKmp8+OwT9H2cb1ii4hLSldSNTZTv
X-Gm-Gg: ASbGncs21f3YY+ekpU1SzFaXYjwonnjbJLn9YpPVxbhEmlPP5O1iX+lc6fR8jrmUwFZ
	3i9TxdKiItWtVI4Lzxqp5QPLptrK5oYeUdxtujV8Ibum/+CHoPgmv/kT7b3Lr049F4Vaz6oY6It
	ZekpMRgmDPie0Ew7H0JuCLM6KGwPGqyc7IWLBItj74WotBrMSBjXBn5VFbnGLY76KHdlaLqZbbS
	2o4nqY4qLFgpAoiDFAFcer+4Jk8PEf+U29MtzBiIizLnm+Hvs87uF3t6fcN3D0xS6LpMBibHXdR
	MB4GTfv6mzYuii5sJyA=
X-Google-Smtp-Source: AGHT+IFH+wwEUO3RIISkmb/dD9lGkicUbZRUa3Xe1lQO7mKP/+N/aJmGWVz4x7eyoiCWGPPhPaZbSheSNa4JxMcfVm4=
X-Received: by 2002:a17:90b:3f8c:b0:32b:be68:bb30 with SMTP id
 98e67ed59e1d1-32d440d2749mr13489875a91.37.1757381368283; Mon, 08 Sep 2025
 18:29:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830-b4-tcp-ao-md5-rst-finwait2-v3-0-9002fec37444@arista.com>
 <20250830-b4-tcp-ao-md5-rst-finwait2-v3-2-9002fec37444@arista.com>
 <20250902160858.0b237301@kernel.org> <CAGrbwDRHOaiBcMecGrE=bdRG6m0aHyk_VBtpN6-g-B92NF=hTA@mail.gmail.com>
 <20250903152331.2e31b3cf@kernel.org> <CAGrbwDTT-T=v672DR4wJU0qw_yO2QCMQ4OyuLjw+6Y=zSu5xfw@mail.gmail.com>
 <20250903162758.2bae802c@kernel.org>
In-Reply-To: <20250903162758.2bae802c@kernel.org>
From: Dmitry Safonov <dima@arista.com>
Date: Tue, 9 Sep 2025 02:29:16 +0100
X-Gm-Features: Ac12FXxNvfpjs0LONIP8XH31Y_M-Y_UcZVzasS4KRi-wIESHeToTN5MrMCtmpZY
Message-ID: <CAGrbwDRTx8NvG7sOxtgj9shuNaJK=6=FaHFUEGsZBBvcryxEYA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] tcp: Free TCP-AO/TCP-MD5 info/keys
 without RCU
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Bob Gilligan <gilligan@arista.com>, 
	Salam Noureddine <noureddine@arista.com>, Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 12:27=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> On Thu, 4 Sep 2025 00:17:34 +0100 Dmitry Safonov wrote:
[..]
> > Looking at the code now, I guess what I could have done even more is
> > migrating tcp_sock::ao_info (and tcp_timewait_sock::ao_info) from
> > rcu_*() helpers to acquire/release ones. Somewhat feeling uneasy about
> > going that far just yet. Should I do it with another cleanup on the
> > top, what do you think?
>
> No preference :)

Jakub,

I've sent v5, addressing minor v4 review comments.
I have a patch that migrates ao_info from rcu_*() to
smp_{store,release}*(), it seems to work. I'm going to send it as a
follow-up, once this gets into net-next as these two seem to be mostly
reviewed/ready.

While on it, I noticed that potentially I could trim (struct
tcp_timewait_sock) by 8 bytes if tw_md5_key and ao_info would union in
another helper structure. As on time-wait socket only one of MD5 or AO
could be set.

Planning to send these two patches in a separate thread/patches set.

Thanks,
            Dmitry

