Return-Path: <netdev+bounces-247476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE4ACFB154
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 22:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6DD10300874F
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 21:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD7B3009E2;
	Tue,  6 Jan 2026 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUiWUBXL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF792FE571
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 21:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767734752; cv=none; b=N6LZBO5BM3JZsu9rnZcD0hO2ra7n/K+9mq0AYsgK1YQSX5oLmthfo+6/uS5G3P86axRHMcVPuTGdJGt7O1E36AEi8/9v3NoEHMrrRpaZUKzQPF97by7Y6gSDeVAiZ5qY3SOJdEWBfSVRgpOkbt3TzEFxpNQskIUWWJrAJJDaz58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767734752; c=relaxed/simple;
	bh=I3eQAT/IR1A41/QWrWgkPe6odAhmGNzg1D41gyPiuuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7SdsE/g8TNO5Km2hj+emTwiVPmwGIyAznh/7YZUQkExYHcWgMJv3prNWMQYdOr1scoTPF67YsvN/VRl/H51RiKbqaX6WKTjxkkyOzyyhR01Yh9Wb0C32NppzuCYVhdRTbr62kygw/4XM8Zc13cMVjl2GctBjmpdCldfg6htQQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sUiWUBXL; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8bb6a27d407so120675885a.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 13:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767734750; x=1768339550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgC2gnzpQbjXigwg5q1BOcErLm9lIlGM/l11K6xhhJA=;
        b=sUiWUBXL/PpKLUZHfQukKfuNuiei47fC+GMbJP4ohB2MEpC7mMJ2a/oCqjmTKY/p9D
         F0M+qGXlJqsRHAJ+Hq4Rt5fkj2iDC7rUGKlhCBx+2YAGvPeHKUK5F1/GTD8hK+rgGRc0
         LQLh4n/XSkXToW0QOx1QLcCbwNyVH/a8dSANQM/WURHQ93GJsZqcmfQcbjbk6ydC8eb7
         Zt6n9BLxwxF4WuAt8MiAHpj/DBLfz1C5XXV1uWZBnNTq0O7z6/f24HpcVOb8NFXrzE1n
         1XYvqGR9nKJIgJJWYFOcmhdLapP2eMxFmqgSnV5+ZEPLCzKCj26BR3OLFE1wfd71T15t
         w7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767734750; x=1768339550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CgC2gnzpQbjXigwg5q1BOcErLm9lIlGM/l11K6xhhJA=;
        b=Kji/tiNpo3zlTVRZUR+tdnojzezJzOAH9digrdSFypePC2ttskCT4ShJmPzv6gsBGz
         cz2aTQ+Xo+xIKoXPJ/HUyZNmtA5t2Tox12Mz90BX3BXZZxQwGP3wBD09PWcutKalPbjQ
         DKCKNVjZxZHBL0CzLIAF1mb6+h/80qdnM2T90E/1M+nEQCWFAi/GOp9U1O4QDYouSa7g
         +BcDdwWRw0WWnVmtlvzQDo5qVSkzVtU4RmYQyVbqZLA7qASwJWp2/9nQ5ky9ECAGn2Ac
         HtyoooHJbTxziQH9seAIUvvTsRE0zxjZYUhjB5yZ0mV0r7gH5FqGQovcyypfP0M8Rf4l
         nAhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaY8F6LtMr8kYFWXTpnCubAwG1HEP5UUUhZT7CLbsnqRDBGB/SbaMOF1G0UKsM0lPrphE1pgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSrVWJnQviUxEBLBspD3EW639iFqwZ5PlankZU+/nwM2WrIN4X
	s4qsdkNau2AxlGII7bIwR/mJcSMhJqm50QTXNBiHzHKyiKZMMrpRClOjZuKiUceRxBQu5+1FR9y
	M+QbxrbahYF5NgWNf28E2oRJDUwof1cEYcmPSPrfl
X-Gm-Gg: AY/fxX4Cv0tvC/HU/tcafw908hezpvYfS5fWCjNszUoKWOFstqS0oyjDjQXm08PRZCg
	x4lpQEslVgcfgA/NtfAXuPEL7feDgpcKTTLzK8xcCCvVa3idETv9C5X3Ga2uKZcK4537k8ATyA+
	qdKmHATVFsHuWqQmCR1vhkgrZuX2MXfMzmfKpD1sqI+Z63u7vGm1SaBeTGSvTtfFxHuWIYEtziy
	GaiLy0NzcTWLTi18bmyBbfNpqQAbXDsthBmVXkbiLV9AMZaGhRSMTKMC74s35VL69W/yS8=
X-Google-Smtp-Source: AGHT+IF811r+/0kXL7lohohMKZES3wWRlRvyvJaQqd+Ij/EIdCvkdXfvKX4AXA9pEO0qKEJQhxw+g3G1sjk3iKLBuK8=
X-Received: by 2002:ac8:7d0b:0:b0:4ec:f697:2c00 with SMTP id
 d75a77b69052e-4ffb49e6e22mr4247071cf.42.1767734749369; Tue, 06 Jan 2026
 13:25:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106144529.1424886-1-edumazet@google.com> <20260106095648.07a870f1@kernel.org>
 <CANn89iJnXg892OU13PeJMGvBKw90fJdqDaAmJ867Rptsm0zgNA@mail.gmail.com> <20260106123151.03a984bb@kernel.org>
In-Reply-To: <20260106123151.03a984bb@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 6 Jan 2026 22:25:38 +0100
X-Gm-Features: AQt7F2q_d_I_CK6WmUKLHfRXhhIRA4LZJWD0kXbJm-wHrFsWiN48olvMvOJ9huM
Message-ID: <CANn89iL_Sa_ez340w2eyM_rfCnOH-UV9-zo1sYv65_hdQ-_W6g@mail.gmail.com>
Subject: Re: [PATCH v2 net] ip6_gre: use skb_vlan_inet_prepare() instead of pskb_inet_may_pull()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com, 
	Mazin Al Haddad <mazin@getstate.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 9:31=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 6 Jan 2026 20:33:40 +0100 Eric Dumazet wrote:
> > For some reason I am unable to run this test from a virtme-ng instance.
> >
> > I guess I wlll not make a new version of this patch, maybe Florian can
> > take over.
>
> Hm, no complications seen here:
>
> $ vng -r --user root
> ..
> prompt# cd tools/testing/selftests/net/
> prompt# ./gre_gso.sh
>
>     TEST: GREv6/v4 - copy file w/ TSO                                   [=
 OK ]
>     TEST: GREv6/v4 - copy file w/ GSO                                   [=
 OK ]
> 2026/01/06 15:30:35 socat[1704] W exiting on signal 15
>     TEST: GREv6/v6 - copy file w/ TSO                                   [=
 OK ]
>     TEST: GREv6/v6 - copy file w/ GSO                                   [=
 OK ]
> 2026/01/06 15:30:35 socat[1721] W exiting on signal 15
>
> Tests passed:   4
> Tests failed:   0
>
>
> Happy to give you access to the netdev machine to experiment there
> if that helps, just send me an SSH key.

My vng launch script had the -v option ( --verbose, -v   Increase
console output verbosity), and this was causing issues.


Anyway, using my v2 patch on top of current net-tree
(238e03d0466239410) seems fine to me, no error at all,
not sure why your bot is unhappy.

Could multiple patches have been tested together, one having a side effect =
?

[hi on] edumazet@edumazet1:~/git/net-next$ vng  -r --user root --cpus
4 --memory 4G
/usr/lib/tmpfiles.d/legacy.conf:14: Duplicate line for path
"/run/lock", ignoring.
          _      _
   __   _(_)_ __| |_ _ __ ___   ___       _ __   __ _
   \ \ / / |  __| __|  _   _ \ / _ \_____|  _ \ / _  |
    \ V /| | |  | |_| | | | | |  __/_____| | | | (_| |
     \_/ |_|_|   \__|_| |_| |_|\___|     |_| |_|\__  |
                                                |___/
   kernel version: 6.16.12-1rodete2-amd64 x86_64
   (CTRL+d to exit)

Illegal instruction        shell-history-configtool configure-interactively
root@virtme-ng:/usr/local/google/home/edumazet/git/net-next# cd
tools/testing/selftests/net/
root@virtme-ng:/usr/local/google/home/edumazet/git/net-next/tools/testing/s=
elftests/net#
./gre_gso.sh
    TEST: GREv6/v4 - copy file w/ TSO                                   [ O=
K ]
    TEST: GREv6/v4 - copy file w/ GSO                                   [ O=
K ]
2026/01/06 21:25:27 socat[1214] W exiting on signal 15
    TEST: GREv6/v6 - copy file w/ TSO                                   [ O=
K ]
    TEST: GREv6/v6 - copy file w/ GSO                                   [ O=
K ]
2026/01/06 21:25:27 socat[1229] W exiting on signal 15

Tests passed:   4
Tests failed:   0
root@virtme-ng:/usr/local/google/home/edumazet/git/net-next/tools/testing/s=
elftests/net#

