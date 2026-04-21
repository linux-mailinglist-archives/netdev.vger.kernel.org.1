Return-Path: <netdev+bounces-280032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKWpACkr52nv4wEAu9opvQ
	(envelope-from <netdev+bounces-280032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 09:45:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0EB437D18
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 09:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D37E301DEE3
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 07:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334AA384237;
	Tue, 21 Apr 2026 07:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUN5Huas"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D8D384246
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776757317; cv=none; b=lbHDw9gJboS/z2OsbRy5VMQDkd8ju/6u472UaJDU4bYOQEEGC3rzxosK1PBF4x3XvEc48EPh+t1Sq8agIyYtry2otBWw3WEFVqifWYr7MAoF2pB/z8M56mHt+rAV3HERzdyeuBbu3CawADxiGujii/N1ZchbUMcp52sfIQIA2sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776757317; c=relaxed/simple;
	bh=j/fjtO1QpBD4D+sfM0UUenGaAkM1iBkSqqaNX6Y0Q2A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oVEl3Ey8kLx3Aeewe5HT+IoDzPUJGCgmi+eE87FL+tXw/AkJ00kj1EOywKPUdSkFpfWx9y0/Zw9Xu2sTdzpUWxPnm7hxTav+NATsM+AawdYaDkHKvkj4NSeR2ItG5PIx6i+4X5R+MzwakpoOkHbRTj4YxjP99LEBpkrpEWRIwyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUN5Huas; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7982c3b7da9so38900487b3.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 00:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776757314; x=1777362114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/fjtO1QpBD4D+sfM0UUenGaAkM1iBkSqqaNX6Y0Q2A=;
        b=CUN5HuasdByzgoF6Wk48BME60N0Y1Z9mvNTmunAxS8K+EptmuKmWmZ7J3gouZIl4up
         X2ZQGwzUfkhd1y+nFOiUziI0sb1DE0wn2q6IcEdH+hBAsQizYKG3SiXTSQC4SFIS8+Ut
         ghNCHcQyNEebqLh8+AJXGITU2QFLTHhnA99JJi2qnAUeYTea5aDRMEch6o1rOVbxCRmd
         /I7H7CqKS8oX9aqh2meCCGv3Wy3hrO+9wA46d15hY+W/HyN18hb7gZVPSCNuXCSTFdod
         U4k5OlHROX7zBh4WWcbs4J/jSpFbtfpAZEx8VYbEJ8tbFp9ca7bIm0meQPN0ktEmHNPm
         KRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776757314; x=1777362114;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j/fjtO1QpBD4D+sfM0UUenGaAkM1iBkSqqaNX6Y0Q2A=;
        b=XP8VJ8Szc3I9l5Ub9UH9i2rgLVIUKVFysi4Qkh48wafPFotYZzQmwxU07pfyzDx6sV
         8LYdHYVYxY3oSPj0zzUJX6cCX8JdBsK7n4yRZcPi9+o3TxPtgyHXRZ6ej12Q0vN9UNSv
         yll0+GWbHJKPKDl5rMVETWi/tyB0SIEBitSf06MrTOSa/ler4NAzxPDTBoY3CbyDmDvb
         ZWGtq7ZZPKAJ09MOEZVOorKkiRUAHDpXDfKCVtBALL0yeUyXHt5/wXcsC5apiK6Wvlsc
         W0LKiHh/4pcOHHK1BNdK2sybuLjAPUNnyNllLpEGVMR+sY3Qh8pfOe1L8zsvYzv8B0yU
         tdAQ==
X-Gm-Message-State: AOJu0YzMPp76Q90x0d1tylMsapIokZasiLZvaiqptFSEjYLXeRWvV8ro
	dyItSF0Ipl9aT7mUsYHNYr7B2LLvRhpCjXT+gk2JK5gs8Ul8I2zkb2lN
X-Gm-Gg: AeBDiesSMYPpn5Hh3bwy5BR1bJNUv82QRBlExgLtst9f8Iaan0BrROBgrpDkRMjrrmW
	ii6OhVmKvBJqf5tZkPSyhvn5vAG5TvTJV44PjRCcl54jh3Bg8QmFGDF+AjXri3l/WZOBwShsxLj
	Z5HmcVyDHVGiG8qbG5cL38Ol66XnbE70NsiIaMZAK/vLs9lvEYH28oFLRO/kFUHwWySgIca7Sne
	QAT6Q2HUuDhhoPptQBSyfvFiVtogq3nq7JImV7pYW/6jj1a10XaaiyD4L1+OTORzeeyx4dINEHo
	Kl5AwBeGjAhUOrZxTIFeRwn5HsWSqLk3Eb2NqUj/yAlJT0QXvRkGXNeBGSFLl+CV4/H5kaqBphu
	AZRBwUKHCTcWPZ0NNQWOlfO2JsBWKo52NMk82k1HYTdt7Yik6NHYpLOgUaWa83bJBsW00ikeIXj
	GCdb8akdrZvBFIFxokrY308WsrspFBXQYcjIRmXkBOtrTJAvpRhPQjLOffckzAE6ZqqJumiY2kj
	QKybPefdH/TdUY=
X-Received: by 2002:a05:690c:c4e9:b0:7ba:f2f1:86c7 with SMTP id 00721157ae682-7baf2f1927amr64925247b3.1.1776757314129;
        Tue, 21 Apr 2026 00:41:54 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee9ce50fsm53147857b3.47.2026.04.21.00.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 00:41:53 -0700 (PDT)
Date: Tue, 21 Apr 2026 03:41:52 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 "(JC), Jayachandran" <j-rameshbabu@ti.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Danish Anwar <danishanwar@ti.com>, 
 Daolin Qiu <d-qiu@ti.com>, 
 Eric Dumazet <edumazet@google.com>, 
 Felix Maurer <fmaurer@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Simon Horman <horms@kernel.org>, 
 "Raghavendra, Vignesh" <vigneshr@ti.com>, 
 "Bajjuri, Praneeth" <praneeth@ti.com>, 
 "TK, Pratheesh Gangadhar" <pratheesh@ti.com>, 
 "Muralidharan, Neelima" <neelima@ti.com>
Message-ID: <willemdebruijn.kernel.270fa204f615f@gmail.com>
In-Reply-To: <20260416161856.CsL4npMH@linutronix.de>
References: <20260313092226.SscHp2zQ@linutronix.de>
 <20260313160410.LEhav8Xz@linutronix.de>
 <willemdebruijn.kernel.1fbf050c50d62@gmail.com>
 <20260317172906.eG2LxlZ7@linutronix.de>
 <willemdebruijn.kernel.17068ce38efa5@gmail.com>
 <20260319142613.KHz32I-V@linutronix.de>
 <willemdebruijn.kernel.8e323262df61@gmail.com>
 <20260324163820.p9M2z27W@linutronix.de>
 <20260402163237.EIE16Pj_@linutronix.de>
 <willemdebruijn.kernel.1f3d8356e4a5a@gmail.com>
 <20260416161856.CsL4npMH@linutronix.de>
Subject: Re: [PATCH RFC net-next v2 2/2] af_packet: Add port specific handling
 for HSR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280032-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ti.com,davemloft.net,lunn.ch,google.com,redhat.com,kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A0EB437D18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sebastian Andrzej Siewior wrote:
> On 2026-04-06 10:47:56 [-0400], Willem de Bruijn wrote:
> Hi Willem,
> =

> > So the requirement is for a communication path between userspace and
> > the driver over packet sockets.
> > =

> > Existing options that work for both rx and tx are
> > =

> > - in-band: a packet header or footer
> > - mark, metadata
> > - maybe: vlan tags
> > =

> > These require changes in the HSR driver to use them, but no changes i=
n
> > the protocol independent core logic, which includes packet sockets.
> > =

> > As I mentioned before we cannot sprinkle protocol specific code
> > throughout protocol independent core code. That quickly leads to an
> > unmaintainable mess. PTP over HSR is a particular small niche case,
> > nowhere near first in line to get an exception to this guideline.
> =

> I understand your concern. I tried to make as self contained as
> possible and little runtime overhead as possible.
> =

> > One perhaps interesting Rx only option I had missed before is
> > SOF_TIMESTAMPING_OPT_PKTINFO. Would that give you the original
> > device ifindex today?
> =

> The upper logic expects to poll() on the fd. If I need to filter the
> device based on this then breaks the expectations.
> I need also to receive packets without a timestamp so I don't think thi=
s
> works.

I don't follow this. My suggestion is to optionally receive this
additional metadata along with the data. Not as a filter.
 =

> > If so, we now only have to consider the Tx path to the HSR driver
> > (the Tx path directly to the other drivers do not need this metadata)=
.
> > =

> > I'm not convinced that it is hard to come up with a way to send
> > a packet to the HSR driver with an optional header or footer or
> > vlan data (or skb->protocol perhaps?) that cannot be
> > differentiated from other traffic arriving at that ndo_start_xmit.
> =

> I've been looking to skb->protocol. Maybe if the packet has ether type
> set to PTP then the HSR layer could consider everything before it (the
> two MAC address fields) as internal header and the actual packet starts=

> after that. Reasoning would be that you shouldn't send a PTP packet ove=
r
> HSR without dealing with the restrictions. So this could work.
> =

> Then the question remains how to do the filtering on RX side. For the
> so_mark I did open additional two sockets=E2=80=A6
> =

> > If all this fails, we can look into a protocol independent approach
> > to passing other metadata in packet sockets. to/from skb_ext or cb[],=

> > say.
> =

> I will try the above but it looks very hackish.
> cb[] is limited to one layer. I do have a skb_ext variant working but
> this requires cmsg to set it. Do you think about generic skb_ext which
> is set from af_packet? But I don't think it brings much value if I can'=
t
> filter on the RX side before returning the packet to userland.
> =

> > But at this point I see enough options that do not require changes
> > to packet sockets.
> > =

> > To get back to the simplest approach: skb->mark. Is there any
> > concrete risk that on this path that would conflict with other
> > uses of that field? If packet sockets inject directly into this
> > driver (possibly even with PACKET_QDISC_BYPASS)?
> =

> So I have a skb->mark variant working. I do read on the ethX interface

When reading on both ethX interfaces, that gives you all the info you
need on Rx, right? Or alternatively by attaching to hsr0 with
SOF_TIMESTAMPING_OPT_PKTINFO.

So skb->mark is only relevant to the Tx side, right? There might be
yet another way to identify in the hsr ndo_start_xmit that a packet
arrived from a PF_PACKET socket. E.g., by checking skb->sk->sk_family.
As alternative or complement to skb->protocol.

Btw, on receive the inverse could also be true: insert a synthetic
header and pop that in userspace, e.g., a VLAN tag.

> and write on the hsr0 interface (so I need two extra fd per interface).=

> The only concern here is that the mark value is hardcoded and could
> collide with an existing firewall setup or so.
> This field needs also be evaluated by the ethernet driver in case of
> hw-offloading for HSR.
> So far, this is the only working solution I have which does not touch
> af_packet.
> =

> Let me try the header with the PTP hedaer type and the additional
> sockets for RX.
> It will not win a beauty contest but maybe I judge too harsh=E2=80=A6
> =

> Sebastian



