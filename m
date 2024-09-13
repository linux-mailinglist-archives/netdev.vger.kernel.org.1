Return-Path: <netdev+bounces-128120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D84597816C
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F561B21295
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D291DA63F;
	Fri, 13 Sep 2024 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="kFnxc6Ib"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784751D86D6
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235146; cv=none; b=QVRltP5C76VGNUXSYoJcZueLhfg916umJEBHcI2vA/AbEtdSKmbNZD2cEjqn2K38IyYfRRHQuYfDc29UCmrOPiJXmM4VH+i7S6XtEGzu3+NZPlt5TFFaadM1vA0qBHQmAkVKbimNr0fWwJmP/YKZ7W4fI3bgu/AfTaCrA021gwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235146; c=relaxed/simple;
	bh=aviylsYmGCSXBAL9QBooOZiPJR0L/Lmo3/rF0QbeHI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEu2WbYPVYxx/eZSNMqwN6pw2hMAOJYOEX4KCVKuTGM6iVLxXqR2gHmOgIywU5WSQZ0TFTB/ts/AOZOCZKDF06KYDyG8jAwP/vrYxc8d4lRvv6RGS/nhgAmjomiKsKuWbOB5nsLK21q9JuzWLkPEp3Byepf7Bw7qd33LAfMQYG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=kFnxc6Ib; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 24D193F371
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 13:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726235136;
	bh=aviylsYmGCSXBAL9QBooOZiPJR0L/Lmo3/rF0QbeHI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=kFnxc6Ib1gGYHHIP+KF/XD3UpmmDcs7a1FdMKXaqbtz7tbHe9L0yVTWTpAuYOIlDK
	 DmJe2+sxhOkdhiXNdtjR8vTSZAoiinWCNygvaeUKjY2IxiCjm/bAICwppR6VAzAUK4
	 HhTjZrsjGidZn89GmWBhtmT7waJx+1s99Lyul4HusXUNPLq0V0vbNhvZfiRARfUPnE
	 3cLNFJ0MEfpWwwpAr1MZgOu9Jc4QUOw+CqbO2adp/avMTgD5PWEUFvGIi93xvjv8Io
	 6a5Gic8icI3GzXPx9aVESM/Euvp+MAZZ6DVW5KI4lrv9xRhPQc7x6iOAbGvtZOoq+d
	 h1Jjfx07UakUA==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5c2465b7fc1so634218a12.0
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 06:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726235135; x=1726839935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aviylsYmGCSXBAL9QBooOZiPJR0L/Lmo3/rF0QbeHI0=;
        b=HSeQnyeAIyrYgM72Ado76t6odQhUwYTMsCGJbdUp7So6Zp/6S4EOcjiDtuPsJKkn3v
         +yShq0+2ynP0/TzEnBD45Sc5fz6VBs3ueTEGrH1A+BPmqn+U3WPztvpwPmgOrknBHeeF
         7esfM84hrJ1nZjmwn0Ojew6PIq5mKiW0kkNnLo50TQjEL5a1UR2ZqVsKZQkWrwpdcxg5
         CJzdcX3+1y768xCaXOwjpH1eQb1TxsfsGOZtRDlftxda7GexcMaF6UE2Z3fPWZZrh5bl
         PfiD+k1keIKsGZ5c25l0PuHXeIpN3RlaQcXD5rJSBPtiXQ3/iOsh+I/S6LHUQFTT9nib
         ipNg==
X-Forwarded-Encrypted: i=1; AJvYcCUQKBTV2SNVyWM+g+ryknaGGEsbv9jFVgLM8J5p0v5T2kma+tzisVEdt/aiCTJ8GpcRDvofLsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvJXwo3fkAJ9tJrkb9p+woJUW+qQBXwD7Pn7R+BhL8PDlwESpx
	Z5o8cUjDKKmsnLS3DbQXX13TpQcR/9/Jdlc353/jWDcUvzA8wPAWN5mS7+HEbZeKruFGVOB2Vt2
	KnWcWHDVj09t6V42sZNui9AgRtV55kdrrxfBW8W+52yO8uk0Hr/Tltbqd2ynF2rwzpUpSKOL9Kn
	H8Fi7jAHGl3bu2meJ73suCb5JOzvr6gZh/WFrcUGAEf77L
X-Received: by 2002:a05:6402:350a:b0:5c4:14dc:8c91 with SMTP id 4fb4d7f45d1cf-5c41e1b26cfmr2473046a12.23.1726235135361;
        Fri, 13 Sep 2024 06:45:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9fHYAoyON92L3VmfYpW+F+XX76BHrLOK6VyOn4RM5Xc+9oLVWc+LhLEbJWZ/qhKfonAT3Rqf8scc52xb7zDk=
X-Received: by 2002:a05:6402:350a:b0:5c4:14dc:8c91 with SMTP id
 4fb4d7f45d1cf-5c41e1b26cfmr2472994a12.23.1726235134235; Fri, 13 Sep 2024
 06:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHTA-uZDaJ-71o+bo8a96TV4ck-8niimztQFaa=QoeNdUm-9wg@mail.gmail.com>
 <20240912191306.0cf81ce3@kernel.org>
In-Reply-To: <20240912191306.0cf81ce3@kernel.org>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Fri, 13 Sep 2024 08:45:22 -0500
Message-ID: <CAHTA-uZvLg4aW7hMXMxkVwar7a3vL+yR=YOznW3Yresaq3Yd+A@mail.gmail.com>
Subject: Re: Namespaced network devices not cleaned up properly after
 execution of pmtu.sh kernel selftest
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jacob Martin <jacob.martin@canonical.com>, dann frazier <dann.frazier@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,
Executing ./pmtu.sh pmtu_ipv6_ipv6_exception manually will only
trigger the pmtu_ipv6_ipv6_exception sub-case, which only takes a
second to run on my machines, so you shouldn't need to run the
entirety of pmtu.sh to trigger the bug. It won't trigger on attempt
#1, but in my experience, when I do it in that while loop, it will
trigger in under a minute reliably.

> Somewhat tangentially but if you'd be willing I wouldn't mind if you
> were to send patches to break this test up upstream, too. It takes
> 1h23m to run with various debug kernel options enabled. If we split
> it into multiple smaller tests each running 10min or 20min we can
> then spawn multiple VMs and get the results faster.

This logical division of tests already exists in pmtu.sh if you pass a
sub-test name in as the first parameter like above, but if you think
there would be value in separating them out further or into different
files not all in pmtu.sh, I would be happy to help with that. Just let
me know.

Regardless, I will go ahead and work on a new regression test that
executes just our quick reproducer for this specific bug and will send
it to this list.

Thanks,
Mitchell Augustin

On Thu, Sep 12, 2024 at 9:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 11 Sep 2024 17:20:29 -0500 Mitchell Augustin wrote:
> > We recently identified a bug still impacting upstream, triggered
> > occasionally by one of the kernel selftests (net/pmtu.sh) that
> > sometimes causes the following behavior:
> > * One of this tests's namespaced network devices does not get properly
> > cleaned up when the namespace is destroyed, evidenced by
> > `unregister_netdevice: waiting for veth_A-R1 to become free. Usage
> > count =3D 5` appearing in the dmesg output repeatedly
> > * Once we start to see the above `unregister_netdevice` message, an
> > un-cancelable hang will occur on subsequent attempts to run `modprobe
> > ip6_vti` or `rmmod ip6_vti`
>
> Thanks for the report! We have seen it in our CI as well, it happens
> maybe once a day. But as you say on x86 is quite hard to reproduce,
> and nothing obvious stood out as a culprit.
>
> > However, I can easily reproduce the issue on an Nvidia Grace/Hopper
> > machine (and other platforms with modern CPUs) with the performance
> > governor set by doing the following:
> > * Install/boot any affected kernel
> > * Clone the kernel tree just to get an older version of the test cases
> > without subtle timing changes that mask the issue (such as
> > https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/nobl=
e/tree/?h=3DUbuntu-6.8.0-39.39)
> > * cd tools/testing/selftests/net
> > * while true; do sudo ./pmtu.sh pmtu_ipv6_ipv6_exception; done
>
> That's exciting! Would you be able to try to cut down the test itself
> (is quite long and has a ton of sub-cases). Figure out which sub-cases
> trigger this? And maybe with an even quicker repro we'll bisect or
> someone will correctly guess the fix?
>
> Somewhat tangentially but if you'd be willing I wouldn't mind if you
> were to send patches to break this test up upstream, too. It takes
> 1h23m to run with various debug kernel options enabled. If we split
> it into multiple smaller tests each running 10min or 20min we can
> then spawn multiple VMs and get the results faster.



--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

