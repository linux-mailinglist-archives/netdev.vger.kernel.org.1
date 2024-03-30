Return-Path: <netdev+bounces-83513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1DC892BF7
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 17:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C2F2830BF
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 16:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C713C473;
	Sat, 30 Mar 2024 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzxvaHr6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955FB3BBCC
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711815146; cv=none; b=hdKrh6BBcACwZT61TOUFqZ05malzWM+WIX7zWKbo0qlpYUxt9yu2P9NP7a/wlb578lkYNFVShP6hZFL1jpdQ4t9hDHAB438/tjfx78l7asOkW/h/5J+U3peZcRFPm2jwEuagi0RtwOD10I6+JyFQjHRYCjDroA8gxj2oiDaVzQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711815146; c=relaxed/simple;
	bh=gb0wbzYCn+s6xl2Y1JhOPZbAeNk0nN+B1cjFTzYSqac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eiRafXhaQc1rH1KSVyVShOmhOCRKzJa0seYr05xX1xTuAPnd8Ul+a3Q1tFlu1yG2QBPTJUqFiiek+SQs6c8CUNT3yxXGUTvm/uHr/JhziaFBxXvi688krhzVqEZvE818nIAHZ0eGxOMYdj/OtjttBPK1gKEfKJz5M+9N78o47z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzxvaHr6; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d700beb60bso52310421fa.1
        for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 09:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711815143; x=1712419943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oplGzIl08heQJGCvOWbH0pzNYHmcuI8DAip8sdVS/cY=;
        b=OzxvaHr69gBbJTCkvYR0OqPROzYrJKkzbucNW5LL77pqpu8GKrRMUqWtjQV/gkW1xH
         uaqOXLmM+WFA8nNPqYeaLMZ7JIrrrNh3G54hFMgJVqWb3eGYvz+hCi5m6sxFrgw/Il4I
         pMfOJJI1OmFebNjrIv9ZufswBHxA/z3xCH91oqfwB3Bj02l9HT6ARjhq+YwJl1WJieBq
         T6zXCB9V73ZtQO0bpH6/PRvHQNsbhqGTpHjbvofac3CN4U/45ddDO5+Fx3RGuS3Yb76l
         QW2uw3uR7x7vxHgElMiLC5EqghLJpfd7qLK6pLuRrS9unwyLFijZOHEXCf2uLrKQVWt7
         WIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711815143; x=1712419943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oplGzIl08heQJGCvOWbH0pzNYHmcuI8DAip8sdVS/cY=;
        b=GE+THAkI00TGTaevQYJ7AsZrqpF4lD4Vo37rL0GFoDXup5bDbz+7sWoHHkLLDjjsrM
         hIJWmwOTv6M9ThbUjbQ8Skv4h2aTiM1drKd7eCu4bgWeqj7LK0kDBlMVCdBqxVqy7woa
         /A0PguAabQY+yuQqafqV6Wq63yGEfM8yPtRL21O8idBxZefG+ft0ZhJNn36PHjTbaD0v
         pgCwfxmCJ6aEllra5g6SZafxXv1zjQ0x9ziymC3ZmCE15hHiO60SxDrPXuo6Fr6k6Yra
         uHHIureAN9QQoc3DjBytUyKQUxn0zXkh3uNLAwxQw6opq93zGHDhsmK8cmZMG0VtvoO4
         tevg==
X-Forwarded-Encrypted: i=1; AJvYcCWxWpRKii/DR5oiFxu1vGqWMSF5JaJSiBbEdbJqVrMC8LohaIRENzyDk+S1Pf/b4zP5Fo2qVEUSSjdil2fN1B1QssK3sxqV
X-Gm-Message-State: AOJu0YwiphxSg+qAp/JHs7HYkQgF2hc99NsIbVRJIAB8MY18JCTp1izK
	GXhl9k1vDw5ESK4oyqek9O/E3rhQITnRF2G9Rt5OYGoOm5ccA8NO004rgshkAOauP6x2s6G9HIW
	p6pIG7ni9S4tAi3xFuThlnbrCT9E=
X-Google-Smtp-Source: AGHT+IHHaPR/6PemL3v6Nwx8QwVHFTp8p6ZbR6H8yp2Py8jxyz/n+xlSgu1t2wgsbB3deCApO/hXOrdQ7EWBpkoQbgI=
X-Received: by 2002:a2e:91d1:0:b0:2d6:d043:f6fc with SMTP id
 u17-20020a2e91d1000000b002d6d043f6fcmr4129766ljg.48.1711815142486; Sat, 30
 Mar 2024 09:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329154225.349288-1-edumazet@google.com>
In-Reply-To: <20240329154225.349288-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 31 Mar 2024 00:11:46 +0800
Message-ID: <CAL+tcoA_LxLei9ZT+RH16w_vamy1Ka6OJDXjwJNB6kPo2a_sPw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 0/8] net: rps: misc changes
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 11:42=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Make RPS/RFS a bit more efficient with better cache locality
> and heuristics.
>
> Aso shrink include/linux/netdevice.h a bit.
>
> v2: fixed a build issue in patch 6/8 with CONFIG_RPS=3Dn
>     (Jakub and kernel build bots)
>
> Eric Dumazet (8):
>   net: move kick_defer_list_purge() to net/core/dev.h
>   net: move dev_xmit_recursion() helpers to net/core/dev.h
>   net: enqueue_to_backlog() change vs not running device
>   net: make softnet_data.dropped an atomic_t
>   net: enqueue_to_backlog() cleanup
>   net: rps: change input_queue_tail_incr_save()
>   net: rps: add rps_input_queue_head_add() helper
>   net: rps: move received_rps field to a better location
>
>  include/linux/netdevice.h | 38 ++------------------
>  include/net/rps.h         | 28 +++++++++++++++
>  net/core/dev.c            | 73 ++++++++++++++++++++++-----------------
>  net/core/dev.h            | 23 ++++++++++--
>  net/core/net-procfs.c     |  3 +-
>  5 files changed, 95 insertions(+), 70 deletions(-)

For this series, feel free to add:

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

>
> --
> 2.44.0.478.gd926399ef9-goog
>
>

