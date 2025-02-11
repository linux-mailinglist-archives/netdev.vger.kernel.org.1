Return-Path: <netdev+bounces-165170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1967A30CE1
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 14:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A011882FCD
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 13:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09192220698;
	Tue, 11 Feb 2025 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wyagR4XU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4695D1F192E
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739280622; cv=none; b=s5KDyA9pXy26SenYlGL9O/im0Kl+HcKKaYqfRaMXtg5ysmWXVwbfYirGwytG2XQnfShziwQEUwGS3JybJCkZ3oXD6AeSLRRor6K02nibiU6d6X0jdMHIgfZJoKIv7+WxmFjyo3H0NzqbQAtKyQ0/34kfDZmGLm0xIxqTTP0CFkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739280622; c=relaxed/simple;
	bh=82BW2TgiZ+59w8ny9S4IM4TvfBXPG/VmPuNOynqtCtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Be2Y7ST953jQYDdDKs7HOdP3mUK+8CiGy58Oa3T6HPRhWsuSTpxD1Rtm1JgzmtaB3SbxreUWEtvsrvbNxnBvhI9JcQaRq+ir+HFWeLr6rVwfgTSUVct5beGkiVCwJGl7BkfhYCN4w4TCF+pIQxo0MsfvyxKhLsVJ5PgmEClTOlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wyagR4XU; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab7c07e8b9bso368852666b.1
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 05:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739280619; x=1739885419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82BW2TgiZ+59w8ny9S4IM4TvfBXPG/VmPuNOynqtCtU=;
        b=wyagR4XU5bCPH1CSj+D2QWHkOm68rGf5ud8JNExDz93oc7qdjp1S8ndPRk76b/rZgW
         tldkRS9Q9fA5qGrjKpkhLQQ5E5EAKxus3Tl9upZJYaaD0SLCWt+e675oEv4rtWPENO+Y
         URlq6VhnlcBXKBLj8r6/BYqNHk88TZZvuOkWce2oaFmtC/HgKUOU9OUPYwCOiQ+TzGyi
         gh45yF/T+CwFFaDrzSTyVcSbZb6uCsbvZltZCugaqPC41jViymXYF6g+JLYGjhEVmyAo
         7ymtwYdq/bP67Wmq5zVHdVvhJuxEoHQy87zFbv9c0gzZPO7BCRSvzPxvLxAKokMvEj4e
         uKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739280619; x=1739885419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82BW2TgiZ+59w8ny9S4IM4TvfBXPG/VmPuNOynqtCtU=;
        b=YlOPYKckZuoRc+OQiROxsUDxSIsf8M8QDN+c+tlawBGUFCpz7mLfFEdoYhSTLG7FQo
         jow042jlIbJOdckiQBvv2I1xA6dcfuuRyhbiX1nIOsqSD+I9P9fxET1oWCsRjHfhQwgk
         Q/t84sRX4VQyf9/hD9eKc/v24EbZxhOcCyL/iwrMx+4rk3op/SScWAoKFw3MwdhWK61A
         2almoW+ffeIabFcvMg62Bm2PSw21vghXcFtGnDjiA3iDGusDcwyjBKfgwbTNge+Qfm05
         Ro8UQib20cdzpFRMmAxxICaI3bRleNVDaENLBPFmLOhyZGF/seqfMiUj4W9IJAlEFdrI
         rxQw==
X-Forwarded-Encrypted: i=1; AJvYcCXUokWtawR3zgVgaVXLI3u8WwBg4iwxy9bM0paBsLkBmM5HfqfYIh7UMrUhP0Kh+3vb65WFd+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjB7wPDW0GNdvanLkBw5feoXLSQhB4PfdXO/mmjDMiAzdkzlRI
	SRAbRGJrVWVdbSs8XXNZJ3VK2bb8KVup1Mj5bwyq6G2otpCR1v2XilnKIBkp4O9snvSdz+pLfpJ
	8C0Abk1vNtkE5uyr4ILJlt1jXM5LPnCWAJMk1
X-Gm-Gg: ASbGncujI24J7AYOXC/i3UGSz+hVtkb5ErVrtXtPz+Lx6uYSJZevdK/Pv4o2JWVs+Nm
	D9ye8eDC330T73dDSDUWDfZpz5OwY4SaC9Rf8bv9twWt+D7osEL5gwfNYzeFucIliv66CN7DW2g
	==
X-Google-Smtp-Source: AGHT+IF+c4dpr3+3jjyexFWSIic+MCyCj2EsuAMKw7FHGG57pO61F0kbL5b3iJvVDgdPCATBskBApuRNIlEGArVa6ME=
X-Received: by 2002:a17:907:daa:b0:ab7:c1d5:14f9 with SMTP id
 a640c23a62f3a-ab7c1d51fe4mr912374766b.10.1739280619537; Tue, 11 Feb 2025
 05:30:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211045057.10419-1-kuniyu@amazon.com>
In-Reply-To: <20250211045057.10419-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 11 Feb 2025 14:30:06 +0100
X-Gm-Features: AWEUYZmdaVpaxSjKB1DU-BcxmRIsM5AhynrWmG8C5BTk_8hbQ0r07QcViIve8VI
Message-ID: <CANn89iJTQmF7_AMUP_QBV3YkrU9KDRTuumTQEJT8_JcmK3O3Sw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] arp: Convert SIOCDARP and SIOCSARP to
 per-netns RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 5:51=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> ioctl(SIOCDARP/SIOCSARP) operates on a single netns fetched from
> an AF_INET socket in inet_ioctl().
>
> Let's hold rtnl_net_lock() for SIOCDARP and SIOCSARP.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

