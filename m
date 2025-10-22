Return-Path: <netdev+bounces-231655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6915BFC276
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 15:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5476257AE
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E8D345CBB;
	Wed, 22 Oct 2025 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b="EMT3FnbT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6FD2F8BD2
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138124; cv=none; b=hS48QTDptydCHGAnjPQaj5z4mUZFFVRljT1Y9FlR1akyJXfAHSqkiMv60Xt8MJqJX4rpvonrIwCtzv/Jqc4Jl62NIc9zUWzjj9/qKxpnA7G+TtXfE9++AcVNyRx0TOtmYH0/kgctzLGMx3i2j4H7N0WkYtLeFSTvSCU+kaHRBIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138124; c=relaxed/simple;
	bh=YyOT6xckVX0MriiIl7HBo2d4T8KTUI4Zs0unfYBtZTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9HOi9HMqUTP9x4t9xuyWbZ9i3jTtGN2vZptwc+ltigxUlGCN3Xwsfw5LNvj7PGLCrmG0+I0CwLWKxd0Z5etmFaCxIiHkNYR4VjBGrr7JKwgHOGKEYmiUcN0uwV2rJdUjnUdZ0+7a11SFfllKS9l5DqyUupPdStTBumOWG3mz0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io; spf=pass smtp.mailfrom=vyos.io; dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b=EMT3FnbT; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vyos.io
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78488cdc20aso56769547b3.1
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 06:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vyos.io; s=google; t=1761138122; x=1761742922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YyOT6xckVX0MriiIl7HBo2d4T8KTUI4Zs0unfYBtZTE=;
        b=EMT3FnbTWISnp8qFS8tmeCFyrvbxL4ZJ3ydv8XGpLrnSQyGWnNTULQQ1Y4/Uv7YtmJ
         aejyuE/km3ZFPTNKjgN35GzsNqohMByj2wC3QhKxYd4BTwyYnzO8/PimtHyP4DWyoUmC
         HbQmXuGB7ijOqy+DW0+cnwrvuyAPzXLvEEvWLH3YlMN5N7hXu1htCCv0Ju4buO0PQYca
         BKJLZkFB2wj5fDbS8BIdY5l1/ZZC28uY8WFgIbJAQD/y9gzBsEBc9kAXHAh24JO4okOD
         wdm2j6AkVXrjr920Hq9FSNCStvE9MVB6Q6rWrwny4fxWx8knVoz6lCNVeNEuUjL+jY9z
         7kQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761138122; x=1761742922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YyOT6xckVX0MriiIl7HBo2d4T8KTUI4Zs0unfYBtZTE=;
        b=Dg+Nr0UmMHj6G5f5Xo9ZxnqL+FXF3n5azL6RHdQfHjIgX57DBy1idGDhVhNLg3XQJY
         d26Gp2jwAmut0molUI12hJVGPwa4xFUuIY88557v6rJuvB5of2zuy2XJzNfYnLR0gL5a
         0fP0VPRvMDAQqAC+AWoKxGoTStVOnjGKsZOmrR3qPGK9h2nS7caBB4qqUUT5G4k+fK9U
         ffxCs3h927sv7nBHUzl4IvzJmyoqw8t8BqKty/1ASfiH3KfoNlW+GDX+gmjzS681syoD
         QLhHj3kS1YAWdXoWQHHbEdHDckFQRQiILOj+cwJC+Al9r1mlr4hYkMKkC5PFfBSSeXLM
         M5aQ==
X-Forwarded-Encrypted: i=1; AJvYcCV50/YSjxjVfySPFh//g2UG3sn8Uz1MgfHX1eyknPk9BFlsZhn0JBKs+hyzFzwp7+MpqnZR5wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPqgkjPfFaykcVhwyFl3hVfeR7nC6br20uET+9cDjTs86aY6ec
	7gHGmWIt9oWkwyifnxqrrdhUDXv00Xhf3/4qZxxepUnyO36ZuCrFzG6GqHyt45ObIKCFW8tedOm
	S3cGJID++OXHTn3eVvADeM76spCFYlSyqt+jmp7iykw==
X-Gm-Gg: ASbGncun1thN/llC9ZxcSFZqZOu48xhwIbS1FEWqBj9s2zzxLbyp7j497UnkZCpyNZS
	QBwj3EJVhXAWcqfbVMoDHKhMaeyTH5tiGdjuhtaHNrUMaZe9PDXZwZT+jddpw0f82JDiFm915om
	gUclva9cEkwioq6i1qmffz4TqWKOQ1uKPrA0rhW/61WdSKXmXCJXgp3O9878mnATVpN9JvBoUkf
	DtofBr/KUlzn0VS0ZZVO8Rd1XzmhfxUYSwqPbfbhBZVXweckHkl9LL7RU5fDFbpB+owdGSX
X-Google-Smtp-Source: AGHT+IF9jG7efkMJkLjrKK96cUycd0uKP1eoJk4jV4LE5zYD+KPHywlzQYSMFmQ/paz3aQtOfKK1rFQpJc1+j+AphxY=
X-Received: by 2002:a05:690e:4182:b0:63e:d1f:d683 with SMTP id
 956f58d0204a3-63e161c551amr14636102d50.45.1761138121557; Wed, 22 Oct 2025
 06:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021133918.500380-1-a.melnychenko@vyos.io>
 <20251021133918.500380-2-a.melnychenko@vyos.io> <aPeZ_4bano8JJigk@strlen.de>
 <aPghQ2-QVkeNgib1@calendula> <aPi8h_Ervgips4X4@strlen.de>
In-Reply-To: <aPi8h_Ervgips4X4@strlen.de>
From: Andrii Melnychenko <a.melnychenko@vyos.io>
Date: Wed, 22 Oct 2025 15:01:50 +0200
X-Gm-Features: AS18NWCJ-LY11lV6XRcH3jguswzoDQqltcrK4QfPMuRXpo5tSQWNpGqcBGGDgzU
Message-ID: <CANhDHd_iPWgSuxi-6EVWE2HVbFUKqfuGoo-p_vcZgNst=RSqCA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] nft_ct: Added nfct_seqadj_ext_add() for NAT'ed conntrack.
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, kadlec@netfilter.org, phil@nwl.cc, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

> BTW, this fixes DNAT case, but SNAT case is still broken because flag
> is set at a later stage, right?

I've checked SNAT with the "PORT" FTP command - didn't reproduce the bug.
I assume that `nft_nat_eval()` -> `nf_nat_setup_info()` sets up seqadj
for the SNAT case.

