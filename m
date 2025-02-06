Return-Path: <netdev+bounces-163606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958AEA2AE9B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 18:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E203A1AEE
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 17:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B2E239589;
	Thu,  6 Feb 2025 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="oCFB2UCM"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79A523956E;
	Thu,  6 Feb 2025 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738862019; cv=pass; b=JXHvMm7tH5qq4XVTyFb1jCyIqlY/e2DlViv79qvzJ4e5x/3a9YgMsIgVBSjNSftHt4SIP1Unx56uedH7YuhiG2r/kRN+XeZfZ1XaM9yFC+mE8FywbUEo3rpfU0wzFJmdLKQoPFIJ1NpaZ9l2V0f9RGxrPafuV/5s7nkjKNI+JtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738862019; c=relaxed/simple;
	bh=H7Ok0MZWMdZNNFeQQRhn3Fy8AX60OBaQDH12MQwyBkw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rTIdJ42Vv5n/GJ8WH1YcQU8TObZT4VCmyG4Q1rCMuEhhzDWjqt3/9GnDQm5gi3EofnYYkwkYl4bs1Xkdw1lDTdUx0gQxy8cdhuH+KroRim3JCdoOTazrvMBuWqnNcdAkqRr4xA9HZeZryXSQsGeok+1adGbRH5i0RtGo9kul+xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=oCFB2UCM; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4YpkFy1VChz49QDp;
	Thu,  6 Feb 2025 19:13:26 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1738862007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ae8qlcBx/Jg+8J5hjz60d3i9t4IsJ8ZeJ3uKgzLwMvs=;
	b=oCFB2UCM5IObOxdkjGt9dbgqQbgvN63i00kiKjcIAJ4vUNRTpbHlJEN6syEkelUQAe/Vhq
	R/nCdkDjLsam0J/zUga09NiGqK9IBYOaVmnbqzEAIOYJLnACn+ihrFcQgO7bNlt+MqjeRU
	5prDMsBwgvJH9th9vRVcbBy5sMhS5R5tVlak/PAthw08I1fvwEXuulq4aLn2P4Cyt+Ajp4
	JFj64UaBihZoemYfuKRWAwDe+T6632DWi49JI84ABCtdYN7GzUb33FFd41Vp8aleqUkq13
	0mJ7oZDOZw+1ZR0RL35xDEobsNZu77vh5czRIMv3IhmmFiPgycogKaFdpMLnjg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1738862007; a=rsa-sha256;
	cv=none;
	b=n5SkvdJy3DvuPHPMGJS22MNjMqUMvsa7+SuPSFiAhMWd8s8EwT3kXVfQGFqtyJ5nWjWMSm
	juLccQGXCntcgV1KSTbA77DlK5YXJdBljO0rfyMteTM/EBFoaZPNgDaoWyxVOvGoS+PaWk
	MZmdV21rVRxwOhfwmkXNRyFCn3eRTHOKEgn4TpGyEhNkRcju9Es1E2VECLOq5kH7Vnlmt7
	Jlk6GChI9vLjD5gr2DUeEqjfiFlqVGzKi+d4p9jZdgsMhrP1H0NOHn9/Gx/rJ2CW6ZT69v
	5r+RKWEkIxt42/i9zlxTHKlB/MzuS/7lMzDO18uaG/07Mq/tKcQNbt4Dv8ocog==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1738862007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ae8qlcBx/Jg+8J5hjz60d3i9t4IsJ8ZeJ3uKgzLwMvs=;
	b=vUyQz3FxeFf9agi0H99kmqeda8keKTLt/mqEqVtBg1O9JNWd2wmjega0Gou7Zgz5Uxx4QP
	ORG/9MCcZeApI7cNlLDYPGTVtoAc3Bagm//+lhj1wZolaKBC9HZ5lsMeQ/FKAX+uK2c0zw
	sWNKKYF+9S7a+cZYcA1MOwfcQL7G+NBlhyqLoALRjKtSsqdsKzcJN+R1tbRs0elyMgTBZY
	D9AmWrc78NYGMRnyr+JGfYzh2zMXjsth6yeZRMVZJMuSmxLy2i0k9laYZC2OH8FwuRmHD3
	w8s3qQjQ8bc25oCLeZAdzoCrwCbKE6hkcNOu08fuJ4t+ycp2wyeBK0RNe3RLSA==
Message-ID: <0a132561e1681cd0a9b10934a1cc1f96d29dfb8a.camel@iki.fi>
Subject: Re: pull request: bluetooth-next 2024-05-10
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Willem de Bruijn
	 <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Date: Thu, 06 Feb 2025 19:13:25 +0200
In-Reply-To: <CABBYNZ+9D-jSyTsRvzRReHE4enfv6DP=Pr4uZCaLdY3-4D6AHg@mail.gmail.com>
References: <20240510211431.1728667-1-luiz.dentz@gmail.com>
	 <20240513142641.0d721b18@kernel.org>
	 <CABBYNZKn5YBRjj+RT_TVDtjOBS6V_H7BQmFMufQj-cOTC=RXDA@mail.gmail.com>
	 <20240513154332.16e4e259@kernel.org>
	 <6642bf28469d6_203b4c294bc@willemb.c.googlers.com.notmuch>
	 <CABBYNZKJSpQcY+k8pczPgNYEoF+OE6enZFE5=Qu_HeWDkcfZEg@mail.gmail.com>
	 <6642c7f3427b5_20539c2949a@willemb.c.googlers.com.notmuch>
	 <7ade362f178297751e8a0846e0342d5086623edc.camel@iki.fi>
	 <6643b02a4668e_2225c7294a0@willemb.c.googlers.com.notmuch>
	 <CABBYNZ+9D-jSyTsRvzRReHE4enfv6DP=Pr4uZCaLdY3-4D6AHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

ke, 2025-02-05 kello 15:44 -0500, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Tue, May 14, 2024 at 2:40=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >=20
> > Pauli Virtanen wrote:
> > > Hi all,
> > >=20
> > > Thanks for the comments, I guess the original series should have been
> > > Cc'd more widely to get them earlier.
> > >=20
> > > ma, 2024-05-13 kello 22:09 -0400, Willem de Bruijn kirjoitti:
> > > > Luiz Augusto von Dentz wrote:
> > > > > Hi Willem,
> > > > >=20
> > > > > On Mon, May 13, 2024 at 9:32=E2=80=AFPM Willem de Bruijn
> > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > >=20
> > > > > > Jakub Kicinski wrote:
> > > > > > > On Mon, 13 May 2024 18:09:31 -0400 Luiz Augusto von Dentz wro=
te:
> > > > > > > > > There is one more warning in the Intel driver:
> > > > > > > > >=20
> > > > > > > > > drivers/bluetooth/btintel_pcie.c:673:33: warning: symbol =
'causes_list'
> > > > > > > > > was not declared. Should it be static?
> > > > > > > >=20
> > > > > > > > We have a fix for that but I was hoping to have it in befor=
e the merge
> > > > > > > > window and then have the fix merged later.
> > > > > > > >=20
> > > > > > > > > It'd also be great to get an ACK from someone familiar wi=
th the socket
> > > > > > > > > time stamping (Willem?) I'm not sure there's sufficient d=
etail in the
> > > > > > > > > commit message to explain the choices to:
> > > > > > > > >  - change the definition of SCHED / SEND to mean queued /=
 completed,
> > > > > > > > >    while for Ethernet they mean queued to qdisc, queued t=
o HW.
> > > > > > > >=20
> > > > > > > > hmm I thought this was hardware specific, it obviously won'=
t work
> > > > > > > > exactly as Ethernet since it is a completely different prot=
ocol stack,
> > > > > > > > or are you suggesting we need other definitions for things =
like TX
> > > > > > > > completed?
> > > > > > >=20
> > > > > > > I don't know anything about queuing in BT, in terms of timest=
amping
> > > > > > > the SEND - SCHED difference is supposed to indicate the level=
 of
> > > > > > > host delay or host congestion. If the queuing in BT happens m=
ostly in
> > > > > > > the device HW queue then it may make sense to generate SCHED =
when
> > > > > > > handing over to the driver. OTOH if the devices can coalesce =
or delay
> > > > > > > completions the completion timeout may be less accurate than =
stamping
> > > > > > > before submitting to HW... I'm looking for the analysis that =
the choices
> > > > > > > were well thought thru.
> > > > > >=20
> > > > > > SCM_TSTAMP_SND is taken before an skb is passed to the device.
> > > > > > This matches request SOF_TIMESTAMPING_TX_SOFTWARE.
> > > > > >=20
> > > > > > A timestamp returned on transmit completion is requested as
> > > > > > SOF_TIMESTAMPING_TX_HARDWARE. We do not have a type for a softw=
are
> > > > > > timestamp taken at tx completion cleaning. If anything, I would=
 think
> > > > > > it would be a passes as a hardware timestamp.
> > > > >=20
> > > > > In that case I think we probably misinterpret it, at least I thou=
gh
> > > > > that TX_HARDWARE would really be a hardware generated timestamp u=
sing
> > > > > it own clock
> > > >=20
> > > > It normally is. It is just read from the tx descriptor on completio=
n.
> > > >=20
> > > > We really don't have a good model for a software timestamp taken at
> > > > completion processing.
> > > >=20
> > > > It may be worthwhile more broadly, especially for devices that do n=
ot
> > > > support true hardware timestamps.
> > > >=20
> > > > Perhaps we should add an SCM_TSTAMP_TXCOMPLETION for this case. And=
 a
> > > > new SOF_TIMESTAMPING option to go with it. Similar to what we did f=
or
> > > > SCM_STAMP_SCHED.
> > >=20
> > > Ok, I was also under the impression TX_HARDWARE was only for actual H=
W
> > > timestamps. TSTAMP_ACK appeared to not really match semantics either,
> > > so TSTAMP_SND it then was.
> > >=20
> > >=20
> > > The general timestamping flow here was:
> > >=20
> > > sendmsg() from user generates skbs to net/bluetooth side queue
> > > >=20
> > > * wait in net/bluetooth side queue until HW has free packet slot
> > > >=20
> > > * send to driver (-> SCM_TSTAMP_SCHED*)
> > > >=20
> > > * driver (usu. ASAP) queues to transport e.g. USB
> > > >=20
> > > * transport tx complete, skb freed
> > > >=20
> > > * packet waits in hardware-side buffers (usu. the largest delay)
> > > >=20
> > > * packet completion report from HW (-> SCM_TSTAMP_SND*)
> > > >=20
> > > * for one packet type, HW timestamp for last tx packet can queried
> > >=20
> > > The packet completion report does not imply the packet was received.
> > >=20
> > > From the above, I gather SCHED* should be SND, and SND* should be
> > > TXCOMPLETION. Then I'm not sure when we should generate SCHED, if at
> > > all, unless it's done more or less in sendmsg() when it generates the
> > > skbs.
> >=20
> > Agreed. Missing SCHED if packets do not go through software queuing
> > should be fine. Inversely, with multiple qdiscs processes see multiple
> > SCHED events.
> >=20
> > > Possibly the SND timestamp could also be generated on driver side if
> > > one wants to have it taken at transport tx completion. I don't
> > > immediately know what is the use case would be though, as the packet
> > > may still have to wait on HW side before it goes over the air.
> > >=20
> > > For the use case here, we want to know the total latency, so the
> > > completion timestamp is the interesting one. In the audio use case, i=
n
> > > normal operation there is a free HW slot and packets do not wait in
> > > net/bluetooth queues but end up in HW buffers ASAP (fast, maybe < 1
> > > ms), and then wait a much longer time (usu. 5-50 ms) in the HW buffer=
s
> > > before it reports completion.
> > >=20
> > > > > if you are saying that TX_HARDWARE is just marking the
> > > > > TX completion of the packet at the host then we can definitely al=
ign
> > > > > with the current exception, that said we do have a command to act=
ually
> > > > > read out the actual timestamp from the BT controller, that is usu=
ally
> > > > > more precise since some of the connection do require usec precisi=
on
> > > > > which is something that can get skew by the processing of HCI eve=
nts
> > > > > themselves, well I guess we use that if the controller supports i=
t and
> > > > > if it doesn't then we do based on the host timestamp when process=
ing
> > > > > the HCI event indicating the completion of the transmission.
> > > > >=20
> > > > > > Returning SCHED when queuing to a device and SND later on recei=
ving
> > > > > > completions seems like not following SO_TIMESTAMPING convention=
 to me.
> > > > > > But I don't fully know the HCI model.
> > > > > >=20
> > > > > > As for the "experimental" BT_POLL_ERRQUEUE. This is an addition=
 to the
> > > > > > ABI, right? So immutable. Is it fair to call that experimental?
> > > > >=20
> > > > > I guess you are referring to the fact that sockopt ID reserved to
> > > > > BT_POLL_ERRQUEUE cannot be reused anymore even if we drop its usa=
ge in
> > > > > the future, yes that is correct, but we can actually return
> > > > > ENOPROTOOPT as it current does:
> > > > >=20
> > > > >         if (!bt_poll_errqueue_enabled())
> > > > >             return -ENOPROTOOPT
> > > >=20
> > > > I see. Once applications rely on a feature, it can be hard to actua=
lly
> > > > deprecate. But in this case it may be possible.
> > > >=20
> > > > > Anyway I would be really happy to drop it so we don't have to wor=
ry
> > > > > about it later.
> > > > >=20
> > > > > > It might be safer to only suppress the sk_error_report in
> > > > > > sock_queue_err_skb. Or at least in bt_sock_poll to check the ty=
pe of
> > > > > > all outstanding errors and only suppress if all are timestamps.
> > > > >=20
> > > > > Or perhaps we could actually do that via poll/epoll directly? Not=
 that
> > > > > it would make it much simpler since the library tends to wrap the
> > > > > usage of poll/epoll but POLLERR meaning both errors or errqueue e=
vents
> > > > > is sort of the problem we are trying to figure out how to process=
 them
> > > > > separately.
> > > >=20
> > > > The process would still be awoken, of course. If bluetoothd can jus=
t
> > > > be modified to ignore the reports, that would indeed be easiest fro=
m
> > > > a kernel PoV.
> > >=20
> > > This can be done on bluetoothd side, the ugly part is just the wakeup
> > > on every TX timestamp, which is every ~10ms in these use cases if eve=
ry
> > > packet is stamped. EPOLLET probably would indeed avoid busy looping o=
n
> > > the same timestamp though.
> > >=20
> > > In the first round of this patchset, this was handled on bluetoothd
> > > side without kernel additions, with rate limiting the polling. If
> > > POLL_ERRQUEUE sounds like a bad idea, maybe we can go back to that.
> >=20
> > We have prior art to avoid having timestamp completions on
> > MSG_ERRQUEUE set sk_err and so block normal processing.
> >=20
> > Additional work on opting out of timestamp/zerocopy wake-ups sounds
> > reasonable to me.
>=20
> Id like to follow-up on this, do you have any plans to continue on
> this?=C2=A0

So this is on TODO list, there's an unsent revised patchset adding
SCM_TSTAMP_COMPLETION, taking above comments into account. I can try to
find some time to rebase it and send if useful.

I deprioritized this, as some Intel firmware changes significantly
reduced the ISO desync issue, but now it's not clear if the TX
completion timestamps can be used for ISO synchronization. IIRC, at
least how I used them previously doesn't work now.

The desync issue on Intel HW still exists (not good for production
use...), but it's hard to trigger, so I don't know currently if TX
timestamps can help with it. Someone would need to spend more time on
this.

TX timestamps would still be useful for flow control.

> In addition to synchronization Id also like to experiment
> sending on TX complete kind of logic, instead of time based, or at
> least I don't have a better way to attempt to synchronize the TX so I
> assume if we keep feeding the controller whenever it has buffers
> available it should be able to not miss any interval.

AFAICS, for synchronization (only) guidance in the specification is
(Version 6.0 | Vol 6, Part G Page 3709)

"""When an HCI ISO Data packet sent by the Host does not contain a
Time_Stamp or the Time_Stamp value is not based on the Controller's
clock, the Controller should determine the isochronous event to be used
to transmit the SDU contained in that packet based on the time of
arrival of that packet."""

which I'm interpreting that Host should queue synchronized packets for
different CIS to HCI at the same time. But since this seems
implementation-defined, I don't really know what Intel firmware is
expecting the Host to do, so maybe pull on completion works (at least
until user app misses a wakeup).

--=20
Pauli Virtanen

