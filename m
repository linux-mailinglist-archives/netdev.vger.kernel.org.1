Return-Path: <netdev+bounces-163708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8957CA2B677
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4419188997D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017AF1EA7F6;
	Thu,  6 Feb 2025 23:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4Fe/Zmn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BC422FF3A
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 23:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738883584; cv=none; b=ritTUp9BQhWlYeXPC0nuBFzoD7zU3B13ogLhBzFJqsGEqBmVxCTvwQqkAveKDMibHwTiayKQX+cZDY9weMyYqUt2XWjbcMIqLWbNJkiPBEKp5XBaWxjbY/yzMoXmUq6Utbq5F7L5NbZxQA4Ad9mtoUL2N7CnGlsbpIETvd9i25g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738883584; c=relaxed/simple;
	bh=pxQkcgzoqUdCw+TJyVxn3vNH3fKJsheDOZ1JZe3YhFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkW7kAGnVq8EuwCTGx4DTdQ/nXUvJh9ztZIQZQ5dj6yk86Ij8wnHXHp6NpvfiGKApVEGGwd6LdZ7Ln9WauXLI/G6HLk8U0kpe8OZaboS8OOJKu34RSMU0oFx850LngF/gVi2l6bGK8IncWX+u1W1GN9GSMO5l2QgvaL/+yS5048=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C4Fe/Zmn; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f032484d4so60005ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 15:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738883582; x=1739488382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxQkcgzoqUdCw+TJyVxn3vNH3fKJsheDOZ1JZe3YhFE=;
        b=C4Fe/Zmn6sBRZMSWHriNlYGDMqUbMqim2ZYNjdbj4K8uhf9KcSfx5V+G49pMjGFBYQ
         Fo74LmwgCdRuSMh6n46UT3DZxGBKg/lBnmW9uQKi0vzcnPcUpo1JKUQ4dVrxZNLcC7vq
         dklcgRNbAtBEw1ukxhQHjy8VCg6q5E0OPZPEGvxas4c7wVtLSJgCztExQ5T2Ro+VNAXF
         YJoa5DKY5NDvSOXdZtE9PCiYac9JyQjs6flsAcS3vZkvId/I+PdMgw75s/edpdBxkmHz
         A2Ncg/HXjgtD2GBGwMkBUD3bemlJW8rdXrjWKypCxidNmdqxgfcHt6KgdydS5S4wxTGF
         e28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738883582; x=1739488382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxQkcgzoqUdCw+TJyVxn3vNH3fKJsheDOZ1JZe3YhFE=;
        b=nXTvbaTcnI72Dz0USeceqKT3DkT2YtawzFbKkHm5TvNhhswLBkgkLpwcs5HdvZDjn+
         6HayzKJhzKPJik5wsKtDjlqtmnorqhDDmuYmvzQl41Ts3wr8KxYXnP+dvSG1m7GHkWce
         Otgx8Fvn5pYVcBrz/Q2tOCgic8gR6UjjD2HpiP2eIPOomyMmQGpMw4Bw6WPq3n1TuLaE
         oSfmIX51kVY9peUiRtCMaYCNo3x17cK9jpaHWpOOASId7/6hYJJ6mK0FKYOAcVBFR3vI
         SB0Mf6B/A2ta7OmhoiJ5nIXb/RSM2XV9Xwtdy/G6JTprUW4rB/JV1SPVrYNGAdfF0+wV
         wkTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVupZcM/Zvh14yc8j8EWurRyr98IOmOaTLGCwQ+SZ5AB71j68XrqAMNGu5FpGnGg6+jF/rW0Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcU5+TpfqCy8e3dcn1bCI77OkK0C+6xHUdOYpCjYzm1DR5ED5W
	BwdNzQtGWqUyI61Qk6gaA4/cTYuWArppmR1R9vW8IOyFK+3J5FLh+T8SLR4m6dDkYacHRK6wUGk
	PEKAiQpaBVXw2PyAD4n0DxyKP2LSDBr7QP7wS
X-Gm-Gg: ASbGncv/leaWzpdyXYIQLoMd3zwNVrTUJ/xNjVfEbbATR8Gkw8OJhLWSRacLJBJW8qy
	BqiBngP0TDa+mMBZiLXuLyEpCV2P7P2WwqnvB6dEXPYM20o4XXtAoV2n/cjMcRm0GArfQ49Gh
X-Google-Smtp-Source: AGHT+IHEu+5Q3psaE67vnhQPwq4PnyR/Vs4uGcf25XBu1lmUzZzm26p0zbd7m68h/lcu8YXBGyf5iemjV9/5Qe0mnPE=
X-Received: by 2002:a17:902:7488:b0:216:48d4:b3a8 with SMTP id
 d9443c01a7336-21f4edb2ab8mr936375ad.16.1738883582410; Thu, 06 Feb 2025
 15:13:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206225638.1387810-1-kuba@kernel.org> <20250206225638.1387810-3-kuba@kernel.org>
In-Reply-To: <20250206225638.1387810-3-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 6 Feb 2025 15:12:49 -0800
X-Gm-Features: AWEUYZlsGicrzd5UkZYbDidTbNjTVs7p1IyMAiofpYM7hArFqsNcCeVMjFWlqyE
Message-ID: <CAHS8izMLUEezD74akqzae0LGFRkwUxnxgXMLUd0GThJK6LmSnw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/4] net: devmem: don't call queue stop /
 start when the interface is down
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 2:56=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> We seem to be missing a netif_running() check from the devmem
> installation path. Starting a queue on a stopped device makes
> no sense. We still want to be able to allocate the memory, just
> to test that the device is indeed setting up the page pools
> in a memory provider compatible way.
>

Gah, I think I made a suggestion on v1 that would have broken this
check. We do indeed need to make the driver calls, if only for the
check that the driver the memory provider enabled pool.

> This is not a bug fix, because existing drivers check if
> the interface is down as part of the ops. But new drivers
> shouldn't have to do this, as long as they can correctly
> alloc/free while down.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

