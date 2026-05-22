Return-Path: <netdev+bounces-290950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMDVHjHkEGqOfAYAu9opvQ
	(envelope-from <netdev+bounces-290950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:18:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1775BB6DC
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34C40304225F
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697433921F1;
	Fri, 22 May 2026 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PT3xGnW5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AEE390614
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491609; cv=none; b=nNTyiONHAUrpURXbPfzHctALAj7RtP9Pg1IlmZNV/c/jAw03TVsHisI9MaoHmyd5l/ivJUkJe71lKwLm188chPU7jN+RBeZtE8idFlGb/+DoWmSX0xtz6vF2DGCQ8tJoAp4m2GfbKxa1a4hjF1JR50/Tb1mk3ydW6GyC/pl+adE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491609; c=relaxed/simple;
	bh=Fez6u43JHnu5UDOWx/pPSXR660FEhxKYhKFB2XUcY9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlDV9RAUKR+lBUCFNSVKPYJM+l70FzN8bNPpSOkgNSGk07ZUcR8IMMFA/eAaCD9J1br0rVPYa7nCwvREBEQVjYkL8WyUUZn47rkKj5PS1T+FSzqcsa7nH2JvFmyI3QeUXOaVQJ4fI+FU2RLvedfioRaMtCsgsAvvU5DKMPB1vxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PT3xGnW5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935021F0155E;
	Fri, 22 May 2026 23:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779491608;
	bh=v9niaF4Uojso0oZVlKonLr3dXUFjfeqjw5teboOascA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PT3xGnW5gAw82VMH5k7DJNBc/BCFzweOqKPoc/2ZtQP9l9/OJlYXkevrMxB4Cw2EG
	 qdnO9U1MPmee3uCXDrtraS/m2O0YcdQR5oYUA8XqtzDo/drXmKUO7A2wMX0W8BlnMZ
	 OVB2BDzsD5SxG9pzNLY42s/LNbNvbPSOmm9NkBQVeH12W1rc3BFbO5uSgHSP3cBGj2
	 2s42Ax4nvWw1lZOVhQZRXCOZyWmVyNqagJqwtoEmMr4/lsH1OGEmJ2yWpYPXWe0s34
	 lHm8ZIihLhelmEBy73vIU9wSNxB4VMF2V1W1lQ/zAvhgk2t6+5i633DITZO8/O85gi
	 1vS+M6gf7EEkA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	petrm@nvidia.com,
	o.rempel@pengutronix.de,
	idosch@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch
Subject: [PATCH net 7/9] ethtool: cmis: fix u16-to-u8 truncation of msleep_pre_rpl
Date: Fri, 22 May 2026 16:13:10 -0700
Message-ID: <20260522231312.1710836-8-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522231312.1710836-1-kuba@kernel.org>
References: <20260522231312.1710836-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-290950-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:email]
X-Rspamd-Queue-Id: DD1775BB6DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ethtool_cmis_cdb_compose_args() accepts msleep_pre_rpl as u16 but stores
it into the u8 field ethtool_cmis_cdb_cmd_args::msleep_pre_rpl, silently
truncating values >= 256. Seven of the nine call sites pass 1000 ms
(it's the third argument from the end).

Fixes: a39c84d79625 ("ethtool: cmis_cdb: Add a layer for supporting CDB commands")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: petrm@nvidia.com
CC: danieller@nvidia.com
---
 net/ethtool/cmis.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/cmis.h b/net/ethtool/cmis.h
index 4a9a946cabf0..778783a0f23c 100644
--- a/net/ethtool/cmis.h
+++ b/net/ethtool/cmis.h
@@ -63,9 +63,9 @@ struct ethtool_cmis_cdb_request {
  * struct ethtool_cmis_cdb_cmd_args - CDB commands execution arguments
  * @req: CDB command fields as described in the CMIS standard.
  * @max_duration: Maximum duration time for command completion in msec.
+ * @msleep_pre_rpl: Waiting time before checking reply in msec.
  * @read_write_len_ext: Allowable additional number of byte octets to the LPL
  *			in a READ or a WRITE commands.
- * @msleep_pre_rpl: Waiting time before checking reply in msec.
  * @rpl_exp_len: Expected reply length in bytes.
  * @flags: Validation flags for CDB commands.
  * @err_msg: Error message to be sent to user space.
@@ -73,8 +73,8 @@ struct ethtool_cmis_cdb_request {
 struct ethtool_cmis_cdb_cmd_args {
 	struct ethtool_cmis_cdb_request req;
 	u16				max_duration;
+	u16				msleep_pre_rpl;
 	u8				read_write_len_ext;
-	u8				msleep_pre_rpl;
 	u8                              rpl_exp_len;
 	u8				flags;
 	char				*err_msg;
-- 
2.54.0


