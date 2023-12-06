Return-Path: <netdev+bounces-54533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7E2807670
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1391C20A9A
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AC860B97;
	Wed,  6 Dec 2023 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D5MQeZ/g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DDBD47
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 09:21:44 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a1a496a73ceso144026366b.2
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 09:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701883300; x=1702488100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaGi8ynGM0sSJk2cTHVa3nEhLRrFYa9iM9DZek/jE/U=;
        b=D5MQeZ/gXYCtMOa4/nL+W0QBofAy1ruXp7uqMLykbemVYDW/4RPGjsZw7k9542PbyH
         Tat05egCGHpq5U8zwd78UufQ0qkkvOK6skxvp20/Baq3/lQww2Lk2AqcoAasdVAgJxTv
         WgGb3/XNA3o9RjDF+FOAh3POgoGann7NFe+zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701883300; x=1702488100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaGi8ynGM0sSJk2cTHVa3nEhLRrFYa9iM9DZek/jE/U=;
        b=xMJYJmReEqsVEbw2hoX6QZJiZYeIIElUc2Hyx/pQqvehB8i7PX8kd6yw3BfG2GfBAH
         VPHpJIoaiONj86Rq6mBV5UVcnPd5gpDwln8ztvlhhfKgz4KAMl7zmxsTLP14mzkiUp/j
         8Ye21uFbSWvcyvJRaoGJWVSa2symZNYRtjB0s0RlFnpHlGXbi6RZr4X5S50sGJKm1yY9
         wsN5djI8nHr5JP6zk8pnG0ApiBtxjZXKbytwOYxAc5b2d7d5tcs/rRyKzpUfmS4u6UKk
         5cCzoLU5kQDTqtpheX/z47ePNRVZ4rpuIqdyzkGtry2k6Wljn2EUSGr2o2YTGKYWeXd9
         SfOg==
X-Gm-Message-State: AOJu0YzkXCQeDvMzHmHecAZ8H1+fD/KCrPdaVARzZ0R76fCqucu8073R
	aVB8fdy+n3jocZHDnyh8YueVGztrG10I62mSYSu0kUCU
X-Google-Smtp-Source: AGHT+IELor0YGeZuJdAz2JdlCwkM5627VRDbhNY78JEZl0SjSWpfBb0gYKOLTSq2iPwCt7Sr+dFghQ==
X-Received: by 2002:a17:906:198:b0:a1e:6f75:d9f6 with SMTP id 24-20020a170906019800b00a1e6f75d9f6mr37195ejb.74.1701883299823;
        Wed, 06 Dec 2023 09:21:39 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id gs1-20020a170906f18100b00a1df4387f16sm197943ejb.95.2023.12.06.09.21.38
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 09:21:39 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so79835e9.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 09:21:38 -0800 (PST)
X-Received: by 2002:a05:600c:22d8:b0:40b:4221:4085 with SMTP id
 24-20020a05600c22d800b0040b42214085mr87519wmg.1.1701883298586; Wed, 06 Dec
 2023 09:21:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206033913.1290566-1-judyhsiao@chromium.org>
In-Reply-To: <20231206033913.1290566-1-judyhsiao@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 6 Dec 2023 09:21:21 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WCLB2M1jGEa5NM=thEmJmntV1sAqg11iLH0uizwhN2eA@mail.gmail.com>
Message-ID: <CAD=FV=WCLB2M1jGEa5NM=thEmJmntV1sAqg11iLH0uizwhN2eA@mail.gmail.com>
Subject: Re: [PATCH v2] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
To: Judy Hsiao <judyhsiao@chromium.org>
Cc: Eric Dumazet <edumazet@google.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, Brian Haley <haleyb.dev@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Joel Granados <joel.granados@gmail.com>, Julian Anastasov <ja@ssi.bg>, Leon Romanovsky <leon@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 5, 2023 at 7:39=E2=80=AFPM Judy Hsiao <judyhsiao@chromium.org> =
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
>
>  net/core/neighbour.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Though as evidenced by the discussion in v1 I'm not versed enough in
this code for it to mean much, the patch nonetheless looks reasonable
to me. I'm happy enough with:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

