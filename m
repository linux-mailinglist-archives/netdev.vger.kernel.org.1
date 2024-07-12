Return-Path: <netdev+bounces-111168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2135993026B
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 01:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 793ACB21C33
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 23:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376D461FE0;
	Fri, 12 Jul 2024 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="ICf5jtyA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="moVLrHlv"
X-Original-To: netdev@vger.kernel.org
Received: from flow8-smtp.messagingengine.com (flow8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D4D1BC20
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720827293; cv=none; b=j2Wce0TsOi0+O1Z4xqEZTZbbroKxRyZYF3VgOn17Lirp5ofxs0j7Re4QLzcvQgn7iqA/Xz8LLxFQpq/EDFJKPiNsp0pliwm+1CSsFifYB+y96xC5dWlFDxsT9F+2T4vSSUea6chGUseq/EWf9hLN6CG357V+zP5f6VaV+mUC+cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720827293; c=relaxed/simple;
	bh=nkm3IAjC6zpRvBOnIORF0Ufuam/KPeYNJshCAt0QbtI=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=gyL+C9UoAGzXGY+tZHkkDbQoH1iVUL7V58o411kf6W2OTgXu/5P1LE8Xeq1jJ2jzDk+RgXof4YV+4KvTZz8VkK6r7M/aHyxNIQ/e4ZHGKY/W+HhLxN6k+FVLCOZ2ckO73DnPKVBz6iEQTGi2JZMa0I4/htDUfXuSP28CeetyiPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=ICf5jtyA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=moVLrHlv; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailflow.nyi.internal (Postfix) with ESMTP id 4558320046C;
	Fri, 12 Jul 2024 19:34:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 12 Jul 2024 19:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1720827289; x=1720830889; bh=K5R34j4yyVy3qF7Hi9RR5
	5J9NYRarozZMJGeC5voexs=; b=ICf5jtyAeo2BDe7CS9PlV8xpuM1J8HHeFuPPh
	dx+cRZliqWtZGxFnQ4/wvbpO1y2Do5ZyCD3jfGdhfOGTNzdIoATt3rClpHNzZ5Xb
	MhnvxVZTt3hr0hKTCSam0ukGkWshpxGJBbMOOtswvFd1wANDH7HZ9P4ExmocVtzL
	C3FqW6LvK6kIKpucaeZnabicqnFDg8rTcIDjQj6ZmBz6bBrMyAO3vP2DYOYRYqWV
	fKMgt6pUK+ewOzdOH6ob9IgJeY972yK4pJS1ifnxbKNKppZdg+gpviIbxtzAvIgx
	oH9nRcBlVR2f/hxrUZGaiWQ8YF5Txlq+mNE8QPK0oEYJPMTXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720827289; x=1720830889; bh=K5R34j4yyVy3qF7Hi9RR55J9NYRa
	rozZMJGeC5voexs=; b=moVLrHlvSkw/iKR+v+nkhQthfsVj85UyOQC1RnkrusQl
	QCXUHRIt6V4ndfGPA5G3fS2Fr/eIr4Md1bcmRQSeyEtOzie4nertjbBqjdS0pNyd
	1AaSPeqBg/Ah3ovRBvVU4KNmvSL0HDLlfKuD88a+GnEkXVKzEBIVzXLD53f9ZAls
	WyV3sp+zbnC+KDiL+DgdxVo3XxLZZMg5KXCisDsYrNeqZtBIIdxaLRkqSX19fhKd
	BpwpQ98w9ivYf563Vlw0Qbq3kU6swqb1SJpm9OXGYsBSTr/LmKri//T1kXkuQk8q
	1TUzcLbb6bHOWB3D/VPXFhmFuH0ArRAIHn9wQ62K2A==
X-ME-Sender: <xms:l72RZsGLJi45iuGedpN3IFmuiS9u0Sasz-oPNOUBlyvsAdPHY2OWgQ>
    <xme:l72RZlUD28NorocjtGLi0NBoFawtuHC-Md2bzd0alS-WktjYOpTFjbhHgMqXmrjSN
    dTsvtF06VWo5XHpIcM>
X-ME-Received: <xmr:l72RZmIh--j26nnI1GEmG7HUJZSFf1jYNzjBmOLce-OrHTeqXcxk53E8tYG53lZdbc3eIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeejgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujghfofggtgfgfffksehtqh
    ertdertddvnecuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghu
    rhhghhdrnhgvtheqnecuggftrfgrthhtvghrnhepieefvdelfeeljeevtefhfeeiudeuie
    dvfeeiveelffduvdevfedtheffffetfeffnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvght
X-ME-Proxy: <xmx:l72RZuGuJtoKSuMAf3owxHRSKixQiJIzAmXJFPFWZID57cc9hrnxpQ>
    <xmx:l72RZiVgRjU01Uua841OE2s1tmg-swtHasQEII3U30BeOaS-MZqQGg>
    <xmx:l72RZhPKWiIZjYqmoxz-454z4StSFJwa2nWCo7uBgl1E_wtTyqRQqQ>
    <xmx:l72RZp2tVmi3Tbigb2w7dMcRVFr4z0GuMe1SahiWMM7wFC2EQkAhDw>
    <xmx:mL2RZrXGT4iGXQaE9nrsoUo4OL8ANE_IMp0d4Wlk6nA7Or59QCmKaO0d>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jul 2024 19:34:47 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 9C5489FC9C; Fri, 12 Jul 2024 16:34:46 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 98D979FB9E;
	Fri, 12 Jul 2024 16:34:46 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Nick Child <nnac123@linux.ibm.com>
cc: netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next 0/1] bonding: Return TX congested if no
 active slave
In-reply-to: <20240712192405.505553-1-nnac123@linux.ibm.com>
References: <20240712192405.505553-1-nnac123@linux.ibm.com>
Comments: In-reply-to Nick Child <nnac123@linux.ibm.com>
   message dated "Fri, 12 Jul 2024 14:24:04 -0500."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2245991.1720827286.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jul 2024 16:34:46 -0700
Message-ID: <2245992.1720827286@famine>

Nick Child <nnac123@linux.ibm.com> wrote:

>Hello. Posting this as RFC because I understand that changing return
>codes can have unexpected results and I am not well versed enough to
>claim with certainty that this won't affect something elsewhere.
>
>We are seeing a rare TCP connection timeout after only ~7.5 seconds of
>inactivity. This is mainly due to the ibmvnic driver hogging the RTNL
>lock for too long (~2 seconds per ibmvnic device). We are working on
>getting the driver off the RTNL lock but figured the core of the issue
>should also be considered.
>
>Because most of this is new ground to me, I listed the background
>knowledge that is needed to identify the issue. Feel free to skip this
>part:
>
>1. During a zero window probe, the socket attempts to get an updated
>window from the peer 15 times (default of tcp_retries2). Looking at
>tcp_send_probe0(), the timer between probes is either doubled or 0.5
>seconds. The timer is doubled if the skb transmit returns
>NET_XMIT_SUCCESS or NET_XMIT_CN (see net_xmit_eval()). Note that the
>timer is set to a static 0.5 if NET_XMIT_DROP is returned. This means
>the socket can ETIMEOUT after 7.5 seconds. The return code is typically
>the return code of __dev_queue_xmit()

	I'm not sure that your description of the behavior of
tcp_send_probe0() matches the code.

	It looks to me like the timer doubles for "if (err <=3D 0)",
meaning a negative value or NET_XMIT_SUCCESS.  The 0.5 timeout value (in
TCP_RESOURCE_PROBE_INTERVAL) is set in the "else" after "if (err <=3D 0)",
so NET_XMIT_DROP and NET_XMIT_CN both qualify and would presumably
result in the 0.5 second timeout.

	However, since tcp_write_wakeup() -> tcp_transmit_skb() ->
__tcp_transmit_skb() will convert NET_XMIT_CN to 0 (which is
NET_XMIT_SUCCESS) via net_xmit_eval(), I'm not sure that it's possible
for err to equal NET_XMIT_CN here.

	I'll note that the 0.5 second timeout logic had a relatively
recent change in c1d5674f8313 ("tcp: less aggressive window probing on
local congestion").  From reading the log, the intent seems to be to
bound the maximum probe interval to 0.5 seconds in low-RTT environments.

>2. In __dev_queue_xmit(), the skb is enqueued to the qdisc if the
>enqueue function is defined. In this circumstance, the qdisc enqueue
>function return code propagates up the stack. On the other hand, if the
>qdisc enqueue function is NULL then the drivers xmit function is called
>directly via dev_hard_start_xmit(). In this circumstance, the drivers
>xmit return code propagates up the stack.
>
>3. The bonding device uses IFF_NO_QUEUE, this sets qdisc to
>noqueue_qdisc_ops. noqueue_qdisc_ops has NULL enqueue
>function. Therefore, when the bonding device is carrier UP,
>bond_start_xmit is called directly. In this function, depending on
>bonding mode, a slave device is assigned to the skb and
>__dev_queue_xmit() is called again. This time the slaves qdisc enqueue
>function (which is almost always defined) is called.

	Does your analysis or behavior change if the bond itself does
have a qdisc?  IFF_NO_QUEUE does not install one by default, but users
are free to add one.

>4. When a device calls netif_carrier_off(), it schedules dev_deactivate
>which grabs the rtnl lock and sets the qdisc to noop_qdisc. The enqueue
>function of noop_qdisc is defined but simply returns NET_XMIT_CN.
>
>5. The miimon of the bonding device periodically checks for the carrier
>status of its slaves. If it detects that all of its slaves are down,
>then it sets currently_active_slave to NULL and calls
>netif_carrier_off() on itself.
>
>6. In the bonding devices xmit function, if it does not have any active
>slaves, it returns NET_XMIT_DROP.
>
>Given these observations. Assume a bonding devices slaves all suddenly
>call netif_carrier_off(). Also assume that a tcp connection is in a zero
>window probe. There is a window for a behavioral issue here:

>1. If the bonding device does not notice that its slaves are down
>(maybe its miimon interval is too large or the miimon commit could not
>grab rtnl), then the slaves enqueue function is invoked. This will
>either return NET_XMIT_SUCCESS OR NET_XMIT_CN. The probe timer is
>doubled.

	As I mentioned above, I'm not sure this accurately describes the
behavior in tcp_send_probe0().

	-J

>2. If the bonding device notices the slaves are down. It sets active
>slave to NULL and calls netif_carrier_off() on itself. dev_deactivate()
>is scheduled:
>
>    a. If dev_deactivate() executes. The bonding enqueue function
>(which was null) is now noop_enqueue and returns NET_XMIT_CN. The probe
>timer is doubled.
>
>    b. If dev_deactivate() cannot execute for some time (say because it
>is waiting on rtnl). Then bond_start_xmit() is called. It sees that it
>does not have an active slave and returns NET_XMIT_DROP. The probe
>timer is set to 0.5 seconds.
>
>I believe that when the active slave is NULL, it is safe to say that
>the bonding device calls netif_carrier_off() on itself. But there is a
>time where active_slave =3D=3D NULL and the qdisc.enqueue !=3D
>noop_enqueue. During this time the return code is different. Consider
>the following timeline:
>
>  slaves go down
>             |
>             |   returns NET_XMIT_CN
>             |
>     bond calls carrier_off
>             |
>             |   returns NET_XMIT_DROP
>             |
>       dev_deactivate on bond
>             |
>             |   returns NET_XMIT_CN
>             |
>
>Because the bonding xmit function should really only be a route to a
>slave device, I propose that it returns NET_XMIT_CN in these scenarios
>instead of NET_XMIT_DROP. Note that the bond will still return
>NET_XMIT_DROP when it has NO slaves. Since miimon calls
>netif_carrier_off() when it doesn't have any active slaves, I believe
>this change will only effect the time between the bonding devices call
>to netif_carrier_off() and the execution of dev_deactivate().
>
>I was able to see this issue with bpftrace:
>  10:28:27:283929 - dev_deactivate eth252
>  10:28:27:312805 - send_probe0 - port=3D8682 - snd_wnd 0, icsk_probes_ou=
t =3D 0+1
>  10:28:27:760016 - send_probe0 - port=3D8682 - snd_wnd 0, icsk_probes_ou=
t =3D 1+1
>  10:28:28:147410 - dev_deactivate eth251
>  10:28:28:348387 - dev_queue_xmit rc =3D 2
>  10:28:28:348394 - dev_queue_xmit rc =3D 2
>  10:28:28:670013 - send_probe0 - port=3D8682 - snd_wnd 0, icsk_probes_ou=
t =3D 2+1
>  10:28:28:670066 - dev_queue_xmit rc =3D 2
>  10:28:28:670070 - dev_queue_xmit rc =3D 2
>  10:28:30:440025 - send_probe0 - port=3D8682 - snd_wnd 0, icsk_probes_ou=
t =3D 3+1
>  10:28:30:440084 - dev_queue_xmit rc =3D 2
>  10:28:30:440088 - dev_queue_xmit rc =3D 2
>  10:28:33:505982 - netif_carrier_off bond1
>        netif_carrier_off+112
>        bond_set_carrier+296
>        bond_select_active_slave+296
>        bond_mii_monitor+1900
>        process_one_work+760
>        worker_thread+136
>        kthread+456
>        ret_from_kernel_thread+92
>  10:28:33:790050 - dev_queue_xmit rc =3D 1
>  10:28:33:870015 - send_probe0 - port=3D8682 - snd_wnd 0, icsk_probes_ou=
t =3D 4+1
>  10:28:33:870061 - dev_queue_xmit rc =3D 1
>  10:28:34:300269 - dev_queue_xmit rc =3D 1
>  10:28:34:380025 - send_probe0 - port=3D8682 - snd_wnd 0, icsk_probes_ou=
t =3D 5+1
>  10:28:34:380072 - dev_queue_xmit rc =3D 1
>  10:28:34:432446 - dev_queue_xmit rc =3D 1
>  10:28:34:810059 - dev_queue_xmit rc =3D 1
>  10:28:34:900014 - send_probe0 - port=3D8682 - snd_wnd 0, icsk_probes_ou=
t =3D 6+1
>  10:28:34:900059 - dev_queue_xmit rc =3D 1
>  10:28:35:000050 - dev_queue_xmit rc =3D 1
>  10:28:35:330054 - dev_queue_xmit rc =3D 1
>  10:28:35:410020 - send_probe0 - port=3D8682 - snd_wnd 0, icsk_probes_ou=
t =3D 7+1
>  10:28:35:410070 - dev_queue_xmit rc =3D 1
>  10:28:35:630865 - dev_queue_xmit rc =3D 1
>  10:28:35:850072 - dev_queue_xmit rc =3D 1
>  10:28:35:920025 - send_probe0 - port=3D8682 - snd_wnd 0, icsk_probes_ou=
t =3D 8+1
>  10:28:35:920069 - dev_queue_xmit rc =3D 1
>  10:28:35:940348 - dev_queue_xmit rc =3D 1
>  10:28:36:140055 - dev_queue_xmit rc =3D 1
>  10:28:36:370050 - dev_queue_xmit rc =3D 1
>  10:28:36:430029 - send_probe0 - port=3D8682 - snd_wnd 0, icsk_probes_ou=
t =3D 9+1
>  10:28:36:430089 - dev_queue_xmit rc =3D 1
>  10:28:36:460052 - dev_queue_xmit rc =3D 1
>  10:28:36:650049 - dev_queue_xmit rc =3D 1
>  10:28:36:880059 - dev_queue_xmit rc =3D 1
>  10:28:36:940024 - send_probe0 - port=3D8682 - snd_wnd 0, icsk_probes_ou=
t =3D 10+1
>  10:28:36:940074 - dev_queue_xmit rc =3D 1
>  10:28:36:980044 - dev_queue_xmit rc =3D 1
>  10:28:37:160331 - dev_queue_xmit rc =3D 1
>  10:28:37:390060 - dev_queue_xmit rc =3D 1
>  10:28:37:450024 - send_probe0 - port=3D8682 - snd_wnd 0, icsk_probes_ou=
t =3D 11+1
>  10:28:37:450082 - dev_queue_xmit rc =3D 1
>  10:28:37:480045 - dev_queue_xmit rc =3D 1
>  10:28:37:730281 - dev_queue_xmit rc =3D 1
>  10:28:37:900051 - dev_queue_xmit rc =3D 1
>  10:28:37:970019 - send_probe0 - port=3D8682 - snd_wnd 0, icsk_probes_ou=
t =3D 12+1
>  10:28:37:970062 - dev_queue_xmit rc =3D 1
>  10:28:38:000045 - dev_queue_xmit rc =3D 1
>  10:28:38:240089 - dev_queue_xmit rc =3D 1
>  10:28:38:420053 - dev_queue_xmit rc =3D 1
>  10:28:38:490012 - send_probe0 - port=3D8682 - snd_wnd 0, icsk_probes_ou=
t =3D 13+1
>  10:28:38:490076 - dev_queue_xmit rc =3D 1
>  10:28:38:520048 - dev_queue_xmit rc =3D 1
>  10:28:38:750069 - dev_queue_xmit rc =3D 1
>  10:28:39:000029 - send_probe0 - port=3D8682 - snd_wnd 0, icsk_probes_ou=
t =3D 14+1
>  10:28:39:000093 - dev_queue_xmit rc =3D 1
>  10:28:39:030052 - dev_queue_xmit rc =3D 1
>  10:28:39:260046 - dev_queue_xmit rc =3D 1
>  10:28:39:450050 - dev_queue_xmit rc =3D 1
>  10:28:39:520044 - SK_ERR(110) port=3D8682 - snd_wnd 0
>        sk_error_report+12
>        tcp_write_err+64
>        tcp_write_timer_handler+564
>        tcp_write_timer+424
>        call_timer_fn+88
>        run_timer_softirq+1896
>        __do_softirq+348
>        do_softirq_own_stack+64
>        irq_exit+392
>        timer_interrupt+380
>        decrementer_common_virt+528
>  10:28:47:813297 - dev_deactivate bond1
>
>Again, I know the easier solution is to remove rtnl users to reduce the
>time before dev_deactivate (we are working on that as well).
>
>Nick Child (1):
>  bonding: Return TX congested if no active slave
>
> include/net/bonding.h | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>-- =

>2.43.0

---
	-Jay Vosburgh, jv@jvosburgh.net

