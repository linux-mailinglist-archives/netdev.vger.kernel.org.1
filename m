Return-Path: <netdev+bounces-239642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D80C6ACBB
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 18:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02A334E9CF6
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66FA368289;
	Tue, 18 Nov 2025 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCZDGjzI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C8133C50B
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485017; cv=none; b=kbC5CSvI8tUjlPCSM27SquAA0gwGjoQO8C5QQZxvPyS1HSwnEDhVrKaQn/iqdy+hwy6GiDllrXurGCT7XWPjmXpu0uWzG59S+t2s3N0OIqaYIZsZdCSsHwWVvFKTBXxvzIe2XzAlorHvMFauPpP+Z8awtimPeH18gCLeYcI/k4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485017; c=relaxed/simple;
	bh=5V7GiE6xtZks7l89G9tTxWFWQSrdthsihabtJ0mENe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5OyHUAlpalFhhe/V2wvIO8MSzlx7F2a7STPgSdzzf7cCuiOL9dUr3EePjkr/GWlHWnBk/bSjPKj4l0S62I+HFWe5yBRxuJLkTZG2JwKetA1HGDBYPUpNQNtMFQAlFNXr8jsEcu2Yc9DF7ber3ikCAIdPSe09/VxqBd8IjlTRoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCZDGjzI; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso10065070a12.3
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763485015; x=1764089815; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5V7GiE6xtZks7l89G9tTxWFWQSrdthsihabtJ0mENe4=;
        b=VCZDGjzI6OOU24B1aEZXcWyEOZ8AbwrSJXAQaiCrSfMv1IdYDwcA+v+7sVzaEzWf0g
         7EXNWhSQ9tQO4FxnBy6e/L6i7flybanqTadvEVxLwSGi/F3IBFSHK/FaFsPU2iyLwkXq
         Kdob2qyE9gShed3svdb7bjHz9obAH9okCZYIj5/GaQEHLkbqPT+HFE4uaGy+U+dSEwJ3
         gFbvyoTRUoTnUiDLWoIeasEeMGMZ+K5QacQSS7JjQ0LFnXyCw7eRAOroFp1evd3+3ET1
         UbcoGV3k4JX0hlklKAL0UpWDo/ESM4DNFMbxgPMl2Cb4g0JZegMlaeEsuQwABJIRjmtg
         wJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763485015; x=1764089815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5V7GiE6xtZks7l89G9tTxWFWQSrdthsihabtJ0mENe4=;
        b=d+9g6ddp58+ekloaYNJaefh7XNprSEC4TOol+0vWZD9+hpb8zRQlRnMzBo2T1S41Tf
         yllCZvu9pvuBg3pjN2k2u04ywRyTOS/R1gx0GA6+wA5YtfEVpCh0Za0fGS653ArC9qqt
         gqYQlpNSzbyFkTScWMDsyVMjlz2kWHUb19VW+K2h1SzrYr6QX3QFyQjKHVtJvytRkdMj
         1xNbsAphh3N2tiZfeotQ5ud5qQ0k4UmosB1WjlXx0358epIgo7djupK80aN9ehfrmMfX
         +W9hzM+qYTNavposCXnkZteHMEH3Q9L2gduLPcKPXKxzq1p9MfWzVFI69OhcPnZHHYQg
         nWeQ==
X-Forwarded-Encrypted: i=1; AJvYcCURWfYt4tokA8jeXrVoZ5EYKKj5QkjXt20ekrkKTeeJoUHI7aEY/mVnvlZ1QVlM5kwdxNphk1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpaBDJXl5gcnETe8+wkZYa2sC0o8DmLc8fH5ZwCAnU61gkHZKm
	DG/OKR6386BTtb5YyBJ+SN6bP5QZOwUKCM2MDPPWiYCINLL87Dkc+I1tSMG12TLDokJmG/fhCtt
	VticQErDSPUFPcGwbX3jxHfuZdnXgYkA=
X-Gm-Gg: ASbGnctK/Z+4aEh/1dsqbj+ztJtEUFVT8Hp2rG/FrTqNTY0XqbzExvbnixBsyFaNIDN
	fGBKTFd9u6yk7F/q/FPzE0C/QXTNcq2lLkKFGwMCpK2gIxnzp1v7laGqs6jIaEmdBWQIOFzacPq
	bicu8i7HKNIPr1V8XXgawuq7GKROGH1PhaGOW9NBl4hQXaNpoQUaxNgWrd42Cujvz6qqkYk7lwx
	Dhmbn6EAapdYf30Je8hOrB2RpQuT/5haLyPd23A8sD1jbt/4UOE66vFFObgaoyNrC9faKLI35ug
	F+h1i80=
X-Google-Smtp-Source: AGHT+IFs1ML/yGQuC8YS4/Iv0wOMlGo1jVem3rfZFTTCm2g0aNVw9IUXkatjMzTKAnormtovEcs5dn1ta7eT+xhuG8Q=
X-Received: by 2002:a05:6402:2111:b0:641:3d64:b120 with SMTP id
 4fb4d7f45d1cf-64350e89f50mr14361293a12.18.1763485014376; Tue, 18 Nov 2025
 08:56:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118164333.24842-1-viswanathiyyappan@gmail.com>
In-Reply-To: <20251118164333.24842-1-viswanathiyyappan@gmail.com>
From: I Viswanath <viswanathiyyappan@gmail.com>
Date: Tue, 18 Nov 2025 22:26:42 +0530
X-Gm-Features: AWmQ_bl01hvmKDelrUqTiwPIOlLTUnTAKXqeUslzZwhDZ8PPWJwRB4NxkgNyhqM
Message-ID: <CAPrAcgNSqdo_d2WWG25YBDjFzsE6RR63CBLs9aMwXd8DGiKRew@mail.gmail.com>
Subject: Re: [RFT net-next v4 0/2] net: Split ndo_set_rx_mode into snapshot
 and deferred write
To: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	sdf@fomichev.me, kuniyu@google.com, skhawaja@google.com, 
	aleksander.lobakin@intel.com
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

I am sorry that it is broken. I will submit a v5 as soon as possible

