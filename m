Return-Path: <netdev+bounces-241975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AD6C8B3B9
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD817359B05
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF26314A76;
	Wed, 26 Nov 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="nfxEgPcf"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2222312834;
	Wed, 26 Nov 2025 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764178601; cv=none; b=sLQwMcXEEvwRx48BNUOLHhUkjyR6y2O8T5vure85Szu/trWdXV0C+TOp7TByvb8bOT/o75MCqRMWZAFmCtomJxejIy5Ipr8ExDgt2ilT/Bz6KcV++7HgkAsHJ+WKwGWx8CKmNVpYW8gTvY180bFSajuR3HFJhmDR+FhQN57sB9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764178601; c=relaxed/simple;
	bh=a62PzhsjiYPfays+dr02XXmYWYlahFKTmCbyir6Bii8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TS0hM8hOj5FbcYkLf3QFRnTtyNSdjdGkozGxayjiwOrhAFAZO6ukCuRrI6YT4bS4jjAIf/o6Qmv9dYxey1F9N+YTiQZnMEhnaRY5XqHSxdn+TrN+I62qWnPjb4nq8GenA4IdV7CA4vfk4zgYRLFIMY+bAfxtHuqa0gGsUzP1dc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=nfxEgPcf; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1764178585;
	bh=a62PzhsjiYPfays+dr02XXmYWYlahFKTmCbyir6Bii8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nfxEgPcf1A3cgqZfi3Nj/wORaVg4z6MRyrGgDL9ndXu1v19OeVEaueqqhw+fnVfdw
	 ZbyCeR1h3WSFv2A7u0aADKEwOIlBtL9aXOKEKDozGHbcWCyxwOtZZzxBA+Qo91YXJF
	 d9xX/p8kOYANMXDa/xh2G9jMil9hJGCP82Bw7d2+j3KVZNTwEIV4fVoWgRYB8RKxnh
	 APWKGhHxZVjQZ8CvzykguB9EHshNobzBem1IjWaVC9KykZIxNcC30nKDKpnx9B3uvZ
	 4Ni6Lrcf5irpFmkXAVYTiwEjkfjv/qHQAHF1VmpDjWYClmwckRA6HxhR14E1Kv0lFl
	 MBCo/HBff7oYQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id AE25C60115;
	Wed, 26 Nov 2025 17:36:25 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id CD969203CDB; Wed, 26 Nov 2025 17:35:52 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jordan Rife <jordan@jrife.io>
Subject: [PATCH wireguard v4 07/10] wireguard: uapi: move flag enums
Date: Wed, 26 Nov 2025 17:35:39 +0000
Message-ID: <20251126173546.57681-8-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126173546.57681-1-ast@fiberby.net>
References: <20251126173546.57681-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move the wg*_flag enums, so they are defined above the attribute set
enums, where ynl-gen would place them.

This is an incremental step towards adopting an UAPI header generated
by ynl-gen. This is split out to keep the patches readable.

This is a trivial patch with no behavioural changes intended.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 include/uapi/linux/wireguard.h | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/wireguard.h b/include/uapi/linux/wireguard.h
index 3ebfffd61269a..a2815f4f29104 100644
--- a/include/uapi/linux/wireguard.h
+++ b/include/uapi/linux/wireguard.h
@@ -15,6 +15,20 @@ enum wgdevice_flag {
 	WGDEVICE_F_REPLACE_PEERS = 1U << 0,
 	__WGDEVICE_F_ALL = WGDEVICE_F_REPLACE_PEERS
 };
+
+enum wgpeer_flag {
+	WGPEER_F_REMOVE_ME = 1U << 0,
+	WGPEER_F_REPLACE_ALLOWEDIPS = 1U << 1,
+	WGPEER_F_UPDATE_ONLY = 1U << 2,
+	__WGPEER_F_ALL = WGPEER_F_REMOVE_ME | WGPEER_F_REPLACE_ALLOWEDIPS |
+			 WGPEER_F_UPDATE_ONLY
+};
+
+enum wgallowedip_flag {
+	WGALLOWEDIP_F_REMOVE_ME = 1U << 0,
+	__WGALLOWEDIP_F_ALL = WGALLOWEDIP_F_REMOVE_ME
+};
+
 enum wgdevice_attribute {
 	WGDEVICE_A_UNSPEC,
 	WGDEVICE_A_IFINDEX,
@@ -29,13 +43,6 @@ enum wgdevice_attribute {
 };
 #define WGDEVICE_A_MAX (__WGDEVICE_A_LAST - 1)
 
-enum wgpeer_flag {
-	WGPEER_F_REMOVE_ME = 1U << 0,
-	WGPEER_F_REPLACE_ALLOWEDIPS = 1U << 1,
-	WGPEER_F_UPDATE_ONLY = 1U << 2,
-	__WGPEER_F_ALL = WGPEER_F_REMOVE_ME | WGPEER_F_REPLACE_ALLOWEDIPS |
-			 WGPEER_F_UPDATE_ONLY
-};
 enum wgpeer_attribute {
 	WGPEER_A_UNSPEC,
 	WGPEER_A_PUBLIC_KEY,
@@ -52,10 +59,6 @@ enum wgpeer_attribute {
 };
 #define WGPEER_A_MAX (__WGPEER_A_LAST - 1)
 
-enum wgallowedip_flag {
-	WGALLOWEDIP_F_REMOVE_ME = 1U << 0,
-	__WGALLOWEDIP_F_ALL = WGALLOWEDIP_F_REMOVE_ME
-};
 enum wgallowedip_attribute {
 	WGALLOWEDIP_A_UNSPEC,
 	WGALLOWEDIP_A_FAMILY,
-- 
2.51.0


