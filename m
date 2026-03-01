Return-Path: <netdev+bounces-262351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM76Lxqfo2mZIgUAu9opvQ
	(envelope-from <netdev+bounces-262351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 03:06:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4241CCF6C
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 03:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47D31304E74F
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 01:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3536D26D4F9;
	Sun,  1 Mar 2026 01:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nnOqDWVg"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA162BD5BD;
	Sun,  1 Mar 2026 01:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330268; cv=none; b=HIPu7ZAopwDCSd2fYPXkTVr2umaqd+SziQqsdyFQKxBAAJdsc51hnHDHXtj0nM6J6gBy2cupxNsbdQlxgd877KoKxtyEXxDoVR6fUeh/azZ1/jGLvtBFD6AHRaESDppNLPhsx14+J0BaGlZn2jfcYzBvmBOnwK5uoK6SgI4j/Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330268; c=relaxed/simple;
	bh=lHU3xSKCjFyLDiY7ZphFFUEStuVglwcMF7pvWtxWCMQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Bw1pKo0JUGcgD2oaUEnomABH3XKdG50XgdRpH2MxUqckuV60TEEuMQo5BjeFSP3W2usZXa8z+eC6eJ/fZkSwme0m4rjcqU0LfaUNkUxW3vNKTjnR1OcAkPJsgE6u9jAqzURLTWHA0uBZXLyiwnVX6xzAI9+w2sm4fBZ0uDOjLFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nnOqDWVg; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772330263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxadtNbQWhlhzbbOR6btZRdIspmuB+siJad9zZNDOPI=;
	b=nnOqDWVgZguYU3rnRRI/jxJEmQTIxV7NcyNEPpLrHmeoWcN5FCuGrsQRRusW76yHk2PMEE
	XisHpvxlb7pq/Sfl+b2GChJrhwu1YVhL1Bvw9sCx9f3AHS10TyiS2+4od3jlF2+PQ3VB5e
	zepdnHuQ/gAh4E8fI2NqvO4MjkudiOY=
Date: Sun, 01 Mar 2026 01:57:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <d3722ec10046a2fde021a2b8a51a83431c8bcbac@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v1] net: nexthop: fix panic when IPv4 route
 references IPv6 nexthop
To: "Eric Dumazet" <edumazet@google.com>, "David Ahern" <dsahern@kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "Jiayuan Chen" <jiayuan.chen@shopee.com>,
 syzbot+334190e097a98a1b81bb@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman"
 <horms@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <CANn89iJjjNW4U6ZxVcuRxWaKPbo1wfEyBD4Etkf+f6CWyhAHFg@mail.gmail.com>
References: <20260228031400.163009-1-jiayuan.chen@linux.dev>
 <20260228073959.0ef1b33f@kernel.org>
 <3a00c5bf-6740-47c3-b885-c1e0cfe62289@kernel.org>
 <CANn89iJjjNW4U6ZxVcuRxWaKPbo1wfEyBD4Etkf+f6CWyhAHFg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262351-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,334190e097a98a1b81bb];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fib_nexthops.sh:url,shopee.com:email,gre_multipath_nh.sh:url,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: BF4241CCF6C
X-Rspamd-Action: no action

March 1, 2026 at 01:04, "Eric Dumazet" <edumazet@google.com mailto:edumaz=
et@google.com?to=3D%22Eric%20Dumazet%22%20%3Cedumazet%40google.com%3E > w=
rote:


>=20
>=20On Sat, Feb 28, 2026 at 5:33 PM David Ahern <dsahern@kernel.org> wrot=
e:
>=20
>=20>=20
>=20> On 2/28/26 8:39 AM, Jakub Kicinski wrote:
> >  On Sat, 28 Feb 2026 11:13:59 +0800 Jiayuan Chen wrote:
> >  From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >=20
>=20>  fib_check_nexthop() does not validate that the nexthop family matc=
hes
> >  the route family. This allows an IPv4 route to reference an IPv6
> >  nexthop object. When the IPv4 route is looked up, __mkroute_output()
> >  accesses nhc->nhc_pcpu_rth_output which is never allocated for IPv6
> >  nexthops (fib6_nh_init does not call fib_nh_common_init), causing a
> >  NULL pointer dereference.
> >=20
>=20>  Note that this is not about IPv4 routes with IPv6 gateways (RFC 55=
49),
> >  which uses an AF_INET nexthop with nhc_gw_family=3DAF_INET6 and prop=
erly
> >  allocates nhc_pcpu_rth_output via fib_nh_common_init(). The bug here
> >  is an AF_INET6 nexthop object being directly referenced by an IPv4
> >  route, which is an invalid combination.
> >=20
>=20>  Add the missing family check in fib_check_nexthop(), mirroring wha=
t
> >  fib6_check_nexthop() already does for the reverse direction (rejecti=
ng
> >  IPv6 routes that reference IPv4 nexthop objects).
> >=20
>=20>  AFAICT this breaks a bunch of tests, quickest to repro with is
> >  gre_multipath_nh.sh but you should probably run fib_nexthops.sh
> >  on your fix as well.
> >=20
>=20>  nothing to fix. The patch is wrong. IPv4 supports IPv6 gateways; t=
hat is
> >  a known feature.
> >=20
>=20>  please post the stack trace for the panic
> >=20
>=20https://lore.kernel.org/all/698f8482.a70a0220.2c38d7.00ca.GAE@google.=
com/T/
>


My bad, the previous fix was wrong - IPv4 routes referencing IPv6
nexthop objects is totally via this path.

The crash actually only happens with loopback nexthops, e.g.:

    ip nexthop add id 100 via fe80::1 dev lo

In fib6_nh_init(), nexthop objects always have fc_dst=3D:: (no
destination prefix), so fib6_is_reject() returns true for any
nexthop using loopback device. This causes it to skip
fib_nh_common_init(), leaving nhc_pcpu_rth_output, nhc_exceptions
and nhc_rth_input all NULL. When an IPv4 route later references
this nexthop, __mkroute_output() hits raw_cpu_ptr(NULL) and crashes.

The simplest fix is just allocating nhc_pcpu_rth_output in the
reject path of fib6_nh_init(). The release path already handles
it correctly.


diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index c0350d97307e..4e7c44101709 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3643,6 +3643,12 @@ int fib6_nh_init(struct net *net, struct fib6_nh *=
fib6_nh,
                                goto out;
                        }
                }
+               fib6_nh->nh_common.nhc_pcpu_rth_output =3D
+                       alloc_percpu_gfp(struct rtable __rcu *, gfp_flags=
);
+               if (!fib6_nh->nh_common.nhc_pcpu_rth_output) {
+                       err =3D -ENOMEM;
+                       goto out;
+               }
                goto pcpu_alloc;
        }


./fib_nexthops.sh
Tests passed: 244
Tests failed:   0
Tests skipped:  2
root@bms-ytl-d1-ap

