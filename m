Return-Path: <netdev+bounces-229587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C5ABDE9BB
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 15:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5EE1883C0E
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 13:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C91B128816;
	Wed, 15 Oct 2025 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ThAy3Q8i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E282019DF6A
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533317; cv=none; b=RPdPULsihipS3idf33BeiNFnPmVXr+aaIilchNjustsrUD81c1DmQwLrYUbcGynq5XFA40A6umxbPt9FM4xoL1h3fzcCFCmA46iYCEpCtDKmlQv9xHFTxXpuOtAzSYVupKvSP0DHQac3HgU5DYaXoV0/z6zPGXQRRGkgnUWIHE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533317; c=relaxed/simple;
	bh=p2g8DDugdDQMuyWLMnshJcRH6Wur84Lz4G2DvPP9EuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTFpgzeS/BAwD/LzpmX9efyoJ/rq9OF8gkabl9gK0xM9+TuFS27srk/hx2BZsewyqKbCr7YUN12VteRNyRSY+GQ5WLdpakOYqZG5+K0TSqnbtVFgVA581F9set3pFXei6zTe9lACBtyeRpXdmMVpQMV9eytay6y0zNE6jvG6k8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ThAy3Q8i; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7815092cd06so23510667b3.2
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 06:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760533314; x=1761138114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2g8DDugdDQMuyWLMnshJcRH6Wur84Lz4G2DvPP9EuU=;
        b=ThAy3Q8isVDGR60kVTt2aSJ0PwH491JzhAy8FlcFQQpSTAsK9mivNk98ymlApdV+Gj
         iwmdT3f73D33xn4+Y8MJglE6ZZHroknFJTkPASEIIYey6KhTPqM3E5zRqfmo8CfgHUOb
         Ly+hrgyH0s/L/5+NyeJyBwzRZfOJIuNIbl53+RM8YwlVS7nd57/LSV0NEi3dCpOs2Ovf
         6e6rl01zfoSfIZk6K5YhZXTOuw4RiG3blkE1i7K14e5Ro0H9MDd1l+e1R8fV+x4zSWls
         U6R0X+EBeOGf54mPJBugXFqcSUWnFJy2SLicM/pF8EKSeIT9ZzZULppbjgdYfO8Ml933
         7+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760533314; x=1761138114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2g8DDugdDQMuyWLMnshJcRH6Wur84Lz4G2DvPP9EuU=;
        b=cA2ycjSYeXbXXn5By1J7zL5yXwencshaxeHrzlkekVlZrPu7DfuHkbMpOuOTx0WHhL
         a9wvLQEJIBxSD6N/UHpM80kMcBjpGQVOyWVZDMds4NNcht9d0eKNGuIGQP4VamUq2BuN
         EN2IpRACT12TyIF/DsTUZG704oGjlma/XujXT6qubIVAw8asN928CPxQJrjV9KHHcBMS
         /vS9PMkmK/MnhQlLJr7GNQDESDjCNL/zx71B/eCtlj40eddo3Ms1DklCxx9PP16ClhLX
         oKk8HTJb2Qgaki6PUkzgU1R+OBjNBQ/P1/Z5HIj73ml9++I8xavdJjwyqnLePdB6x+IX
         ZDxg==
X-Forwarded-Encrypted: i=1; AJvYcCVnqj8fMH3X1UDc6jLoBrRvBFQ+r7eLtdgSy1kyHWQMZYHcKAHNG4586i8nyNBjGnOMocdojZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEfZkiHK2taIDuasPhvFYxD0YrPjPz5e7wpa0TAO2IeNh8f8oc
	iRYf8d5bbFiyXLefLSTvkYs3QIfa+tsb3OEr48hbRO08I1VYswwX15LJJGtK2B134HakuN0FHkg
	KFkUnYYvFnxRMjz5BYMeK0e6iiFOS3lqh/IKX4lSr
X-Gm-Gg: ASbGncsqfX/Sbf+RklpEx2VUdIA0QMhB7YQLPnLtxMwiwRcwXD6FAaSuz0N9YY1qc3T
	JeLnLjZIt+YHROk9sIaZcRMKdiAs9ENbKX8NnQdZ62KutlUYKt9FHfoAdh/8d3AtqslAfKrHdrD
	gKnXk8mqHU2ac31G2frPUC1umMyeTA6OOAl61bWOEKQIRmaY4p3NAB5Gry51Pj8OtVV2NGF/wWi
	Np7BcIv0GEMIPW741Iyuotnr97o3izTx/eEg1nQ/Y2o
X-Google-Smtp-Source: AGHT+IH4B3x1POXb5aHhcwukrowB2p1LvnlrcG4wsaRRA2FY8tzIu2k44QCBVlk3X/W316xoQldbnsMrSGJtZQFmYPg=
X-Received: by 2002:a05:690e:150b:b0:63c:f5a6:f2dd with SMTP id
 956f58d0204a3-63cf5a70861mr12434439d50.63.1760533312921; Wed, 15 Oct 2025
 06:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014171907.3554413-1-edumazet@google.com> <20251014171907.3554413-3-edumazet@google.com>
 <a87bc4d0-9c9c-4437-a1ba-acd9fe5968b2@intel.com> <CANn89i+PnwtgiM4G9Kbrj7kjjpJ5rU07rCyRTpPJpdYHUGhBvg@mail.gmail.com>
 <f51acd3e-dc76-450d-a036-01852fab6aaf@intel.com> <CANn89iLH4VrGyorzPzQU66USsv1UP3XJWQ+MWMTzrceHfUNYVQ@mail.gmail.com>
 <9539f480-380b-4a29-afc5-025c3bf0973d@intel.com>
In-Reply-To: <9539f480-380b-4a29-afc5-025c3bf0973d@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 Oct 2025 06:01:40 -0700
X-Gm-Features: AS18NWALqAAB0jSVqF-GA-fBac-cmZu2ZB-8GyC5TAkt6KMWhigWO62bZ_TTvXU
Message-ID: <CANn89iLVxzmJrxhyEXYp26V9SZy5D66PS4ywf=vZ7piK99Hdww@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/6] net: add add indirect call wrapper in skb_release_head_state()
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 5:54=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:

> You asked *me* to show the difference, in the orig discussion there's a
> patch, there are tests and there is difference... :D

I am afraid I have not seen this.

The only thing I found was :

<quote>
Not sure, but maybe we could add generic XSk skb destructor here as
well? Or it's not that important as generic XSk is not the best way to
use XDP sockets?

Maciej, what do you think?
</quote>

No numbers.




>
> >
> > I can drop this patch instead, and keep it in Google kernels, (we had
> > TCP support for years)
>
> Ok, enough, leave this one as it is, we'll send the XSk bit ourselves.
>
> >
> > Or... you can send a patch on top of it later.
>
> Re "my Signed-off-by means I have strong confidence" -- sometimes we
> also have Tested-by from other folks and it's never been a problem,
> hey we're the community.
>
> Thanks,
> Olek

