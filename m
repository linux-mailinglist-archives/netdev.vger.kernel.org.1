Return-Path: <netdev+bounces-100841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E498FC404
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 08:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0399D1C21E90
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 06:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B0316938F;
	Wed,  5 Jun 2024 06:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ckK9JfBG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A43190466
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 06:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717570695; cv=none; b=farTzHczeT27CsyjOPAWwAXgAtS/GasGdomosoN5VT5m6A945SIb/SqF2pQRjf35WPs/zv9zJvfONUcldeU6InvKWrRgZT8qxW7DACw8rW2z00GFIMUZaqn4EPneYpTQMNbnhtHfItuHwk4Q9NjnJHDva3I0Kgg1FVULVtW2rsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717570695; c=relaxed/simple;
	bh=miZ06IeCcLRV5Zx5F/6o4GSDXpiCMtM64dTPGVVkLk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ezFYPRLYG7gJ+vBMECdC6RTJ7aWqWK2bOXlIhCv78E4on+O+6VmKd47s9i4EC0XkEC05wfPENikdVvo5y3PPA/Ljc3X8DSI9PqUOf28/Ljl2xz+IzwpjxWg+IFLTz7EfYhr8ha+h3aYYBJKKTBwHcI/5hMbyK/7ybJu2IB93i/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ckK9JfBG; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a22af919cso5220a12.1
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 23:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717570692; x=1718175492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4jeAXhafmOJ3qyUvYZALUAxZup3Ci+3VokQAO+gDZo=;
        b=ckK9JfBGZl0sm1qejtBIPN3Q5k5e70yDZUBns2YAmMaaWbYiguNnRtSwbjBf08xsWW
         maVOHgnQxz1/8aQjsHvhvEZbdckjVad13PVoWfwbk9sTcWPN7b4Ss5olCnvuLOY9wF8J
         96kPJVn2y9+bvQx4J46TPmlDJzciFfdYwhGXbAVMp1APViWryfYGMW24JjuIMGWViBUJ
         Idd+lLI/rx8ZCa2LxmCfp4J5UyHJyaMkyn7JvWolABYPLJGVlWe4C2W+Yz8TvZw9iFI0
         n3zY/UfQUDNpBDo7BzndVhdTtdS3LAv0VyKNA8mbugAexQLQhk2JmBMrkFRPv+TTrc5p
         wd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717570692; x=1718175492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4jeAXhafmOJ3qyUvYZALUAxZup3Ci+3VokQAO+gDZo=;
        b=gWTZZ5lmFjbRZrZtuv3b5puqLErlIJHRcr6vjoaAjpq4cyCmMJdVYOps103B5TmcXI
         cRlGP2+gIVzopgsadZ98KTwdgQlELrUOkIGnh4jwJkXaxZsFP+P/yGfrdRa0TFh+yPtE
         a5vceAumyx4MS4TxtIHSDVL2naIkSSxFA7M4869BA2DDoPgkNQOvr6JQjO3DdGdLpNVJ
         cFBQ0D4fPO6uKOM4DhAwgmTYNo+auorE8SkoZbZZYN8UjaKTmGpXqM1O6fHSbp3RjkZE
         zpoicdu+6ggl+wotHrHmZoWDSW0wpaM2FeCtX/+DTPMHPfsfCy9jAWeAEOOKHzoXFD5T
         Tzng==
X-Gm-Message-State: AOJu0Yx0CvHSpv0d/I/ypep1hcEJTlYWGUCmXAJcTNFRNHcN95UEx02I
	aSs4PCvXG0mnBJ7JXKl/BRmEI1yxbtVqG2VvZwmUES71xDzBRmhGb5pxOdcnNWMQn7RKUaObY8R
	egSunBz2032VYu4Rt8mkEQIyRb0TXpC6ALsQvyKAWAlDMuypE2w==
X-Google-Smtp-Source: AGHT+IHkFGYs05JmQEM4+yfrqe4u6ulWVU2NmH5M/ecVI4DoRmW6x90kfgFiOiKG1HHYJT+zUzYFQm02p0ciN3R2PUI=
X-Received: by 2002:aa7:cfc5:0:b0:57a:2398:5ea2 with SMTP id
 4fb4d7f45d1cf-57a94fb4b2bmr77556a12.3.1717570691575; Tue, 04 Jun 2024
 23:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604140903.31939-1-fw@strlen.de> <20240604140903.31939-2-fw@strlen.de>
In-Reply-To: <20240604140903.31939-2-fw@strlen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Jun 2024 08:57:57 +0200
Message-ID: <CANn89i+qX2jubHVpUo6B3BAU30BJ1+0HOp2ZRpKN-qCd-UtBYw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/3] net: tcp/dccp: prepare for tw_timer un-pinning
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, vschneid@redhat.com, 
	tglozar@redhat.com, bigeasy@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 4:11=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
>
> From: Valentin Schneider <vschneid@redhat.com>
>
> The TCP timewait timer is proving to be problematic for setups where
> scheduler CPU isolation is achieved at runtime via cpusets (as opposed to
> statically via isolcpus=3Ddomains).
>
> What happens there is a CPU goes through tcp_time_wait(), arming the
> time_wait timer, then gets isolated. TCP_TIMEWAIT_LEN later, the timer
> fires, causing interference for the now-isolated CPU. This is conceptuall=
y
> similar to the issue described in commit e02b93124855 ("workqueue: Unbind
> kworkers before sending them to exit()")
>
> Move inet_twsk_schedule() to within inet_twsk_hashdance(), with the ehash
> lock held. Expand the lock's critical section from inet_twsk_kill() to
> inet_twsk_deschedule_put(), serializing the scheduling vs descheduling of
> the timer. IOW, this prevents the following race:
>
>                              tcp_time_wait()
>                                inet_twsk_hashdance()
>   inet_twsk_deschedule_put()
>     del_timer_sync()
>                                inet_twsk_schedule()
>
> Thanks to Paolo Abeni for suggesting to leverage the ehash lock.
>
> This also restores a comment from commit ec94c2696f0b ("tcp/dccp: avoid
> one atomic operation for timewait hashdance") as inet_twsk_hashdance() ha=
d
> a "Step 1" and "Step 3" comment, but the "Step 2" had gone missing.
>
> inet_twsk_deschedule_put() now acquires the ehash spinlock to synchronize
> with inet_twsk_hashdance_schedule().
>
> To ease possible regression search, actual un-pin is done in next patch.
>
> Link: https://lore.kernel.org/all/ZPhpfMjSiHVjQkTk@localhost.localdomain/
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

