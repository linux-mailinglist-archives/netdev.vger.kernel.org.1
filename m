Return-Path: <netdev+bounces-114958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D556944CE4
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54CA91F229BE
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592331A7210;
	Thu,  1 Aug 2024 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vqLiinCY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04481A08D1
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517888; cv=none; b=lWOHHKP3XpLKyIAeWKOLumMrMXaRtW2JqQ8DdTkTmEF4DE1/AdLvNcx+LdpW0m5etq1qPyxJBmWCpP17a7lAurl5S6gWnn5dfL0j2ubeFMyZ4UKZcktUT/m1fyj0hRUGU8Rf2N7xcErJ7vWNCY5U+GLJWdyovC4OAmi7iXI3rjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517888; c=relaxed/simple;
	bh=2b116E7FQ+pAYtecWSCYXvLNIyOFl3/kX7mBS1bwNII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/7IV5seVYKELDYItbVpNFgh2gBH+0ED571LSKvAiokch0LU9qGpCc3CVPI/W6F1dzgzOnc61/nerfRMBqIH5D3kUYc/CAPK2+dtteIn7M6/SP1OfvOd7siJWEuv4uwC5r6rf3vy9b0LSL96exUqsmS4PL9CmxZS2766ejnrMUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vqLiinCY; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so33187a12.1
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 06:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722517885; x=1723122685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2b116E7FQ+pAYtecWSCYXvLNIyOFl3/kX7mBS1bwNII=;
        b=vqLiinCYmYef02cBcAP6W1PYTAb/pziOpZKmvsHyM29athqMTPncZ6L6y2BXKWjIs0
         dcF51p4ZcZO3WCODIxVAk7BKVQJmURDdj36qV+KG/74n4mtu3JBq17U9FejQ7MT8yuyJ
         gBJT4fiuEPfb/uGsWUXRkml2grV+q5pEBBioe8fEEWLfeyjZk2CJkfnEoRWoBzm2NSFt
         4IN+OGzD9K7NBzLeAmJII3oj2qPAbgBlMq3kbZk0RqxO4tlUWbN9nkE2by7nqLmYJpwT
         yNFPRRGdH4WVb+LYF/+wk1s9zp2MdP4wRyH/ypGdxfxdaZJQzA4ZY4Hl5NYprZYFYofP
         lZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722517885; x=1723122685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2b116E7FQ+pAYtecWSCYXvLNIyOFl3/kX7mBS1bwNII=;
        b=Sa7MYI5hDhYbIJ9wLCzxHyheo0humwV5/Cu6fnQ/oyScGjTP9qy4DNHDpn+XUXeSqT
         2Q0D6nT48uo53VM2ECZwdZSAkI3Dkq2aOn/hhH1Pny/PDL/deN5YDW9KWu13hg9yAaMQ
         XVlZVj2fA+4IEOIsF+bKay1jj90CeYfdIg4512UiayZHPo3TMqUBSztSujLp0wDjgn44
         0GIV4cvRsD01A5jI9NZLiG8kMKQcQpFQFWcZdCfBqvUV4U47SlgHwsCzptkZUF5BpiOy
         py1iGuQojlxopeF9eOLuRi2+E8iwvX7+FouNa+IC6snMddH15QWYTFr7l0kqpraRTTNG
         ApVg==
X-Forwarded-Encrypted: i=1; AJvYcCW1UZEG5rLX6otcfPk+8pfIgLn8DZzTEQES1xptjkLjY4t/xOj/o3mP8j+bBtGO4iLGPv0Yjalo93fkaKiPjQZuQLfCTI60
X-Gm-Message-State: AOJu0Yw/0r0Jv2DeoRjihaxMAWOrYBPn0ilb135ftmdPCLgexBsh0K8N
	NrDwhegstPgv7/p0kRW/DnUhUZDcG6vKkWGnEqP87kNEWoFsyxEa8wS4pyUFLOZXcOR0yIDBRxE
	1j6jH8H8ayXPQXNRLQeRANhHk4SlYhQmwCDFWRvii1PztkpJBdP4G
X-Google-Smtp-Source: AGHT+IFevpRTlLOOrxC7yYbYRP1h87dcMwd4qr7VYtyfCAC11NtmKHVzp6yAK3m/U10SuH9s2y0P0OAqji9bRa412L8=
X-Received: by 2002:a05:6402:35c7:b0:58b:90c6:c59e with SMTP id
 4fb4d7f45d1cf-5b740c8fc80mr81171a12.7.1722517884631; Thu, 01 Aug 2024
 06:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801111611.84743-1-kuro@kuroa.me>
In-Reply-To: <20240801111611.84743-1-kuro@kuroa.me>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 1 Aug 2024 15:11:10 +0200
Message-ID: <CANn89iKp=Mxu+kyB3cSB2sKevMJa6A3octSCJZM=oz4q+DC=bA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix forever orphan socket caused by tcp_abort
To: Xueming Feng <kuro@kuroa.me>, Lorenzo Colitti <lorenzo@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 1:17=E2=80=AFPM Xueming Feng <kuro@kuroa.me> wrote:
>
> We have some problem closing zero-window fin-wait-1 tcp sockets in our
> environment. This patch come from the investigation.
>
> Previously tcp_abort only sends out reset and calls tcp_done when the
> socket is not SOCK_DEAD aka. orphan. For orphan socket, it will only
> purging the write queue, but not close the socket and left it to the
> timer.
>
> While purging the write queue, tp->packets_out and sk->sk_write_queue
> is cleared along the way. However tcp_retransmit_timer have early
> return based on !tp->packets_out and tcp_probe_timer have early
> return based on !sk->sk_write_queue.
>
> This caused ICSK_TIME_RETRANS and ICSK_TIME_PROBE0 not being resched
> and socket not being killed by the timers. Converting a zero-windowed
> orphan to a forever orphan.
>
> This patch removes the SOCK_DEAD check in tcp_abort, making it send
> reset to peer and close the socket accordingly. Preventing the
> timer-less orphan from happening.
>
> Fixes: e05836ac07c7 ("tcp: purge write queue upon aborting the connection=
")
> Fixes: bffd168c3fc5 ("tcp: clear tp->packets_out when purging write queue=
")
> Signed-off-by: Xueming Feng <kuro@kuroa.me>

This seems legit, but are you sure these two blamed commits added this bug =
?

Even before them, we should have called tcp_done() right away, instead
of waiting for a (possibly long) timer to complete the job.

This might be important when killing millions of sockets on a busy server.

CC Lorenzo

Lorenzo, do you recall why your patch was testing the SOCK_DEAD flag ?

Thanks.

