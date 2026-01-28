Return-Path: <netdev+bounces-254487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGxwJliNemk37wEAu9opvQ
	(envelope-from <netdev+bounces-254487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:27:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00154A98E4
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9EB1301809D
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8842344029;
	Wed, 28 Jan 2026 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="je7fEDoE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770EE3191C9
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769639250; cv=none; b=JPdBnKASE0eVjrK1p3ZwtQ6HU8hJJ1hdXnovnV9J+YiJQbNScVaSs1igcw7QER2bzW4PGCm3aNUnUrhPn/uKI7FK4k/z6A+1VLSZElBKyPqKt5cVoTyl2l84E/gas2SfUxeHI2xakYfXd4p2XMIpKdUK9yoYFPBDnOr0nd1MFAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769639250; c=relaxed/simple;
	bh=DX1dunjFl7ul6NzJr9ty/Zk8vvkbi/BbccSxsuaroQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e78/D4yeJ4wKsCOPFTwua4BKFkVJ8qWIqtTLu36WuUIYXK+oSgzOG7DoUJStbpTjF+Ds5TIHiYFBzEYtzL0ZIdC06BDv/Zkho7sdwyepSgqCKZ1BKX59YCibN1eb3xlsWM/TQLN5JiWplUsqjESXsPT5Tp6BLx0J00w6pHuDRSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=je7fEDoE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a7b23dd036so1303725ad.3
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 14:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1769639248; x=1770244048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3eYfjgqY4a/BMsIpyzIRy1aMQwrAiII0bz0e/dp/Dkk=;
        b=je7fEDoESR1eSvSBe8qjZX0CQIy8Cz0JqW/ILWr7GopkEuZqKMBMbhMl7GJnx3u9vE
         2MWDgxnLB6DQOl+FmngFA/s5BjNoxj3rvwJme1IF7b6drgpBWKILvfR+ti5g6NFjET+R
         mDWenW4QZsMcufecH2iHzIk4ud2QNyM+LBDTEm0MlR6jGwe2vD08zinCl0BmwJYlPnwL
         bN4y6TaLlUbwdtjODEtmg49WT3hkwZ0Umrb7n7QyYwC4slD0sAIpleRL4SyOsf+Cz3VA
         SP8A/nfo8ysmwzDf6gkKyoCoo7/jLTQQ2kXydEDWz7HgrLCSPyWxR5wVrd2YVcO0OOfY
         pCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769639248; x=1770244048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eYfjgqY4a/BMsIpyzIRy1aMQwrAiII0bz0e/dp/Dkk=;
        b=IIA+BM5sU3zUp+DpTt3QVjYrUFrsx3yAIDKlbWTzYJ8ph2woGwvZ3hLmOODV4Rnjhh
         F4usqeS6GBY3ZMZocltdJsMHByhZrOAJKQCk1azRO1Oq7Tyx0VbG0ChiyjMfej3fJc1x
         JvYC46asKVT5dFpw2qmD3JMhXIxbbtOTtyCA6izzwx1j6kZOdfqSr5a0pHsUoQZxw2ws
         iZ6cvspYgwDb3jcqpqa5vcId4+l/sg81Kl7vq9PKoBAazVw3yrbvXE66XCovbCksojT5
         LlA9zBmMQ95UFcC11suuVt/Qbbu557f6d541m2G0qkoNw/vPqDf8AVPtYQobjAjedDb3
         61Ww==
X-Gm-Message-State: AOJu0Yy/o8FpjhCrKn1+S/uS6hcQb3xzb8iI8+UPBwIr/LRPGsAz6GXa
	u4a4mFiveXgeHbJcBngP4Eoim2QWhAwJHCWUbTPHwWCrLaF1rFVuQWh6dAWtszxAOtykwa1IkS7
	npHPu
X-Gm-Gg: AZuq6aKdEUIYEbP4QuKlSsvw9e4ObOhCSUTLgzuRMFICqZ2sjoWK+JKBTngFArLKUQc
	dtBBtsNgn4353RmDmb8h4J2DTDAPUDYhCk2wqX9VyvCKcP5hwMekbEnea9Q+pkkGJUtjJjkmTgq
	iwgPyGyso8cnOhd8IyqgF9x2iPLPZPNTz/JN5RHPXYVzqiS2lhwJquDa4GNF5Y7SeqMYEkGzN2V
	gMkdwQb/S6tJ4bU17gGJTxOZJ6hzYX5cGT6pD/ALr2YdjnuxSa44Ys9fXkIi7psJcApXchZGT97
	w5wDuwuEXLXortiFaw59aY+PU8CJWL2JB35obMAHv8y4bFTkDIE800zgR2tMiJQvSWbloGhwrR3
	XSd7LqOkh6TSxe0xTwQziyRowp2MuvykKu/NZ6U7qMBAto1BjcNdP7pKhcgEauGF2
X-Received: by 2002:a17:903:3b84:b0:297:df4e:fdd5 with SMTP id d9443c01a7336-2a870dd5039mr63469825ad.23.1769639248298;
        Wed, 28 Jan 2026 14:27:28 -0800 (PST)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c40e1sm32169395ad.55.2026.01.28.14.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 14:27:27 -0800 (PST)
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
Subject: [PATCH net-next] bnxt_en: Allow ntuple filters for drops
Date: Wed, 28 Jan 2026 14:27:17 -0800
Message-ID: <20260128222718.1679581-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254487-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 00154A98E4
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

Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 6b15fedbb16f..fd32231bf8e0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1353,10 +1353,12 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
 	if (!bp->vnic_info)
 		return -EAGAIN;
 
-	vf = ethtool_get_flow_spec_ring_vf(fs->ring_cookie);
-	ring = ethtool_get_flow_spec_ring(fs->ring_cookie);
-	if ((fs->flow_type & (FLOW_MAC_EXT | FLOW_EXT)) || vf)
-		return -EOPNOTSUPP;
+	if (fs->ring_cookie != RX_CLS_FLOW_DISC) {
+		vf = ethtool_get_flow_spec_ring_vf(fs->ring_cookie);
+		ring = ethtool_get_flow_spec_ring(fs->ring_cookie);
+		if ((fs->flow_type & (FLOW_MAC_EXT | FLOW_EXT)) || vf)
+			return -EOPNOTSUPP;
+	}
 
 	if (flow_type == IP_USER_FLOW) {
 		if (!bnxt_verify_ntuple_ip4_flow(&fs->h_u.usr_ip4_spec,

base-commit: 239f09e258b906deced5c2a7c1ac8aed301b558b
-- 
2.47.3


