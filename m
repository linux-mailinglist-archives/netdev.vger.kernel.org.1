Return-Path: <netdev+bounces-232589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2CAC06D28
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E89464EE9C8
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DC4238D22;
	Fri, 24 Oct 2025 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jjamd91j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30AE1A83F8
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317894; cv=none; b=LXlQGSAMJSjGmxCJxYmvvseNrGQsUYvZ094fj73s+hXMPQsunIgUgXEluJiIiA5KDRowBrtnttsKWyF2M1g8WgBMImqUZsjXAi0hwdlC3KBeAg/2T5k53MKZefPuHBInp2DGgTJqydPRaLXquXVRaoD/KbM9QFtOpN9xWlJVkvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317894; c=relaxed/simple;
	bh=ON32usTfSIIaa/epALN44S8Tc+CBqu5L0cNFTudIiQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgJOvlEwx8/Te53WEO1PcYaLnsJaTG4ITxgoRrhg3fJV7xiG/QZONbC/yU62jFghwbR0+j5IjpTHfQGb1MK645VisXRBDSAkcOa9oybRmc92SG3FwzaGIOejsCoMeCS7U0nHXttsWL5WXyn/7SJDpF64ZaSwHKoGyRxfcXY9hrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jjamd91j; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4e8922b1bfaso26710291cf.1
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761317892; x=1761922692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ON32usTfSIIaa/epALN44S8Tc+CBqu5L0cNFTudIiQQ=;
        b=Jjamd91jmBgH2I49DUZqcr9CqNV+el3lxpM1Hkt73fXQzbBiw1KTZPGrCDAowcMUrn
         a/bKZ9yEF2PCYEyq/4K9VZMS6e/6Y3hn/7h3ry/CoIdvPyia+91w6VmNY8R7bvuRWax7
         7Wn9vo4fb5DQQU6uvXL2q7y5Olp64me4EGEJ6PRK6+gOGtq436HKyGTOiqoqGl1B2BWI
         sPUXXgKrCTP6UDeiJMqWaXQgoLv6bgr+6pPBSmYnJy/rrHG8mPIgbjkKnGF4kWhkS2rp
         2ELjj/pZHlrDMtqfqJzGKPe8FV/4rB8EX21xatC3lQw/HchMWggygJXqsyvTD3YbEEZj
         yYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317892; x=1761922692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ON32usTfSIIaa/epALN44S8Tc+CBqu5L0cNFTudIiQQ=;
        b=cvQtbUujYl4F+YmzW+1Xwv/0FHEl/RbPZA6L6Yi2YmXoz38BRl7rLGrWe8Y1mm0Xip
         ovGrBl155rwgf8vcUj/Ngo/bO9Sj4KZZmevmhF16BcyfIQxzrVGgE4MF6pgpBLSRzKDu
         KR0gYQCXGxiDXK3CElfv4FDj8uASEe9Rmtz63IYOEVNaCycySUTqr99uiZ5qWPkLAaet
         +fTBgWbrj4UM2eG7sh1UUfiDdy6hzrTutGLfjWyQGa5+Qoe3QFCyYvRDmUSCTV79DdmC
         o3NpaU5PO7cKiq1nwcUaeiVQ5qU+k4+xfWDIxpmXIqm72cqGjw6YQy7ZJtUxQnobhLqK
         KT2w==
X-Forwarded-Encrypted: i=1; AJvYcCW3YKmcObp6cH/5PwHubvwPuoB0k10crmMqtWgFERSrwDppes0F22kA+e8L86YUxox3VdIbQR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGwv3Pl77VpB5y1Xpr/ngr6j5+G7SMubybYAU9dmWktEfozlOX
	FS0GLTQyMAhBIDA6lvCdxt3Medp5mQJJ6wafoZ2kc7+8QttzbKfnmbHgukR07dgS4BQOBSiNWun
	Um9rPw+dIjnYZNlpNmGGL7mojj+aegzIIlOXo5q3G
X-Gm-Gg: ASbGncsHIZXWj8OTKMyADobRJwg7wbCmCLbFLaxILAXY1UXgzuCFpYk1YiZPpCAZO65
	iQ74Q7tq5QFn9DCnGnkbFAT6JO0c5iprC+XBRPN1OeuKlVjsV1gohR3O8sbvRstIq4sQ12hlS1M
	MYLVRURCLn5128vmkgEbleksToF7M5pZwIqewPzPjqamKf9D5ilUWTg+dMsPTLhU0THksk3HFDy
	P5WqFxbfPRRSFPQMCalvGcmPLk48m+GC8qRhrTGZmyMFnw3imVSoabgYYJxCz0epXUWBA==
X-Google-Smtp-Source: AGHT+IGAjb0zRHObLA6MxvQ7pMHyAXe1HohEB8HZetnq/OaOOUTAyKa/ql45mtJThhD/jqmNEQXDJ3FeItmBfpIsJwA=
X-Received: by 2002:a05:622a:2484:b0:4e7:1fca:22ad with SMTP id
 d75a77b69052e-4eb947cf7a7mr38007921cf.7.1761317891483; Fri, 24 Oct 2025
 07:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024075027.3178786-1-edumazet@google.com> <20251024075027.3178786-3-edumazet@google.com>
 <67abed58-2014-4df6-847e-3e82bc0957fe@redhat.com> <CANn89iLjPLbzBprZp3KFcbzsBYWefLgB3witokh5fvk3P2SFsA@mail.gmail.com>
 <44b10f91-1e19-48d0-9578-9b033b07fab7@kernel.org> <CANn89iKgqF_9pn6FeyjKtq-oVS-TsYYhvyVRbOs3RzYqXY0DWQ@mail.gmail.com>
In-Reply-To: <CANn89iKgqF_9pn6FeyjKtq-oVS-TsYYhvyVRbOs3RzYqXY0DWQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 Oct 2025 07:58:00 -0700
X-Gm-Features: AS18NWANMYs4TPTDdjfCLExaFmNRWvWgZiT8zE42hbyQJhJn-wE7k3HmmUmuedc
Message-ID: <CANn89iJThdC=avrdYAfNE4LqRvPtkGS-7fLQdLOYG-ZOTinjRw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] tcp: add newval parameter to tcp_rcvbuf_grow()
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 7:47=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>

>
> I usually stack multiple patches, and net-next allows for less merge conf=
licts.
>
> See for instance
> https://lore.kernel.org/netdev/20251024120707.3516550-1-edumazet@google.c=
om/T/#u
> which touches tcp_rcv_space_adjust(), and definitely net-next candidate.
>
> Bug was added 5 months ago, and does not seem critical to me
> (otherwise we would have caught it much much earlier) ?
>
> Truth be told, I had first to fix TSO defer code, and thought the fix
> was not good enough.

To clarify, I will send the V2 targeting net tree, since you asked for it ;=
)

