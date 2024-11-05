Return-Path: <netdev+bounces-141952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516259BCC6A
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F2E1C227CB
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8031D54E1;
	Tue,  5 Nov 2024 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IzURaaWj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6D51D516F
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 12:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730808704; cv=none; b=JyxkB0m+xlm0okbJSHOZfgK8IpOEzVn5IeBzd09vLkg4fJOqXbswkRF/2oZaViP83w7YrUQVE6UyjRaqShZaQyM4NDjmtpxJ6v9Q44//O9Z071FAlllanTsr/IEwtxGwNQq8IaU7l794EZeG7SYVGDQc1zL8FPos7qTFPV13KnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730808704; c=relaxed/simple;
	bh=ABKvtoIrylTyJbj2YQxk7+vKPejF7GcDhjN+pvPyYgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqMDCIkh0njrJx1zDtczsd+mAQK8+vXBFWUy3ztL32eXFdRh1tNUMgiQ1I+GOAZRYUe3FD0kPv3rY8xJOOdRbavBW2vPoKkTaFpU3HTkDTNfWu8DCyyCVJSQUoOyvJ+JN8Q8wB+lqRaOo36kYqHOq4/I4OplF9LBzmSJa/4dMUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IzURaaWj; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539ee1acb86so5367862e87.0
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 04:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730808701; x=1731413501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABKvtoIrylTyJbj2YQxk7+vKPejF7GcDhjN+pvPyYgo=;
        b=IzURaaWjzh/QkXNrle2dBwjXfPaoZnIV5QTX4YRfRS5Gyx26NOLTM/O9eWuI9/yXo/
         rvB9/zLjkyUKUzi+luy+ylUdCISL4WIBUnroRE1xJ0DpzSu+Vs5HNW5FacRpbmxbTk6q
         NzXRMok/Kr9ASy2xK3pu+lCj++6NjTax1zwKUBmqDWIJlE0I0Gs44ZKpSKTyZ7n/ZhpV
         1P8oGEwuqvT2iUZW3J5+rQVf4Psqdg4nYBoIj5GOQEk4jrVBNYclAN5fCfdXaKhMa2MJ
         4X4HxtQeNr/f1RpptbhsOApYsnEGvmKW4WTCNYdtcVclNr0s62FhVFOGmluJ2RmI6ON6
         k/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730808701; x=1731413501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABKvtoIrylTyJbj2YQxk7+vKPejF7GcDhjN+pvPyYgo=;
        b=JYYt0ZNWZnwzyNCzhnct9N9DdSxyPK1TsY+JHhMj5mLejlagzPo8yowKN8whFpOgXO
         y2BEgvXjNoegWZfWUZqvtiahJIwHvTauVcv6oG2xwulWFiwiPj5hjdCZ/tWSyOtjmQhV
         qyn4o04N7CEb3gwfqO3iCh0wQbjr7DlgcJ0dzeOWU2sQ9qU90ph6EZFIH9q0lxtoWaG4
         GFZQcAGB8Fii3CTl1C8ewauolRS8x9mTts5/rdnaOJeqwVGqEpxjQQCZwhI8M2Qoh1Co
         24LbxSQnA06usvN79ArloNfYRjUF/EQeOked98nI1ceeHPKwZpkw0up78uTKmHO3YwYP
         Z7cA==
X-Forwarded-Encrypted: i=1; AJvYcCWGK2+xcODXq5IvdS+WVfZR6Jl+gwHQ3wEg9chvt2J2vb07ViU3P/2qedZoJNnnqrYUzI6AI/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmgjnNLP1x5BEhMBzqK6nu+Fgfs8lAc6riX/3Cp6asg7XuA2un
	Mcvryn1lAhww31glfQUDXhfsPeJgB60uf8X0N/7gYXiAqCWmNkaYepdNkFJxg5+vDGEYPfJmj5k
	h0slkiffQfx62bFDhWCiCKC3d/naJMfa4dHbItnmzTqDOqJqyaw==
X-Google-Smtp-Source: AGHT+IEk7SJLNCqbiTZEIjw+CbrT094UAOk1ZikO5jhJoaKVLKivxtZeAzC9UoZnzU4vNlSplne3hvsdfINV9E7Y6cQ=
X-Received: by 2002:a05:6512:1590:b0:539:f74b:62a5 with SMTP id
 2adb3069b0e04-53d65df76aemr7078077e87.25.1730808700335; Tue, 05 Nov 2024
 04:11:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104152622.3580037-1-edumazet@google.com> <D2067CE4-F300-4DED-8012-9718FD6AB67F@remlab.net>
In-Reply-To: <D2067CE4-F300-4DED-8012-9718FD6AB67F@remlab.net>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Nov 2024 13:11:29 +0100
Message-ID: <CANn89iK0mAk__j32b6yOUJsDtM0EDgymgoKi0P8o+ZEf_YVbbg@mail.gmail.com>
Subject: Re: [PATCH net-next] phonet: do not call synchronize_rcu() from phonet_route_del()
To: =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi@remlab.net>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Remi Denis-Courmont <courmisch@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 12:05=E2=80=AFPM R=C3=A9mi Denis-Courmont <remi@reml=
ab.net> wrote:
>

> Synchronising after sending notifications sounds a bit iffy. Whatever a g=
iven notification is about should be fully committed so we don't create a u=
ser-visible race here.

This is fine, the notification sends the ifindex, after the route is
effectively removed.

Fact that the device is held a bit longer than before should be an
improvement, or just a nop.

However, doing the dev_put() after synchronize_rcu() is probably better.

