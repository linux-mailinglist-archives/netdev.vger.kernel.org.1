Return-Path: <netdev+bounces-219819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98204B43239
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 08:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60ADA163C45
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 06:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9386325D208;
	Thu,  4 Sep 2025 06:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EW0n5f2Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269B8253B5C
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966872; cv=none; b=STue/EQ50aQ7siKldn+kad93B63UresUwefcK9w1Tls2jFCQGozPO/7Ycw4WmrmqC3VYuHyJZEDCYsOxQDkSrSrBa8kH9Ud+NmQ7QQEU7diGY1j9kz1MSv+0fwDIF+l/bCFr6Lf2iNfGTkUU4x1eGc7wkkUWzzJ2+MXJ1KSWSs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966872; c=relaxed/simple;
	bh=3KCF8QkrJxtNpKsZinIxLUDN/iGTdt5EQC0MLI136kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLXbY+JXsH5KHYuuhG+iX+Wt+uwm6xyCxa0ilT4tF6icq8zWb1Ksyw+ZHjnd9hgmv4WwoUNZQmh0xDmPuy5A2ePROYmpsruO7yEHKO5vqBPE939a21AZdFIUxibZRv+dJsR8f7F316NFFDwaxTSOB6+/ieph5oWUk71uv36aH6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EW0n5f2Z; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3f2b6e0b93dso3819405ab.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 23:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756966870; x=1757571670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KCF8QkrJxtNpKsZinIxLUDN/iGTdt5EQC0MLI136kc=;
        b=EW0n5f2Z86MtOmz8Qmkbtsh8QouQ0IYuFXK3YjXQtkLWC6f1ASo8IRZ93IlL6er/xr
         tLr0j8jlyGaBdvFtq/5/c7Fxtbe/ibb1QpNgUG34MueVW74qA47aNyXrAgSAO0SeDKx8
         QF3OGC8S7hMTlY5tQCUiW44bCBWi1PIccRoLuOcuhmwpnDgFl3L2eMWtX7hW2lfWGPXI
         GHwtNojr3LBXy9KGEiHQbEMDsSIOm9+/LIMvutzaV5AtC2XOA76Sp91ACyHnL/hBVK1y
         DcH0NChARLxxosbOHZuT4Rwd7Sz5hKYh8FnzNlKNeR2LwwOW4VrZd7QMKIwU6k4eoEp4
         zJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756966870; x=1757571670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KCF8QkrJxtNpKsZinIxLUDN/iGTdt5EQC0MLI136kc=;
        b=MHwjS5ydpbwnIGEAhkcSMDHFQCEpYjuYyxj8m5j5hoefXAckh1vusfizDT83018Dr4
         hDdCH2lkaDdU/RxcKc53VsilooCKzQia001izzvm+ucz4+ax8rKjc2ZBqOPAMnWRlEpM
         g8zYWI+JNJY5r1E8BKdGPlCYwVXTodt5hcDPbAQr9JxrxjXJHP1djHvjAshu1xHNj/at
         AHlKajaH2wTFd0QKuJnl8adkx4a+aKlwoh/49nl0zRN5PWTxjk7wajbaqNhwDDs9/zUT
         2NsJ97P2cQXNdqVgO6g2HW46rnQaFmXScN9cwvqx3rquiHruG7rAzkpJGGAw+i9BYazW
         TJmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXcouyitC4gU22GA8or4Q0kWYPNNjXbCREDljqX2ucDDl/ly09KDgryTI6ElnSqeq8JIiSvqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEzk6nfhgcKaCTErgsqUVYK98gK4iVNP0xXoYrheom1XSw479h
	7HgFUeCwbrkrb2imVuFKsf9dAgyO23FAhPbbJEAzPdJBinnol5KsrVH2sGAMN4XLnolELK31L61
	KAFaGa6wJdnulC0nP15iCsvgIsPloGBg=
X-Gm-Gg: ASbGncsLGp5B7K6O7N8LbLciSf4tl8eY4opvErBcQe6ZXEqpwi1xFLYcfusrzW+VymR
	iEmoJQQhfoJmmKcvdbmOKq9VcJkmgxSB90xdy4MwJ3Gl2NZ+meet/29OyXqNGuy6su/i3OmACmF
	SMKFEXMPTd48iJiwzJhvBP+t9K6BTaotTiqVbQormWLeehsX6/shZpOt/LSyVV1nVXtBNjXO77R
	Fpvj5A=
X-Google-Smtp-Source: AGHT+IG9JrN49qNUiyegLZpH/D0VV+j0N8iJebQ7aOeIaJkcoPiWmOUWEj05QDCe47ehKkfz7tl9BWuhimy8a4NTG48=
X-Received: by 2002:a05:6e02:12ca:b0:3f6:61ef:4b6c with SMTP id
 e9e14a558f8ab-3f661ef4d21mr68860655ab.10.1756966870123; Wed, 03 Sep 2025
 23:21:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903084720.1168904-1-edumazet@google.com> <20250903084720.1168904-3-edumazet@google.com>
In-Reply-To: <20250903084720.1168904-3-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 4 Sep 2025 14:20:34 +0800
X-Gm-Features: Ac12FXz3Ikia1hoaPROLgbVhPh-M6JgORXA8jIxM8JHcomSa2ZIffLYbUuy_dt8
Message-ID: <CAL+tcoDLLknDrzbiStcPH+Wwniv1W1eRVBWLo59KdyJVxNaXvA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] selftests/net: packetdrill: add tcp_close_no_rst.pkt
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 4:47=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> This test makes sure we do send a FIN on close()
> if the receive queue contains data that was consumed.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Thanks for spotting this interesting case.

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

