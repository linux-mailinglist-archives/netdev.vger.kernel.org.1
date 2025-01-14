Return-Path: <netdev+bounces-158110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0858BA1078A
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92A477A2267
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9745922DC2A;
	Tue, 14 Jan 2025 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NpY+jkXc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA46E224B1A
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860633; cv=none; b=uNKoSaFGyVxlXfNfrGmzlrSxMLjDALeAou7OjG3apTLdEFvPkPXowYU0jLHUJyEH9NRHa13bh//WY6fFmTx/sVkjRclNkjHd6N4r7qvCTrcfsECfiLdiujLLZfKQnrv/pyyWamTcqFaKS8h74jxmt0nrZEPIuk1Jk7fh4HoQkI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860633; c=relaxed/simple;
	bh=b0yrr5KIufJ32YRZoM3kcOzCQ+AtD+sgJ0OuU24zflM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jz6JcUTXE0OBqcI3bCfMBi5c8DEwoLNoEV1ORXqIY56CoajbrIgB9dvq3XvB1px/vDh/PBOBAWpmELmdXOqeKLaqtHzaQtUEfLbWmZ+yra2kgD9VCPLOZFom1CJfloRPaR5qQs0zjznMHVJQVh0NNL6WYfJUU7Ai8+iHM3qsaJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NpY+jkXc; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so4764134f8f.0
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 05:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736860630; x=1737465430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0yrr5KIufJ32YRZoM3kcOzCQ+AtD+sgJ0OuU24zflM=;
        b=NpY+jkXcWvxy9Hl7P1tbW5aaDYc4weRzqnvywwsJ8V8y0qJ7MzopXGYJ2RK1/D8YzM
         L+tdOibhKzhI1YeH5NtM38OYHfgGcdkm2x9aTf+LvcXLPqQoLoe00em5qpy5ulGcbXBN
         VVejRXRRqdoNzWZhHsOmhw56tO4si4401gjjHaca/MrMUamFplrf/C3eUOODnapw6lCl
         ovD/lRUj/HFPBAhsnnuzIiNSUxuZcwuAaxOurc/5XQQ9N4QECA4XZhSZ1Vxlgh2cfEkV
         JcZ1Elm+mCwWB2C2SPAR+UnFKptJ+ByTILAXq18vVC7N51JemxdJy0fFeaQuLLNdNrUV
         jQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736860630; x=1737465430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0yrr5KIufJ32YRZoM3kcOzCQ+AtD+sgJ0OuU24zflM=;
        b=jTv4kjjvVriyI79ffpKrHGYqiznWEeRzI6TTEpmlqpCcauH1QdlhHOXuaayfcIgT5p
         7n4oi/Z6GY9F0HTSP8/izFgzCFNRQov1w1YAP+62UX51VkMiRIRS58Kh4LoAWTV40awi
         PWGIgSITiHAk9xNy/Qr2Boo4gVN+UB9bFVW/CJiYbn+YTi7bDqkt0ba5qPkpxnyHaxKB
         0Go/HTvXLtiZU/yMByDKc6Wl2RQemh7mM7BorFCO6s5dQB7HHUgGfcCuoa3WVasmRH0X
         VlysnwDnF4kxQxfk4LLIHRW6tNj3A9yfb0Q7ShdfIiB17gowY3orXYv3GxI7tz69/cac
         wp/A==
X-Forwarded-Encrypted: i=1; AJvYcCXplfnAHYVaYAKl38lFYha+oXt5sQuB2GoXWmeg1kQ0quOdrO7PDmtwzM+ITm7U6fdtWxV/RX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFlaDQ9C5SPhgAkrfPxRjHCGX5N3VRzQQYhhq1kAUZ+Mg9KqNw
	wK4est8hoc4WgJ8hWJdWW9j1+656Dq9BxlnDv/c86bfYL3NRIUFbkyaypZ4rHVI7YO5XAD+nDji
	n3lNcKC0E0WZkYfWYgHyn7nG7WqqTnjY5PUs9Sw2t3Zh9APeHeA==
X-Gm-Gg: ASbGncuSy8JfP5SSiQXU2qVTMYwDiHzBZu4UwrnuBul35NiLdrPIOmpr68NJEZRgXbd
	tJ9v/V+wn78UDpkURdjvr2Yt4t7DIsBXN5P43vw==
X-Google-Smtp-Source: AGHT+IEtRiWxFp0QMjuDn7H2xaB3ZsjhPx/0s788K7hif2gPBAJM7WhuxjJRDbfKbdnWLv7yTVh0OhfrwVucw+NZl7U=
X-Received: by 2002:a05:6402:35c7:b0:5d0:feec:e15d with SMTP id
 4fb4d7f45d1cf-5d972e06763mr20576126a12.8.1736860617694; Tue, 14 Jan 2025
 05:16:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114035118.110297-1-kuba@kernel.org> <20250114035118.110297-8-kuba@kernel.org>
In-Reply-To: <20250114035118.110297-8-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Jan 2025 14:16:46 +0100
X-Gm-Features: AbW1kvZRmoDLb3CeOkrIWvCybXsaZZtv2UjmFV6gcrwKVXgu1txvdy6fgXkGFcs
Message-ID: <CANn89iLJ90iuFWRRKO3BVu=CZWDxzLYdQCh7LgSRpqes=guEnw@mail.gmail.com>
Subject: Re: [PATCH net-next 07/11] net: make netdev netlink ops hold netdev_lock()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 4:51=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> In prep for dropping rtnl_lock, start locking netdev->lock in netlink
> genl ops. We need to be using netdev->up instead of flags & IFF_UP.
>
> We can remove the RCU lock protection for the NAPI since NAPI list
> is protected by netdev->lock already.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

