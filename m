Return-Path: <netdev+bounces-128592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD27B97A7C9
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 21:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA672863C7
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 19:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EAA2A1B2;
	Mon, 16 Sep 2024 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="qI6k9pk0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08DE15C120
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726514766; cv=none; b=UHM99+Qcv85wmgLDJrnNmpXdmAFkrRsb5UpipwH/xT+yQ0UXJC1Wgry0ayxX1aCoKInbssLDl8tjnBlFAvvg7ciezKq4lyKKOH2o9e8QfJEyWEZZKA5K5zzaX56JMD874552oQl5I8JTuMVbtqe0Yzrvl6EOaAizj+XzOQGl2tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726514766; c=relaxed/simple;
	bh=6hVSPTDjjuHtlG4ysrsJ7KI3PBSfKbhOd99YqQZc20I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZgrUpy9zmdAhqD6145adnjaVgdOAEUWo1K/L9kj0PDpocS9gHrV/nJ3UN0lS9hpnxbbD37SP22CpvzgsEpdfqKWQrNtL9rpMPs5OPt2hyWp4r3/CDsi9qAsG/nnULQ4DfxR85VXRlzk38qqiI8OTHwdaUDQraxXnDpFZDgJtAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=qI6k9pk0; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4E4AB3F5F4
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 19:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726514762;
	bh=6hVSPTDjjuHtlG4ysrsJ7KI3PBSfKbhOd99YqQZc20I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=qI6k9pk0PWOS7fNU7sihonwuuA+lLq93IrWIC/dJ5HJoJk6T4QhOLnmITR56IeLOC
	 7HwBSAUbpJaq7TRjPyPlfPF+Vell1qyb1R/XE5bWhwXqwoTBHuR0QaTn8dhKuDdciA
	 dA+ylewzwZe1F8GSIwN1svFK3nV0KqRWp4Jrcl//2FbN0bcT4hul40+9Rd2GK74YDU
	 E5c+cmiSm1fkwCLysWfiYfrU42I95oZ0XpyXsBy1oBQtWMHHjB8BGQ/yQAY3nHCrcN
	 ZpC+cd3m5l4+4Y1xeiyOjObOfaCtRjariwruWSycGxCxRRfXnfNVcqdCDKJNhwfoP4
	 T4vQEFMDVD46g==
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5344b7df784so4066107e87.1
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 12:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726514761; x=1727119561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hVSPTDjjuHtlG4ysrsJ7KI3PBSfKbhOd99YqQZc20I=;
        b=dRN3LOA48Xi6ckwJAZFTjdNwTpcIiZQsFOzFv2ulOuhPU2W+7Bs4u90gW4NpuBuVHK
         q8YSA9TKwmOlE4AgwM7/qEW/IrvMaGNAxHK1u1u1e0sjoB5XxopYVUkt4I4UPca8EFvm
         HD6GCDLgPKdirbcpi7D+Snv6yDxKLLcUk+cUPovibQFH2ASxsAkZlXKBQZoZK9JywBCv
         3k5H4ITbww5x3TP1RIf3VH9rgChkukk7adn+JADV9geoDIS5Aa0elI+M9e9YAyYa6/3u
         U6uuF2uo9yJaDXjYW6pJz+7pJCnA+xvQAnADdwXJjE350q4h2A9aYC8hu8gYUvwokviZ
         sYTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUQ+M3E7VxkVv9gmXgI7oPiWnhFKBFbtQk5EYoWoh4VRvRczupyVRbVcNuvwdshJrfXgJufoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl2qu0TKm15jcz7p/P0KfXOzDXIfnaY6qZ1ExE5ewP6CnfQIDi
	AhAf6o4LGrP1VFUe6AD1JWCCUJoGA4uaMxnBCUhMZK0CafzqM9jzVMJ6farNlJX1UbrfCtoou8b
	GUQbDn1/+hQSXziWdiji3b9nNL5CXIngO+0eGuCL4+6EylEtRKs+hYjjetJFT67twiJLEb4nJE6
	GfgU95H8V9e74y6FAtd6gJwGOJnsBN4uNjonDSfLly0wHN
X-Received: by 2002:a05:6512:1193:b0:535:6cef:ffb8 with SMTP id 2adb3069b0e04-53678ff321bmr8869785e87.54.1726514761307;
        Mon, 16 Sep 2024 12:26:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9iFAn60gqVCh/eEOClq/2Ao2PKM9BHijjCnoTeeccANQO3dg8hkcL8qWA+1JKf+BkzHLG8xBIVMKN5qLCNCg=
X-Received: by 2002:a05:6512:1193:b0:535:6cef:ffb8 with SMTP id
 2adb3069b0e04-53678ff321bmr8869741e87.54.1726514760012; Mon, 16 Sep 2024
 12:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHTA-uZDaJ-71o+bo8a96TV4ck-8niimztQFaa=QoeNdUm-9wg@mail.gmail.com>
 <20240912191306.0cf81ce3@kernel.org> <CAHTA-uZvLg4aW7hMXMxkVwar7a3vL+yR=YOznW3Yresaq3Yd+A@mail.gmail.com>
 <20240913115124.2011ed88@kernel.org> <CAHTA-uYC2nw+BWq5f35yyfekZ6S8iRt=EYq4YaJSSPsTBbztzw@mail.gmail.com>
In-Reply-To: <CAHTA-uYC2nw+BWq5f35yyfekZ6S8iRt=EYq4YaJSSPsTBbztzw@mail.gmail.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Mon, 16 Sep 2024 14:25:49 -0500
Message-ID: <CAHTA-uYxSzp8apoZhh_W=TLFA451uc=Eb+_X4VEEVVZNGHaGjw@mail.gmail.com>
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

Linking in this thread as well - I submitted a patch to net-next with
a reproducer for just this bug. It works reliably on Grace/Grace on
v6.11 (and prior kernels already known to be affected), but I have not
had a chance to test it on other platforms yet. Let me know if I need
to adjust anything and whether it reproduces the bug on your machines.

Patch w/ reproducer:
https://lore.kernel.org/all/20240916191857.1082092-1-mitchell.augustin@cano=
nical.com/

Thanks!

On Fri, Sep 13, 2024 at 1:59=E2=80=AFPM Mitchell Augustin
<mitchell.augustin@canonical.com> wrote:
>
> > Sorry, I missed that you identified the test case.
>
> All good!
>
> I will still plan to turn the reproducer for this bug into its own
> regression test. I think there would still be value in having an
> individual case that can more reliably trigger this specific issue.
>
> Thanks,
>
> On Fri, Sep 13, 2024 at 1:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Fri, 13 Sep 2024 08:45:22 -0500 Mitchell Augustin wrote:
> > > Executing ./pmtu.sh pmtu_ipv6_ipv6_exception manually will only
> > > trigger the pmtu_ipv6_ipv6_exception sub-case
> >
> > Sorry, I missed that you identified the test case.
> > The split of the test is quite tangential, then.
>
>
>
> --
> Mitchell Augustin
> Software Engineer - Ubuntu Partner Engineering
> Email:mitchell.augustin@canonical.com
> Location:Illinois, United States of America
>
>
> canonical.com
> ubuntu.com



--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

