Return-Path: <netdev+bounces-267213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AXgJ48zs2ntSwAAu9opvQ
	(envelope-from <netdev+bounces-267213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 22:43:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5467427A20B
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 22:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45B83303A3DC
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A8F33F5AC;
	Thu, 12 Mar 2026 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D01+0/da"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C258F37DEAE
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773351820; cv=none; b=mkvd5R+3/dqlb26EI9odof/Oms5rp8ZGQ7++oPOD6yAMUTtD0EpeD/xd8r7CL0luw2LI6MehvgnuL+2zRSmJopGQvWeDh2ZUeT8im2nKg6Ue+t18zWMs7Vvcizk2fo6G2FKA+PV23jpwgo/aUZ6zzhx53fdjJ7LhyWW3hIcGAFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773351820; c=relaxed/simple;
	bh=mz3u90N8hf+wV4srd4oW/1I4nV5mOY6t0gEFQ6zAyBk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bzBBl4FTZk3i/nCCub8zwDqekCSBoN2TH+q8wmZEUAmE4OPwbYjOY+iqeT07DcRty392ZWUi/2Ai/gKgjL+nFPm8L7Dp0KVmh30S6Mdn5tTxvLrKO/b3w5MaYO64sxDn26ba5FLu6wnA98jh/VQqmpKAtugVBrb87lgu3aWYv3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D01+0/da; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-899ed41208fso9633386d6.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 14:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773351818; x=1773956618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mz3u90N8hf+wV4srd4oW/1I4nV5mOY6t0gEFQ6zAyBk=;
        b=D01+0/daObqwfEKER3rNEOmmlVaZPdqhymbF/qPr77AkoLvhuQkvmpnWKnkcJHxvnt
         NZSq6DQ5tSNSqe0NGSaYI5DhRalHq+sTgbIDODGAK22mkxNP19xeCbqhHcO3pGVzdjEy
         bYR9JmfBDgsd5LSzG5NeZzo/tcC7esM+fzIyeMOr1ZeQVnQdzyY7IEVQhQpRHi9g6aBd
         Hlbjn5OqHIZegLrDuh50pqak4aopaeOUFYX42iaSjCRTVKmY5tVR8f+gCo1SBFG+GV88
         ACcp3ai4WGFZIG/5LUQ4mq3jm3GEKAWdEM0x7cjJSVAFTMezceqLS1c4xDNDhbhr4VSM
         Q2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773351818; x=1773956618;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mz3u90N8hf+wV4srd4oW/1I4nV5mOY6t0gEFQ6zAyBk=;
        b=kFt8KMd+nIjSuiUfQu5SFp7azpgZa1AEzIm9gL1TuxZUuNVl1lgudUFlw2PYEE5v3U
         ly0fukCKnnjmH2zI76jhd32IRuCReaIhUbid7hTj6fQtBrD72IE7BqEwvQFDAafcL+uf
         htPId9gaNjoItOe7nIaHgOX9l7ycQUaStJ30OVmHkiucms8NVY9obyQkvmmM1WweiM2p
         ZK48/KVc3B3MKhQ5Ip025a+wywYEA5cwhLVmSKtEhbSeB7nY3QPZJ3hwol66ypsEv8aI
         l/KKcxdyYijmpvprA+5tvrpsndBaPEFLByf3OiAcid22qUmy/f3B5gwggETT2hSz4B1K
         /exQ==
X-Gm-Message-State: AOJu0Yw7EgzHWGKkSmRZymyBUdn96FyJJ+1nc39a3uVRAQDAUvsHnrjB
	1Qsp9RqtAtOoteFt3gdcxm8Rg3kUw62BnAMT7n2+aVB4/AYCtB3BcV2lus7U0Q==
X-Gm-Gg: ATEYQzw0/oX8SdDomSRsfFEFaK28ZnHglh3WqGwg/ap3pwSTuJTWYtfWnWfcQ1MPfSu
	CXhxQAtNlQB28eEWQcigY59NnKIt44HjeLB4nvLsu3CH/Y2SWV8epH2g64HGnC0C5qG1usbHSOv
	l6Eya8j6V4bHYhDxLPPc3fytTB7kD1UbQe0mmw2D7cKAuZqSOrZ3xtwCCjAl1buDj0xl/ozRYjT
	e1Pnc5glQYS/HHcMti0bR11uXMKc0B0Y9Zh7ELP9NZN/GxeluA5fNDS5VoVd80hq45yBxt4z51Z
	PMRoIc5soh0HnLZ8iKQlybbX1i6mgnCxt/PSCxgLMZNrFCEfVYHKy/gaf3Co1FFdFu6k70eKf0i
	XEB11oi8XH9yNndyhVBjHXwX7YVHRGMZRg2WI6dEy1+nW36yLB9Uj7mbsLnedASbl3R0yANTD6F
	oedN9k6bDjenU9jXJri30SkJYubsLFeFDzWzCryrjynebukQGkeVUBaaJWMg21HxGGUiQyHt62B
	vE5DkuHGn2crVs=
X-Received: by 2002:ad4:5ba7:0:b0:89a:14be:4593 with SMTP id 6a1803df08f44-89a81f8c1b4mr21550836d6.35.1773351817777;
        Thu, 12 Mar 2026 14:43:37 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-89a65a96b33sm43307346d6.0.2026.03.12.14.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 14:43:36 -0700 (PDT)
Date: Thu, 12 Mar 2026 17:43:36 -0400
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
Message-ID: <willemdebruijn.kernel.be379ee17449@gmail.com>
In-Reply-To: <20260312154253.UC-QUPvD@linutronix.de>
References: <20260309-hsr_ptp-v2-0-798262aad3a4@linutronix.de>
 <20260309-hsr_ptp-v2-2-798262aad3a4@linutronix.de>
 <willemdebruijn.kernel.3b7b5294c6434@gmail.com>
 <20260310105544.EVXIekwG@linutronix.de>
 <willemdebruijn.kernel.3693c9aa8271@gmail.com>
 <20260312154253.UC-QUPvD@linutronix.de>
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
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267213-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ti.com,davemloft.net,lunn.ch,google.com,redhat.com,kernel.org,gmail.com];
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
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5467427A20B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sebastian Andrzej Siewior wrote:
> On 2026-03-10 17:35:33 [-0400], Willem de Bruijn wrote:
> > > but the problem was sending with system's HSR header.
> > >
> > > > For the first case, could skb->mark be used as port selector when=

> > > > writing from a packet socket to the master device? That already w=
orks
> > > > with sock_cmsg_send.
> > > =

> > > We would have to specify that SO_MARK 1 and 2 denotes the port on w=
hich
> > > a packet is sent. This kind of burns the usage for everything else =
on
> > > HSR so it feels misused.
> > =

> > It is more or less what mark is for. An alternative similar field
> > supported by sock_cmsg_send is skb->priority.
> =

> The ->priority thing looks wrong. It is used by ssh and other
> application so they would suddenly behave differently.
> But okay lets take SO_MARK. Might be smallest abuse here.
> And we would have to hardcode the values in respect to HSR and I have n=
o
> idea where to document this.
> The difference with SO_MARK in general (at least my understanding) is
> that you can choose the values based on your setup. Here we would say
> 7-0 are already reserved.
> =

> > An alternative may be to share the information in-band. Already
> > insert the HSR header also wen writing to the master device. If the
> > master device can detect this packet-with-pre-existing header.
> =

> Given all this, I guess it is easier to stick to SO_MARK as the header
> might collide with other data.

Inserting a header by the packet socket sender and popping it in
hsr_dev_xmit is a bit like virtio_net. It is a private channel.

The tricky part is how hsr_dev_xmit can differentiate such packets
inserted by a packet socket, from regular packets arriving on the
device.

Anyway, admittedly it is a bit of a hack too.


> > This is not the first case where ndo_start_xmit may already expect a
> > header prefixed that it normally inserts. I forgot the exact case (ca=
n
> > look it up), maybe a weird edge case in GRE?
> > =

> > It does not even have to be a valid HSR header: just an agreement
> > between the process writing the raw packet and hsr_dev_xmit.
> > =

> > There probably are still more ways we can approach this challenge.
> > But these are three that do not require kernel changes outside the
> > HSR protocol code.
> =

> Okay.
> =

> > > And then we would need an additional bit to
> > > specify whether the HSR header is there or not. Unless I open addit=
ional
> > > socket on the ethernet device just for sending and dropping everyth=
ing
> > > incoming.
> > =

> > Right, packets that already have a header prefixed are written
> > directly to the intended slave.
> > =

> > > And we would have to filter/ distinguish the RX port based on it.
> > > Userland has a cBPF filter to filter everything out and receive onl=
y PTP
> > > frames. If the PTP packet is forwarded to both sockets (A and B) th=
en
> > > userland would have to throw one copy away and go to sleep again. T=
his
> > > sort of breaks currently linuxptp logic. It would probably require
> > > either eBPF to filter also so_mark or deal with "no packet despite =
the
> > > wakeup" but so far I tried minimal impact on both sides (kernel and=

> > > user).
> > =

> > I don't fully follow this part. It discusses Rx again?
> =

> Yes, this is RX. If I open packet socket, bind to hsr0, how do I filter=

> for packets from one of the slaves?

I was thinking of attaching directly to the slave devices.

> After some thinking and browsing through the packet code:
> The hsr stack creates hsrX. If it would create additionally hsrX_A and
> hsrX_B in order to be able to send and receive only on the relevant
> slave device then I wouldn't need the filters in packet code. That coul=
d
> work=E2=80=A6

That's another option.

