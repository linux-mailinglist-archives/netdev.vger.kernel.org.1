Return-Path: <netdev+bounces-239363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CD4C67351
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 05:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26C364E1E39
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8FB242D6C;
	Tue, 18 Nov 2025 04:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tsb1Fksk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A945F2417D9
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 04:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763438585; cv=none; b=dN9MpboXS0WPAMOR2UGQBwFxu6Xv7gRqCEgZQ8PZF76ogtjJ45DHptQZW2mbgBqyJ7cSulsr5VikB/5MWFcK4GKx04/SIXsYMBLqYkdTUld8PU2TjDX2HZMwAqb9ba0GL4HZHKn33ohbiW2uy2hL4Z9nREekTKoBotiqZrY7aI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763438585; c=relaxed/simple;
	bh=Uzw9Cuh63BvABwkj6avIY2DRSS7wbNAskApB5MZfb1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LR1ZrP9CIzTnrnkGSCEZJlragce/GrA7X/fS0r+r3w2t1NfOyClwoFs+iLvHZzLtrp1U86aEc9GmV2ZZMcjFeSYilW5CH+IDfJUj3L2dDiIgeG8oio1nd/Lo/9YeLQz/uWtlqrjmc7CaNi7NUJVmByZCB+BYxrbhm8qmhwAa5Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tsb1Fksk; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso2773996b3a.0
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 20:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763438583; x=1764043383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uzw9Cuh63BvABwkj6avIY2DRSS7wbNAskApB5MZfb1Q=;
        b=tsb1FkskgPg/5ccCCC23kGD4H0Y09Lco1t7kK9SquFNUTQMBnWvboXcBeghvj3DuXt
         6glrno9FMoI0yzX8KrUIxtKTwWAfrqOm1ZPncymuHep2Rv/wUnjaQzqL2wO9PouB73kc
         uRPVEoNrUI+FljuuxGO8/HO90SZBNbpNN5yHeuUldV6SaqSy3u325JtZRaqeRM7x2JJy
         Ukg6PGBphh17IC43jmL36GpEzI59d2l68SNlqMlvsAk7AZZ7iLKFIMtADhHqNhtqtUB9
         DsI6hL9WlpKcYPn/6OJGBpNQWOdPgEziDeT7yR7PNBmx2v4AyHmkLvp9HOQU3jg5BmCN
         jaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763438583; x=1764043383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uzw9Cuh63BvABwkj6avIY2DRSS7wbNAskApB5MZfb1Q=;
        b=pUe/U5G9q9bIfSf27eioZIxQTgLLHJvFYtlXE8kcodVV1I9ZBZULBPExSKhZfoY7TB
         OIgbxlCiDG64CY3U9Y0GC4SfMjihSkBflzKLBciT+ZwNqQgO4BbKKriyzhgXb74csJ6l
         7fwfZuwA88xv+9oHadLxAvQfyPYowQ+KzKPcbAhgbj7tpnfiF2Vt5CLgviCwnZWCzjJJ
         tTa7U/uiKhS7hD9Z7B+FoZcjxlN+ExOHTpFuImaxARpTglwSov64F3DtnicQWeoKiNop
         Iw2zqUB3NUTVAlWkhtLGUyvi17mEPpqb0+u1FTAN87+Smy/pS5jINzXkaIH+m9P+Ha8b
         prXg==
X-Forwarded-Encrypted: i=1; AJvYcCVyDYhBbE/L1tn+X3X6zUyrqkOijCED7xM8XTQHNLo5RHNvvpO42fCretifMOPy0Q0LOZPeIfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywot2e6r7c7qOXpZl6PwiP1xQ6g9FF1kt2CYIRr7qXWY8My8R9M
	CmA9mcsTWgkAIALEAG18Xfb2xnM0jN/40jE/Qid5Jp5ElqTM5z+BRNbzpcZ1L50zevxmUBwVd3/
	9ehhcocHagEns7151tB24piOJdamaViYBxavQI6qU
X-Gm-Gg: ASbGnctcgFpg1TOIB0ngFP6x+h/7Kz1V5eBbJtaI6brpta0EJ8ZPhWUkO2ZTi52TbEE
	PuZCdrJvU84k2NguE8fss5IsYO+S9gTaCHY4O3DsxZJG4Y7KI+2eZUbdnL7g4fnmzY7Cau6/AxT
	mD6IEdUXKiqEucXolVhIX/q/zfId1GW148Lpw7A98P5uPBFLLpWyoeGxSzISeNYESbLZb06eo18
	smn3K4Bk6fJgyj9pHefRrgJuwPnyo+yX5wa7IId/CQstcBYM8PQz7xajzdgLIQwuGqF0k+VbcIf
	Kp8dMPQb73LGKT4BM3iQqE4EFIMEt20XyRN/br2BfjQfRZNA
X-Google-Smtp-Source: AGHT+IGVKK16WOUWNLj3MF84coHjBOCc2JO4awTqrGx60DIuZSX8EKWn6Yn8A+EM/KKx6QEMOdeKasPis7sObo15PCo=
X-Received: by 2002:a05:7022:ff44:b0:11a:335d:80d2 with SMTP id
 a92af1059eb24-11b4150592amr5130988c88.35.1763438582558; Mon, 17 Nov 2025
 20:03:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116202717.1542829-1-edumazet@google.com> <20251116202717.1542829-3-edumazet@google.com>
In-Reply-To: <20251116202717.1542829-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 17 Nov 2025 20:02:51 -0800
X-Gm-Features: AWmQ_bka7s71xiwbFmjid9MWMFshDXwu416IZZc_QLEz_v5izsqbfJhpakNEE5o
Message-ID: <CAAVpQUA41G2ymgDVZ4J5yfba5cPYivaMD0c9QLcUCKidu2a8=A@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 2/3] net: __alloc_skb() cleanup
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 12:27=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> This patch refactors __alloc_skb() to prepare the following one,
> and does not change functionality.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

