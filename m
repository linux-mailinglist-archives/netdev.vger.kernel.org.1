Return-Path: <netdev+bounces-138877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B369AF48C
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 23:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB8E1C21E62
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 21:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC0C217911;
	Thu, 24 Oct 2024 21:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMkvpFS5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6391217338;
	Thu, 24 Oct 2024 21:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804429; cv=none; b=hOIUD81a8vrtAqZRD7BvN1PZW1cB2/QwE/YCk0pqZLewODB3R1PzJ8oCEF73A3cAWRsx08bybroHATufoc16YAcryJTp66XJo6V8lQmBsEGucm09C4hjMuxRpjLGRa4/2iU67mHIqVWrYSVMhOVnHf4jZ2N4woY6LhFUHsTu3xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804429; c=relaxed/simple;
	bh=go564DnfBiEx79xSbk4V/4Kf/fjy5zdl97UH8liwTnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3elEEWrqPUzBRYo9Kvn8mR0HQvzoT1KLBPtKn2K+ESs7lLVUr+V9BIS3N7+lA8luykM+trHODq0RG6MHLIPtzuaeb6MmbI3gkaLHytcTG+VsokL/zTSxEnEnVtq780WUo9p2vkcWieTKwaJACEZE/Ynwn7wyP99S8yiaqQAymc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMkvpFS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221F2C4CEC7;
	Thu, 24 Oct 2024 21:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729804429;
	bh=go564DnfBiEx79xSbk4V/4Kf/fjy5zdl97UH8liwTnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hMkvpFS5bU/4cGW/N/i+elpi8q8hEn8bQ6ByXvXB8teAKsSx6SzVXcvVz/6EAqjiz
	 JX/5rjlg6o1Nvpftw4Kfc7s3RoTAbbzeIYbD2+xBWBFpSsAn9fvSn8TxwbmNGTyAss
	 nwV2bj4EzLWZJUh+yRpkjJI97rjvcFTkmwdHgFnfHW+8VgYnnGAQuHeXKbKuDJ1L7/
	 xLIU+CVXpkWSflPqWlo6BwBYmBzh1oaSxU8zkhRWuzZ+8kAkwpyLeFAHHaOkSqGXcD
	 AEZVZf4X0AR24dSpdlQ/AvsnzH/GW6wJuRuMqz6wE4Jmgs6GtGcJ30ljSDxvtBGOVW
	 Sev3uG064/NGw==
Date: Thu, 24 Oct 2024 15:13:45 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v2 3/4][next] uapi: net: arp: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <903f37962945fe0aa46e1d05c2a05f39571a53fa.1729802213.git.gustavoars@kernel.org>
References: <cover.1729802213.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729802213.git.gustavoars@kernel.org>

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Address the following warnings by changing the type of the middle struct
members in a couple of composite structs, which are currently causing
trouble, from `struct sockaddr` to `struct __kernel_sockaddr_legacy`.

include/uapi/linux/if_arp.h:118:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/if_arp.h:119:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/if_arp.h:121:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/if_arp.h:126:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/if_arp.h:127:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Also, refactor some related code, accordingly.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/uapi/linux/if_arp.h | 18 +++++++++---------
 net/ipv4/arp.c              |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/if_arp.h b/include/uapi/linux/if_arp.h
index 4783af9fe520..4a25a05125d3 100644
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
+	struct __kernel_sockaddr_legacy	arp_pa;		/* protocol address		 */
+	struct __kernel_sockaddr_legacy	arp_ha;		/* hardware address		 */
+	int				arp_flags;	/* flags			 */
+	struct __kernel_sockaddr_legacy	arp_netmask;    /* netmask (only for proxy arps) */
+	char				arp_dev[IFNAMSIZ];
 };
 
 struct arpreq_old {
-	struct sockaddr	arp_pa;		/* protocol address		 */
-	struct sockaddr	arp_ha;		/* hardware address		 */
-	int		arp_flags;	/* flags			 */
-	struct sockaddr	arp_netmask;    /* netmask (only for proxy arps) */
+	struct __kernel_sockaddr_legacy	arp_pa;		/* protocol address		 */
+	struct __kernel_sockaddr_legacy	arp_ha;		/* hardware address		 */
+	int				arp_flags;	/* flags			 */
+	struct sockaddr			arp_netmask;    /* netmask (only for proxy arps) */
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


