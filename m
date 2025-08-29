Return-Path: <netdev+bounces-218087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAF1B3B089
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04DF01670EC
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 01:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9401990A7;
	Fri, 29 Aug 2025 01:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FWBg3Lrf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E351DFF7
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 01:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756431232; cv=none; b=ifyKUUqpZ6RKfcu5SJKNSCMIzxrAQp80L5RU6BYHenVLEBOB6EEZ7yykPsnGYwgGXptQ/DsE4CF963hVKAUp+OOxHwLjwHKpOWNvzd0HAbqGbGJ5/PSUWAusT88+AbsdP9Stmd4kcQGL4yhEhaQlcUGOTzKkDvmAaN6NE5/WSdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756431232; c=relaxed/simple;
	bh=DPh7cT5+mSJIgSo5SrL13D9bfkqnE+2Fq1ol2kgxtCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f17qfh9j+GieE+d2scSYWD6Ug8/+9cPFsDj+LXBJm5QcTh161EMSrvi0dEFgbUyLazfRP8PuclvUU0VUpChwkvp42AsB9xUTjG9IYJFiuMuMB87Mkz3vmS8WLmQm8XiMgvxkNap+SzjCYqNXhklRJtG0CDNC6u+noguqKLxoK+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FWBg3Lrf; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4c645aaa58so1032216a12.2
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 18:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756431230; x=1757036030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoJ0d/w6UnUNtl7ys0E4IAYSwymS8wk+0JNV0D2OiCs=;
        b=FWBg3LrfIPXM/p05GBIxOai5xhI6yb8PxzoYSibeuiyp0cnNFtJrRcZk/toYe8asXG
         KAQK6NzqWQCrQH3LJ6Fm7G45Fi5FCbPaVhCC11rI7WTpa2pkIl+MgToQZ1iWZycbQAGb
         ARwiRifi01wHoaj5A8ctJwbypsIlue9cPPMbzimnUgjNSwoKxiuqHLJqiAO1vc7+oesX
         5sNRbmWceKGuMdMSmJFaHeOiYnXboVM+WSPjua3/m9pTmYAK8ESGoZ/HwQxmgj0X5cU3
         +rQHnEilMq5YLhgX5Om7yuFWx5BaQKqPdMvqSrHwlCjlBgQRqzfEno5qf0ZzqznQkxSX
         b9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756431230; x=1757036030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoJ0d/w6UnUNtl7ys0E4IAYSwymS8wk+0JNV0D2OiCs=;
        b=krtHK9+MiOxBdb1H0p9IdjePdxxYVNEWmLXmAG2KnBZaCeKP0yrLfF2rplRgwEllTO
         3E0S3IoFpVSkBcUlgOmpRw6UEeADbhwldPUpTow/8nn/zoQnDXL45sVAGsvhiKYzxwON
         tHVfOBGDQN83tnOlMY3sF38rR5IvSbcDcTSKAc3EGCkpnmbl2amBy37OVqOc9v1tsVwA
         9tOEoIXjtPX/F8kKctXRKZXtyg5IKy9j9APHsFYZ+kdOdUDD70KRqZ4CxWGQ+sRrdHlt
         8H5oZDcEtDWsfWQSWOzU1Ej05CfoYr6/qFKHNOU7Mq+ShzWRgDkxJUhSX9iGqhd2lZL0
         VxaA==
X-Forwarded-Encrypted: i=1; AJvYcCW2w3OvQz/7zbIhATGKjz/H27KBemIHwYer1Nn60YgIq6grVOsHZ/WamaWXU7RfZryyHlJX5uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvJD1OLgpE4+e7VJCc3Ocro/duYhrBtVOrhvlmSUK3v+RqjM4J
	2urJlFghEnm1Fi0KymcyzoAaGsymOXCDhLsSLITetucy8/JuGaS8J0nIa5FyRIdulCB1J2tYuIV
	dpbHzS+9qdwKLSiqMNMDW+AoC8NRmkjDBD7ctXGYa
X-Gm-Gg: ASbGncvw3LZC8wlQ88eV5CarXpG/EJVQiAOSQTaRI/MhGMG1NamU/V7a0mIGnhtTRmG
	iOWNwyUdmfPGFSmfa2W5MckatSLvQz7fw0R8aluvgkaiNVbVoPQoBNmmo+xIqI5iXlv/QMY75vG
	6X0h2ylYkcfhvicuXlrUTNpOmSWugwFXYsXPFYxDL1rYoRezWuPpt/02hAX1AYK0U0t6wTTDJ+G
	46EJKjpP1VaBzD5F/FGnkir9/bpqAWHnaePoVdVtnK8nnti5hasiD3aEY9JNJVrb0hKgRDCkTp7
	eNk=
X-Google-Smtp-Source: AGHT+IGzJ7zluIdgfpcR9NREs72zU4TaZpGyrCNDXuLPLWxusMxFDic4R0/yxQzOh/LTnc4pBxJwS2R3jBcIXWDHIS4=
X-Received: by 2002:a17:903:3885:b0:240:6aad:1c43 with SMTP id
 d9443c01a7336-2462ef70541mr296230635ad.48.1756431230289; Thu, 28 Aug 2025
 18:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828102738.2065992-1-edumazet@google.com> <20250828102738.2065992-6-edumazet@google.com>
In-Reply-To: <20250828102738.2065992-6-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 28 Aug 2025 18:33:39 -0700
X-Gm-Features: Ac12FXynCaGPSINlb6hgSgmkryYO_9tSnbZj_ufma4NCG2USyN7HOYpGcVQyFVQ
Message-ID: <CAAVpQUDkRWs8D-PY-pGDC=Wyz1FLd9UKZTFM=msOjdG1FEb9-A@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] inet_diag: avoid cache line misses in inet_diag_bc_sk()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 3:27=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> inet_diag_bc_sk() pulls five cache lines per socket,
> while most filters only need the two first ones.
>
> Add three booleans to struct inet_diag_dump_data,
> that are selectively set if a filter needs specific socket fields.
>
> - mark_needed       /* INET_DIAG_BC_MARK_COND present. */
> - cgroup_needed     /* INET_DIAG_BC_CGROUP_COND present. */
> - userlocks_needed  /* INET_DIAG_BC_AUTO present. */
>
> This removes millions of cache lines misses per ss invocation
> when simple filters are specified on busy servers.
>
> offsetof(struct sock, sk_userlocks) =3D 0xf3
> offsetof(struct sock, sk_mark) =3D 0x20c
> offsetof(struct sock, sk_cgrp_data) =3D 0x298
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!

