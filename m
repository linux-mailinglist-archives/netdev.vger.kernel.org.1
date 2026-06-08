Return-Path: <netdev+bounces-296741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FIJtE7c8J2pXtwIAu9opvQ
	(envelope-from <netdev+bounces-296741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:05:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9D665ADEF
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:05:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AAvILZHy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296741-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296741-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70B5F3055E83
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 22:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BDD3B0AF5;
	Mon,  8 Jun 2026 22:00:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C848B3B0AC8
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 22:00:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956058; cv=none; b=F+zEaN7tw4tDxPo42mNLjyfsS4k/0L/ATif6W/PSs3BpDkkBl51TtfJnpP4I8yOMAlaZZdjDc9BpyCzA087fQOBPNCFkqrtCheuEzUI6FkVbp4pOgsSlnAZRSFdQKuooYwUa6dU0jy4NNW40Y9GYS1ESokNH/wfbD/dO5f3UqPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956058; c=relaxed/simple;
	bh=6+vlX3Zkjr8OL4hq40PlY4P5AES/e9oiYGn2TbONXnA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ge/lmmyR1UyYPM5mhO9LugkTG21hjPcnye9lyMf8WhEJjTUkBpsgR/8qhTbycsZzKinJOMjS3WVP/bUiwPR/wVRqV/l7YWq5TjkOumYGOwEL28cTHp67nId8M1CLphNsZlluElldqBFR77GVc4rgwHCDHLWwAj9bqh89c9t28Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAvILZHy; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso40794165e9.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 15:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780956055; x=1781560855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLJ2jMp588e+auPb3MWqvkkw02fmeTR/jbhMobrCAUQ=;
        b=AAvILZHy03opO6Ngrsqm/rSjjeJVpRSVRlDqlbE0tIO3ixthskzl7T9jYn0I7SXnNS
         4TDGMx4JCdxC/blmCbRkGzf4dVwWdtau0wRNOTqccg9uiLf6qpdMSYTAtbrnod9jqlZY
         TsUgMRZ8kt4EVSo6hX23l6e0FWZCx+3uTdnBfW2y3vcNFURAiO6TKJDkpzzeYHq8E/w/
         0pju1eulSYEHXfigCJwNCRd/JhRJJNfe8kWtv1/S8NEOFcQCEfCeLGYdhemR4vooZ3pX
         P6rJ7mpUEYi5NrEoL2aGKj4LCqaCVAlAV0quvJ43n6rhhP6Jsk7FVP1p5f6yRjsxZEwt
         RYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780956055; x=1781560855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wLJ2jMp588e+auPb3MWqvkkw02fmeTR/jbhMobrCAUQ=;
        b=a6rUEwOnvXgl7NkhWy7wrNGTdgROit2QfenRRXCFiIdLET4ugG85kpACK1IZLgl6cb
         C2zLBAOpccI+vqAZU/TsWNvi2GcrdvmE0JS/uAlDnLPaZRvpwBwVTptKn3En2ADSVtm3
         D0EYsAu3yE81F0vLQfYkCiNdQOQqMk1cwMNG4ZvScxt0iYuqLSi2lFOgfA7IWfIkLBkX
         XToOQxbpTfHj3a1+wGTut8o8rLCgUzoARjtdU8H03jn1zrZ8x44SMccUYsa2vr/TX2Iq
         fiyZjIC8A8OC6laaPtQyBxYg4cCzEnSIJJ49FYWXyElXD0wEz5W7Y+kBTknrF608sWTd
         jUrQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xMw6N422b4fjEa/KsCgi7PjURneH0s/8Ozso80vwLtsLtCQKf84BGvESRN8Y/YwMhB0KeWqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQEcHdNP84Tp7IRZZ/yiZR6dRTobpQB13pxTOUrTNzVamDJ9ou
	7IPdcHim7JNQ2xVYarnm1gFjZwwgqXG0K0fy7LLnfRtQqiF7RWW4Vyoe
X-Gm-Gg: Acq92OG6S671KzUJgRb0yjc48DdTz7E1+8JgU3KpTZeWShryWpV3NWG+TWwnpCD7Kvt
	GVQMRuIbXF+uo7CrVeQ6UBDs+T4LiCfiHe3KPPugZ41UVZDFfnMJrJ6CF2xshKlSxSqoIqIwrWL
	8UZr2r2V9bONLo3GGrRBSNTpPhMaVef9swFudVXJhR0751Vb1dWnGBnzvH78GzVCkYoBnPHpgr1
	0Tya/EYlppiarDDossXBDcrmRDZXU5kXRJIoTog6M/+6IeBJQG2jXt7gYFRBrO9+nx+T2CMXsMV
	6W+qBleKHgnIMRThPyr6uMTavIaETiXb0lsDjhEMsR+FRinOgkWI4CnMNUG2NVd2aO5g1ZqojXC
	o5yHS7WHPRr88UbFFPoxmDQSCQw0+YP/64NxB2y4fVyNAGO2HCOumTWsA78ZQvqKVesCGT+igjW
	oMlYrbqh3E4IanjkeD4NXrXb5eA6ovAmQ0Im6W3lgCpIwUQ0BOgs/tMa3JS4DQkW1jyAVzwDw=
X-Received: by 2002:a05:600c:4e14:b0:490:4e3e:b483 with SMTP id 5b1f17b1804b1-490c2600ebdmr261518925e9.22.1780956055100;
        Mon, 08 Jun 2026 15:00:55 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cbfe4sm435232735e9.7.2026.06.08.15.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 15:00:54 -0700 (PDT)
Date: Mon, 8 Jun 2026 23:00:53 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "horms@kernel.org"
 <horms@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu
 <larry.chiu@realtek.com>
Subject: Re: [PATCH] rtase: Workaround for IP fragmented UDP packet hardware
 bug
Message-ID: <20260608230053.5c1a7bc5@pumpkin>
In-Reply-To: <0758634ad8944162b7de0d915fcfa88e@realtek.com>
References: <20260601062341.63981-1-justinlai0215@realtek.com>
	<5c095b26-9720-45b0-a8d5-a8495291e45b@lunn.ch>
	<447c46ad1f654222a8daa423149f0b89@realtek.com>
	<20260604124606.7143581b@pumpkin>
	<1489704deb9844b08848758af95a448e@realtek.com>
	<20260604155308.770b2deb@pumpkin>
	<0758634ad8944162b7de0d915fcfa88e@realtek.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-296741-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:justinlai0215@realtek.com,m:andrew@lunn.ch,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:horms@kernel.org,m:pkshih@realtek.com,m:larry.chiu@realtek.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pumpkin:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lunn.ch:email,realtek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F9D665ADEF

On Mon, 8 Jun 2026 12:28:28 +0000
Justin Lai <justinlai0215@realtek.com> wrote:

> David Laight <david.laight.linux@gmail.com> wrote:
> > 
> > On Thu, 4 Jun 2026 13:43:27 +0000
> > Justin Lai <justinlai0215@realtek.com> wrote:
> >   
> > > David Laight <david.laight.linux@gmail.com> wrote:  
> > > >
> > > > On Thu, 4 Jun 2026 08:33:51 +0000
> > > > Justin Lai <justinlai0215@realtek.com> wrote:
> > > >  
> > > > > Andrew Lunn <andrew@lunn.ch> wrote:  
> > > > > >
> > > > > > On Mon, Jun 01, 2026 at 02:23:41PM +0800, Justin Lai wrote:  
> > > > > > > The hardware parser incorrectly interprets 319/320 in a short IP
> > > > > > > fragmented UDP packet payload as standard PTP destination ports
> > > > > > > and treats the fragment as a PTP packet for further parsing.  
> > > >
> > > > Is that a packet that has been segmented by IP, or one where the skb is
> > > > fragmented enough that the data in the header is too short?
> > > > I thought that IPv4 required an mtu of 128 bytes (ish) and IPv6 somewhat
> > > > larger - so I don't see how that is a problem.
> > > >
> > > > If the skb is fragmented then you need to move data into the header not  
> > pad  
> > > > the frame.
> > > >
> > > > If the hardware really is broken then I suspect you need to disable the  
> > feature  
> > > > and suffer the consequences.
> > > >  
> > > > > > >
> > > > > > > If the transport data is smaller than RTASE_MIN_PAD_LEN, the
> > > > > > > remaining data is insufficient for further parsing and causes hardware  
> > TX  
> > > > hang.  
> > > > > >
> > > > > > Where does RTASE_SHORT_PKT_THRESH come into this?
> > > > > >
> > > > > > RTASE_MIN_PAD_LEN is 47, so matches all packets which need padding
> > > > > > up to
> > > > > > 60 bytes, plus FCS. There are not many such packets, so why both
> > > > > > this all the complexity and just pad all small packets? Do you have
> > > > > > any performance numbers which show the complexity is worth it?
> > > > > >  
> > > > > > > Pad these packets so the transport data reaches  
> > RTASE_MIN_PAD_LEN  
> > > > > > > before transmitting to avoid triggering the hardware issue.
> > > > > > >
> > > > > > > Signed-off-by: Justin Lai <justinlai0215@realtek.com>  
> > > > > >
> > > > > > Is this a Fix? Please add a Fixes: tag. And base it on net.
> > > > > >
> > > > > >  
> > https://www.kernel.org/doc/html/latest/process/maintainer-netdev.htm  
> > > > > > l
> > > > > >
> > > > > >     Andrew
> > > > > >
> > > > > > ---
> > > > > > pw-bot: cr  
> > > > >
> > > > > Hi Andrew,
> > > > >
> > > > > RTASE_MIN_PAD_LEN is not the Ethernet minimum-frame padding  
> > > > threshold.  
> > > > > It is the minimum transport-data length required by the hardware
> > > > > parser after the packet is incorrectly detected as a PTP packet.
> > > > >
> > > > > Therefore, this workaround needs to pad the packets which can trigger
> > > > > the hardware issue, rather than just padding packets to the Ethernet
> > > > > minimum frame size.  
> > > >
> > > > Is that a longer length?
> > > > Excessive frame padding (beyond 60+FCS) can be treated as a protocol  
> > error.  
> > > >
> > > > -- David
> > > >  
> > > > >
> > > > > I agree that RTASE_SHORT_PKT_THRESH is not necessary here. I will
> > > > > remove it in the next revision.
> > > > >
> > > > > Yes, this is a fix. I will add a Fixes tag and repost it against the
> > > > > net tree.
> > > > >
> > > > > Thanks,
> > > > > Justin
> > > > >  
> > >
> > > Hi David,
> > >
> > > This is an IP fragmented packet, not a fragmented skb.  
> > 
> > Ok, your tests are broken for fragmented skb.
> > skb_tail_pointer() is the end of the initial fragment, not the
> > end of the actual data.
> > So you could be adding padding to a full length packet making
> > it overlong.
> > Somewhere you need to be looking at skb->len.
> > Probably with a fast-path check to ignore long packets.
> >   
> 
> You're right. skb_tail_pointer() only covers the linear area and can
> underestimate the transport-data length for non-linear skb.
> 
> I will change the transport-data length calculation to use:
> trans_data_len = skb->len - skb_transport_offset(skb);
> 
> > >
> > > The issue occurs on a non-initial IP fragment whose payload
> > > contains values matching the PTP event/general destination
> > > ports (319/320). The hardware parser incorrectly identifies the
> > > fragment as a PTP packet and attempts further parsing.  
> > 
> > Wait a minute, what stops someone using either of those port numbers
> > for something else?
> > There are no hard restrictions on the use of UDP port numbers.
> > So what does the hardware do with UDP packets to port 319/320 that
> > are being used for something else entirely?
> >   
> 
> If the UDP destination port is 319 or 320, the hardware will identify
> the packet as a PTP packet and perform the corresponding PTP
> processing.

But aren't I allowed to run my 'frobnicate' protocol on those ports?

> 
> > > The workaround does not modify the IP or UDP length fields. The
> > > original protocol headers still describe the actual packet size.
> > >
> > > Therefore, the protocol-defined payload size remains unchanged.
> > >
> > > We have tested this workaround and have not observed issues
> > > caused by the additional padding.  
> > 
> > Have you checked all the systems that might receive such packets?
> >   
> 
> Could you clarify what kind of protocol error you are referring to?
> 
> From my understanding, this workaround adds padding at the end of the
> frame without modifying the IP or UDP length fields. The
> protocol-defined packet length therefore remains unchanged.
> 
> This appears similar to Ethernet frame padding, where additional bytes
> may exist beyond the protocol-defined payload length. Could you
> elaborate on how this case differs from the padding up to the Ethernet
> minimum frame size (60 bytes + FCS)?

The padding of short packets to 64 bytes (inc FCS) is a special case.
I don't believe any other packets are expected to be padded.
There have been issues when packets get extended when hardware switches
add VLAN headers to padded packets.
I also think you'll find bug reports caused by one of the VM 'virtual
network interfaces' adding extra padding to frames before they reach
the physical network (possibly just making them even length).
I can't remember the full details, it caused the company I used to work
for some issues because we had some hardware that rejected frames with
unexpected padding, a google search showed it was a known problem with
that VM.
A quick search showed https://www.virtualbox.org/ticket/18202
I can't remember if that was the source of the padded packets.

David

> 
> Thanks,
> Justin
> 
> > -- David
> >   
> > >
> > > Thanks,
> > > Justin  
> 
> 


