Return-Path: <netdev+bounces-78397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA358874E64
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 12:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F074C1C230F0
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 11:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E7C128832;
	Thu,  7 Mar 2024 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXIzZiKQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0CC85634
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709812633; cv=none; b=FLWbqhnNjkBsx3Nw64ewbd/8vHhVnvGzCckeVpvobeWGCEI2MlQ7+Zk6hOz16OKI6Ot+pwX6vE5geI/TPcv8Ri1UsnSzFNiOeWiAQN+UpM9y1Z9hdqku5XgBqdAMzjz3kVt6f9iTe0Iihdl+6f/X+J4hosfUMPUJ3Vjxf0+RSEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709812633; c=relaxed/simple;
	bh=+JukNaHb38hsYxEeTSHJ2cVE1PiMaWiyYHjA11cHyrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkFy9dYZ5SEeq9h/a+UUaqVlUP9rKtn0TXR7mdVTgPwoRO+VE1tR/d/DHnddGGgkQ4ezGh1EvmDh7a51iqYm15TDKraVa18nTngCa7YRhumWsdFnxPl9bEnKgDycKtNGdSo1PiRpboSbQVGwAgRDQwInfN0/Y/aX5EvRO8E4OBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXIzZiKQ; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-21f0c82e97fso367631fac.2
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 03:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709812630; x=1710417430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EkqsNcuRS9Su2W8NiaWJi2c82JNx7I1Jx8XU7hXvux0=;
        b=ZXIzZiKQ9wUW2+mLsODJxotFc+xLNfICVO5KRFyYMhYIiCsbsQ23Acux8T+5b1N1ex
         3rHIddJpLgbR7G4Y+04+vJfoa2GusxYfGvMmscf4lvrnRsuTCMg6RLx1kdKhulCUh9ep
         oQlkDOangCvxf0lM+SK9L+cL8vHhddX/rrNRFZR1MIWy+/QXC8xp5+k7msjiUTe8L9mM
         7gZz+k6VxEPz6MMInaf8JlTn0NiyPdIDnbAK9nNsoffAFnWaETrDzjZmplC0sosltAax
         m7wnKumkmDM4k0wj4Ly98x03mPTx5EsHtTLDi4fc7Ks8zjZG9XgUZHoWfNhQHWSMxh30
         qktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709812630; x=1710417430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EkqsNcuRS9Su2W8NiaWJi2c82JNx7I1Jx8XU7hXvux0=;
        b=fumOemmO2H70cz75h4+pFDDHsskkg3cRH5fzdL2MF61sZxM2kA/tn90o0ylTZ1As+c
         7iW4IX4pUhCZS7gCNA3XSm1kZtDawpn5VZRB8tSXl8Uzg6UZemOHRySUEpha3S+FoP9R
         RkHyNTBBpEw2fqk7JBi7cCW3o4XqydC5V1zreuQWmIAGe9G1J3TbvWkfFk5LqAQCtvlX
         9mbw67Ob57F4Xws+TVfYNSP1d+7XCn1nrCh31UhlWyeMJvuVpvHkH5maGBN3nVMnWSVy
         5T48WqzoqjpoZY31QcHrpJk/r6OXjcK6PUflfB8tO2VnUAc2o386KVS9gVgShF76Qhv9
         Pwag==
X-Forwarded-Encrypted: i=1; AJvYcCVIeH9SrW09EAzu9fa2C2tugrSWLoCPjooLWQ//ECdkp7RNHv1VcdHIlRVGdFoZTqFb2Dt+HTkpoqUDckB/0pmqN1drfN9n
X-Gm-Message-State: AOJu0YwtS/8OssAdK0SZHLdV9BhwdvTDp/OMn9xM7IfZOVFQQp4mruAR
	mAVNBJDg1HiNpZo2H9rNcFhxavKpagfr3ZBEhePGMsf6i/+20+ZRvEmyXYpzA3EPDPHXLap727t
	N+P4ig0P25PNrutJREkhC0OiMJwpAXcw5XAE=
X-Google-Smtp-Source: AGHT+IEJ9u7aVSM+QHGDU55jjJBt7pzelFRuvd1BU8rGainwVdkbQbal2JajS0PmSaGJnr+U3GdwKzzMYfzHUbuUaeU=
X-Received: by 2002:a05:6871:e01a:b0:221:381b:1cf8 with SMTP id
 by26-20020a056871e01a00b00221381b1cf8mr8086602oac.3.1709812630472; Thu, 07
 Mar 2024 03:57:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306231046.97158-1-donald.hunter@gmail.com>
 <20240306231046.97158-3-donald.hunter@gmail.com> <ZemJZPySuUyGlMTu@gmail.com>
In-Reply-To: <ZemJZPySuUyGlMTu@gmail.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Thu, 7 Mar 2024 11:56:59 +0000
Message-ID: <CAD4GDZyvvSPV_-nZsB1rUb1wK6i-Z_DuK=PPLP4BTnfC1CLz3Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/6] tools/net/ynl: Report netlink errors
 without stacktrace
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Jiri Pirko <jiri@resnulli.us>, Stanislav Fomichev <sdf@google.com>, donald.hunter@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 09:31, Breno Leitao <leitao@debian.org> wrote:
>
> Hello Donald,
>
> On Wed, Mar 06, 2024 at 11:10:42PM +0000, Donald Hunter wrote:
> > ynl does not handle NlError exceptions so they get reported like program
> > failures. Handle the NlError exceptions and report the netlink errors
> > more cleanly.
> >
> > Example now:
> >
> > Netlink error: No such file or directory
> > nl_len = 44 (28) nl_flags = 0x300 nl_type = 2
> >       error: -2       extack: {'bad-attr': '.op'}
> >
> > Example before:
> >
> > Traceback (most recent call last):
> >   File "/home/donaldh/net-next/./tools/net/ynl/cli.py", line 81, in <module>
> >     main()
> >   File "/home/donaldh/net-next/./tools/net/ynl/cli.py", line 69, in main
> >     reply = ynl.dump(args.dump, attrs)
> >             ^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   File "/home/donaldh/net-next/tools/net/ynl/lib/ynl.py", line 906, in dump
> >     return self._op(method, vals, [], dump=True)
> >            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   File "/home/donaldh/net-next/tools/net/ynl/lib/ynl.py", line 872, in _op
> >     raise NlError(nl_msg)
> > lib.ynl.NlError: Netlink error: No such file or directory
> > nl_len = 44 (28) nl_flags = 0x300 nl_type = 2
> >       error: -2       extack: {'bad-attr': '.op'}
>
> Basically this is just hidding the stack, which may make it harder for
> someone not used to the code to find the problem.
>
> Usually fatal exception is handled to make the error more meaningful,
> i.e, better than just the exception message + stack. Hidding the stack
> and exitting may make the error less meaningful.

NlError is used to report a usage error reported by netlink as opposed
to a fatal exception. My thinking here is that it is better UX to
report netlink error responses without the stack trace precisely
because they are not exceptional. An NlError is not ynl program
breakage or subsystem breakage, it's e.g. nlctrl telling you that you
requested an op that does not exist.

> On a different topic, I am wondering if we want to add type hitting for
> these python program. They make the review process easier, and the
> development a bit more structured. (Maybe that is what we expect from
> upcoming new python code in netdev?!)

It's a good suggestion. I have never used python type hints so I'll
need to learn about them. I defer to the netdev maintainers about
whether this is something they want.

> If that is where we want to go, this is *not*, by any mean, a blocker to
> this code. Maybe something we can add to our public ToDo list (CC:
> Jakub).

