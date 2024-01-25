Return-Path: <netdev+bounces-65793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD13683BC46
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 09:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970BD28A30B
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 08:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37881B954;
	Thu, 25 Jan 2024 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NleBauai"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E26D1B94F
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706172538; cv=none; b=rmnpzN1uK4PAzRYrBH3hntThxvxh/Xq445wBF/QJ6gB1m2p4ZdGi4nv5syCRJ9NA0xZFzUOIicuonnLvBu6RDAeC195LHIb2FRtWBzDjU1BpbgE62sQdNy0ZQQFXHKSMotBDA29qM8+VNL+XMUAQdXyBGObdogqDK8UzvQKb2A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706172538; c=relaxed/simple;
	bh=ugVRvbXMqaaI04cZgFh3Eflw+q3XhgQV8p/8i4Mur6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAV3hrqAwCG7uYS1l5raDalgYF1+Oil2lY3ja2sFvbKVo7hYrrxcasQFuteiYKumUqa2QbeLhyL5Jebix7KFAPH+lut8As3e6ovpugN97/sZThk7CAX8BTKn6I6M1z074dZ5flWlHdy4lMi7DlSPSQyV1di7q6761Hnxy+yvSD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NleBauai; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso11596a12.0
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 00:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706172535; x=1706777335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prP92GbmaxKiGBLaZVvyY/3do2YP+LsQqUWaXmO/hL8=;
        b=NleBauaiYTamzNzcUgclMnqdr/dPtbzwr76WZXTikuIpV46orP0jMA/vHxEUjcuPLW
         ltm+jGvt9yJePRQzwdgJBJOwzNdXam0mXMxaz3aDCnuopGM0aLBpUx1O6RiIn2sNSdGF
         DvMexNEuzVU2Y5VfL2XPWVBM/OV38KaUVsorTJ0T0yNkTseJrNz/xB2PEzehPu5S+SNY
         VMBfHjZMIHsHRZaosl4qfBYLDZmxf5/kyEXwaryMCB1ercjto8jdRqA4Axhvp+PL8N1I
         0KM/5f8q4L0obj3uspTqVPMm9g4bzeJcxHYaxT3dDXDNobeUupk4Z2geULAgLI2btmIp
         kbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706172535; x=1706777335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prP92GbmaxKiGBLaZVvyY/3do2YP+LsQqUWaXmO/hL8=;
        b=XkPqUTl6bsl8xnmXMkRuNDJkW2Ro4w4mWzP+Tu9fw2lZXCFJA7PI9gPD4rVrdl6/yH
         LpH2hSOPUpfOJEdRk1o8+oCCiorSVc+SzPo3e5DcP3ADn53T91LvBd2JQdFIgr68zgBt
         oeiSRDImfu1jTWdR4QaemgvM9wrqgxjqOwAKghDPgg1h6qNdiX62xpz3V452koEEeWCz
         747XaDAHCdtYwNzBwdlk2KXqibaOTY0uSWchwKQCkXO8mZ5/rqYNE64kZGkk5luvnLaB
         TBney6BOO0JDerzPihxhDcu+HXgxIfSbxm1jG3RGxh2UVPWDE60bdLr3c9pJ6LH/r2cW
         xDcw==
X-Gm-Message-State: AOJu0YxZ1LpIwcL9tgcHZYeyjiGq2b8z+D/zcrXl9POgHU2QUXuTxX6Q
	nTrKrgqp3WufIiCvN2qwhqMgwHNBaKFbeBCQ5iETV/RvavrLOvWt8S9QaBHpruYTe0ADmIURw7S
	8WGogwVty/x3BtFaJmpKSCYYwCQIAW8VMlQ92
X-Google-Smtp-Source: AGHT+IEJS5MJHBuMVjXoGYBdRZxSQCog1ImgX5JUClFp0G1spvHjBWOHdlsQl6HXFAWavxeJgx9lK+EdYZQJ78edRuk=
X-Received: by 2002:a05:6402:1d88:b0:55d:152:7d59 with SMTP id
 dk8-20020a0564021d8800b0055d01527d59mr58730edb.4.1706172535337; Thu, 25 Jan
 2024 00:48:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7c3643763b331e9a400e1874fe089193c99a1c3f.1706170897.git.pabeni@redhat.com>
In-Reply-To: <7c3643763b331e9a400e1874fe089193c99a1c3f.1706170897.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Jan 2024 09:48:41 +0100
Message-ID: <CANn89iKqShowy=xMi2KwthYB6gz9X5n9kcqwh_5-JBJ3-jnK+g@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: add missing required classifier
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, Maciej enczykowski <maze@google.com>, 
	Lina Wang <lina.wang@mediatek.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 9:23=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> the udpgro_fraglist self-test uses the BPF classifiers, but the
> current net self-test configuration does not include it, causing
> CI failures:
>
>  # selftests: net: udpgro_frglist.sh
>  # ipv6
>  # tcp - over veth touching data
>  # -l 4 -6 -D 2001:db8::1 -t rx -4 -t
>  # Error: TC classifier not found.
>  # We have an error talking to the kernel
>  # Error: TC classifier not found.
>  # We have an error talking to the kernel
>
> Add the missing knob.
>
> Fixes: edae34a3ed92 ("selftests net: add UDP GRO fraglist + bpf self-test=
s")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

FYI, while looking at the gro test, I found that using strace was
making it failing as well.

Not sure about this one...

Reviewed-by: Eric Dumazet <edumazet@google.com>

