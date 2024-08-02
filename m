Return-Path: <netdev+bounces-115228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA1394587E
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 09:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDCC0B215EE
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 07:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBB71BF314;
	Fri,  2 Aug 2024 07:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="amgb4Mjr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A851BE87F
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 07:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583114; cv=none; b=Vh308q7bQiKIb5zRPjctcmJci8jc1YNsTn9KR7lhrt7TP0rRrbP2Cl0jV+RGI3bex0KUIYxSvg9c34fqXn3P3xhD7WMcT9VoU5bSeCzyuOgcuPxMWjKMWh2DbREq5bu0aBw9id9xoBBDWwC1MkqENUDQUbK8Wld/Y/GKLrRs3+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583114; c=relaxed/simple;
	bh=FpwSbCChaBLYWXYgjWM8gyKpzwm5eYvktHF7C2+B/lM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lf4uEYhj4E7W74+aI7TGLbc8YEUqeeRlIVua3VaUkGfk2VpPWNomi2FVlDZQwz7GAaEkgw5jQ0EUD2RYw6PZObTTx5OpOAAmNz0L/occ+SAEP86JKbdV6yF5syg20gV77TxsjNPEsbyE0Cz2F/dBZHpnv0jViJ+PSJprSFXfDak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=amgb4Mjr; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so47024a12.1
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 00:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722583111; x=1723187911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpwSbCChaBLYWXYgjWM8gyKpzwm5eYvktHF7C2+B/lM=;
        b=amgb4MjrLRBFBmIIHGNmjAgtv4ypawwulFKr2GOrsB1GrfYwitRrpZDo2ODJ0+Nrjv
         LIpcf21M/zbIS20Xsf6tYelTn6k3K5TO+VrEzGpo/GILsh5XhAHLcsa2Ux4vyXR2GCU7
         E8IypgQ/wvdpjMQR2kt23xG2fZh1RCSzM2OtoR6AdMD8BwYaosPIgJrEEuj84Dj+lS+z
         OUI6XmkNNG6QPehqr+UbswziRVuJlio2vjvXCSvhhzlesO4y303EVDIJtwXjP0VGnk4q
         dkWFKOX+5TRguv0pmlFuSca0t24QlHe7EyWhLvYUIwK4jEPpwLCxWmwcJYjNaVOPJMS0
         yGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722583111; x=1723187911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpwSbCChaBLYWXYgjWM8gyKpzwm5eYvktHF7C2+B/lM=;
        b=qPL6C3IL/ZeYDEDVAp83Oqx3SNXgwnfGPSQf1KaSRxSqwZUihyjGKkShbX2jyHlkJy
         2yrxVFwsKTyswaZkkK4TdtU+ZLTmrDhNswfT7gLkKchlD9o7dpB4fQDQpL/V+wBGMwcd
         1pDtkNpBhtP5GD/m8WD+qk+3c94YY4irlDUcse3iLGOwIOPcTqptYWD69OUgCLb6+98o
         nsO66L8sTol3KXhqiu2daCcA2cMlbRQLEe0tZaUXXq3eBB7khvZG+C5j/xS4RCvnuUOi
         MTxPNuIxDGNzchbLpY5Ynft6NLnYm37XYx/VfFa1JmUuMbPF72PqcImTjWMHoHpLmwJv
         o+lA==
X-Forwarded-Encrypted: i=1; AJvYcCUyJ37ZQqmLGVxpvkNfsc1ZrF5knRVNn3Wv8NVfLlmOAJSYb0FlMhHsQJYE9p1oce+LaVRqmCA+IwAovwfPW86ztAu3B8OX
X-Gm-Message-State: AOJu0YySZ+bCnnY+UrTxnyDCDNSsDtBPijEsxvxAmTJzK/+WJvx/qib5
	X5u86/+C9niI08m64auHyXm1w4GL+gshIVv/tVvRFuN2yGPTXFOj/jSHFLDi+6vS+n25EiZ3J/s
	FqlArS4M9FyKLGh2G7gZV3BXwMeaGyIElpL9l
X-Google-Smtp-Source: AGHT+IH8OexSSGmPaE1Yqik5tzJiO5X6AD6IxmlC+tTTB8p8SVkOwWgpoHXfP0fFFDRhomc6QUMtKvS1No3uaJLzPCg=
X-Received: by 2002:a05:6402:358e:b0:58b:93:b624 with SMTP id
 4fb4d7f45d1cf-5b870c69d67mr70970a12.1.1722583110956; Fri, 02 Aug 2024
 00:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802001956.566242-1-kuba@kernel.org>
In-Reply-To: <20240802001956.566242-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 2 Aug 2024 09:18:16 +0200
Message-ID: <CANn89iJvMjrQrT1o12i=x7XYzcZYeYLUrYt4XAL=m57v0_e8XQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: skbuff: sprinkle more __GFP_NOWARN on
 ingress allocs
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 2:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> build_skb() and frag allocations done with GFP_ATOMIC will
> fail in real life, when system is under memory pressure,
> and there's nothing we can do about that. So no point
> printing warnings.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

