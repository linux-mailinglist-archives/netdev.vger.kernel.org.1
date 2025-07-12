Return-Path: <netdev+bounces-206387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A47B02D3E
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 23:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CC567A1A6F
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 21:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7782922129F;
	Sat, 12 Jul 2025 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sMPKDnKG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0671E5714
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752356627; cv=none; b=gKKkC6yUibnWqL8XWDsGSfRNb8krut6OJ4/c5KA7x5PqSQgyveWJiqyCv2gumYv4u64qE7JiaUbAjnuiEI5rT1nGdj3/hyrBcYAfrhQ2ycC8eJ3ZgokamJ3UIWGYTQdZc0+HGp76UvDlWrEW7reYU4MBDRVlXPo26kZZ0glq97s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752356627; c=relaxed/simple;
	bh=BTmVoM4DSqTZ1lT8nEVcC+9Dk7/BGe6X4FzXHub8rxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9T9IDRpgNE8BfTPOL9f+kVJzc5ReEsJKEgN1V5QtaRC3gAtHzpi6PV3EPXJVCf1Sw359RllLC6h2wAvgBRKakFYtYIe8OBUG/6ZZPDONFrBQTC5w01XxYVJ28Ii5TGQ4lJSgzKpv3dpcBZArFIim2ad1plbr4qrrKexOQx2t+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sMPKDnKG; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b390d09e957so3367125a12.1
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 14:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752356625; x=1752961425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTmVoM4DSqTZ1lT8nEVcC+9Dk7/BGe6X4FzXHub8rxA=;
        b=sMPKDnKGwq32+tvIcWlOsjh2MOjZcKkwTpGtUDaZYGsXZsymZQUvzwPqxGUxSuqce8
         wjIqmWLvSW8e9FgToOcDS4PzF1rURhHHxqv0opJooLBGnN4nJU0AEa3GGbXoscrWXTS/
         FUQbqYIq+j7KhLyKDNBNXuWsVUxBsD5BqtL5q3qcfOL19DPhxoEA8I1MXi5HRnDDMzUJ
         pex9wRa2X0P/0OweNdQWKCQlgH8OvaTl0uH8OJy/xq37uyzbLlLsH8LHBXeYQPIosm12
         mIiiHRaTR9KfuTQtUGIVRrNobMlyCHn3HGn/4eUVTzO6EE9FWASgXoG0hGg7OEkTE1pK
         +xFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752356625; x=1752961425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTmVoM4DSqTZ1lT8nEVcC+9Dk7/BGe6X4FzXHub8rxA=;
        b=EbbzA8QvNl9MIkG9suR3LjTEZXdfS9UKavgFDcwGCz2dNHt5nO0/f5Hb0L0pgXf/dg
         CO1u6cCrt7yUOk6F9Xe/7E0bLkilnM38vI2tYTQHZwa7ZerEki7Xa/EJpVSAsoi/nHvk
         v4TLtYQCdLUH6UKdPca2RFqpa3R8wyxZjmZACrGeFNhLzw0ZbJyRpgyBwyWQleccbOHT
         D6ZFo3wcT1eJEKN4uVzmcNHX23xHOEprTAVfsTJwkY2WBAn7/esJvucyCmh9OCnaZ1Eo
         3nWm/wGxaGZBjI+S43MqOF0v5uFy8yGrGqKmPb3sbFdQr2nhnsmwabOaZZqqJQ7lYsKq
         d6iA==
X-Forwarded-Encrypted: i=1; AJvYcCX+/A4otP6yJ1+3Ug6/XgSSLFZ58oSg97rQcnu1HVDeThpt7ohLhQEmP9NgZK71iApbqludyXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIKo56C4k66cqVVa62p7O9HzpIVjjhDLNxp6Ptq+mizVHvX3AY
	7sEp+zDBt8pII+9V7Y6dEMiFyCl2liJD1AJnYwosKG8fRvJDlcntmqjzctxEn3zlgUgblpTQjeq
	+QxWVxAK5K4VMjBO29g3AF13mGRQheZmnbaFvzl80
X-Gm-Gg: ASbGncvGfhWazvFJLFweZkxiGkcxCLh995EYiYSFy8bYdBuA2lk6EpFfpR89tGl+IDd
	mou9BJUxMunFezOS/1rUEgH2ivF9qatU6rt/BGBV5kLsv8oya8m+nBqPA+O/FCFob+G7srTtoCH
	6s6HTpJhblDO9OYp83vYwdgAu/UyU5/G/MNBKZcBOwX0L7bb17w/ibJcUB1y/tojyUu420FO+KZ
	L9MGawTOKR+C+2G5zEd1RAsHEioQEcK1YjnVexA
X-Google-Smtp-Source: AGHT+IEXDo/GxyT8G+OAV6Cg8KC8VT73PkkEuNwF4gL2+rXWbPWTcAD/A96Cxme9amJBTC1pWIe//U3LalipzFEzVfo=
X-Received: by 2002:a17:90b:278c:b0:313:5d2f:5505 with SMTP id
 98e67ed59e1d1-31c4f57241dmr11284468a91.16.1752356625180; Sat, 12 Jul 2025
 14:43:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711114006.480026-1-edumazet@google.com> <20250711114006.480026-7-edumazet@google.com>
In-Reply-To: <20250711114006.480026-7-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 12 Jul 2025 14:43:33 -0700
X-Gm-Features: Ac12FXwwYD4DPOoeDE2idJIDExQed4g3jn2011lBNeedSSAp0Oech5D8WRxS144
Message-ID: <CAAVpQUD9uRwLbWeiny5+dVeUXp0v14_OFb_4RZxAj49ohHQdkw@mail.gmail.com>
Subject: Re: [PATCH net-next 6/8] tcp: add const to tcp_try_rmem_schedule()
 and sk_rmem_schedule() skb
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
> These functions to not modify the skb, add a const qualifier.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

