Return-Path: <netdev+bounces-205467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D1AAFEDB2
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC9E174BA5
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7AC299ABD;
	Wed,  9 Jul 2025 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7S94nnE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38272E7F20
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074812; cv=none; b=sG7+UH4Hn2ql8wa+J+kWmDx1Ywvyy9dJCfYMAx9t/TpRO9PaeM1RHciyLRP0uMkUGtlgjuWPecpYlggKCqxNLz/5tT8Nyay2OCjAUVaVWKVlDZvmSyu/v9uomWCUhmJouilwN1wTY1Noepaqe94Ojz7snZOHo5iS+9cNtIbmKDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074812; c=relaxed/simple;
	bh=Lf7bJFk3uV9MKQuav7jQz6/MttJtMdGad9u+KUEboXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXLL01wD1YissYAuQ7DF43gm6Ob22mJtt9CS+wm8kxfRYaju3dlndSR7sMm8hipP+2ihZSnSPV3y8lwC4VAEY945x8xi7f+y+KSdo3qAnV/WUf1zHcbZqXXX13Cz9PblKN1cF5LhXUpNZyDaOPj95MkxU60Lj4whA2z5IVocdFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e7S94nnE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752074809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lf7bJFk3uV9MKQuav7jQz6/MttJtMdGad9u+KUEboXU=;
	b=e7S94nnEGpSrKl0vjipYKF8SDOGfV4owufizDIvNlO0d3nq4F1+J3Q9rnuJfIZuz0PrlyQ
	V22Dsxm68Y6EPeZ5O1wcwnFTSje6dmk/5Vfje/3vpvVLhnkqh4zvF2yIH797UUrsCxVbLQ
	zd+vH/cbGBw0euLrC2d4pwUdrrRi4bE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-3Vw5VH1tM6m99I8tWqPklw-1; Wed, 09 Jul 2025 11:26:48 -0400
X-MC-Unique: 3Vw5VH1tM6m99I8tWqPklw-1
X-Mimecast-MFC-AGG-ID: 3Vw5VH1tM6m99I8tWqPklw_1752074807
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-70e7f66cd58so503197b3.1
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 08:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752074807; x=1752679607;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lf7bJFk3uV9MKQuav7jQz6/MttJtMdGad9u+KUEboXU=;
        b=M/UOpan4/xQ1ngGdx1G1rAJ6vPCZA9WDvhix8V5Ku7ITB90u1X2xmHjetDLoq8aDrq
         D33Jd1AHVnqpT/VAOLhAMREnvd/2ddF0aCW3GHWfr+KvtvHB9y9elwZr1Bbnz65+Y6mk
         22WDyhoFDN2Y7XqF+MgKkhL9pu+SZPvwgbCS0rAFylJ/pBGFnmRSb4KXBnOkAtc4LOsM
         IRc081RQZWkvUqU93UHvmCjDFY11kk6ih8fd9srhDteRTEO1AYwa9+3RSkAiVKDISfyP
         incUWXq1L+4iaMI9NaoYpdC83227smvfRy6/9dltmkEj0+4LWQbmBAIweskH4YIVVs2n
         zIrw==
X-Forwarded-Encrypted: i=1; AJvYcCUbMtsiavbRZIMRzClHuSdigGgJa09xPPy/KzfiZkRsC+9G5NVbRgQSHAmdiNZERcevJrzuACE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVxZLxSeAI6vPYGgrbycV+fK4C24UeoRSZcL/6mAoNVYvTBkRQ
	NLtajtnsoCpeH4IS45trZQiD8LyECxqvn8OkUVZwMsF+tW8WOHBbAIhBvDMYIuNjqzQOAL911Yr
	uK/xXj8mL42rx41pDEanjXPno4B2LkodVl8x8+XyXdL1YejqHbNPrMUeAoGZHRqUlZFZ5OPWmjG
	2rXw2CkRyoc/vxHsxGuxC7Qy9noYAuUQVj
X-Gm-Gg: ASbGncuxvNeSuHrZ6W2gdvqG/zZvlaDOhwfxkaUEICmbTQbxreTdb7T4i+YK1U790KA
	gEB+toY4JD6X7kO6fxBmonIUm1U1mkLyLa653L5RPKhM5wUBuim2zY8MRGgr32yx0+bIdyK/sWa
	qB5TuM
X-Received: by 2002:a05:690c:4d83:b0:70e:326:6aeb with SMTP id 00721157ae682-717b1696280mr41605377b3.10.1752074807402;
        Wed, 09 Jul 2025 08:26:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9oyUbfKLC5sveWj0ptirc82cNeL70EgaNkak6GlzIurDedMJZY/972EbTHi8rpQ5YCU07IRWEQOOiaTHdLVE=
X-Received: by 2002:a05:690c:4d83:b0:70e:326:6aeb with SMTP id
 00721157ae682-717b1696280mr41604877b3.10.1752074806659; Wed, 09 Jul 2025
 08:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <472a5d43-4905-4fa4-8750-733bb848410d@linux.ibm.com>
In-Reply-To: <472a5d43-4905-4fa4-8750-733bb848410d@linux.ibm.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 9 Jul 2025 17:26:35 +0200
X-Gm-Features: Ac12FXyNj6u4xw4GpaDSraC2WH1PFh63NMAa2Sk2WZqN1f1LqOBvccFzhXYQrfM
Message-ID: <CAGxU2F7bV7feiZs6FmdWkA7v9nxojuDbeSHyWoASS36fr1pSgw@mail.gmail.com>
Subject: Re: [PATCH net-next v4] vsock/test: Add test for null ptr deref when
 transport changes
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: mhal@rbox.co, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, v4bel@theori.io, leonardi@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 16:54, Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
>
> I'm seeing a problem on s390 with the new "SOCK_STREAM transport change
> null-ptr-deref" test. Here is how it appears to happen:
>
> test_stream_transport_change_client() spins for 2s and sends 70K+
> CONTROL_CONTINUE messages to the "control" socket.
>
> test_stream_transport_change_server() spins calling accept() because it
> keeps receiving CONTROL_CONTINUE.
>
> When the client exits, the server has received just under 1K of those
> 70K CONTROL_CONTINUE, so it calls accept() again but the client has
> exited, so accept() never returns and the server never exits.
>

Yep, I saw exactly the same issue while testing a new test.
I already sent a fix:
https://lore.kernel.org/netdev/20250708111701.129585-1-sgarzare@redhat.com/

Please, send a T-b/R-b on that if you can.

Stefano


