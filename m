Return-Path: <netdev+bounces-169878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8C0A4634A
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D8D1697C1
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 14:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5044221739;
	Wed, 26 Feb 2025 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CHfY64kF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B16F2222BA
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580977; cv=none; b=P4pjFVrvSUHu1fH0Bw07Td4UhQDYI7v17PZj8DW+Rr7QvQtWkfC+p0DFuTdmvGBe44PlW6uiXHZIAsKXBpK6pI5XdslMWQfI0+DkKOLrGT7aIWuqLaBJRVvXzjxT+/rwt4iZKwDyjG2p5I0Ch+IylnRYA5zqfQo6juvBGhXUBIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580977; c=relaxed/simple;
	bh=HW4q/dvrHkzJHHF6z9dslJz9bNwRts9FErUkzj16gs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xnbxva6smlH4Te9L4GLxokoFOGfmM0yh7ra26Bq+M4LuoMIL+2UEMTQgIUm2sfRe39fcPRBMy1VifXjohUKFHAkn5B+hPraz4lYOaIUTvtd1npC07AZegtsWEDAqYtynUNcElD/8/cxVXN8RijPkhJIGQzdMmvQfQXxrLiuYstw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CHfY64kF; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5debbced002so1800069a12.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 06:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740580974; x=1741185774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HW4q/dvrHkzJHHF6z9dslJz9bNwRts9FErUkzj16gs0=;
        b=CHfY64kF1+XUXJZO8/MMcuKOQpL+vV7C3h4MS7gG//dPThDgw7yvnx7vwCzcU8AQEA
         EByXRVh+DymQKxU4CyAQrYkVzfWs3CPFp6U6DGHzhAjNpu7qMwqBRfJzd/2QcGas8y+m
         mLXADlT4HwccvLwG2Vok07WquAWngYM2HZZs2bYBtknsu5qAo5XlO9ZSJOt2REMYxsjs
         5TECzTA70qxfXTGkD7z6mcN1ekODYSQKnXKBqRNUq9gqjCMdHdfvjY/2bLMWcqwjnIo1
         KoBHwOKg7DGaabZt3hgEszWB4AiyFhSkwt0rZtf4jg7KeaeLtzWRo4I/VO2vgASpvqi4
         Fp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740580974; x=1741185774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HW4q/dvrHkzJHHF6z9dslJz9bNwRts9FErUkzj16gs0=;
        b=a4TWYIqwp1OvKMCGhcU+G3MN12aGd9lM0bJmaYEwWtsjLqutlre0Pw9KIijTmYZ2JU
         7ibt3qWiCysjQx8EGVPYp0vo1n3Ek/4GtR7v/+Jpfs679OLi8GiIyfReBWPUgHygiSca
         nl6b+rdaRhRx1N0U312Kog8AApYcMLDjosK0CZY/UyXNOvWGLM1wbfGwRJEgH8WUdf3O
         Dbb/p3MixfKN52PDCIXWYTzJ8XSi5wnf1NpmTCf9yvHlsRiUb8hWhWES2lG1QfpGEYBj
         PdNC7K9e85PraXboa76nZ3ZELpJx/XRic3U0811Mgab5BmBeIPP1r7b2T76dgxOlXxCq
         rSmw==
X-Forwarded-Encrypted: i=1; AJvYcCV1FTWJ1PrUBu3KgFsevfRlx19rRxTOpHRQ+eUy3OCzrSk4QnnHLIJfnOymxWT/zObh2OJHI3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUUNs+X5JpUTHRJQt+0MHmZ5zrzv0zL9ao8msOzcg3T8q2pTbL
	B0u+YOzvOyXe3etpxa7yUz5tkjGrPt053q5HygDmh/mwAzS3I8GcUaXY+5jkXi5j4O+25kJW2cF
	f6p6JQ3zm7xq7JQOXHjpIAyBuA3lrqvFvsz8o
X-Gm-Gg: ASbGncsA8HHq1kjnmyrudtmE/WH2jy338aJEvoxYcA5rx+0Ph86fLjUhvlN03afqqcc
	6FYWP99AibjqKlNlW/6cjWqJSUo+3nyiUH1taUrUOUgyMY1/HfnvJF76P8m+NObz7T4TVYnFy6q
	0Wq2g2uCU=
X-Google-Smtp-Source: AGHT+IH5mqfDRfyqyxFGF8aXm6i1q9j+VX3XycvTw3g5gRs08qHcE16+b7D9MWqf/dv7BwzjkInUcxCoyK77povim+Y=
X-Received: by 2002:a05:6402:274e:b0:5d9:f3fb:fa45 with SMTP id
 4fb4d7f45d1cf-5e0b637670emr22302046a12.16.1740580974154; Wed, 26 Feb 2025
 06:42:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225182250.74650-1-kuniyu@amazon.com> <20250225182250.74650-11-kuniyu@amazon.com>
In-Reply-To: <20250225182250.74650-11-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Feb 2025 15:42:42 +0100
X-Gm-Features: AQ5f1JrZU4NeYk5NsQU-1XbqpA0gZKmVrU-X8XynAiKlVvXL_UwLC6LTqMeJLQA
Message-ID: <CANn89iLZ=CGtSbP+M1Ycv-rjXxN5kG4Hp8ZKzTaFTt87TEf6OQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 10/12] ipv4: fib: Hold rtnl_net_lock() in ip_rt_ioctl().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:27=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> ioctl(SIOCADDRT/SIOCDELRT) calls ip_rt_ioctl() to add/remove a route in
> the netns of the specified socket.
>
> Let's hold rtnl_net_lock() there.
>
> Note that rtentry_to_fib_config() can be called without rtnl_net_lock()
> if we convert rtentry.dev handling to RCU later.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

