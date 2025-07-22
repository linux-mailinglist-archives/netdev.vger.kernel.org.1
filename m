Return-Path: <netdev+bounces-209110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE376B0E534
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 23:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94371C26E3E
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 21:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059DB284678;
	Tue, 22 Jul 2025 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kAAuMy6t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98659156677
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 21:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753218328; cv=none; b=hOhds2bf3nLAs5f1dY7jU3PsswPyxW+hT7vndG5T3EOCmf+59IQT9N82gXECsYgupYIujpA28EBlTgmTwbEOFEQoDMtWpBUWUKJDHCWoJZiU8QiZ4tDBw4qaXk5eGvno/+n/LRAaazSHWQbd+hZUZgpJhY1zJYEJZVr1FkXk+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753218328; c=relaxed/simple;
	bh=YvZswcJgPnJu8NwpRikuHKOiJVhNA3+eCw/j6FvSygw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aEDNHgZXEm0Mo2sHsxu9MKQdJ5N4E1wwVcXvj8foIAQlE8C6jCiFSni6tpIUOFboBgUf0Ih2u5ef/w4lS9uvxdqX6kxcBcFpUF+J7qTUKr/n+0M8If7Yzx1m9AI2OZsSx48MVKnBUKvuhT8bZVXqUXFn+yLZe3Enpw/ouu/VXIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kAAuMy6t; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-237f18108d2so59625ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 14:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753218327; x=1753823127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvZswcJgPnJu8NwpRikuHKOiJVhNA3+eCw/j6FvSygw=;
        b=kAAuMy6tX10yDmIUf+j4HbF+GCqfHUTaKBozZbAb3wQzf8IpBZ7YYbg0NUV0Pt3XcV
         eGSgQkB/Tm5yuLIqPZJeFYD/3QzEQOhQXdx7jeujVsp/fn5rSF41NZunq4SFe8saQl5p
         tMrCx2sEkt4U9c5cmGUk9SZ/A2RBgpIID3LifOESrOFpgH8HLWRxRqYukLWu49h/YfmQ
         zpB73tBxJBulHBXWLFHNVjQXvep4s0qrWnAXCjryJJXYbzrU9xOHfMSoFASh3z240I35
         CJnrSbKE4dvd5ponpesB0nZ7s1HLSKVpptzDpEeJAj1+bGnMjYX3q2NlIX9sqCWz75GX
         CijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753218327; x=1753823127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvZswcJgPnJu8NwpRikuHKOiJVhNA3+eCw/j6FvSygw=;
        b=Z9Gi/vVVakffTFdp1Gm45g31UgqG1O3KpqYPQUN4rUsShXTyI6YIkxX+Hw86L6PPiZ
         qCYWDWZzeZfE/rwqdE0rFcm+5uLfZMbAcb0xRKMEylf4WYyxDUJShk0S6p/718n8S5Lo
         B1DExAdxPB2XoxeDIFKUppGZkK3lZBx+0v0FIMSc1z3W1iZR00M4PYW84ER+WJrDW0BW
         uXJ1B1F3LtTIaaPVWLfvn88rNNb93N5Hql7ZhygYH9sKCJxZwnobI8K2phBuQhPpAk9n
         jL+OsH2S311NRJRWjIxc0YBFu89JUZEYn5Dy6aWwBse0a9VAH8EU6sEdGH08wZbO/Wwv
         ZF/g==
X-Forwarded-Encrypted: i=1; AJvYcCUcPlJY65ORWxPaB+sh/QurZv1a8A1qH79Gn9GxEPAusIh4C3HFrmjTcpUUNUANqImIuO1dA7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ot1J+rWyLAaw5gRcPuBNBWR6US7u+JKvJ4yUFYvPLQ3wuT12
	5wsEQt7BEcirbG8BCRthYvXcQLcGHScGIyW5atbA6GWEiGAeYe7enlmOB+I+3fvsUPlTSLfXTGM
	mt5pDj1Ap4ppxK1FEm7S9cJOICx+wJGqun2OHbHAd
X-Gm-Gg: ASbGncskw4ZTXp/rf484Bw1MGrpnpImVa02UQ6mITCy6Wuppx7D/71e5+TY1ffpNq2x
	GIZUu856JBefX5Vcs8NutrsRLf323PQ2e7abhV91kpN9zr5Jghpa4U7TCxIJDJ9ErGncGqfsY1G
	uDSYqPf5Dp/U7qlR4wglJlE5BtVr/rGb4bQjTMZLeBs9BCnltChdV6KOd7GVwDa3gMuLnWKYDrY
	Iqaj6Zh3A8nXQwFiuWS/LxZBhVlpWgQ0C+5AF0TdWpKHOOJ
X-Google-Smtp-Source: AGHT+IE55UreLA0QV+Kgl08cqDnnKSf4spb7w8N2uku9yifYMNhSPwaEUemS9l5dOslGsPEVtMzKmr0/QoVm0p5g0Mw=
X-Received: by 2002:a17:902:ce8a:b0:234:8eeb:d81a with SMTP id
 d9443c01a7336-23f978e1dd6mr861215ad.16.1753218326486; Tue, 22 Jul 2025
 14:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722161927.3489203-1-kuba@kernel.org> <20250722161927.3489203-6-kuba@kernel.org>
In-Reply-To: <20250722161927.3489203-6-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 22 Jul 2025 14:05:08 -0700
X-Gm-Features: Ac12FXyP89EjsjCzI_phWVkg5cXangFsDAxrUNOIZ209dCSux3W3wTBaCb78I8Y
Message-ID: <CAHS8izM_eUxcnOFniP2d3D+H74bO8hZdrKZj3mkBfhCxbOGKAw@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] selftests: drv-net: devmem: use new mattr
 ynl helpers
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	donald.hunter@gmail.com, sdf@fomichev.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 9:19=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Use the just-added YNL helpers instead of manually setting
> "_present" bits in the queue attrs. Compile tested only.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

