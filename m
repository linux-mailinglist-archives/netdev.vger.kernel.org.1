Return-Path: <netdev+bounces-224047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EB8B7FF03
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DF2627E42
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D8D288C12;
	Wed, 17 Sep 2025 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0HMgUqeq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B7B22A813
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118412; cv=none; b=cV8JVrozHBAz9tUG4AxGqFmIQPYbOh3jGoCPKo1Pn/xqFaHMFU5ci6xjGB67nroU4rLb0tjnC9Tp6Moukq5woSRdZc9eECaefS7ddfhWNQ79RPmnPE+mmwoF2Bq4wxt7v1UiaLl2PrQPQCL+Lyo6k9/reFer4LUVnftvewSBqwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118412; c=relaxed/simple;
	bh=/SgssRE7RhhdCzPPKiWmxmWCfc7JqmcAYiDDh9k9fqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQ7ohCX6v8ap3Ofdu/XXLD3YgGSHTmcgoOVmVRQuHgETkJERW9DK/7StYvOzrn71gLWU3ChfZljYPUZDwnf0Xl+ZoJh20oszZ+WZIhbV8EN4Ucl61xcZeXA42FvaV1j5DoKHkSAxHNFG1UwloUjqiswkQtmhpsgDMtSe1MEt/iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0HMgUqeq; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b5f3e06ba9so11419951cf.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 07:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758118410; x=1758723210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SgssRE7RhhdCzPPKiWmxmWCfc7JqmcAYiDDh9k9fqA=;
        b=0HMgUqeqtd3SuitBIot/78thDzEQ/B7yVyP8mKM6Tv5hgU0IRFUWlVatT0aOmt48WK
         dvZ9F+WvaCVTxVb5IUomuPsilm/NqXsH6gke1TCxlhfOyApYwRib+jqTr7u/2YvfuUCj
         lBzV5KyeBlAwPWlaHqbonawgOUe/rAO+Akfc6fI9VmAWD0OQC1xKSR7SzjOg8lYVfoU+
         /VMUZUFhT6gE4nN6s8dAgmoy/syFEIx9zoK+yrrO8EXyEMoQB754NGYJ7d3RNWOHr6o/
         1Jk7eFUaRqLxfR/aML1WDs19OTwJngjXT8guK5qTDs0/K70L+xrpXFnS/msiSPGUanWw
         0n0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758118410; x=1758723210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SgssRE7RhhdCzPPKiWmxmWCfc7JqmcAYiDDh9k9fqA=;
        b=Kds3JdU3YQiOJj1Nlu/DIIWJysTku4QHKBKiSeVNWFZZOPeGcbFRpr0Ett11X1F//f
         IgChblqKcPQHxQ3/O60+71ZTRIcDXUxb45GOfAIJFkFgmGeuOSxGmTdJ3MJqcL5Z009+
         21vg1jipnO8ns+KRfC/mJr3Lrdjes7f17TRWyA6zY+IT4J55wEi++zWgIwJpSc2ctENl
         fGZ1gB1TnGLOnIP/Rk+y8qCBLEMaOdhBSgPs3eaoKQBRftTZYRlabgYfIcGjnVZSwbAd
         wI1Z/Vr4VEI4MbNqIZybVeg9ii/9WGyOhcw8RvlCuNvoTocxdewuc0kDORVHqUktMDNj
         3Jqg==
X-Forwarded-Encrypted: i=1; AJvYcCXim5P/orCujWY8HmeRQzDgb6RSc4x35HX+qUXKus+BevCMBZXfoaJXU+FHIaW7DAXNDU2dTzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/eRdl4byu2RTX+BN810yWvCjv31oNZKR+ZrvCgthqUk8T9qSh
	MdMmuBuGfNta1a9mBK/tlOSlphkgG266k2e7gtDrsMVGzBaDVFmQP24Mb4/V6s+i4xP65sG1hVs
	0BI1jL7jrFUkWekXddWzpah/D7KbMt5Qo5ZAJO3X8
X-Gm-Gg: ASbGnct3+sxePLrykipx6mJQ2VQDEEWi/aHKIWtwmJd+kBd4r3b8EBSlxyW7Ju4WZoK
	V23oDOjpGGX1gnZ3gjfQBhPhrti/k7lvVfWvI9WL24s+bSppH/ne0HD1e2uJqBnhktJ9Boh3aM2
	KvqL8QGMrWAzZboai+hX9HSHpMILbGDF/kVT1Z8EwJeqDYXyeXwXSy/N3hvx+102MHrt3C3EbIy
	ARR5dxW3KnKR/uEKgt8IMo=
X-Google-Smtp-Source: AGHT+IHPI6ul8LHl8lWUzenWa9g6/LW8d+EETLtWc+M3yL9gubo/LBBVWehdzJjQm7uRU4IsxVnESLK6Lnw2xZo8tFA=
X-Received: by 2002:a05:622a:511:b0:4b2:8ac4:f097 with SMTP id
 d75a77b69052e-4b7b4525fb6mr84305051cf.33.1758118409515; Wed, 17 Sep 2025
 07:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916214758.650211-1-kuniyu@google.com> <20250916214758.650211-4-kuniyu@google.com>
In-Reply-To: <20250916214758.650211-4-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 07:13:18 -0700
X-Gm-Features: AS18NWAYbCEP5NtFTEMfxCqYZrsTgzGv8ge0mkPOAfz5TaKQyQtMt_3SsARS3sY
Message-ID: <CANn89iKRrqEnt70XkTBNJXdE-fo=tLjFgH8YCqtyv-eCmNpmBQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 3/7] smc: Use __sk_dst_get() and dst_dev_rcu()
 in smc_clc_prfx_match().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 2:48=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> smc_clc_prfx_match() is called from smc_listen_work() and
> not under RCU nor RTNL.
>
> Using sk_dst_get(sk)->dev could trigger UAF.
>
> Let's use __sk_dst_get() and dst_dev_rcu().
>
> Note that the returned value of smc_clc_prfx_match() is not
> used in the caller.
>
> Fixes: a046d57da19f ("smc: CLC handshake (incl. preparation steps)")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

