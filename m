Return-Path: <netdev+bounces-266348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENCvLq2OsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:35:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C393F2585BE
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD6EE3021C2F
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B539535A397;
	Tue, 10 Mar 2026 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0yZYCkL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFA236493E
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178536; cv=none; b=h9XswCplX2i2Yu+pTgXF7sN4XiohUvOPt3HsH7tryCaTph7xVkX25iOdI1BCJiYtjP1oUmlJyDxQl8vQgisTB7FOUvvuBr2TRnn/ZoYGGQPAQFk2w4nxqcQF1c1uAKRzn9j6U+53ALHAXKscinUcGZqdeIEc+2etI8WjFZLws5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178536; c=relaxed/simple;
	bh=cf0zOThJP4CHjR+drL52NMKbHPwyA4h5ppsnUreY7bQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cxnd71A/t8qtJi20SIHc23vN/pSKFuJv8oDVj2nEKoN0fdCC3CjXjFKvok02/t3yrxoqNTRo6RWFMfRQhuBugbCKVkfAuBfjrSUkBWe98UqLZAh50EnS05TTKnYb7nADo/+F1fSmIBXS4Qf/eH3BEAxg/ZbqrCwva8mO2VYLuCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0yZYCkL; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ad46a44easo12127882d50.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773178534; x=1773783334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuhK/VPu29r0bY+L+cpE+SCnfTgIEoBd+pjieyxoxiQ=;
        b=A0yZYCkLs59k0+E/VRbKKj+pQwDyUzaIBH0EkFtWg1YLKMro8ptG/HBaLT47bgcwlg
         OJ64aAdeFaYDAB8cAzXiNOLSYKZgyvSOp5Zy3L13wcDg0KBgYmXefFJJ/vQvy03HxJiQ
         9d5w7WeA8IilVS2ZLcsIH3KmfBNplkEpXssmJjccEkCBZlZFlzHnG9IxxJuy8hJsKfU/
         LzrPHTDNYrSDTnv+THvM3ulSwWiI4ESt6jCzqGxmZsMtioTI0mfmH3ZvL6of0IaZhDGV
         XrHmYKIJCmDKSq1Q4hoxe7OHQuFrFZH+tLVYkiWuM7xuwBn8kiteU1H2OfoFVeMCghKP
         gZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773178534; x=1773783334;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EuhK/VPu29r0bY+L+cpE+SCnfTgIEoBd+pjieyxoxiQ=;
        b=acYaQIpHoGNIBOk90Zw+jc2UaHeSb0cFZi+EO4rchZk5YUElrMGbl2AFcedK18bMyt
         VowJk1vIAzf1z9eYJBVkydcHG2EK2V/hZ8RZj06RaqkJFgZ9sB74v1xZkrxh4Tj/SjBf
         o1yzUy2qqRni4ZiO/6g/O47uKCgUnvliCsXphFFBTgsyK2Vzk7xyHBZDOtlpAKFCucYZ
         1sx4B4cAhFyqEeE3JE8t/UlYcO37zIPi8iE1ZUm4fsPMMuEAn4qCrdCcz954G7XgElRh
         L2P/P4WloRCwUIJwMKhHLvqeGKSJKYahiaMPP+oBwlMekHfVFAPRpqsHvOuhvbeCelyj
         kP0Q==
X-Gm-Message-State: AOJu0Ywr94uzkHaZaMEzINV9fAV/aGaGxKU4G2fKuDSef9NwFv9Rbgqq
	2mBXqRXhdRRuFgRteTMy35zasHt1H8Vnj/cOUvxfSi5PfPBAdPMNrma2
X-Gm-Gg: ATEYQzx70V2sNGc16oxsTruop8DT77ETZhAnqybzaH+MYznqLefvBymuN0LDNfjSyaC
	hQVVCJ1PHiDwgleaJpWYSexU9Im7oOO5/6zbrpMoT6oEQbWGEQe6P0QkBgK8iqdRg2rx6Iq0SWt
	ZdyoqS6tAXc6zEJIQYdn+wH9PMCpy4dlLAEMs9CCUTRxW+IbPwpZmE0xdtcNQEKrot7w4W7SwSM
	rMLrXbVo/eT+DMf3fEAe1xjwQt9OFHRzoPauyJEp5gbItS8hF3MKjUtDOqnpfURSqYrvXzHL0/q
	gWjJndioPOk8IFZhKRoH1Zj2QL2g94InR9tU0BsajOSQur1aSpL5EPAtktDh8VBQX0vXq/mD3zv
	os4oucgPzyfZx1fYpm0GTTs1B9MWKF7FGEEVCK+eKFWy4NZSnQtXveHwD0/a1xGI42asIqFO0CY
	eOjkEz/j56DQyTpx+8CRr+8p5AQJ4fb8amFQO/w70zAR0ZXif6eVEHY1/eiYF7jKRL13wd0GJGT
	WvQ7A==
X-Received: by 2002:a05:690e:1aa7:b0:646:b1f3:aeb2 with SMTP id 956f58d0204a3-64d65686a28mr189261d50.3.1773178534129;
        Tue, 10 Mar 2026 14:35:34 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64d65143c73sm215338d50.20.2026.03.10.14.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:35:33 -0700 (PDT)
Date: Tue, 10 Mar 2026 17:35:33 -0400
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
 Simon Horman <horms@kernel.org>
Message-ID: <willemdebruijn.kernel.3693c9aa8271@gmail.com>
In-Reply-To: <20260310105544.EVXIekwG@linutronix.de>
References: <20260309-hsr_ptp-v2-0-798262aad3a4@linutronix.de>
 <20260309-hsr_ptp-v2-2-798262aad3a4@linutronix.de>
 <willemdebruijn.kernel.3b7b5294c6434@gmail.com>
 <20260310105544.EVXIekwG@linutronix.de>
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
X-Rspamd-Queue-Id: C393F2585BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266348-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ti.com,davemloft.net,lunn.ch,google.com,redhat.com,kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Sebastian Andrzej Siewior wrote:
> On 2026-03-09 21:38:33 [-0400], Willem de Bruijn wrote:
> > The same point about adding per protocol state to sk_buff applies
> > to a slightly lesser extent to PF_PACKET.
> > =

> > Adding this much HSR + PTP specific code there is a non-starter.
> =

> It looked like a little and is hidden behind a static branch so it is
> just a nop as long as there is no one using the socket bind. And withou=
t
> CONFIG_HSR there is not even that.
> =

> > I should have said this in v1. This likely makes my skb_extensions
> > suggestion a non-starter sorry.
> =

> I need something to share between two layers I think so that
> skb_extensions wasn't that bad.
> =

> > We need to find a different way to
> > =

> > Rx: get the port info from the slave device to userspace.
> > Tx: send out the intended slave device.
> > =

> > Let's separate the two challenges (and patches).
> > =

> > On Rx, could your process just attach the PF_PACKET socket to the
> > slave devices and filter on HSR PTP packets? Then separately drop
> > these packets in hsr_handle_frame (as already done?) or TC ingress, s=
o
> > that they only arrive in userspace?
> =

> I could listen directly on eth0/ eth1 as a PF_PACKET. That would give m=
e
> all I need including a timestamp, yes. I wouldn't just be able to use i=
t
> for TX but lets go on.

Great
 =

> > On Tx, can you share a bit more why there are two cases, one where th=
e
> > master has to add the header, but also one where it does not (so
> > userspace has presumably inserted it).
> =

> PTP + HSR. Lets assume the following setup:
> =

>          =E2=95=AD=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=95=AE   =E2=95=AD=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=95=AE              =E2=95=AD=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=95=AE  =E2=95=AD=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=95=AE    =

>      =E2=95=94=E2=95=90=E2=95=90=E2=95=90=E2=94=82 Node X =E2=94=82=E2=95=
=90=E2=95=90=E2=95=90=E2=94=82Port A=E2=94=9C=E2=94=85=E2=94=85=E2=94=85=E2=
=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=
=85=E2=94=85=E2=94=85=E2=94=A4Port A=E2=94=82=E2=95=90=E2=95=90=E2=94=82 =
Node Y =E2=94=82=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=97
>      =E2=95=91   =E2=95=B0=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=95=AF   =E2=95=B0=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=95=AF              =E2=95=B0=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=95=AF  =E2=95=B0=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=95=AF    =E2=
=95=91
>      =E2=95=91                                                         =
     =E2=95=91
>      =E2=95=91                                                         =
     =E2=95=91
>   =E2=95=AD=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=95=
=AE            =E2=95=AD=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=95=AE  =E2=95=AD=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=95=AE  =E2=95=AD=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=95=AE            =E2=95=AD=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=95=AE
>   =E2=94=82Port B=E2=94=9C=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=
=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=A4P=
ort B=E2=94=82=E2=95=90=E2=95=90=E2=94=82 Node Z =E2=94=82=E2=95=90=E2=95=
=90=E2=94=82Port A=E2=94=9C=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=
=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=A4Port=
 B=E2=94=82
>   =E2=95=B0=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=95=
=AF            =E2=95=B0=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=95=AF  =E2=95=B0=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=95=AF  =E2=95=B0=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=95=AF            =E2=95=B0=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=95=AF
> =

> Node X has direct connection to Y and Z, each node has two ports. You
> could add more nodes but it always remains a ring.
> Lets say node X sends a packet (say TCP/IP) with the destination MAC of=

> node Z assuming a "normal port 443" request. This packet gets a HSR
> header prepended and is sent on X-A and X-B. This happens transparently=

> as hsr0 is the device with an IP address assigned and port A and B are
> just two device which are up with no IP address assigned. These are the=

> physical devices forwarding the traffic.
> =

> Y-A receives it, is not the target, forwards it over Y-B.
> Z-B receives it, it is the target, sends to its master port which
> removes the HSR header and the packet arrives in the IP stack. After th=
e
> master port, it forwards it also on Z-A.
> Z-A receives it (the copy from Y-B) identifies it as a duplicate based
> on the HSR-sequence number (does not inject into the master port) and
> forwards it on Z-B.
> At the end Node X receives two copies of the packet it sent and removes=

> them from the ring (node X was the sender identified by the SRC MAC and=

> does not forward it).
> =

> This is how HSR works in general. Now lets add PTP to this as specified=
.
> The target MAC is always a multicast MAC and the ether type is PTP
> 0x88f7.
> =

> Use case 1: A PDELAY_REQ packet. This packet travels only between two
> neighbours. That means X-A sends it to Y-A and Y must not forward it
> over Y-B but needs to answer (send a PDELAY_RESP). These packets are
> sent as PTP frames and the HSR stack needs to prepend a HSR header with=

> a valid sequence number. X-B gets its own request. Userland needs to
> track time/ state information on per port basis.
> =

> Use case 2: A SYNC packet. This packet is sent from X-A to Y-A. Again a=

> HSR header needs to be prepended by the stack on X. Y-A receives that
> packet. It injects it into the master port where user land can consume
> it. This is the same as the previous case.
> Here comes the different part: This packet needs to be forwarded by Y
> over Y-B. As in the previous case the HSR stack does not forward it on
> its own but this part is done by userland. So userland sends a packet,
> only on Y-B and this packet already contains the HSR header from X and
> it needs to be preserved.
> The forwarded SYNC packet got its timing information updated based on
> the delay within the stack (so it is not identical as received).

Thanks for the detailed explanation of the challenge!

> That is why the HSR stack must not forwarded the packets on the other
> port as it would normally do (breaks PTP time information), why user
> land needs to know on which port the packet was received and why it
> needs to send a packet only on one port with or without the HSR header.=

> =

> > The second case is simpler: can just write directly the whole packet
> > to the intended slave device.
> =

> Yes. This has been suggested and was indeed used in my v1 of linuxptp

Great

> but the problem was sending with system's HSR header.
>
> > For the first case, could skb->mark be used as port selector when
> > writing from a packet socket to the master device? That already works=

> > with sock_cmsg_send.
> =

> We would have to specify that SO_MARK 1 and 2 denotes the port on which=

> a packet is sent. This kind of burns the usage for everything else on
> HSR so it feels misused.

It is more or less what mark is for. An alternative similar field
supported by sock_cmsg_send is skb->priority.

An alternative may be to share the information in-band. Already
insert the HSR header also wen writing to the master device. If the
master device can detect this packet-with-pre-existing header.

This is not the first case where ndo_start_xmit may already expect a
header prefixed that it normally inserts. I forgot the exact case (can
look it up), maybe a weird edge case in GRE?

It does not even have to be a valid HSR header: just an agreement
between the process writing the raw packet and hsr_dev_xmit.

There probably are still more ways we can approach this challenge.
But these are three that do not require kernel changes outside the
HSR protocol code.

> And then we would need an additional bit to
> specify whether the HSR header is there or not. Unless I open additiona=
l
> socket on the ethernet device just for sending and dropping everything
> incoming.

Right, packets that already have a header prefixed are written
directly to the intended slave.

> And we would have to filter/ distinguish the RX port based on it.
> Userland has a cBPF filter to filter everything out and receive only PT=
P
> frames. If the PTP packet is forwarded to both sockets (A and B) then
> userland would have to throw one copy away and go to sleep again. This
> sort of breaks currently linuxptp logic. It would probably require
> either eBPF to filter also so_mark or deal with "no packet despite the
> wakeup" but so far I tried minimal impact on both sides (kernel and
> user).

I don't fully follow this part. It discusses Rx again?

