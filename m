Return-Path: <netdev+bounces-115952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A28A9488FF
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 07:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85EA51C224C0
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 05:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB847FBA1;
	Tue,  6 Aug 2024 05:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J+P0Faxz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982BC4A0F
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 05:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722922713; cv=none; b=p4S7oTkXDCZ+8zSt+E9v+6ofUHyDV23q9YHXMXaH26upJSC8tJhp2gHuHf3EqnTs2uCYz/5Wzlmm/Z5Dvc9YNYWzRtGDvY12NXH6yq1KdWBv6buvlblaLXSwe2axLXU5RrTDnULj9ysWHrJM8PvTbE5DuV1RiWDefDHzZlFEEFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722922713; c=relaxed/simple;
	bh=nv9KmsZ1yKU59hIdldPaKreBpJTwI7hWtY6x8d3DVb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jhf9O+Vz8Idjvg+WiSlh+QfZd1IGnPN4HdRqb+wtSIpAsqrwD8RfvRocNALbziNtCBNq0j+oyQQA9Y7tCkbDXlSAjxNpbYIf+0c3H64ffmxwdHzgsooQisItdGayspN6HDwcfUuw1LTNZtEbN5sHSvZSDvzOR3RcG8tjufapFSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=J+P0Faxz; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a1d024f775so13515685a.2
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 22:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722922710; x=1723527510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6VphDARfeA6NyT++3QeBbABzQSFLqFyae07zknicPFA=;
        b=J+P0FaxzOe3tbLCk+ndmTZSsxPGNuQtdn76TvevfXbe2uEbRVCnZSDx2xBgxHHKecp
         EequTn1iAkMIcqRNkkfmveXVO5FGPVA4ajlKNv1Q+AjMfiVwwXZ87wNJTJSDZ5B/9n+H
         1Ff8ALHtV9gtOX1UwGyvdFK9dVUXrUJqSVETA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722922710; x=1723527510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VphDARfeA6NyT++3QeBbABzQSFLqFyae07zknicPFA=;
        b=miO/P8Y/i2wLnDKP1OBPz+K+GvFbLDT4FbfhRmlNXJ40KRrFcgqw5aofMEc/MiWhaf
         gTPOaOK2xcezwzlgIV4O563JmWp07p1ZlVZExbmKsLv1oyww7I9yFYTicTaZMIz7eCEa
         Y5RWgUlke3fU48LiZheohCRMX8+QZpUFtwUupbJqR3GFvRi0Y7UwzzhJaBDsB8WrFwq5
         ZCWNgeYSAs2Py+mwx4yKhZJJSJfisPS2kCMmE5+sfRW+VEm76IOMZ/4kLeWIE9LLiPCh
         0kvfO5QObejAVfKp3fcmWvv9qKOTw1l/bJ4wMmwPNvC9VofWe/QXFsowBe6ri4ZGjkHd
         UIyA==
X-Gm-Message-State: AOJu0YwpyHUx4ra/t9r8DDkYzW/IdPQV0L3yMPFzOhlfL1p9wUtk9LFS
	G4h8X2X+rWTf7Yy0PlDpEtsmB4CLs2+pzv8kBU2zezYkRW+kRcfBraz/xH5r0g==
X-Google-Smtp-Source: AGHT+IFrKjPKWX15umVbVJTX42ukwRDdJd4jJGl3TZ0pgJ9DXAxx+mReYsudD4SwbjBBGZmWAhXqxg==
X-Received: by 2002:a05:620a:4548:b0:79d:79cb:2a68 with SMTP id af79cd13be357-7a34efc81d3mr1844773285a.57.1722922709625;
        Mon, 05 Aug 2024 22:38:29 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6d800dsm417857785a.8.2024.08.05.22.38.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2024 22:38:29 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	leitao@debian.org,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net] bnxt_en : Fix memory out-of-bounds in bnxt_fill_hw_rss_tbl()
Date: Mon,  5 Aug 2024 22:37:42 -0700
Message-ID: <20240806053742.140304-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent commit has modified the code in __bnxt_reserve_rings() to
set the default RSS indirection table to default only when the number
of RX rings is changing.  While this works for newer firmware that
requires RX ring reservations, it causes the regression on older
firmware not requiring RX ring resrvations (BNXT_NEW_RM() returns
false).

With older firmware, RX ring reservations are not required and so
hw_resc->resv_rx_rings is not always set to the proper value.  The
comparison:

if (old_rx_rings != bp->hw_resc.resv_rx_rings)

in __bnxt_reserve_rings() may be false even when the RX rings are
changing.  This will cause __bnxt_reserve_rings() to skip setting
the default RSS indirection table to default to match the current
number of RX rings.  This may later cause bnxt_fill_hw_rss_tbl() to
use an out-of-range index.

We already have bnxt_check_rss_tbl_no_rmgr() to handle exactly this
scenario.  We just need to move it up in bnxt_need_reserve_rings()
to be called unconditionally when using older firmware.  Without the
fix, if the TX rings are changing, we'll skip the
bnxt_check_rss_tbl_no_rmgr() call and __bnxt_reserve_rings() may also
skip the bnxt_set_dflt_rss_indir_tbl() call for the reason explained
in the last paragraph.  Without setting the default RSS indirection
table to default, it causes the regression:

BUG: KASAN: slab-out-of-bounds in __bnxt_hwrm_vnic_set_rss+0xb79/0xe40
Read of size 2 at addr ffff8881c5809618 by task ethtool/31525
Call Trace:
__bnxt_hwrm_vnic_set_rss+0xb79/0xe40
 bnxt_hwrm_vnic_rss_cfg_p5+0xf7/0x460
 __bnxt_setup_vnic_p5+0x12e/0x270
 __bnxt_open_nic+0x2262/0x2f30
 bnxt_open_nic+0x5d/0xf0
 ethnl_set_channels+0x5d4/0xb30
 ethnl_default_set_doit+0x2f1/0x620

Reported-by: Breno Leitao <leitao@debian.org>
Closes: https://lore.kernel.org/netdev/ZrC6jpghA3PWVWSB@gmail.com/
Fixes: 98ba1d931f61 ("bnxt_en: Fix RSS logic in __bnxt_reserve_rings()")
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 23f74c6c88b9..e27e1082ee33 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7591,19 +7591,20 @@ static bool bnxt_need_reserve_rings(struct bnxt *bp)
 	int rx = bp->rx_nr_rings, stat;
 	int vnic, grp = rx;
 
-	if (hw_resc->resv_tx_rings != bp->tx_nr_rings &&
-	    bp->hwrm_spec_code >= 0x10601)
-		return true;
-
 	/* Old firmware does not need RX ring reservations but we still
 	 * need to setup a default RSS map when needed.  With new firmware
 	 * we go through RX ring reservations first and then set up the
 	 * RSS map for the successfully reserved RX rings when needed.
 	 */
-	if (!BNXT_NEW_RM(bp)) {
+	if (!BNXT_NEW_RM(bp))
 		bnxt_check_rss_tbl_no_rmgr(bp);
+
+	if (hw_resc->resv_tx_rings != bp->tx_nr_rings &&
+	    bp->hwrm_spec_code >= 0x10601)
+		return true;
+
+	if (!BNXT_NEW_RM(bp))
 		return false;
-	}
 
 	vnic = bnxt_get_total_vnics(bp, rx);
 
-- 
2.30.1


