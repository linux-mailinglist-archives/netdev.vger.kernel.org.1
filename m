Return-Path: <netdev+bounces-241864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C839FC8983E
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 12:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 534613585AA
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 11:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63E9321448;
	Wed, 26 Nov 2025 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TWBm9nFt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C0E321F48
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764156472; cv=none; b=g5rl85L171Sqbd9m318h6avt/XdF+XYylxiVIUWW9rqPSeA/UamZEz7zaTb40MdZDdhvDp1TC7QR2Tqzg2S7qiUWOBNFcKpt/aUocD5xerM3vRT5V1L9X02dPi+5y/SR8c1rP6s9a9t+qQ4+hgwrPlwOLPefoICODgduWHnCsjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764156472; c=relaxed/simple;
	bh=kcuczaZ5GkPO8H+hZQFd0TtQO9CvE0wBUafzpDXN61g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5X5GPoKURgxh4VE10IWsOenxc9J5MBLy8wtfp7fXIHrqHiatlIE8K1k4+2GUX481X+UHxs3Ij4IQ8j4JewLEVz2UTBeIoJh69upC3BcsaZ9XOAt6oKIpsorRl5h8uAHppyjKp/jiRljpWmCjQBSjUxWqf5vYIaUwWZQnwHFQxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TWBm9nFt; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ee4c64190cso49916571cf.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 03:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764156470; x=1764761270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcuczaZ5GkPO8H+hZQFd0TtQO9CvE0wBUafzpDXN61g=;
        b=TWBm9nFttGLwwIBz140riT+ymWoQ9kcUlbBWMVHqKPAwOJNbwOHCcThqV939uXvvSy
         ksfwA1UVyh3ojmnxAoKjxRisYa+s94mdGezVR1xlPxX/E1WtxOXdUKd6K3LUXVyAkZ6l
         Qkasqa8rLJs6F8OC4OOCsjSTxFknLh8ugk3t+Q3NffrNRE/rUkleKV/37DVEvssY8W+f
         tCe/WUhDL5O4TXDoc8LXxQjO7uog1hhC/ePvbByjYsi4CbhPuUOpRgGLbt6lRlEGuuG1
         2vSnSAXlQL6dOGaPDfHUP+k02fEp5tn3Bx68s7bouHQoL1hTPwMfk34cCzmCTOgYJ38G
         1VYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764156470; x=1764761270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kcuczaZ5GkPO8H+hZQFd0TtQO9CvE0wBUafzpDXN61g=;
        b=IsiJ2ChwGhFh4rW08dhCZPAY0slHwM531y23N3BYNSP929PVLw9NNdnt1PyiiiBSM+
         s5AqGyKk5YIKy63dqPIpFBxmisZhOLbWaSlPCl4SitTE4hgkDs3PmRvSDKL1JVuwlYsN
         Qh+uLynm2rjlADJ5o0qlO7cGlIwuySzKS+4nrgMstqRMjx1J99YIam2Y47BjzqYLUNEh
         Vsj0poGnCq5Mf2koc7kngrO4RtsrdfPvgfbQ0FbGOjikVZEyG3GCNHoNlY2O2Mwatq+/
         HxKVnLRTicNlSW80eLhLVm5/5K9b4mGL/q+W0tCk65SKc9eij1skwPFLfVxLhptpfVoX
         mOFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF3xDXlFFuuqK/HDwO/AxJGOZ0X4Azdd9IdjeOkm8Rgpu2cjvwybibj5itXJ9RWwvpA3lyibE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9HHMHfbgOVaTmi8FJOuyQFLR4KeYcOxvQwsxRL87tKy4BM52i
	kbFVb/MUgt6qGvV9bW2JYiXP9Fvm5Z2lZHS0QoNGjz+3Uqux0Oa1LR8q0dBX036q1MQ2nthEjUj
	4TxWTRjTcJmd/pzYQTcitzm2Bp8nJje4kZv+gWcB7
X-Gm-Gg: ASbGncuGSJ4W9jkXm3J1AAiiUiCi4ce8K45wxSSD2+fNGDXXvNGYXCQwI54jH+In5uU
	5As05kfgrdK0TjV+Zj3lWJO/CRqScG8CRbkqHqAVkcPZugDO4IXzpvFj1iAcWWsEx4d/h9LwOQ5
	a1yfnQlbFJ05cpQ2/8PvYPaVscg+NDyrhl4RsiS8M+0rjTatr8tja15e15tSDCRN87D780h2FK0
	wugOOF6u3ivGNrmqAinJqTLYLCCLTl4W6aHH7nF47EGPruSKnb7BSZGbxrExVCHTiurwg==
X-Google-Smtp-Source: AGHT+IF6g9CIPeNJdXr/T+0KiUaGENhriN5NUh5mwWlmGGYyN2qbGP6eW7wPTr0X0lELIXZDT24DU1JM2Bc0aKIJMJM=
X-Received: by 2002:a05:622a:198b:b0:4ee:435b:787c with SMTP id
 d75a77b69052e-4ee58a96f7amr235856171cf.36.1764156469718; Wed, 26 Nov 2025
 03:27:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124175013.1473655-1-edumazet@google.com> <d5760f10-829d-4e0f-b755-1c651c1e1c42@kernel.org>
In-Reply-To: <d5760f10-829d-4e0f-b755-1c651c1e1c42@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Nov 2025 03:27:38 -0800
X-Gm-Features: AWmQ_bmhJVpHAGv9S6ESBKMtgsfGFRAh0QiA-WPcBNHOruYU8trmt1AeP_GqwJc
Message-ID: <CANn89iKCz4xbbn8taZrC2VhsSWBALLDycfyH0UcJSv-pQ=CWog@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] tcp: provide better locality for retransmit timer
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 3:23=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Eric,
>
> On 24/11/2025 18:50, Eric Dumazet wrote:
> > TCP stack uses three timers per flow, currently spread this way:
> >
> > - sk->sk_timer : keepalive timer
> > - icsk->icsk_retransmit_timer : retransmit timer
> > - icsk->icsk_delack_timer : delayed ack timer
> >
> > This series moves the retransmit timer to sk->sk_timer location,
> > to increase data locality in TX paths.
> >
> > keepalive timers are not often used, this change should be neutral for =
them.
> >
> > After the series we have following fields:
> >
> > - sk->tcp_retransmit_timer : retransmit timer, in sock_write_tx group
> > - icsk->icsk_delack_timer : delayed ack timer
> > - icsk->icsk_keepalive_timer : keepalive timer
> >
> > Moving icsk_delack_timer in a beter location would also be welcomed.
>
> Sorry for the delay, I didn't manage to look at it yesterday. I just
> wanted to say thank you for this series, and for having adapted MPTCP as
> well!
>
> Just in case, even if the series has already been applied:
>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Thanks for checking the series !

