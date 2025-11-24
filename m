Return-Path: <netdev+bounces-241161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F61C80DAD
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 14:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63DF3A4E8D
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 13:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3270930B52B;
	Mon, 24 Nov 2025 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b="QPd06RrO"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E7F13790B
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763992407; cv=pass; b=BRgliPfMgKKWfgpDD5BdgiF89wjf9CAgZGd1WkM6eUnrRASOF/59RlUHQNxvbT4L5IZd2izY6Zr9GgwD7rj6XvjX5COun5WrRUee5/6PkoEYVvIYI+7pJFwRlQ2EBbflC5/OHx4KYVK0HwvYwxLd8ddm6NmgWgDsK7ZdbP+uyqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763992407; c=relaxed/simple;
	bh=s5h8gSB7v6bsXNAhS9y3RI1hx5UQsmHua34zCqEP0I4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Hn6OH5z0vspFAYhgxLIEw20xDd6Zyaa18Q2vlTNO7T1TZ40kE11hfQFT6m2xllozNe9kfhyu5bvJLfB9koJvEr/1xc0nBzDzYqONoIr9EUNOn422qz3sOAOfNbIXGkMzpP2JvhBkk/DsAST6OzmF+SyPsztzaEU6UnIUsm0SFk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net; spf=pass smtp.mailfrom=azey.net; dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b=QPd06RrO; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azey.net
ARC-Seal: i=1; a=rsa-sha256; t=1763992373; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=CdXkQYfMBGRUPeUpKV4Uh5qSRG9zF1JFpwjI74FnDy4z2PAGW6Pwp+c+lZBtt3xOn7tqZv7CGWjDCl6TX8JGdrtmQxzkgxnSc8giuc7QtDug8evyZ7GYnA8ZQqAFVhDbHUTIGkKtYR4Av9z2kfzuj9P5DKfLJ0sKDh1/ec2dix8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1763992373; h=Content-Type:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=rBkX/nDuN24GUNqkAosSgW7yt3kwIvRuz+2yBGUA6hE=; 
	b=IhO6d2xM+BtEU6ppNc42SlBXp2NuX1spGH2WOYDH9beTkUlVt/ll0rHT6YHVQK/LOunqeM3nwMdVDf94s/2I5Tnu/zqo9xqp4AVSYNwo8UxT1XR6zzE6YMqnGweBHd9NXeJeCDZF4LDmtcd11onjPcECO5Tdx6l7pG/i1wQv990=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=azey.net;
	spf=pass  smtp.mailfrom=me@azey.net;
	dmarc=pass header.from=<me@azey.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763992373;
	s=zmail; d=azey.net; i=me@azey.net;
	h=Date:Date:From:From:To:To:Subject:Subject:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To:Cc;
	bh=rBkX/nDuN24GUNqkAosSgW7yt3kwIvRuz+2yBGUA6hE=;
	b=QPd06RrOe6IVecQxCNPH5+JtrlR0SlpgQZiIffVVaOmOkIjFEKKTFz1TiA0vo6HA
	5Y+43PjGQsD+ry5sqS3HL7Tj2DRkGZ6Oj7W8nlbtuSF1bsGDQ5kyBTI9c855oFoLuDB
	jSVmRahiF4UCR8hdP+a1x0RVvqdh/HRb0QS7hFhI=
Received: by mx.zoho.eu with SMTPS id 1763992368103378.52597944823765;
	Mon, 24 Nov 2025 14:52:48 +0100 (CET)
Date: Mon, 24 Nov 2025 14:52:45 +0100
From: azey <me@azey.net>
To: David Ahern <dsahern@kernel.org>, 
	nicolasdichtel <nicolas.dichtel@6wind.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] net/ipv6: allow device-only routes via the multipath API
Message-ID: <3k3facg5fiajqlpntjqf76cfc6vlijytmhblau2f2rdstiez2o@um2qmvus4a6b>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="alsnc4vfxlzkwrw2"
Content-Disposition: inline
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/263.908.66
X-ZohoMailClient: External


--alsnc4vfxlzkwrw2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PATCH v2] net/ipv6: allow device-only routes via the multipath API
MIME-Version: 1.0

At some point after b5d2d75e079a ("net/ipv6: Do not allow device only
routes via the multipath API"), the IPv6 stack was updated such that
device-only multipath routes can be installed and work correctly.

This change removes checks that prevent them from being installed,
and adds a fib6_explicit_ecmp flag to fib6_info. The flag is only
checked in rt6_qualify_for_ecmp() and exists to prevent regressions.

Signed-off-by: azey <me@azey.net>
---
Changes in v2:
- Added fib6_explicit_ecmp flag to fib6_info to prevent regressions.
  Very simple (and naive) fix, all it does is flag routes created as
  multipath and check for the flag in rt6_qualify_for_ecmp().
  I'm not sure whether it should be an RTF_ flag in fib6_flags instead,
  but there aren't any unused bits in that field so I made it separate.
- Removed hanging has_gateway as reported by <lkp@intel.com> bot

Link to v1:
  https://lore.kernel.org/netdev/a6vmtv3ylu224fnj5awi6xrgnjoib5r2jm3kny672h=
emsk5ifi@ychcxqnmy5us/
---
 include/net/ip6_fib.h   |  3 ++-
 include/net/ip6_route.h |  5 +++--
 net/ipv6/route.c        | 11 ++---------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 88b0dd4d8e09..da9d03cbbab4 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -196,7 +196,8 @@ struct fib6_info {
 					dst_nocount:1,
 					dst_nopolicy:1,
 					fib6_destroying:1,
-					unused:4;
+					fib6_explicit_ecmp:1,
+					unused:3;
=20
 	struct list_head		purge_link;
 	struct rcu_head			rcu;
diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 7c5512baa4b2..5f00e9e252c2 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -73,8 +73,9 @@ static inline bool rt6_need_strict(const struct in6_addr =
*daddr)
 static inline bool rt6_qualify_for_ecmp(const struct fib6_info *f6i)
 {
 	/* the RTF_ADDRCONF flag filters out RA's */
-	return !(f6i->fib6_flags & RTF_ADDRCONF) && !f6i->nh &&
-		f6i->fib6_nh->fib_nh_gw_family;
+	return f6i->fib6_explicit_ecmp ||
+		(!(f6i->fib6_flags & RTF_ADDRCONF) && !f6i->nh &&
+		f6i->fib6_nh->fib_nh_gw_family);
 }
=20
 void ip6_route_input(struct sk_buff *skb);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index aee6a10b112a..7ac69bf5ccf2 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5119,7 +5119,6 @@ static int rtm_to_fib6_multipath_config(struct fib6_c=
onfig *cfg,
 	}
=20
 	do {
-		bool has_gateway =3D cfg->fc_flags & RTF_GATEWAY;
 		int attrlen =3D rtnh_attrlen(rtnh);
=20
 		if (attrlen > 0) {
@@ -5133,17 +5132,9 @@ static int rtm_to_fib6_multipath_config(struct fib6_=
config *cfg,
 						       "Invalid IPv6 address in RTA_GATEWAY");
 					return -EINVAL;
 				}
-
-				has_gateway =3D true;
 			}
 		}
=20
-		if (newroute && (cfg->fc_nh_id || !has_gateway)) {
-			NL_SET_ERR_MSG(extack,
-				       "Device only routes can not be added for IPv6 using the multipa=
th API.");
-			return -EINVAL;
-		}
-
 		rtnh =3D rtnh_next(rtnh, &remaining);
 	} while (rtnh_ok(rtnh, remaining));
=20
@@ -5448,6 +5439,8 @@ static int ip6_route_multipath_add(struct fib6_config=
 *cfg,
 			goto cleanup;
 		}
=20
+		rt->fib6_explicit_ecmp =3D true;
+
 		err =3D ip6_route_info_create_nh(rt, &r_cfg, GFP_KERNEL, extack);
 		if (err) {
 			rt =3D NULL;

base-commit: bd10acae08aeb9cd2f555acdbacb98b9fbb02a27
--=20
2.51.0


--alsnc4vfxlzkwrw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQsyzQDQ/6KK5HOf3X5T0pxxcIejwUCaSRjLQAKCRD5T0pxxcIe
j/WdAQC5XfnFt5i3LGoLoDcsdOXkgll0eLgliYVd9CZnpMkyvAEA1/PeFW98Al2j
fZ12LSAl4M6sUmppD80haqluvb5GJQk=
=UlVp
-----END PGP SIGNATURE-----

--alsnc4vfxlzkwrw2--

