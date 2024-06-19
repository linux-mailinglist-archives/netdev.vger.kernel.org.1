Return-Path: <netdev+bounces-104810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB7990E79A
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 11:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B731F2119B
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 09:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704978172A;
	Wed, 19 Jun 2024 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bSumNmua"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C6681729
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718791000; cv=none; b=RDxYYTnIbWFsMShcBjJ6G6ALlp4SuSEMl96mwWJ5wjCmiLSblbbrr4/sJuv7GbmccABL+sUB54IhJarRZPmqUuA+EwyBEbwhmBsjxDPEFp4Qa/mOdzjYuBrSYLDiBd6oRubw+r6AD9zcol9L3etYxWjdj7POMYG/yT2Lvfr+/fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718791000; c=relaxed/simple;
	bh=U069fedxP3fiUdw/neBJ4u6RIFjsO29klu0fvtBvX6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWeRLVZ6jBjh3geDwRsvFwTaUAUNtor0I5TtiaKisomJmg4N52R40Kv1f80VNile5tSxGF/Q0aCSB6nmatV7mLkSwdunLIZpK2w9gAOkH0TXmq5ChdCD742m9Hlltx8j73JwbyOplBoVlQ5YRwNwuENPhggN312UdPZ4b6c5CLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bSumNmua; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57d119fddd9so3488a12.1
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718790997; x=1719395797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U069fedxP3fiUdw/neBJ4u6RIFjsO29klu0fvtBvX6E=;
        b=bSumNmuahOlESGvzQSb7QchTJhJGJRqnAsMdwYB2vO9EK5MDt5/MseGyWk/0cP2yel
         2JA5lAh8YzfwU1oIAlB1JuILJIMWj+CH+VW6faT7NUqZLmba3gtEKRFrbL+Kp7Y/ETrD
         wQhK5ihf1CODAveHDjmhXE96JLEs1te+G5v/a5FDjDuwz5pvrQrRcNFk1rW/DnJwxS78
         1jRg7iCdSA1MkjGcVCklS3IOQMMmKJvqKUnp5asfu4cwsmt1oFEw7wDLwRbTUsU1Dfil
         xFnwLaUX84cl2i6Nt1SOZZTO++Rq4EoeK7evy1BbV5pS9kqJ3GgpTUWRjncwtaxF0gkM
         mnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718790997; x=1719395797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U069fedxP3fiUdw/neBJ4u6RIFjsO29klu0fvtBvX6E=;
        b=Dy2o6BfJoscspx9Bg4BMV/kP8eJLttiUvuQHZRxBalBMw6AVM6sSx9uJV4KOfjN//E
         Yku98YDgo1l4DhavBuhaYo5N7mcf31pwYr64pFa1J8UGHhm8OGxJrzsJXCrEsSNJl/ns
         +9soHuUiXcDuoxScYFgiZ0+uCY556iHnwUukNd+/2Iwm94Xe6Yg/OmNvZ21XXmN4onkH
         us6PEII4SVRyXJ2TP5HlTCj5tP9CTcZZHGGiY7F/FghZ0n1okCN3jp+/PVvcEBeNC4Hx
         a+2lCWilWCZBzK1iyekkaNe8C6ofKIxzWPPgl2h44y08ED9zXum4QlrqbU/4E472qTNZ
         EXNA==
X-Forwarded-Encrypted: i=1; AJvYcCWu5cTxbUqMQetyY1wGpVNklkTk0hd97WPQqel7Tt/TnwD4j5w+zqRHEGvJpCrMA7DES6wD6l3M4CRL9jkvoCsbfhVuwGDg
X-Gm-Message-State: AOJu0Yy2gX4KNO++0mLG70L5Zp2dxvgpb6zI7mYGxQSKMWs8gzHVrFzZ
	VK1kXhfANx84qcOWUIXD4dZSPDaQMqPCRHg5ewUTvEJiFdBz1Eg4plUy1Y7acNOhyNxKUjivsMB
	+tRWvFNrLW2UQtU6zcEYY4qVZnLgIN8qXfK0V
X-Google-Smtp-Source: AGHT+IGF8IPjq9R9XtjwrL4FUJ544IilKN39MOW5W8Ji606nsm71k9RdKIAjT3+JGOWkaCCZ3NK2ufxFEqAKVzI+Jx8=
X-Received: by 2002:a05:6402:26c5:b0:57c:cfa9:837b with SMTP id
 4fb4d7f45d1cf-57d0ce92e3amr168655a12.0.1718790996922; Wed, 19 Jun 2024
 02:56:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615160800.250667-1-edumazet@google.com> <87zfrjk8wi.fsf@kernel.org>
 <CANn89iJ2SHPGVM1mxx4x4WU5X0CcVmmBhSD-FZS5fPs_Z1D01A@mail.gmail.com> <87sex9l0oc.fsf@kernel.org>
In-Reply-To: <87sex9l0oc.fsf@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Jun 2024 11:56:24 +0200
Message-ID: <CANn89iLK2o0_dyGt+OpkCjunzzTGQDFEar3vBDiwZFz9cmC0bw@mail.gmail.com>
Subject: Re: [PATCH net] wifi: cfg80211: restrict NL80211_ATTR_TXQ_QUANTUM values
To: Kalle Valo <kvalo@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 11:52=E2=80=AFAM Kalle Valo <kvalo@kernel.org> wrot=
e:
>

> Just the tag in subject claims it's for the net tree:
>
> Subject: [PATCH net] ...
>
> Not a big deal, actually happens quite often. I just usually send a
> reply to remind the net maintainers not take the patch :)
>

I see, thanks. My scripts are mainly targeting net trees, that is why
we see net there :)

