Return-Path: <netdev+bounces-307092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 35HmD6SnVGqWowMAu9opvQ
	(envelope-from <netdev+bounces-307092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:53:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C7A748F8D
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:53:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=WbERo4Iv;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307092-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307092-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 050E43047C70
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03F03CF1F1;
	Mon, 13 Jul 2026 08:51:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DA819644B
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 08:51:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932669; cv=none; b=SXmrHab6WG0zrwIwqERFOkDEe6EY1t/P8AZiARSfoT9GLYJnNtsisFRqS6Tz2/saoKpithKvTbkyregNioYr8db9ngH8qKXMlys21Wh3zVBzC3fUrad4A1bH0Rmga3Hwfl6kwTV0ztdjXp7E8CL9dhb6F6SQsDcLfouhXISANa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932669; c=relaxed/simple;
	bh=LZmYzSZHvSmK27C5FKFswe2I1n14E2yXo0OLJz3yogQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b9LteLPCxtBUZdo7fSGaw4ut3B/fOIJmhAA5T3IKHkcZbvkYEAFeQDa5cMeqOnkaSm57Gi59jodQ/bzZ51xdNMPwctUKIpGhwT4aOQsIWerdUKsslPD++4tth8Ncz12hFsZkU86wgO8ssQo9ULmi9oPwV4N7y7NxavI3FUsplTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WbERo4Iv; arc=none smtp.client-ip=91.218.175.178
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783932665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XYaYW82p7wsV8E9db+1qghBp7beIn1ApUa8oU9ChvUM=;
	b=WbERo4IvAuB11DQOh4VbdujM8uekC7x9n0u74a61jH818R30RUUQShshZHtHNc/e4lvA1k
	0DWOWL2hfKODG3hsHL0NPYldo9sRDFcTaHq1K3/ycjJ/RslwbddUDydOCkJnegc8JXybzr
	x6+jumCaiQK4iw6k4wK5HagtRk8IpOA=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: chenguang.zhao@linux.dev,
	maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH net] net: txgbe: fix heap overflow when reading module EEPROM
Date: Mon, 13 Jul 2026 16:51:11 +0800
Message-Id: <20260713085111.1481884-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307092-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[chenguang.zhao@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jiawenwu@trustnetic.com,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:chenguang.zhao@linux.dev,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:zhaochenguang@kylinos.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenguang.zhao@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83C7A748F8D

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

txgbe_read_eeprom_hostif() always copies round_up(length, 4) bytes
into the caller buffer, which ethtool allocates with exactly 'length'
bytes. A non-4-aligned length therefore causes an out-of-bounds write.
Copy only the remaining bytes on the final dword instead.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index affea1a364ef..26d0cfc58ee2 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -96,11 +96,13 @@ int txgbe_read_eeprom_hostif(struct wx *wx,
 	dword_len = round_up(length, 4) >> 2;
 
 	for (i = 0; i < dword_len; i++) {
+		u32 copy_len = min_t(u32, 4, length - i * 4);
+
 		value = rd32a(wx, WX_FW2SW_MBOX, i + offset);
 		le32_to_cpus(&value);
 
-		memcpy(data, &value, 4);
-		data += 4;
+		memcpy(data, &value, copy_len);
+		data += copy_len;
 	}
 
 	return 0;
-- 
2.25.1


