Return-Path: <netdev+bounces-255283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Oy0xNmVNfWmkRQIAu9opvQ
	(envelope-from <netdev+bounces-255283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:31:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29625BFA15
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7467C3014C62
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 00:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E03B2D8367;
	Sat, 31 Jan 2026 00:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="heUjay/2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9E218027
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 00:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769819490; cv=none; b=IxMwe+unt5DeaVqs8I6fEzx14CEcFfsmYBnkTJKjHtauGe4QnhLk7K3DuYJ/v/bH0ktTzkTIjthB2foniv0l4v2Y+ne+raaQKlQbelx2xvSNFf2paqiKcma6lZtG0Uw0VjAzXPAgLBmo+B3COSmxIXORzTp7wNrLjWveu5le5Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769819490; c=relaxed/simple;
	bh=9oBcU60APrXdRDUwgOJ/YVbZTh/KIjGr/FLUseRN3zo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ozG3NfQlhrj1OYaZ7prR1CwKlVBD4roB27Lzkwd2leQIxhPloOPDeacAWUR4LnQEtkKeWLYJcui6BRniRhd9SL6oTj3fXMBA7Kre8sOd36vyWT3wYRbTH47FbVo2yZqJqVGOLJ9x4SxgSfxYkzPcrqjDNcc7KVPCTat0FTZTAMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=heUjay/2; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so1057002a12.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 16:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1769819488; x=1770424288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nNet+qCw5kKXXKdFjfZxFhD9/MzzBmPNM66XEuqgsbs=;
        b=heUjay/2bOLDS3cGfZWOcCaK24YcgEukJXeHlRJ/7+wwMfELzdQB6hbnoi/xE/bTEY
         UmFMVwbXVr1MBJx+Mhocw9/u8fHkFZYkZA7ImJNWDgRu6mo2xaV1tUoaYmjO3w9Zzkng
         ABuLtzEttUzTrt+qF0QJRKZryCENlbYgZAUf2kWyXVELXn4P8RV+eDtUUQ6J09BGGiBp
         g6d7DnmkbtqhqhWgGEZR590ziCVaFkYGTAKAm6OZeb+6dKhhtsedcJ3nWZC0/J/yFgNd
         n4+UVsdCZCFpVt8vc1eVb3MuBQwT3OpUpN1nCjBva5tMEM+WBPAg0z6fsYv0C/9XEQ0D
         /e6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769819488; x=1770424288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNet+qCw5kKXXKdFjfZxFhD9/MzzBmPNM66XEuqgsbs=;
        b=Mla97sTluxyQbkDJLKbiFZY0KEZyd5vqcrReQEwdfeBEQB9SvM/xggsG1k6vhluhvC
         zwm/qVF/YTzKNu1YOLAmGJSjQCCbuT/q+olB1fPKnx+5RuRjDkQ6k8fmCanjIU0/OAsw
         Kp0f0mZPAC6dLX5aUI0hxWm0dZHwWwpv0Z7b3yTQTM9fzH2Ux4yI4+hGzzya/J9I+N8x
         CXZnYe7cQrVPEJWRXkqiF7nVPXL/TMI9rYY4+mQIwsWuea6XF8xYn7qNBjAF/ts3Ur3J
         Fps6Tcs5QY8RyEp3Y50qb0/tVSjOf8/liEptoE/2mstKV+v9I4QFZ+MIkRbPNKemL9w0
         oeQQ==
X-Gm-Message-State: AOJu0Yzd7QnzVIM9Ih4WVziAZzemu5bX36pJto/y1y/nMyxLN0xTwxR+
	ZBPu0Hr34rQ/7nXsxBD08Gc1MuSK/sIw6ouc3a1mjN/B9HDCn06lVGqUyZsV7GF/6/6coqPQptt
	PNMOS
X-Gm-Gg: AZuq6aJnjtohgEXmIp+37grPv19RlxQNW/4jCHx8sCd2jMzrUOIt2hZl00U/fj0XgoM
	BUNeReWc9UIo+6Pz0UKBK/wC5RkAACKsP0L0axrFAPioF5kE+u/6OF7R5jsIHi+dNakZFciDt8T
	kzPD6D6b6c5yIMotBwEHGHc535hO1L1J5zQZv07M389kpV5rniT6MsQ/32IXvDXdTfGWnCEfiIK
	U19TpKsd0lrmv6UpaJzBKqN8bcoGjFqyKKEHCETFszs6ukGtT3zFI12J7o536ImBlprznIRbRrf
	T/mriw8coTLMxMB1xmuZ4c/Q+tQ9cR7Fz74up85RjrExLUyovk0EuJqZ+fxW3KFxWoaaevsLykv
	XfBvrDmMWvHS9pfad+HoZGHip1+x27u7gnuV28JpLm/aGyzOCbL/PH8h7dMh81Yo6s9f8obZU0O
	ieMLs=
X-Received: by 2002:a17:90b:2e41:b0:340:bb51:17eb with SMTP id 98e67ed59e1d1-3543b34fcbcmr4748872a91.15.1769819487720;
        Fri, 30 Jan 2026 16:31:27 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c1eeebsm9213290b3a.45.2026.01.30.16.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 16:31:27 -0800 (PST)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: shruti.parab@broadcom.com,
	Joe Damato <joe@dama.to>
Subject: [PATCH net-next v3] bnxt_en: Allow ntuple filters for drops
Date: Fri, 30 Jan 2026 16:30:41 -0800
Message-ID: <20260131003042.2570434-1-joe@dama.to>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255283-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email]
X-Rspamd-Queue-Id: 29625BFA15
X-Rspamd-Action: no action

It appears that in commit 7efd79c0e689 ("bnxt_en: Add drop action
support for ntuple"), bnxt gained support for ntuple filters for packet
drops.

However, support for this does not seem to work in recent kernels or
against net-next:

  % sudo ethtool -U eth0 flow-type udp4 src-ip 1.1.1.1 action -1
    rmgr: Cannot insert RX class rule: Operation not supported
    Cannot insert classification rule

The issue is that the existing code uses ethtool_get_flow_spec_ring_vf,
which will return a non-zero value if the ring_cookie is set to
RX_CLS_FLOW_DISC, which then causes bnxt_add_ntuple_cls_rule to return
-EOPNOTSUPP because it thinks the user is trying to set an ntuple filter
for a vf.

Fix this by first checking that the ring_cookie is not RX_CLS_FLOW_DISC.

After this patch, ntuple filters for drops can be added:

  % sudo ethtool -U eth0 flow-type udp4 src-ip 1.1.1.1 action -1
  Added rule with ID 0

  % ethtool -n eth0
  44 RX rings available
  Total 1 rules

  Filter: 0
      Rule Type: UDP over IPv4
      Src IP addr: 1.1.1.1 mask: 0.0.0.0
      Dest IP addr: 0.0.0.0 mask: 255.255.255.255
      TOS: 0x0 mask: 0xff
      Src port: 0 mask: 0xffff
      Dest port: 0 mask: 0xffff
      Action: Drop

Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
v3:
 - Removed unused vf variable as suggested by Michael Chan
 - Added Michael Chan's Reviewed-by

v2: https://lore.kernel.org/netdev/20260130002323.2561266-1-joe@dama.to/
  - Extract the FLOW_MAC_EXT and FLOW_EXT check so it happens unconditionally. 
  - Eliminate the local variable ring, which was used in only one place and
    call ethtool_get_flow_spec_ring instead.

v1: https://lore.kernel.org/netdev/20260128222718.1679581-1-joe@dama.to/
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 6b15fedbb16f..53a83b6680c4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1346,16 +1346,17 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
 	struct bnxt_l2_filter *l2_fltr;
 	struct bnxt_flow_masks *fmasks;
 	struct flow_keys *fkeys;
-	u32 idx, ring;
+	u32 idx;
 	int rc;
-	u8 vf;
 
 	if (!bp->vnic_info)
 		return -EAGAIN;
 
-	vf = ethtool_get_flow_spec_ring_vf(fs->ring_cookie);
-	ring = ethtool_get_flow_spec_ring(fs->ring_cookie);
-	if ((fs->flow_type & (FLOW_MAC_EXT | FLOW_EXT)) || vf)
+	if (fs->flow_type & (FLOW_MAC_EXT | FLOW_EXT))
+		return -EOPNOTSUPP;
+
+	if (fs->ring_cookie != RX_CLS_FLOW_DISC &&
+	    ethtool_get_flow_spec_ring_vf(fs->ring_cookie))
 		return -EOPNOTSUPP;
 
 	if (flow_type == IP_USER_FLOW) {
@@ -1481,7 +1482,7 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
 	if (fs->ring_cookie == RX_CLS_FLOW_DISC)
 		new_fltr->base.flags |= BNXT_ACT_DROP;
 	else
-		new_fltr->base.rxq = ring;
+		new_fltr->base.rxq = ethtool_get_flow_spec_ring(fs->ring_cookie);
 	__set_bit(BNXT_FLTR_VALID, &new_fltr->base.state);
 	rc = bnxt_insert_ntp_filter(bp, new_fltr, idx);
 	if (!rc) {

base-commit: 6ad42b24413630199cb9f35d073f71768788f8dc
-- 
2.47.3


