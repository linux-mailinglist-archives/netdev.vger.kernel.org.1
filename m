Return-Path: <netdev+bounces-239533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEFEC6976B
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 13:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 835624F168D
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 12:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A39922D793;
	Tue, 18 Nov 2025 12:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qKFy5mLY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84340205E25
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 12:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763470038; cv=none; b=PhWejtskP/nASnk1WwDwWagdd0meLHVbwJguBMxbkkLuoovVRy+DBVNxMXQkZjR/T2/jWik/3UZs2c5GptUyFALshl+iN4bkglgvFqiICm4p+2XUWqgsc4O9FP1j9xT7Yizgo1dKR5hyK3cWahrTYMESjmhu2ozNJfm28pWKvQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763470038; c=relaxed/simple;
	bh=NWQxp9KBiLHRWrgCkXUCI83WZYSSzpaVRI03tm6xh+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqGQBM4UhfNe1OwKEQm/aYMq/TbhQT54ru5b74MwpnFNuwRrR0E7/lEUiOAjjLRhu7aJkTXJLQnf+GMwjdzuSQIGV5NXqd2EI16mQ0BcL9zbz9d94g8Fn8VouID0ro872DLgtryiyCmkeMfBUa0L46NCESPlJtF1XGyKY2UwMTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qKFy5mLY; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b1e54aefc5so462433085a.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 04:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763470035; x=1764074835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWQxp9KBiLHRWrgCkXUCI83WZYSSzpaVRI03tm6xh+c=;
        b=qKFy5mLY9eMdIrf3qnKu1ntAaK8ianu1MJRVXBK5KsVS1Td4X6Kp34ZM9MtkBj1hIE
         0md2VKTJN3AJShzVv11fDMi00tGZ3t0ATKPNZ5m8pi8RZeJm4X8UsUepJi25VtOkKiE/
         NzaHarlEpblOQuQkIz7w1hIfiBj7iwdfIa6yyKNQgQmXfLdmAVM3eAgtYAHELKdq/0/g
         hUYvULAWv0zIFWiAoPNYGbkaAsZzjwudKz9TO24BMIYiD8nFCXgvWNd6NOmCmbT2xwgp
         Ol3TJBJd3kJo4/dGBf+cmPVNugPJOQL9BliwsHZE0+T7fDRddokMA8hwJHwSiHWWUsKP
         +WmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763470035; x=1764074835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NWQxp9KBiLHRWrgCkXUCI83WZYSSzpaVRI03tm6xh+c=;
        b=Ruj4y+fpDc1NN3qrAO3H7gk+24bDq1ZZftm5vnsNIScSpqNIyK+Csbqy9XyFsistqB
         HaoW/WHxAuo0QaJklN/YLkRrKEwXVDxZAfsTToOd7wfjcGf+mPWacQD4y0nx2C4cfmxb
         kQTuu090j6PSFWA7RMEdU2ygSkU02P57Ioyf7ddZYD5maF8fyIyb9aAQ/2y0ZbWirY3A
         DTFqmXIeDS42aEHctxCIRgV/CHCASisWvFxnb3+qS82MKHllHnfdhrlZF13a/9D/Jk/5
         fzed7gTDwTd16D6Sq64AD9S5ZMLjIIagZzOW5V9SI9XgailhSCPjosIW1evbv8mfD9Yi
         RbnA==
X-Gm-Message-State: AOJu0YwtdyHsHCX5v4KPAOAaC/8bwWx9t0eIPE29os6WW2ofJjLg1WCg
	UAP+UMlhBMqB5zroz3NDNMEajuug+Imyycbazb0vs9xyoFvkbqYHp5lbT8PM+Q5/v7QB/FGXhvF
	mx9jviT6rj9/xlF9VF5tVbnqLFORkU20jXUFkyDFR
X-Gm-Gg: ASbGncu3GBAN5d78K4FUm1MfXVL2Vs3gsILZYDgvgzXoFTpDIhAs8hJ64/9py6ILK9h
	NpEQo3vdezqcopq+Bevs/fLXyQgl77tivuW5RAhSNelpy1DFyxncr7JQNu17PBFHBII5gPgVT6P
	enQSF+ZyJBmiz1uKud8sd2ty/NMtdoSf2AivbWo40Yp9PmEY8jxy3j6B34pzhPpJPbk0ph6v1Bo
	/ogxiffn3xnhY4q9gNf4LOLFCC1NEoADsn8afjQpSxrBvYuaxybmvrO5DgBUvpptqKJ5ixPNXvJ
	bvUNC78=
X-Google-Smtp-Source: AGHT+IFel95ndo5/P6oZ48XEw/AOQFsYKTmNuIvvHxjsqkubiBKUuDFHrQTgQQddEqpHrJ7r0NhqhlRpU2kZ199P89U=
X-Received: by 2002:a05:620a:190d:b0:893:1c7:4b with SMTP id
 af79cd13be357-8b2c314c1c6mr1906693185a.31.1763470034950; Tue, 18 Nov 2025
 04:47:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118100046.2944392-1-skorodumov.dmitry@huawei.com> <20251118100046.2944392-6-skorodumov.dmitry@huawei.com>
In-Reply-To: <20251118100046.2944392-6-skorodumov.dmitry@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Nov 2025 04:47:03 -0800
X-Gm-Features: AWmQ_bmAarW5E4irh7uh5Ba7FubcEKyQjHRluFoVESDgKHjzVHZCbWcO4di10Bw
Message-ID: <CANn89iJvwF==Kz5GGMxdgM6E8tF8mOk0gUqSt2Lgse-Cvpo9=g@mail.gmail.com>
Subject: Re: [PATCH net-next 05/13] ipvlan: Fix compilation warning about
 __be32 -> u32
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	andrey.bokhanko@huawei.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 2:01=E2=80=AFAM Dmitry Skorodumov
<skorodumov.dmitry@huawei.com> wrote:
>
> Fixed a compilation warning:
>
> ipvlan_core.c:56: warning: incorrect type in argument 1
> (different base types) expected unsigned int [usertype] a
> got restricted __be32 const [usertype] s_addr

This is not a compilation warning, but a sparse related one ?

This patch does not belong to this series, this is a bit distracting.

Send a standalone patch targeting net tree, with an appropriate Fixes: tag

Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")

Thank you.

