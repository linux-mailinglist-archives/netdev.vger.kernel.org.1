Return-Path: <netdev+bounces-218071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C804CB3B05D
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38C6583109
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 01:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4500213A86C;
	Fri, 29 Aug 2025 01:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rLRF0Fri"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09733FE7
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 01:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430551; cv=none; b=kOrOFHVvKK7Dixs+p89WRHxI6woUWR1HL/KXYsSnFofkOxvP2kQslnIkhjMUhCTLLff1TlNlo1nq4DCf1D+OeyVvxmAUCbPayX9IiE7cePgYdYvQZDYVfBQbdH7UMZ1f+IGMngB5hV4hTmdvyDTx9Hidaaf/XXlMjlcPCNbwANc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430551; c=relaxed/simple;
	bh=odO0BurKDKJS6dJLAUCeXUpzXULQTjuf/Oy5jIKVG3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+pkYUEiOJ09fXfJgLPSZZ6R+82fI1Rb+R9lbdzBgnJIXnF25EYpK3xi261tvl3q40+RliYea55GJV+5+ZV1AUGd0bfr6JHRjrGDEtcUryNQn++5/FsjIIXijaocCumJktO37gqyaLawTnGARUccQsbbTgpMF+PI0Bk3SrVcOLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rLRF0Fri; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-248a638dbbeso14296215ad.2
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 18:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756430548; x=1757035348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odO0BurKDKJS6dJLAUCeXUpzXULQTjuf/Oy5jIKVG3Y=;
        b=rLRF0FriqYxGTOgtJ5gACHYB+fA/XXKJGAGXRkGh+P1e9GmGPsCahRWxKt7QioTMuj
         0GvRSvfYkkRZY0PF7YFVrgIu2TzsxGKCarjOlE21igsva4IQaZzK3mQmkoki7ViE9imI
         k2oQL74iD6JMaE+LC3F3N3xjbl3ldS9WG8oeUfDlsRx1FrOh0xFznHECiyW7A3mF39v2
         yz8mniOxGcwv7dlR236zq1dYrM6GVtX52Co6SevxJviE8N4Wqafa82f1qKWhYpHIiTjt
         g86VzADQdReN/acgpxt6Novnd3OKAdEs4yBbiGuqPzPlqrS1rZ2kaPVcabaWgNSOAsLc
         rTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756430548; x=1757035348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odO0BurKDKJS6dJLAUCeXUpzXULQTjuf/Oy5jIKVG3Y=;
        b=i0MQ548u3/7LVwC8XHulTWy3r3tsfWnmAE/ABHHbIw2RfZ0K8e0n8f54mjZ8QS9B2m
         smg8WehnWdevSW6rrXDWNvClMAkBUVY2Q0jL0r6DTWTQyK9m8C9733x7sVzI9zIIxLwT
         L1tQBUYyL7FYaQOXFwSeL92Vzt7uePKixcFxPOkv4jsm4MzyHawOpYnA+xqoAXrrta+2
         6HUBsQ2pagx3HAZ6LrRwJyoAj+IRJYghtmU25xJODE/7PLBH9D5nFNpmq9Ebx8ZqUY4N
         lMj96jriVFa21J3+egfHo3CCZPuw5sOCJp/d2NOiK//KmBG0QE7yXx6LPjMiaZRfD6db
         FMQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUYpePB+mhxHczlAt9JO9a1cqqYQTbSLRXqIrBlUAR0EXuiH7rmd5RPtPwuo76Hk5wBkPIDAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdk1/BAF+fm8nO1Mo85UH4hXF7+PQxoSQG5ZgEGgUuj2vjkevT
	yeRZC3tvHJjVd3hNMLrA8u1knVTG+gqwfPjS95ulYgO/DljigVL3hFAni9nU5SIrsrbEBTLFqRv
	v1/Lmmy8xJtkrds77hpQapcoN2aSQpYPsqPON/uz7
X-Gm-Gg: ASbGncvABskKFWmnioigsn0dimUSoqgcsJZh+2hCFITLYaKNiwvy6YORDMGR0W5LhCX
	EUzFx5aKlr0Iht47YZ3WElV52X694AmLZLf/k90hSM6nbTyxhSWpWG0DNECtmTL8byizkOfWOFI
	ZwenwT0KQdc1EQ0DnrmYA2AF+JDB4ZGsHr8CAycLmCeoKRHMzE3EZ5VIZrSrXgvICkrLbevoLD0
	8lVYVqjaDkMoLeBBEvUztdr/wF5rjv4RcbYTgSkq8zrwep8SQgqHQ7+ljEK081UmqvG6h9tk9f/
	ECs=
X-Google-Smtp-Source: AGHT+IHjXgA/kYL8H3AGLTxqgqB0qGfGOIFpQHPMccGcuNzovC0KDbvBTy2ww7rKi0/LyAsxOdXk5swnJVUILJgjOqg=
X-Received: by 2002:a17:903:2c05:b0:248:d646:b99b with SMTP id
 d9443c01a7336-248d646bbb2mr73223215ad.43.1756430547943; Thu, 28 Aug 2025
 18:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828102738.2065992-1-edumazet@google.com> <20250828102738.2065992-5-edumazet@google.com>
In-Reply-To: <20250828102738.2065992-5-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 28 Aug 2025 18:22:16 -0700
X-Gm-Features: Ac12FXwraFWrAmJmioR_g3gYpAQGyjv6z8mVWeLWatJ2kP4qymWkeLJeAYvYN7E
Message-ID: <CAAVpQUD9jzRKZTScxy+ObQo8eBy19xFD5pURQaR2AcpqVDLbrg@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] inet_diag: change inet_diag_bc_sk() first argument
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
> We want to have access to the inet_diag_dump_data structure
> in the following patch.
>
> This patch removes duplication in callers.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

