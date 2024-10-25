Return-Path: <netdev+bounces-138926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B86E9AF721
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA851C21852
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 01:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E54A945;
	Fri, 25 Oct 2024 01:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="PDRzRWOi"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2797783CD3;
	Fri, 25 Oct 2024 01:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820703; cv=none; b=iz6uU3U5qmqYw7Qpz9riBlxJZAMIgXBlQM3weRrK6Gs8Xd4+Awq7rmMv4tlYIfl//+CRf7SGJAZzCl5pilzJquvQYREDwWTsGXujduXg9Ed8pAKAB0WPW+/lMbJeVjzaA5RVLPKzDU+S5YmpGc+qHUGZRfn99Q5vVKGfC+vtw1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820703; c=relaxed/simple;
	bh=j5rUgI4QcDohUY6gRW9S+wk/GQOr7ranVqJfRKCi0B4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fQquHDnQvJCs5OCXI8vJlj6duUv3HeilRYlVpXAJSX/OkYA+74UXXtIhHFTGe0yQNMgt8sO9zzXRqmg+3BmN+rf16EjfE91Bnjk10KokvtBBRZogpRkKlYg/aUsXXbXB6gM9vYFa64ApfgIrGyX/Ztb/kL+pgBC0mWOs/PF3KC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=PDRzRWOi; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1729820695;
	bh=GHNqhn7iF5nbiHx3NlBURflSyACOuScmqv9/P11/hSE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PDRzRWOiXqIln3VKPJQ+lEIiLsTqnM4VODSbPvkYNJ+ZYjbh1GOPOQIC/VhKO/xlD
	 iDrLtoBM4NB1horgKbiFqzTKx9p7KUcNlTXrgrg1r8daWejcMR0ytQNmfR7zKQJm2N
	 tKK+58IB6e2lnFvpcNmnmAdjbER6WJF1KJlzheqC5SX5mScPuGax7+M9qWT9/Ya0/+
	 lxybIWX+nEN5djVHJJCj04m1CFSuZb92Bp1F0jxZGBkCgqGwPMkNmh7/+z21Ih5NZm
	 gk6Vc7fMyOpLtkx7Pj0GIv5AnuJS0EzwZYKsEeVTf1pLfJKd3J21jqjB1M/YtM6vbT
	 7rDqzmniIZViw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XZQZZ6HSZz4wb1;
	Fri, 25 Oct 2024 12:44:54 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, kees@kernel.org,
 broonie@kernel.org
Subject: Re: [GIT PULL] Networking for v6.12-rc5
In-Reply-To: <ZxpZcz3jZv2wokh8@sashalap>
References: <20241024140101.24610-1-pabeni@redhat.com>
 <ZxpZcz3jZv2wokh8@sashalap>
Date: Fri, 25 Oct 2024 12:44:54 +1100
Message-ID: <87cyjpj6qx.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sasha Levin <sashal@kernel.org> writes:
> Sorry for the spam below, this is another attempt to solicit feedback to
> the -next analysis tools that a few of us were working on.
>
> Bigger changes since the last attempt:
>
>    - Count calendar days rather than number of tags for the histogram.
=20=20=20=20
I think this is a good change, but the presentation of the information
probably needs a bit of work.

Some of the commits below are in next-20241024, which was tagged less
than one day ago, but some are not. But they're all shown as "0 days",
which I think will confuse people.

I think you need to differentiate between 0 days in linux-next vs
*never* in linux-next. Otherwise folks are going to yell at you and say
"that commit was in linux-next!".

>    - Make histogram more concise when possible (the below is *not* a good
>      example of the new functionality).
>    - Add more statistics to the report.
>
> On Thu, Oct 24, 2024 at 04:01:01PM +0200, Paolo Abeni wrote:
>>Hi Linus!
>>
>>Oddily this includes a fix for posix clock regression; in our previous PR
>>we included a change there as a pre-requisite for networking one.
>>Such fix proved to be buggy and requires the follow-up included here.
>>Thomas suggested we should send it, given we sent the buggy patch.
>>
>>The following changes since commit 07d6bf634bc8f93caf8920c9d61df761645336=
e2:
>>
>>  Merge tag 'net-6.12-rc4' of git://git.kernel.org/pub/scm/linux/kernel/g=
it/netdev/net (2024-10-17 09:31:18 -0700)
>>
>>are available in the Git repository at:
>>
>>  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.12-r=
c5
>
> Days in linux-next:
> ----------------------------------------
>   0 | =E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=
=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=
=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=
=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=
=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=
=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=
 (14)
>   1 | =E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88 (2)
=20=20=20
So I think here you need something like (numbers made up):

Days in linux-next:
----------------------------------------
   0 | =E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=
=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88 (4)
 < 1 | =E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=
=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=
=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=
=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=
=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=
=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=
 (10)
   1 | =E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88 (2)

To make it clear that some commits were not in linux-next at all,
whereas some were but for such a short time that they can hardly have
seen any testing. (Which still has some value, because at least we know
they didn't cause a merge conflict and passed at least some build
testing that sfr does during the linux-next merge).

>   2 | =E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=
=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=
=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88 (6)
>   3 | =E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=
=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=
=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=
=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=
=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=
=88=E2=96=88 (12)
>   4 |
>   5 |
>   6 | =E2=96=88=E2=96=88=E2=96=88 (1)
>   7 |
>   8 | =E2=96=88=E2=96=88=E2=96=88 (1)
>   9 |
> 10 |
> 11 |
> 12 |
> 13 |
> 14+| =E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=
=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88 (4)
>
> Commits with 0 days in linux-next (14 of 40: 35.0%):
> --------------------------------
> 3e65ede526cf4 net: dsa: mv88e6xxx: support 4000ps cycle counter period
> 7e3c18097a709 net: dsa: mv88e6xxx: read cycle counter period from hardware
> 67af86afff74c net: dsa: mv88e6xxx: group cycle counter coefficients
> 64761c980cbf7 net: usb: qmi_wwan: add Fibocom FG132 0x0112 composition
> 4c262801ea60c hv_netvsc: Fix VF namespace also in synthetic NIC NETDEV_RE=
GISTER event
> ee76eb24343bd net: dsa: microchip: disable EEE for KSZ879x/KSZ877x/KSZ876x
> 246b435ad6685 Bluetooth: ISO: Fix UAF on iso_sock_timeout
> 1bf4470a3939c Bluetooth: SCO: Fix UAF on sco_sock_timeout
> 989fa5171f005 Bluetooth: hci_core: Disable works on hci_unregister_dev
=20
The commits below here are in today's linux-next (next-20241024):

> 6e62807c7fbb3 posix-clock: posix-clock: Fix unbalanced locking in pc_cloc=
k_settime()
> 10ce0db787004 r8169: avoid unsolicited interrupts
> b22db8b8befe9 net: sched: use RCU read-side critical section in taprio_du=
mp()
> f504465970aeb net: sched: fix use-after-free in taprio_change()
> 34d35b4edbbe8 net/sched: act_api: deny mismatched skip_sw/skip_hw flags f=
or actions created by classifiers

The first question that comes to mind here is what's the diffstat for
these like.

There's a big difference if these are all tight few-line fixes to
individual drivers or sprawling hundred line changes that touch arch
code etc.

Listing the diffstat for all of them individually would be way too
spammy. Passing all the sha's to git show and using diffstat seems to
give a reasonable overview, eg:

$ git show -p 3e65ede526cf4 7e3c18097a709 67af86afff74c 64761c980cbf7 4c262=
801ea60c ee76eb24343bd 246b435ad6685 1bf4470a3939c 989fa5171f005 | diffstat=
 -p1

 drivers/net/dsa/microchip/ksz_common.c |   21 +++++++++++----------
 drivers/net/dsa/mv88e6xxx/chip.h       |    8 +++-----
 drivers/net/dsa/mv88e6xxx/ptp.c        |  142 ++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------=
---------------------------------------
 drivers/net/hyperv/netvsc_drv.c        |   30 ++++++++++++++++++++++++++++=
++
 drivers/net/usb/qmi_wwan.c             |    1 +
 include/net/bluetooth/bluetooth.h      |    1 +
 net/bluetooth/af_bluetooth.c           |   22 ++++++++++++++++++++++
 net/bluetooth/hci_core.c               |   24 +++++++++++++++---------
 net/bluetooth/hci_sync.c               |   12 +++++++++---
 net/bluetooth/iso.c                    |   18 ++++++++++++------
 net/bluetooth/sco.c                    |   18 ++++++++++++------
 11 files changed, 208 insertions(+), 89 deletions(-)

I know the pull request has a diffstat, but they are significantly differen=
t.

Apologies for bike-shedding this so hard, it's just because I think it
would be a good addition to the development culture.

cheers

