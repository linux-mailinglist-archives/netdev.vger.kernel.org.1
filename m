Return-Path: <netdev+bounces-138979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED929AF96B
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 07:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45061B2114F
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 05:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7058318F2F0;
	Fri, 25 Oct 2024 05:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/I9yhYr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEBC18E76C
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 05:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729835952; cv=none; b=a/Lm6Ufe0CF+7SQsgV2CGdEGH7JboRytWM8HminGbX8r/LbMeK5SfcGfhafplWmVosB36j9ZVxdWA3lFWUf4cliziCI5DbRTbs3e5c+GwCWu0Or6kRiWzZdCSvnel/WluVb6loIL0mHhcflLrGMDDFbrfhZiO+C7BWcPJ6A1keA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729835952; c=relaxed/simple;
	bh=889DekKwPg3I7tZY2hm5fT+TKCkq/RTzOXQTBLUMCHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMe5LmjICXpDxHi+6/P9w8NgbZDDLMvehI4PoH0ZK596KDlZkxCD/JJZTKIYKjEuUlhZo2KoEHj/CQuCbHtOsnPT8XV6QtnKIkSmN4XYAZdPcp3IVlOKIiwQBtDJPkitlJR0Xv4i2W91GVHNWaF4aH+jbvnFDLYfl0U/vaktG8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/I9yhYr; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b1507c42faso213468085a.0
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 22:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729835949; x=1730440749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=889DekKwPg3I7tZY2hm5fT+TKCkq/RTzOXQTBLUMCHI=;
        b=Q/I9yhYruZleyjB8V/sY7Kwe96laxfIluEN4SOL/Up13yD8EAiLkSrrEc7QKL+b2KT
         91LnJhoxz3eZd6NuGmCg+w8XHnvBw95MW1pDfWsaUVQL+/y+HOvmThU8mbxgf9rSLUf4
         HfHBq+SYpI7VZT+WLicoeouhw3Jq8q8LMbKc2SPhc0SJgwQ2XAyVCNGBAX12hTs15MMF
         ffZooQmZZIrWCnzwZZbdVqHPEwei01+zY7isV3bQ9jsbIhpQ71XI6WsqaMDBQSjVJ/eE
         cCJLgTsD6UZyAdHYX3S/Jam2F7ZjYBBsMHMsFKvEuQpjbpTV6H7KDTpFn76lX4DgMy2t
         kBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729835949; x=1730440749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=889DekKwPg3I7tZY2hm5fT+TKCkq/RTzOXQTBLUMCHI=;
        b=WrynoRyS1rtYeDbd9fQgc9cen0IDyxmEmCQu0NOsi4r3uNMFbiXrSGk9OWvZBbUUbr
         Mz92PH7d1jRRet4drweII4GFrNGRqWA0TeIDnbgkLP93Zd3I0spq543dyvw0b/OW3klY
         MscaZCBZtZT0J7ZJqSRCaoe+R/zbC103GFj0DTIXJgm7D1q7mXtwJnC6C5LX6VSksePJ
         emMGAxuZJIXTKvmW5R+LqWDr/pmBApg8/Y41nyBD0ktTdmemdLYmsqh6RDYYUJVgOlaL
         0fT9A1VTjfHyLUC6XzbQRiPVr3xS8999uHiad6qxclz9d172XUlZ7V7sInqXCZyxYC6c
         rg+g==
X-Forwarded-Encrypted: i=1; AJvYcCUwE1GW394+N7rYDmmACZjSvrHtPScp0T2DaOdLY4Jo8ud0OmwJO4AVN9GFmHR5AuMAGa+sjoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFHMHXtPl+yFBbFD90nFmblL348g+JDIhI1Y3esOTK68t8brkD
	3w70rFu290z9GhsepNV3CQZGtJw8MrGvOOsAdIstxy2EYarp3B6ao78LE+pfY9xrHveIL+LmqRP
	MaA8dQ7nxWxcvDKeoCJESYU6KM5KZvnw1qo1AZg==
X-Google-Smtp-Source: AGHT+IHoJyJzl4rVKPt+oVP4Sgnh1bOW+cCK8+cIUu2E1P83B2Aafre712u5UmakrkK1XsAw9Zgsx/8GlrWt9Frgzd0=
X-Received: by 2002:a05:620a:454c:b0:7b1:4762:8a with SMTP id
 af79cd13be357-7b1865aec1bmr768212385a.3.1729835949385; Thu, 24 Oct 2024
 22:59:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024093742.87681-1-laoar.shao@gmail.com> <20241024093742.87681-3-laoar.shao@gmail.com>
 <a4797bfc-73c3-44ca-bda2-8ad232d63d7e@app.fastmail.com>
In-Reply-To: <a4797bfc-73c3-44ca-bda2-8ad232d63d7e@app.fastmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 25 Oct 2024 13:58:33 +0800
Message-ID: <CALOAHbDgfcc9XPmsw=2KkBQs4EUOQHH4dFVC=zGMfxfFDAEa-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] net: tcp: Add noinline_for_tracing annotation for tcp_drop_reason()
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>, dsahern@kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Menglong Dong <menglong8.dong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 4:57=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Hi Yafang,
>
> On Thu, Oct 24, 2024, at 2:37 AM, Yafang Shao wrote:
> > We previously hooked the tcp_drop_reason() function using BPF to monito=
r
> > TCP drop reasons. However, after upgrading our compiler from GCC 9 to G=
CC
> > 11, tcp_drop_reason() is now inlined, preventing us from hooking into i=
t.
> > To address this, it would be beneficial to make noinline explicitly for
> > tracing.
>
> It looks like kfree_skb() tracepoint has rx_sk field now. Added in
> c53795d48ee8 ("net: add rx_sk to trace_kfree_skb").

This commit is helpful. Thank you for providing the information. I
plan to backport it to our local kernel.

>
> Between sk and skb, is there enough information to monitor TCP drops?
> Or do you need something particular about tcp_drop_reason()?

There's nothing else specific to mention. The @rx_sk introduced in the
commit you referred to will be beneficial to us.

BTW, it would be fantastic if we could trace inline functions.
Additionally, can your feature[0] also allow for live patching of
inline functions?

[0] https://x.com/__dxu/status/1849271647989068107

--=20
Regards
Yafang

