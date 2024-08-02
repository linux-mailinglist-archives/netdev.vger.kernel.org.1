Return-Path: <netdev+bounces-115271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5867F945B1B
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 11:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A39C1C22877
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 09:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD2C1DAC43;
	Fri,  2 Aug 2024 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qbUfU+N1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7091BF304
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591342; cv=none; b=rgzO1ZYatN8tLtOvbBxH9LOayJdOEyYfbOI54TZdNlVwv+6k/333grGLmNq55bqppk3HpYZP+5hN6IREZdWaQT1Kq1JG162rq5MMzj5PjUhfYGx6WmNHeI0Kx+QDZGWQH5ID8pJFPfmZa8MZg/iud57Ydq6v+Ovnn1eArmE3H5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591342; c=relaxed/simple;
	bh=XZHdqn60yF6PHpZ5aHi0tvgUiUW2wUIHbiPgkSq7mhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tsADRbaMwCCavt/zyM+aT4/hP5xMow6MbhiAH1IqhQvCqAmrqhsmCAlGCPBiD1AoQJeKoDZX0bNmJkFQOsZxlknsM63ztoYpc3T/r37udUPO4qzuQhN9wQBe84hziDi4qrZh/AVlc+SW+4aV3wCrKV9QTaFeyrOGUtscgwg/L/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qbUfU+N1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42807cb6afdso208885e9.1
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 02:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722591339; x=1723196139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZHdqn60yF6PHpZ5aHi0tvgUiUW2wUIHbiPgkSq7mhk=;
        b=qbUfU+N1AwXFRu8kZOuI97QuRi1V3jg2CORHXiQ97njNn2KT3CYDTf8SDWxRI3pkCb
         3BCguc8K/O5OQ/8YeIL+KpWUH21o2JTGq5A4G36cEyDTgtJ8HPjblYedZW6GClmnCkEg
         WwhMPs+OC5rZsTLKr7wJTFOcMtNx1O4OqXXILnXXdSU3JFDoiCRCZxOcy4vFXzvVErzb
         mB5f/hcG5kaedeEyN1BUwZqnc7fd6PpUxl2M+1GVaN3pCJSthp3sGs19S9EaBvYOfOfC
         AL1sVDyg0TMGDHYcmG/b52dOe7Eu0JFs94Tr954pTEzpL3LsY/yZlcQ3jpSqmdvrk3sB
         0H/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722591339; x=1723196139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZHdqn60yF6PHpZ5aHi0tvgUiUW2wUIHbiPgkSq7mhk=;
        b=URXm2VXLTpiJLS1Soh+a6FQuOW8om66k+6HQsNR0IYKK7DVbYeUyrVVc5AvGOXD3mo
         SIzsN6p1n4rVzhSXdIzvTzkhDlido6d1Mr5wXAWiRBK1LzNlKfs66hTYnu/nBlg6/fWw
         pVvLP9uOlKUgq6E4pDPfHky4NQbKRhtq2eVECMqL5X+hA5tAKRE5HoW3TMoMNzvwqomg
         xKowISx/9czR0J//gDqCsRaggTrReo3nJumNhaH2oc6N1K5w0H6X7mgW5YqoneI5ok3c
         3MIBl/oV9Ks2o60OK8FUygijBPx8obhh23fP9PJj6SP2+qysf8CHphRsjKOa/Yd7zoM3
         tC1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMWOdxZhRrYWcJAh3KNYxKuyFI7b/wqtp9Lk7IMXyRPlnm7DL5IcKQ7dx5BbNP6tQDtKdaEWUltNjuXvxB+lxUh5bc8Zp/
X-Gm-Message-State: AOJu0Yz9QhEmhHT9HHojrBaJCCVB8UW56w7cV9Fgki+1/RyU5y/sZwO3
	+KVBKAdwFYnbErCUldCz2BHzVhz9G9SsLSF7WBn4kcdJT3e8RhK0FgYQ5v/fYiBkRKH05CNasAK
	/TIEoqVaVURr3Dis0nJEOc9dbknOaz9l1jid5
X-Google-Smtp-Source: AGHT+IHjUf4oahb1dp1J7DoabWxAycsCYh75rvfadKcbZw2pTRTIotD3kwILWrjO0X1Y2jFWhsxlQqQZ7ixmL7jpVVk=
X-Received: by 2002:a05:600c:1d20:b0:428:e6eb:1340 with SMTP id
 5b1f17b1804b1-428e9a9d900mr831065e9.4.1722591339279; Fri, 02 Aug 2024
 02:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801145444.22988-1-kerneljasonxing@gmail.com> <20240801145444.22988-6-kerneljasonxing@gmail.com>
In-Reply-To: <20240801145444.22988-6-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 2 Aug 2024 11:35:28 +0200
Message-ID: <CANn89i+gpyrzH_gd0oyrfnMovx0B6FWGS+7KKLydaKayFXh_sQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/7] tcp: rstreason: introduce
 SK_RST_REASON_TCP_KEEPALIVE_TIMEOUT for active reset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 4:55=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> When we find keepalive timeout here, we should send an RST to the
> other side.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Note that this changelog does not really match the code.

We were sending an RST already.

Precise changelogs are needed to avoid extra work by stable teams,
that can 'catch' things based on some keywords, not only Fixes: tags.

Reviewed-by: Eric Dumazet <edumazet@google.com>

