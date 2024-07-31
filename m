Return-Path: <netdev+bounces-114364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B24A942465
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 04:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1B81C217E3
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 02:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16AAC13D;
	Wed, 31 Jul 2024 02:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6fuIvll"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402E5D515;
	Wed, 31 Jul 2024 02:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722391292; cv=none; b=fF7PU42wNMefXKzqe48JEmf+a2gzz0abDFDY9LhPhxWz2ol+IzS9oCSuwP2nLlp64ohB/yD9ZUyf+E39cPMYNj89iBnxd+OJmppiSZ7UeWsc4EXq17nA7ulUwoRxe1r7DIYQkKO0sPE1JlWkx627muS/Aip6i5I88lB2giGlchA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722391292; c=relaxed/simple;
	bh=fdY78Fk6R2HzkoN0xSv3a99UtS4mSyHZzxrnCguWXI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBh/R7e5lSLvLhpDZiAHe/icAqHYBMfDAycW7oEwkM0M7JnYpY6Gg1aqESfhm6qVwZq6FCO0IPweIWCmeyLK7wuOhGqIEvnGJC+m+ubezlU0PhUmMqnGR/SxAgdIIsHcACKOtP9ICV2Xhj/ovMwKE1a7LEckBym+1eFYTt++BMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6fuIvll; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d333d5890so4912409b3a.0;
        Tue, 30 Jul 2024 19:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722391290; x=1722996090; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hZm9jqVdI6uXR3Al0BK51/ldu/aT/9y35fwjn7m93rM=;
        b=d6fuIvll0GrC/UQKlgTwxaH7tyoCeVS+yC1uInRAeLjrMHvr2B3ZC4HwVjuLXdG2i8
         w04W/B7bRLPU984iD1JYtCYAji9z92rSXQO0Cn8BLZF2Ajcs5Exf0UKBafo/HIBvVSpT
         PZwU7aMkzzeDUu5q6/AJim68gMai+rB/m2a48M/5jP1R9NZtfo66+CTHZEkoJLaNnw9k
         oNcTCcnO+Ojkh7oosadLVZPyPvb0wotZuFKVjN5s3H0FjXxboVlhvAOzIBaruk4LR6yW
         ijaYe/QVRVnhtJsR+r/bprHMvs2ZaphnhjlDNPna7hHlJhsC0+wGazWtTYuhqF/aKAxU
         gGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722391290; x=1722996090;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZm9jqVdI6uXR3Al0BK51/ldu/aT/9y35fwjn7m93rM=;
        b=CzAQEr0UvLKUtkSftFGpVBIjB40gygoVl/rWhR4yCR8kq+zlbS2/UShFz9acHaDREW
         Pnr+89jaZ74MbCkFfKpQQRMfVORlYTQwv/e3TEEzBn0MtKg6LVQ+qEPnMVTY6wk+0Ikh
         n0m5TYEMl4o6QX7NLvaGJO+XLBKXnAcpw/KGizelUhqvRWjHNtbCpiEsCKDaZsbb+YIM
         NBhm99StFxMoOrDaLptAkXBhZqSStSpkbWz8KMF86AlaplAUrByeGNmSz8cKAuTVMedQ
         I0eiMmvWF24IHsQhk57uCs3KyrLds6NZwb+MI/ASyPcm/hTRjJKPA68gAi4eVc/oQzSI
         s27A==
X-Forwarded-Encrypted: i=1; AJvYcCUbYilLAC/18qMxF0UHg9WRMMCZtNPpIJ08IWmLP9Z3pWfBZn+4lN4MLY43blGLdZ1f1MzE2ND82I3beVD0l0zZhSEyCyCUzcYebjWaWHlMHCiuuA/vnBxOC7iEiha/o/qjx5kp
X-Gm-Message-State: AOJu0Yw0ddtIH0EiCNJ4zouWVwAY+sG6GmWnJnKph8rnd6H2K6Q+CA2/
	sUaML+Gx61GGox/+rmtczpKC9CBbmUyH6zG/kquEhg0xDNUi8OU48X07gR3m36CKPTZCcsttrTS
	w+qUCNj8hg6m1tfnhTG9cPTSzw8Y=
X-Google-Smtp-Source: AGHT+IE5vbw2N+dFPsmlVewgVVSABONlXu1cvOpKcjSS7EFeb4Ah+80/EgqMIshh7fhZr24F6LDK+ozdpB75a6BTT9o=
X-Received: by 2002:a05:6a21:3406:b0:1c3:a760:9757 with SMTP id
 adf61e73a8af0-1c4a14efcb7mr17339527637.49.1722391290417; Tue, 30 Jul 2024
 19:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-tcp-ao-static-branch-rcu-v2-1-33dc2b7adac8@gmail.com> <20240730183702.06aac434@kernel.org>
In-Reply-To: <20240730183702.06aac434@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 31 Jul 2024 03:01:18 +0100
Message-ID: <CAJwJo6YCJJZgaCEXH5WPpJsEkDPnajWQ4gvXaawPyT9f_cpGsQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net/tcp: Disable TCP-AO static key after RCU grace period
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jul 2024 at 02:37, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 30 Jul 2024 01:33:17 +0100 Dmitry Safonov via B4 Relay wrote:
> > +     struct hlist_node *n;
> > +
> > +     hlist_for_each_entry_safe(key, n, &ao->head, node)
> > +             total_ao_sk_mem += tcp_ao_sizeof_key(key);
>
> nit:
>
> s/_safe//
>
> no need to safely iterate if we're not modifying the list

Certainly! The keys can't be deleted by another CPU once it's
tcp_ao_destroy_sock(), somehow haven't thought about the iterator
here.
Will send v3.

Thanks,
             Dmitry

