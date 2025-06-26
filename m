Return-Path: <netdev+bounces-201606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B25AEA0C5
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9186A0B34
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD192EE619;
	Thu, 26 Jun 2025 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CdItKguO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B722EB5CD
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948333; cv=none; b=utJd5Qs0EbXrw7IS8S7szoK+OZumHQrgiaDi8dut9d/w+mXj1ARo0WSUl0NF2TTmgv+tt1SrfbkBAlxfR+2/793YrR3ZXxoJXs80mRSG0I+Nh3mhTl1IwrFuXxFkUM2uyLQ2PXqRY/ZzBDvVM9gsPNOj0U9j1rHUPQCtWv8fEEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948333; c=relaxed/simple;
	bh=ODgo1OAXRZN3h1Y9ghBi+gHZTnbjxmAf+9oP90cdj04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnN8AAovh1fbxhxIdDK8Oe1quMCXLsON0h4n3yW3dnAmVOvDYk+M1HurIP9MuFFKPNteqpOMECpxGaVya5TWqsKEiXA4HTJcn+HCGe5WrHBHWDxR0e1YARB14uG5/61eks3Bdzdeo1srAE8T6qZ7El65ItmBciFPyIyggB6d2Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CdItKguO; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a42cb03673so14975921cf.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750948331; x=1751553131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODgo1OAXRZN3h1Y9ghBi+gHZTnbjxmAf+9oP90cdj04=;
        b=CdItKguO4vUq02mvfP4t1FQ3GP2qor04St/52p6ZC9gLvZxLUGCAR6NaNc+F1Z7h6g
         8AXeY4/ASvGUJ8CJ9cowGqPuNjWuMTa88zcF/BecjG7g2NbhAiJdCKQ7pg+QfkHAmVmu
         JSl8aQYkuKnKVm/6mGJxHDBfDtoCyqxl9Vr89ZrhKqEx5iUOdlk1EesjFqADwKV558q5
         DXZ0NKoi606yOdF+TtSA9grW0T09q3+n6sozCgOzihp06SUuDZhnRTq6V6z0rZsegu44
         wOT12W96Ibf++FAQ/T0jWEFhro2wCufpV6htSUdif+Uii6ckq5ytK8RDhyHvNAZ7AADf
         O/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750948331; x=1751553131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODgo1OAXRZN3h1Y9ghBi+gHZTnbjxmAf+9oP90cdj04=;
        b=eCb6xrq6dnOsnme791Wi1ifu4zJuA88SftlIo7D0TiV6mvJCsTV9d5ps15pWjPicSY
         Onxsx2BjSe7iQCIbYLnJXltAkZVSGVOU1/EdsMmzK3H8g/M7hQsilo+/b4JL5dfLfwUs
         rnOfXUDZZvuNhHR8zbiwlzo6xDqFKkToL6Kp9lEO+qWFzK9Na1UVuY0sNrN1foKa8PDQ
         VruygOM+VPcBNMIpzkBO+vY58wDe6TDxr3bO9NO81zK5amsW+daPRuBaEPxJ22lj4ues
         kJjJzrxUQkVenOtw7maZ8BN/n2a3KzWX50mX9EEVf8Gq6Sx21JgGywcWoyUtUJKe859W
         G/pA==
X-Forwarded-Encrypted: i=1; AJvYcCXfYxjZlxlTw8I+7pOpGJ96tHr7/0toCsxNOjo9/eNxeRWBw9HIF/1JTTJfvD6mqMqRVDzmkwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA6TrENO5ZzUAan+xu2g9F7AS6KToGR/kOSE20+K2nUxQjTVlj
	iBrTCrxNgoCNh8vT3/mzrZdqIObzWv2x7fninKY2n2bMVFG8oqDCiLpwwpcVgU8fJFxlTY2lOKU
	OOnjgI3zCikXSYv92upx/tLlIpZ0knoFC+3lX4upB
X-Gm-Gg: ASbGnctClj2w/LgpWX4liEA4ClCa9UItXIy8zclu6zmM0jU1B0Rp2wrD9+LuhV3Z6h5
	TokBMgPYSIqMaVqgttdf09DvI5zpFLkY4bKWxM0q/nI66CiG4NvMF73uikPwH6lHfAmFZ33sPRB
	zW90qxBlxA7cj5yLU9NVcqCRH6lwz9Aw3Mp+3FII/pJGk=
X-Google-Smtp-Source: AGHT+IE9Nd9ekyNJ/35yAYkWP75avlwRt7KSeWaA6NTmVWMrUseQhShr4vsPAVztmrlPKJRtrgd7k0P2wQx2VmWRO50=
X-Received: by 2002:ac8:5a43:0:b0:4a4:2c75:aa5a with SMTP id
 d75a77b69052e-4a7c07ca810mr122506881cf.30.1750948330908; Thu, 26 Jun 2025
 07:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624202616.526600-1-kuni1840@gmail.com> <20250624202616.526600-5-kuni1840@gmail.com>
In-Reply-To: <20250624202616.526600-5-kuni1840@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Jun 2025 07:31:59 -0700
X-Gm-Features: Ac12FXxAAfNVQK94sSMYfysHzA0phrzZriEM4rDnW3hyeTJYF62hSpfbneByFlo
Message-ID: <CANn89iJ6H5BYDzv2d26-u5W=GU7stN4YJQUZwVhaD5fNcA6=Tw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 04/15] ipv6: mcast: Remove mca_get().
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 1:26=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.c=
om> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@google.com>
>
> Since commit 63ed8de4be81 ("mld: add mc_lock for protecting per-interface
> mld data"), the newly allocated struct ifmcaddr6 cannot be removed until
> inet6_dev->mc_lock is released, so mca_get() and mc_put() are unnecessary=
.
>
> Let's remove the extra refcounting.
>
> Note that mca_get() was only used in __ipv6_dev_mc_inc().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

