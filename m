Return-Path: <netdev+bounces-83671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F186F893496
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 19:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F2928589F
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 17:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C9115F3FA;
	Sun, 31 Mar 2024 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzxvaHr6"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC09D14A4C6
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903429; cv=pass; b=qTuS4s3qspMGMpMlyfghcT2aT9ERoOo78SUXRFuAufSE7jwtK41OXveEBi8xs4mqo/feqiELnNkpkLNrAPt0LmD8orMlC9X/cd7gjlAjmr+lWFzlj5zzRSzmrUtwfb/3CKtRRx8y+kHAqDoFmbXDLm6wvFuk91xjBDmnzvPne2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903429; c=relaxed/simple;
	bh=gb0wbzYCn+s6xl2Y1JhOPZbAeNk0nN+B1cjFTzYSqac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IP1npr5S1Wtc94Wf98OFSLltz4v1tEWG/OI/DF0tjM2IJCO5amkC7wJ3yC8fIqx4O8w2PiNMQYASh1urah0PYi1aPfQoxNCGCedj3sQIZ0ocHFoIa9eS5ynC2o5LW7fDy3TvtCki7CwklRUYY/uNL8ByMkAqidJo2Vdgvg36pxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzxvaHr6; arc=none smtp.client-ip=209.85.208.182; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5EEE920896;
	Sun, 31 Mar 2024 18:43:46 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AHTdNrsHxQZV; Sun, 31 Mar 2024 18:43:45 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 2324A208CF;
	Sun, 31 Mar 2024 18:43:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 2324A208CF
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 162A7800061;
	Sun, 31 Mar 2024 18:43:45 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:43:44 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:04 +0000
X-sender: <netdev+bounces-83513-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAUJKmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3VuZXQuY29tBQAGAAIAAQUAKQACAAEPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAAAAAUABQACAAEFAGIACgAlAAAA34oAAAUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 13880
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=netdev+bounces-83513-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com D38FE2025D
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzxvaHr6"
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711815146; cv=none; b=hdKrh6BBcACwZT61TOUFqZ05malzWM+WIX7zWKbo0qlpYUxt9yu2P9NP7a/wlb578lkYNFVShP6hZFL1jpdQ4t9hDHAB438/tjfx78l7asOkW/h/5J+U3peZcRFPm2jwEuagi0RtwOD10I6+JyFQjHRYCjDroA8gxj2oiDaVzQU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711815146; c=relaxed/simple;
	bh=gb0wbzYCn+s6xl2Y1JhOPZbAeNk0nN+B1cjFTzYSqac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eiRafXhaQc1rH1KSVyVShOmhOCRKzJa0seYr05xX1xTuAPnd8Ul+a3Q1tFlu1yG2QBPTJUqFiiek+SQs6c8CUNT3yxXGUTvm/uHr/JhziaFBxXvi688krhzVqEZvE818nIAHZ0eGxOMYdj/OtjttBPK1gKEfKJz5M+9N78o47z8=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzxvaHr6; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
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
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

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


