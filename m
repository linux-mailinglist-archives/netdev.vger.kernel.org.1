Return-Path: <netdev+bounces-135932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E12E599FD2D
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 02:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A132C285C2C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 00:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD471171D;
	Wed, 16 Oct 2024 00:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6lznSgu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C2910A2A;
	Wed, 16 Oct 2024 00:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729038767; cv=none; b=Uuz2HfCJuRbQjQecWM9guf7lVmJwkjH1SRL+AFjUTmPjsHns2eb/I8OFPVnRJeV0XgxtDwYb785G2hArHiGUfJK+vpQv94xQpZwXMZkzFwtfK8WMpsQtwIEwONyW0AxXXMo7w6jzeUb1EXxocVpaEC0fesJOt0aHlTqXB55iq7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729038767; c=relaxed/simple;
	bh=iHoB2CtxcbvJ6Ygv4kl5YbKNImTMb7GFaBl6ohxzF0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svGcvHHAcGAEE1P8I/Y7H2zxCVp17D+CI7mfjsBF4KDWsC0JgjPVLgXYxiogkJI0X5cwafcRBp6CXb4XBMuJKtKsLe6ozezZpUc/DOyGEh69jKGHiBXWmf/7/aZJxea/7rcw95nizAyLQzP9vqrZluwbHdc5pBq/skN+eUZ1XaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6lznSgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B586FC4CEC6;
	Wed, 16 Oct 2024 00:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729038766;
	bh=iHoB2CtxcbvJ6Ygv4kl5YbKNImTMb7GFaBl6ohxzF0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P6lznSguM+46Y9q2WGQsWzv5yGOriwtV/gu0pd2QmpsZD4AvrHIAcS0UAhi1fv+4w
	 x3vsGaeV+LzGSVgfKr56Mfo7OVvLeYoQhaU+wo1G2U/PaOFbXtFb+HPI2e7fL503s9
	 V1SWG5JwZ7Z56aVyDdy9c3+iKF+a6fuzZmtll2vxMvFzjzRoH3OmNSoqMSss1RkWwl
	 CYo+TM7UTGxP4uO9D8arRN0TN5WEiJIM5y7OdR4vRc+E7FNnT0WNUVdySFODIr2oUf
	 uYQzkDhAQoWcMtJeSybIu7oprak4XjKRMmrRFfSK9QO3rRz7K6PP97lfGEltIwpgfW
	 Tg4dfAyPnM0IA==
Date: Tue, 15 Oct 2024 18:32:43 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: [PATCH 4/5][next] uapi: net: arp: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <f04e61e1c69991559f5589080462320bf772499d.1729037131.git.gustavoars@kernel.org>
References: <cover.1729037131.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729037131.git.gustavoars@kernel.org>

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Address the following warnings by changing the type of the middle struct
members in a couple of composite structs, which are currently causing
trouble, from `struct sockaddr` to `struct sockaddr_legacy`. Note that
the latter struct doesn't contain a flexible-array member.

include/uapi/linux/if_arp.h:118:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/if_arp.h:119:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/if_arp.h:121:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/if_arp.h:126:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/if_arp.h:127:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Also, update some related code, accordingly.

No binary differences are present after these changes.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/uapi/linux/if_arp.h | 18 +++++++++---------
 net/ipv4/arp.c              |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/if_arp.h b/include/uapi/linux/if_arp.h
index 4783af9fe520..cb6813f7783a 100644
--- a/include/uapi/linux/if_arp.h
+++ b/include/uapi/linux/if_arp.h
@@ -115,18 +115,18 @@
 
 /* ARP ioctl request. */
 struct arpreq {
-	struct sockaddr	arp_pa;		/* protocol address		 */
-	struct sockaddr	arp_ha;		/* hardware address		 */
-	int		arp_flags;	/* flags			 */
-	struct sockaddr arp_netmask;    /* netmask (only for proxy arps) */
-	char		arp_dev[IFNAMSIZ];
+	struct sockaddr_legacy	arp_pa;		/* protocol address		 */
+	struct sockaddr_legacy	arp_ha;		/* hardware address		 */
+	int			arp_flags;	/* flags			 */
+	struct sockaddr_legacy	arp_netmask;    /* netmask (only for proxy arps) */
+	char			arp_dev[IFNAMSIZ];
 };
 
 struct arpreq_old {
-	struct sockaddr	arp_pa;		/* protocol address		 */
-	struct sockaddr	arp_ha;		/* hardware address		 */
-	int		arp_flags;	/* flags			 */
-	struct sockaddr	arp_netmask;    /* netmask (only for proxy arps) */
+	struct sockaddr_legacy	arp_pa;		/* protocol address		 */
+	struct sockaddr_legacy	arp_ha;		/* hardware address		 */
+	int			arp_flags;	/* flags			 */
+	struct sockaddr		arp_netmask;    /* netmask (only for proxy arps) */
 };
 
 /* ARP Flag values. */
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 11c1519b3699..3a97efe1587b 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1185,7 +1185,7 @@ static int arp_req_get(struct net *net, struct arpreq *r)
 
 	read_lock_bh(&neigh->lock);
 	memcpy(r->arp_ha.sa_data, neigh->ha,
-	       min(dev->addr_len, sizeof(r->arp_ha.sa_data_min)));
+	       min(dev->addr_len, sizeof(r->arp_ha.sa_data)));
 	r->arp_flags = arp_state_to_flags(neigh);
 	read_unlock_bh(&neigh->lock);
 
-- 
2.34.1


