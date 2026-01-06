Return-Path: <netdev+bounces-247451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A84CFAC47
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 20:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F28F7301969C
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 19:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFEB2FE58F;
	Tue,  6 Jan 2026 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZVctNM7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F7927877F
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767728611; cv=none; b=pYcZTzC5wpP5gLxNEqlq/8ZEkLXz49RxR+v/Sg1hXvw+1BUpnEwISsRte/N/hAk7xjox5rGsruQjTtWsoIqrtIlqPLb8dFOL5G/m95iukWZmn5emrYABkBOalBns1pcBwgrvY9rk7i6ANE2qfzgpLvr0y0UYMRkOp1E2P4H38U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767728611; c=relaxed/simple;
	bh=GA7qajFf0TRlUXrQhvlZlLW7QVbHr3IJsSXWDfjHW8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cG4pzJ0MKVPAyypJYh9SQ5dfDmDnoLMt0CYd/xUTSY8nFTSGjuSxvwkMpsF4XEuMQNE+CK9lxfnFNqQOiyFhklzDIHsvdy3KsnGo/Mv7PBg2qXVk4gaX9KwxWSwqtRudueaLpGRtxgtKNODP44kQgUxwlcbRYrKZNtxbzhULFbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lZVctNM7; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c24f867b75so127465385a.2
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 11:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767728609; x=1768333409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7oDQ+5QDGuRHwbY5X4yJNRMmxu0zMUbgLFmRN+ThAE=;
        b=lZVctNM746DsTJsFQpnnkie0aAPuGwPT/4YRFk/6CO0cyANCrzkB3GYkc9ystf6vVU
         P2A5xLg4jdlldIPZFQTUpvpFgJulbBlHSytuolSpVgvLWmcMtFORG9QaKoK7Y/1P0AB7
         3ZDOagYbYrxzd5ARZj8kglzgXKXOATmplP1oRsphzS6i6S4pTz3HiyfknhL1GAnCh1Wg
         Qb8m4OKjbxoQP+7QxGqfPzvomgXSoxxZtY/3/1Q9c+HG/R5yMXUCUpIayZzve6HOi6B5
         B7PysKmpGT/kw/YWKC9teoY7uuMDqVKVQY6vqkUpnKGNdGB1KhRP9eGS1IxpESX7QojZ
         Q8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767728609; x=1768333409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y7oDQ+5QDGuRHwbY5X4yJNRMmxu0zMUbgLFmRN+ThAE=;
        b=jRZaWZyQH0cq0/0YrLm4mS+8AhGNof++Y4y/wDYBW2i7FwhSRLW9UCxb2a18qqBWCx
         xvfFfDdDyrzXNGwidNpXzXjYocePo/ErHbj4l86I3j0AzPq9fNnzEXKaeuqTvXoroYW6
         3iI3w8ln1bfAGHMWf7xnZjSGXcnRHIyaBoWIq9ylS36qJ14cpWhaeveRvgGa6bGYIWCR
         oGGN83AWTN08uPR7ii1A5MwddaZ3KUHEYsgEuqpUxxK7iT3gYSJSHIPW+er6yAwuzCpS
         Ck92xh0HY6ZjmSUaxAPlQnWTKSiqdsQCRVBm+j6A62jDzZOHo3+m/LzwuGew1gQF9Ziv
         gepg==
X-Forwarded-Encrypted: i=1; AJvYcCUGU/F5Bsr/62nqeMejr2n50rNaOv/XpuclHzlobNDF0q8haZ0Gmygg+6xyM/ajr9FcEco+mqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9hwzzH/d8IuKSyQrgBHL9NqahR2/aVcOpMvwKdSFr6JfYHZOz
	FllFTBXxe4++0b6cAEQTXN8iI7Vg3Z8moCU6bwHL46+pSR2vhyq64nX7le8FUK4I+3zIV8BimO6
	uvJgkHPfxRgfr5Pxegtx1JKlOdKvC0A8oNaW7W5mf
X-Gm-Gg: AY/fxX7hdNxKV59lnilQDw0FcGT/YUz1jeUMOOBOJYVlsT/0tFJeOVqEPkQu4txiWIR
	6lAtmmqEekzQZvzae7fXyN2ac8GuBMIsGqdpqBRV78WfAS7BaYJjUSHlyGVsbhBMYSPFLRM/yFR
	VN0zLzOIZQThPH4BbU/MJy64fi15JepK2/7OLRFBBakTilFvCCs91E5kKBaD9IMpPPQP4bvWvIc
	/7kxOyCyiwbRkqUXhregEi8Qbq5RBBAqix56kYHPV59UfGcJQ4Qt6qOO2Yehj3XU0UgKMY=
X-Google-Smtp-Source: AGHT+IFq7FW+Kam/KPi0SOcblNj7LHO2uwuAcX/mLJj5tajl2Jn97emaElfzYq9O9U55qEDmKYcnC9EJ0P8ZnxLJWZg=
X-Received: by 2002:a05:622a:d4:b0:4f3:581e:f49a with SMTP id
 d75a77b69052e-4ffb499bf70mr871191cf.42.1767728608620; Tue, 06 Jan 2026
 11:43:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106164338.1738035-1-edumazet@google.com> <20260106113041.18423d86@kernel.org>
In-Reply-To: <20260106113041.18423d86@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 6 Jan 2026 20:43:17 +0100
X-Gm-Features: AQt7F2qB-Mxp2VPiiy2RP1xlYtuhp6FmA94_zhungYqPDlw6dKdUeRnPaCk6674
Message-ID: <CANn89iKzd7LHOtQCKjTHN4a0uzbAv8En+QwzYy5HT0fQ1W3n+w@mail.gmail.com>
Subject: Re: [PATCH net] net: update netdev_lock_{type,name}
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 8:30=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue,  6 Jan 2026 16:43:38 +0000 Eric Dumazet wrote:
> > Add missing entries in netdev_lock_type[] and netdev_lock_name[] :
> >
> > CAN, MCTP, RAWIP, CAIF, IP6GRE, 6LOWPAN.
> >
> > Also add a WARN_ONCE() in netdev_lock_pos() to help future bug hunting
> > next time a protocol is added without updating these arrays.
>
> Looks like we're missing ARPHRD_NETLINK

Thanks, I will add this to V2.

>
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/bonding-dbg/results/462041=
/14-bond-eth-type-change-sh/stderr
> --
> pw-bot: cr

