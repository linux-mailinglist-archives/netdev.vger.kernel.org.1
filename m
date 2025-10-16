Return-Path: <netdev+bounces-230069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6FFBE3882
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 14:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E33585D5A
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C5733438B;
	Thu, 16 Oct 2025 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="csgUewUt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACD2334381
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619389; cv=none; b=PG0XQxMji5SHe07GqolXjM+P6WR10jo8FB1J4HP3aETBstbwOPCNSjZZGrt3IoIhZ7L6oDJw5FMhUIb7PRKGQ/rKidany/j+x9k4nQF5dB9BIGuI5j6A3QFUlyNx5tqgK1ngPg9sIML7XNHBjJTsnaNod9qaAFBxWvidvRG4MTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619389; c=relaxed/simple;
	bh=AQFACMSOZqDLF5yVgb772SY0kn8MNC0ek9D3kdz//oQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtqKGWNchwslVaTUvrh193LSztQU0ps8zjwF2bI8rc2lkOc7TOEwG+aMCEhbuT5sauOsMftbkAV2alZVQH0FOtf9+bclZYHOaP1Jyo7b/Xat0kxp2NuOzDwrMvzhdstA7rzhIPYWByOo/FYSXCiTJkYSFeN6C7/6QHzTx1IKLCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=csgUewUt; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-7946137e7a2so13250756d6.0
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 05:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760619386; x=1761224186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQFACMSOZqDLF5yVgb772SY0kn8MNC0ek9D3kdz//oQ=;
        b=csgUewUttbwc9Fi2VZ9+spNf43Avs60iKmpxmpIiJkaHb/4LDFai1y+LE4icLocL03
         Dl+d+7RUmQJdn+K1rPNWNkPkvpn+JmTYUiKtKOMnptm3rb988oh8SqZOdSDEg8B6hEEF
         6Ks00RQ+bKnTNIjW1yXXcC6Wcvd++yKY3xsqk1ZCQJ1DlQGqBbQxNBcnHsryp9plI6xj
         UgQ4TIT0N5/wZKmm0TrpKhQ3CWDAjKzEtVNlWSUUrEiupeee015zUyFIduNYLVYqU2Oi
         bKBBYt0i2keC5ccTc4y7NH97QCJKAQwYTCLOWDmFsKirzn5cZ1+elRz6Spp2mN8Xnnuw
         dKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760619386; x=1761224186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQFACMSOZqDLF5yVgb772SY0kn8MNC0ek9D3kdz//oQ=;
        b=u2ZxoKfZNPdCT82Z4Q1aVqDyQqeeQkzoJK9CG/z/Zp1fSvdDtV+LF6ykm2QDdT0ByM
         daNUkBOlVHnhMc83OMWx0r6UjG2em2YHzDHY4KN7yWi7XY/iYMQCev3NUDXlwayIceXu
         89EGngI/gKgxB3+C74f6UHZEf+dkQvfyWbGULPYEjeXPyi/qTQ513N8AUZuC1Zziin+a
         9o0W2wCVs8pgMcBz3JJVs8fEBjcVCItYwnTlMxAvpf5nz5bqMc+1k3m5cYjEer+q3BVi
         Lyd4X4OvoHq20C08UCaRKuw6iEoKl9KJ/5J8wIfBJzSyDv0dblNcPYLI4pyFK5ASw0/m
         obDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvrsxXoYjskbik1T29nmbCcl8qzhBzOwpSOUsgrgx1WPyesnBNOS2PWoyjZaWxeH2JL0mTqpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn9fVzRV74nMtUK5KM0U+8c0m5Q82C263OZa0M+MZYBiu5iJyO
	aRPhZKaDfn3Cz8Y5Eh9R7Y1dAg/6QaAj6ERDcDZeeVrz7fZ+H60o1/pDfUEbBfl3tsjlDbWqQ1+
	exE2fE4Vj4Tcb7qPeiaGxUr6+7F9o9RY/3jX3HkI8
X-Gm-Gg: ASbGncsYU3aD0J28FGuN8qpxVXaNBtSi8CXxBVO01oVGU/lgxUlki98zBuzF6o5KAp4
	ssijCbnAp3Ocm19AnPA4ZWBG3Mr9qwzftbCV+OURTIylzVdUQaTaDq4RGAhOfS+OyfxIUcB/c/T
	/TtseQkeaS0vMHHIvPz2gbufY0hRqxbA6xj+gfrb9FLd7AMJR+zWdDrdFlPD0pS6V6oUuuFk2rQ
	Y7pfByHpOUn4ryR9TysgV86R2EOZ9wy9usJTVCclhEDXOsa5MaYYa2mfYDnH42UxWKEHSCOPBkn
	pRA=
X-Google-Smtp-Source: AGHT+IEIf96fIc0v82VOpajJsrRm/aaohs2E405khgkK1OaYq2OzYAXmH8Z6URhSxZZggj/WlBUz/sG/4VM6nA1pdHY=
X-Received: by 2002:a05:6214:5006:b0:795:7af3:6ffb with SMTP id
 6a1803df08f44-87b2f032de4mr478029846d6.63.1760619385685; Thu, 16 Oct 2025
 05:56:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015233801.2977044-1-edumazet@google.com> <e3ecac24-c216-47ac-92a6-657595031bee@intel.com>
 <CANn89i+birOC7FA9sVtGQNxqQvOGgrY3ychNns7g-uEdOu5p5w@mail.gmail.com> <73aeafc5-75eb-42dc-8f26-ca54dc7506da@intel.com>
In-Reply-To: <73aeafc5-75eb-42dc-8f26-ca54dc7506da@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 Oct 2025 05:56:14 -0700
X-Gm-Features: AS18NWDechlNadLa1aY2_jBhV1uOiNfO-T24cWCqgFgsq9sLynvUEwKziheiigA
Message-ID: <CANn89i+mnGg9WRCJG82fTRMtit+HWC0e7FrVmmC-JqNQEuDArw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: shrink napi_skb_cache_put()
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 4:08=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
>
> BTW doesn't napi_skb_cache_get() (inc. get_bulk()) suffer the same way?

Probably, like other calls to napi_skb_cache_put(()

No loop there, so I guess there is no big deal.

I was looking at napi_skb_cache_put() because there is a lack of NUMA aware=
ness,
and was curious to experiment with some strategies there.

