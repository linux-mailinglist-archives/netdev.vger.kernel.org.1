Return-Path: <netdev+bounces-112319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 674529384E9
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 15:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2091F212D1
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 13:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C50161339;
	Sun, 21 Jul 2024 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEOLgzVP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B79D4414
	for <netdev@vger.kernel.org>; Sun, 21 Jul 2024 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721570144; cv=none; b=ExWYqKC0veQK+AlmVJN2zrjnkeEVL5/Dt8luqx9hdoK/BCMVj8dWIlV77emBEfVTTpiZ2H7Iu1GrvfV3CmumPmINJisyo3i5Wsg0YgGAGob8Zlgx3aLAqmZu3cYe3UKToWJtBSAeHZz8JWz1u5KH6sHVxBaM0U8jF/fQrtJM+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721570144; c=relaxed/simple;
	bh=bxseoDb+uRHz1mHEstzv4TtMiiiWJnYUpTlt/lF15sY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=GKBBwOEFre41omd83tyypIe7Z/xa7bj8jp8iK9xLD6DzDj1FwUGqjqeVo0uN2XbxNY/E/phFbpcoIF3Nw5sDQxnfQOkBc2ZlZ1W/OmTEIex/XD/Sx32FtbWcxClIB1n8GonngjJCaE1F0AY1RHl8I8ku57rYeWZK6XaV9BidYwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEOLgzVP; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-66493332ebfso30814847b3.3
        for <netdev@vger.kernel.org>; Sun, 21 Jul 2024 06:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721570141; x=1722174941; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qdgCLlcc6BKdV14Br9A+jG/cSvwVX8eK0b3c82wpcIA=;
        b=QEOLgzVPNMxqCVtz+i6VeNaxYADt1DhXd0NYUw/6su+msELq37jpaxXTsX5bGkxS6f
         OLwtIXo5gaL84LGLPcJVbJo34iIyxsuMIeQwapg+Qc9rHuB+gIFISin0VtHDkOF5nxVp
         s3AnxtuAZsBL4mhCAydo5FUakeeQpIP9bEujavjKUJBGkI1FIJK9XI0ACI5n0JA6hYZn
         4CGj5GmKwZ94r1puYFyv/63/TjI+vUMlRPjJu+wPOfRiMtrFYU+mbNW540ienYuC9Q28
         /3RGIOTL+s0tBMbMCFWJ8Pt5oqYBYARt0pDBAs/5NoCUNaagoaqd51USuq6TwlPgnoKg
         JzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721570141; x=1722174941;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qdgCLlcc6BKdV14Br9A+jG/cSvwVX8eK0b3c82wpcIA=;
        b=cMLNdCjBWt56ElFhM1kQ+SMcpZ/uzuZlovvlRwdWTwoorpjva/xICiIFskqCLc3JN5
         eEXaFU9xkfH4JE/qUxSWnVUmY86HFacm/XhpPNmK+//GoHTm385E7s+h+Z/oy1ymPj4+
         U1mtTVLpONRPNm2iheV5MTVi6stLa9rl6BaN06GjkFWD1bwBQk7SoZchlLY+E0q9ldLT
         k1x+w/+b1CMwI085+heDPgzKM6vqKGPBvZRA69bjHh34xkhVWXuZX/PWKhNI56H8JI6I
         Nwe9LMc0TWpK2+kq5DLvQKfncAKcsso4uo+6T303O3K/PLf/EDJphmqGUmHXj6TtXDS3
         3c8w==
X-Gm-Message-State: AOJu0YxUGkQfZMauYFHDikL04T/+9C2NZgJCrveT9b0i+x4056eEBC+T
	m1Ol+S2OBcPdKsxdukypCR0K/HysXGmOAH+j1kSTzDiQfGB0DCN8Ju5hRDB4iQFIt/JYcrgULFU
	FbZw+5W1OF6prwSgIi3cEGQUNL1IjW4Ll28Q=
X-Google-Smtp-Source: AGHT+IHvAxpNE98EODDwth1Fmh0QKbAmejQkqNxS97612/x8hOwrOpxevoCS25Fxf/HQvGPNxKjUbjMKwP6xWX3uNjQ=
X-Received: by 2002:a05:690c:1d:b0:65f:7ac6:7f69 with SMTP id
 00721157ae682-66a684c2c6dmr73512397b3.6.1721570141098; Sun, 21 Jul 2024
 06:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Guy Avraham <guyavrah1986@gmail.com>
Date: Sun, 21 Jul 2024 16:55:30 +0300
Message-ID: <CAM95viF6QsbSq0u3D361Xif28q-yGLGJT_qk7+C3fj2=Op3o4Q@mail.gmail.com>
Subject: Potential issue in networking sub system when handling packet with IP
 router alert option
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

1. Introduction:
First, if there is anything I should do differently with respect to
the mailing list "procedure" please
let me know (I have never written nor subscribed to any mailing list
related to Linux kernel
development).

My name is Guy Avraham and I am an embedded Linux engineer.
I am new in the world of Linux kernel networking domain.
I am facing an issue related to the handling of IP packets that have
the IP router alert option present in their options section.

I am working with kernel version 5.2.20 which is compiled to X86_64
architecture (let me know if further information is needed). Also, I
am quite sure that the issue is also present in later versions of the
kernel.

2. Preface (problem description):
According to RFC 2113, the presence of the IP router alert option in
the IP packet header means that (section 2.0):

"The goal, then, is to provide a mechanism whereby routers can
intercept packets not addressed to them directly".

One such protocol that leverages this option, is the RSVP. The
situation I am facing is the following: I have 4 routers in a "row"
topology (for the matter and for simplicity). Lets name them:

R1 ---> R2 ---> R3 ---> R4

R1 is the RSVP tunnel "head". R4 is the RSVP tunnel "tail".

The RSVP's goal is to construct a tunnel from R1 ---> R4. For that to
happen, R1 sends an RSVP message (i.e. - RSVP Path message towards
R4). Note that the source IP of this packet is R1's IP and the
destination IP address of this packet is R4's IP. It (the RSVP Path
message) should pass and be processed by ALL routers along the path,
which in this case are R2 & R3 (and finally of course R4), just as it
says according to the RSVP RFC, section 3.1.3:

"Each RSVP-capable node along the path(s) captures a Path message and
processes it to create path state..."

At some point of time, due to network issues (which are legitimate),
R2 does NOT have a route to R4, i.e. - in the RIB and FIB (Routing
Information Base and Forwarding Information Base) of R2, the address
of R4 is not present, therefor, R2's networking layer in the kernel
"thinks" it can NOT "route" packets (and in particular the RSVP Path
message) towards R4. The RSVP application on R2, HOWEVER, as mentioned
above, due to the presence of the IP router alert option, MUST receive
the RSVP Path message that arrives at him (in order to process it, and
forward it to the next "hop" down the tunnel path), but it does NOT.


3. Linux kernel networking part:
When the situation above takes place, i.e. - R2 does NOT have a route
to R4, it appears, that the ROUTING logic (phase of the netfilter
flow) that this packet traverses within R2 Linux kernel causing the
message to be dropped, thus leaving the RSVP application NOT getting
the message even though it should. While, on the other hand, where the
same situation takes place, BUT R2 does HAVE a route to R4 --> the
message is passed towards the RSVP application (via the proper
socket). The RSVP application opens a socket and set the
IP_ROUTER_ALERT option for it (like so: setsockopt(sockfd, IPPROTO_IP,
IP_ROUTER_ALERT, &router_alert, sizeof(router_alert)).

Recall, that in BOTH situations, the IP router alert option is present
in the IP header packet (of the RSVP Path message), HOWEVER, it seems
that in the "problematic" situation, it is not being considered (or
its presence is not "strong enough" to enforce the message to be
passed to the RSVP application).

4. The "relevant" function:
I looked a little into the Linux kernel networking code, and found the
following function: ip_call_ra_chain (from the net/ipv4/ip_input.c
file).
The (main) objective of this function is to "pass" the packet to any
"relevant" socket, which in my case will be the socket of the RSVP
application.
This function is invoked (used) twice:

net/ipv4/ip_forward.c, line 110
net/ipv4/ipmr.c, line 2101

The call to this function in the ipmr.c file is not relevant in this
case (but is, for example, for IGMP).
So the only call to the ip_call_ra_chain in the flow that the RSVP
Path message goes via, is within the ip_forward.c file, within the
ip_forward function.

5. Linux kernel networking subsystem design:
As of my understanding of how the networking stack of Linux kernel
works, the ip_forward function is called AFTER the IP_ROUTING logic
takes place. So for every IP packet that arrives at some host, where
the destination IP of the packet is NOT the IP of the host, the
"trigger" that will pass the packet (of the RSVP path message) to the
relevant application is the call to the ip_call_ra_chain within the
ip_forward function (i.e. - will pass the packet to the RSVP
application in this case).
However, if the host that receives the IP packet does not have a route
to the destination IP address of the packet, it will drop the packet
EARLIER in the routing phase (net/ipv4/route.c line 2310)
i.e. - in this case, the RSVP path message that has destination IP
address of 4.4.4.4 arrives at 2.2.2.2 WHILE 2.2.2.2 does not have
route to 4.4.4.4 --> so the IP router alert is not being
taken into account, thus causing the kernel to drop the packet and not
pass it to the RSVP application.

6. Proposed solution:
As I see it, the call to the ip_call_ra_chain needs "somehow" to be
used "earlier" in the flow of packet traversal in the Linux kernel.
What I am thinking to suggest is that RIGHT after the fib_lookup check
in the above mentioned location in the code (i.e. - in
net/ipv4/route.c line 2311), if indeed the lookup was unsuccessful
(i.e. - err != 0) --> then the call to the ip_call_ra_chain will be
used.
Then, if the  ip_call_ra_chain function returns false, the code
continues as is, while if it returns true (i.e. - the packet was
successfully passed to all relevant sockets), then the err = 0 and the
code will "goto out".

Does that seem like a valid fix for this issue? Please let me know if
anything else in this fix is problematic and/or anything I have not
taken into account.

Please let me know if any kind of information is needed or if anything
is not clear in this query.

Appreciate your reply!

Thanks,
Guy.

