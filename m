Return-Path: <netdev+bounces-162671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDB8A27949
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 19:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72D11888473
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 18:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C647217659;
	Tue,  4 Feb 2025 18:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DQ+KyDtk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D29217645
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738692229; cv=none; b=OJA12eB/Tyj0ekvNJpBWvZovHMl5kUw80OZsiA1+x2/+d/Wh80WgCiZq1V+aX/YJ7q9RYVfLq1ghs3Q2qtls26Nz51LaXrdRPulOGBGMhlwVSxvEVYCEEytrUFKFobO/lZHUCsFAezQcGkYEYGMdbRyqqcvBJh+jD8lDILaJ7jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738692229; c=relaxed/simple;
	bh=Oj0oNLn2yL6+fmX5W290/5q7EprAS3GBOQgkRODPBVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkGqzc5UT4uGodHZZlKSKIWPvs1NKUw0Z/n1r1EpquYfbRtVxWiZ7IMD0ADv3KOu+4qCYNzstapof93DXq8G9DFuxRfPLQtDGTtKffnDThsYFaDb8CSP8kKbBrhu7eTDvWx4pxQQyJ3/2+fGWc7C+P6K/oQndzngcTtOfrMZUjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DQ+KyDtk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2163affd184so146105ad.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 10:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738692226; x=1739297026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnKb/NxDzwUPz79zbu5N/Xfg9BKIOLMoGS4rXOX07CA=;
        b=DQ+KyDtkBwZJAhWhAuyRLkhaKlrlprdaumqBBWGb5rYVhJ5zvZFsaw/09i/unlQsJl
         xQLhazeBVf25SD1PzF4JRfqc5hlzo/54HzTFVPi9gC8BqAb31DxwAFOnxATSJS3oMvbF
         zwv3Yj39GxnYFh+df101DZeOowd1QWFO2N6CrK8APpNvTfLNIZ8Aoi06R/TH1hmUi2A6
         lwxA5FRbJaOOHnssKA94tlAuQSBF580Hhp9999NpYT+qgp/vaMOJYOcehm13j7b1EGKR
         NARGB9W50n9tnEn4s2gQwgafvsvgcuO5wMJEpE24jofmeBT+2YMEVX6EBaXWZvCure5M
         B/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738692226; x=1739297026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnKb/NxDzwUPz79zbu5N/Xfg9BKIOLMoGS4rXOX07CA=;
        b=pUYQihUSeKHNkQ6f2pvTYR0dSc0baSCDZM1Xv8IF2H7NkRk60eq4oOODz1OQFURWo5
         1vm0V2riwR4Xu/F/Yhs5cdE9/pxaO6gavvOCHh84aDoDIzYscRgBKzcgZb1Y68M4wog5
         n6LXtM6zHZkzJh6cPIHBcZsTcL5ss8Mc+7J284uXa0/e56Tk+iQW48dnlg/7xSheFFnz
         LTtMzwfjDlVLauGEgwd19mtfCbNCmTRvQR9g84g/6vsUv6EFsAbnJCqqrxf4zraDoSIh
         sIlIFx1s3AWG4PyL8JPvgLxw4z/hjmyUkm5xjjiOnjZ47HhkS3Pn0IdlCsZg+rNyAIhY
         RGeQ==
X-Gm-Message-State: AOJu0Yzv9wiDTVWbFkanJ6Y6bR9SdVRRae99yZxS7Ih3WhzSBiazFtR5
	mYq8hM4GEKpEiaRrAOZ/HqnIc9zYpuABhCbPbZNPfCR98GPiT9ewKQM806hJEqfFxSHL/64A59K
	GwdrSNr4NM+h/hW9WbWApheGrsI9aAoMv1DWZ
X-Gm-Gg: ASbGncsLA5TqC0V/mxyRHSVAWTcdD/fyLzuUjyN3TBysALov62fWqPD6byhh6HDRgUI
	kWSZPDvkmmMMAjh2Q3ZYyXv7l35GjUodBBq90GLSNDPtD/3MZi1KZlKIdtHtC7DAgn4dB8mMI
X-Google-Smtp-Source: AGHT+IFGO0WVuOzQMwTOIUL2zNV30YHnBBx/izI8+SQNwu12kEXS3uYQZz8FhcRE8mSTIdjM5HAUSbAmJ4VB9XKoqDo=
X-Received: by 2002:a17:902:bc8a:b0:215:44af:313b with SMTP id
 d9443c01a7336-21f000c1a2bmr3663845ad.0.1738692225592; Tue, 04 Feb 2025
 10:03:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203223916.1064540-1-almasrymina@google.com>
 <20250203223916.1064540-3-almasrymina@google.com> <c8dd0458-b0a9-4342-a022-487e73542381@redhat.com>
 <CAHS8izOnrWdPPhVaCFT4f3Vz=YkHyJ5KgnAbuxfR5u-ffkbUxA@mail.gmail.com> <71336d4e-6a75-4166-9834-7de310df357e@redhat.com>
In-Reply-To: <71336d4e-6a75-4166-9834-7de310df357e@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 4 Feb 2025 10:03:33 -0800
X-Gm-Features: AWEUYZmiESSMokFwGB0BJqHNhJeqNgHpu960zdUgGcxEH4CFZhDgvoFYnYH4I-E
Message-ID: <CAHS8izPFe-1tf9Xetc8Znj04x9rKXVchR3DaspRGPDRbSFQFgw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/6] selftests: ncdevmem: Implement devmem TCP TX
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 9:56=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 2/4/25 6:35 PM, Mina Almasry wrote:
> > On Tue, Feb 4, 2025 at 4:29=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >>>  .../selftests/drivers/net/hw/ncdevmem.c       | 300 ++++++++++++++++=
+-
> >>>  1 file changed, 289 insertions(+), 11 deletions(-)
> >>
> >> Why devmem.py is not touched? AFAICS the test currently run ncdevmem
> >> only in server (rx) mode, so the tx path is not actually exercised ?!?
> >>
> >
> > Yeah, to be honest I have a collection of local bash scripts that
> > invoke ncdevmem in different ways for my testing, and I have docs on
> > top of ncdevmem.c of how to test; I don't use devmem.py. I was going
> > to look at adding test cases to devmem.py as a follow up, if it's OK
> > with you, and Stan offered as well on an earlier revision. If not no
> > problem, I can address in this series. The only issue is that I have
> > some legwork to enable devmem.py on my test setup/distro, but the meat
> > of the tests is already included and passing in this series (when
> > invoked manually).
>
> I think it would be better if you could include at least a very basic
> test-case for the TX path. More accurate coverage could be a follow-up.
>

Thanks; will do.

--=20
Thanks,
Mina

