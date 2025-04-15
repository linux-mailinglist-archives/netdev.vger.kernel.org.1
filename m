Return-Path: <netdev+bounces-182935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4215AA8A601
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D953F3A74F7
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 17:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DA02222C6;
	Tue, 15 Apr 2025 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YWDQbDgN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C36B1F3FDC
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744739340; cv=none; b=ppCKfiaIEiUNMjpEfeSwGxnrGISkBE96E7fTDDWxsFq0bzkO4Bdc0QLFw9XGGbH/NDHgfGAW7hvS2aVerAvBVUvgIMXL0bVT24MgEx7odc+aCyAtSsy+LhiCQMmvGOPDa7PgmalGlH4Pzmkgj7oKBna5eHrEu3Ber28agAhgIuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744739340; c=relaxed/simple;
	bh=P4grIgMcFBx6uX0VhGtxuvQCENvc2Rsj2FroJKBMbDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9idrMeG/g6QCDh5Oj5x5dcSTpFYNNG8BGlyMfqm2licVl0wB/pNDdqx/Dj2bMM5/I6ii+e+CLuz6M4FEdnzI3L4/FGv+RtD0D67LdP/zD003mDHlN4QD67QXdScm6J4IfiR1FC0GRsYFxdS3ObZgkNwip02HqgblRdpnn+SiNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YWDQbDgN; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-603ff8e915aso1664907eaf.3
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 10:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744739338; x=1745344138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgSwWLJCnsmrTM6Kf/YHkuzpzYvCE+MfEaXp8mEkXW0=;
        b=YWDQbDgNNrhR3uQCV7eu3nacB158z+UNmdP3szVzk0GMfrJbznsdw67RVNOp8ZuSng
         Pklt0AT8P+K7Jo0AsoH4RtfFWW5/TtN0Dljwz8qFWYi9LrrzAPUmdRMNxmRVQB1PySzx
         WijHqZz5X/XfY50Nk6RUcCPbresSWIhjkrhGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744739338; x=1745344138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgSwWLJCnsmrTM6Kf/YHkuzpzYvCE+MfEaXp8mEkXW0=;
        b=pR3VN4Ok1yZUTyc4HF8Sb3Qf1qQ3EQSNHfPkeelUgYUkqdTYLfHoYczHpPUVaLVTBw
         bCDoBXybNyJL+8WJyz25vunxj7oZzttPB66AZELrY9S75Gm5Dw0jGxOJoLPZMm4Cxj4Z
         dyuS1oX/RLhOC1Vv6oNGB4d7dyxMbzkWgHhHApYK6VSLTMp+55IExhr79GEXje0rWMOb
         ADwJ2RuGfdoNG4z2U1v63xdrbwPnuh8oZc9tM33pmBWRWVWRV8lb7kw4YmAX6TNeok3+
         PstvuPYe5fTglPplh96RnIrhfrAxOeNoos3Y9xMRRroe4QnKKDZwz7kP5BAlczr6cemQ
         RvpQ==
X-Gm-Message-State: AOJu0YxSCgaNTZIvaW02JlNqp6nSbaw79ln+cf+21q2A5ENUURWRb1nj
	SpEB7tz2q2c/N5EdBxcjDgUG/2vMqaw387UMF01QEa/KsaJNjoKk449/kKCBq+T6oTvEJSMydo4
	=
X-Gm-Gg: ASbGncsZI74yzTswVE7ZyQPyR0qRU8m11WllHa4a4oty8R14JohhOzmM3/AQDQe6cz3
	BopbifAH2LBDhLdcMUcGjBuMXefORPvZtTmk9Mu+dFZUxXotOY+DqshFktmXhVDKHyxo1PWN1H9
	Fh9AaDcCMcOr5IrvV19C0W9QkUPIRAd/iF12NB0cTDKOVjVjzMarbSPK1G/ept5m2mvijY34D/A
	fc7gm8+6VKj3f9UIXdrqcUXwwrsJbbV945YGUhZWhT+NQq9Jg6o069Z5DZGNguMHkZwv1U3Ar07
	n8Zyh03+Ini56HNX7qQQq5JOYrhKfmTH8jIqUAcnM2BN0eqhq/qcnX4y+Rlmr2CnojWPsYpFq38
	ROqorQJhpFunHVCJz
X-Google-Smtp-Source: AGHT+IFXklvxW0G5/85K69JyhI5pYnciRqWEUyJ/OgBrcHD3g2epaGat13qd2dU3ptOg0IpSpbYEwg==
X-Received: by 2002:a05:6820:2087:b0:601:d595:3b1f with SMTP id 006d021491bc7-6046f590ac6mr9698025eaf.6.1744739338086;
        Tue, 15 Apr 2025 10:48:58 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6045f50ee87sm2457073eaf.7.2025.04.15.10.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 10:48:57 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Shruti Parab <shruti.parab@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH net-next 2/4] bnxt_en: Report the ethtool coredump length after copying the coredump
Date: Tue, 15 Apr 2025 10:48:16 -0700
Message-ID: <20250415174818.1088646-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250415174818.1088646-1-michael.chan@broadcom.com>
References: <20250415174818.1088646-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shruti Parab <shruti.parab@broadcom.com>

ethtool first calls .get_dump_flags() to get the dump length.  For
coredump, the driver calls the FW to get the coredump length (L1).  The
min. of L1 and the user specified length is then passed to
.get_dump_data() (L2) to get the coredump.  The actual coredump length
retrieved by the FW (L3) during .get_dump_data() may be smaller than L1.
This length discrepancy will trigger a WARN_ON() in
ethtool_get_dump_data().

ethtool has already vzalloc'ed a buffer with size L1.  Just report
the coredump length as L2 even though the actual coredump length L3
may be smaller.  The extra zero padding does not matter.  This will
prevent the warning that may alarm the user.

For correctness, only do the final length update if there is no error.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Signed-off-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
index 5576e7cf8463..9b6489e417fc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
@@ -496,9 +496,16 @@ static int __bnxt_get_coredump(struct bnxt *bp, u16 dump_type, void *buf,
 					  start_utc, coredump.total_segs + 1,
 					  rc);
 	kfree(coredump.data);
-	*dump_len += sizeof(struct bnxt_coredump_record);
-	if (rc == -ENOBUFS)
+	if (!rc) {
+		*dump_len += sizeof(struct bnxt_coredump_record);
+		/* The actual coredump length can be smaller than the FW
+		 * reported length earlier.  Use the ethtool provided length.
+		 */
+		if (buf_len)
+			*dump_len = buf_len;
+	} else if (rc == -ENOBUFS) {
 		netdev_err(bp->dev, "Firmware returned large coredump buffer\n");
+	}
 	return rc;
 }
 
-- 
2.30.1


