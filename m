Return-Path: <netdev+bounces-236847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87139C40A95
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 16:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D211A4503F
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 15:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AF03016E8;
	Fri,  7 Nov 2025 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NarajT4B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA63C2D29DB
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530474; cv=none; b=joSqsdrldLNIyI+tvGBrP7VIaPUiEC7WIb6dD2y30bFIPFHqiRorTOc85Z2JnfXqBYQ0w9Ekdj4EBfQ/vyg1bp0YdhLrj8+ISMoLmNPnTM0csnl7tUNhl6AcHjG67l6i4sPokrtn+RUZs8hWAAhvBJH6VdbKweCOBwPYFHGa85k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530474; c=relaxed/simple;
	bh=QaOwRoCREX8jr3W8+fijwDjxpbV0NrpIzkmcRob7F4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVHgq2NQzFR33AGxoVmQkcbj8nhbjXdINJNZ4DAHm6+nSrEYMjsZOulDFKjFmK2cIhDB5aorEk3NSIsCGLp5ZY3h8w9q0qVXXCUOJfmMpWBJCpPo68rfTko2gX0ZWrPdfJxQJPECeSxQ5YXrIz16YEjaseri6+GuR7I8uJazbI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NarajT4B; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-87dfd3cfafbso8588926d6.0
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 07:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762530472; x=1763135272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaOwRoCREX8jr3W8+fijwDjxpbV0NrpIzkmcRob7F4w=;
        b=NarajT4BGKvw4SnqBX3wkC3d056CC2gHu6o02CNU/7kUQ4JlZm+BXieYAAJl58gIX6
         5MJtj/1m9/ckWC4UsHB3Kos+My7othQ1i6mkUeI4OwRyTQEm4AsbutaIPHBDu0frhHc3
         xlB0+rjbM71pxgb6ugjphbw0/7AWL/wli8Ou+t+uXDzCZpWMCBXi+2mr5KpVfkoPtBcb
         /XNZ5l3zs7XCcCXWk+qJ+SNKF0MlVcMjMFNp2XjIKw528lv0Nge3AZxNBQVg0SOUJJIu
         2tNLdRiU3h2fwOSABWzyauT+VVPKIMqRFnTIZ8k0Z1ig46WwWEJMPjyB9ubFumlBB6Cd
         N/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762530472; x=1763135272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QaOwRoCREX8jr3W8+fijwDjxpbV0NrpIzkmcRob7F4w=;
        b=S5jMMOxA+isVTVauGDhxaiPXaoBYwUGjfl7XAAjK1dbZQ6ES1EuADyePBcvZj3uYis
         dMvBVa7UMQ+b0nWHD7/l8Nr6pgNsc61rFK/9w+VjQQ1MppX7LlaUINR1qTKfLLPqzUhb
         2WWfqnIsQWi3ir7wU34icejB4iH9J88mNV2pbJNnKS3RPB3xhM4MIPK6DqQwnM+kWSVK
         9avkQRa6+lT50AsbAK6MoWsGCMrN0CqAhSmmCf34+E7M93Eqi0DKsBKOYqjc2o7igv7+
         6Uy0K6+a0cm3W9KzNc5CQxbKk8faN101maS+FIt4cfSkf2aaQhh6ovqkHBRkL0n30bO8
         6OvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSugcpgGU+PFrk4Y2Rqn6T7zq3w2WMg/MSed3fzuD3ORHXIOsT/G7ILeQCBvwF7EtCsM7pjnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAiqt1R0vCeRzH6AlXyY5KYYYtId4G2fj1KwNr9r1SQuBeBIpr
	nEIIvai6zd5dqEf+QQJeUV1T5l7kRhNVCcdiSDkMkW/nN7Ab1GX+QylRIBuWCEbbJWzJCn7mpQ2
	N7gUQi+ZGCLe3heTJYsCWXIbrUaXsjF8b5rddY320
X-Gm-Gg: ASbGnctdJeQkN+QcYIyFHfeZhZFD+T2+H63lq+dTPTPNAk1R4kAyDSM2YP4SgwH1byk
	gyBH8shhgbtCEp/Oe+u40djBGGqVwqwU240X5qPS+QXI6I5CDjg/kte54LKavkxjajI4qjOjQrz
	R2XQSJewDXy/JILg5gdsEzFA6nXAwXiHI/aLoOeeGraZk5zj0ACR5RRSTFEE9WWT3Vr77CNNz2b
	m43sKAukvgVHtWk+yirA5VGq+QAZxcwgzMlglyqVFRKSdIsBhkhJg0Hvcpk
X-Google-Smtp-Source: AGHT+IGUVDj/jFcuFj+/ECTN6ZzUTiALpsXnYVqV0YgRr9ay9dbvKVgSYeOau3bEfGsN+dZCYDlj5pdHrYGaREkMSos=
X-Received: by 2002:a05:6214:1d08:b0:87f:fb1b:ef95 with SMTP id
 6a1803df08f44-88167afcf1dmr43109536d6.8.1762530471248; Fri, 07 Nov 2025
 07:47:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106202935.1776179-1-edumazet@google.com> <20251106202935.1776179-4-edumazet@google.com>
 <CAL+tcoBEEjO=-yvE7ZJ4sB2smVBzUht1gJN85CenJhOKV2nD7Q@mail.gmail.com>
In-Reply-To: <CAL+tcoBEEjO=-yvE7ZJ4sB2smVBzUht1gJN85CenJhOKV2nD7Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Nov 2025 07:47:40 -0800
X-Gm-Features: AWmQ_bmrjOWjVZdDiSzZFjbTgn3GFS9iPmjobaT1ACjnNfGOBjCXjrqXOiVGjw4
Message-ID: <CANn89i+fN=Qda_J52dEZGtXbD-hwtVdTQmQGhNW_m_Ys-JFJSA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: increase skb_defer_max default to 128
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 7:37=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Fri, Nov 7, 2025 at 4:30=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > skb_defer_max value is very conservative, and can be increased
> > to avoid too many calls to kick_defer_list_purge().
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> I was thinking if we ought to enlarge NAPI_SKB_CACHE_SIZE() to 128 as
> well since the freeing skb happens in the softirq context, which I
> came up with when I was doing the optimization for af_xdp. That is
> also used to defer freeing skb to obtain some improvement in
> performance. I'd like to know your opinion on this, thanks in advance!

Makes sense. I even had a patch like this in my queue ;)

>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
>
> Thanks!

