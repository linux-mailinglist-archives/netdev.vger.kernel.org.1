Return-Path: <netdev+bounces-254954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MsENgz6e2n4JgIAu9opvQ
	(envelope-from <netdev+bounces-254954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 01:23:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD19B5E19
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 01:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51A533006B6B
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470A827A10F;
	Fri, 30 Jan 2026 00:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="aWiE6dzV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA3227144B
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769732616; cv=none; b=ICQAJHRkcJt5c220h3JvkPiFXZmL3I3PSry6atr1ebKZGn5RsjograENms5+xo7L34Qx9h2N1nonS0tPw9ZbDHoYs93v5DJRJTfLDL+fCIQoqdD13FRoMLHi208EuxM9/XV22IZxizmE6Z0sb+7MpkAB5wnbmKB/VWLDw0e2w9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769732616; c=relaxed/simple;
	bh=Bez8Q5r36ysIFUldkr/8dIXuKz9tz3zg5yj/t6pbohQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MtxiNDa6IS/srl2qcdWVbVFXKNJEUy/S5SkMwnR0HiySx38lGyVeFJZsQcMSBF4b/ES8BjFCAa/C79Gf0n4hBUsYoZLfLL754TUmXazj/AopQZa97otHftsNdr6XAuXGb58s+ABUklWH6LusEy5wNbcflX+Dk6HEMvl9pJMHZrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=aWiE6dzV; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82318702afbso1397209b3a.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 16:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1769732614; x=1770337414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CYTSAYfgo6LKzK29EiEZAvRbOdiFgqzpufodvAYyN7c=;
        b=aWiE6dzVYgyLdm2dATGrh3CuKH3Dt4ukbf70oT5h1MquA2ArAGXRRU5X1p6Qfjtcou
         mP4lhQzvDLJ/52jEwOEr8QVbJ0XXgQ7mlIectLwNVBxGt5hiYIu1ITVsMcqICy5dxrlk
         ZxsdaWzYYvZqBfmmVt4FlRTSz68+8bMMsOUhRyaOubqXXmrq5j8rNYOjTmbOyCxfgq87
         m0xnc031GZFXuBWdD98gyYR5gS+2W9zJl+VBonaO6jR23MmDD+bKTl8G81fFuOzKeOqx
         iRaOQ35j6DWKMWvL2tjiKXn1qdRloqOwLYiD6LdU0Gak5FZhHkN366wpqmHbsMRuX4Km
         y4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769732614; x=1770337414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYTSAYfgo6LKzK29EiEZAvRbOdiFgqzpufodvAYyN7c=;
        b=eBuZqTVroZRQmL0l1F/yKBE7alnJYnVUOb2ilu7wqZxPMZgS5JHMsakTkLLukO4RD8
         /i4VsnsziEWYCkLuFDQiwSR2tHLVWC1oHTxs4vaE6BRGv0U5bTI78xGdRCUb/hiV4sTX
         f0pAn2CGv2dDGXAbceaVkL9+wGQ4jGn7J1BZ7oFbFzyZ9U2I2ulTFlijm15c7Bl0aSaD
         hL3vlf6BQOyw6HrMOdUAQ9danDmAJhv+2JTB41Bl2rqoP6+ocmPWoLQrB1TMjOj+fIsb
         Jq6DAhovolAuPZIzIbqdOZKZ1FbqUAVBoNBt+rJvUeX3vRllkY2EAQZvfvweE7N5mctO
         OdRw==
X-Gm-Message-State: AOJu0Yx/8iL/RZM2tYAS7ZL8uBRRiAfL7JwhUhobP1Coui608bvNZ8PU
	c5PR+9DePNaLhisZr1Vc2miGsTzoOebOTKRct+ZOHsyzsk8h5PPHELw1EMO+LHXh1kJrBSk/0hQ
	9r5wA
X-Gm-Gg: AZuq6aLA4ecwM+ZKCTituE/VFZA7V4EHobHCKKaed5d9IRSLZtsZ145U1R8l69XIOB3
	p4/FhFShTlBAVUJvJbpFjWjqrjab8sTsO2CkZNgrgC0qzBuET/TSmb8k5jdE+3ojv6TpQciBt9b
	M6Ayd+rgOfim7/3YANyEGmWHKb2ZAuZnpCqRypaafve+A/1ubOs8Fbm2YZ27CWuxgO0XBXZN5PB
	kPVk/hcG70zBbq4qkXWTOl+UErFFRpRolFiVW1bS3+41PYX0qe0+swSB4l0YqE/UoJ6BgJWNen3
	5EUAN01R1lwzGx0fmlcrWYvuvmErEw5+s8KcK4ibzk+aVnCxpVv6MtXGzXYzD66N6VCROHGVLCS
	LTwBzBP/W2vHdo4tZtGAwD0tlvlorcUstOuaQ501PQ+sMFuUWa/cB3t9R0DvHP/G7yVg=
X-Received: by 2002:a05:6a00:13a2:b0:81f:41cb:c7de with SMTP id d2e1a72fcca58-823ab64017fmr990174b3a.14.1769732613888;
        Thu, 29 Jan 2026 16:23:33 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c22672sm6406716b3a.51.2026.01.29.16.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 16:23:33 -0800 (PST)
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
Subject: [PATCH net-next v2] bnxt_en: Allow ntuple filters for drops
Date: Thu, 29 Jan 2026 16:23:22 -0800
Message-ID: <20260130002323.2561266-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254954-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 7DD19B5E19
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
v2:
  - Extract the FLOW_MAC_EXT and FLOW_EXT check so it happens unconditionally. 
  - Eliminate the local variable ring, which was used in only one place and
    call ethtool_get_flow_spec_ring instead.

v1: https://lore.kernel.org/netdev/20260128222718.1679581-1-joe@dama.to/

 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 6b15fedbb16f..eebe78628cbb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1346,18 +1346,22 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
 	struct bnxt_l2_filter *l2_fltr;
 	struct bnxt_flow_masks *fmasks;
 	struct flow_keys *fkeys;
-	u32 idx, ring;
+	u32 idx;
 	int rc;
 	u8 vf;
 
 	if (!bp->vnic_info)
 		return -EAGAIN;
 
-	vf = ethtool_get_flow_spec_ring_vf(fs->ring_cookie);
-	ring = ethtool_get_flow_spec_ring(fs->ring_cookie);
-	if ((fs->flow_type & (FLOW_MAC_EXT | FLOW_EXT)) || vf)
+	if (fs->flow_type & (FLOW_MAC_EXT | FLOW_EXT))
 		return -EOPNOTSUPP;
 
+	if (fs->ring_cookie != RX_CLS_FLOW_DISC) {
+		vf = ethtool_get_flow_spec_ring_vf(fs->ring_cookie);
+		if (vf)
+			return -EOPNOTSUPP;
+	}
+
 	if (flow_type == IP_USER_FLOW) {
 		if (!bnxt_verify_ntuple_ip4_flow(&fs->h_u.usr_ip4_spec,
 						 &fs->m_u.usr_ip4_spec))
@@ -1481,7 +1485,7 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
 	if (fs->ring_cookie == RX_CLS_FLOW_DISC)
 		new_fltr->base.flags |= BNXT_ACT_DROP;
 	else
-		new_fltr->base.rxq = ring;
+		new_fltr->base.rxq = ethtool_get_flow_spec_ring(fs->ring_cookie);
 	__set_bit(BNXT_FLTR_VALID, &new_fltr->base.state);
 	rc = bnxt_insert_ntp_filter(bp, new_fltr, idx);
 	if (!rc) {

base-commit: 239f09e258b906deced5c2a7c1ac8aed301b558b
-- 
2.47.3


