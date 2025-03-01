Return-Path: <netdev+bounces-170910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E49BA4A8FC
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 06:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17BA175CB8
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 05:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B711BF33F;
	Sat,  1 Mar 2025 05:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sDlq9ZGE"
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FA928E7
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 05:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740807214; cv=none; b=Gb4T8W4LwCbq6fuUDvfzfh9Cp3p2c9VV6sW3mHGgPNH1U3GWagze9hFMRiTapGv1oJyr7yl57NRmuJ9dS3rVVFsn91HZGIC7qJbSJ687RVmkI0zXOAumqq6MnioPE1xjfpnlQR6lVbtNf47RZ7zWOFQo+yYQUuphh8ulabdz9zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740807214; c=relaxed/simple;
	bh=ZrRPeNUxL90aXDQMG1/SmMDM+J1aoW3Dv74RJgNkMco=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=YIBGSF70ApFxaQXdyBRRGIEz98asNl9Cm56m9p5BkW36Nb6/7gEzwx2O3QdwiDSPPGlb+rfBgOHjR++3zLvjnY5WcNJZyQx2V9BJ9dVyXQM48VffdQ8ZvAl6fHY1XFOGhP/QiznSDMCyQahV2HZDgjw/3qs3dt9llRPOxPEPhoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sDlq9ZGE; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250301053327epoutp0378165fa49ca216bdf4f46fc4f9eeced1~olu6np1Am0353203532epoutp03f
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 05:33:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250301053327epoutp0378165fa49ca216bdf4f46fc4f9eeced1~olu6np1Am0353203532epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740807207;
	bh=xQgrnunQJ35zDX3H/wcDNk3BC+UHwAQtdeQC18BXYRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sDlq9ZGE4J9iNEwRPg/qsycMVhPAeuiCM0SwUkA67PZF3xlfjRynqnulJ7VKyzcfK
	 ig3KmF8kLTTwnSIU6ZtgPuG1iPcSy557BSxcGkLdnVPWft7NULmzVp5zNWny2PVgC7
	 tWBY4v90rvHlaalj79tA5ZPx3A1JOrHSW/yS8FQw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20250301053326epcas2p1aa536b3947ab5b18c0321c5643c60785~olu5ziTEd0659406594epcas2p1X;
	Sat,  1 Mar 2025 05:33:26 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.70]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Z4Ydf1WTDz4x9Pw; Sat,  1 Mar
	2025 05:33:26 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	4B.64.23368.52C92C76; Sat,  1 Mar 2025 14:33:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250301053324epcas2p34b58ddc8f1a6eb4622b34402d817ab26~olu373jIB0113001130epcas2p3T;
	Sat,  1 Mar 2025 05:33:24 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250301053324epsmtrp2d95365b3c2dbf80801b9a6d0a5f061e3~olu35XAJL2717127171epsmtrp2T;
	Sat,  1 Mar 2025 05:33:24 +0000 (GMT)
X-AuditID: b6c32a45-dc9f070000005b48-81-67c29c25b48e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	7B.0F.33707.42C92C76; Sat,  1 Mar 2025 14:33:24 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250301053324epsmtip1d58f105c9734101a2ee16316b577a2cd~olu3l3P6e0263402634epsmtip1C;
	Sat,  1 Mar 2025 05:33:24 +0000 (GMT)
Date: Sat, 1 Mar 2025 14:37:23 +0900
From: Youngmin Nam <youngmin.nam@samsung.com>
To: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com,
	horms@kernel.org, guo88.liu@samsung.com, yiwang.cai@samsung.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	joonki.min@samsung.com, hajun.sung@samsung.com, d7271.choe@samsung.com,
	sw.ju@samsung.com, "Dujeong.lee" <dujeong.lee@samsung.com>, Yuchung Cheng
	<ycheng@google.com>, Kevin Yang <yyd@google.com>, Xueming Feng
	<kuro@kuroa.me>, Youngmin Nam <youngmin.nam@samsung.com>,
	cmllamas@google.com, willdeacon@google.com, maennich@google.com
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
Message-ID: <Z8KcXQhdRId1S6w8@perf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CADVnQymr=sst5foNOF7ydr-fUyAK6XLvRyNvnTVBV=wgPLpBBQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHc3pv770wO+/KhLNqNtYZMjbKWixwMNRMYazskTAXxzJjsIG7
	0lHa0lum8xERirAS6RhzAuJSh4GBGc7KCoOxkVIesrA5kOEQgfGUPRB5iShoy1XDf5/z/X2/
	55zfeVCYcJIQURqdiTHqVFox4Y07mgNDJQGlTrX08hgPzTV1keheYwGJSu+YcVRdn81D47Yi
	HI21DpOo8BxAmTe7MDRsbSdQT8MUhr535PORs3mCRN31pQRaaHxMotz+Rhy12nzRwq3HAGWP
	zJIo549HOJob6SHQb22ZJCprmiFR1hfV+G4/ZU3lfZ7SZk9X2qtOE0pbPqn89UYPocyvqQLK
	WfvmOPJYSmQyo0pijP6MLlGfpNGpFeL9hxOiEkLDpDKJLAKFi/11qlRGIY4+ECeJ0WjdzYn9
	T6q06W4pTsWy4l0vRRr16SbGP1nPmhRixpCkNYQbgllVKpuuUwfrGNOLMqk0JNRtfDMl+a/p
	KzxDx763b1cMEBmgE1mAFwVpObTU9vMswJsS0nUA2pvKCU9BSM8AePlPEVdw85MzDXwLoFYT
	C5khnH4NwKkvh/jc4AGAY51mvieN08/Dwm+ngIcJWgId7SurvJHeDn++OAQ8AYzuxeGjvmng
	mdWHjoLL/QqPR0Bvg46pC3yON8Dvikdxj8WLPgRHb77P7XqRgqcnvTmOhvM/TJMc+8CHbTX/
	sgjOTjUSHLMwY7AP8ywLaTOAHb2/YFzhBVgynrO6N4zWwIttH/K4JrdBVx/OyethbvMyyckC
	mPuRkEsGwKVzVwDHz8GGsksYZ1HC2Y+TuBO5jsORoTL8DNhcsqaZkjWLlbgjGB0Iv67fxclb
	YNbVzzBOfhZWrFBrHDZAVAFfxsCmqhk2xCD7/6IT9al2sPrmd+ypA4VPpoOdgEcBJ4AUJt4o
	KHmjSS0UJKlOvcMY9QnGdC3DOkGo+5IKMNEziXr3p9GZEmTyCKk8LEwWHhIqDRf7Cd6tM6uF
	tFplYlIYxsAY/8vxKC9RBq9oKatyz63Dhz6Vnd17tfblwuPC4nGd0nrQdN71oOIVjdOExlyb
	fJddE32Kgez595Qb5rqr/04LclVNXxNGf/NqrFpoMVV2rhtUdz6UBwybXTNky9aUE1EtiaP9
	91te32RtvzS0c33a1pYLQd25xTsJwD/hdUrb5Tdy8O7Ti+X5/UdyyIkOx3X5MYWg96tMx2uL
	Eaa7lYEnvYsktcm/L+4PEhR8sGK9fY/68a0BEV8xsGQ/v+AQjcWvSzu6Evv5dldeLJmnWAqO
	zi7eYraW7i4tHIo5vnzHVXbk6AFNa0ruvLxi31PxPjGReZ9k2CYTBivGsYaAszeQxFI+GFj8
	k84QES/G2WSVbAdmZFX/AEBZFRB8BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7bCSnK7KnEPpBq131S2+HLjEbnFt70R2
	iznnW1gs1u1qZbJ4tmAGi8XTY4/YLSZPYbRo2n+J2eJR/wk2i6u73zFbXNjWx2px6PBzdovL
	u+awWXzb+4bdouPOXhaLYwvELL6dfsNo0fr4M7tF+8/XLBZfHl9ls/h4vIndYvGBT+wWzQvX
	sTiIe2xZeZPJY8GmUo9NqzrZPBb0sXu833eVzaNvyypGj8+b5ALYo7hsUlJzMstSi/TtErgy
	zhw7wVTw0r1i+v52tgbGDrMuRg4OCQETiW9NRl2MXBxCAtsZJbpWPWPuYuQEistI3F55mRXC
	Fpa433IEzBYSuM8osXCBJ4jNIqAiMXnzO0YQm01AV2LbiX9gtoiAhsTdRQ8YQYYyC9xmkdhw
	4DYzyDJhAWeJv3dsQWp4BZQltr2bxwqxeB+LxNrVX1ghEoISJ2c+YQGxmQXUJf7MuwTWyywg
	LbH8HwdEWF6ieetssDCnQKDEk/21ExgFZyFpnoWkeRZC8ywkzQsYWVYxiqYWFOem5yYXGOoV
	J+YWl+al6yXn525iBMeuVtAOxmXr/+odYmTiYDzEKMHBrCTCOyv2QLoQb0piZVVqUX58UWlO
	avEhRmkOFiVxXuWczhQhgfTEktTs1NSC1CKYLBMHp1QDk/v9BTypBVaS2tGZK/jSZG518db9
	S5GIP2sVMylkW9Jf+YalW1QOeQcvqssznb5kDSMna+Fi5ymuYSufP1GPlDwtvzTI9mDk1Znb
	+LZGB9qLPE7IY0qoCpnW8bhbsPKB8Jpv624lbvtUFCdqY68iZdnFceLHElnLn9OzOK0a1l1f
	/qDqnNGRLK7Lrn0eLDVb874rxjx5onztq1BR8CTelQIPPzBmLrLcfe7Ww2ydlJBNPhNbAiqk
	bn0OPCwyV+fRWvmOU4uiHL6a+yr3TuxbZ/mEsWbpvw0PLuTYPeyKnKN+OXbCUbWExUJau7f+
	mM7pcF7s9sqJsoY3V1yZ+KVfsvTg7f1nYrdfazf+ObdEXYmlOCPRUIu5qDgRALCTbDhMAwAA
X-CMS-MailID: 20250301053324epcas2p34b58ddc8f1a6eb4622b34402d817ab26
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----souVHaJ2v40ysJO-goJgDtKdm5PFoGmT3TNK2tOxyR5.xT_N=_16a425_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250120001504epcas2p1d766c193256b4b7f79d19f61d76d697d
References: <CANn89iKms_9EX+wArf1FK7Cy3-Cr_ryX+MJ2YC8yt1xmvpY=Uw@mail.gmail.com>
	<009e01db4620$f08f42e0$d1adc8a0$@samsung.com>
	<CADVnQykPo35mQ1y16WD3zppENCeOi+2Ea_2m-AjUQVPc9SXm4g@mail.gmail.com>
	<Z4nl0h1IZ5R/KDEc@perf>
	<CADVnQykZYT+CTWD3Ss46aGHPp5KtKMYqKjLxEmd5DDgdG3gfDA@mail.gmail.com>
	<CGME20250120001504epcas2p1d766c193256b4b7f79d19f61d76d697d@epcas2p1.samsung.com>
	<Z42WaFf9+oNkoBKJ@perf> <Z6BSXCRw/9Ne1eO1@perf>
	<CADVnQykpHsN1rPJobKVfFGwtAJ9qwPrwG21HiunHqfykxyPD1g@mail.gmail.com>
	<CADVnQymr=sst5foNOF7ydr-fUyAK6XLvRyNvnTVBV=wgPLpBBQ@mail.gmail.com>

------souVHaJ2v40ysJO-goJgDtKdm5PFoGmT3TNK2tOxyR5.xT_N=_16a425_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Tue, Feb 25, 2025 at 12:24:47PM -0500, Neal Cardwell wrote:
> On Mon, Feb 24, 2025 at 4:13 PM Neal Cardwell <ncardwell@google.com> wrote:
> >
> > On Mon, Feb 3, 2025 at 12:17 AM Youngmin Nam <youngmin.nam@samsung.com> wrote:
> > >
> > > > Hi Neal,
> > > > Thank you for looking into this issue.
> > > > When we first encountered this issue, we also suspected that tcp_write_queue_purge() was being called.
> > > > We can provide any information you would like to inspect.
> >
> > Thanks again for raising this issue, and providing all that data!
> >
> > I've come up with a reproducer for this issue, and an explanation for
> > why this has only been seen on Android so far, and a theory about a
> > related socket leak issue, and a proposed fix for the WARN and the
> > socket leak.
> >
> > Here is the scenario:
> >
> > + user process A has a socket in TCP_ESTABLISHED
> >
> > + user process A calls close(fd)
> >
> > + socket calls __tcp_close() and tcp_close_state() decides to enter
> > TCP_FIN_WAIT1 and send a FIN
> >
> > + FIN is lost and retransmitted, making the state:
> > ---
> >  tp->packets_out = 1
> >  tp->sacked_out = 0
> >  tp->lost_out = 1
> >  tp->retrans_out = 1
> > ---
> >
> > + someone invokes "ss" to --kill the socket using the functionality in
> > (1e64e298b8 "net: diag: Support destroying TCP sockets")
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c1e64e298b8cad309091b95d8436a0255c84f54a
> >
> >  (note: this was added for Android, so would not be surprising to have
> > this inet_diag --kill run on Android)
> >
> > + the ss --kill causes a call to tcp_abort()
> >
> > + tcp_abort() calls tcp_write_queue_purge()
> >
> > + tcp_write_queue_purge() sets packets_out=0 but leaves lost_out=1,
> > retrans_out=1
> >
> > + tcp_sock still exists in TCP_FIN_WAIT1 but now with an inconsistent state
> >
> > + ACK arrives and causes a WARN_ON from tcp_verify_left_out():
> >
> > #define tcp_verify_left_out(tp) WARN_ON(tcp_left_out(tp) > tp->packets_out)
> >
> > because the state has:
> >
> >  ---
> >  tcp_left_out(tp) = sacked_out + lost_out = 1
> >   tp->packets_out = 0
> > ---
> >
> > because the state is:
> >
> > ---
> >  tp->packets_out = 0
> >  tp->sacked_out = 0
> >  tp->lost_out = 1
> >  tp->retrans_out = 1
> > ---
> >
> > I guess perhaps one fix would be to just have tcp_write_queue_purge()
> > zero out those other fields:
> >
> > ---
> >  tp->sacked_out = 0
> >  tp->lost_out = 0
> >  tp->retrans_out = 0
> > ---
> >
> > However, there is a related and worse problem. Because this killed
> > socket has tp->packets_out, the next time the RTO timer fires,
> > tcp_retransmit_timer() notices !tp->packets_out is true, so it short
> > circuits and returns without setting another RTO timer or checking to
> > see if the socket should be deleted. So the tcp_sock is now sitting in
> > memory with no timer set to delete it. So we could leak a socket this
> > way. So AFAICT to fix this socket leak problem, perhaps we want a
> > patch like the following (not tested yet), so that we delete all
> > killed sockets immediately, whether they are SOCK_DEAD (orphans for
> > which the user already called close() or not) :
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 28cf19317b6c2..a266078b8ec8c 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -5563,15 +5563,12 @@ int tcp_abort(struct sock *sk, int err)
> >         local_bh_disable();
> >         bh_lock_sock(sk);
> >
> > -       if (!sock_flag(sk, SOCK_DEAD)) {
> > -               if (tcp_need_reset(sk->sk_state))
> > -                       tcp_send_active_reset(sk, GFP_ATOMIC);
> > -               tcp_done_with_error(sk, err);
> > -       }
> > +       if (tcp_need_reset(sk->sk_state))
> > +               tcp_send_active_reset(sk, GFP_ATOMIC);
> > +       tcp_done_with_error(sk, err);
> >
> >         bh_unlock_sock(sk);
> >         local_bh_enable();
> > -       tcp_write_queue_purge(sk);
> >         release_sock(sk);
> >         return 0;
> >  }
> > ---
> 
> Actually, it seems like a similar fix was already merged into Linux v6.11:
> 
> bac76cf89816b tcp: fix forever orphan socket caused by tcp_abort
> 
> Details below.
> 
> Youngmin, does your kernel have this bac76cf89816b fix? If not, can
> you please cherry-pick this fix and retest?
> 
> Thanks!
> neal

Hi Neal.

Thank you for your effort in debugging this issue with me.
I also appreciate your detailed explanation and for finding the patch related to the issue.

Our kernel(an Android kernel based on 6.6 LTS) does not have the patch you mentioned.(bac76cf89816b)

I'll let you know the test results after applying the patch.

Thank you.

> 
> ps: details for bac76cf89816b:
> 
> commit bac76cf89816bff06c4ec2f3df97dc34e150a1c4
> Author: Xueming Feng <kuro@kuroa.me>
> Date:   Mon Aug 26 18:23:27 2024 +0800
> 
>     tcp: fix forever orphan socket caused by tcp_abort
> 
>     We have some problem closing zero-window fin-wait-1 tcp sockets in our
>     environment. This patch come from the investigation.
> 
>     Previously tcp_abort only sends out reset and calls tcp_done when the
>     socket is not SOCK_DEAD, aka orphan. For orphan socket, it will only
>     purging the write queue, but not close the socket and left it to the
>     timer.
> 
>     While purging the write queue, tp->packets_out and sk->sk_write_queue
>     is cleared along the way. However tcp_retransmit_timer have early
>     return based on !tp->packets_out and tcp_probe_timer have early
>     return based on !sk->sk_write_queue.
> 
>     This caused ICSK_TIME_RETRANS and ICSK_TIME_PROBE0 not being resched
>     and socket not being killed by the timers, converting a zero-windowed
>     orphan into a forever orphan.
> 
>     This patch removes the SOCK_DEAD check in tcp_abort, making it send
>     reset to peer and close the socket accordingly. Preventing the
>     timer-less orphan from happening.
> 
>     According to Lorenzo's email in the v1 thread, the check was there to
>     prevent force-closing the same socket twice. That situation is handled
>     by testing for TCP_CLOSE inside lock, and returning -ENOENT if it is
>     already closed.
> 
>     The -ENOENT code comes from the associate patch Lorenzo made for
>     iproute2-ss; link attached below, which also conform to RFC 9293.
> 
>     At the end of the patch, tcp_write_queue_purge(sk) is removed because it
>     was already called in tcp_done_with_error().
> 
>     p.s. This is the same patch with v2. Resent due to mis-labeled "changes
>     requested" on patchwork.kernel.org.
> 
>     Link: https://protect2.fireeye.com/v1/url?k=544c1d82-0bd7257f-544d96cd-000babff317b-bdb81ce9ab3ea266&q=1&e=a6f04ac5-af96-4431-b73d-76d141ecd941&u=https%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Fnetdev%2Fpatch%2F1450773094-7978-3-git-send-email-lorenzo%40google.com%2F
>     Fixes: c1e64e298b8c ("net: diag: Support destroying TCP sockets.")
>     Signed-off-by: Xueming Feng <kuro@kuroa.me>
>     Tested-by: Lorenzo Colitti <lorenzo@google.com>
>     Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
>     Reviewed-by: Eric Dumazet <edumazet@google.com>
>     Link: https://protect2.fireeye.com/v1/url?k=4a9f6303-15045bfe-4a9ee84c-000babff317b-4ccbbea72f6265df&q=1&e=a6f04ac5-af96-4431-b73d-76d141ecd941&u=https%3A%2F%2Fpatch.msgid.link%2F20240826102327.1461482-1-kuro%40kuroa.me
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index e03a342c9162b..831a18dc7aa6d 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4637,6 +4637,13 @@ int tcp_abort(struct sock *sk, int err)
>                 /* Don't race with userspace socket closes such as tcp_close. */
>                 lock_sock(sk);
> 
> +       /* Avoid closing the same socket twice. */
> +       if (sk->sk_state == TCP_CLOSE) {
> +               if (!has_current_bpf_ctx())
> +                       release_sock(sk);
> +               return -ENOENT;
> +       }
> +
>         if (sk->sk_state == TCP_LISTEN) {
>                 tcp_set_state(sk, TCP_CLOSE);
>                 inet_csk_listen_stop(sk);
> @@ -4646,16 +4653,13 @@ int tcp_abort(struct sock *sk, int err)
>         local_bh_disable();
>         bh_lock_sock(sk);
> 
> -       if (!sock_flag(sk, SOCK_DEAD)) {
> -               if (tcp_need_reset(sk->sk_state))
> -                       tcp_send_active_reset(sk, GFP_ATOMIC,
> -                                             SK_RST_REASON_NOT_SPECIFIED);
> -               tcp_done_with_error(sk, err);
> -       }
> +       if (tcp_need_reset(sk->sk_state))
> +               tcp_send_active_reset(sk, GFP_ATOMIC,
> +                                     SK_RST_REASON_NOT_SPECIFIED);
> +       tcp_done_with_error(sk, err);
> 
>         bh_unlock_sock(sk);
>         local_bh_enable();
> -       tcp_write_queue_purge(sk);
>         if (!has_current_bpf_ctx())
>                 release_sock(sk);
>         return 0;
> 

------souVHaJ2v40ysJO-goJgDtKdm5PFoGmT3TNK2tOxyR5.xT_N=_16a425_
Content-Type: text/plain; charset="utf-8"


------souVHaJ2v40ysJO-goJgDtKdm5PFoGmT3TNK2tOxyR5.xT_N=_16a425_--

