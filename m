Return-Path: <netdev+bounces-150201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D579E972D
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F6F28350D
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E703D1A238E;
	Mon,  9 Dec 2024 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p3CIV2zx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C4B1A2388
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751262; cv=none; b=Kml/VmXSF/gaBWvF7iVaa1ZY+GcEBHYSvFd9S0KOqgzOSivKhRbdluye+bhPwfEbv4VnRQWcUpi2n4+PfQu0v9IdOnv9iu9AgtCi+zWhPshqXXbC+pgACKD4WryG+c6jJokKwEtwjvgon+yoHIazKBzTOw5F6GuvqcA8uSWacoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751262; c=relaxed/simple;
	bh=2XnCJO2Ir1RkGS9FPuM9lx46jfc3ddfFDKFy3P8d4s0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfqv3FX/F4zK5tBhjqxazw9GWdrJH7YM5Xacsh7xrBSnvKzSTgW9fX3eHldjYYs3xsRCPWjmU/yFXRnOZk3JNgl0j8cKy+9/2m/y44Ho7RGZCp7fpC/NcG0OU/JCxkiyh5TaLU4Xw5ZeyZ2IHk532rMbo1XCY78BvMr4lYOY4Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p3CIV2zx; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a78b39034dso17892415ab.3
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 05:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733751260; x=1734356060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XnCJO2Ir1RkGS9FPuM9lx46jfc3ddfFDKFy3P8d4s0=;
        b=p3CIV2zxhBVji/6bO3YfxmW4O2TcIZ1T7jgU26jtHnLoS0d3aVfNnEZNSDxuCyHzr+
         7vR0pzM/Kp+kXZUC6PvyQ0E92QZ4/HBvaeJ9vCP59FDKwdvP6iyASccT8V7mBW7gP0if
         4v8uS4G/NZ0yE+RlXkrcEXbEzBNBA17CUzOASteMQY7JewCZoVYNGE1/G9Pu9ZCndBAH
         8sQS1JmKAoaPdXF+BWtENRvFkxtWm7Y9X9F2diLyALvaPdbZKcCBEw1edJvFfwVuT6xQ
         MKZ4gwJDphkyrEkL+z+bdSRJEZb6XruAnhrn21WVmc6qD9s9+t0lFiHc+Fz1HQDOatAH
         h+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733751260; x=1734356060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XnCJO2Ir1RkGS9FPuM9lx46jfc3ddfFDKFy3P8d4s0=;
        b=q6J/GCffYfOy/Bf2qUiKu6kOj9A3atDr4iMTZwLUzh+5iLdekl/LLBK4Y8bRJW1e6Q
         lJhrfyOf2KPWOLS2V8TyKdm4flC/2OdrXRkVqbayU85RSUmbCAJIE1KAIRq1D8hprmD+
         zq5ERxq1ajDt/tNJTxhRXGrjH6n8bXrNqHcs70TEMVkCdg6fCCZK12vQ9aSdKRkkcyX9
         5fsttSYka4BWzaRRF8e7eY/83xr8ZWMLVrsWh77D13au38ZceaRtzwQ1ggnhmTxtKMMM
         B+X5Vqv90UQkBlBp6hR1A2qAVumm8wLonC2Vj/RLmhSPAPlFLWwjHqG/jQREV8ZWytGi
         y+6w==
X-Forwarded-Encrypted: i=1; AJvYcCVROy7ZoX5mGyU5lvRoYCj4oS+DuZA5Yw64lvCrToRi2v+i2MboryPUIzVheE2hhwselbkR478=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxyqRjbWlfKY//6dG+dn31AexYtIo6DfREEGhWqumGs769nzJ8
	QQz3QInc073TTW/l+VqPFjC98y1fckavX7IbTw7JRgwE2ttWqMkI1HuAhdzKjnfMEsDX8wGREZC
	U5FntTnsFfOc3uli52uDDscp7oEn8UZDIAcKu
X-Gm-Gg: ASbGncvTDxca0mOgw45uncoMtVibj8j0Y3ZkJFKdz0j/FBF3ODQMB0nANa2mvnOnJHU
	G+nECUqlAurnrto4lVT0neqWhuZoFWg==
X-Google-Smtp-Source: AGHT+IHRSd8liIwypeFGnJ2w4GP4iNsA1tFPI9rJi5aQdzanGH/U1dY5+7Sdd0pd0DZsUi7LvwuAbNc3wqFv/AS0+bQ=
X-Received: by 2002:a05:6e02:1e06:b0:3a7:d082:651 with SMTP id
 e9e14a558f8ab-3a811db1f7amr136023395ab.12.1733751260168; Mon, 09 Dec 2024
 05:34:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-net-mptcp-check-space-syn-v1-1-2da992bb6f74@kernel.org>
In-Reply-To: <20241209-net-mptcp-check-space-syn-v1-1-2da992bb6f74@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Dec 2024 14:34:06 +0100
Message-ID: <CANn89iLipfRa2jj7bXNQzx4ocgbD2C+z8+cYChQfPRwQ2SoiEw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: check space before adding MPTCP SYN options
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, Christoph Paasch <cpaasch@apple.com>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, MoYuanhao <moyuanhao3676@163.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 1:28=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: MoYuanhao <moyuanhao3676@163.com>
>
> Ensure there is enough space before adding MPTCP options in
> tcp_syn_options().
>
> Without this check, 'remaining' could underflow, and causes issues. If
> there is not enough space, MPTCP should not be used.
>
> Signed-off-by: MoYuanhao <moyuanhao3676@163.com>
> Fixes: cec37a6e41aa ("mptcp: Handle MP_CAPABLE options for outgoing conne=
ctions")
> Cc: stable@vger.kernel.org
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> [ Matt: Add Fixes, cc Stable, update Description ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

