Return-Path: <netdev+bounces-202000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBED2AEBE9C
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 19:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079474A5D86
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 17:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4442EAB85;
	Fri, 27 Jun 2025 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0CSBtyGw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D672EA148
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751046729; cv=none; b=kklp4upoykaPoMcaVsYIXe2T8aV5/YBRjZDalnvfdSYPIaF7UFkwA0yRQZ4jIQBfrbkG6E9hwQh5FhF7Kjap5JojPcN+6OwMxwH7o0ztHB9JSE2DuEMqHFMX1n9M7g9D5ah5XWl21W9wjCYWl/T6EKS9KSqFFsxJcXdDqpy+SCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751046729; c=relaxed/simple;
	bh=dnrAWTPyTlLa1kZjQaQmWIcSAusQR2HZtx15gDk4XgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tb+EbwWBnEB7DfruYveK00nd64MJcjkMsYvFtSdMrXcWqeyRUmS/ah2eLlM1KylSkb2chmu8rKNzPPd8sdoOezSUiJyHfaYrRRa0Bgr5/IhY4k/A31P3RJf4ph8p/ZACx8kMHNggNGlY43zMIloMGgPdpsJiB7ovAjcOPXIyc5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0CSBtyGw; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b34a71d9208so166425a12.3
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 10:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751046726; x=1751651526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnrAWTPyTlLa1kZjQaQmWIcSAusQR2HZtx15gDk4XgE=;
        b=0CSBtyGwi8b3VjzyvDFZWUUF29zkHlmcTlZMkgiSp7w/X5baKRbEvkh8PgCB6t2vQg
         RKC2D6dJvaSnX1vL76ocwM0nfh9PT6sjJkowRZhO3aDyXKH8SzFP7CsGcNwwr6rFStjS
         DhXwgvYXrjOVTeIf+C7AUF1pQOx9LKCbMAdUgXsRQzo41zXZKfHaLL7SjmsoTtZdYQcc
         JmGucUK+NwIp58+IgY/Gb1er/5Gu+vTcabtzF6Cruahlh/OqjcfgKzKla2xAEQCoong7
         3rtXcQdKodBpxIClSGGGPyaavcpXSCmsuxdiQa1He0hE74hYhEk1VWO6BI/GJGaWCtKS
         ZtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751046726; x=1751651526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnrAWTPyTlLa1kZjQaQmWIcSAusQR2HZtx15gDk4XgE=;
        b=l5KhVQyQscsFKMeqrS0WM6O9e17DA1+ifl5/qGDBgUvh8AFxvlJknWNN4j+qITI5uY
         IhHHfZhBKlUMCquC4oFlFWmOrGtwJdIUQQWNLqnPMpLHt6mWW1gISX6xaMcPr3d/SxpF
         M7xSDUpdBMfa9EKlD+R37gOA6r2PN/ICmOiv2r5MukE3nraHIGmvEcQXuzlkJKzHB7EM
         603QCTdVRRExvvHhlv3By0+hmAYqoPr8ZV55xG7Bp/OrFe1RA0BRL3zkd9nzJ+YrfsCf
         Tlz815Xs/pynorw1kSGlsJNunZMczrQiYGC4MGyvqbUoEdKP0WFJx8Uvy6BwwE+KCCY8
         WOcA==
X-Forwarded-Encrypted: i=1; AJvYcCVzcNUuuI6E8I+WB1sgQzBjvoCoJ7FHL9ddaPXoJsMWhe4Ada2+zWD9orMN7ukQfY30ADdrdaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWS2HvLmed3Nqa5V56Gx0BGcKx1Vv1EZDV9462bzwbWhpbakwk
	rOoGkr4wNlK0xilTWBBrJl/I1Fn+Axpm5H5veFepe/7L84+z5vwM/T7vrBo+L9d2oLFYCo1SDXx
	0HMuPTnYn5CRWvZsHv06JkC66mKzP630kRtkO56YLmx+6SjjZPI+4FVfuW3k=
X-Gm-Gg: ASbGncu5ZcL5IS++euEJ8cZyo7ge9IuDF7xcWQJHhy8DLOkKL1dm9YNj4g3mjJlDVy4
	fxElT2mbqBqPsINkzvFqgMPjSDd3rkNUc2NYMsxeqHjogLDyuuCfT+koMNnL6Xuv7/MOnnSWuID
	qmF7gRJJeXmphY7/QJjJSfjweTqbjLKcSuikeNBzGwRSKLa014FA8e47KbS5hIdTmlpMVRPSkLG
	g==
X-Google-Smtp-Source: AGHT+IEIlnErc6+CFc8E+cMlUs1MJs9s+oPPgH3yPHlngL89AAuof/hrxElf8aKo01K7foUwLbA+t5J+CoYZQDVX/yA=
X-Received: by 2002:a17:90b:2ecd:b0:312:f0d0:bb0 with SMTP id
 98e67ed59e1d1-318c9225deamr7397537a91.12.1751046725867; Fri, 27 Jun 2025
 10:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627112526.3615031-1-edumazet@google.com> <20250627112526.3615031-5-edumazet@google.com>
In-Reply-To: <20250627112526.3615031-5-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 27 Jun 2025 10:51:53 -0700
X-Gm-Features: Ac12FXzvagQBOh6JtkPjhaDkKEgMHXByIc31nXURuFgMUWqjWzPUhoiJ5bH5rsQ
Message-ID: <CAAVpQUCB+7F4rFffLXwzy9808bg6fwaR4mj=BsUtC10r=x7z2w@mail.gmail.com>
Subject: Re: [PATCH net-next 04/10] net: dst: annotate data-races around dst->input
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 4:25=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> dst_dev_put() can overwrite dst->input while other
> cpus might read this field (for instance from dst_input())
>
> Add READ_ONCE()/WRITE_ONCE() annotations to suppress
> potential issues.
>
> We will likely need full RCU protection later.
>
> Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

