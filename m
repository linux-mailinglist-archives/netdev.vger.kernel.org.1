Return-Path: <netdev+bounces-219706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF986B42BD6
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 23:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58AB71BC6FEB
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 21:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6742EB5AB;
	Wed,  3 Sep 2025 21:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LAMjJzOa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0C71F2371
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756934761; cv=none; b=H01qkRSd+BuARZvBYjOykiDd1b8lB0nPLaNkCK7cSL+P2Uve0r4nlLWFNwe4vbrHWdo2lPjFVcaGKSWqPvJFP/Pk8niW/nDIDWseIuWeYKLymO94V1drwBQXoW11TX7326wPNW+hmZ0nUeS5RgeuOdsriNqO49KQZ/r+9C3Vaoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756934761; c=relaxed/simple;
	bh=jyHBAuDVftkRx0HBy4T7ggJt08EctxvHcJYcUPC2i88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ErsXOu/K1H+ACoq3cBD9eGn149RNhb5N+VGE78OPK38KdIIqgEJMlaffbooi0iA4M5hmcUj5wbhfxLoXjgBAhh9H5llII6DZTTjGjRc33a7/WquqNiQoRNWCV6mJaA4VfRwiL4K46gpBQ211mRSFOlCCdoYK3x/c8fJScM9xsKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LAMjJzOa; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-248df8d82e2so4070045ad.3
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 14:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756934759; x=1757539559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xEQt+L8Ho3n2dPxDKsBxoMXt7ItKZIAEGKvH+NsNm8=;
        b=LAMjJzOaIqEdVaPpci6dJE/0TNuTZsAGTvvMEQIjmvg8KcLsUhZh+FMYJwrA9WQOX/
         +kity5DCNVeabDifZU5MY17qNmUIxjY6Ph1l93uSbnUH3OXi2DazexyDePyNgK0ZKGzI
         K2aF6QOFHvE9+LVYzQ/pC2+wVQrutGlsMFTORYfLwywOGps7blAP7X0Zzq15BjjamH8A
         q+gopzWwI609s2g2CXKNprhdnMSX9oc4CXO+c4piuECJL7r/5T4CutbNfnmbzB1bkw6/
         mGKEQnhCIz6gDW+VARtxIr2qijWAU6rUvmJ6oYcBIzTEwJ6Gzdcgrm93e8nOrwrsSbeP
         5ADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756934759; x=1757539559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xEQt+L8Ho3n2dPxDKsBxoMXt7ItKZIAEGKvH+NsNm8=;
        b=irFwNeJd/20fftFSQ4Blz3g3mCXStj6dChpWmN/DR/g54K4d8P3xDMVb2UTkhVS4/p
         ACkvf68sixFM/CzbMP0wc+uM+62B7Xll43Otgpe1cI1NSFBw2Z0h7h59cxL9UjqUqkWV
         Z2ZGx/39cnZUTpBMc5pYsusKjFPKSqPlmfYo8w21f6OlThbvWwnwENy5cijojtWzGJOZ
         ic5YTvBKzYpJ7j8CPaff1eCbQGH/axMiGu5PTuyLGMBVeX61uyAB/rP0TQ3bUlwQ7EAz
         cstERa2qQf1++3bJbz7NtdrqTGypwQOIQizg84tR0OcvX4AqJG/N0EqjdtTLUO2Tpbgm
         4upA==
X-Forwarded-Encrypted: i=1; AJvYcCUjnW6NeRuX93U7okOaobUbsrYvwWRjVEVEe3jO9FJz/aZ+VkrnWDJbtAj3oi6NzrLWrlnwlCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAuh7ChVw1vfRAZVjK+4EWdhOgNHXjtsW5ESl6l4oYIRrb1lh2
	AU6Q2Hm5x70wTY10fVQpqroB9X/RqT5fL+xmGR5pLt9PJUyaipo/uFmCl6Lry1hkQstDyZ6txDE
	sYdXbXc4YhzOpgraHvPz1BvjzrRiqHzHbfHhjwFKF
X-Gm-Gg: ASbGncs86mfth0Wx1EMeKjUWCTojXnRE00P4ufnyt94VMhC+YJ5wdYjOYcC8mNVCtEg
	PLUvkbknKMZb4rHrjR0YLjRIMzgbvqtZHjDZ8pPZGEpeT/rU4WktKWmmB5VabRj72iHspZM7qCp
	rU9X1CNVhsl2+A49X7D3PimRzjcY6I+j2Er2VKb+CaODOFjPOsDXvkrtIV+Qi5ZeE+jHHDFh2sD
	iypEcjFO+OTIAtvGCum2L9xz3yvJrrOTmf9biOcLQRuiLIU4iLoQ4QH63KB9uDS8JREUcLfYkJh
	J4TRQhWzrAs=
X-Google-Smtp-Source: AGHT+IHRfpHto8LlfSXKfbZf0SFWi7fFWtwcv3b9CN/dPfI2rbOx8GpveZ1gaLb8oE0c41ec9Cq4gRO9FlgchlHavYg=
X-Received: by 2002:a17:903:ac8:b0:248:75da:f791 with SMTP id
 d9443c01a7336-24944aed0c1mr217213335ad.47.1756934759252; Wed, 03 Sep 2025
 14:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-b4-tcp-ao-md5-rst-finwait2-v4-0-ef3a9eec3ef3@arista.com> <20250903-b4-tcp-ao-md5-rst-finwait2-v4-2-ef3a9eec3ef3@arista.com>
In-Reply-To: <20250903-b4-tcp-ao-md5-rst-finwait2-v4-2-ef3a9eec3ef3@arista.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 3 Sep 2025 14:25:47 -0700
X-Gm-Features: Ac12FXz2G10zJlTs9-Is9rvwM0S7wxPXm9bN1bbgkTiJ4ZOjmq8xmatzEdvjbDs
Message-ID: <CAAVpQUCiaQ7yr+5xLYVaRp6E2pzNDwSiznEOkmd5wS-SAosUng@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] tcp: Free TCP-AO/TCP-MD5 info/keys
 without RCU
To: dima@arista.com
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bob Gilligan <gilligan@arista.com>, Salam Noureddine <noureddine@arista.com>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 1:30=E2=80=AFPM Dmitry Safonov via B4 Relay
<devnull+dima.arista.com@kernel.org> wrote:
>
> From: Dmitry Safonov <dima@arista.com>
>
> Now that the destruction of info/keys is delayed until the socket
> destructor, it's safe to use kfree() without an RCU callback.
> As either socket was yet in TCP_CLOSE state or the socket refcounter is

Why either ?  Maybe I'm missing but is there a path where
->unhash() is called without changing the state to TCP_CLOSE ?


> zero and no one can discover it anymore, it's safe to release memory
> straight away.
> Similar thing was possible for twsk already.
>
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Change itself looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

