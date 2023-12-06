Return-Path: <netdev+bounces-54313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801F880687E
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 08:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B134A1C20A9E
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 07:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3834417734;
	Wed,  6 Dec 2023 07:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RVgXsKxL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7161A1B5
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 23:34:39 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so7891a12.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 23:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701848078; x=1702452878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrLGOurk8L5L0NnPLUV2I7uNbYLxUdBqrFGq7mAToT4=;
        b=RVgXsKxLYCuPUrDTXabS/YaKPggmrfdjbfeFicZ+ty34bG93X6Qbr7MrmwwVDkiro8
         gi8vX159tHoXz5e4VcjKjGrE90vdyimjZ6pNtipmXzYTgJMXVGba5b9kuUowW4JFincb
         Y/fR5IXQ6bzPh8WvgpIT9QWwifm1YEvNxMVPnX4U0pGUCGfFUWRcQGRTJ5oiHzOGSBB2
         SO1dQCxh4N9EMPW74vmxhmTSOHMbTVh6Mw8qLShws+tvknuJHnq4HiX3Zl9JVRtUCKDy
         OHFjmf5I6j4DwubaYzIrrpFAXHlIiAZ3LyDzv4chD+yAZnKVJbXKBD9xsv4caHCiyNGO
         /OGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701848078; x=1702452878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrLGOurk8L5L0NnPLUV2I7uNbYLxUdBqrFGq7mAToT4=;
        b=EVQ6J4b4tDKMQQi/tfX2NhcQKd8CRv15oUuH/VeGRsQSxBWXpNNd5AxTiMjgpo9bGZ
         ogZdkRIoFcXj2iine3gQZWv3Wj2yhJuBDTlqK27rTArVmQVh9JDQ2kHnxOapofEZFIot
         tsTWsu/DlBVpK86kQ285b6TIONqu1tOhPnuLYDdP2VXdgwlJkJrwuxP/bZfBgqN8mz76
         9zSccjkYtWQ6NOqqhUml792dwr6sqtyHagqnwnJXu/UB+Ae5TUFZdzcezahsgkcP8WYQ
         ZpmU6LungNmu2PfqV17OH8DId+cCVxygpCSVclDMWB3qNbjEb8N0cnd4kvtTe6j/bvPo
         zwuA==
X-Gm-Message-State: AOJu0YweoEmzhSNlBzD4TwtHemwHdQJfbb1km4vEM+iqn1d8v2Px+B9u
	I7GE50UUPbNhUjj441kVXcd6o3N6Idlgb7o7xfU4YQ==
X-Google-Smtp-Source: AGHT+IGldiRIFyGKYysUNKi5CQSdX373OFF+v40mkRnSHG6nIDPkTDJD/kDCf/0mazNx1HSyGQ9CMJ5qmSJ/VPpXWqA=
X-Received: by 2002:a50:d744:0:b0:54c:384b:e423 with SMTP id
 i4-20020a50d744000000b0054c384be423mr40767edj.5.1701848077557; Tue, 05 Dec
 2023 23:34:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206033913.1290566-1-judyhsiao@chromium.org>
In-Reply-To: <20231206033913.1290566-1-judyhsiao@chromium.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Dec 2023 08:34:24 +0100
Message-ID: <CANn89iKiG0oLhkYQj=OkhvcWyR_kfSsot_2zo9hFCm1A7u-tWA@mail.gmail.com>
Subject: Re: [PATCH v2] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
To: Judy Hsiao <judyhsiao@chromium.org>
Cc: David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Brian Haley <haleyb.dev@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Joel Granados <joel.granados@gmail.com>, Julian Anastasov <ja@ssi.bg>, Leon Romanovsky <leon@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 4:39=E2=80=AFAM Judy Hsiao <judyhsiao@chromium.org> =
wrote:
>
> We are seeing cases where neigh_cleanup_and_release() is called by
> neigh_forced_gc() many times in a row with preemption turned off.
> When running on a low powered CPU at a low CPU frequency, this has
> been measured to keep preemption off for ~10 ms. That's not great on a
> system with HZ=3D1000 which expects tasks to be able to schedule in
> with ~1ms latency.
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
>
> ---
>
> Changes in v2:
> - Use ktime_get_ns() for timeout calculation instead of jiffies.

SGTM, thanks.
Reviewed-by: Eric Dumazet <edumazet@google.com>

