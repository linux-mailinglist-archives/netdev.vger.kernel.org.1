Return-Path: <netdev+bounces-209062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38E9B0E243
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 18:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CED43A65C4
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7201027E077;
	Tue, 22 Jul 2025 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFJXoNDS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FBEBA36;
	Tue, 22 Jul 2025 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753203520; cv=none; b=PPu16wJNYwjfyNOL3unXnof/7n243I2z8ZP+2v0Yz1gQRPa3PX7qWOfkEIEtzZH3+zenpG57MqwOxansvyhEEPQah0TXG/f03BvEhzqvSEyATaSajdgUt3KCVhYajW82jFH0AoyJyJLvMxXMyhozBE6xKbjoBchfciJ/btvHCUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753203520; c=relaxed/simple;
	bh=EzsOnl7+olKKZ5Ot6tPHfR94bGdMefvahgUe1Z+lDe4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dS8RU43//+F5Dn8EYvSqdzf4Dct4K4kYZ5dQPNTNAm6EU0M4QlJpGqWWUcwZl7M2EfKNxyBxGqF+IaPOWSnmB2uuPMKCNutoJFn/VWjnDxHYftJpAwg6DIsp7UYvj+yDyEjoudi/whrOktas87/cHKDM+R8K17SDecR5z+iz7zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFJXoNDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49D6C4CEEB;
	Tue, 22 Jul 2025 16:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753203518;
	bh=EzsOnl7+olKKZ5Ot6tPHfR94bGdMefvahgUe1Z+lDe4=;
	h=From:To:Cc:Subject:Date:From;
	b=pFJXoNDSq+xog/hwJv6hRoGqdwSwbr6f+XrfWmmSxziJH5qcK02XLbc96RhmuEKbU
	 rLpWulK8+Y5AoGMsntIbD+avFWkcQUOsmszBr6nF8s6JFH/fHmNruIg1LSgcJuv2aA
	 av7zk2TIGMusVuX+MISrWCHYvqnTLnd811smFekgbdBB0I2BOHlg4YyxoeX7nkHR4E
	 y+Dq3UdzYhB0JM4Ve1ZDGhUlU90p10JnnOfqjv+1ZmPrmcahMilri7v6kvv+Gk8DX8
	 Z/GBaXsTCq53Ofv7O/ILhVIAJT6wIKD3E4Zn1trXyhXLgTagIUqGz7iB4yJ8yMk8s9
	 GFza5ynd4hF2A==
From: Kees Cook <kees@kernel.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Kees Cook <kees@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next] net: Document sockaddr safety in ARP and routing UAPI structures
Date: Tue, 22 Jul 2025 09:58:37 -0700
Message-Id: <20250722165836.work.418-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2100; i=kees@kernel.org; h=from:subject:message-id; bh=EzsOnl7+olKKZ5Ot6tPHfR94bGdMefvahgUe1Z+lDe4=; b=owGbwMvMwCVmps19z/KJym7G02pJDBn1h229QjyOJCmu1j917Hgvy06BTgaPSOfMJdynHt54W FEp/bG5o5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCL3fzAydE2YzxV+JNopl+vT wmkRTcF3LrtsD+berLpEfIbIw0t6Bxn+p0buYnaeV5+r9tbiekvUoRWpZjLTLi32Czs76db0qS0 SzAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Add documentation clarifying that ARP and routing UAPI structures are
constrained to IPv4-only usage, making them safe for the coming fixed-size
sockaddr conversion (with the 14-byte struct sockaddr::sa_data). These
are fine as-is, but their use was non-obvious to me, so I figured they
could use a little more documentation:

- struct arpreq: ARP protocol is IPv4-only by design
- struct rtentry: Legacy IPv4 routing API, IPv6 uses different structures

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: <netdev@vger.kernel.org>
---
 include/uapi/linux/if_arp.h | 3 ++-
 include/uapi/linux/route.h  | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/if_arp.h b/include/uapi/linux/if_arp.h
index 4783af9fe520..4164cc6e8aa5 100644
--- a/include/uapi/linux/if_arp.h
+++ b/include/uapi/linux/if_arp.h
@@ -113,7 +113,7 @@
 #define	ARPOP_NAK	10		/* (ATM)ARP NAK			*/
 
 
-/* ARP ioctl request. */
+/* ARP ioctl request; IPv4-only protocol. */
 struct arpreq {
 	struct sockaddr	arp_pa;		/* protocol address		 */
 	struct sockaddr	arp_ha;		/* hardware address		 */
@@ -122,6 +122,7 @@ struct arpreq {
 	char		arp_dev[IFNAMSIZ];
 };
 
+/* Legacy ARP ioctl request; IPv4-only protocol. */
 struct arpreq_old {
 	struct sockaddr	arp_pa;		/* protocol address		 */
 	struct sockaddr	arp_ha;		/* hardware address		 */
diff --git a/include/uapi/linux/route.h b/include/uapi/linux/route.h
index a0de9a7331a2..a2955e25d7ee 100644
--- a/include/uapi/linux/route.h
+++ b/include/uapi/linux/route.h
@@ -27,7 +27,7 @@
 #include <linux/if.h>
 #include <linux/compiler.h>
 
-/* This structure gets passed by the SIOCADDRT and SIOCDELRT calls. */
+/* This IPv4-only structure gets passed by the SIOCADDRT and SIOCDELRT calls. */
 struct rtentry {
 	unsigned long	rt_pad1;
 	struct sockaddr	rt_dst;		/* target address		*/
-- 
2.34.1


