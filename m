Return-Path: <netdev+bounces-223366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B38A4B58E17
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 07:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D61A16E4DE
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 05:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE122D6E7D;
	Tue, 16 Sep 2025 05:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a7mwEH4W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DAD221DAD
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 05:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758001853; cv=none; b=Q2Kew/AdSmIAeSMwZn1Pb/FVI5v+a7I/RHZoTqgMSPnBHHFo3i+V4xYq3RVfnRvWxDXdneLKXaSViLdLDtdOFwSOdCGzteG5e1+9vvsF3lKaKz18vM6ITJVKnTOjq8y/rRXF1hx09NHyLgOj4JTyF5POABIHhzAKlGBOxgprN5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758001853; c=relaxed/simple;
	bh=jOFjelAeUGYYJhWOrvXJRPCoPExWqx9ES6ZMZOxMdUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcoovJzbPznCDRTY4PUa0L9Bd5DHc4jnmIuLmsujVaZm3Diq9mcbUEZUwm80kmfUZu6QFf/2Z6nx9drof6rPUNeHerZq2TZdhZ9jpoGM2R3I5blEyeqy8uAe38cPt8Gb61ATw/aOIc5qhB45EvOmy4pajWfUhqtef6gYdHFA8KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a7mwEH4W; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b54c707374fso1393793a12.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 22:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758001851; x=1758606651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uC7lcdF5yoRsiFdtU9hvyBhv7JRrCU6GaaI4bilxlMA=;
        b=a7mwEH4Wn/lXCwJ/z6Xf1QtmD7hJ3vsqf1Y7Jalkm1h8CjHW404bG6EszAA3pYxWGI
         ntXvKaX098nU1day1l/69u4pEKVri4uHFmms4jxGrwurpt6gkfW7/ijiViXuiZxNYrz+
         2SVIIfuQA5S7lyeBsx136rnufKEyCCSGYbL3hCnpD+vg3kK3Ts4K6vH9/WibaRuoSFn9
         0oUgNerrh1vd+PUeVdsU2nDXXCE3oOU3brXh9SEb9HntMkVwjzZk7IqVQV1ogis16skt
         4NWDu8aRXuGqd9qhMs5a0/oaJc9F6qVimAcZGgpyo+O54P4fgm1OVbniFxpsIcRYbVxe
         OvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758001851; x=1758606651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uC7lcdF5yoRsiFdtU9hvyBhv7JRrCU6GaaI4bilxlMA=;
        b=f/VNz7Q8EYfbX/tb5+r3uoSbY/1A68Zx1qvf0f5dwbgezdUUKkJhDMasdQ2p+CcVnH
         kKPsRft4t1C0t0Onu96/NWdmXItexA4ZTzF5J7InVzGW3JcwI1F6vFYr7wppJM2UQaO8
         3Png2biwn6FSzxbflM2X7TARUYUK/q1jzZsWsN9HBGvu0m6RyHSez4NTBrCoF47sS4j/
         2Ldp17MUrZY45qllYDN+Jq+6PnfZhJV4YGWUVQUvN2k5WPiDbrDHsIpD3O7ys1SWQ1ge
         3I6nVmctAhTBvFDUwbQegPNc24ROWIwuKb7SAgaQ4ZKEZSZA9ECw5tZ4jh0RQ3yR7L1V
         ewCQ==
X-Gm-Message-State: AOJu0YwYkUuq5qHvxAj86w5jH7P8MZCFZdpJMYNpb8E3WcmuC/k9usjg
	RVJKzv7tO1zwl+dpPPehPlfPaZKcUS/ODOFIfgf1s6umv++SI67AWY+9GK4tT/rYZn/jELHVddO
	PK05/tSBwftMur6N/R0RyFtOCuUEfvqW5huQnffSd
X-Gm-Gg: ASbGncvgGrmOUYt9/f4E/Y+kUiHu7iemJclksX4QdRonBSQXPr/WjbAS1oCSfF1UNFt
	bcJYvI3/pJ1kf0aqb2+2PE6lBtNKqJyvG9pVGppWz2/W2z8oTGcooCnBr/hiEZEpSmns+0pvrxO
	PD1UKl6Yo/QI9D7xVPkV9GiKNFYD/uIBX4mSlWyPp9svwg0hoLn6Z7TUm+biVssodqoJ3V0orXY
	ZeMU+xjYxxy+/Kik4nYEZxZ+x7IJHBchsrIGQBUVKBGaSMwON4VvSaNLA==
X-Google-Smtp-Source: AGHT+IH09e/UIwLHFIn5tHBbvjGloxcnDvNUC5XqPJ6Ur5oPUJmXEEWj5rpHipUdPu/FhGvqE6CzeD7bxJH1uBFa3v8=
X-Received: by 2002:a17:902:ebc5:b0:24b:164d:4e61 with SMTP id
 d9443c01a7336-25d243ef720mr148256445ad.13.1758001850396; Mon, 15 Sep 2025
 22:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913-update-bind-bucket-state-on-unhash-v4-0-33a567594df7@cloudflare.com>
 <20250913-update-bind-bucket-state-on-unhash-v4-2-33a567594df7@cloudflare.com>
In-Reply-To: <20250913-update-bind-bucket-state-on-unhash-v4-2-33a567594df7@cloudflare.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 15 Sep 2025 22:50:38 -0700
X-Gm-Features: Ac12FXwEOEoC0t6UZJJv-0VKN3jaamvHvSxEOTs7rz-typPuEzzo_VmJk3L3jMM
Message-ID: <CAAVpQUBLvvhPjbmGSnUk_Up10AowDEeY_bR=ecZFoSN5ef1Sfw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] selftests/net: Test tcp port reuse after
 unbinding a socket
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, kernel-team@cloudflare.com, 
	Lee Valentine <lvalentine@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 3:09=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> Exercise the scenario described in detail in the cover letter:
>
>   1) socket A: connect() from ephemeral port X
>   2) socket B: explicitly bind() to port X
>   3) check that port X is now excluded from ephemeral ports
>   4) close socket B to release the port bind
>   5) socket C: connect() from ephemeral port X
>
> As well as a corner case to test that the connect-bind flag is cleared:
>
>   1) connect() from ephemeral port X
>   2) disconnect the socket with connect(AF_UNSPEC)
>   3) bind() it explicitly to port X
>   4) check that port X is now excluded from ephemeral ports
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!

