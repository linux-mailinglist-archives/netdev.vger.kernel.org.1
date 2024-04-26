Return-Path: <netdev+bounces-91565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D3E8B311C
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 09:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13692820ED
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 07:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC1213BAE3;
	Fri, 26 Apr 2024 07:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GI+gF8vv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CB213B7AF
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 07:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115562; cv=none; b=PZ7JL5svii1oX7hIE7g3OyjEssR3tRIBOyuzWLB1BiN6VHjFc0rO0KRLO9s2/PqCKXc4WY64czMcZAmG4YFSte1j6yYOOescoiD0u/9v3JdP0Lt4QfcHVXbWrCGcP4rcS80dpkF0mNjL2h5qbS9pn4L1VTTyt7VNWJS0QjwiBwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115562; c=relaxed/simple;
	bh=4seAV79ridn4oK7nRaqYqUH8RKW5l/spsnmRvibRiNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLXLbJ8R2qtSlRCSuF0YEXLEgOjNH/6WTG6NplSFAZ4atmAMi9QKmftkyr06TrUDzH5pM+fWy92Y0FUDrdOkctlg9KXc/bWCibfUqbjpCKPmqlqSYqeiPNlr+1F2Ps/W8ASiLLyV3uwYniLZzIsrYsVVRF4REL1G4WJ4GuTtOEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GI+gF8vv; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso4999a12.1
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 00:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714115559; x=1714720359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4seAV79ridn4oK7nRaqYqUH8RKW5l/spsnmRvibRiNs=;
        b=GI+gF8vv/xhzBvU7ySvStn6LV0WkJml2LcVgOsLWDd6W/rxZEGYLnbAvC1cuuDHRrJ
         wtcSGZg00sW/HPnlc5xUsdMfsWYCGw9p+Q0nyw0uvQLUlDfkys64cbgoe02DH4yiRmij
         YFnnI365rem5AC3FVB26+APkkhLPqtWwCGHuNWwGt/oHCiiIkPjsXwtuZABPcG9t/Vkf
         QoDF/v+m/dxbdyY/sMAzi7e+pNckBGh3MCICvxiW1itTMw9a/J8Mc3lksHWlkhiFvgul
         M9C8znWyndq0jng6YTWaUv2P4oKLroHOsmezaxDDQ/lmWmUqbBtOxoNww2byOy4Rod0p
         ditg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714115559; x=1714720359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4seAV79ridn4oK7nRaqYqUH8RKW5l/spsnmRvibRiNs=;
        b=ouicbzEqJuewky8ZMR98fhqKs6PwJq5kEiWdOXrrlZ3rBfahwZPubbjJ80oHz/c9RX
         6hlLsrLPUe3ky6CHdASwZEysQBZD6V2I97GWZDPZkfi1WokdM0Eadb2t7DmeXVoFfNsi
         I4Zdu+VR0yURT39gVNnztgYgxywbqiUO84lUOFhlWzm9paaKx/wxwCZrdgG4Np1v7eL3
         7o2akYoDuKvSmtEYAn97TU6YcGI3tCtv6liR/Y7zzCr4k7V5fs5xrQlobAWQscARx1IZ
         r63X9P499hcMUKUzuZWk9Fuj943l7YRhEx+3ZXLwAzMGAx4jcAReL7o3dsMNV5rOs/mZ
         kHJw==
X-Forwarded-Encrypted: i=1; AJvYcCXQCxW0EEIHgAIVbQ/LENv2txr7x/6SLaQ+D+FbJHoiPt0ue61jZP+GcuoKCzad1bGOnMP80Nyli2PSbq0nVBDlZgLT6ssT
X-Gm-Message-State: AOJu0YyX0vHz2zuIzIUODj/HA+dET/9Xj/79vQMS07a8rScEqqQ2E1Qp
	zUew1TFA3QYV9TJq9QTJ8voarnrZew0yD83gkuT3QT5xf9svWv26YJsbHaz8OU9srNHONZooSip
	/J85QLz+0RzJC3eYRGnGFL6S/vtH9ZWLohMTk
X-Google-Smtp-Source: AGHT+IExI6r1PzLpwM+kdZrqejtoIV/lrdCRc9hPnUboYdDZk61WahQ3oh9IdCqM9A4jm4HWv8p1C4wk/G0gLyWVjh0=
X-Received: by 2002:a05:6402:26cc:b0:572:57d8:4516 with SMTP id
 x12-20020a05640226cc00b0057257d84516mr44282edd.2.1714115558737; Fri, 26 Apr
 2024 00:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425031340.46946-1-kerneljasonxing@gmail.com> <20240425031340.46946-8-kerneljasonxing@gmail.com>
In-Reply-To: <20240425031340.46946-8-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:12:27 +0200
Message-ID: <CANn89i+oyLS8goc0oVEpDW+PR35q+BcSph0s31q3Lj-RwSRFVQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 7/7] rstreason: make it work in trace world
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, horms@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:14=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> At last, we should let it work by introducing this reset reason in
> trace world.
>
> One of the possible expected outputs is:
> ... tcp_send_reset: skbaddr=3Dxxx skaddr=3Dxxx src=3Dxxx dest=3Dxxx
> state=3DTCP_ESTABLISHED reason=3DNOT_SPECIFIED
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

