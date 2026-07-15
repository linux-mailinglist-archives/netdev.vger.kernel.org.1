Return-Path: <netdev+bounces-307686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id goiaHDE6V2rdHgEAu9opvQ
	(envelope-from <netdev+bounces-307686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 09:43:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD5575B8B5
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 09:43:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qkds8EwA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307686-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307686-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60A64300748A
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59A13C4165;
	Wed, 15 Jul 2026 07:43:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7393C3791
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 07:43:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101421; cv=none; b=DDWTdD2uCEro2GCrytDOc8KevSgdOVSlsrjrXRazCfToPoikWUR5q/Ng8M5onWOIm+buEPq1ZX9d0Dfi1/l7OnxTQtSLYEcblp76I8xwcXh2IReu9ABV9j3VVXq3WA4Q+9yadPwslbXJ8te+9wQ01KX9KLBJj4uzxtLOmjP5cfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101421; c=relaxed/simple;
	bh=Dqabu4UeNovAvh+LzyIVlcZ/EhWLpGQw3HuptsIqWcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+/3lVn9KVE1M6gAv70gypcVh80hGNfy6YAzqSSmNSDUCNPo4fsqegNGBVL0qJzY+Bz8pl51TRUaV0Vp/FJrREgBBJzqvaO3ZtfY+Jf2MgMlZMggFHdbzjKvTTM/STZczoxZ/wkoc1OBtKFLfvwyEjsrdKaLwnGxI1j/GSkjMCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qkds8EwA; arc=none smtp.client-ip=209.85.210.179
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-848643382fcso5787342b3a.1
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 00:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784101420; x=1784706220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GC1e/5Hz543x6Xbvz3bOQl04AkOMjBv03xL6AoR9lwc=;
        b=qkds8EwA3LRnpbK7vx86S0AAu6Fprq6DEz5sL6wGfwMozzSXXkMf45eVTiXmFLC3PF
         6oWmFt/7QQQFef831SzFjdW/2ENlfBWdt73ibW3Ryr3+tvtt8CgxpSkFPJ5R54EXTJoF
         Kfb7GIg/ZP4EqSBP3nWv0POFJVwTsaHgE4qpyI4yv4lT5EN4fnI2yDAFesRxBXbps06+
         GiD2o4niv0JiLuoYaw7b0dDF6ggClaQtCQxPElGFxYTJu74JH3UoGzN6sNstwcA9Hb2A
         SEaV/kgPHn18Y/Cn8N3I2TPgEL+c1CMHKHegEgja4EB+AUnHfr6LLzyxodK8bkN06Dek
         51JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784101420; x=1784706220;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GC1e/5Hz543x6Xbvz3bOQl04AkOMjBv03xL6AoR9lwc=;
        b=sGRhXk+YjZSrzRv6xYSTjoMP1zIVv6woLEAG2I626G0D1dlTpkPcK+p4cJmQKPucri
         o7VhbWIdsD4LghVxsHLDR+6XZO/VdV2Nz1HpDAUFEMUSauuiUX8bAPTEKERAENVYGSQZ
         z09N13QQ4s0dK3YpIdPIa6ke52Dq6Tbn9gvKGx94a9+st5IXzOOnsTpTIduolq8gphtF
         bjIn7J6Gv6qtCtEOvHr1CCX6LgiG3ZuiwCrLjYQsS7Xn+uBikIg1GFYp9WbWvN91ku8a
         Qplq+AFjVITREtM5bBjKpWRq8LHbdlFNmaRv5rfryOCfSprfelXVZ4BzEPIf/enFAETM
         Tnhw==
X-Forwarded-Encrypted: i=1; AHgh+Rq3NLu4QhqYV7PZIpk20CQkVBXD5aUlmSy5O7YEYSIRriEpG1mh9fMJ+8wZvVxfKw4VaQfFXCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Q06gqJhNMqLwNXFX4lV2x7UU/lqzbJCaVu1fY5MxtOL90Shg
	q+zYajr9/kwchOA5r+DQjHtODijepRcMLIABxYF2eFHcTVe131Ex70wv
X-Gm-Gg: AfdE7cn1fOFJerN0qwCE/JBtaf4p5N5o4N+Vwq7d6i2HDCgzbcdfZESerK3pZu6TNl1
	TDj5zi+AzO3YA2WBOdO1MM8dF5dLpMoUB9ynPG6aHuuVYvCqrsdeY1s+eJiLpYKJyCGIlAJLljP
	F+CeXhB4HZY8m8DPkXLl03oymREhb4q8S3Xj1NeWmm0+dWFGfq9plLgQi6s/AqZi1tQsVhQYx3T
	Zt+vErkCtjtazVr9a0ATl7icFSG/s+AS+OxF9h0Tf/PKI2XV3b4hPMZc4WpLYvDYDATPepxumQ4
	Px8+SIgGwIODSQdhOdEGNdosibzmiOuLJj64La/GPqsvQoz1jRLGolSI6dySZKdL+nOCOFWhb8R
	nilS9ijeJUeEJrHbBSv4wM8t2wUXhhEyhY9DnBSLz6cMxpvC+2waLbvpYEbhsVr262Mbpi225XM
	GCfuwBFV0vlQrO/gjfcKqGSBV2KCwCbKiQ5QtO8F4lLaWBKw==
X-Received: by 2002:a05:6a00:855:b0:848:4ff5:5311 with SMTP id d2e1a72fcca58-84a51467aedmr6726397b3a.28.1784101419571;
        Wed, 15 Jul 2026 00:43:39 -0700 (PDT)
Received: from CPC-mjac-HKWGEZ.redmond.corp.microsoft.com ([70.37.26.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f7dade0sm2666238b3a.46.2026.07.15.00.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 00:43:39 -0700 (PDT)
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
Date: Wed, 15 Jul 2026 07:43:17 +0000
Message-ID: <20260715074317.2271-1-jack4it@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714174201.GA1037700@shredder>
References: <20260712191218.236-1-jack4it@gmail.com> <20260713122339.GA548566@shredder> <20260714034309.2226-1-jack4it@gmail.com> <20260714174201.GA1037700@shredder>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-307686-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jack4it@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jack4it@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack4it@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DD5575B8B5

On Tue, Jul 14, 2026 at 08:42:01PM +0300, Ido Schimmel wrote:
> It's unclear to me why you need the UDP port based demux. On a single
> node, do you have multiple pods that belong to the same tenant and
> therefore share the same VNI? From the above, my understanding is that
> the answer is "no".

Good question, and I think my earlier framing sent you down the wrong
path, sorry about that. The honest answer is actually "yes". By design
a node can hold several VTEPs on the same VNI, as long as they belong
to different HA sets. Anti-affinity only keeps the two replicas within
one HA set off the same node. Two pods from different HA sets on the
same VNI are free to co-locate, and that co-location is the case that
needs a per-pod port.

> Assuming the answer is "no", instead of having multiple VXLAN sockets
> in the host netns (each bound to a different port), why not have a
> single VXLAN socket bound to the standard port (4789) and let the
> VXLAN driver perform the demux based on the VNI? [...] creating
> multiple VXLAN devices in the host netns that only differ in their
> VNI and then move each to the relevant pod netns.

For different-VNI pods that is a clean fit, and I want to try it out
regardless. The outer packet still carries the VNI, so a shared socket
can steer by VNI without decapsulating, and the host never touches the
tenant frame.

Where it stops working for me is two same-VNI pods on one node. They
share the underlay IP, the port (4789), and the VNI, so the outer
header is the same for both:

  outer: NodeIP:4789, VNI=X  ->  pod A (HA set 1)
  outer: NodeIP:4789, VNI=X  ->  pod B (HA set 2)

There is nothing left in the outer header to steer on, so the host
would have to look past it and terminate the tunnel itself, which is
the VTEP role I would rather keep inside the pod. A distinct port per
pod puts the distinguishing bit back in the outer header, so the host
can stay a stateless outer-UDP forwarder.

> Given the anti-affinity constraint, you will only need to load balance
> between pods on different nodes that use the standard port and that is
> already supported by the FDB nexthop groups.

Agreed that the across-node load balancing already works. What the
VNI-demux version costs is packing density. With one shared underlay
IP per node, VNI demux allows at most one VTEP per (VNI, node), so N
same-VNI HA sets of two replicas need 2N nodes. With a per-pod port
the same sets fit on two nodes (replica 1 on node A, replica 2 on node
B, each pod on its own port), and anti-affinity still holds. For 5
sets on one VNI that is 10 nodes versus 2.

So the port is not strictly required, and your VNI-demux model is a
real option I will prototype. The tradeoff I am weighing is density
plus keeping the host out of the tenant datapath, against the uAPI
cost, which is small: NHA_FDB_PORT is the nexthop analog of the
per-entry NDA_PORT that already exists, it is control-plane only, and
a leg with no port behaves exactly as today.

Happy to keep digging if it is useful. Thanks again for thinking it
through with me.

