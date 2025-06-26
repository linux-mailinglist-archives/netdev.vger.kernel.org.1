Return-Path: <netdev+bounces-201693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3540AEA924
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 23:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C49A166E74
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 21:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9C3260579;
	Thu, 26 Jun 2025 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Y6VB8rfo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f99.google.com (mail-lf1-f99.google.com [209.85.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA252CCC0
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750975168; cv=none; b=LECzT8R+b7EVKOd+XCwtFaU97vEV0S2JCh7OqtVOzDFEQ77DD61tY+RbCEdaMYBfx7UBPu+bk+T3aSonnjrzT/+XlE+O6jonlyWSyabR/KBK2Ur9QMABYL7+6KkwcMwY1Ahut//5qHuxvvvSrbwsZrWpcTRtPYB6/s7OyGfh3fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750975168; c=relaxed/simple;
	bh=6g2ieE8kGwYwZUegdD615OKxqbgx33yoBTYlOLrwG1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eLfTiZcGJsSRiGtdmTfoMBT30OEKxlUKfUep+r8gH+nO2zVV2972GvN0F4zZt1CG3e8WcZFN6orXuJARW8J9mp5M2Mgi4xQdI998020NK7aJrF3I+t/604PvoySA8/E6wo404Xu0ZD3g/WTfiowazxL0CUDviwdxmiSaOBhpFk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Y6VB8rfo; arc=none smtp.client-ip=209.85.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f99.google.com with SMTP id 2adb3069b0e04-553bcf41429so170276e87.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1750975165; x=1751579965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h1LREwhwaWgQ6UTOhXo6Lc31Mqqh4bYeLtAgmVIVkDI=;
        b=Y6VB8rfog180xGAKBPIQJ3bV+F+YYdE0BBQgPQT6eb0CmXhi6Dn++gjXPptJ+ZzSv7
         7CV+qIs8Gqb8bMs0KmbLPQ+tCTIN01TuMBSiUYzaOhAVXZ6si5U9y43WPDrndcVmw/Rr
         qh8HZr5VANBNa6m+Keou0czyysfE5d0FgdZG9A4ZHp9qBv0OSru6+THJNgJI/Jfl2Lab
         O9GRFLJb6papyPy39wxs8q2DgeBsVl177lRphBQuWN/SyOsIQd49yFbodOIGTddxxnu2
         4QUMBykERtwOUlvR6AVWK4jBtJ0SGe3jy54e0G8HwbvGHdjFDeNfB4cVHECu0HIdntHy
         0UqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750975165; x=1751579965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1LREwhwaWgQ6UTOhXo6Lc31Mqqh4bYeLtAgmVIVkDI=;
        b=AiG6ubxH7JyN1m3TLo0hgXo4eO+Qar4RcxS3m40F7jQErJJc6P2x8J2J1piulXlMoK
         b7xg3wUVzTlJ7heZJE3hpppFZZueU+UWGldAS4VpX3ZVeQAonrwBNkngGszvhHn4zdDU
         tfF+h9j3wR9miYv4UVZaN/A+brNpQ86WWnplLu5UJUihwNJas/ju83+XD/ej3TpaGjPa
         QAxk2iwZ0z/zd8bvTxlKAGN3o12AePPCPqmfR2KNSEyU+p6WPHoucJGEuKfwWnrjbd3B
         DwojTjOT7ev+OFa+laVSjmbgSEDsGrRQze8ZUh1yIbXInKbkaVAmejrT+O5fPOwLqx1S
         YQMA==
X-Gm-Message-State: AOJu0Yx4bE5eS9hX9RA5JZX5S7qaKwF9MxUMGvTwrplHwFHs2C2JPdPW
	JlsuqHseA9ovG91MZdYRDRgsbxRfNRRLiMaEURIHmZ6l3CbxfGvD6uTH4CWktfekv7nxCGEeZMO
	SCYFhKuEkl3NQCj2J1IwUPRY6F+Gft6ev6Axe
X-Gm-Gg: ASbGncuDSUKE0/nXTLlC7CuTyjBh+cHjqfyGBYPbPM53BykkuovNRXWTOuCv07oq3PX
	oiGvcsCUif4IEtGOfqrR5Eu5mrohBEMRiFzQ6TBfSx1zenOcAq5R9Iqm3u3TKc21ZlmBH0v9eRl
	9Fi/Gl+rX6MMLRvkcmzJFQZHslpC8zprX6LiLGUHDF4a+D8/+hLnDhkUxrzDM3JkHlEnxAul2PI
	sM3hAevroq36bta638bcMzgGLgwDLcEUBidwV28/WYNUA3CNQ3xZufY675V/GVNgl4jgF811giD
	ufXua7FZWO3DBbdZtqZoEeeUu9q+2JPuF2cQ7CWsb/JYZY/b+k8JodoZW9BAClfbgtaQmyrTSW0
	DWA==
X-Google-Smtp-Source: AGHT+IFgS2Ic/mHhsVejy4bYSDMfi/zJ92Uozjhcgfv6wk/f85RH90V0Hcad3f045cVXSXNf6qsmU2qPPUOh
X-Received: by 2002:a05:6512:b8f:b0:554:f76a:bab7 with SMTP id 2adb3069b0e04-5550b8293c3mr141375e87.1.1750975164435;
        Thu, 26 Jun 2025 14:59:24 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-5550b2cc7bdsm64745e87.95.2025.06.26.14.59.24;
        Thu, 26 Jun 2025 14:59:24 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 0DA9D15EFB;
	Thu, 26 Jun 2025 23:59:24 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1uUuct-00Br7S-Pu; Thu, 26 Jun 2025 23:59:23 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net-next v2] ip6_tunnel: enable to change proto of fb tunnels
Date: Thu, 26 Jun 2025 23:55:09 +0200
Message-ID: <20250626215919.2825347-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is possible via the ioctl API:
> ip -6 tunnel change ip6tnl0 mode any

Let's align the netlink API:
> ip link set ip6tnl0 type ip6tnl mode any

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---

I finally checked  all params, let's do this properly (:

v1 -> v2:
 - returns an error if the user attempts to change anything other than the proto

 net/ipv6/ip6_tunnel.c | 44 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index a885bb5c98ea..8dcad289b8c5 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1562,11 +1562,22 @@ static void ip6_tnl_update(struct ip6_tnl *t, struct __ip6_tnl_parm *p)
 	netdev_state_change(t->dev);
 }
 
-static void ip6_tnl0_update(struct ip6_tnl *t, struct __ip6_tnl_parm *p)
+static int ip6_tnl0_update(struct ip6_tnl *t, struct __ip6_tnl_parm *p,
+			   bool strict)
 {
-	/* for default tnl0 device allow to change only the proto */
+	/* For the default ip6tnl0 device, allow changing only the protocol (the
+	 * IP6_TNL_F_CAP_PER_PACKET flag is set on ip6tnl0, and all other
+	 * parameters are 0).
+	 */
+	if (strict &&
+	    (!ipv6_addr_any(&p->laddr) || !ipv6_addr_any(&p->raddr) ||
+	     p->flags != t->parms.flags || p->hop_limit || p->encap_limit ||
+	     p->flowinfo || p->link || p->fwmark || p->collect_md))
+		return -EINVAL;
+
 	t->parms.proto = p->proto;
 	netdev_state_change(t->dev);
+	return 0;
 }
 
 static void
@@ -1680,7 +1691,7 @@ ip6_tnl_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 			} else
 				t = netdev_priv(dev);
 			if (dev == ip6n->fb_tnl_dev)
-				ip6_tnl0_update(t, &p1);
+				ip6_tnl0_update(t, &p1, false);
 			else
 				ip6_tnl_update(t, &p1);
 		}
@@ -2053,8 +2064,31 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
 
-	if (dev == ip6n->fb_tnl_dev)
-		return -EINVAL;
+	if (dev == ip6n->fb_tnl_dev) {
+		struct ip6_tnl *t = netdev_priv(ip6n->fb_tnl_dev);
+
+		if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
+			/* iproute2 always sets TUNNEL_ENCAP_FLAG_CSUM6, so
+			 * let's ignore this flag.
+			 */
+			ipencap.flags &= ~TUNNEL_ENCAP_FLAG_CSUM6;
+			if (memchr_inv(&ipencap, 0, sizeof(ipencap))) {
+				NL_SET_ERR_MSG(extack,
+					       "Only protocol can be changed for fallback tunnel, not encap params");
+				return -EINVAL;
+			}
+		}
+
+		ip6_tnl_netlink_parms(data, &p);
+		if (ip6_tnl0_update(netdev_priv(ip6n->fb_tnl_dev), &p,
+				    true) < 0) {
+			NL_SET_ERR_MSG(extack,
+				       "Only protocol can be changed for fallback tunnel");
+			return -EINVAL;
+		}
+
+		return 0;
+	}
 
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		int err = ip6_tnl_encap_setup(t, &ipencap);
-- 
2.47.1


