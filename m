Return-Path: <netdev+bounces-206389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509CEB02D44
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 23:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50FC5A40B90
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 21:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3AA1F0E29;
	Sat, 12 Jul 2025 21:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T3n5mmHk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED66623B0
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 21:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752357477; cv=none; b=BLkIG9S+COqfjMaK6ndwcerB7g0i+a3lwLOuVy4WNsaCsKhltc3IIuRoh/YWGxJlEG8+edDuMKfDNhOK1mivBJu9Q613LrttbOFj6TDQbZz3/oJ7auHjLNLq6cLscVU/N7m5f4m+aJjgB21bHkYCogMYqhNHbCQovpjig4tIfpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752357477; c=relaxed/simple;
	bh=UG0vJTokVRV9gZHpRqrhrVAwtZj3tRrvNvfYc/X2VhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMaVNro1RAQBC+arPTe9E3Xfh36vMkj6Vcuv2ZjHyfrKDK8ZVLBwBIVn+NWkqYSOV3Vw/zDWX7tFsUEgkAevMEjEbxSF0mx0ZgnZOEKpXbLQ2VPBpgYQifMwKRgF3gy422v6WirdZL+yNcpAgX8HcxGv+OQU8QovLLkUGOzQXVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T3n5mmHk; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3122368d7cfso2646145a91.1
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 14:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752357474; x=1752962274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UG0vJTokVRV9gZHpRqrhrVAwtZj3tRrvNvfYc/X2VhU=;
        b=T3n5mmHk3SXpPzXr5Ti1BjYNXWZ1UC4fHtXpEZyZheIH9F5kGtTHm7gti+ws0GzNM6
         4ZZNEpm6RH93yRWz9pD3LqZm7HeWFq3gbJYHs/dSlN2UdQScJbrkTaQ6ILqZEohr6QYR
         ATGkRhWoNtZ2XZWV0p+P+fjByUSzydlWmEFXzlAgraVsZ/ffAkM6BONWWWaIhJ5fEhmv
         Mg+2QZ5UG6VJJize+Kbh5nfe5uBORwTwyOkf60/R+0I/COzkt4YyBkIcYV19YjJjCFmw
         EVhQtPXll9F26gUl2zDG+arUfwJyapZy0f4jTPfSZbnmZGGPnH2Aj2Orib4sGgcR3swX
         vMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752357474; x=1752962274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UG0vJTokVRV9gZHpRqrhrVAwtZj3tRrvNvfYc/X2VhU=;
        b=RGwMsLpnqug+EQ8tgdpQCjw+pIiZ2iutql8uiNdGp/jecJZ1YxPI0mzj2/pHfGCXhm
         I6edafpH+nkh9D3uXQ/shUrl2SIqa6ovhaQSd2cCiXieUOT6WQBG1bmn6iJxwR7s1xk6
         vqUoOcXeGeiH2crcS7NuqD3jCq9M/Dey7ekBMrjtcvtHNoFXIK9xcBYFxRnA7dNSiotV
         u+csaUGZu+ZFrBvOPdMg9NsiMFPrKNMPj+u4KM/Q+9iOIZ/w2oD0bVtg0X+IQhrXsh4m
         /JXfc1w/jKHbzTOP44doE2bqC2zpiRrP+5sHdd/tRxqJ2Q+S4BDJWwtw+Wj+Vn0Ewdjt
         EbgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUHdkaguoImxN6RdCebDmfeyw5n4yGmliAR25lDlTzRB6SHX72GmRIFUKhPfNIO7lGyTBacic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBI00eOzRKoEcJIApPw7clsawWOXmCpW8Pnu+e197EsKnH4Inz
	4I2LzsnW7PGnwZiuAizlVFZNaOpBqM4VaBe3stJe+pDXhJmMMdHdAih5ODa8c6CDKS3hc4MoBIo
	7bLiHLahSN+hDuafr3yKj61x8x+XbJ1IDZ1/3F9ZW
X-Gm-Gg: ASbGnct8NBC3KWX2xTlRc4uOOiOhcBnn88U3tCj2HyV16lUu8vCf/kDyvS2EIqcxEHd
	XUrPKPs3wZUHPos8GNGDVRANGLoEaD816MmXT2QiTpoIq82EWXLqSh7HLqA42Jbx+i20JHa4Eih
	7h4/Hp9X9Mj5NQr53V1a9vjrzH+AuBS0xFrcOksKJBCQXmpbBL1piURLAXgodI8mvkdl5CANvY3
	KkuZYpHywAm6eVh2ml6D2wA+da3zfCgSQIAsSfObCKBAgF/tnU=
X-Google-Smtp-Source: AGHT+IHXvMaLhRUbGWX6sHzxwJERuTVehEOWVRW34Qsh1wp453VbmoXw7gLgDSDBfza4CdI6h04r91tWn9XzMrKoSb4=
X-Received: by 2002:a17:90b:3844:b0:311:df4b:4b93 with SMTP id
 98e67ed59e1d1-31c4cc9c984mr12176895a91.7.1752357474093; Sat, 12 Jul 2025
 14:57:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711114006.480026-1-edumazet@google.com> <20250711114006.480026-9-edumazet@google.com>
In-Reply-To: <20250711114006.480026-9-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 12 Jul 2025 14:57:42 -0700
X-Gm-Features: Ac12FXwfnKUZ5gc1Aj1r-pHrOCF6SAqS1i8DkAQxmp5pIQUlX0h1KWH6rTmte4Q
Message-ID: <CAAVpQUCQfCrw+CedbeVcYNd-CfCQ+cqkF1D+AAqHBGni-diiqg@mail.gmail.com>
Subject: Re: [PATCH net-next 8/8] selftests/net: packetdrill: add tcp_rcv_toobig.pkt
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 4:40=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Check that TCP receiver behavior after "tcp: stronger sk_rcvbuf checks"
>
> Too fat packet is dropped unless receive queue is empty.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

