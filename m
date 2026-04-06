Return-Path: <netdev+bounces-275620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nnFNBKTH02lNmAcAu9opvQ
	(envelope-from <netdev+bounces-275620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:48:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DF73A4613
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C37373004639
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 14:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D78C3191BD;
	Mon,  6 Apr 2026 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epVrLowI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B63622F01
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486880; cv=none; b=mWMzwTiIGc3sXB+ae3lmK6ReVr6dyhC0xKkg4BSasfcalnAnYbZBKnwiORFSKxsNo3WKWv3dfG0QJcXbqHplTjS1al+zOFVt+xtAdrL1UYidfAX7eTq6MhJV/DHrRvG+bwR8CAN1vdxa2UkadvjttxcpdugZbP1uqQhuM60JF00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486880; c=relaxed/simple;
	bh=xM6M67kxqQjw6I8qtw/e3iPmYFXpqxBszKd2fVxFxsU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=T/hbUA0ANKPIkdmGB1rwkMeeDCYvblIpk/PaE14jvPO+WNlWVPkX2gjS1+j7RNPB6srMa6u9GnasdL4gXRGmhPuMR8cOu5+WsPOaVI8xeMRToDf1w6brk9qoYgJ7yl2DIz3dxa2Bp0W79rilYzfDh0j+/StHmboHpI2SPduIWCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epVrLowI; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79a74765703so30243967b3.3
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 07:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775486878; x=1776091678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xM6M67kxqQjw6I8qtw/e3iPmYFXpqxBszKd2fVxFxsU=;
        b=epVrLowI8DSYg98GKv/8t91+etHgiAnZbgCv5fEwPlKLjtrpm85NW1VhLPcTw3gcKT
         QNIYXgoxZoe30tJQ0LVSIt0hq8/r36s1I7nd+DA1YfgaqpVleunDLbTGkQpz9NvDvF1q
         EAPs6KZtvorM6bXWbNZd8SHsK6Obv2t0+tBVFWV5hsitKIFLQEY2ivOTmR2EX7IsXPui
         c/u3l/G+EdUwKF2yCOBfii/rkqvM3YX91qt2cmhE1bgFDrrPv5f7gw3M5vDTAidl4pgG
         2qNCJ0fhwD4a96+kSSdUjlPqoRZt8V0eVNPFs5X4urkaSbjGjO22n6KcYrc++yyAkyLd
         yMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775486878; x=1776091678;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xM6M67kxqQjw6I8qtw/e3iPmYFXpqxBszKd2fVxFxsU=;
        b=PUVEFamU/MfYOFe5Mpd8fV2epeO8L+297A2IAy3v2TnTrvL0Pz33CRiVc+XKXEydcz
         oZ3NEbSYxzL/1wJaqcJaKwdFBhfykv28s8+byD9J06WTaa9Wt+v0XACW7hFDwiWoDI4d
         oN/UZWxETv+evWSfHI2+XE6PyAbdUv5voxXUNssjaOEoCLPG+z5mfORFfJWgLF1RzQWT
         qIbW+rrQ7aAodcRZixIRLpUI01C1Y1XQ1ajfNWHAnp4+hVyV5fFhE3AxX6rL3P4SkmDC
         4BcxjGT9WZSolx1aJq3JgIyS1Gr64IvdJOaL8J6XJnat+bImrEzHWvuzqNHiDoMa0a2+
         p/HQ==
X-Gm-Message-State: AOJu0YyDXE6mhLSSyZ6BY2nISOvRohkIEMFnMZEvf9kl7GHUQ5aQJs8x
	8XLq8j/DIO4txWpbOnmrgdTUrmUDui4sGtKKn8zmYxEwAjljIrGPiJX9
X-Gm-Gg: AeBDiesj+aISm0GFCOW5mwY1KCDUBntCs9n0msA83QOowMHXQp+ipYo9z7yK9AfklOq
	9JZsi+CqW9IJROSwv51HcA2UM3qKH9x9QM6UGgzXyYCAzI917n4kD8itYdDy0wMqI7O/NnVSs6s
	ZBy3IOn1p9eCs62jziuqJxNX5D2p/IeU/wRDPAkvLQwYME73ydzLoYCakIn4xjWNbWxwtlnnLBp
	35kNWFBc7knDeg10kr96IvwyS7cxSJL2dt4GGAjc5lFVbnRph7djHLcLVaufkDK+QC1tdZC+pIA
	5G7gFbNMHFCHHPsAFZxMoAjTDluLuo7llt/QMbKLU1Oc6sAUgCHXoVoWk2pOsbahtfV/YvwXLiL
	DyeOZwaDIXk56jBrTnQTVXxPukjAwc/jDjAOSIU2bEEMfbBBwN1Z2D4ZMGJcKZ1XC1KtnecNMvT
	jgj+NMkeJd2X1gv58abyq+FsiU6TzJAErqhtnPa+wjsmNmpgJ9es275NMmasal5D+33FR5wXc2d
	MOL
X-Received: by 2002:a05:690c:e68c:b0:79a:3d1a:a667 with SMTP id 00721157ae682-7a4d5f56494mr74350457b3.48.1775486877887;
        Mon, 06 Apr 2026 07:47:57 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36ea2c42dsm54005387b3.17.2026.04.06.07.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 07:47:57 -0700 (PDT)
Date: Mon, 06 Apr 2026 10:47:56 -0400
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
Message-ID: <willemdebruijn.kernel.1f3d8356e4a5a@gmail.com>
In-Reply-To: <20260402163237.EIE16Pj_@linutronix.de>
References: <20260312154253.UC-QUPvD@linutronix.de>
 <willemdebruijn.kernel.be379ee17449@gmail.com>
 <20260313092226.SscHp2zQ@linutronix.de>
 <20260313160410.LEhav8Xz@linutronix.de>
 <willemdebruijn.kernel.1fbf050c50d62@gmail.com>
 <20260317172906.eG2LxlZ7@linutronix.de>
 <willemdebruijn.kernel.17068ce38efa5@gmail.com>
 <20260319142613.KHz32I-V@linutronix.de>
 <willemdebruijn.kernel.8e323262df61@gmail.com>
 <20260324163820.p9M2z27W@linutronix.de>
 <20260402163237.EIE16Pj_@linutronix.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275620-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61DF73A4613
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sebastian Andrzej Siewior wrote:
> Hi Willem,
> =

> On 2026-03-24 17:38:21 [+0100], To Willem de Bruijn wrote:
> > On 2026-03-19 12:27:57 [-0400], Willem de Bruijn wrote:
> > > =

> > > Right, so this is simple without hardware offload. Does this HW
> > > offload exist, or is this aspirational. At least for infrequent PTP=

> > > it does not sound important.
> > =

> > The snippet below was for the icssg driver as-is and it works with
> > updated firmware to ignore PTP packets while HW offloading is enabled=
.
> =E2=80=A6
> > With the skb_ext I had, the mechanism was mostly the same but it reli=
ed
> > only on the skb_ext data. Now it has to look at skb->mark.
> =

> Had you so time think about it? The proposed skb->mark solution kind of=

> works but feels hacky.
> The version with skb_ext does touch packet's code but it is self
> contained and does not slowdown the !HSR+PTP case since the compare
> conditions are NOPed.
> How do we move forward here?

So the requirement is for a communication path between userspace and
the driver over packet sockets.

Existing options that work for both rx and tx are

- in-band: a packet header or footer
- mark, metadata
- maybe: vlan tags

These require changes in the HSR driver to use them, but no changes in
the protocol independent core logic, which includes packet sockets.

As I mentioned before we cannot sprinkle protocol specific code
throughout protocol independent core code. That quickly leads to an
unmaintainable mess. PTP over HSR is a particular small niche case,
nowhere near first in line to get an exception to this guideline.

One perhaps interesting Rx only option I had missed before is
SOF_TIMESTAMPING_OPT_PKTINFO. Would that give you the original
device ifindex today?

If so, we now only have to consider the Tx path to the HSR driver
(the Tx path directly to the other drivers do not need this metadata).

I'm not convinced that it is hard to come up with a way to send
a packet to the HSR driver with an optional header or footer or
vlan data (or skb->protocol perhaps?) that cannot be
differentiated from other traffic arriving at that ndo_start_xmit.

If all this fails, we can look into a protocol independent approach
to passing other metadata in packet sockets. to/from skb_ext or cb[],
say.

But at this point I see enough options that do not require changes
to packet sockets.

To get back to the simplest approach: skb->mark. Is there any
concrete risk that on this path that would conflict with other
uses of that field? If packet sockets inject directly into this
driver (possibly even with PACKET_QDISC_BYPASS)?=

