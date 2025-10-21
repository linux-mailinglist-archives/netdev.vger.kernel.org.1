Return-Path: <netdev+bounces-231401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C0CBF8C89
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 22:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCFA04013ED
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 20:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811C0283FE6;
	Tue, 21 Oct 2025 20:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hlqLVVlO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C1D283CB0
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 20:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079758; cv=none; b=YYfT+KW62AKQQ9O3sxz0NoWaDA6w2pnVvZ7t+n03vNBUNSDgrUtMA8sdBlLWx3V/CRXEheA8aJivaOV2wG6WKjfUxyTOrlmtk01k1PbJC6X1/pVJB6b7HZddtUh7fcwnsB4JAUkvZhpyzyllyS4XTM12c3pq4MM3I/iWdWp6TmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079758; c=relaxed/simple;
	bh=g6dy8XM2tNgAWkD0Ln/WsTZs+6D8oQBA35+4cAScGbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uh9cBhKofyvtf873bq0cNqMJV1Zp9cjb4P1P2AEZ1WrhyOO/5w4r+GOzxGfU5w8Fa5ow28oxOrD5V+7A9pKiwoxNx8FEhH8MsBMZ0cY/x/NxlASCRWfPP1QkbUtK/5Oj2v5/kqIoXCh+bQ7SDedvxNExp1ZukaA6oVdYqP34+Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hlqLVVlO; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-58877f30cd4so928e87.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 13:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761079755; x=1761684555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6dy8XM2tNgAWkD0Ln/WsTZs+6D8oQBA35+4cAScGbk=;
        b=hlqLVVlOOp0ofUhNecCvneY2ZryGSeiAxUq5cd75AAB+TmoTUEBgsUQPEDi5bbkw4m
         PerZH9OY8Ow2XTwiZMQcAYc72AUSVrcRcSsz5tTCEFzOXRntxiQHbVc8UKDJBstN4Kw9
         c+zl6GQTCq1zJgsQnePcGdkti/anhsC3MXLpPLU/1+zDeggxAPFj+xCj3egSHCc9KJZe
         +aR0kVSLa9eA+rPeqkzcJ6LSVbjShVZgjIeh2x5k4pe1RVC74PwT3tzLmSQ+Cc0Ve6oD
         4NWn9sTa+bDxdm7h2IsaIfs5KewaY2wBCGo0Kbz92GGhuk4W0zMkOtdYPcbmuIVldcd/
         hxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761079755; x=1761684555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6dy8XM2tNgAWkD0Ln/WsTZs+6D8oQBA35+4cAScGbk=;
        b=ckcWG9LuPRUy11y4GEgPTC22g11sZ2NWfDg2EdHb9ynq7o0gPlObT2YFJcbqhqiN6q
         speCvle6mvFONWiUfYkjmJN1Nz1AARAZkFgk9SwgvW/3ovQEdM1vfJzQL75j9vSU6DJ9
         mq0pq49APFJf7XJP7DdoTtA+yajX864/xO4LFjyn8ekgh8ajzzD+HcwKe++XknK8oJYB
         Q3Ok2pMsxN1qEtJsxX9ASNRRmQRe8mFEIg5J9fXbvw0VcMi2406R47V7erpXNCrR4V6P
         ZEeMlWJFre9iJSKHlK6g/vL33aJ11Vfc9jZww/UYC31H0g26MdsDqIOGXeTs79b5kC3W
         gGIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQS++Ldnfd1rdlMthXizcHAMUz4R3Alb/i0Z6qHqzGstp0P4bbAObbMCllBYQeMagRJAXywHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjG+bBmqNuRxpUsvloJ5IZd5WSdHScyScpz3LWZopB279J7fAm
	8jLSBzodeqKhg9exyS87p2Fvd3So4IY1514e+CVf2W8RGCuAUu0/7URF+jx7ZL867ukCN8k7Uyo
	vS5qn+jt3ubroXmwCO6nauDfUW5rvV1VdYyo1rj/4
X-Gm-Gg: ASbGncugwBWRjYEo594zagErdQseFTmLu6MGpelcqmvFWi6wkv0qPAUX1U4yHcbrBvd
	W1Ulfh4/wVTFlUgnm4qD+vKRE8o885ZAJqW94TJBfEowC+t1ZQeVJy6rsUhhxkvKMiMG76s9lFj
	gWqsrLtPXUpp8u39dUsDHkAcqjXDVlxdmi7/++olN2FN7ert4pYIRXn8LdBLxjIO6/GwFu2YBh8
	s8Y9WMV8W5O89UOqhxbpBG8BlNGDyP9EBWtY8bYVCdqN+3CTPa7IErbfHTh2OS/zQdEl12/VXr3
	kU1TgL4PiyhE71M=
X-Google-Smtp-Source: AGHT+IHO8C0kuFsE2itE/Q1SaLLHUpR2/FUx1UBenLRQjmlfDU+nR8Hn0rTwMaYmiLV/P7aB6nvOtrMzw+rTnaTtwDU=
X-Received: by 2002:ac2:4c06:0:b0:591:c35c:566c with SMTP id
 2adb3069b0e04-592ed7c3bfcmr87691e87.4.1761079754378; Tue, 21 Oct 2025
 13:49:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021202944.3877502-1-dw@davidwei.uk>
In-Reply-To: <20251021202944.3877502-1-dw@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 21 Oct 2025 13:49:02 -0700
X-Gm-Features: AS18NWAglQNajORvS47bG_oYzZMZSo8stXNRYSpIm8BsUjn_k2_VJC0JV74-kbM
Message-ID: <CAHS8izNuJUXnQCz6X4xMGu=fm2jZ5VO-d=57xC7epu3Bn5T5Gg@mail.gmail.com>
Subject: Re: [PATCH 1/1] io_uring zcrx: add MAINTAINERS entry
To: David Wei <dw@davidwei.uk>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, 
	Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 1:29=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> Same as [1] but also with netdev@ as an additional mailing list.
> io_uring zero copy receive is of particular interest to netdev
> participants too, given its tight integration to netdev core.
>
> With this updated entry, folks running get_maintainer.pl on patches that
> touch io_uring/zcrx.* will know to send it to netdev@ as well.
>
> Note that this doesn't mean all changes require explicit acks from
> netdev; this is purely for wider visibility and for other contributors
> to know where to send patches.
>
> [1]: https://lore.kernel.org/io-uring/989528e611b51d71fb712691ebfb76d2059=
ba561.1755461246.git.asml.silence@gmail.com/
>
> Signed-off-by: David Wei <dw@davidwei.uk>

Seems fine to me,

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

