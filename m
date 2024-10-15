Return-Path: <netdev+bounces-135472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB18B99E0BB
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DAF31F2546E
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458251C68AA;
	Tue, 15 Oct 2024 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="czT8fMT8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879761C9B81
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980270; cv=none; b=HLDm0CJQVv2WwyPtiJnLd7GyZjHNnjkpSsBDy0iqb7bcvz3VHHd8oqSljZ6QW+RdTHvpn/0zxT3Y4QlapX59NbKLGvhl0X3n7SQ3FjKoDoDpOlOQ6h0uC5Q6TpLhnutDemLV/DFprAxOFKoyVWZhVhgzaytOQ+Rxh8scBcTifrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980270; c=relaxed/simple;
	bh=NJ+gdPg7AVUPVqSIE9u+0X/whrIDBj0KAP10SY13xGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMJQlymTj6mRN3xYmME1t7X8KRHMmpY6eiXeOkid2u4GUhPcjc9rdkvnSScOopgQ15dv5/R/Q5RdWiKpMA/N0sZOhFIT3WIcGmgFJR9ApQQy4IQGFsiLlpNuvTDIaZfY3M/GC0nt+lUuCyc8aiLM8qsp3lFXv/2rQZMJUNfckPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=czT8fMT8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a994ecf79e7so777750266b.0
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 01:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728980267; x=1729585067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJ+gdPg7AVUPVqSIE9u+0X/whrIDBj0KAP10SY13xGg=;
        b=czT8fMT8OnGUWHsaFeR4pL8kRQln4wN552ghB+Q+gmgaQUnhhhVuOIcYA3oglPcg0/
         1YJdYGQwL/kUKkJkDZVmdUefVYMWTEDEGP/ka+sjcLM4XUezm7xpWKqk4l9Sb1tP5JAb
         G3THwOVqLxxic+9JgFm54uHRZmLiO+a0h22wabPpv1iHC2bCg0A81Zaxc/UK6z9Toph+
         FpLHDbd2R4GjdmrrcHoKN7B67C6QQTcPkJwet0HavqsHLERLDT8i3iozvi4HbVwHgP13
         DwI3EBfdKDbP4aPYnpf+Fo9/TsNi+5Za5fh+Uj4riuG1Ch9nMcQm51t6xX883u2yba7m
         DT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728980267; x=1729585067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJ+gdPg7AVUPVqSIE9u+0X/whrIDBj0KAP10SY13xGg=;
        b=Xq6WUcqt7M53whxs76SYi6yL0z+9vYJcrRMfaB+OkwJunJuUHQkE0ao5HanNsXO+5J
         1ZzRQpCTJ0v5H8IVjOxa5TWHNeHZy3KOACzWPRTakSt5ktT6IVv9UvnNsCzUOi6C6p5J
         xC9jT5Ph0BwnmAAB3As8qHGEqtd4+AKI8wIhZv1EqkbXvBLmqcXUJ9yaodIXkhfDUQ6i
         RSqZCfHGuBn35tt+YgXLiH7IVOn2sC5T2a6xb4m0jWdET851klSJ4e92QdRH69dlM8bJ
         84MlITc4ykVZHzoKbm7Y+S0V3IGlYyARcnib0BH8URhMhCSrUjGqVrCCWmHMua6tq7w+
         OF+g==
X-Forwarded-Encrypted: i=1; AJvYcCXZONz7bY0UXSDE0sPyCOdSHE6hGOBCtcA04iD5Axh3drS5ifNUCA6kusynS/sMADBFL8nhrMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoVnZmKL60p2ykfNkNNXWwI4jw8IabfYASpa/LtikkLM/Sl+Ex
	G2TMXRy1umn2stIU4BgGWvSRY2UylN9ibzxf1Q3NeqszL5ujxf8Lq0crr5TY1FcTIWgveW1ZbKk
	lw8dVHK9kd6EYDSgV+7BNBCuAZCyPRJ3Va5mmfPHYTxUKh30FVbiz
X-Google-Smtp-Source: AGHT+IHl+Mk1zsnbn1r70wAEXK1iwSZ5UDVTZTp0Q6lhuNFwo51kJg175MFNBWekvpkz26U2yNc6sABG/HTZ9tr9Pt8=
X-Received: by 2002:a17:907:e9e:b0:a99:f779:adf9 with SMTP id
 a640c23a62f3a-a99f779afc8mr920243066b.63.1728980266540; Tue, 15 Oct 2024
 01:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014201828.91221-1-kuniyu@amazon.com> <20241014201828.91221-7-kuniyu@amazon.com>
In-Reply-To: <20241014201828.91221-7-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 10:17:35 +0200
Message-ID: <CANn89i+Hr5WC_h-PKFMDGHUqB7W-ROaq-5bSM0FLgSNTZg_NYA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 06/11] ipv4: Use rtnl_register_many().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:20=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> We will remove rtnl_register() in favour of rtnl_register_many().
>
> When it succeeds, rtnl_register_many() guarantees all rtnetlink types
> in the passed array are supported, and there is no chance that a part
> of message types is not supported.
>
> Let's use rtnl_register_many() instead.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

