Return-Path: <netdev+bounces-119784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E12F956F2B
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 17:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1253BB28989
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A742941B;
	Mon, 19 Aug 2024 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xkYr1TSB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DB32C853
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082355; cv=none; b=jpG9ABgfis5wT/f+3oHle64NgsqEerKIM+e69G+r+fCVIHo8TXYJ3uo6vgQYHQNUf74i4nvjdqiC2EMlv6127/jUGPcBFHhLucOv1PxCrf/HHistniizh7g0HYMf3DYiB7sOzKv7rwOixwubFHXe1dYecsTiaRnBSFooXgaY6RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082355; c=relaxed/simple;
	bh=vDocGVLyebSkZkK9Y2QI9+eWGL/8LYENEpd1p555La0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=meafIVFEHS3VyMj3JzRChxe6xQlCn+yPhr5i9o+xYDiCW6ojnbhne6d/hBpnUM5GdarIp5V/er5OK+t0Oh6k4SNH2A2rchFsuuOaotK/1gYu078FjSTsjKM6BfzMDIcU31NX5A2FYNMe8IhWV+VOJRgVvXnSPzIFo3eBgPOsqJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xkYr1TSB; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39d2256ee11so14580375ab.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 08:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724082353; x=1724687153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDocGVLyebSkZkK9Y2QI9+eWGL/8LYENEpd1p555La0=;
        b=xkYr1TSBbkjh0ymtdhwAEaLbEYTRjkwB4Z/3utdvAA3faOyLEuScMZE2U8CVfvQCk6
         rRGNei7oO7CUS4dY/dZdyPERGwLR5D7Ub+GlRkrOCpZ3Z/8AX/OInmJ/q3XZQODCoxNe
         dfIxLstK1N1A/6y1twCrCQQ0x2zjHF9h9IYa7vvyqozNxUvydNfLfFrSFEb/f+PBwYmL
         DMs4Rn9lg571DcK9QTrdI6tgUg6t/lPEN6r85pa92YsV863tdxoFmrjRmtsGu+0F+WdG
         OPj8hTtovddCzSvgTA3vLRk+SFL6f0uxk8Agy3df2dHEsd0zSr/TF7Hcua+FVn4dgcx7
         mkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724082353; x=1724687153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDocGVLyebSkZkK9Y2QI9+eWGL/8LYENEpd1p555La0=;
        b=kzkUEUBIdCoknR7WM4KSNhA9IReeSObYf+9IzwQXmIk4bOUMmspyxLTx+4cQRHY7B0
         1Rm9ZDSDm8oInVf2M3DDs+eVe4vaqvJAWF7HjwygmB4QQ+rp81Or9+x+e6PhOEovBzn1
         fYx2Af5FZBf9Z/yogn87FpfrV8PnOrxZuw0aSegXJcgkn5NV7+M/bysd+4CQ4DTc3Uwy
         5Al1v+YkIjcaXZgcGnDls6vx/McSuSunD8kmKnSu9W8GWgsjsADi9gyGBf2takcn4Lf8
         Sh7/iw0AGr8Oq00Jj1bgs65OLNHIpC2C0jZrrEmCbo1qYvTXbG8qJRC7hhW4EuG5uKqn
         lCZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgNDeO6Ni/03JREZt+d5XrPIyU1KMj6+TS97si7kWJX3LJ+cFFS0GFkXqb9qqhEyv1s/j8BaUyis8StEAA/cV5jvX7vLq/
X-Gm-Message-State: AOJu0YzjAjOHrfPMXsojLDfLMvBuprQdY1CR2BeGGUvPFxackDYc1qJa
	HzYW6+S+QXEX/q3cnDVpNPbWYegW3hiH1qq+BlFBrz+fcFz9FnlUVFCvatZj/S8srkF4HugBodZ
	NJuTmkqexiH4U7UlFrFlXfAjZ0oobEC456c4YW4OP4vbZR53zXEyk
X-Google-Smtp-Source: AGHT+IEz/XGX2uRDdzDN3HAi9NNlskJUIF37RVseHsPBCxrLWyBmvNN7OeH7en1AsgRu0FjqHr0XVZACoMpojkrBlQg=
X-Received: by 2002:a05:6e02:12c8:b0:396:d1c5:e5f with SMTP id
 e9e14a558f8ab-39d26cdee76mr133625395ab.6.1724082353203; Mon, 19 Aug 2024
 08:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816153204.93787-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240816153204.93787-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Aug 2024 17:45:41 +0200
Message-ID: <CANn89iJZ8RwFX-iy-2HkE=xD8gnsJ26BO5j=o0460yUt7HiYcA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: change source port selection at bind() time
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 5:33=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> This is a follow-up patch to an eariler commit 207184853dbd ("tcp/dccp:
> change source port selection at connect() time").
>
> This patch extends the use of IP_LOCAL_PORT_RANGE option, so that we
> don't need to iterate every two ports which means only favouring odd
> number like the old days before 2016, which can be good for some
> users who want to keep in consistency with IP_LOCAL_PORT_RANGE in
> connect().

Except that bind() with a port reservation is not as common as a connect().
This is highly discouraged.

See IP_BIND_ADDRESS_NO_PORT

Can you provide a real use case ?

I really feel like you are trying to push patches 'just because you can'...

'The old days' before 2016 were not very nice, we had P0 all the time
because of port exhaustion.
Since 2016 and IP_BIND_ADDRESS_NO_PORT I no longer have war rooms stories.

