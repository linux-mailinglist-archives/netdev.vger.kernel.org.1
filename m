Return-Path: <netdev+bounces-160097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394D8A18208
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 17:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357C23A8242
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED99F1F2C4B;
	Tue, 21 Jan 2025 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HCAjZ1I+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329B21925AF
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737477235; cv=none; b=jW1TAWfNQiWB6jJeqkKIljs9wfL2EpyPqPampCH+8Oh02r6EeYtNuB689KjzsFkBOqmU3CN18EveiQ/1UOQ5ZSSw6MR7tGaH7JUFS2E07Qz0Vp5163tyobKQbDKXp1gaGgxkhDMPCY6Cv+oYs6KoVLyLaiSMse1e6ZiYIxDBAT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737477235; c=relaxed/simple;
	bh=f6B1+Dm9poLs+mWer7ufLv5Ss2ecbBYZfpvFhsrFQak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9BBCTIOC66C6469r2rPgTMnSuRnNhH1L7s3efAPeIpo5pZW151akyKF8zLS/IMbXlf8rp21eWx2pu2FGghQmFhNHcxkxeN57YGpuSHbFiEA9G70PnJAgs58ym+U1G/eOUsRXaQRYSvjt1PXxSs4S2VJXiqJiCcbesRLd51DJe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HCAjZ1I+; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d88c355e0dso11325654a12.0
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 08:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737477232; x=1738082032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdED6c/28R5Wd2NmnaGdbGB7VZbqYu2i5SPv2e68HBU=;
        b=HCAjZ1I+niL1WIQx67ApIb9y31FohrPPJKF9nJTBiVlYjmNt3h5xOg/1UZqbXsYwMu
         asaZO+i3qqRUrXr6k8jULzef6wHoJmcHcTmo9EpWKMO5HpenUH8K9tsvRLakZwSp0yqW
         JZN45i3nl+3Vy5FCrkSP0JKz4UoM+cydXAPN7ax5XDA8nr0U7/LY2DLWAFjzvcrPzRvt
         6y14oBY11BrzJwwtom5d+y9KrfwwA17Q6IViZ3zQyEVYfrLp6oM1/ly1/+36Vl56PE0S
         WeHN7xwRQes5CSUnQFKo31C+7+HVHAWuH/VECUzzFBkUvppmzkS1VzUKwHeJ3ARY1mcn
         G33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737477232; x=1738082032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdED6c/28R5Wd2NmnaGdbGB7VZbqYu2i5SPv2e68HBU=;
        b=Y5ncJEhPnByK50Thd9cKq7n6PwDj5wVrILXgiFyu05zurns7rhpi41puaYc18qckyJ
         mKqu+EFLgZgeygtUolnpBAoh6Fe4FAqvZL6tfBT6R7uHZ8POQm18a+ROef6ArjCq0+ki
         8UffwdbOWc90xZCwpqsiYbBrVY8w6pel2IiaGiyKJRDKXbZMlqfllebwjEXQmXFGuVO0
         JiAJyUYBvxg/17YsFPo5xqgItMy+dkObRC/XaDNTd2/AfduExJPuVVXoKewolvTh42yC
         AG2QB8XgjXIV+mzLbXLrK9BxuYr/zZLSCQGLclPppXjIcvYjUzwXPTH7Lfv5UQG31fpd
         m7QQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4v7RvK15L9Z0tAnBvIpG9E+f1AO/UVNKDErriKtJDXRl6Yn9YdCj65rkWhFuIO/zCMwt8o5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFfFz4gnTxovtvclhSM2tt6C+xZf2hKig/YZjTv9zp0m0G/yCR
	RbSbkbuvT7UqjFijTtxDOeVjqYZ5z2IrqxCELIfOLwSMewLmcTCik9EbCTjyyvy50CGGRhjT432
	hsnPchTIsFKQcSZap4ymTeTOwDDTaUfQUJH1TEGpkuwK/LAam9w==
X-Gm-Gg: ASbGncsS6WpSKhsN25h9/kQYMwLu7DU++Wqq8qCte6pYn/xuU4YZFZRBVdnJlmWFgd9
	J/EdeDsgBCEoNNkIGDE0DMeRZzwqtl3Cf1w7NTnbKGAUmCttWuwY=
X-Google-Smtp-Source: AGHT+IFyloJvbyPbipYoyrRMhP4LxZS49NfRALBwSPblHYSk8+BeMwLy/18rcC5lOMewJpqcCEPUQDhW7Qo/HFLO+JQ=
X-Received: by 2002:a05:6402:2342:b0:5d1:2652:42ba with SMTP id
 4fb4d7f45d1cf-5db7d313997mr17212674a12.16.1737477232317; Tue, 21 Jan 2025
 08:33:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121115010.110053-1-tbogendoerfer@suse.de>
In-Reply-To: <20250121115010.110053-1-tbogendoerfer@suse.de>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 21 Jan 2025 17:33:40 +0100
X-Gm-Features: AbW1kvYJBibR8xnvsBoxQdNF96aij6TjqkGT9g0BbYJTIg4RCGvWqHxu6fPmYBc
Message-ID: <CANn89iJLC-H_zPOoAhEowiL0_viwMOA3qFN273HyEVapwPjvyw@mail.gmail.com>
Subject: Re: [PATCH v2 net] gro_cells: Avoid packet re-ordering for cloned skbs
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 12:50=E2=80=AFPM Thomas Bogendoerfer
<tbogendoerfer@suse.de> wrote:
>
> gro_cells_receive() passes a cloned skb directly up the stack and
> could cause re-ordering against segments still in GRO. To avoid
> this queue cloned skbs and use gro_normal_one() to pass it during
> normal NAPI work.
>
> Fixes: c9e6bc644e55 ("net: add gro_cells infrastructure")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> --
> v2: don't use skb_copy(), but make decision how to pass cloned skbs in
>     napi poll function (suggested by Eric)
> v1: https://lore.kernel.org/lkml/20250109142724.29228-1-tbogendoerfer@sus=
e.de/
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

