Return-Path: <netdev+bounces-162037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B26AA256AB
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 11:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733273A9892
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 10:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B44200BB4;
	Mon,  3 Feb 2025 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lt4O1M8w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C555200B8C
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 10:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738577411; cv=none; b=BY5hMXaSIWAU+U/dRoarcgf1hvNO4XjnJsdDT7pcBQbISZCW7d0Tkt3FrPLsSE1efs26H0dQUEyJ+XbmFp09VZu+GXMQOQhXb6LYDroMd9LFvaXu+Qkr+maUnsyml2At47k5IR9xM7clNe4FDxg0swiN9slRhOizR2ZMN0ZZTwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738577411; c=relaxed/simple;
	bh=QY+adC7CRKaHfGkZyktnx1Z096et7HL8MtaXlJBz3QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxQ+wNv9IYYImAaCqPNQI6NQQoZ5wMxLp501q0+ZklsRIizBiHMDkAtl8lW9sObPaEq2uIq+dVmyCwtCpactseNruOwjKF8nNAXjdd2WyXtMpmFV1IjezXyhETBP6v6hCEzFuzAO9689zK3ENFnhCwFab29jUAdldsceHnUDubI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lt4O1M8w; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d96944401dso6806150a12.0
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 02:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738577408; x=1739182208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8E//xQg1sdr4osdEJWZhsDye0tENvBeQ5yKFQrKgSko=;
        b=lt4O1M8w0aiZVa3B5JnTkuNq2ZHBAMWYYmeiHJ8u3rOp/Ikwko4J/qp5+E4PfW2kzq
         0PiAyBQjXsn9YGRVDAEFbQS1KfYxG/MgtZIBS5kNPJVUOym8kUVeFMXxvOsM9XPbO2Kc
         TPQfEBUKaCp6HzV1LTz3QEZHZiZ94zvajtZhYgAneR8vX3fCBDWqDy+H8N/TT6CAYGfN
         W4SL9+EPgfjMVLRweSsF2IssmzRjpdfrSls5IgQikr8ShL7XJjCcgZKRnMkXuBWgj9nO
         Vbs5G7XLYhwYqS/xQOfQKbvu+1/xzNe6OL7TUMMi6G2+CDu6S/0NC2JQR4tUY1vJ1crp
         9/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738577408; x=1739182208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8E//xQg1sdr4osdEJWZhsDye0tENvBeQ5yKFQrKgSko=;
        b=fEIjpz1JAfsfdbQ/VxOj8kOFOY01Hw0XLcTouE18goY3ThkJgf0vadDZgIxYJW3U8U
         optTIn3W4yQMSYTIa3mEEPR5719zi5OsOKu2mlu+mkFNaMgDo/VRKS9hHGfuCk3XW5yx
         imI7bCBRdKQdWaGc9D2OzwigtL8PI5MhLuds8JrC4gTl5KpwHDFRKgw4Iuu1+D879aD0
         FVtIxus2FMshrM6WLVSTfQbo/CfDkF9X0J+DiEVzWbDJfrip4o/mG89KXxfLt56r9KBl
         TEKDqnIoI4Z4FKjKIS0u1P0j0e94mahFy+pbnTrhDhkW1Amtp1vyRYAw6JmE/sCb1CJX
         fqwA==
X-Forwarded-Encrypted: i=1; AJvYcCXdxv40WonvoviQiwmnpB+3EPgdL+y9OL8RyTIRdbdGRqhNPjMvllhK7h5IFbKGd+Y3h4P0+wI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMH4QquVUg1ppkeKQ5Rr6cA33CsBV0/6dIsqRGhCRuecpjAkT7
	wpwx4xSc0JUiUm7RWdjauW4JSxyp0Mdz34ECeqpkmCvL25EZo1DZKs+baoUSBYj1ki0aOPjlUqI
	qTIi9PDDZDBxkQujsqmmRYC2AS63p1ouBjjkQ6jxVfbTyRxO1owzk
X-Gm-Gg: ASbGncspyBoMI6OowYytJuNbFnUr7EBSwRrf4fLtMi6gDd9HCG+9UP7mIZmyW0PKbov
	GMUm0uvSflV06ahmqNEZdL1az4LiIds3FxUPa2s8UghrFQpbDSQ9itAZ+FgIYnb0EDS6ma6c0uw
	==
X-Google-Smtp-Source: AGHT+IGRDfFBtCgWcpUr0gzTCsCEb3fH9B4cWknG4gQZk5mFY9fQmhZeuaXEeTlpWdoUAKXNLSi2WKQuo3HuPvQXTwQ=
X-Received: by 2002:a05:6402:2388:b0:5dc:7464:2239 with SMTP id
 4fb4d7f45d1cf-5dc74642547mr14685571a12.7.1738577407633; Mon, 03 Feb 2025
 02:10:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131171334.1172661-16-edumazet@google.com> <20250131194623.187-1-kuniyu@amazon.com>
In-Reply-To: <20250131194623.187-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 3 Feb 2025 11:09:56 +0100
X-Gm-Features: AWEUYZkgkJ0fyRYoCPNee5JSuculV-bf3YrkodH1cj7h4a-hbRdNlP0jzfzjA08
Message-ID: <CANn89iJCrshU6iqMUuPNuC6caqqw3E0YPLov5Zw2+jM00bKJig@mail.gmail.com>
Subject: Re: [PATCH net 15/16] flow_dissector: use rcu protection to fetch dev_net()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, eric.dumazet@gmail.com, horms@kernel.org, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 8:46=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Fri, 31 Jan 2025 17:13:33 +0000
> > __skb_flow_dissect() can be called from arbitrary contexts.
> >
> > It must extend its rcu protection section to include
> > the call to dev_net(), which can become dev_net_rcu().
> >
> > This makes sure the net structure can not disappear under us.
> >
> > Fixes: 3cbf4ffba5ee ("net: plumb network namespace into __skb_flow_diss=
ect")
>
> The correct tag seems to be
>
>   Fixes: 9b52e3f267a6 ("flow_dissector: handle no-skb use case")

Yes, you are correct, thanks !

