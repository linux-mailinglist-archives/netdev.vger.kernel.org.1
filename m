Return-Path: <netdev+bounces-194104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC9BAC7587
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 03:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ACA44E7210
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 01:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA5D221D87;
	Thu, 29 May 2025 01:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xLH9qh6W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D5821D581
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 01:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748483606; cv=none; b=rKxJMjWoEOQtfBkmZJzr4gBQs5x0cXN9oT4xeiEoY2ztz0rw30BDagekvoLLBXvXYd8RuWXt5RVcFSlD0aBBS5+cLkXS6LiZsC43IIPo+MtT/MDviSCbfUjuGQ0RKIOF0U+KFHdvPiQsJ3uOj53afZSLq2hhrgtuTchRPSPWznk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748483606; c=relaxed/simple;
	bh=rJbOnLrons4tTuN78stT1ORqO5zSyyGsE+esZxR3PBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZByVT7BjMG6IuLfuDrNbEcb99IIhURIddseoS8a1c8a3hLb08btSLEV9t5bgtLZgInK42Z5XI9dzaEGUIMvqXv5CD3t9Q4InUAt7ScFF2ZIn7nPG+Ee/bLO/CNKf1oaghUB7jZY1LjsVwXs/uPzHlo6+8eNdiDK9g+pBD5/v2r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xLH9qh6W; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3dc9caf4cc7so45ab.1
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 18:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748483602; x=1749088402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rK28GjLplaS1k6sqbBmLq7Kl/oZsU4xMjKQXJ8HS3rA=;
        b=xLH9qh6Wzyel+Qcwg7oraOeFJvWcjbp2sDQo3q+QMvOdqB5Is/qIbwKEdx62m17kcB
         NDcN1BJVn4c6RojJriZALkozb3UabYmyqbER7XNquDEDzF484+6rhfTtJX694bibKxLw
         oEefb6zx8WJ/ViWFjMUgCf8tdjOtVITIs9nq+YeBiNGZAuIO76FMS1bNHFc8+din55kJ
         7C5iGk5mTPOyH/t6M4NlhQLt5u1ekxUDgoMDVye1wgcTp7T1USKQpG9vPGOQ0NP5tjmU
         9N1+PaYxLCNi3mN86gip2sIg0kQLF/Cq2QYqIOUzuAU3nD66n7EY21Q+eHYNpSyy3ifn
         bW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748483602; x=1749088402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rK28GjLplaS1k6sqbBmLq7Kl/oZsU4xMjKQXJ8HS3rA=;
        b=IXzhCJmjrrkS0N/hf1rjTFwbRfHswtnK4uquv1/k/1K7KDvzXW2c8bzO19KgwKQ7an
         qbTRUcZyt7eXEG+fUEKJRCtv+Jhbd4UPEW9xbZQN0ZOPB07OXxppv4F909e71LRgJFwR
         WUi9xKzZ8gHrJG5jursdyzXxTJBZlGs6uXrF9CPHKmXxjOCgUZe8ZvCycnu2nV9RvBZp
         1lPjlnHlpbgt9ZuYM7HGA4xk3Tch6fSZsW/59UXwH3sHiM/ecBYJk8n3THyoWqxmoixE
         lteAgVe7xsypl5v1KiMQ1Z/1DQcG7gA3ycsm5BCRJ6Gvsyu7BCxMOfmCU8hDLHYAQLcA
         Mmow==
X-Forwarded-Encrypted: i=1; AJvYcCXn4KiIe1oSCoFtpstVpaKv+4IU+ATtWstvaNObYXI1mlyOvyWMx1CQE0dPmFZYy0jfrISi0iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzenGRdWrQI7EuVHL20RABGEy2rBaUOGWmJpkMHkGkHk+jkzvqB
	gBc4W7iu/JTuNNs4I6o4h5Pf3UEDjQlRGqoYHTko50Y/rJeBSMMZh2JEOt9ehDqRq73cFUcMqpR
	RhfVrVCj1RbzNjz/E36yhUrYKdZwJrOHJJWjHfM7n
X-Gm-Gg: ASbGncs2gYInVGg9sLGGqrZym9kqmNtmxDVoez2IZVYZRwIQCwreH6Q/Wf4V3a9u3fm
	p39QQkJ+Om4XlmT58tY03oMEngMZQa4vV1paPSQe5LJXSQ67eZzcw4rZAktV5EvO7YgWvx0Raq2
	JUOF9PYEuRXlVkkuP8HQV415xJZodffJZo6Sb9V8zcI3NRh4VxIjzKrv6/emSFb9szeInbNv30i
	A==
X-Google-Smtp-Source: AGHT+IHvXpxdbsNsdSIj7f0krR3C592J4ox9Z6xPbGgTujvSL8gBecLol8wGmmUwIDp3VmUxXJZIQ9cqFHX68YMuAB0=
X-Received: by 2002:a05:6e02:17cb:b0:3d9:6c7a:2b37 with SMTP id
 e9e14a558f8ab-3dd943b659dmr165085ab.0.1748483600459; Wed, 28 May 2025
 18:53:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527091855.340837-1-yuyanghuang@google.com> <20250528154906.GD1484967@horms.kernel.org>
In-Reply-To: <20250528154906.GD1484967@horms.kernel.org>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Thu, 29 May 2025 10:52:43 +0900
X-Gm-Features: AX0GCFuYgCNb70ORjeZSMAVUwUmRpmuC-GcYb2mnhAWrV6WRxyL5vLj9hHEg0Fc
Message-ID: <CADXeF1E7zuqpixcB+9j90d7tZhR5bsSsrniYD-BtpK8+uzA_Pw@mail.gmail.com>
Subject: Re: [PATCH net-next] selftest: Add selftest for multicast address notifications
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon

>Other tests in this file seem to warn if the ip command is too old
>to support the test. Perhaps we can achieve that here something like this
>(completely untested!):

Thanks for the advice. I will modify the test to make sure it skips on
old iproute2 versions. I will send the patch after net-next reopens.

Thanks,

Yuyang


On Thu, May 29, 2025 at 12:49=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Tue, May 27, 2025 at 06:18:55PM +0900, Yuyang Huang wrote:
> > This commit adds a new kernel selftest to verify RTNLGRP_IPV4_MCADDR
> > and RTNLGRP_IPV6_MCADDR notifications. The test works by adding and
> > removing a dummy interface and then confirming that the system
> > correctly receives join and removal notifications for the 224.0.0.1
> > and ff02::1 multicast addresses.
> >
> > The test relies on the iproute2 version to be 6.13+.
> >
> > Tested by the following command:
> > $ vng -v --user root --cpus 16 -- \
> > make -C tools/testing/selftests TARGETS=3Dnet TEST_PROGS=3Drtnetlink.sh=
 \
> > TEST_GEN_PROGS=3D"" run_tests
> >
> > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > Cc: Lorenzo Colitti <lorenzo@google.com>
> > Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
>
> ...
>
> > +kci_test_mcast_addr_notification()
> > +{
> > +     local tmpfile
> > +     local monitor_pid
> > +     local match_result
> > +
> > +     tmpfile=3D$(mktemp)
> > +
> > +     ip monitor maddr > $tmpfile &
> > +     monitor_pid=3D$!
>
> Hi Yuyang Huang,
>
> Other tests in this file seem to warn if the ip command is too old
> to support the test. Perhaps we can achieve that here something like this
> (completely untested!):
>
>         if [ ! -e "/proc/$monitor_pid" ]; then
>                 end_test "SKIP: mcast addr notification: iproute2 too old=
"
>                 rm $tmpfile
>                 return $ksft_skip
>         fi
>
> > +     sleep 1
> > +
> > +     run_cmd ip link add name test-dummy1 type dummy
> > +     run_cmd ip link set test-dummy1 up
> > +     run_cmd ip link del dev test-dummy1
> > +     sleep 1
> > +
> > +     match_result=3D$(grep -cE "test-dummy1.*(224.0.0.1|ff02::1)" $tmp=
file)
> > +
> > +     kill $monitor_pid
> > +     rm $tmpfile
> > +     # There should be 4 line matches as follows.
> > +     # 13: test-dummy1    inet6 mcast ff02::1 scope global
> > +     # 13: test-dummy1    inet mcast 224.0.0.1 scope global
> > +     # Deleted 13: test-dummy1    inet mcast 224.0.0.1 scope global
> > +     # Deleted 13: test-dummy1    inet6 mcast ff02::1 scope global
> > +     if [ $match_result -ne 4 ];then
> > +             end_test "FAIL: mcast addr notification"
> > +             return 1
> > +     fi
> > +     end_test "PASS: mcast addr notification"
> > +}
> > +
>
> ...
>
> ## Form letter - net-next-closed
>
> The merge window for v6.16 has begun and therefore net-next is closed
> for new drivers, features, code refactoring and optimizations. We are
> currently accepting bug fixes only.
>
> Please repost when net-next reopens after June 8th.
>
> RFC patches sent for review only are obviously welcome at any time.
>
> pw-bot: deffer

