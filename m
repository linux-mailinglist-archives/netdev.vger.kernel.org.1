Return-Path: <netdev+bounces-126461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 292A29713B8
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 11:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1F91F253BB
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DCE1B3B33;
	Mon,  9 Sep 2024 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="gSIsSp2a"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8568E1B3743
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874213; cv=none; b=VLjyAqFNNgV7TI6ykB4B+Jyqp5TAWc08TxvcPriMgEUMKXRVZNq9N0GMuuXot1iMY2mPGyZ4CCOwEIXRbQa1lFA6DRU5A3x68kMcCAXGFQbMAeoDxZvCBlGqnqsBhYlwqeLLMHmHXLAhEERclk/eRMWOum0sN8KlFYRNDMIyLA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874213; c=relaxed/simple;
	bh=2hhaDnEh7i5vKpqyxWUvmq4KSr6Vp678dLSFZBgo2gM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HAV/anT4EqKcErTs8WgeNvG4zBI4Bi76Q7NXTmhAyY53Lc6RGZKyUJ9oJuqE3MOOkDxXQj2ZgfDXVY4230aDDtLx7f7l39LFKGzek0k0FNP3pPRGDnbdEKZ5Fy3EwqioMpuKdHesuW9rcwurzhCg52BvXLCl8GUMhKfv/E5sx7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=gSIsSp2a; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1725874206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sAB6jyL+HmPslrDlOyH4jXE06t7xjjOryXjF6q0+DDI=;
	b=gSIsSp2a4g53MZ+4UF0nGxCeQu5nURLMlcAc2T2HwYF6qF22RXdyQ856uVGsH2e9knMGMy
	+Mmtvz2NxstpuoRM4ZWTT7MmNiTNHFArpLg+h190J5ov0nbP6X5h3aUffjbvsH6GOke/RE
	dZ4oUDeLJmJOGbT5bCWxz7oNMg+qNTCjU53jI/zEugBVvhCuMfcFMmrj7rxFwXQa1M2iUg
	rqlqNhdFOz1B7mID1s8yiEZ2Vma5aGThVE5MVuboy+QNVAM3oxTem02AzwZ0qvIzn9cWnG
	T+mpQ+/FwGSsymOcuma4mfl01HF1pBMHcAaDZ77cOQJ2tpgW2Dyt2ThHl0wa2Q==
From: jane400 <jane400@postmarketos.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: jane400 <jane400@postmarketos.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH] uapi/if_arp.h: guard struct definition to not redefine libc's definitions
Date: Mon,  9 Sep 2024 11:28:55 +0200
Message-ID: <20240909092921.7377-2-jane400@postmarketos.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

musl libc defines the structs arpreq, arpreq_old and arphdr in
their <net/if_arp.h> header. Guard against a redefinition via
__UAPI_DEF_IF_ARP_ARPREQ for arpreq + arpreq_old and
__UAPI_DEF_IF_ARP_ARPHDR for arphdr.

A follow-up patch for musl is needed for this after this gets picked.

Redefinitions of all the various flags is fine, as this will only
produce warnings with a lenient compiler.

Signed-off-by: Jane Rachinger <jane400@postmarketos.org>
---
 include/uapi/linux/if_arp.h      | 8 ++++++++
 include/uapi/linux/libc-compat.h | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/uapi/linux/if_arp.h b/include/uapi/linux/if_arp.h
index 4783af9fe520..9f2dcc16c013 100644
--- a/include/uapi/linux/if_arp.h
+++ b/include/uapi/linux/if_arp.h
@@ -24,6 +24,7 @@
 #ifndef _UAPI_LINUX_IF_ARP_H
 #define _UAPI_LINUX_IF_ARP_H
 
+#include <linux/libc-compat.h>
 #include <linux/netdevice.h>
 
 /* ARP protocol HARDWARE identifiers. */
@@ -113,6 +114,8 @@
 #define	ARPOP_NAK	10		/* (ATM)ARP NAK			*/
 
 
+#if __UAPI_DEF_IF_ARP_ARPREQ
+
 /* ARP ioctl request. */
 struct arpreq {
 	struct sockaddr	arp_pa;		/* protocol address		 */
@@ -129,6 +132,8 @@ struct arpreq_old {
 	struct sockaddr	arp_netmask;    /* netmask (only for proxy arps) */
 };
 
+#endif
+
 /* ARP Flag values. */
 #define ATF_COM		0x02		/* completed entry (ha valid)	*/
 #define	ATF_PERM	0x04		/* permanent entry		*/
@@ -142,6 +147,8 @@ struct arpreq_old {
  *	This structure defines an ethernet arp header.
  */
 
+#if __UAPI_DEF_IF_ARP_ARPHDR
+
 struct arphdr {
 	__be16		ar_hrd;		/* format of hardware address	*/
 	__be16		ar_pro;		/* format of protocol address	*/
@@ -161,5 +168,6 @@ struct arphdr {
 
 };
 
+#endif
 
 #endif /* _UAPI_LINUX_IF_ARP_H */
diff --git a/include/uapi/linux/libc-compat.h b/include/uapi/linux/libc-compat.h
index 8254c937c9f4..e722c213f18b 100644
--- a/include/uapi/linux/libc-compat.h
+++ b/include/uapi/linux/libc-compat.h
@@ -194,6 +194,14 @@
 #define __UAPI_DEF_IF_NET_DEVICE_FLAGS_LOWER_UP_DORMANT_ECHO 1
 #endif
 
+/* Definitions for if_arp.h */
+#ifndef __UAPI_DEF_IF_ARP_ARPREQ
+#define __UAPI_DEF_IF_ARP_ARPREQ	1
+#endif
+#ifndef __UAPI_DEF_IF_ARP_ARPHDR
+#define __UAPI_DEF_IF_ARP_ARPHDR	1
+#endif
+
 /* Definitions for in.h */
 #ifndef __UAPI_DEF_IN_ADDR
 #define __UAPI_DEF_IN_ADDR		1

base-commit: 89f5e14d05b4852db5ecdf222dc6a13edc633658
-- 
2.46.0


