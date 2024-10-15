Return-Path: <netdev+bounces-135476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA04599E0D3
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E457282815
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D271C68AA;
	Tue, 15 Oct 2024 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZskgOrZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F221C302E
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980402; cv=none; b=bqny9cdJBNodRhL8ywMbdAly8zbz6EA4y294ilRwXDfopP16JPcvhVuLiuBjz8xTW4Q5na/KJ/CjREyrUvVKmdeVEtUoRfoXh9yorENgKQKPqpOQNGKzNUVJMJp1LB3ZTF2f94i+55pU9n3F7k5v8Qw8lzf7/ORDE9PZ5REt9R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980402; c=relaxed/simple;
	bh=hYJeZatC+vow3TzPbxgLmdQn7zPNpA/4HZLUm3MuoP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvC7hG6O0NzpaeQri3f2Lnsms7zYvYV9tfNtiYO8scx/KmW7vmTAMrKH9/IDNEKKMjZ7HsjRwwVQ6Bzj4PVrltZI7dCVsGTXH1dFHsjvX7zkp9I9bVUT1abE5PlXFzuRxKFK1t9mApyj19JjeLT1W+uJbLnEjgNf7HkwrQUllxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZskgOrZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c94dd7e1c0so5154121a12.0
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 01:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728980399; x=1729585199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYJeZatC+vow3TzPbxgLmdQn7zPNpA/4HZLUm3MuoP0=;
        b=aZskgOrZXU4wx+ws7rm76wyjagOAbUTtg2haQgACewazsbaewIRg+tieGfgcaq5nLE
         SLZwMbF3wHSBBAVdzXBhd8AVb225vulcsKMhM0XMqT/VU8ToBpO42nAv6NIS5rCTzEXR
         hXLVYo0HTlNN6rUaW9IkfVO4oRyzY2yR7MtbssfqXX376GIkOilCtfH8XHiFAobvXKZm
         ceQppnrkd3pGCnUp5cjerZS4q3YwTl6Tq1+b4HvUQkScgWm8tNFcoHWZaLhqGJqc439s
         374XOopPPMnXvD2Fkwv4mFy9YWvMsiQgU4akKjrzClVISToJyaWZYoOCF+OeCxyt547r
         BneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728980399; x=1729585199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYJeZatC+vow3TzPbxgLmdQn7zPNpA/4HZLUm3MuoP0=;
        b=groF/xXwVzz+MdyEBnR0u1d7nCy5nOSuFHz6+BjZZqkL1+fccBzpEndsiyzi3c2cDE
         HxuwnwNnN/F1nqbu47IPutqXOJMEMW21iZZZIjiKTNzt65fGcZxz45nmtIOeIhjLNjjC
         MkzkSPr2U5dq3IiZnqY60wFN0nC3TXbFR9O7uDYRE6gCo+zvapkDBgkJwmX9lhMofGGB
         OIuWtD25ktK9quevJ1eim96Tsbf+hb6WsXTtX/qGPBKOnCsdvvfJV25Z0mxJCt/sk0rw
         rZ6H4q2483gsXUWMgkapOn0kVG43p+AJKrlypDXAkAU12hyfza3t+By7IgqUtZJcaHdf
         EFvA==
X-Forwarded-Encrypted: i=1; AJvYcCVRtSfeBTek5Orb6y7JIF6oyoiPfYrNO6r6hc3EE5NXn9eokXApFaIJkedyRZL9P+hk/VeZNQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCwWDx6xNr2lrYsm0XZUyvaz4Bu4w4fiG7wos5xE8J2jB45UaT
	PgD/T0WjOnmxRh1HSM7LoEewOV/acp0f2GH7ULOB2RzadVMkC90AtRBgZoUg54JkC6psiuTQ9Rc
	VQ3gc6sE5dVY7rpYvIMv0mV/AOW3RL8juPb40
X-Google-Smtp-Source: AGHT+IHfaGgUC3GZmP/ZjkPLqAOan1utPH+5wn7DCp1PqPflW4iQaEEEvOBGaYKfRATRuUd7owbtFa2gNwEw6J77XQw=
X-Received: by 2002:a05:6402:5194:b0:5c9:87a0:4fcc with SMTP id
 4fb4d7f45d1cf-5c987a050f7mr2705311a12.16.1728980398698; Tue, 15 Oct 2024
 01:19:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014201828.91221-1-kuniyu@amazon.com> <20241014201828.91221-9-kuniyu@amazon.com>
In-Reply-To: <20241014201828.91221-9-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:19:47 +0200
Message-ID: <CANn89iJuLo8y0frrcyK1RMbP4K4mfkOKdr2s93yC6_STtdRfLQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 08/11] ipmr: Use rtnl_register_many().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:21=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> We will remove rtnl_register() and rtnl_register_module() in favour
> of rtnl_register_many().
>
> When it succeeds for built-in callers, rtnl_register_many() guarantees
> all rtnetlink types in the passed array are supported, and there is no
> chance that a part of message types is not supported.
>
> Let's use rtnl_register_many() instead.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

