Return-Path: <netdev+bounces-70574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F5884F9B8
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 17:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C030E1F23E16
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 16:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA1576047;
	Fri,  9 Feb 2024 16:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="o28ICFue"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45927BAEB
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496537; cv=none; b=YigP6seczHBsvASVaT7BsljHZOz3xEriIxAkzoYVKxqnElwLZFGVA7LQGOs+UYKt1Hbo5qOBJpCzU+B9cPbbWgEYjqATIlB+EOmakWeBnU2l/RF18XqC0V1KHSmPDvRnhOfNKC8wVWfVR+qRXRzKuasytqxXxOtqz4lMVNlLcS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496537; c=relaxed/simple;
	bh=yModSXXua3oB7OjIrjLIis3+DYHhBihTuP7cBjdvcVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ecZfAL4kbjsPPR8R19Q9vD3neG/yEIrqUsShjAoASQA1AVCrBkY2edRdpMcqVZViOPBDWbq1bi80AC5G55sqRfs/MojAibueEHeQaHX8LZM6aUoMXJkNoCxnKr91PKyI+KHY2cdWTOxGGlWxY2wNBVvSJmVFfaGqJadIpT87SI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=o28ICFue; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e0523fbc27so607565b3a.3
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 08:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707496535; x=1708101335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPZp4hTlWStrVav5LwjJp17/XmDyXmhjbnSznY/Szto=;
        b=o28ICFueBakW5bIIP/3tgy5/26xcsDbqazzqw9lkEuXEJ6YI7NyY3d7SSUYQAjfgLP
         Jmp7tQNnBAeekcHmVC/sLxj+vciJeRRLcqghflNNMdg1R4eCAcJFAquqOiv8WW23tLmq
         0Ov54pmdPpwE9XKFhdEyGP0pUxk7cdbw2hYShWxCEerzpl7b67UilI0qpzQ6i643FQ/q
         Molnac60h0yk6/gBUY4ecY4005+KbNjg++s/925F+KF3k0n52asq+xuyIUSyWKC43rt3
         GRsXN6hSecRXuN9bTe8dkKFg/agBPNvgjWx+BpHXdkAFe5qfNioGpLFrXhgkvKgVsPm4
         GfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496535; x=1708101335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPZp4hTlWStrVav5LwjJp17/XmDyXmhjbnSznY/Szto=;
        b=nHgLCppAZci/W48UW78dpBM/wOSUuq5+gdpZTlavOZ/nEKPjZyrONZm1HgBI2zx0T2
         Ysmh4Mh1BK4LD/TwcP8UH6QAkrL5c/Q1tNLy4lpDB4B3egaR/9/mFPjZsJY6FVFZT/s1
         ExswRw1omWRlovAvfGDdKYApqW6x7rr7SVqNYKA+X1ipZmkAsaKUJwMbAwZyUo/7PP3o
         DdbNNhwfbjJNL5FHhJYuPdgz9fOKa+ce42ggdtdnh3YifMM8NbKKY+2AepXsLjXpJN6+
         sZuih6O/yDU4KxwMLInHCe7UW077MnJEPCliOIqNBCxS2OYzJXDzZat/v77oS0zZG5KH
         cuyw==
X-Gm-Message-State: AOJu0YymtxQJOzfCxywlN/brFLnS6xJeBtUfBNKKK76M/ZqZO1g7Vasd
	1WU/qKDaPt9nh2PmggkH+TZWd2HC15FUkk+XRVAJBs22HfrB9Yb8SAkCM6/hHoU=
X-Google-Smtp-Source: AGHT+IEN8whbbSNRwt0+8ChPGLgi9onSmSERHEKTDagQIqcIibsooqCynh411hX1HwH+rdageKZCJg==
X-Received: by 2002:a17:90a:17a5:b0:295:ef33:49af with SMTP id q34-20020a17090a17a500b00295ef3349afmr2528944pja.9.1707496534830;
        Fri, 09 Feb 2024 08:35:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9SzLHAMzmSNoyk+9XJuplvgnJr1piMoJVeMvTTPmloposv7Aqo5+DoZG6lYjEl6gbKa8NkOtqhuse9LrBDHeQoMdPSR570KzA1y0G2BSiPaQQb5koig==
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id o4-20020a17090ac08400b00296fbf5b294sm1969448pjs.38.2024.02.09.08.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:35:34 -0800 (PST)
Date: Fri, 9 Feb 2024 08:35:33 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, sgallagh@redhat.com
Subject: Re: [PATCH] iproute2: fix build failure on ppc64le
Message-ID: <20240209083533.1246ddcc@hermes.local>
In-Reply-To: <d13ef7c00b60a50a5e8ddbb7ff138399689d3483.1707474099.git.aclaudi@redhat.com>
References: <d13ef7c00b60a50a5e8ddbb7ff138399689d3483.1707474099.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  9 Feb 2024 11:24:47 +0100
Andrea Claudi <aclaudi@redhat.com> wrote:

> ss.c:3244:34: warning: format =E2=80=98%llu=E2=80=99 expects argument of =
type =E2=80=98long long unsigned int=E2=80=99, but argument 2 has type =E2=
=80=98__u64=E2=80=99 {aka =E2=80=98long unsigned int=E2=80=99} [-Wformat=3D]
>  3244 |                 out(" rcv_nxt:%llu", s->mptcpi_rcv_nxt);
>       |                               ~~~^   ~~~~~~~~~~~~~~~~~
>       |                                  |    |
>       |                                  |    __u64 {aka long unsigned in=
t}
>       |                                  long long unsigned int
>       |                               %lu
>=20
> This happens because __u64 is defined as long unsigned on ppc64le.  As
> pointed out by Florian Weimar, we should use -D__SANE_USERSPACE_TYPES__
> if we really want to use long long unsigned in iproute2.

Ok, this looks good.
Another way to fix would be to use the macros defined in inttypes.h

		out(" rcv_nxt:"PRIu64, s->mptcpi_rcv_nxt);


