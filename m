Return-Path: <netdev+bounces-238960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 295B5C61ADB
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 19:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24C494E1A70
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 18:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C1B21FF2E;
	Sun, 16 Nov 2025 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b="S5fbB9H8"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAD3227E82
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763317942; cv=pass; b=W7TWRKv82A/PAl6HcnDXjDdKpQyn78NPLCOYfhE09tLrCWIyd+jQAAdwE9bqxvt0YagdtZESnBB5p+pmvyd6wfuZexGjLlhFtOyN8bpx1snoKUbG8il5JOjaBdHKkGTLMdm+yFl96hM0vICGdJgAsmBMBTzi0bXJ2vlvYz8EeoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763317942; c=relaxed/simple;
	bh=rEiIRKkMLGqBwGdE7Gj7GqFHzPl22jS+GhACtHUk6Sc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KUc1vNmLICgm67hBY9CrHYWCAo7BAu94WGTBkhS3YJpWnig8Q3DQv+CIG21v7Cdp7lOdM+Ly3KD6xXVPVFLIuylNqZ9yyw2ygySTQ1r0aAYMAvxtWMzwnPNbVdahXMAd7NRjOh34KOTU07vS8byuwQeuty81pVRPpc+5F0Hr6z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net; spf=pass smtp.mailfrom=azey.net; dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b=S5fbB9H8; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azey.net
ARC-Seal: i=1; a=rsa-sha256; t=1763317902; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=aiWshKQ2yJzkQlariOTRFzSueiG1PjtATml0zNnuwTQKNM2iKeQxIXNPTyB/uAAKhvyFSLg3rT1R7VrDkLIb/seJPry4hBTNLUfKtaW02NXEW2ALV0sro+iN3lnjg8GL2GnrXvG56DhAGKRy0UCQEXvDPyKm8mRDj8jnMSgLfpM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1763317902; h=Content-Type:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=ABKLWa5Pu+BrlG/3XiCL2WxzTPtAPncvZnlySWX08D0=; 
	b=Tt8eUFJFWmYU0h8I8qwv8Yax/oZniuPq0sRf6hXqw8AuuUL/m3laIctXpALRJdPp96tbXWcVGM9ibORQ1RN1Aj6K0LnfxqFsqQqtvI+qC76+uLeOwKs38BLqzec2+FWHPS8gm+JhmorDfgtbSkqRH36PJxgGoFQ9H9+WKBC7xpA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=azey.net;
	spf=pass  smtp.mailfrom=me@azey.net;
	dmarc=pass header.from=<me@azey.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763317902;
	s=zmail; d=azey.net; i=me@azey.net;
	h=Date:Date:From:From:To:To:Subject:Subject:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To:Cc;
	bh=ABKLWa5Pu+BrlG/3XiCL2WxzTPtAPncvZnlySWX08D0=;
	b=S5fbB9H8ZgR8NFQDD6pZhFrgbOpBUxardCumJawsxkTyYoMhiS2zcbK6/gwjL/ec
	I21uqh8uXIY8cnpey1CtGoUzVJn2JO0v3URI/9yTBjaGc2DsMwd2T+cBT9a61kUThIV
	RgXxEH6pCuB4QsmVWUmBRiXhyB8W4aZemvtY9fe0=
Received: by mx.zoho.eu with SMTPS id 1763317900435202.658144284562;
	Sun, 16 Nov 2025 19:31:40 +0100 (CET)
Date: Sun, 16 Nov 2025 19:31:35 +0100
From: azey <me@azey.net>
To: "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/ipv6: allow device-only routes via the multipath API
Message-ID: <a6vmtv3ylu224fnj5awi6xrgnjoib5r2jm3kny672hemsk5ifi@ychcxqnmy5us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f4vydkeg6t2uco7g"
Content-Disposition: inline
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/263.283.95
X-ZohoMailClient: External


--f4vydkeg6t2uco7g
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PATCH] net/ipv6: allow device-only routes via the multipath API
MIME-Version: 1.0

At some point after b5d2d75e079a ("net/ipv6: Do not allow device only
routes via the multipath API"), the IPv6 stack was updated such that
device-only multipath routes can be installed and work correctly, but
still weren't allowed in the code.

This change removes the has_gateway check from rtm_to_fib6_multipath_config=
()
and the fib_nh_gw_family check from rt6_qualify_for_ecmp(), allowing
device-only multipath routes to be installed again.

Signed-off-by: azey <me@azey.net>
---

I tested this on a VM with two wireguard interfaces, and it seems to
work as expected. It also causes fe80::/64 and ff00::/8 to be installed as
multipath routes if there are multiple interfaces, but from my (somewhat
limited) testing that doesn't cause any issues.

I'm also not completely sure whether there are any other places in the
code that assume multipath nexthops must have a gateway addr, but I
didn't immediately find any.

PS: This is my very first contribution to the kernel (and indeed first time
sending a patch via mail), so sorry in advance if I messed anything up.
---
 include/net/ip6_route.h | 3 +--
 net/ipv6/route.c        | 6 ------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 7c5512baa4b2..07e131f9fcf5 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -73,8 +73,7 @@ static inline bool rt6_need_strict(const struct in6_addr =
*daddr)
 static inline bool rt6_qualify_for_ecmp(const struct fib6_info *f6i)
 {
 	/* the RTF_ADDRCONF flag filters out RA's */
-	return !(f6i->fib6_flags & RTF_ADDRCONF) && !f6i->nh &&
-		f6i->fib6_nh->fib_nh_gw_family;
+	return !(f6i->fib6_flags & RTF_ADDRCONF) && !f6i->nh;
 }
=20
 void ip6_route_input(struct sk_buff *skb);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index aee6a10b112a..40763b90e22c 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5138,12 +5138,6 @@ static int rtm_to_fib6_multipath_config(struct fib6_=
config *cfg,
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
--=20
2.51.0


--f4vydkeg6t2uco7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQsyzQDQ/6KK5HOf3X5T0pxxcIejwUCaRoYgwAKCRD5T0pxxcIe
j0d+AP4mT61wII0s4ibBC8MC7NuiGUJInVhq06SabAZmiYLNfgD5AcEgTXl4RbHS
SXKvYW2SRT5++tffxIy7IQ/UmkOQogo=
=K1DH
-----END PGP SIGNATURE-----

--f4vydkeg6t2uco7g--

