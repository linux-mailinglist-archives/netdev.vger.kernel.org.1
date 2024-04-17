Return-Path: <netdev+bounces-88636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ADE8A7EFD
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 11:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3AB1C21389
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 09:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7172D6BFB3;
	Wed, 17 Apr 2024 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HqYxPXd7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B11F6A353
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344534; cv=none; b=kqqKh4n4/hSRzK6G1SdDFM9o3C45QRfBTbBmV7XiwR0c11Unlq4XyfO+YvizjLMgzpn71S0Q4FuMVNouKj0xplILhiuadDDwlBjj+0NXNs8aMBkmy+cen+Sd3eSgaB/9PFgWi2v5MEXmTy8g2NqKtAgiDzcUz776K8Si+QjeZJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344534; c=relaxed/simple;
	bh=co0vGStyxzs2wYudwfZgCahyCD+9GAQnQzEr1hx3Sl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9l/xKQw0bmwvsktfeLGqJnTjOr4G857/GOvFjTql366GPHzclylSG/mrMOlTkM5i96Axb3Q8sJoLXRlwLbdThE7fm0QtA1vO1DSc6Q/pQo2cF+a9/OsSUDZpgtdhA+tmPzt5U6Axfy42TvxYjFjuYZrhfXk3vGbCtKOoHtLahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HqYxPXd7; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so7713a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 02:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713344530; x=1713949330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAY8JMpfOE+rjYgFlJjU2Fp0QQAa6jroDez9CFZ6FKk=;
        b=HqYxPXd77MPew12v8LA56Bq0K7omPm6X2MKAEaSBhlNXILBjnUAUtPC75YnQcIYEZx
         I2k8iR/g62xXeb1rJZlVAiC2AM+VFDR/YQmakOlgEDZYaodjL1BZ3QkK/NQMksJ+yhbP
         o5Zk872P7wbLiDL3b+WyAGIF99tjTlQHlf85YalvcxZ0+BrrFSiemBQRnd+0UD9xwCQa
         dhK4BU3P94N9XvN4ytbhzVQPkIDIh9Q+QtYbqUn8w1K4RZsPM0Cl0BKY/tmhMyyGc7eH
         DfLfEkEsAGe58W52sPE97LoMWpjGzHKmiud3MYuYOVQWxooWvkMjxp3bjkj5GUH8tnuZ
         LVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713344530; x=1713949330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAY8JMpfOE+rjYgFlJjU2Fp0QQAa6jroDez9CFZ6FKk=;
        b=xVoYd/S9yrQOwauSypwCbaSEFm6fiikRFSHpP4MbX8zlvENisl2jMAQpOQ/rJDHC1M
         tgHMMsnQjdocpdnWcK6N0mFlWx/RYy9xaO6NxTddTHd+ONlPXYrZ5LFkppvUlD24YgIE
         vcx4QIFM+JHR6JGBdzl5/F2V9I3u7zLmQGiuCz/FlXTt3bHwwXprwg8m1N5GCb4+bQZx
         5PgfARaXzYshCwYaN2fXHRz/M5+A+SOF95kJyF27L4U9bJvxsXZ8ZYerT8G5FIHTUSgD
         nWJGPJEbqopNzV4Xa8dbXerBkJX+T+RS08lUf6QSk1LYbPsthJ158xtcrz97JljGuy5C
         cBdw==
X-Forwarded-Encrypted: i=1; AJvYcCWZxKHTuMI3hiU8Iz7PNsJ6YUq+PIk2aRU5hM5MpxSKsWp5IuKURWkC2TnkRFv8cIzD9c2HSk2Wlfj6bwzQ3ovqQv/FwucQ
X-Gm-Message-State: AOJu0YwWfuF0+4C2bfRj7vfaCbBb9Lc4g1EIzA0veWFPdKM7H42B5EZE
	S0WVWHVpYOqCTK7oKoS/LyTtC1teRFUQ4V+1jVlbxCQ8+AW2SdTfkFIbXNjyTcxMbs0MSESXx5W
	0xUDMd6xOXaYB2c8tbE0pw4//1etXKFTGzEZV
X-Google-Smtp-Source: AGHT+IH4cUad/wnQKLE4dWvHNWAVSWHtbhac2FgNRdt0BeRKm1vTHUByA1AGiXIWwXcHIzNQLrGDOtsihbDKjDzHamk=
X-Received: by 2002:aa7:d9cd:0:b0:570:481a:8a1f with SMTP id
 v13-20020aa7d9cd000000b00570481a8a1fmr108872eds.5.1713344530145; Wed, 17 Apr
 2024 02:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417085143.69578-1-kerneljasonxing@gmail.com> <20240417085143.69578-2-kerneljasonxing@gmail.com>
In-Reply-To: <20240417085143.69578-2-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Apr 2024 11:01:58 +0200
Message-ID: <CANn89i+aLO_aGYC8dr8dkFyi+6wpzCGrogysvgR8FrfRvaa-Vg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/7] net: introduce rstreason to detect why
 the RST is sent
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 10:51=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Add a new standalone file for the easy future extension to support
> both active reset and passive reset in the TCP/DCCP/MPTCP protocols.
>
> This patch only does the preparations for reset reason mechanism,
> nothing else changes.
>
> The reset reasons are divided into three parts:
> 1) reuse drop reasons for passive reset in TCP
> 2) reuse MP_TCPRST option for MPTCP
> 3) our own reasons
>
> I will implement the basic codes of active/passive reset reason in
> those three protocols, which is not complete for this moment. But
> it provides a new chance to let other people add more reasons into
> it:)
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

My original suggestion was to use normal values in  'enum
skb_drop_reason', even if there was not necessarily a 'drop'
in the common sense.

https://lore.kernel.org/all/CANn89iJw8x-LqgsWOeJQQvgVg6DnL5aBRLi10QN2WBdr+X=
4k=3Dw@mail.gmail.com/

This would avoid these ugly casts later, even casting an enum to other
ones is not very logical.
Going through an u32 pivot is quite a hack.

If you feel the need to put them in a special group, this is fine by me.

