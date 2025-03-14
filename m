Return-Path: <netdev+bounces-174796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CBEA60799
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 03:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B94119C4C7E
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 02:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A1643169;
	Fri, 14 Mar 2025 02:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EQNhBkng"
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DBC2E3379
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 02:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741920353; cv=none; b=F6+230NUb4dOkYhFfEobxzukk7rxf4g1PpwzupHlb8e+gsfChFQbha5L3jtDETdIhoTqP6jHuuVog6YV3ysVkYYDgqo3Up9PxU5+AWBhx1P7H8fMnXC3BlCAeQHCHoiA804OBcz5tHtWfi83KvsP9lPibVwZuPvOovd1wkAeaYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741920353; c=relaxed/simple;
	bh=ziJruGjMI0GA4eymHWA8v/F48RLTPRiahyI8/UJGQ3w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=lCOJYP6D8sGm/Gw4v6TG6vAfZ1qNQLE/yUYwnFdl48ylTZ59d6TaPaRf4lfG2ow3LnWpPZUCiuDynu+tqZeQH1oj1na2G9WfdJicg5y/SS/Fr1VTWUFJgMNZs6hFdJLwgTh2qlSUlT/PJg3GeaaDPsEM2aupPyV8zByq/GR1CNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EQNhBkng; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250314024547epoutp032b8d16806a4e3c6cdd80de87baa0e8c9~si1O9HAR32672026720epoutp03X
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 02:45:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250314024547epoutp032b8d16806a4e3c6cdd80de87baa0e8c9~si1O9HAR32672026720epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741920347;
	bh=2fQnOpR9cCRSIu8ZWpB8PZJwa+Sv/G9ybgLzo4FmFMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EQNhBkngB/Z2KN6xscRg48Cpe1JlyJThi10DxZlkdiwe+RjRul7XYybkrHKJCg5eD
	 XCiU6AwKeRSGsnZZjz7P+ZnEwczOX99XGXCYJnneCvcm7O+2bYt1p171fFtyQqzLPp
	 4wn5L3NQMTWGyh1gg5rMGNpjCYJo62d4rs+F27Pg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20250314024542epcas2p3c9dfa3fba2cc4e352b2227ff9855f67d~si1KWuKuu2636126361epcas2p3G;
	Fri, 14 Mar 2025 02:45:42 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.69]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4ZDTJ60VXfz4x9Py; Fri, 14 Mar
	2025 02:45:42 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	7C.C3.23368.55893D76; Fri, 14 Mar 2025 11:45:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20250314024541epcas2p4e2c2a3477cce44495c9df098eb6fde9e~si1JUwANy1721217212epcas2p43;
	Fri, 14 Mar 2025 02:45:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250314024541epsmtrp1e681038ce3bdbddffa1c101c892b2905~si1JThh5-3173131731epsmtrp1o;
	Fri, 14 Mar 2025 02:45:41 +0000 (GMT)
X-AuditID: b6c32a45-dc9f070000005b48-7e-67d398553655
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	54.5E.18729.55893D76; Fri, 14 Mar 2025 11:45:41 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250314024541epsmtip2b79e900afffc7caa7cac857f6c89c4e5~si1I_pJL32412924129epsmtip2m;
	Fri, 14 Mar 2025 02:45:41 +0000 (GMT)
Date: Fri, 14 Mar 2025 11:49:47 +0900
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
Message-ID: <Z9OZS/hc+v5og6/U@perf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z8KcXQhdRId1S6w8@perf>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzm9F56C1vZXXmddIR11TplA9sO6AHpZpRhF10EN7O4ZGJDL4VR
	2q63NTxMRKhIQQqCE0GyFdiGsg0NQ8YQlBQjMOZACSMQHxMRZIDj7cakW8vFhf++3/f7vnO+
	33lwMN4Um89J1hopg1apEbI98aaOLSh4/9l+tfjebCRaaL9NoN/aThGosteMo/qW4yw0ZjuL
	o0c3RghUehqg7Gu3MTRS1MVGA1eeYKivyeqO7B3jBOpvqWSjpbYpAuXdacPRDZsfWuqZAuj4
	w3kCnfh7EkcLDwfYaLYzm0A17XMEyqmqx7f7KxovDLEUtgaToqHOwlbYrITiz6sDbIW1sQ4o
	5hsCY4mPU6KSKKWKMggobYJOlaxVy4W7P4jfGR8WLpYESyKQTCjQKlMpuTB6T2xwTLLGOZxQ
	cFipMTmpWCVNC7e+HWXQmYyUIElHG+VCSq/S6GX6EFqZSpu06hAtZYyUiMXSMKfwUErS7NNP
	9K2StKlHZUQWcIjygQcHkqFwxHKZnQ88OTyyGUDzcAnBFHMAXsvNXussAVg7PcJ6brFW57KY
	RhuAPZasNcsDAMtaVwiXCidFcLFnGXdhNhkMm7ocwIV9yM3wbvXvwGXAyEEcTg7POAsOx5vc
	CVfuyF0aLrkBFjy+gDP4ZdhdPrqKPciNcHnxPubyQjLHA5q/uwqYSNHwWWerO4O94R+djQSD
	+XCiKHcN0zDr/vCa2Qzgz4OPMabxFqwYO7G6EEaqYe8XE6uBoDPF9WGcob1gXodrMBfNhXm5
	PMa5CS6fvrQWIQBeqTmPMRIFnC9UMWdShMPx7CVWMQisWDdOxbrNKpwWjNwCL7ZsZehXYc7l
	cxhDvwJrHZx1Chtg1wE/Sk+nqilaqpf8f9cJutQGsPrsg95tBqXTMyF2wOIAO4AcTOjD/Vbe
	p+ZxVcr0DMqgizeYNBRtB2HOazqF8X0TdM5/ozXGS0IjxKHh4RKZNEwsE/pzM5vNah6pVhqp
	FIrSU4bnPhbHg5/FunmGpp5s27t7z1fS0WLbg/IjCwUFgy/d+8FfnpFbeVPhVy665BY9HndM
	7s7r/dCyuK8y4N9zjszrEtnRnr8m8i3vHMxPqwKvZ1j60S/GicTG/Mk53+nSCLDpJ+PEGXaU
	u8gW19186I0h6+EDNaOl2qqmj6IHs038u4le427fey/lhGz/Mqgu76JbkCbzBUEZKjnZVtxa
	MqNqvxV30LR50Sy1B4S/Zq3e9WLgm0OJv3YVNH/zXoy98WuRtLQvpunZgU85G0WR58d80nXT
	T3etdBful/H2+rrVepQ7jtZUFB4pqv/MEzeg9/tydvwj2JbAT4usztjXwEosuzVaueHz9B93
	eB1zCHE6SSkJwgy08j9tP6w8fwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7bCSvG7ojMvpBvc2SVp8OXCJ3eLa3ons
	FnPOt7BYrNvVymTxbMEMFounxx6xW0yewmjRtP8Ss8Wj/hNsFld3v2O2uLCtj9Xi0OHn7BaX
	d81hs/i29w27RcedvSwWxxaIWXw7/YbRovXxZ3aL9p+vWSy+PL7KZvHxeBO7xeIDn9gtmheu
	Y3EQ99iy8iaTx4JNpR6bVnWyeSzoY/d4v+8qm0ffllWMHp83yQWwR3HZpKTmZJalFunbJXBl
	XJz1ib3goV7F4kMPWBsY9yt3MXJySAiYSPQtamPqYuTiEBLYzSixctkDZoiEjMTtlZdZIWxh
	ifstR1ghiu4zSryc95YRJMEioCrx9fQvFhCbTUBXYtuJf2BxEQENibuLHjCCNDAL3GaR2HDg
	NtBUDg5hAWeJv3dsQWp4BZQlul+sZIEYOpFF4kPTW3aIhKDEyZlPwIYyC6hL/Jl3CayXWUBa
	Yvk/DoiwvETz1tlgh3IKqEj8+nqfeQKj4Cwk3bOQdM9C6J6FpHsBI8sqRsnUguLc9NxiwwLD
	vNRyveLE3OLSvHS95PzcTYzgSNbS3MG4fdUHvUOMTByMhxglOJiVRHhX215IF+JNSaysSi3K
	jy8qzUktPsQozcGiJM4r/qI3RUggPbEkNTs1tSC1CCbLxMEp1cC046GbXPqmLRVLL87iWWGd
	d0v69Z9tj7Zu0HvCohAjbephwXLgL9+79RHrtV6Lve38zrXX6EPeV5GfRloixzLrfKZ1z9kR
	xC2zwuhL9sXK2J6N4hMCVy3cdYH3vu6D/ownL17xHnPcdGle3oOcac49uclbd5kdX3VtqaNJ
	ZMbtxeFv7337WW5YV+rjE5AvuGHeU2Y/d3Hn6PatS0XzF5VLtKqfve3LtsXgd3T7BtMmuZOK
	8qY/vk7euvaop1yl/dmPt7aenigjdsL5U/D2M1lLu79uT70nGbHujfNC1+dcZy1djAMTmfnt
	q7fNXdqRqvvnkugzr+ZTp/V7P0nc+NhZKfdGJPdZvxSn1sQriYfjlViKMxINtZiLihMByR5a
	dVMDAAA=
X-CMS-MailID: 20250314024541epcas2p4e2c2a3477cce44495c9df098eb6fde9e
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----8zSljUDO-7Nv_mPFAu0GqydQxERUpglxPdU54vW1CIyD1lhE=_7c9b_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250120001504epcas2p1d766c193256b4b7f79d19f61d76d697d
References: <009e01db4620$f08f42e0$d1adc8a0$@samsung.com>
	<CADVnQykPo35mQ1y16WD3zppENCeOi+2Ea_2m-AjUQVPc9SXm4g@mail.gmail.com>
	<Z4nl0h1IZ5R/KDEc@perf>
	<CADVnQykZYT+CTWD3Ss46aGHPp5KtKMYqKjLxEmd5DDgdG3gfDA@mail.gmail.com>
	<CGME20250120001504epcas2p1d766c193256b4b7f79d19f61d76d697d@epcas2p1.samsung.com>
	<Z42WaFf9+oNkoBKJ@perf> <Z6BSXCRw/9Ne1eO1@perf>
	<CADVnQykpHsN1rPJobKVfFGwtAJ9qwPrwG21HiunHqfykxyPD1g@mail.gmail.com>
	<CADVnQymr=sst5foNOF7ydr-fUyAK6XLvRyNvnTVBV=wgPLpBBQ@mail.gmail.com>
	<Z8KcXQhdRId1S6w8@perf>

------8zSljUDO-7Nv_mPFAu0GqydQxERUpglxPdU54vW1CIyD1lhE=_7c9b_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Sat, Mar 01, 2025 at 02:37:23PM +0900, Youngmin Nam wrote:
> On Tue, Feb 25, 2025 at 12:24:47PM -0500, Neal Cardwell wrote:
> > On Mon, Feb 24, 2025 at 4:13 PM Neal Cardwell <ncardwell@google.com> wrote:
> > >
> > > On Mon, Feb 3, 2025 at 12:17 AM Youngmin Nam <youngmin.nam@samsung.com> wrote:
> > > >
> > > > > Hi Neal,
> > > > > Thank you for looking into this issue.
> > > > > When we first encountered this issue, we also suspected that tcp_write_queue_purge() was being called.
> > > > > We can provide any information you would like to inspect.
> > >
> > > Thanks again for raising this issue, and providing all that data!
> > >
> > > I've come up with a reproducer for this issue, and an explanation for
> > > why this has only been seen on Android so far, and a theory about a
> > > related socket leak issue, and a proposed fix for the WARN and the
> > > socket leak.
> > >
> > > Here is the scenario:
> > >
> > > + user process A has a socket in TCP_ESTABLISHED
> > >
> > > + user process A calls close(fd)
> > >
> > > + socket calls __tcp_close() and tcp_close_state() decides to enter
> > > TCP_FIN_WAIT1 and send a FIN
> > >
> > > + FIN is lost and retransmitted, making the state:
> > > ---
> > >  tp->packets_out = 1
> > >  tp->sacked_out = 0
> > >  tp->lost_out = 1
> > >  tp->retrans_out = 1
> > > ---
> > >
> > > + someone invokes "ss" to --kill the socket using the functionality in
> > > (1e64e298b8 "net: diag: Support destroying TCP sockets")
> > >
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c1e64e298b8cad309091b95d8436a0255c84f54a
> > >
> > >  (note: this was added for Android, so would not be surprising to have
> > > this inet_diag --kill run on Android)
> > >
> > > + the ss --kill causes a call to tcp_abort()
> > >
> > > + tcp_abort() calls tcp_write_queue_purge()
> > >
> > > + tcp_write_queue_purge() sets packets_out=0 but leaves lost_out=1,
> > > retrans_out=1
> > >
> > > + tcp_sock still exists in TCP_FIN_WAIT1 but now with an inconsistent state
> > >
> > > + ACK arrives and causes a WARN_ON from tcp_verify_left_out():
> > >
> > > #define tcp_verify_left_out(tp) WARN_ON(tcp_left_out(tp) > tp->packets_out)
> > >
> > > because the state has:
> > >
> > >  ---
> > >  tcp_left_out(tp) = sacked_out + lost_out = 1
> > >   tp->packets_out = 0
> > > ---
> > >
> > > because the state is:
> > >
> > > ---
> > >  tp->packets_out = 0
> > >  tp->sacked_out = 0
> > >  tp->lost_out = 1
> > >  tp->retrans_out = 1
> > > ---
> > >
> > > I guess perhaps one fix would be to just have tcp_write_queue_purge()
> > > zero out those other fields:
> > >
> > > ---
> > >  tp->sacked_out = 0
> > >  tp->lost_out = 0
> > >  tp->retrans_out = 0
> > > ---
> > >
> > > However, there is a related and worse problem. Because this killed
> > > socket has tp->packets_out, the next time the RTO timer fires,
> > > tcp_retransmit_timer() notices !tp->packets_out is true, so it short
> > > circuits and returns without setting another RTO timer or checking to
> > > see if the socket should be deleted. So the tcp_sock is now sitting in
> > > memory with no timer set to delete it. So we could leak a socket this
> > > way. So AFAICT to fix this socket leak problem, perhaps we want a
> > > patch like the following (not tested yet), so that we delete all
> > > killed sockets immediately, whether they are SOCK_DEAD (orphans for
> > > which the user already called close() or not) :
> > >
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > index 28cf19317b6c2..a266078b8ec8c 100644
> > > --- a/net/ipv4/tcp.c
> > > +++ b/net/ipv4/tcp.c
> > > @@ -5563,15 +5563,12 @@ int tcp_abort(struct sock *sk, int err)
> > >         local_bh_disable();
> > >         bh_lock_sock(sk);
> > >
> > > -       if (!sock_flag(sk, SOCK_DEAD)) {
> > > -               if (tcp_need_reset(sk->sk_state))
> > > -                       tcp_send_active_reset(sk, GFP_ATOMIC);
> > > -               tcp_done_with_error(sk, err);
> > > -       }
> > > +       if (tcp_need_reset(sk->sk_state))
> > > +               tcp_send_active_reset(sk, GFP_ATOMIC);
> > > +       tcp_done_with_error(sk, err);
> > >
> > >         bh_unlock_sock(sk);
> > >         local_bh_enable();
> > > -       tcp_write_queue_purge(sk);
> > >         release_sock(sk);
> > >         return 0;
> > >  }
> > > ---
> > 
> > Actually, it seems like a similar fix was already merged into Linux v6.11:
> > 
> > bac76cf89816b tcp: fix forever orphan socket caused by tcp_abort
> > 
> > Details below.
> > 
> > Youngmin, does your kernel have this bac76cf89816b fix? If not, can
> > you please cherry-pick this fix and retest?
> > 
> > Thanks!
> > neal
> 
> Hi Neal.
> 
> Thank you for your effort in debugging this issue with me.
> I also appreciate your detailed explanation and for finding the patch related to the issue.
> 
> Our kernel(an Android kernel based on 6.6 LTS) does not have the patch you mentioned.(bac76cf89816b)
> 
> I'll let you know the test results after applying the patch.
> 
> Thank you.
> 

Hi Neal.

There were confilcts when I cherry-picked the patch
"bac76cf89816b tcp: fix forever orphan socket caused by tcp_abort"
and it also has a dependency.

I believe we need a total of two patches,
which exist in the latest upstream for 6.6 LTS and earlier LTS trees.

5ce4645c23cf tcp: fix races in tcp_abort()
bac76cf89816 tcp: fix forever orphan socket caused by tcp_abort

So, I uploaded CLs for this to android kernel gerrit.

https://android-review.googlesource.com/c/kernel/common/+/3530435 BACKPORT: tcp: fix races in tcp_abort()
https://android-review.googlesource.com/c/kernel/common/+/3530436 BACKPORT: tcp: fix forever orphan socket caused by tcp_abort

After applying these patches, we conducted a total of three rounds of testing with 200 devices,
and all tests passed.

Thanks.

------8zSljUDO-7Nv_mPFAu0GqydQxERUpglxPdU54vW1CIyD1lhE=_7c9b_
Content-Type: text/plain; charset="utf-8"


------8zSljUDO-7Nv_mPFAu0GqydQxERUpglxPdU54vW1CIyD1lhE=_7c9b_--

