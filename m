Return-Path: <netdev+bounces-256313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNqyH0UCgmmYNgMAu9opvQ
	(envelope-from <netdev+bounces-256313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:12:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA608DA64F
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 15:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F08D3066836
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 14:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A313A4F39;
	Tue,  3 Feb 2026 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xx2/mPu2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6pbbJOQn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xx2/mPu2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6pbbJOQn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ACF3A4F48
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770127918; cv=none; b=MI3DzF8DhRmtTeV+ilqFQZAVzcqjzAeagzTxftFKMDeIklWQJXGFYzgoG7TgaueGFpCK4zpzLAGZhPLjcsoc6bjxeCSxum3u8jdt+GN30Cu2m3X7lHuphAHRIyhfgLm8MEg/TcO7x7AwsNFOVfPHaAmDABRhuviEE938ldphcF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770127918; c=relaxed/simple;
	bh=TX/BuBNdfcXbY7I6FBnyQtnO2IYNCp9D92IFrM4t4Rs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=F2lLt8c2l1WnbeX7dj+OWjkO23cemaLsaMQWspQqxXaliE4x8nBtVJP/JJEDUxPmAzLlDZA4OLcBAks0WTgrVswKvu/mT9iD2Qr25MzLXsiXQNkzCF61glRzUcQeEmI1VAQlFNZcOjFozY0YtQS23H0Jq0fGp4/cogIWaZhyk2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xx2/mPu2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6pbbJOQn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xx2/mPu2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6pbbJOQn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 17EDF3E6C3;
	Tue,  3 Feb 2026 14:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770127915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0RMzXHsPQlgkeAYbDLGcLFgF5Ph+Gtc4fbF+WDWzyf0=;
	b=Xx2/mPu2ak55Dbxq6DT8bviMY+MDKO0Nxzn2YiGxDj2MozgmuOK77lQqD13RroYFH6EOkj
	vQs4YqOER2OUumuTTVS4vaY9KRgs8+6ttHD0hslG95zjDEyLa3wwGUTi53j3PIyd8eqO6I
	yLaO0Q3qLo0sjlsGTsU1S0dFTBgxpM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770127915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0RMzXHsPQlgkeAYbDLGcLFgF5Ph+Gtc4fbF+WDWzyf0=;
	b=6pbbJOQntLAl8IkzFpb4gogbh01ipertL8l3EIZLfLBBuT32b4ISt+gf3/yVuCCEFx/74C
	Gi8+3c9GU28ZpUAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Xx2/mPu2";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6pbbJOQn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770127915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0RMzXHsPQlgkeAYbDLGcLFgF5Ph+Gtc4fbF+WDWzyf0=;
	b=Xx2/mPu2ak55Dbxq6DT8bviMY+MDKO0Nxzn2YiGxDj2MozgmuOK77lQqD13RroYFH6EOkj
	vQs4YqOER2OUumuTTVS4vaY9KRgs8+6ttHD0hslG95zjDEyLa3wwGUTi53j3PIyd8eqO6I
	yLaO0Q3qLo0sjlsGTsU1S0dFTBgxpM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770127915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0RMzXHsPQlgkeAYbDLGcLFgF5Ph+Gtc4fbF+WDWzyf0=;
	b=6pbbJOQntLAl8IkzFpb4gogbh01ipertL8l3EIZLfLBBuT32b4ISt+gf3/yVuCCEFx/74C
	Gi8+3c9GU28ZpUAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED71C3EA62;
	Tue,  3 Feb 2026 14:11:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Yw7cOSoCgmkSGQAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Tue, 03 Feb 2026 14:11:54 +0000
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Weiping Pan <wpan@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net] bonding: only set speed/duplex to unknown, if getting speed failed
Date: Tue,  3 Feb 2026 15:11:52 +0100
Message-ID: <20260203141153.51581-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[tbogendoerfer@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256313-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: EA608DA64F
X-Rspamd-Action: no action

bond_update_speed_duplex() first set speed/duplex to unknown and
then asks slave driver for current speed/duplex. Since getting
speed/duplex might take longer there is a race, where this false state
is visible by /proc/net/bonding. With commit 691b2bf14946 ("bonding:
 update port speed when getting bond speed") this race gets more visible,
if user space is calling ethtool on a regular base.

Fix this by only setting speed/duplex to unknown, if link speed is
really unknown/unusable.

Fixes: 98f41f694f46 ("bonding:update speed/duplex for NETDEV_CHANGE")
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
v2: corrected fixes tag
v1: https://lore.kernel.org/all/20260130111904.144024-1-tbogendoerfer@suse.de/

 drivers/net/bonding/bond_main.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e7caf400a59c..4cdf89b21ca0 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -791,26 +791,29 @@ static int bond_update_speed_duplex(struct slave *slave)
 	struct ethtool_link_ksettings ecmd;
 	int res;
 
-	slave->speed = SPEED_UNKNOWN;
-	slave->duplex = DUPLEX_UNKNOWN;
-
 	res = __ethtool_get_link_ksettings(slave_dev, &ecmd);
 	if (res < 0)
-		return 1;
+		goto speed_duplex_unknown;
 	if (ecmd.base.speed == 0 || ecmd.base.speed == ((__u32)-1))
-		return 1;
+		goto speed_duplex_unknown;
 	switch (ecmd.base.duplex) {
 	case DUPLEX_FULL:
 	case DUPLEX_HALF:
 		break;
 	default:
-		return 1;
+		goto speed_duplex_unknown;
 	}
 
 	slave->speed = ecmd.base.speed;
 	slave->duplex = ecmd.base.duplex;
 
 	return 0;
+
+speed_duplex_unknown:
+	slave->speed = SPEED_UNKNOWN;
+	slave->duplex = DUPLEX_UNKNOWN;
+
+	return 1;
 }
 
 const char *bond_slave_link_status(s8 link)
-- 
2.43.0


