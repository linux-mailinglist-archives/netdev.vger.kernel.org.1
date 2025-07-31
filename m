Return-Path: <netdev+bounces-211178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8278B1705D
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 13:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6093F18C64A8
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 11:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A354C2C032C;
	Thu, 31 Jul 2025 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cE9uh/lG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65B62BDC38
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753961327; cv=none; b=HtRAwB+PnEoDRO+LwXsvJaWWfPOpFbW9jegeR2KRe86D4vJ3wsCySXBoGL4r1U5PwpPnfm2ifIFXRXnCeZzGzfbSSUSkPg/bErejMFHG2rPcLwbqJ/scB1b32XLCZan96E1UaJbPbh8cT/nE1i00mzkVe4AlWR9wGjBHI7BwH18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753961327; c=relaxed/simple;
	bh=DeNrnfxc0yCsmF++d2m59qjNIfz9tjCOKX+Lu1e25hk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MClyhCEhVl4Btl+jbQ9dUAZ1c4QW04p0XcjwrZEu63laC9/xZNV6d5RYFwMdHFygBhwALc/6Um8uvQl1OVYJpNYtXDeLCEm1agZEQViLueD0NzzucTc6+GV8nHf3w83RqSb5P0XPdUxhdrb0XVrWc6Bb+NLdLRGEAiM/I28AkZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cE9uh/lG; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6155e75a9acso394173a12.0
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 04:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753961324; x=1754566124; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DeNrnfxc0yCsmF++d2m59qjNIfz9tjCOKX+Lu1e25hk=;
        b=cE9uh/lGPvCX3am7h/f8TBbK2bPBfGN2uAYgoe+xrD1kFVgAC2ADAPTYT8BHXfYljo
         0GEY8eKmGAkIHLjnN/Umd4ho8S5B8zZAiua6xStvgYc8q+TCLwTwbanrjtDdfu4+i6En
         X3SIcHnUeq8WTnqk+5GoDkqBzRJ9VbHqkaxV0d3xEeOiLpqjHDGUVMh6Aeo54LanY7G+
         epvg07mvL8F2r1ro/RXJmIh3cldp5ggi5N9is6vjGmFnxO9Sex73eRiA8b6oRtfTXozE
         t+9d1NBHhaahrQv0czPcJe9TU4MVN/eyYc3WrZQN79Sp9VvkTrBsRW+EnNFHN7KH2FDy
         KXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753961324; x=1754566124;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DeNrnfxc0yCsmF++d2m59qjNIfz9tjCOKX+Lu1e25hk=;
        b=ezKFSdQrMpuzwe23jIted5LivEF4q56/umROHTKEbDQ5oACpIBMNSGl5JZdG544ZqT
         h/f8D9gnhM9J9U335RxT3xPKTL+swGkFcfRSIzCgS2xk+hPPlZTbpSYatED2lupE6X2a
         A5ce+acK4Uano6ODzXDCkcBCSd1E1reHfW4h5HDXkolHeDp7sP9b2sXcBiYPErXcruwf
         sR8ie6FRHk9DTH6c5WLhtuNfBckLwiHrR7dlzBt8YrWfk9tV7GKTn//VvFZ7Bhe9xrUG
         SNayFJApGhOwQi91VsFH3GaXj6RDGy3apd8Wrmwvd+/tVBkWy5P+A10fXCG9adBsceM+
         ZIGg==
X-Forwarded-Encrypted: i=1; AJvYcCV2gQbRfxhzI5YGHpXN+VC6fEU7QrImjJwp9lAG4gEXhHDUad9r+BI9z7TcBgE2/NRWLZ9VmH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOPsZWpSobvrOfJXMOw7BAr8H4SvABdNyI8p7qAki8W4ALb5yr
	hp9sQH8FKj3hKJ3YcqxzS3DCUWD9SYWHBVc/MSj7jpsXlyFS5Hg+fsw8kUyjHbX/lNc=
X-Gm-Gg: ASbGncsZAUmhUV68MGG7+/NRlGh406aUwuVOPunOr+IOcTNurwKm3b7lcQUuCGrqrwZ
	06jPeQp3m/OGLWWFlTwO3fZG4u8toGviXK6HnQTHmLm9LAIbAFfwjH5vGkpeSqB2mSnWPFLdsZ7
	FZ71+iHoXiaCqPTHw9irX0hQoDL6JrgGlMmu4CHrEVNbeh0lSqoh1+ns9a6EZWgRW7SRrdv9PlH
	2v3EXXS9okn/opfFpQT7TyXOCcdkbMMIU63SmJv5pofisIalofyO1zqVr5+zpA8gW8BBcSyw/Ji
	cb5e0QgZZlfjYgD3+F3Nm9beyuKWUIxkxpV9e+94xArSLhOGyq0m6z7btEooed8wedJkG/r6Ml8
	nA8fUEbJPeKb/G9U=
X-Google-Smtp-Source: AGHT+IFQDPIvu+PSiZ2WNlVaBBJOiPn/OH0Qlv3IiM/FRp6ONy3Sa9MaOxjxQdz3RYKV7wwi2Hrj+w==
X-Received: by 2002:a05:6402:4414:b0:615:5bec:1d5 with SMTP id 4fb4d7f45d1cf-61586ee297emr6880898a12.7.1753961324111;
        Thu, 31 Jul 2025 04:28:44 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:eb])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2b892sm929987a12.25.2025.07.31.04.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 04:28:43 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,  Andrii Nakryiko
 <andrii@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Eduard Zingerman <eddyz87@gmail.com>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Jesper Dangaard Brouer <hawk@kernel.org>,  Jesse Brandeburg
 <jbrandeburg@cloudflare.com>,  Joanne Koong <joannelkoong@gmail.com>,
  Lorenzo Bianconi <lorenzo@kernel.org>,  Martin KaFai Lau
 <martin.lau@linux.dev>,  Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?=
 <thoiland@redhat.com>,
  Yan Zhai <yan@cloudflare.com>,  kernel-team@cloudflare.com,
  netdev@vger.kernel.org,  Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next v5 0/9] Add a dynptr type for skb metadata for
 TC BPF
In-Reply-To: <20250731-skb-metadata-thru-dynptr-v5-0-f02f6b5688dc@cloudflare.com>
	(Jakub Sitnicki's message of "Thu, 31 Jul 2025 12:28:14 +0200")
References: <20250731-skb-metadata-thru-dynptr-v5-0-f02f6b5688dc@cloudflare.com>
Date: Thu, 31 Jul 2025 13:28:42 +0200
Message-ID: <877bzowqdx.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

CI is failing because I forgot to enable NET_ACT_MIRRED in
selftests/bpf/config* for the newly added tests:

https://github.com/kernel-patches/bpf/actions/runs/16646787163

I will wait a bit before respinning.

