Return-Path: <netdev+bounces-289447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMJnLsdaDGodfwUAu9opvQ
	(envelope-from <netdev+bounces-289447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:42:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1727357EE59
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9095B30EE96D
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C6B4DBD70;
	Tue, 19 May 2026 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxdNV23U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906C74CA278
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194164; cv=none; b=c89xNvKQ1HurVZFE9He1WE5S1Xl15zYlkjxDq/DtQS2mOZx+F1LtB9Kz5+YFhq1chfEcSsZCX38VRVeboTSUrEpYDK2OTGyGG8PWFzXJjtfAmWfJjMkb1k6oJQlnC37Jy7iHYPab++LOUiyiWpsrYn3Zn56Chuc/05/XSH7iuBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194164; c=relaxed/simple;
	bh=lIc9IvGukuTxrcKPyEANUt/P7j7/XDF0to6T1xKrVwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qaQeEWtZQ8qmmRgUbh4s+c/Fuw5Csq97FwLK51DyTqPH+N9vLLXJL2vnGWRC8mH1hJ/vOOW/uL50mDSqRSfljfr+R9j+X1I0e+6r7aW8Ax24QVg1k9DxlU9hfL0lqGADrn11zklR9njXxBmmE0FdFiqSrLe7Tc13TpM8Uu7QOUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxdNV23U; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b4583f0a1aso21764765ad.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 05:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779194159; x=1779798959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnqfNLPf1FZpTLzCn6yNj1v+FRpfxLX1loWYM78LAiU=;
        b=RxdNV23U+rPsSJ2il8ENIcIFV40H/lty0OrdzTXSVqMXYIz66s5o3jbYDXuRgDRHZc
         mocdfsHTWeH9IxBBe0SpTmTOyhbvkoQYYcewzG1coz4ZXz9ebX1CjusnhKYHmlIAKyHG
         APx13kdteRvuESCs92OtIkWtLS64LSRezJpseyRGKI+MwXAvBcnDuCeLpXWa1lf1qcLV
         s94bvNCIl2PF6LeweFQBTzIQ6Xk74SazVQE0VsSY7VtGWCxu7IZZa7oc3ZMPTkFLf5z9
         Aibou2FWyPxzTDquj6XAkfcb3Bs2SJ7ePLXMFsP97O+thyIjOqZtrtz29wNF/n+9vyWE
         1hdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779194159; x=1779798959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WnqfNLPf1FZpTLzCn6yNj1v+FRpfxLX1loWYM78LAiU=;
        b=BRX7XAl68/PVv1Hi0aF75pUJTB3G/IVVyIMUUqnN17Y5SiX5I326GhMwgG+2XdsVUL
         9qTD/QQHpPT/zfrYCiIqA+WWZBzZ4oaltVx2hY7bDCfx3YN/4oCm5IndPB8OBbGL32Ax
         EGZCR7HWzCXxtFkStpSoqs8/1KLmmH2q8pvqPK0EWUv0u2AC8dnZwSznL7gAwztp7dBj
         mJQeffAXE9QWTab0ufAiE/Tk8/yN5FsK7khZnUekPBJnZLZ1+ptOb7Q2OelxnHDmRUJA
         gTxiermi2sXdtHvE1ciDnUcdoIGCFSY+5FmozbklMDEo2t+5oiLPnSL7aTnictN9GFPE
         cq5g==
X-Forwarded-Encrypted: i=1; AFNElJ/fE3qmi4W69UnoJ9gNEfcqUKU9HPy52CnXenK+KR7NjkhNqkwEeOvzYZFgUISiCf8fZaeI5GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpI0uANBraWWH/oSAE/1d7ublz9J+9Zi5GKEbmXsMUobv0EFyc
	DvjRJU6UgZm4FRdxE2CVFhtGm+WiCq5+Y0NciUxokGMfiXiZk/i/1YLX
X-Gm-Gg: Acq92OF6l1858Tq+zfJYu/H7Qb5qNvNMoLMRfXjE7bApeSCZFVCGF1QhNcBA4A3QCZ4
	hm+JhSs0G44hLTD78NfC0zMVjm6czrHlGZEh0zwNPNwJ/zyupxu/mjY6ubwKl7Vbhu8KJzzdyhA
	cTOi6VLKGBH0TwOioHQ63mKWMoAlvAq3Q4+PVDvU0abXLkFf0S09TKGfrTO9WtVsYReyVuhrdXg
	IivVrcoTZxcKe0lLe8cXZm5IlHJKD4iHKiUGbxn7DzTJLfhJQMxktZFqUU4lUHvn/k7ByfGgu8d
	FMfCrWznXCuyzZ1PgTET0p4ut5a8szLkQ3Wq5Fk8Wpj3aOZf9Gf6p9fRbw4bl+6U9/7B0qbnMxl
	cCPDMaTd92nVp2bj4yju/8sHaoA1E6wJgS1B9O7351pexATIoi8ARxGWCwCAFYYmN3yIYV3m/hJ
	O1SngIdw4QzOWhPNQKWHY0ubEf7XqmTHz2xw8rLQFMLqD/FOOe
X-Received: by 2002:a17:903:950:b0:2bd:a3c5:6d96 with SMTP id d9443c01a7336-2bda3c56ef9mr147376025ad.14.1779194158910;
        Tue, 19 May 2026 05:35:58 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fc60sm193216245ad.9.2026.05.19.05.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 05:35:58 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Shaw Leon <shaw.leon@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 2/2] ip6: vti: Use ip6_tnl.net in vti6_siocdevprivate().
Date: Tue, 19 May 2026 20:35:47 +0800
Message-Id: <20260519123547.2055911-3-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519123547.2055911-1-maoyixie.tju@gmail.com>
References: <20260519123547.2055911-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-289447-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,secunet.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ip6_tnl.net:url]
X-Rspamd-Queue-Id: 1727357EE59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After "ip6: vti: Use ip6_tnl.net in vti6_changelink()." in the same
series, vti6_update() unlinks and relinks the tunnel through t->net.
vti6_siocdevprivate() still uses dev_net(dev) for the collision
lookup. For a tunnel migrated through IFLA_NET_NS_FD, dev_net(dev)
is the new namespace, not t->net.

The SIOCCHGTUNNEL path on a migrated tunnel then proceeds as
follows:

  net = dev_net(dev)                    /* migrated netns */
  t   = vti6_locate(net, &p1, false)    /* misses target in t->net */
  ...
  t   = netdev_priv(dev)
  vti6_update(t, &p1, false)            /* mutates t->net's hash */

A caller in the migrated netns sets the migrated tunnel's parameters
to those of a tunnel that lives only in the creation netns. The
collision check in dev_net(dev) sees nothing. vti6_update() then
prepends the migrated tunnel at the head of the creation netns
hash bucket for those parameters. Subsequent lookups in the creation
netns resolve to the migrated device. xfrm receive delivers packets
matching those parameters through a device the caller controls.

Reachable from an unprivileged user namespace ("unshare --user
--map-root-user --net"). Cross tenant scope on container hosts.

Use t->net for the SIOCCHGTUNNEL path on a non fallback device. The
lookup then matches the namespace vti6_update() operates on.
SIOCADDTUNNEL and SIOCCHGTUNNEL on the fallback device retain
dev_net(dev), which equals init_net for the fallback.

Fixes: 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of rtnl_link_ops")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/ipv6/ip6_vti.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -834,15 +834,19 @@ vti6_siocdevprivate(struct net_device *dev, struct ifreq *ifr, void __user *data
 		if (p.proto != IPPROTO_IPV6  && p.proto != 0)
 			break;
 		vti6_parm_from_user(&p1, &p);
-		t = vti6_locate(net, &p1, cmd == SIOCADDTUNNEL);
 		if (dev != ip6n->fb_tnl_dev && cmd == SIOCCHGTUNNEL) {
+			struct ip6_tnl *self = netdev_priv(dev);
+
+			t = vti6_locate(self->net, &p1, false);
 			if (t) {
 				if (t->dev != dev) {
 					err = -EEXIST;
 					break;
 				}
 			} else
-				t = netdev_priv(dev);
+				t = self;

 			err = vti6_update(t, &p1, false);
+		} else {
+			t = vti6_locate(net, &p1, cmd == SIOCADDTUNNEL);
 		}
 		if (t) {
--
2.34.1


