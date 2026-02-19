Return-Path: <netdev+bounces-259513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2H5ILrY6l2l2vwIAu9opvQ
	(envelope-from <netdev+bounces-259513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:30:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D10160ADE
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49DAB30191A8
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 16:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7864034B437;
	Thu, 19 Feb 2026 16:29:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9BD1EB9E1;
	Thu, 19 Feb 2026 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771518540; cv=none; b=Nca3P8EF0Fnylv4e4OH2GPG6z0PLtMM7ugr8gupyPxtbzkI0jbb7MEbrz1ZAVRIJcQLm8L5UyXjIivO8LPtMB2lfZTtkkBFoyJ+m6TEng9+xNngWV41MqFn++1gjJkwmDXNww+esPiWqTJpir0wesz2+fBw5tZcTr1DtFcAdq+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771518540; c=relaxed/simple;
	bh=Lc8htHD2TqjT/LzXCol2qwK8bhaGPjt6Ytomi4CXJoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MzjJl20Z0YYvHKknvV1/49eNKZUkHHXoo5JmXRL0GaGOg/UsPTuDN1fhXxyTSeXQ+3+jOLnFlOA/fy32cb0V/Yby7pA1xI+YPQ23pA6IS7sWwSr0kgamLLcqBkDpmSXCvqw5qhDoxj+hz4O+Qgx9OoPsv9MlDlQPLiKugZl3uJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id EEA03475E3;
	Thu, 19 Feb 2026 17:22:06 +0100 (CET)
From: Gabriel Goller <g.goller@proxmox.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] docs: net: document neigh gc_interval and gc_stale_time sysctls
Date: Thu, 19 Feb 2026 17:21:58 +0100
Message-ID: <20260219162200.510325-1-g.goller@proxmox.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1771518116948
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259513-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[proxmox.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[g.goller@proxmox.com,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proxmox.com:mid,proxmox.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17D10160ADE
X-Rspamd-Action: no action

Add missing documentation for two neighbor table garbage collector
sysctl parameters in ip-sysctl.rst:

 * neigh/default/gc_interval: controls how often the garbage collector
   runs for neighbor entries (default: 30 seconds)
 * neigh/default/gc_stale_time: controls how long an unused neighbor
   entry is kept before becoming eligible for garbage collection
   (default: 60 seconds)

Signed-off-by: Gabriel Goller <g.goller@proxmox.com>
---
 Documentation/networking/ip-sysctl.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 28c7e4f5ecf9..033e18303d79 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -202,6 +202,21 @@ neigh/default/gc_thresh3 - INTEGER
 
 	Default: 1024
 
+neigh/default/gc_interval - INTEGER
+	How often the garbage collector for neighbor entries should run. This
+	value applies to the entire table, not individual entries.
+
+	Default: 30 seconds
+
+neigh/default/gc_stale_time - INTEGER
+	Determines how long a neighbor entry can remain unused before it is
+	considered stale and eligible for garbage collection. Entries that have
+	not been used for longer than this time will be removed by the garbage
+	collector, unless they have active references, are marked as PERMANENT,
+	or carry the NTF_EXT_LEARNED or NTF_EXT_VALIDATED flag.
+
+	Default: 60 seconds
+
 neigh/default/unres_qlen_bytes - INTEGER
 	The maximum number of bytes which may be used by packets
 	queued for each	unresolved address by other network layers.
-- 
2.47.3



