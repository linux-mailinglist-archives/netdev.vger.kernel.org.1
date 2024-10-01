Return-Path: <netdev+bounces-130798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AD898B9C9
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6929D1F22CCA
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A2D19DFBF;
	Tue,  1 Oct 2024 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yffFw8yF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED7719D887
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778885; cv=none; b=L4fmmKjhYUV4AfhaP+aipS2zmJsNZvsQgALxqXVBByLz/GLE4Ie4hnVRvezSmQImTMBcnPvjS0AWBvxO8Q7ASvVIJQ6gU3OEtMLi1lH2o5/ZZYy2KVi9SWH1iuGp+cYlJ158hdNPR3SzM51V/3fs/NCA8ZNQgkuuLEQWbh4cs14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778885; c=relaxed/simple;
	bh=hG56vuZQAKap9WWIsznN1aenepVaMYbglStG9blM+y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9ZR4BJfyjRffhXHgME2ehlOG8jJXdIImQtXTFzDQqqosPsDZ1V0kv5p23vdj+7wWwGjlhltw1wiUj3RuMNmqlFE2k97TTH2ibHQ0UhTJJT+1JpeZIYUydYvQqPy61evmBbx4denN/2zHIR8BiwGR6wFAGZ9o2OeCbPPyHe0vR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yffFw8yF; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fac3f1287bso25356121fa.1
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 03:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727778882; x=1728383682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hG56vuZQAKap9WWIsznN1aenepVaMYbglStG9blM+y0=;
        b=yffFw8yF0YtX93yGbpqKAzCU7baWikQ75/i9M4OSQbh4CZl77WEchkG8LtwSJfMne1
         11nW9MHvUUKY1xFmk7jgDXpHAjvi2m4u2oBTcMezPlCAU81VN8KWcQTR1blDZmMC6HHK
         Hetc2gENNQnVQ3bu4Lze2vnZqJuBzjjxwwLRWpleNItbiyGYhZyYIJzY8A3/9nTSqZ9q
         yhKwf+1fcLG4MDRV9aQ51GfCvt9aoitPJzsE5RW94LdC7NgPPYHILSe1t5NlB6tUaUYq
         8EaU6Wx/U1gdHG3CA8hiiwNNEW854vAunKTP4Mobc3hWmxMfzHQMrml7ST6k+jcWwkZL
         ZIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727778882; x=1728383682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hG56vuZQAKap9WWIsznN1aenepVaMYbglStG9blM+y0=;
        b=RK+jG9qrG2RRGpYaYRWMHnLzU/LuOu+lsnYQcNrZA0wjwkkxCM8dr8Z3nuKfRV4sEQ
         NWXlF72osRyr49lP6+QqSBouXc8pWORc20AuPYNNpjLmOyic8h4iVn58qbT+j9MpvkmL
         Uvuaq9aEECFD28Lm3N2ojtgftsX2a187/wKY43yG9y7YxAuPTdndAebTE2rqI0nfiB4T
         sAFFTZBs04BG6KAEjeaQNI/u0y4V9atA3CfHp9foNUca6DYIj5fYFbgxvwAYAri1bgmG
         K4GLavO/uDLcec4+iuWlNKD5vLuq81SrlILU0nEtR0Rkb5YYJ/+17qW4bb3kbyT+6t2I
         p3DA==
X-Forwarded-Encrypted: i=1; AJvYcCWcHqIWcDXn9Urejq3FaEMfDZNviznAdqxK95GyGHjj3tOuusARGHtb/R1CRmes3NAfdSGlSC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTvdOPh02SbcuvP8Uft/DqHmF9C2g3Izh6jW9l0xPey0tsIaX1
	6yhcjVJQQliaZgXwLT4vfYb6caq3o8vj8PR39+PggpuDz+ovgKuosi3blbr2aUTLcnZQ4iQJBNa
	kL+R2dSExoauIsbkSmruOWHBb1tgPenHhn07p
X-Google-Smtp-Source: AGHT+IHV/alq5ExfPPEnyVKC2mFpFPFojD1XUyAjUiUU5F24GuGNFfyhO9IVUFmNKARbVE6Ji2HyGV983qbdVy5t1pQ=
X-Received: by 2002:a2e:be90:0:b0:2fa:cc12:67de with SMTP id
 38308e7fff4ca-2facc126a26mr43523851fa.32.1727778882160; Tue, 01 Oct 2024
 03:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001100119.230711-2-stefan.wiehler@nokia.com>
In-Reply-To: <20241001100119.230711-2-stefan.wiehler@nokia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Oct 2024 12:34:29 +0200
Message-ID: <CANn89iJiPHNxpyKyZTsjajnrVjSjhyc518f_e_T4AufOM-SMNw@mail.gmail.com>
Subject: Re: [PATCH net v2] ip6mr: Fix lockdep and sparse RCU warnings
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Petr Malat <oss@malat.biz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 12:05=E2=80=AFPM Stefan Wiehler <stefan.wiehler@noki=
a.com> wrote:
>
> ip6mr_vif_seq_start() must lock RCU even in a case of error, because
> stop callback is called unconditionally.
>

OK, but RT6_TABLE_DFLT always exists, ip6mr_get_table(net, RT6_TABLE_DFLT)
can never fail.

This is ensured at netns creation, from ip6mr_rules_init()

This complex patch adds some code churn, with no clear bug fix ?

