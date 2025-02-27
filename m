Return-Path: <netdev+bounces-170289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B68DA48170
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38551883D9A
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943DB22C35C;
	Thu, 27 Feb 2025 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="LJOqE+/6"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9ED17BA6;
	Thu, 27 Feb 2025 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666125; cv=none; b=rBdsaEk0OSAfoHDxWPmSK4Z5HHMbyL5fDQeitNe6K9xS8xgzI3nnq0kZ/qo4eKJMr/iIcPBWDAHdgioHEDYS+4jsy66R0rz+ia7zrOVCLRIB7XVwbv/asj3uc+l7N3be70+1WUJ75XH6SIsOr5fbPVfhbmrnVmnr2TehYyxBXtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666125; c=relaxed/simple;
	bh=+HiwIAO6jMqFf5NIdCtX273/t0dTAzZqBdFWt3fzBRE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iddqSAobonm1g0f5706J/HTNM45RPv2uAm/Zonid2E2q01xuqAzn6cIwKMDbw6CVW4Ghq5kEx7USJ8ptbZsKwYGtuMK0ZD8Gc4YFrIRxLr0KAeOU4ufy1nM7XQbOK3bqFEV7OTjw1Yxv9Eqa/rxVvnJ6y7YKXCpMz9ZVFqBSQWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=LJOqE+/6; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1740666115; x=1741270915; i=ps.report@gmx.net;
	bh=ueH2mBJqBbPIc/pCwnFyLp23XYZ6U8XmkBzcWFHsgf8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LJOqE+/6Kbsi/JFdbxtilxja5n1fDDG7NcK5QkzoewrTDq3gveKSPMLG4bRVR+wA
	 owxQAa/dKue2ueICbPphQiIaGEW/JhuT7UF12sYNLs9WY6VEvLOS+nRypBiHeUdgM
	 vHAoZAF68vhQoGXVSm8MMvwN5xlhaQKOk/s9fjck13N8Ifg4Jqm1pXFTgikRwhjsm
	 vlb1BWDz0qahSCbfAsw2bWiFXFWzAXw+fSp2+t8OZFYI4oDNWE1qz8hd/NBo2pvJq
	 Ga9qtsxNQoaTueUNAWPTuZCp/MYv+xjD9nzWIX9Mn9mRUx91KLpgxMssGPeQJ8MaS
	 t+2LAX0BLInnZD4NLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.151]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mn2aN-1tPHee2Kgx-00llbd; Thu, 27
 Feb 2025 15:21:55 +0100
Date: Thu, 27 Feb 2025 15:21:54 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pktgen: avoid unused-const-variable warning
Message-ID: <20250227152154.4da61f2f@gmx.net>
In-Reply-To: <4c260b13-3b08-409d-a88a-e5bbb3c18e03@redhat.com>
References: <20250225085722.469868-1-arnd@kernel.org>
	<20250226191723.7891b393@gmx.net>
	<4c260b13-3b08-409d-a88a-e5bbb3c18e03@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hDJsAmAOjPpfF5JEDV31dTu8+edNiRUwO+r1jBKb1aCDfIGRGO1
 R+QKO+7q5sig+RghgQwqeEFj7/42NmeKZ52d9/B+7Xx3SA5j6T5nwErccttDO/uJ5GMXnT6
 ePpg0oSTNPe4y+sFaNXIfM6h7wocQ7bSIgBD6+ww7YZtdZNDh3CRWmaAB4hTxq7vCvdSRh0
 njDoIrqkznMUmzKBVVdnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PseNyx0c1kE=;1ioMzVyGdx66mcLe4jgHlVGtZya
 +4Ol55nUkkFiR7tPzyRMbqWMfFGFqhkgnULlsUkofrsmXr3QxvT4aZ3wqE1Sul9AP97/ukJ/j
 iViayGeS8ObY5bcbGjLMhMewrmHwhCxJ+lXHPsRRIrvd463/W12FZ5LNhqKmOB3/7CBmY96sj
 /AA9wctnfxDrn4Sv0FgIKyC3rHsHl2CILbCtVXsoyJliFgVHjPt+nDY8tTeOc7BvVz0vI2GFl
 lFuo1GqNmO2bIKDdIHXZBw711BWW5/rWk4v/XCdHLDTYwgiMXb/xI+Io+zKHmk4pSJL4oGUpr
 eBz5R8Fp8901q3ZtryxrhpdQs3lmHsyw68xovENJthbg5kb2lhsSjjoU54rVYabt6Ma+7S44h
 5HkfX9lyIxfXS5HOXWYkg8jtSHUVZHRf56nVNvYsDtusZle8m4awbK/AlD4Pib/ZoKCBtU+/s
 IZ0JlAFRKO018X4GcSDtHs6wAAqFFK+CK+Bd0skVSiR1E9i0dylxD607zo9F6evPq+RVvZ7oZ
 ub7YpzXESg2Kh4YNb2f4tGiCdFg+ezSxIDm8hWB0i7DByknArTw112LJ7p7Vd68xsWIAVgmNm
 mYIGzJ52zWHCLMv94Y+DncxUAAof4E9PusnaVvjGBN1dgJe/bc7yPgh496uaUQGgLVWYvLCf0
 XHO0djihKC2n8MvwQZ7GVYU8vVa2Rd4k1MaBzD3GROk5R9pXe60BFASHfpaA8cgKelQIGEt5m
 tmPo5QJjOkWan5Um4iIafBhoku6aV8g2tiFmo1/uEd/ZkKaRAI60knKpEycCFY8WGQynTHDRK
 EGgfDmS5ntDcMeUr56mJlp/ikqsi5ro09H3XFjno8siLU8kyyKqYS7FfHy6bKAQenYIxhJea2
 2hM6UwHtpTcigcPewQUZamg9waRPL+HRVuk1aVWxzZHLD07X/NgsAb04L1pdFfz4AGOHeirZz
 A+YvR0GxXc9KIcTSha4KvLPWuquyZccMVDyeJz4D75RyMEEK0a9IVwD7b+b8WcaStj71mAkNW
 TTLzbz6YGCUjQk9Ivi4syVBjCuGuDFJtzZZCLIe1edJV4uCaAqfuCBvkhLNed3YDxghi14aVl
 TwT+SPjCvtUnJ1Tm2uITzXp0K91EV3Joia6narRMG5WH+xFAb99lbMJH9YZZi8mjDlkW2L/Lv
 UDMSb+yEs4LKBCgQWKxYkbNXsqGHqwHVIIEcbJoguLcPKuihNztVa68z0pV8WNtp8Apf0OK2i
 Q5CYL1gZVtOy2QzZMvTAhdKjU3chE9uKnydv/0+tc6UKZCXzdXqDwF+gCXyDN+k8tWjQjNHI6
 w0o4+lQZLcZyYVeC/skcUN9bfRa8gtobpvwxRW9RrZi38z3+brAEwd463xOYl9bGidkYw/lOX
 vDkY3PVZm4vVa92ASHcXmtgWN3rL0lw9a5WwTRhPMLUhPtQ2OQBzvnXaOs

Hello Paolo,

On Thu, 27 Feb 2025 12:35:45 +0100, Paolo Abeni <pabeni@redhat.com> wrote:

> On 2/26/25 7:17 PM, Peter Seiderer wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >> When extra warnings are enable, there are configurations that build
> >> pktgen without CONFIG_XFRM, which leaves a static const variable unus=
ed:
> >>
> >> net/core/pktgen.c:213:1: error: unused variable 'F_IPSEC' [-Werror,-W=
unused-const-variable]
> >>   213 | PKT_FLAGS
> >>       | ^~~~~~~~~
> >> net/core/pktgen.c:197:2: note: expanded from macro 'PKT_FLAGS'
> >>   197 |         pf(IPSEC)               /* ipsec on for flows */     =
           \
> >>       |         ^~~~~~~~~
> >>
> >> This could be marked as __maybe_unused, or by making the one use visi=
ble
> >> to the compiler by slightly rearranging the #ifdef blocks. The second
> >> variant looks slightly nicer here, so use that.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>  net/core/pktgen.c | 9 ++-------
> >>  1 file changed, 2 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> >> index 55064713223e..402e01a2ce19 100644
> >> --- a/net/core/pktgen.c
> >> +++ b/net/core/pktgen.c
> >> @@ -158,9 +158,7 @@
> >>  #include <net/udp.h>
> >>  #include <net/ip6_checksum.h>
> >>  #include <net/addrconf.h>
> >> -#ifdef CONFIG_XFRM
> >>  #include <net/xfrm.h>
> >> -#endif
> >
> > This ifdef/endif can be kept (as the xfrm stuff is still not used)...
>
> FTR, I think dropping unneeded #ifdef is preferable in c files: only
> such file build time is affected, and the code is more readable.

The ifdef/endif emphasizes no xfrm usage (even by mistake) in case CONFIG_=
XFRM
is not defined, but in the end a matter of taste ;-)

>
> >
> >>  #include <net/netns/generic.h>
> >>  #include <asm/byteorder.h>
> >>  #include <linux/rcupdate.h>
> >> @@ -2363,13 +2361,13 @@ static inline int f_pick(struct pktgen_dev *p=
kt_dev)
> >>  }
> >>
> >>
> >> -#ifdef CONFIG_XFRM
> >>  /* If there was already an IPSEC SA, we keep it as is, else
> >>   * we go look for it ...
> >>  */
> >>  #define DUMMY_MARK 0
> >
> > A now unused define...
> >
> >>  static void get_ipsec_sa(struct pktgen_dev *pkt_dev, int flow)
> >>  {
> >> +#ifdef CONFIG_XFRM
> >>  	struct xfrm_state *x =3D pkt_dev->flows[flow].x;
> >>  	struct pktgen_net *pn =3D net_generic(dev_net(pkt_dev->odev), pg_ne=
t_id);
> >
> > Maybe better this way here?
> >
> > 	const u32 dummy_mark =3D 0;
>
> I think the unused define is preferable; I think pre-processor defines
> are cheaper than static const.

In which regards cheaper (out of interest)?

Both (with and without static) produce the same code see e.g.

	https://godbolt.org/z/Tsr1jM45r
	https://godbolt.org/z/6sr1o8da3

Regards,
Peter

>
> Thanks,
>
> Paolo
>


