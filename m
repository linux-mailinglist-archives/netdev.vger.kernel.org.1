Return-Path: <netdev+bounces-217616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F20B3947C
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA861796E9
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 07:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5192877E2;
	Thu, 28 Aug 2025 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p3WexPG/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC432A1AA
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 07:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364518; cv=none; b=g6RsExeHbwydGU7h6l+JlCg9yeEL29T+L3UmQ4LTu3KJkfdCSkP2O1Zlg2yonNPo/bGWOG1gl4LgrYKODJeyH7svzlV366xevNFQN3Zhhb2DglL67C9b9XeU4wsoJC3H5PeL9O9nLgC2eSGOmr2JtJ9PHbKaRE6TMD3qqfOwbSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364518; c=relaxed/simple;
	bh=x8bkbcL8+tGdys6jSOuE1Hg0Fct7/lC8B1m1J0kB+9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EkZe4KmgwjtHSbM/A6JrT0ZixMLB/NPO0Tg/hnWTzRSL9Nztg0YS4lSMwQcReYoDRl26pyJwXVn7YcV1tQdAS8ijewV6Ggv5gPIceAbvXzS8fTG7aSDl+u2tTwmGfnic68fbxZEC1LR7V6brvHkRDGTOBQS424ElM8YsXwyk5vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p3WexPG/; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b109c4af9eso5106681cf.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 00:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756364515; x=1756969315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UM7DhkEHuk4qSj2m07G7Dl4USkQpCM4utkZ1N2+QBlk=;
        b=p3WexPG/Q8gaSfPUix1wAcrd3kH4zTMhhvIIq/TEZ2Tf9xE2PC6a+4XXxMSQMG+pCe
         WTJrKz/C2z7EYaSh8XpCf9SVYfYeVRjPQuRVsJ6b8wlf8myfv0CDGll1F5K+JtM6wmtn
         iT6jkyxL+ku6ZPHMo2IO6DiNcZ2njPxEZoH7DTqBohvZZhsHEtJKJuadJRwJOQuzXu+u
         T3WvaSxsE/LHVZ3sBWJodRqZAlCwTM6iE05Mq8nkELQ6WcCEoDv1I2HXPqSGmp8pzXyh
         2/sC++uhKx1aVRO7iCmHVsCZJ6RqayJxmVk+CGbrlO12ijdP68qJ2OzpOPgbTmBF57Za
         JL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756364515; x=1756969315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UM7DhkEHuk4qSj2m07G7Dl4USkQpCM4utkZ1N2+QBlk=;
        b=KGqJ4YsJNqHfzAhRe0+4TfhT+Uv0BhT7uQSksp848GB2PRKhk07EkE84Brj8Qfdqn8
         nZDAScyrl6Qo+pk7vEUULfFXckItxzWCN3WYXp5t2oNf2QJfZbvxVZ9/M5S86URXAezs
         govLWSf4+hhHQsJr6GtoFfbqI1D33xwARYlmpCZBqkQZepOTuUwmMdw1xYFjTMdehnPe
         Gf6yPlaC1lIUwNllmaiIJEq10eV1hxkX2UIh+CjD+q42/vHQy5hPFuw9P/1kN6iv1qBJ
         w6S03YNmpRWU+PTKAAvPaS4xM4Mdu4/6WEcK0EaQYKeQLy4viU0+IXEMUD+Pfsqs++o8
         eQ1A==
X-Forwarded-Encrypted: i=1; AJvYcCXHUWVpKvoOfBX3k2/E7KrGfw11XkqeTb/xDK+fj0MZfHVqnfT5OJ3bHqEXvUTZOpGYCCXfW1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYGOPwTi7D4/1iyeFCffiQlD2C8DgW1nECS3k5By44dWnMR5nU
	JBHL4rbgRRCd29j5h8k9CkhWfgEqLV5qiWM4K7zf+CmAIghUo1GmcjLiSuGV/SQlTNf/rUiM2Cj
	neCw8llSopafhI8OLVoaxW+IrMpc3cVS4zW1IcdEF
X-Gm-Gg: ASbGncuIKFyPeEDFEW1oOZwAY9uqXHXm4wNTU6FlmF505t5MwdrUQ3RGH9Di/3f0y0a
	h3dl1k22KjLuz0v5hllHsdiJqhVVuGgjKKsavbgJ5u7S0LDKbLWl5/OgcejFRdGoAIedVuPsjPG
	jd7WDEB/GpA7RHhoNAHTMaflmkHbYstHvYuv2JH2u0nDYnV8H7ju7Fg4hgExwjnHUCmT1IHdDZV
	X+g4tFtd78=
X-Google-Smtp-Source: AGHT+IHBVxWxWSHO+aK5wpbDFa+mZB5wQcUM810HgKp52eoaZy7vbiDehRSg8/y4lSbH1rCe1G5yO/bjvIOteA5XlAE=
X-Received: by 2002:a05:622a:995:b0:4b1:4fd:2752 with SMTP id
 d75a77b69052e-4b2aab44efdmr304122441cf.58.1756364515219; Thu, 28 Aug 2025
 00:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828012018.15922-1-dqfext@gmail.com>
In-Reply-To: <20250828012018.15922-1-dqfext@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 28 Aug 2025 00:01:44 -0700
X-Gm-Features: Ac12FXyrxU3v8TM23-pL8tHyMIrcYye69o8X_1GZcfqchraqv_my8wEdCPDPvGI
Message-ID: <CANn89i+WjMR7kcGkaQvF5YaCiZxa6txMyQvvVQf8rcU7_u9_JA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] pppoe: remove rwlock usage
To: Qingfang Deng <dqfext@gmail.com>
Cc: Michal Ostrowski <mostrows@earthlink.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 6:20=E2=80=AFPM Qingfang Deng <dqfext@gmail.com> wr=
ote:
>
> Like ppp_generic.c, convert the PPPoE socket hash table to use RCU for
> lookups and a spinlock for updates. This removes rwlock usage and allows
> lockless readers on the fast path.
>
> - Mark hash table and list pointers as __rcu.
> - Use spin_lock() to protect writers.
> - Readers use rcu_dereference() under rcu_read_lock(). All known callers
>   of get_item() already hold the RCU read lock, so no additional locking
>   is needed.
> - get_item() now uses refcount_inc_not_zero() instead of sock_hold() to
>   safely take a reference. This prevents crashes if a socket is already
>   in the process of being freed (sk_refcnt =3D=3D 0).
> - Set SOCK_RCU_FREE to defer socket freeing until after an RCU grace
>   period.
> - Move skb_queue_purge() into sk_destruct callback to ensure purge
>   happens after an RCU grace period.
>
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

