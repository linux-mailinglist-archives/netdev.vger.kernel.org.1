Return-Path: <netdev+bounces-132731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F654992E8C
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EED728513F
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0665F1D54D4;
	Mon,  7 Oct 2024 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ql+DjMDb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491C71D47C0
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310423; cv=none; b=NwrGBabK01hl5eaWNXxY/4aBCZhotTt8r9VxqGfKEFHyT2Ky7MLNveF0nAluhl7o4xvOGCk6ESbH86UvlJ5MHvzzLLwKhu0zdfS8SkNNGNbTnirommbfv87fcWeyNaRtaqrQRAetNtiVYqXlk6UveBRxUtrIyLz7j1Lxz7SnW4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310423; c=relaxed/simple;
	bh=q379aEkayzsYq4NQExWCrVM7YFa2t7YzYvpB5khV7kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h97gGtLHNyiKaAvbmR0uXW6q/skuO//eyPFv5CThwEVyYue4T1kq4ZOcT863nWU5I4tezuwj2+fSbzXYCfAbwHeZ0Ue+mOLVwjsOzQ+SJ2i9n05UDJo3XJtULcjhIdpQQZxHQ1iDNCi4uYBAlfYCVZONcex0P8ewuAEBBjO7c+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ql+DjMDb; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c88e6926e5so5230496a12.3
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 07:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728310420; x=1728915220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q379aEkayzsYq4NQExWCrVM7YFa2t7YzYvpB5khV7kA=;
        b=Ql+DjMDbM/dP4ZTbhh+e8TjxJUU73iNgy0/j84w4oeynZFNDhskNOHZCR1I40oe2+C
         5hZPFmLbKH1yYmP6On+/Ah6BV1UFa+Qv2vcfPuFWJGykh62nM/H0wYbIxhoDV17EBzKq
         1fmA2krSVpHL2QnB0ReBXSkMxXxOsOnKvdaMhcMdEooto4Mv8brzfb1VSsfF4fgjVvp1
         qBYyN2crwiAreCJUeIjkdvUxZ2rbGBUz1JQX0mj0sxoT8ewfvuJH6IfNIbpZGl3cn35e
         sNMJHFL77ef1aJRzMG+kmz/qw0wuap24YTSiseTA1AtD6YkQ80aolMuYJmM/4UsYAZ8T
         d5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310420; x=1728915220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q379aEkayzsYq4NQExWCrVM7YFa2t7YzYvpB5khV7kA=;
        b=waJhovUerdi4hiI4IsuIjuuXRVAouIwplg7c2+hS1WJQbiXIe9a1pua2NU5NeJEYJk
         874go40YXCjDkDkkXB4nRRJtG03fh2CV0IwlPnWgy9EsyDjdUmEkueZTklLfQgwr3xKM
         6B/HMGrUSDPfGDUd/ppDLGmmgR1BayaJu38FRfuNRJhQqjS+Chb/Fn5MacabDU4jFc2D
         Gp3VSoSzb5rZNDQCR77hsUUe+1MVFDSn5A+sREwBSv89DYe5DZaG45nosspIDHzvszcf
         pMRIuO26AzPG6WXXi/m358LudwNNBV+UoA2gPbfpF1wv6vj+m4wD0gb44wLbo8Y7CKRj
         +5GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXycLJ/fk8IOp+E9z1VxZuj8Mjh8vP9ceOx48As+Iu5VIu2DNi625D7qDlq7uMkj8fIUz0jv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+9bOmZ/51f2yC4w01LGu+AOSGu2MXISP9Xi5lQBBH1LlVvmgb
	QYXO8M6/GvBm6TSDapoF+yGgfvQFSpOmZiLESNNC5LISUlrWoBDC1r9sA59coPQAlstRoveGpG0
	mpXe/U+mRiwaCuZqLDtY7UrBYd5rLpzc8HCr4
X-Google-Smtp-Source: AGHT+IHWLIoE4kM8tqNyCWLF7xSxDNjC5oYm3E3o4gENIuty1xvAZa9wJekJ8nu+UXh/TUF7UzK+Rc1B0rjAiVAEzWY=
X-Received: by 2002:a05:6402:4009:b0:5a2:68a2:ae57 with SMTP id
 4fb4d7f45d1cf-5c8d2ea0862mr8924092a12.31.1728310420157; Mon, 07 Oct 2024
 07:13:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004134720.579244-1-edumazet@google.com> <20241004134720.579244-5-edumazet@google.com>
 <20241007140850.GC32733@kernel.org>
In-Reply-To: <20241007140850.GC32733@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Oct 2024 16:13:27 +0200
Message-ID: <CANn89iLuzunEmC_CkL7xaAEGYvJfUtgnTmEjfzPY46vYPFw9vg@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] ipv4: remove fib_info_devhash[]
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Alexandre Ferrieux <alexandre.ferrieux@orange.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 4:08=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:

> Hi Eric,
>
> A minor nit from my side: Kernel-doc should be updated for this new field=
.

Oh well, do we still carry kdoc for this gigantic structure ?

So many minor details adding a lot of noise for no benefit :/

