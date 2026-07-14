Return-Path: <netdev+bounces-307348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Oa7MElewVWrkrgAAu9opvQ
	(envelope-from <netdev+bounces-307348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 05:43:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 986A7750B16
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 05:43:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bBblbe5u;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307348-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307348-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 692AA303D73C
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 03:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBAA3812FE;
	Tue, 14 Jul 2026 03:43:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354CA3019C3
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 03:43:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784000596; cv=none; b=NHQ3UsubZkm+3LlZOPcBbBiriYtcfeuA1y91BOPpe+fXW0vS7S1uFlCzLWjOnh3VrwKR4ay3UrNTcvPO+KLO4lU7h/6nxxu4S+uxpuHaz3qXYizMuPV0QPhAox6taU06mPE/oxvQLzyrJsh54dMXRe3pPtSjilfg0x5XPQR2M3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784000596; c=relaxed/simple;
	bh=3xsN4uBCWLq5tHOAX5AMM6paFjntauoohN7uitBI7RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qwXJw/A5ZiebkKJQ+o0bCmdYHXqDxrtep43iOQusoxnp3JXSnLwS6TD6kQ/KiH6nimdU/LtXVvfp87lw0h+2GDj9alXK1oZ0iq/ew7L4Sz+WK/pJnC0ES6nQsAyskLdhvzx7ibcx1Da6ZWN/h7tfH3hreQUgeiydlNuDvr9C1MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBblbe5u; arc=none smtp.client-ip=209.85.215.171
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9aea40d799so229040a12.0
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 20:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784000594; x=1784605394; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c15ToLvk2TWn4ce0WK3+PbGKvmB3+LUIwFChhfNis8c=;
        b=bBblbe5uAuc6QuRb8vRshkiWpL+iRZWwun5o0tBOiDo9AzY19tPXDdsoeD11FYmiSG
         QQdIp5pgBppsTI6brRkGPYysqylBmziVQSniU1SYtWC/a5hShuSqy/FMRmrO8PZbyzc+
         rO6TJz65r+qb/zggocYPZ665Qf7vA8SCttgX3TSp29HiHp2DQ9YSAxjMDM++AHPtwFqP
         4vp5jCYpTuINOcHNaFOXoe/iVpfLiwouh9A3Dgd21PQf+Pj/BYAvL2BSSJOkwG0yP4+B
         fo7rpSjV4Lc4h8LPq6U5CZPkWxGHz5kuwLHevdkRIXDpdwoDM+xemdLTtDDY+Ez0bKTu
         NNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784000594; x=1784605394;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c15ToLvk2TWn4ce0WK3+PbGKvmB3+LUIwFChhfNis8c=;
        b=JQjo+rKx029N3uqlxJBMTOYsHtR9UTv0byjxgnxBd4GbYi9/R1djw3IBs9oF7lhVZS
         PeS3I9L1yahdU2QkpGidh7rDv9GY5OKTgP8YBxrmIeF/nGDS36w6Z6CitvvlMN6dE9rs
         eY+rwAUEzMP+423QMw00aD082ic1A1MteXBAfcEg1cuMeSRBLp2Cg0hZDNlgn4zigou3
         b8fcpjb2v6kSNyOjfVbqQDgi8DImDYBpieDGjHRe3whE3OOW50t3/oXEYuCRfy3NCiRc
         Qmfv5QdI6cDPwsudLPRF6iJ7iWYFXo/QHGLcLVAHvXSp079+2LdnLajxzEdyb6dLdQjX
         kFXw==
X-Forwarded-Encrypted: i=1; AHgh+RpSyMsLhH1mSgOXCrZfZ9WSVcWerPCnv1QM1pUrIfFG4yewssKx9KBhOYr6xFRvJ6PLIGCaioQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHMeDbE09xhY9zL8mp6cuobE2g+cXZCCbTGSPAkQy4q4JK+FtR
	qBf+vqezEIgDUwRvRRF/t6duWSIQCLLQlWEezbrwKcCJRBWuoKNQ7sal
X-Gm-Gg: AfdE7clsLFC6fXJLqjIcCWAnhNS8d5qKSG83BbRr5t9NoblyPycbwBJJRGYjd0pgnMJ
	Ja2FOUchREvFq7YTq+bYrE1A5LBBdW8ymqYr/QGkFO8iOrSlfqmgEdHTMzREDWq8cWZN+xLdyqW
	1hS2xuZWXf1vJ4qvLCVjB8UWd764NAsfC7wWINgMU8FqyXsyECcnRq7PzmL1ha5lomWqqSPGZlg
	ihY13ZpSrs0v1kTdtcoqv0thD97YpHLzkIev2/iFWn/4D4+wL1nKOWmQ5SuFUPeoY38gwcp+Gzr
	fW/W5O1EOZfHyOjHyGrv2stbISR/ZXU2mh50QWs86joUeoO2A3/2dvuc0adZERmgOaU7fC87okr
	h/EdvnPrW9gGP3Wrhe2tdmcMPn6VaESk8w7X+/MO5NzwDrs2kjYkkXIN/tU6vb4854b5YwcpmWC
	FJIM0MfVzJDBazxaz8P1HsAIPv/RZqGMLuA946KNxJ1H2fvgVm/xIAG9F3
X-Received: by 2002:a05:6a21:3116:b0:3bf:ab4b:2d34 with SMTP id adf61e73a8af0-3c110ad50a7mr11817353637.53.1784000594422;
        Mon, 13 Jul 2026 20:43:14 -0700 (PDT)
Received: from CPC-mjac-HKWGEZ.redmond.corp.microsoft.com ([70.37.26.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca7f626fb78sm7221051a12.13.2026.07.13.20.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 20:43:13 -0700 (PDT)
From: Jack Ma <jack4it@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jack Ma <jack4it@gmail.com>
Subject: Re: [PATCH net-next 0/3] net: nexthop: per-nexthop UDP dst port for fdb (VXLAN) nexthops
Date: Tue, 14 Jul 2026 03:43:09 +0000
Message-ID: <20260714034309.2226-1-jack4it@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713122339.GA548566@shredder>
References: <20260712191218.236-1-jack4it@gmail.com> <20260713122339.GA548566@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307348-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[jack4it@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jack4it@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack4it@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 986A7750B16

On Mon, Jul 13, 2026 at 03:23:39PM +0300, Ido Schimmel wrote:
> > Some deployments pack several receivers behind a single underlay IP and tell
> > them apart by UDP destination port.  To spread flows across such receivers they
>
> I don't understand the "tell them apart" phrasing. Aren't all of these
> receivers interchangeable given you are load balancing between them?

Sorry, that wording conflated two separate things. The load-balancing
targets are interchangeable; the UDP port is not what makes them
distinct services, it is how the underlay addresses each one:

  - Addressing: several VTEPs are packed behind one underlay IP, each
    reachable at a distinct UDP destination port. The port is the
    underlay demux that delivers an encapsulated packet to the right
    VTEP -- it selects *where*, not *which service*.
  - Load-balancing: when those VTEPs form an HA set (shared inner
    MAC/IP), a sender spreads flows across them with an fdb nexthop
    group. The legs are interchangeable, but each one lives at a
    different (underlay IP, UDP port).

So the legs are interchangeable endpoints that happen to sit at
different (IP, port) addresses. A group can already carry a distinct IP
per leg but not a distinct port, which is the gap here. I'll reword the
cover and patch 1 to say this explicitly.

> I think you will need to provide more details about the use case [...]
> In your use case, why can't the load balancing happen at the target
> host (e.g., using XDP / TC / SO_REUSEPORT / flow classification)?

I think the key difference is that there isn't really a shared
host-side datapath to load-balance in, and the UDP port is doing demux
rather than load-balancing. The shape is a bit unusual, so maybe a
couple of pictures help.

First, how forwarders sit on a receiver node. A forwarder here is
just the pod that terminates the overlay tunnel (it hosts the VXLAN
VTEP) and relays traffic to and from one tenant's workload. Many such
pods share one mesh-routable underlay IP, each demuxed by UDP port:

  receiver node -- one mesh-routable underlay IP (NodeIP_A)
  +----------------------------------------------------+
  |  host netns: stateless outer-UDP demux by dst port |
  |              (host does NOT terminate the tunnel)  |
  |                                                    |
  |     dst :40000        dst :40001        dst :40002 |
  |         |                 |                 |      |
  |   +-----v----+      +-----v----+      +-----v----+ |
  |   | pod0 ns  |      | pod1 ns  |      | pod2 ns  | |
  |   | vxlan    |      | vxlan    |      | vxlan    | |
  |   | VTEP     |      | VTEP     |      | VTEP     | |
  |   | decap    |      | decap    |      | decap    | |
  |   +----------+      +----------+      +----------+ |
  +----------------------------------------------------+
  (up to ~10 forwarder pods packed per node)

  These packed pods are unrelated -- different tenants on different
  VNIs (below) -- so the per-pod UDP port is node-level demux, not an
  HA construct. A single forwarder's HA replicas are the orthogonal
  axis: anti-affinity spreads them across nodes (never co-resident),
  so one member's nexthop group has its legs on distinct node IPs.
  But each leg is still reachable only at (node IP, that pod's UDP
  port), so within one group the legs differ in IP *and* port. A
  group can already carry a distinct IP per leg, but it takes the UDP
  port from the device (a single value), so it can't send each leg to
  its own port. That last part is really the gap we keep running into.

The pods sharing a node need not be related: each one belongs to a
separate tenant on its own VXLAN VNI, and a node can pack forwarders
for many of them, each on its own UDP port. That per-pod port is what
lets different tenants co-locate without colliding, and the host --
which only demuxes outer UDP -- never has to reason about tenancy.

Zooming into one forwarder pod, there isn't really anything to
load-balance on the host: the tunnel terminates on a vxlan device
inside the pod's own netns, and the pod reaches the customer through a
separate NIC:

  one forwarder pod -- its own netns, tenant VNI X
  +-------------------------------------------------+
  |                                                 |
  |   on/off-ramp NIC   <--- customer data plane    |
  |   |   on-ramp (ingress) / off-ramp (egress)     |
  |   |   inner packet                              |
  |   vxlan (VTEP)   encap / decap for VNI X,       |
  |   |              listens on this pod's UDP port |
  |   |   outer VXLAN UDP                           |
  |   eth0 (underlay)   NodeIP:port                 |
  |   |   to peer VTEPs over the                    |
  |   v   mesh underlay                             |
  |                                                 |
  +-------------------------------------------------+

The load-balancing already happens at the sender -- the fdb nexthop
group hashes the inner flow and picks a leg. The only missing piece is
that the selected leg can't carry its own UDP port, so the sender
reaches the right pod's IP but always the device's port.

The host-side alternatives seem to assume a shared datapath that isn't
really there in this design:

  - SO_REUSEPORT balances sockets within a single netns; here the
    receivers are in different netns -- in fact different tenants --
    so there isn't a shared host socket to reuse.
  - An XDP/TC host fan-out would mean the host has to become a VTEP --
    terminate the tunnel and re-dispatch inner traffic across netns
    and tenant/VNI boundaries -- which puts the host into the tenant
    data path (today it only does a stateless outer-UDP demux) and
    largely duplicates what an fdb nexthop group does: hashing an
    inner flow across a set of endpoints. The group can already vary
    the leg's IP; the port is the part it can't.

On the uAPI cost: I don't think this adds a new datapath concept. A
single fdb entry already carries a per-destination UDP port (NDA_PORT),
and vxlan_xmit_one() already prefers rdst->remote_port when it's set.
NHA_FDB_PORT is meant to be the nexthop analog of that existing
attribute: control-plane only, no datapath change, and backward
compatible (a leg with no port falls back to the device port as today).

Happy to go into the deployment/addressing constraints in more detail if
that would help.

Thanks for the review.

