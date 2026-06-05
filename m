Return-Path: <netdev+bounces-295678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wu9TL3J6ImqNYAEAu9opvQ
	(envelope-from <netdev+bounces-295678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:27:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2416645F71
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:27:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=Xzqz3z2M;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295678-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295678-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C472A30283C1
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEEB47AF43;
	Fri,  5 Jun 2026 07:20:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22779478E20
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 07:20:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644021; cv=none; b=jAVtXauLpoJ5RupH8Njhdsqzd7YOmth5NtfM++fl9N/sTIwwYSVKEWgBgonLOh3SFN6IV9zyPT+rhB6fQI4hGOi3Hsxk03/KKkAC0TtioiTcnfgcSAL79ku4HaxfBv58owBkO99f0gOCpXUcfRI+Skh98hGO0JRuG72Pr9hZLUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644021; c=relaxed/simple;
	bh=0cTEkIom8PRgmqL1w/aqZe1bTqDSW00Whya5NRPSnyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e71X+mCWF+y0B5gxEzABHLpzcgfhi9+es3cZCNgZV802inT+8dst10iSY15cYOSFF4nhWuMxaR+PVBwmNpsjyIs30fYdGO/A0ThFR4eCOfGLXjZfHaLQvN7892lzdGVO1vHfAZCGiXCnKqyiMjS9X5KfgYc5jSn8g6tYOYC3crU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=Xzqz3z2M; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780644018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eoYEIYbvnyhBcDmR6uf7zB0wO4FVOJZsykYBKJGC6fY=;
	b=Xzqz3z2M3l+xKDXgC+r/XWHafAyV7pqqz5ZbH7givgEgrop4QFnpb/wwv9SjAYORFrd/bQ
	Wwwbb9jZm/X1houMwuOd/xWOs3lPiVp7yRFlZmzLwOlmB5nKhAsHfuTmRTcEd1ACFsKDaR
	XFjz9meJnFhPmb9ZAKa1Cl2MHeEzztEyqzm9qFZHEePmTA45WfRn7u8KHu4GPD+pHdJrj0
	qJPmKXQH8GtWTRSbEgqcJOryHa09/qBLo0aNYmptJ4XXfw3soJlz0gtoTXW3/cOs0esgGq
	XDY8GYTZzhKYtUaTAy1WyriWGVy8nFw5I/9Vm/hwgLXoyuAS+nZaI/FR62vG9Q==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 09/11] batman-adv: uapi: keep kernel-doc in struct member order
Date: Fri,  5 Jun 2026 09:20:03 +0200
Message-ID: <20260605072005.490368-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605072005.490368-1-sw@simonwunderlich.de>
References: <20260605072005.490368-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295678-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,simonwunderlich.de:mid,simonwunderlich.de:dkim,simonwunderlich.de:from_mime,simonwunderlich.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,narfation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2416645F71

From: Sven Eckelmann <sven@narfation.org>

The order of the members of struct batadv_coded_packet and struct
batadv_unicast_tvlv_packet didn't match the kernel doc. This is the case
for all other structures and should also be done the same way for these
two.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 include/uapi/linux/batadv_packet.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 439132a819eac..1241285b866cd 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -518,16 +518,16 @@ struct batadv_mcast_packet {
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the general header
  * @ttl: time to live for this packet, part of the general header
+ * @first_ttvn: tt-version number of first included packet
  * @first_source: original source of first included packet
  * @first_orig_dest: original destination of first included packet
  * @first_crc: checksum of first included packet
- * @first_ttvn: tt-version number of first included packet
  * @second_ttl: ttl of second packet
+ * @second_ttvn: tt version number of second included packet
  * @second_dest: second receiver of this coded packet
  * @second_source: original source of second included packet
  * @second_orig_dest: original destination of second included packet
  * @second_crc: checksum of second included packet
- * @second_ttvn: tt version number of second included packet
  * @coded_len: length of network coded part of the payload
  */
 struct batadv_coded_packet {
@@ -554,8 +554,8 @@ struct batadv_coded_packet {
  * @version: batman-adv protocol version, part of the general header
  * @ttl: time to live for this packet, part of the general header
  * @reserved: reserved field (for packet alignment)
- * @src: address of the source
  * @dst: address of the destination
+ * @src: address of the source
  * @tvlv_len: length of tvlv data following the unicast tvlv header
  * @align: 2 bytes to align the header to a 4 byte boundary
  */
-- 
2.47.3


