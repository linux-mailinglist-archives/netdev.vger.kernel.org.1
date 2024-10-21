Return-Path: <netdev+bounces-137582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F309A70C9
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534B7282E70
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF951EB9F3;
	Mon, 21 Oct 2024 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIiPTImD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE07B1EABD5;
	Mon, 21 Oct 2024 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530972; cv=none; b=Kn5Bd8e9vvlhngMm0BkL1Ixt/8JIlGElUabtskb37L6G+NXjJoYVvb0fs4t4uJNO2ZPBg3w6oWnGC5usBwAHqPu6tCadUClCZNcFlpAO45XD+GYWjYPOWJEuWInx5yXu3fcBoYTIqH9IUyQl+rtASpTATaHf+/LV1GRxDHpalv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530972; c=relaxed/simple;
	bh=P7M6hK2QGGokXWddLX6ahenELm3JSyYN9TJnSQFDCtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Peludkex7JW9pjoOfp8fIcgYULEZd5HukqDS3gcR1Lx6xGQYTEZUlWh7zDksJmnYH5MdawQCjFJZ3MROOJzXz9pT0x+2UY97b4wKomyLXvVXawZqbfNxmaZsYqroPBk8B/VWSOpyk944awFh/A9YOvcgIh0Ijv7cdIyeyc7cOig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIiPTImD; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so46465191fa.2;
        Mon, 21 Oct 2024 10:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729530969; x=1730135769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjIFzIpBZflzITDVXrEWci55i0lCxZNwkLn1/JkamZk=;
        b=dIiPTImDjmeFigHbSkJqBuezsgJWgh8reOBkunDjwPRequdnZi4j6iDVaKzvxI7X3Y
         +1eGqri46F4jxSUSFZf3u+fCdpf/rxhGG96lYEpvTKqb1eVaHpOJnnZEU8+fbSDXxpz3
         bCQkGzDUxfz5y0FVCmagPqG0DIf3MjM0cLRDc2Qdd0cx6QW8iA2Kaiynv+2c0ZUYj0HW
         t9eVIo8oS8Bfm08UI0ARK4KFdjDjMNjq8yndkbyzkQVT3kRvn5ViICBfFMoZWQmdGtl8
         CCQNWFewR67vxLRnQGNUpa2787uXeX6hKZC9OQGfifThgP5MTLPH+rXwM4o4NFQO/WkH
         Uc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729530969; x=1730135769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjIFzIpBZflzITDVXrEWci55i0lCxZNwkLn1/JkamZk=;
        b=e+vhxQt3hhp5qlP0pcApVPSyJ32NVZ+KohLOwBSkpsCNi/oH5jTL60E0wK2EfYfgif
         ltH5eKm/MzPteYiqmflRhfRASSUKpCC/gqDfmBu5lgl0JwXNScAaCYJQ+y1i1wRt8Svn
         JFuIxURBl+FmyMSvy2pmDJvRQgaen4m4EiAURTqnL8v+QMoiAFOmIjZuI2I8eKd+9IWo
         wLVBoJbar4gbG0wN0+cvJQPRiyQ7gyXjVW8W21DSKmpqGjvJEZoUNgjL54eDXHyt2mjs
         edEUZek3nCGijZoPwYCrrL+K+/NyEd1ctJTzCSjRZaVJkDfKXiIKK8Mk6VBG78bkQRn5
         R7xA==
X-Forwarded-Encrypted: i=1; AJvYcCWXBlyvbEVRlj9kXt2r8pYQXNiytRnmGrc5Nq4DiCFzJ+hEag1nPTs2EVOzTv/LJmERomz8fzsX@vger.kernel.org, AJvYcCXY/hqVjT3v6RL4VMDJLhuKWPmt0PFhyMYXaakyAs8p19j44973N8kS7j2PR/+JbRmFgUcCLvCl9Q3oHLqvNbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm9vZrIW24l2JZTcdQZHjDAOUMBJpWtfQwoevIE85XsFvrqX6m
	4qlkvM7N2DOok7GNNDI0pkJAGryJeMbdRbXXpKKuQGxA9O+mymVRrpagHOvk2xtSDYr/eGW17am
	xT0o1Xkn1/EvjCgxUs+Ci31b2GsE=
X-Google-Smtp-Source: AGHT+IEkZ7gfcQYBcHFr2b0K8I9CQ3NUCnWQqHfvZazLDfBUdpefcdsx2PbVYbOCZnJ24Y5S7krAD7KMHWs7fkb/D9o=
X-Received: by 2002:a2e:a58a:0:b0:2fb:4ca9:8f4 with SMTP id
 38308e7fff4ca-2fb82eaee9bmr53020881fa.23.1729530968390; Mon, 21 Oct 2024
 10:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016204258.821965-1-luiz.dentz@gmail.com> <4e1977ca-6166-4891-965e-34a6f319035f@leemhuis.info>
 <be9ead27-bd67-49a8-a311-a7ce5e82d4fa@redhat.com>
In-Reply-To: <be9ead27-bd67-49a8-a311-a7ce5e82d4fa@redhat.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 21 Oct 2024 13:15:55 -0400
Message-ID: <CABBYNZKWSqpn9whkYGVm49B472JsGpumF09fK8Nw7dWvmhrKVw@mail.gmail.com>
Subject: Re: pull request: bluetooth 2024-10-16
To: Paolo Abeni <pabeni@redhat.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, davem@davemloft.net, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Mon, Oct 21, 2024 at 11:29=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 10/18/24 07:30, Thorsten Leemhuis wrote:
> > [CCing Linus, the two other -net maintainers, and the regressions lists=
]
> >
> > On 16.10.24 22:42, Luiz Augusto von Dentz wrote:
> >> The following changes since commit 11d06f0aaef89f4cad68b92510bd9decff2=
d7b87:
> >>
> >>   net: dsa: vsc73xx: fix reception from VLAN-unaware bridges (2024-10-=
15 18:41:52 -0700)
> >>
> >> are available in the Git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.gi=
t tags/for-net-2024-10-16
> >
> > FWIW, from my point of view it would be nice if these changes could mak=
e
> > it to mainline this week. I know, they missed the weekly -net merge,
> > despite the quoted PR being sent on Wednesday (I assume it was too late
> > in the day).
>
> The net PR is prepared and sent on Thursday morning - either European
> Time or West Cost, depending on who actually is cooking it.
>
> Wednesday is usually/nearly always a good time for PR to be send on
> netdev to land into the next 'net' PR, but due to some unfortunate
> scheduling, we are lagging behind the netdev ML traffic - to the point
> that I'm processing this email only now.
>
> The limited capacity will last for all the current week, but we should
> come back to speed from the next one.

Thanks for the feedback, I will try to get the bluetooth tree PR done
on Wednesday (weekly) morning (East Coast) then.

>
> Cheers,
>
> Paolo
>


--=20
Luiz Augusto von Dentz

