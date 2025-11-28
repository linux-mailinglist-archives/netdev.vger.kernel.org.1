Return-Path: <netdev+bounces-242611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70226C92D5A
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 18:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 375D64E2281
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 17:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838D728C849;
	Fri, 28 Nov 2025 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b="yHLsEzNM"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o59.zoho.eu (sender-of-o59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67D627EC7C;
	Fri, 28 Nov 2025 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764352221; cv=pass; b=JKrdCwLcCEqOadEP4M1kQcjXdyqwb4VL7ImE8xYzGSRZ0evGTZDHOmnywfsWl0HVuZgY2Dw9LgPTwsztOyESTpMzCzmCwsk40DYDHf+mSWlQWCNuAUlktw5aKVdFjgOd7smHR6uVb2zwE3Fh1z4Yi/vAtY9C+0pKwvI+rOxHVGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764352221; c=relaxed/simple;
	bh=rYc69GgvEYPGlD//p2G70PVnj/2evv8ynThEfDC2R40=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=T/EWmggMzXvRuvovCsStn4Tm7w1KyCiPl5bc7RWAKT/tTQZKx+5VsBXn9IkEsAgBM+/CVlZkOEdHR82rrDEAAFA6RBTzNZcfBshuDkYfYa0izq8Juod513Mj2OAsZZ15vVRy9eI+vu9JYIOV3A/VxLYvR8w74nxJdx9ulbfWmaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net; spf=pass smtp.mailfrom=azey.net; dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b=yHLsEzNM; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azey.net
ARC-Seal: i=1; a=rsa-sha256; t=1764352197; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=UtxDH7zPd5rgN8SIsN6x7CJdejf8YzT98CBkrrX61wMzPhM7fm0J5Y8LsD6ZVCcqwSqLxfpj14DQdj9osLCJwK6o8PRe3gYWN9gllTQZgcMD9XoemxkpQ61J6l3kyfpHP7r9LB1KnzYer+lluRk0VAjR//UH9kmXXrqQbHZ5YRA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1764352197; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=z1QpJojzEmHbRdqCUupi+9xW9rNvfZBvYGXNxryKazw=; 
	b=JT0loHuJ1se45YgPZxMX0yeDN++2b6Z4YvNK+uCN4rlzDiP5RivE5Cjl3n6tkN/8OIMUHcmukEjeVsofBC6Zr52ZImbVraG7rGqmZ0jsPc6mo1g0gWHgTVxGUPDSNlN1nykVFkoXvIcFCxZSmA0rxCs7aLXGb58iJnKXoi4m0/4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=azey.net;
	spf=pass  smtp.mailfrom=me@azey.net;
	dmarc=pass header.from=<me@azey.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764352197;
	s=zmail; d=azey.net; i=me@azey.net;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=z1QpJojzEmHbRdqCUupi+9xW9rNvfZBvYGXNxryKazw=;
	b=yHLsEzNMDm1jUHUKhKVhvbQLFsmUogM5ZHWFOohJ8ZzJAjbGhO542w9IcdjmjrOV
	qKw8GgJv5+XBTAzIastn+LE3qM8RDwfAmNSIHHRrFT5a3svK47lqOZryppZNVflirs6
	DBRo1hYozItCmUibqqo+jhTT0gOShb54yioSmChc=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1764352195574628.4644091285751; Fri, 28 Nov 2025 18:49:55 +0100 (CET)
Date: Fri, 28 Nov 2025 18:49:55 +0100
From: azey <me@azey.net>
To: "nicolasdichtel" <nicolas.dichtel@6wind.com>
Cc: "Jakub Kicinski" <kuba@kernel.org>, "David Ahern" <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
	"netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19acb95fbde.c1def42b209419.2689462649051838277@azey.net>
In-Reply-To: <56a0ec5c-da92-4f92-9697-71127866049b@6wind.com>
References: <3k3facg5fiajqlpntjqf76cfc6vlijytmhblau2f2rdstiez2o@um2qmvus4a6b>
 <20251124190044.22959874@kernel.org>
 <19ac14b0748.af1e2f2513010.3648864297965639099@azey.net>
 <85a27a0d-de08-413d-af07-0eb3a3732602@6wind.com>
 <19ac5a2ee05.c5da832c80393.3479213523717146821@azey.net>
 <1d44e105-77bd-42e7-81f5-6e235fd12554@6wind.com>
 <19aca794ddd.105d1f97f173752.5540866508598154532@azey.net>
 <da447d68-8461-4ca5-87ae-dcfdec1308db@6wind.com>
 <19acb23fcf6.126ff53f1199305.3435243475109739554@azey.net>
 <19acb2c1318.fb2ad2c5200221.6191734529593487240@azey.net> <56a0ec5c-da92-4f92-9697-71127866049b@6wind.com>
Subject: Re: [PATCH v2] net/ipv6: allow device-only routes via the multipath
 API
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

On 2025-11-28 17:28:41 +0100  Nicolas Dichtel <nicolas.dichtel@6wind.com> w=
rote:
> Le 28/11/2025 =C3=A0 16:54, azey a =C3=A9crit :
> >> On 2025-11-28 09:38:07 +0100  Nicolas Dichtel <nicolas.dichtel@6wind.c=
om> wrote:
> >>> With IPv6, unlike IPv4, the ECMP next hops can be added one by one. Y=
our commit
> >>> doesn't allow this:
> >=20
> > Hold on, I think I understand what you actually meant by this, sorry.
> > I got too focused on regressions from the discussion in v1, I'll make
> > a v3 of the patch that allows dev-only routes to be added via append.
> Yes, that is what I pointed out.
>=20
> Please, add some self-tests to show that there is no regression. You prob=
ably
> have to test different combinations of NLM_F_* flags. See:
>=20
> https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/tree/ip/ipro=
ute.c#n2418

Will do, thanks for the pointer.
One last thing I'd like to clarify though: would this behavior not also
itself be considered a regression?

Currently the add and append routes get added separately, and someone
could theoretically be relying on the kernel always picking the last
route instead of making them multipath - essentially still the same
v1 regression.

If not, would it also be acceptable for just any non-RTPROT_KERNEL
routes to automatically be made multipath like this? It's a simple fix,
it'd make appending work and it'd still prevent the specific v1
regression for the case of two interfaces on the same subnet - example
diff attached.

---
 include/net/ip6_route.h | 6 ++++--
 net/ipv6/route.c        | 9 ---------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 7c5512baa4b2..c20beb7bcdb9 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -72,9 +72,11 @@ static inline bool rt6_need_strict(const struct in6_addr=
 *daddr)
  */
 static inline bool rt6_qualify_for_ecmp(const struct fib6_info *f6i)
 {
-=09/* the RTF_ADDRCONF flag filters out RA's */
+=09/* the RTF_ADDRCONF flag filters out RA's,
+=09 * and RTPROT_KERNEL filters out local addresses' subnet routes
+=09 */
 =09return !(f6i->fib6_flags & RTF_ADDRCONF) && !f6i->nh &&
-=09=09f6i->fib6_nh->fib_nh_gw_family;
+=09=09(f6i->fib6_nh->fib_nh_gw_family || f6i->fib6_protocol !=3D RTPROT_KE=
RNEL);
 }
=20
 void ip6_route_input(struct sk_buff *skb);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index aee6a10b112a..865d9139994a 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5119,7 +5119,6 @@ static int rtm_to_fib6_multipath_config(struct fib6_c=
onfig *cfg,
 =09}
=20
 =09do {
-=09=09bool has_gateway =3D cfg->fc_flags & RTF_GATEWAY;
 =09=09int attrlen =3D rtnh_attrlen(rtnh);
=20
 =09=09if (attrlen > 0) {
@@ -5133,17 +5132,9 @@ static int rtm_to_fib6_multipath_config(struct fib6_=
config *cfg,
 =09=09=09=09=09=09       "Invalid IPv6 address in RTA_GATEWAY");
 =09=09=09=09=09return -EINVAL;
 =09=09=09=09}
-
-=09=09=09=09has_gateway =3D true;
 =09=09=09}
 =09=09}
=20
-=09=09if (newroute && (cfg->fc_nh_id || !has_gateway)) {
-=09=09=09NL_SET_ERR_MSG(extack,
-=09=09=09=09       "Device only routes can not be added for IPv6 using the=
 multipath API.");
-=09=09=09return -EINVAL;
-=09=09}
-
 =09=09rtnh =3D rtnh_next(rtnh, &remaining);
 =09} while (rtnh_ok(rtnh, remaining));
=20

base-commit: bd10acae08aeb9cd2f555acdbacb98b9fbb02a27
--=20
2.51.0


