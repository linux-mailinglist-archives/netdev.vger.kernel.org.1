Return-Path: <netdev+bounces-96396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E878C59A3
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 18:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF81A1F23A02
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 16:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059DC17F375;
	Tue, 14 May 2024 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="TxRAVepN"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD6E5B1FB;
	Tue, 14 May 2024 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703602; cv=pass; b=dE4r2EmxxJirIFn2xp0gT7I7FY/raa0Eu3Dlu3S+vQq8W02M3NOa4JOTNc4EZLwqCBsbgs+ow7qPLjg6eoDTdQOlRPveNuYhSmNFfjv0ONqcOUVIgNjzSl8d2hciBclYEAXvBOINLbzYKT5WnXWri5OU/J3Kwu1FTJ/oMeuVmio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703602; c=relaxed/simple;
	bh=oI7iDxdgw3FF3BufaXB1EpX/XLByQJk6QZ5FiKCR904=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YAUfBRrObI9aC+V/irexXqeObkk+zbOXEJ2v0RJdtjeHmFbpfUc8HC/l3j0+Zx4HKeg1Lqq52uiBIKrOv9nDmO/IIG7QGNw/re3Bmray8nARhnyvW5+NvPQao2FX8NBqzO4EN20ZmxLxA+SN9pAAMPREFmTwD2kDJRtKPy6UuKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=TxRAVepN; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Vf1ln0xMcz49Pwn;
	Tue, 14 May 2024 19:19:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1715703591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75CUswRmwmhL4GTcmw7gRTNs6P6579eEZKUjc/QHq64=;
	b=TxRAVepNW+GhhWHoa4TC3TtNV87XH366p4/whjOutypeiE8sYscJjszyHeMhCwC9slkOF8
	sRdKL8n6HS3+tf201dL+zOHiHTeRaAoRMtP3woaPUbX3ydL/Cy9c+YQ56MNwBk97N1eyHw
	LatfJU7asLVLQZ7Rkm1FKkOMDMXPWJjPCQUkxaTga256Pebu0D1FhfsRJMTH0Ukacx+ABs
	SpSPCEY8e+elfCrH9OoMEYCeWGpx6Eezm5wzVtqASQS4kkCiNEUq6ddYVBwIxursX9FBjS
	pyPnKb8SCWhbvBIq8ijNGGN2xfHkOQfmgMdN/v/wrSs9SCh6mRAFceRFYy6Aag==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1715703591; a=rsa-sha256;
	cv=none;
	b=sRqWTw4h2G/mChCmLHXx5ToAtPjih1hsLu9Tok2WrDupZE9R8251WH0Ri64wqkMyXLGDks
	NRi5LFo+nxcAY7UzAimXJREwZMSiWkgRQh+4kMVa4jcLGf2wH92DaQ7Yn0qF8m61AKbneR
	tZra6idWQUAKg+Bh5BvUr0KJoQPHFToXdHJHQyXYxJGXUdSlHZg/k1bcjdrIClktSK/JBa
	76CRqQgBhfID0MZmI41A36OD+CBEDqCO6nOcYe/QARQ4IZt3DvUIpI06xv6umB9s6jPSiy
	AZnE4/GIeUShpY95fECPgyACgPes0jCyULuUI1ENAO8BOXrWcd3eRXJgNBqxYA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1715703591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75CUswRmwmhL4GTcmw7gRTNs6P6579eEZKUjc/QHq64=;
	b=QvBs3Z7lYf+xvffu2nW8J490EkpsHNcmDMd64BZBpsd7qGpgiLsAmG8VQFOKcueJcDbkwh
	MMop8fVs09lnWwvqycqkOGRIG9oUU7I4YR0FvwUNyLMPHh/fSGlfGMrAGC4dJqRe8Zy7ts
	d78cspISb2cJE2INGUNuuycyYAuk6Pw3azu2M2Iw1RpDcKnutgtKsCd7VDgsUYDGAP6zUS
	zQVTDGZ8GN/ycXPYgS7uhALpsA9e6i5EVPVh5LIgUffezP0c9c4+jji7IacoC1i0bnj7gS
	uLssgYkVdXu+B12Qaq8ct+ncs3WVXYjPj+ibXhj39+kZxg/72ZLVbmO+NqVJWA==
Message-ID: <7ade362f178297751e8a0846e0342d5086623edc.camel@iki.fi>
Subject: Re: pull request: bluetooth-next 2024-05-10
From: Pauli Virtanen <pav@iki.fi>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Luiz Augusto von
 Dentz <luiz.dentz@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Date: Tue, 14 May 2024 19:19:45 +0300
In-Reply-To: <6642c7f3427b5_20539c2949a@willemb.c.googlers.com.notmuch>
References: <20240510211431.1728667-1-luiz.dentz@gmail.com>
	 <20240513142641.0d721b18@kernel.org>
	 <CABBYNZKn5YBRjj+RT_TVDtjOBS6V_H7BQmFMufQj-cOTC=RXDA@mail.gmail.com>
	 <20240513154332.16e4e259@kernel.org>
	 <6642bf28469d6_203b4c294bc@willemb.c.googlers.com.notmuch>
	 <CABBYNZKJSpQcY+k8pczPgNYEoF+OE6enZFE5=Qu_HeWDkcfZEg@mail.gmail.com>
	 <6642c7f3427b5_20539c2949a@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi all,

Thanks for the comments, I guess the original series should have been
Cc'd more widely to get them earlier.

ma, 2024-05-13 kello 22:09 -0400, Willem de Bruijn kirjoitti:
> Luiz Augusto von Dentz wrote:
> > Hi Willem,
> >=20
> > On Mon, May 13, 2024 at 9:32=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >=20
> > > Jakub Kicinski wrote:
> > > > On Mon, 13 May 2024 18:09:31 -0400 Luiz Augusto von Dentz wrote:
> > > > > > There is one more warning in the Intel driver:
> > > > > >=20
> > > > > > drivers/bluetooth/btintel_pcie.c:673:33: warning: symbol 'cause=
s_list'
> > > > > > was not declared. Should it be static?
> > > > >=20
> > > > > We have a fix for that but I was hoping to have it in before the =
merge
> > > > > window and then have the fix merged later.
> > > > >=20
> > > > > > It'd also be great to get an ACK from someone familiar with the=
 socket
> > > > > > time stamping (Willem?) I'm not sure there's sufficient detail =
in the
> > > > > > commit message to explain the choices to:
> > > > > >  - change the definition of SCHED / SEND to mean queued / compl=
eted,
> > > > > >    while for Ethernet they mean queued to qdisc, queued to HW.
> > > > >=20
> > > > > hmm I thought this was hardware specific, it obviously won't work
> > > > > exactly as Ethernet since it is a completely different protocol s=
tack,
> > > > > or are you suggesting we need other definitions for things like T=
X
> > > > > completed?
> > > >=20
> > > > I don't know anything about queuing in BT, in terms of timestamping
> > > > the SEND - SCHED difference is supposed to indicate the level of
> > > > host delay or host congestion. If the queuing in BT happens mostly =
in
> > > > the device HW queue then it may make sense to generate SCHED when
> > > > handing over to the driver. OTOH if the devices can coalesce or del=
ay
> > > > completions the completion timeout may be less accurate than stampi=
ng
> > > > before submitting to HW... I'm looking for the analysis that the ch=
oices
> > > > were well thought thru.
> > >=20
> > > SCM_TSTAMP_SND is taken before an skb is passed to the device.
> > > This matches request SOF_TIMESTAMPING_TX_SOFTWARE.
> > >=20
> > > A timestamp returned on transmit completion is requested as
> > > SOF_TIMESTAMPING_TX_HARDWARE. We do not have a type for a software
> > > timestamp taken at tx completion cleaning. If anything, I would think
> > > it would be a passes as a hardware timestamp.
> >=20
> > In that case I think we probably misinterpret it, at least I though
> > that TX_HARDWARE would really be a hardware generated timestamp using
> > it own clock
>=20
> It normally is. It is just read from the tx descriptor on completion.
>=20
> We really don't have a good model for a software timestamp taken at
> completion processing.
>=20
> It may be worthwhile more broadly, especially for devices that do not
> support true hardware timestamps.
>=20
> Perhaps we should add an SCM_TSTAMP_TXCOMPLETION for this case. And a
> new SOF_TIMESTAMPING option to go with it. Similar to what we did for
> SCM_STAMP_SCHED.

Ok, I was also under the impression TX_HARDWARE was only for actual HW
timestamps. TSTAMP_ACK appeared to not really match semantics either,
so TSTAMP_SND it then was.


The general timestamping flow here was:

sendmsg() from user generates skbs to net/bluetooth side queue
|
* wait in net/bluetooth side queue until HW has free packet slot
|
* send to driver (-> SCM_TSTAMP_SCHED*)
|
* driver (usu. ASAP) queues to transport e.g. USB
|
* transport tx complete, skb freed
|
* packet waits in hardware-side buffers (usu. the largest delay)
|
* packet completion report from HW (-> SCM_TSTAMP_SND*)
|
* for one packet type, HW timestamp for last tx packet can queried

The packet completion report does not imply the packet was received.

From the above, I gather SCHED* should be SND, and SND* should be
TXCOMPLETION. Then I'm not sure when we should generate SCHED, if at
all, unless it's done more or less in sendmsg() when it generates the
skbs.

Possibly the SND timestamp could also be generated on driver side if
one wants to have it taken at transport tx completion. I don't
immediately know what is the use case would be though, as the packet
may still have to wait on HW side before it goes over the air.

For the use case here, we want to know the total latency, so the
completion timestamp is the interesting one. In the audio use case, in
normal operation there is a free HW slot and packets do not wait in
net/bluetooth queues but end up in HW buffers ASAP (fast, maybe < 1
ms), and then wait a much longer time (usu. 5-50 ms) in the HW buffers
before it reports completion.

> > if you are saying that TX_HARDWARE is just marking the
> > TX completion of the packet at the host then we can definitely align
> > with the current exception, that said we do have a command to actually
> > read out the actual timestamp from the BT controller, that is usually
> > more precise since some of the connection do require usec precision
> > which is something that can get skew by the processing of HCI events
> > themselves, well I guess we use that if the controller supports it and
> > if it doesn't then we do based on the host timestamp when processing
> > the HCI event indicating the completion of the transmission.
> >=20
> > > Returning SCHED when queuing to a device and SND later on receiving
> > > completions seems like not following SO_TIMESTAMPING convention to me=
.
> > > But I don't fully know the HCI model.
> > >=20
> > > As for the "experimental" BT_POLL_ERRQUEUE. This is an addition to th=
e
> > > ABI, right? So immutable. Is it fair to call that experimental?
> >=20
> > I guess you are referring to the fact that sockopt ID reserved to
> > BT_POLL_ERRQUEUE cannot be reused anymore even if we drop its usage in
> > the future, yes that is correct, but we can actually return
> > ENOPROTOOPT as it current does:
> >=20
> >         if (!bt_poll_errqueue_enabled())
> >             return -ENOPROTOOPT
>=20
> I see. Once applications rely on a feature, it can be hard to actually
> deprecate. But in this case it may be possible.
>=20
> > Anyway I would be really happy to drop it so we don't have to worry
> > about it later.
> >=20
> > > It might be safer to only suppress the sk_error_report in
> > > sock_queue_err_skb. Or at least in bt_sock_poll to check the type of
> > > all outstanding errors and only suppress if all are timestamps.
> >=20
> > Or perhaps we could actually do that via poll/epoll directly? Not that
> > it would make it much simpler since the library tends to wrap the
> > usage of poll/epoll but POLLERR meaning both errors or errqueue events
> > is sort of the problem we are trying to figure out how to process them
> > separately.
>=20
> The process would still be awoken, of course. If bluetoothd can just
> be modified to ignore the reports, that would indeed be easiest from
> a kernel PoV.

This can be done on bluetoothd side, the ugly part is just the wakeup
on every TX timestamp, which is every ~10ms in these use cases if every
packet is stamped. EPOLLET probably would indeed avoid busy looping on
the same timestamp though.

In the first round of this patchset, this was handled on bluetoothd
side without kernel additions, with rate limiting the polling. If
POLL_ERRQUEUE sounds like a bad idea, maybe we can go back to that.

--=20
Pauli Virtanen

