Return-Path: <netdev+bounces-99089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D5B8D3B3B
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 17:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3AC928A1BE
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597FB181B9C;
	Wed, 29 May 2024 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eagpz2Qe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87DC181321
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716997362; cv=none; b=COgCDZFnVIyeVVDjxoGuC9Mvrs/bkfg6x9gNEk0cgpTgVLg9XrxHuQ9/Z9+HXefuD4W0ULUGrHZ8vuG06qeSQld13rA6K5Zm0eTPPg9mtP9qH2I8L7dToO1U/1QHIMhRfOd8bJDitEElkRXjivaGkPf5HXKsjAco172UivnlKDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716997362; c=relaxed/simple;
	bh=Sm0A3tOr5Lpr1Y/HFq8SiAXVhPV4YFwkMkerFXc2prk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJj4SWmRFuKCeiG9hYELFn4rtfPL5cqk2ahhWawewiKN1MMK6zWWnxTRQpn7EGs+psI+avKfHutk20FBSuAdXGMCXqAAMa2Wn8IjLT4Dm3VMJCPMLN/RVS6twjfhqlQk2fj9xAwKe2rsjzn2goHwEZoIvKgN1/jAX44RZEWSLYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eagpz2Qe; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so18911a12.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 08:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716997359; x=1717602159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUsLqmE+3pbRuNtRxo5yB/RArJM9ezRE3b0arTtCqls=;
        b=Eagpz2QeIqZuFMabN/0MU0Mbb7Kv1C9zX3kTIUv3BAWoStoYcvgTzvsEuNZf6fuwxk
         Py2PWp+di5olJlDVCxahmVkRiVn4686jV7VGKjPilfYSJv+7buCZuE9NRYhN0aFkE1qA
         k6om9JM7jhLs5Vms9zmHJnJMgBCjVyaMM5Nz9W4Tj8eYAKwHIYcRkhktFZE2UOfDoCVW
         AN+JcsRcTMPsX9mvTckhyRqdoR2dw0EtNgD01iW1lXZea+4c9FESwrdl4A71VFm62bsl
         NRWFpQKhxrzky3qfBYx50bbr8jCG5LkipoDiPX4eHXobx9N/Y8tyXZ+2j0iv9T3tMfXX
         x6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716997359; x=1717602159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUsLqmE+3pbRuNtRxo5yB/RArJM9ezRE3b0arTtCqls=;
        b=DCjZBZDo7G1kam8n/QIeRhB1ojYtVx7oCwWjrnvjRx7W7DFBbPZGo9DxB5bVsOcrr3
         QaeZ8VxwAX1/qxnJ02nGv3cZR0pHA3jklShCtVftPTUdIFMKDnRRa3CHCf5Bf9nrZqRM
         KrQhGtvjLCUEvwlzyoYO8UWZACLZ7Uqy9BE7pyFFesq+JAvmaJS5mhrRY7uRTzdfmudn
         1wf3csrx6iMIMpaYB9FqawFbYPocwX+rmh9BHj+SD8jCBceB3RtjJGM0ANLbPWGGp/x1
         fcBwJ0yRH9PCb0+YiEC2Pq5FRxAbzS3cKrhFbnWtSTZyiBXxBQAl7mglJgaiiAB0tVXd
         QXZA==
X-Forwarded-Encrypted: i=1; AJvYcCX3/JtXjCa+CLw+tMCP+R37vCzLY6g3RxcV0wqYO0jQoFGmo2aNB7CNry7ma3Ufo74CqbhsISNxmpbucoRJg4TGkXcnhXIt
X-Gm-Message-State: AOJu0Yxok0AwVLlseQhUCR0UQ7W61beVvTtcqTVc5nBQcCsrxpRVRj+S
	xjpUJpdb3CvHhS1m5VKhGT23pzgfbooCv5lPBlPwawMoE6lDcfAFEaj+34pPyqjEyxX8c6+heqN
	rbQoxoLkprpNDkymCVXFzmo9mmpNpxt3adnDQ
X-Google-Smtp-Source: AGHT+IEa+j/A03mDh/Kc5FH7+7Vnrk+8M91Hr2cMFkip2QHLgN/VqxyI0Pb7ZAKi9Nrotu1WVrjF60rj3Exj15INSjA=
X-Received: by 2002:aa7:de18:0:b0:578:647d:a27e with SMTP id
 4fb4d7f45d1cf-57a05d1e5admr162097a12.1.1716997358649; Wed, 29 May 2024
 08:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529033104.33882-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240529033104.33882-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 May 2024 17:42:27 +0200
Message-ID: <CANn89iJ93U8mxLXXuk=nT83mox1FHue+OPCkqBJ1FnHM5N9DHQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] tcp: introduce a new MIB for CLOSE-WAIT sockets
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yongming Liu <yomiliu@tencent.com>, 
	Wangzi Yong <curuwang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 5:31=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> CLOSE-WAIT is a relatively special state which "represents waiting for
> a connection termination request from the local user" (RFC 793). Some
> issues may happen because of unexpected/too many CLOSE-WAIT sockets,
> like user application mistakenly handling close() syscall. It's a very
> common issue in the real world.
>
> We want to trace this total number of CLOSE-WAIT sockets fastly and
> frequently instead of resorting to displaying them altogether by using:
>
>   ss -s state close-wait
>
> or something like this. They need to loop and collect required socket
> information in kernel and then get back to the userside for print, which
> does harm to the performance especially in heavy load for frequent
> sampling.
>
> That's the reason why I chose to introduce this new MIB counter like
> CurrEstab does. With this counter implemented, we can record/observe the
> normal changes of this counter all the time. It can help us:
> 1) We are able to be alerted in advance if the counter changes drasticall=
y.
> 2) If some users report some issues happening, we will particularly
> pay more attention to it.
>
> Besides, in the group of TCP_MIB_* defined by RFC 1213, TCP_MIB_CURRESTAB
> should include both ESTABLISHED and CLOSE-WAIT sockets in theory:
>

We (Neal and myself) prefer to fix TCP_MIB_CURRESTAB to include
CLOSE_WAIT sockets.
We do not think it will annoy anyone, please change tcp_set_state() accordi=
ngly.

Rationale is that adoption of a new MIB in documentations and various
products will take years.

Also make a similar change for mptcp.

Thank you.

