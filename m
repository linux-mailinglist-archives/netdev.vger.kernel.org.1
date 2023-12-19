Return-Path: <netdev+bounces-58955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 990D6818B11
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 16:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39CD41F22102
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 15:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB0A1C68A;
	Tue, 19 Dec 2023 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xZUkecWk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A731C691
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-552eaf800abso16730a12.0
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 07:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702999247; x=1703604047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUn2LhUltRa85X/TxxZyvnwOSHHz8vQo4mNkfgttEIo=;
        b=xZUkecWkk7ozQvPIOtolAYhesq+RB3qP/APwgyC16UWJgS8wK2qV/ERr18YxvgYiha
         +5jBXk8X4eJB+lIdo5kS+88UchwAHRvrkJ33RDHlxeEcRMcmXfuPOudjzCr7DPigkNUg
         wX32Sj4kSI2MxdosbplZtt5FAvck2RgG2/ECGkTs7J8/CYFwO9iC+NyFdIygTVxLuhKK
         0YnJp3ff10o8VWHtJOzED5qeloQzX9htrGTF94MuK9HGeX1AMEYUkvSO45NHGQRH20oJ
         7b3+0wv8if8t1Gnbkk22KHP6SzgDrowWXtlcQ8drEPrnX4Fivbbls9bCcdXt3qcZKhqK
         DdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702999247; x=1703604047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUn2LhUltRa85X/TxxZyvnwOSHHz8vQo4mNkfgttEIo=;
        b=v75KnBVRTIH2qqoPWAZanYEnQ2NqpjacSJCgDgflbrQdr+ae7YozcRnUmpNYljRCHx
         09xavaDfNkHUrVvCo9ykqpJxMhfOEvsX1JJQhr/4WsCpSuIK9yqSGx1az7GDtk8/1ZC3
         BDZbtlsdp/rCq+r2Jn096lWikQS1NN9QsmyAduENzf05+lvW+i23IBUSXYvaqgyPV4CO
         WwRE4xrD09vYpXQQEwjlXJAZV2/e9h2BOzulzJ/B43WnxM2SoujmxN0GH8wK5rawNyON
         fMkcoRq9+GTcolWI5jXw4ZUGB41ry5tlhVGB4eXr2CqtSVuoVvuU44PQqHnguZ/AsY0x
         Ukjw==
X-Gm-Message-State: AOJu0YyuSxZ3GobCyik3jKRGHoh2Mzw0z4/Lph+3xOWr+Dz8e1UcX5Uz
	T4hos2XaPsXf4VrHNgmerirvhr3+Iscj+sxGJu41gwuy2I6S
X-Google-Smtp-Source: AGHT+IEdD/3mEjVW4hcGDVW8dFGzaxUxmhtR44/vqbB3tXGa8Ms84822pPxG2O2KNv/VnkpUUtB3F24mGD2w0tgvEG8=
X-Received: by 2002:a50:d613:0:b0:553:44c8:cfc9 with SMTP id
 x19-20020a50d613000000b0055344c8cfc9mr214533edi.0.1702999246822; Tue, 19 Dec
 2023 07:20:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219001833.10122-1-kuniyu@amazon.com> <20231219001833.10122-5-kuniyu@amazon.com>
In-Reply-To: <20231219001833.10122-5-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 Dec 2023 16:20:35 +0100
Message-ID: <CANn89iLongzRM7N9Jsaa2ugTC2eAnNVU=ntFsi3wddGJxsmqeA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 net-next 04/12] tcp: Save address type in inet_bind2_bucket.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 1:20=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> inet_bind2_bucket_addr_match() and inet_bind2_bucket_match_addr_any()
> are called for each bhash2 bucket to check conflicts.  Thus, we call
> ipv6_addr_any() and ipv6_addr_v4mapped() over and over during bind().
>
> Let's avoid calling them by saving the address type in inet_bind2_bucket.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

