Return-Path: <netdev+bounces-215608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CD1B2F7DE
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984163AAB71
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FAC3054F3;
	Thu, 21 Aug 2025 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1d0O64rI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4932DEA8F
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779069; cv=none; b=owmqw9tGzLxcV4Nf9vA6ky7RxUgX86mygp/H32c6gUhmyaPbJSREW6iB8oW6G7PXtrgs/4xc7Cr0lM/S0R8v8P/qBbzbLPgayJ+hzSKpfGTYWQzALYZyLcessICokfljhD3jR8HPbbJKiiMYJGRIEPi18RTr7DumL6f2TrePl7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779069; c=relaxed/simple;
	bh=f1AbBbvLlmetpbm2cknoVOkum8sEWbncoukC/4LrwuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTuk15QGlSESUBk9gL0XevWO9SfWVtvgM8ud1sayH9N2xMw7gmdUUTOsw8G48WH61unmE/JN2pVBIWCvlkAOuApzylYaQrk5/VfYy1IFrkIVpUc3PNJKp32iO+FLoszPqsqz1yfEI+sX+1CZl3IEbECYJKnZ0PbDykGSFaIP8js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1d0O64rI; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b109914034so10813281cf.0
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 05:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755779067; x=1756383867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1AbBbvLlmetpbm2cknoVOkum8sEWbncoukC/4LrwuI=;
        b=1d0O64rICsWpfp1eb4Q5gc2LxsR6uLVDSPIZcm8PyqVlfeafi0vD4fErSm4wlrEwGY
         /1C5qgn34lKV/0q8/M2nkGtaLrphZRFmZJxRp1sq+trcmeasboSJlozEWSfuMVj5v2ln
         pS9wSyf7yCWv01yYzqo27s37v/XmdSFrHvIcVpyVn6NtPjWJRsReafak0htJaHRKJe6N
         il5/tD0mWSvOwIaTSwHaqHL+w1QjF5BxZScQ8x4Z4m2EzA9dpcH93fFQfASCSCdWVMDS
         eis4A4mS+ZKuiweh7NLa8za4Hc1zI02G+ScsdFmibuMenFxbz/1Z008uPaI5wDi9Sex0
         QTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755779067; x=1756383867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1AbBbvLlmetpbm2cknoVOkum8sEWbncoukC/4LrwuI=;
        b=Bqqa5agKOvuSdbuKErE+ukeEQ/F8H552kE5se06dVx27QKi64Pyld7WfLn+2F38Pyu
         YyEEbbRpGp9F0y1V0aSvMLjUSvAVLkm7cY0ujU6XAIO6YXMg70QAn/KZdJkMhTJBN4kR
         0GqAcJ2XaRuZ416ocer+bQPtvt6FbGXLSNkcRIo9UdIg1IAspG5z7TwRkTW8YA6BINqj
         yf5TdyCoAWWt+ziGALnW+cORKX49gGGh2XZMOPcEynGRu5IwOVkN9O+TUOTPOphmLwMi
         uEveNobzn/LSorQ0/Xsvrmj4UBLXIhx11o8i5pwUvGtCXPI7vslmVQX7ZJVwK45eJGsc
         kIIA==
X-Forwarded-Encrypted: i=1; AJvYcCWIk5l3gPK/TtapdWHqt32GY0y46mQwDeurEp2iOK3JuS/xJg2eru/tdNpjy9uqELCaBA31ihE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz44+VYwmgpdmoPNSzlHA9bRv1Yu/yGosnuPIN5A22ucYDO6wHi
	7qkCtgk/8e8pdjS80dnXuZRzNaXLVUdSrkP14A4lXG6YFB3Ztds+irw2ieNbscAwIN/uODxhusa
	+qJioD4Uk/9x/zooBwhKAvEkb0M5DtlrHNDT5Ql79
X-Gm-Gg: ASbGncvJzhCbhs4CS6TWSu21Vq0OYt4TDvUr0bBBdZJKz4Vugn7nFXZkbWKOUMSAo1q
	RgbtALjgMtCMXZ6GLeFIdYi+IKnl76G/WBriQSrVgYw2KQD72+/3dQ5v4NqOu87WkxhrxSwafNK
	Dc9PnrIEPTZyYjSHBaBmoJF7kEdxbmkAiw9mYj9v5JxE4rp2MEQfRnEMk5iRlNHItbGtuUd6X8g
	dnKnjB8fzikdr4Xwa2u4ROXqg==
X-Google-Smtp-Source: AGHT+IE9nHthnuO3iyaaTFTophq+5yluqv4flsuTIbWyobQg+AKCHWYdoAelc0nDHS8WwCDQgE8Y49CEmLBBB7iUtng=
X-Received: by 2002:a05:622a:5e17:b0:4b2:8ac5:25aa with SMTP id
 d75a77b69052e-4b29ffc2c09mr20057031cf.83.1755779066699; Thu, 21 Aug 2025
 05:24:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com> <20250815083930.10547-9-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250815083930.10547-9-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Aug 2025 05:24:15 -0700
X-Gm-Features: Ac12FXz4ItLodbd6ls4z56PUPr7M6ZV9VCYXJm2RKx6YiZF5T39E5oM6J1bp_oU
Message-ID: <CANn89iKvwM4EFwzuLXOr8OzddQto_rPfdBHUMLzS=xxG3USzTg@mail.gmail.com>
Subject: Re: [PATCH v15 net-next 08/14] tcp: accecn: AccECN needs to know
 delivered bytes
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 1:39=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> AccECN byte counter estimation requires delivered bytes
> which can be calculated while processing SACK blocks and
> cumulative ACK. The delivered bytes will be used to estimate
> the byte counters between AccECN option (on ACKs w/o the
> option).
>
> Non-SACK calculation is quite annoying, inaccurate, and
> likely bogus.

Does it mean AccECN depends on SACK ?

>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

