Return-Path: <netdev+bounces-125053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 291D296BC67
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51451F226F7
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB57D1D9344;
	Wed,  4 Sep 2024 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D8A192px"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC70185935
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725453197; cv=none; b=cEXFov/PB+2jVYJlxtjbgwOgA0ZcZWTN/lNsu580BU4YANDbzCLxdLiG67WeT9u2MJwZDqVvlrIJps9jfSH/aXET4w0Pc5n6gyggSsIpMptsYW13UDSeg7LvcGqvMUwYWM60vprxDFUM2Of7peEhnY21HNUx/v7xe9I0/tvGESA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725453197; c=relaxed/simple;
	bh=7UoD9XiCpvi6y1xEyB8+5f+ERh25lzqVSxkvy5h5/dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKhPB6K0VJyYZ1wf0DKpOFFr/TK9KLDKKR+LxCKpoG2Y5zEiQgXPrgfmhld/KAXL/lRU28gthLaXllB11tF/acmj7XCAuAMebXMJv8blEoLRNLPzkuuwHGfOIWCMEPtcUkn4gvTPr34qXIIJFyhKk10INGAC1lqXgam/3iNDNVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D8A192px; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c3c30e6649so668528a12.2
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 05:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725453194; x=1726057994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bXLYQrAn55qVHKqCMDfrSJuD7so3yQzO4aIvtH++AM=;
        b=D8A192pxxQ7LzkjSwfZ1WOOlnl4xz1WO5LuMdC9o1inymEoHYM2Bfx+lEyfI6nQP8G
         3m5MiyDGexZUXqrmH5VaovppbcyBIpKtYlT7iKdwn1OPw857GgRSwapGVz8aXckKWMJC
         eHrA6cJCkdi0uL4+1+WxAJWlhSF65guFcCaiuqNwxNedM9Uqb1/iJgi3RHGLbWM4LTN+
         ewZlnXWVtFMpgKi86zF1nrAln6KgcMIAhVflDDHetysVw/mIU56ZQ6ttTB3tYAiTq1E1
         noLFXyiI/5CH2x2h2wrV79uBgnYc2fTEXIGi8rT7QDV8L/D8f+LZ4jKUO3vUbU5qy3CW
         J2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725453194; x=1726057994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bXLYQrAn55qVHKqCMDfrSJuD7so3yQzO4aIvtH++AM=;
        b=bmK/zKp2J3m1rxucg8groczfIYl+oTWTYmUB2lf0bXH2cKHiFg0LoAtj1resBcPPX0
         nVAqPwo0QJR/E03h2Fo7HyD+xlk/gfgdealIA8oSg+IRsWjGNwNA7XalPOJLm6Kvr2aP
         fSDnkQCI+MwazqhBldwdTmz86p2CHJXIfaWiDzU33SgLDdy6OlamTlSwjkxmbg6gB0VA
         8/jJOtUmLWUAWkKTA2koahIjogos7+c9M2Oa/uaFq/UlicVlboofSPHgGipZ/pGr40CL
         Rm6KysOR6cjZapj6AyvXlQ1TNrVqI6JhU/9nRdIxlvyMjbb8MUxBVGHI42Knm7qVuXA/
         tNPA==
X-Forwarded-Encrypted: i=1; AJvYcCXhxYHRzT1gkUn2C6rC3V6IYoradsxZeQFYNpzMDt/ptYqY7Eb4XgetzggXGddEdS04ef0e2+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH+LQmVFPVaFQyBe5z4mliDU8lWi60T4jNf86qOvq2MaKaAWJ+
	6kG5JERjVFI/Glwd1nhgyO1EvKt6hVVTmzdcMq2FvBHMRI2F+yboc1SGt8LGS/J5QvJ6EmivSq2
	iSAJn1/TcG41miAJy7K8r0Y/zUzoSVsZb3kR3/tXopnSkYBS3xGzF
X-Google-Smtp-Source: AGHT+IHSWhhfEGVLU8gtaJv8edwr6ndZX9ujHluP3FBkuXM39Jrx2YzM0lBdfRG5k5PfLNmwX1DTQ6QqlRxSWW25Nz8=
X-Received: by 2002:a17:907:9409:b0:a7a:ab1a:2d67 with SMTP id
 a640c23a62f3a-a89b93d963amr1059288466b.1.1725453193678; Wed, 04 Sep 2024
 05:33:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_DE4D2D0FE82F3CA9294AEEB3A949A44F6008@qq.com>
In-Reply-To: <tencent_DE4D2D0FE82F3CA9294AEEB3A949A44F6008@qq.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Sep 2024 14:32:59 +0200
Message-ID: <CANn89iLQuBYht_jMx7WwtbDP-PTnhBvNu2FWW1uGnKkcqnvT+w@mail.gmail.com>
Subject: Re: [PATCH] netfilter: tproxy: Add RCU protection in nf_tproxy_laddr4
To: Jiawei Ye <jiawei.ye@foxmail.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, fw@strlen.de, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 2:25=E2=80=AFPM Jiawei Ye <jiawei.ye@foxmail.com> wr=
ote:
>
> In the `nf_tproxy_laddr4` function, both the `__in_dev_get_rcu()` call
> and the `in_dev_for_each_ifa_rcu()` macro are used to access
> RCU-protected data structures. Previously, these accesses were not
> enclosed within an RCU read-side critical section, which violates RCU
> usage rules and can lead to race conditions, data inconsistencies, and
> memory corruption issues.
>
> This possible bug was identified using a static analysis tool developed
> by myself, specifically designed to detect RCU-related issues.
>
> To address this, `rcu_read_lock()` and `rcu_read_unlock()` are added
> around the RCU-protected operations in the `nf_tproxy_laddr4` function by
> acquiring the RCU read lock before calling `__in_dev_get_rcu()` and
> iterating with `in_dev_for_each_ifa_rcu()`. This change prevents
> potential RCU issues and adheres to proper RCU usage patterns.

Please share with us the complete  stack trace where you think rcu is not h=
eld,
because your static tool is unknown to us.

nf_tproxy_get_sock_v4() would have a similar issue.

