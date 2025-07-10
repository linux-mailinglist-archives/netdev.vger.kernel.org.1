Return-Path: <netdev+bounces-205728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E56DAFFE41
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 11:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9FB217AE86
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 09:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E2C28FA83;
	Thu, 10 Jul 2025 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aytSVCOv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD07F20B80A
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752140134; cv=none; b=rwd8Ad/DTrIR7fQ76/m+kZJITNPvjp7ynJWWz/1jzRSQflQ83L/Cd9qcw+ce7/Im11kf6bPI5NkfcXLhdtnpRh1k+WG9+1UFglPN7YT3r+QpL1AfmEnfK3uavtSaowcNt4H4Skjgr8OpZUbmLKXVaqkZf4qyfOVhif6yUi+iIOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752140134; c=relaxed/simple;
	bh=jDcTBR733Ey0pQ6Kvz3XoQ/2AV5QbEg2flyxBXJ3hrc=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/gqaiAQuoBKz8ZUTQ0vHLfq7iJrsfUxMoIBZxB15qYeixS2w2x0XBp+MtcdtWsoafIFIRL+VlXQPlm9+0Ahnn6UODX/EGVeZfus9dBmYlTtGIKE5u2BssgWqiZrgaU1b5jrBREFQopfA/++HYjGgLcVhmKetNbBNfXJD2QCJ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aytSVCOv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752140131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VGegctVS7kclcGReETmZUDvu3NzNqiLoHGO3dzCwHeo=;
	b=aytSVCOvCSiiHB4wpfHo69/bWNk+8G8M4+Ms2PT9rKi3/r+ObQFO86Upr59zMjIguEcZBp
	HcqAAH/vS1td47on8cYnjtwnwRGMAbUCrdWkufh0d7Y3+KXkkvQLzORqzLrAzgs5PaReEL
	dIdrUd4rDzVBfYTFic8v3TR7yukFYx4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-764iGvasM8iM6lfkjjJvvw-1; Thu, 10 Jul 2025 05:35:30 -0400
X-MC-Unique: 764iGvasM8iM6lfkjjJvvw-1
X-Mimecast-MFC-AGG-ID: 764iGvasM8iM6lfkjjJvvw_1752140129
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ae3c5ca46f2so61690266b.2
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 02:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752140129; x=1752744929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VGegctVS7kclcGReETmZUDvu3NzNqiLoHGO3dzCwHeo=;
        b=KolQ+XFHN7k6EmnA4WmDewgNtgcCzJeAWjzvj17oMEA0y092ypXW8uFBFdi1ePhVRy
         oaomsoiEHcEDxRe42Fzgq7pbUaoVCp/KqQ5yqGeJYspaGISlWkHwvd380KvEFSIrfDCQ
         6G++UXRcfvK02UReMDFanGykVeC30cHGden6vdrWWs6kqAExDKFqJ8+7LnYmlyFj7CsM
         Fk4ynmDzv3gMFvgzPCbGM2zqpABcHXk4OKjTBpC/jFuvT1dmLGBZpGip9TJwlLbEU0Ar
         7xjn46mHr8zYWMowAqsw1Fg0zcIkrYST9Jn55uiaI28CutPG0sqtvfe+iSNfze7KrraA
         IaLw==
X-Forwarded-Encrypted: i=1; AJvYcCVza7hsL4BHdHRqosr5uVdYPx5nyaooQEY3CrK8jNl1+lpWLgq/KH9SL2TIAwhkplJoE4w4V+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqX2QRxSZO26t2fasB1z03E6Sk8DBdxZ9gd1eMLVvkJ6TcsdDs
	rB2ajdWyzWq3eAfZ1OKDaa/lpdSxYh80TmiQ7YYZJtlv1Z6sb5s2c+uWK2q1TZ7oVNXjG0T7jix
	JsHsQR1ZKZU5W/SDl9mqUWev3i7+ePWy18tqM3PoD46ePoXaOlsqLu//e4dUXUMm8NAqsN2Smt6
	lkTbrFwNmAhGVXlyJbCWH/xwXSCX8oAJEF
X-Gm-Gg: ASbGnctCLRU6WjzEKef26TA3mBkTibwz3plaw6ZGTN8+6MFZ9kdlqAIWLUOi+V4827l
	XryxrPNwVYMSI3bPHAGx/6SG1+CYvMc7XiZYmBZxfs0ALQtLGRsQzNlmWcP95rXf1gRo9Tilylp
	UkD1LHNw==
X-Received: by 2002:a17:907:d01:b0:ae3:595f:91a0 with SMTP id a640c23a62f3a-ae6e6e9e293mr221651166b.16.1752140128684;
        Thu, 10 Jul 2025 02:35:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ9bY8ULiwJQ4tmAzJDceRtfzTgKsPKJJUr/KE0R2tTxH2SedPEjRimb1UpJke711NVk99cXMnKCrwVIfpzpw=
X-Received: by 2002:a17:907:d01:b0:ae3:595f:91a0 with SMTP id
 a640c23a62f3a-ae6e6e9e293mr221647266b.16.1752140128150; Thu, 10 Jul 2025
 02:35:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Jul 2025 02:35:26 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Jul 2025 02:35:26 -0700
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20250627210054.114417-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250627210054.114417-1-aconole@redhat.com>
Date: Thu, 10 Jul 2025 02:35:26 -0700
X-Gm-Features: Ac12FXwXzZsgnXHkneZZzbZoAHjPTwH51L_vIx2yc4CZc7-YUisbQ-uTsVYwHm8
Message-ID: <CAG=2xmOXG_5da9+yX0z8hruTqgQxaHzRLVVHZU9M9cmZ475Qqw@mail.gmail.com>
Subject: Re: [RFC] net: openvswitch: Inroduce a light-weight socket map concept.
To: Aaron Conole <aconole@redhat.com>
Cc: dev@openvswitch.org, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	Mike Pattrick <mpattric@redhat.com>, Florian Westphal <fw@strlen.de>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Joe Stringer <joe@ovn.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 05:00:54PM -0400, Aaron Conole wrote:
> The Open vSwitch module allows a user to implemnt a flow-based
> layer 2 virtual switch.  This is quite useful to model packet
> movement analagous to programmable physical layer 2 switches.
> But the openvswitch module doesn't always strictly operate at
> layer 2, since it implements higher layer concerns, like
> fragmentation reassembly, connection tracking, TTL
> manipulations, etc.  Rightly so, it isn't *strictly* a layer
> 2 virtual forwarding function.
>
> Other virtual forwarding technologies allow for additional
> concepts that 'break' this strict layer separation beyond
> what the openvswitch module provides.  The most handy one for
> openvswitch to start looking at is the concept of the socket
> map, from eBPF.  This is very useful for TCP connections,
> since in many cases we will do container<->container
> communication (although this can be generalized for the
> phy->container case).
>
> This patch provides two different implementations of actions
> that can be used to construct the same kind of socket map
> capability within the openvswitch module.  There are additional
> ways of supporting this concept that I've discussed offline,
> but want to bring it all up for discussion on the mailing list.
> This way, "spirited debate" can occur before I spend too much
> time implementing specific userspace support for an approach
> that may not be acceptable.  I did 'port' these from
> implementations that I had done some preliminary testing with
> but no guarantees that what is included actually works well.
>
> For all of these, they are implemented using raw access to
> the tcp socket.  This isn't ideal, and a proper
> implementation would reuse the psock infrastructure - but
> I wanted to get something that we can all at least poke (fun)
> at rather than just being purely theoretical.  Some of the
> validation that we may need (for example re-writing the
> packet's headers) have been omitted to hopefully make the
> implementations a bit easier to parse.  The idea would be
> to validate these in the validate_and_copy routines.
>
> The first option that I'll present is the suite of management
> actions presented as:
>   * sock(commit)
>   * sock(try)
>   * sock(tuple)
>
> These options would take a 5-tuple stamp of the IP packet
> coming in, and preserve it as it traverses any packet
> modifications, recirculations, etc.  The idea of how it would
> look in the datapath might be something like:
>
>    + recirc_id(0),eth(src=3DXXXX,dst=3DYYYY),eth_type(0x800), \
>    | ip(src=3Da.b.c.d,dst=3De.f.g.h,proto=3D6),tcp(sport=3DAA,dport=3DBB)=
 \
>    | actions:sock(tuple),sock(try,recirc(1))
>    \
>     + recirc_id(1),{match-action-pairs}
>     ...
>     + final-action: sock(commit, 2),output(2)
>
> When a packet enters ovs processing, it would have a tuple
> saved, and then forwarded on to another recirc id (or any
> other actions that might be desired).  For the first
> packe, the sock(try,..) action will result in the
> alternativet action list path being taken.  As the packet
> is 'moving' through the flow table in the kernel, the
> original tuple details for the socket map would not be
> modified even if the flow key is updated and the physical
> packet changed.  Finally, the sock(commit,2) will add
> to the internal table that the stamped tuple should be
> forwarded to the particular output port.
>
> The advantage to this suite of primitives is that the
> userspace implementation may be a bit simpler.  Since
> the table entries and management is done internally
> by these actions, userspace is free to blanket adjust
> all of the flows that are tcp destined for a specific
> output port by inserting this special tuple/try set
> without much additional logic for tracking
> connections.  Another advantage is that the userspace
> doesn't need to peer into a specific netns and pull
> socket details to find matching tuples.

What if there is no match on tcp headers at all? Would userspace also
add these actions?

I guess you could argue that, if OVS is not being asked to do L4, this
feature would not apply, but what if it's just the first flow that
doesn't have an L4 match? How would userspace now how to add the action?

>
> However, it means we need to keep a separate mapping
> table in the kernel, and that includes all the
> tradeoffs of managing that table (not added in the
> patch because it got too clunky are the workqueues
> that would check the table to basically stop counters
> based on the tcp state so the flow could get expired).
>
> The userspace work gets simpler, but the work being
> done by the kernel space is much more difficult.
>
> Next is the simpler 'socket(net,ino)' action.  The
> flows for this may look something a bit more like:
>
>    + recirc_id(0),eth(src=3DXXXX,dst=3DYYYY),eth_type(0x800), \
>    | ip(src=3Da.b.c.d,dst=3De.f.g.h,proto=3D6),tcp(sport=3DAA,dport=3DBB)=
 \
>    | actions:socket(NS,INO,recirc(0x1))
>
> This is much more compact, but that hides what is
> really needed to make this work.  Using the single
> primitive would require that during upcall processing
> the userspace is aware of the netns for the particular
> packet.  When it is generating the flows, it can add
> a socket call at the earliest flow possible when it
> sees a socket that would be associated with the flow.
>
> The kernel then only needs to validate at the flow
> installation time that the socket is valid.  However,
> the userspace must do much more work.  It will need
> to go back through the flows it generated and modify
> them (or insert new flows) to take this path.  It
> will have to peer into each netns and find the
> corresponding socket inode, and program those.  If
> it cannot find those details when the socket is
> first added, it will probably not be able to add
> these later (that's an implementation detail, but
> at least it will lead to a slow ramp up).
>
> From a kernel perspective it is much easier.  We
> keep a ref to the socket while the action is in
> place, but that's all we need.  The
> infrastructure needed is mostly all there, and
> there aren't many new things we need to change
> to make it work.
>
> So, it's much more work on the userspace side,
> but much less 'intrusive' for the kernel.

I'm quite intrigued by what would userspace have to do in this case.
IIUC, it would have to:
1) Track all sockets created in all affected namespaces
2) Associate a socket with an upcalled packet
3) Carry this information throughout recirculations until an output
action is detected and the destination socket found.
4) Traverse the recirculation chain backwards to find the first flow
(recirc_id(0)) and modify it to add the socket action.

Is that what you had in mind or am I completely off-track?

Thanks.
Adri=C3=A1n


