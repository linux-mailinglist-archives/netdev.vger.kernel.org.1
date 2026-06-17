Return-Path: <netdev+bounces-300159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zLoxN5mOMmpF2AUAu9opvQ
	(envelope-from <netdev+bounces-300159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:10:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6EE699898
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:10:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b=PwlHF2Wg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300159-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300159-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=canonical.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F727301AD97
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9553AA4F1;
	Wed, 17 Jun 2026 12:08:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901E13B6BE3
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 12:08:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781698083; cv=none; b=qvXmektSW9dxTgquVKxzj4S+S+wCgqdgOs+ZlxHbpfDYBPNRhD/mMx6ckhKvz8EpTFJeQRoC2K2w3kEEfzZzwG6zB1x5Khw9welONDHGHgpYIGcnNL5cFcjHmAlyXrYOkwVEC3n6PnArt2MMZmUv8qqjT65KR92niJRgLqy1fFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781698083; c=relaxed/simple;
	bh=QHZ9OsDnSwQfl0sgYLMV3tonKZSrpQcWcCNfhi9YTF8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gz6kqX5surhAlTJs6E22jMdTpIbglxkUmvGdUpqxtnQh5RhCJNHkm0WokoZuV/53/ImqdBrglKPql3g+cOxeXqKJUZwYw0Gi2igtb2UNrlUMk6SVu5lRKYJF2MEpanfKjs9vhRDFfmImqwncg+ZB3owPKlkBRzc2wtQubP6Fls8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=PwlHF2Wg; arc=none smtp.client-ip=185.125.188.123
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B737E3F620
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 12:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781698078;
	bh=fc+WT2fkJNdUER4e5OAjVf1P3kXeLF/bOCJ1S03o4x4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=PwlHF2WgY7CEKYFYNhHJ62Qn4ealD7Y8IFPM+JPRYBwC2Oc/gv19LRsoR9wHrjyMW
	 P0BGFRwg7biupuM+Hpm+ZDDRfxHq1pl59H/o8+ze4GoXGvfuirW+i5cl1+hidAT19m
	 ihQLW+HmmxLOf1mlQk66ux6FoJ6ghOCky88cchzqCAYsr4dCl7BeLrcsQkCBhgrLCr
	 vUfWy2vZPoLOdmtsxbrVOQlX6Hj+Ysx6tonNKIMgqfB5dtPgiQO5nZdXh86/F+gUZu
	 m7jsa5PhFpLl7khc9rwUZagfLJziZiTMlBTtVaubEfd4kC5HJZPXv2R9iLIF5byHa0
	 b0URQOP4lVOgBsCsGyEuxi+b2cRLruu8GAH80Ze2c4uIpybZ+R6sEWY9t6uVrIH8fn
	 3dPRmp25DaiG98PC3BewKKEH3vN4kVpbOnjY0ZCzLKuav7W/u27krb5zaT+3kFgt7s
	 Q7xXLvWkYje9IzLAJ3zgvC2jWXEhixnQf+FhlmLS2/hrTns8EX707Ow6HrsivPD/09
	 i6dO9/E3ozjjQv/2LnsoytO66YA0bI/IZcAucGKOGPWdujNuY1/IfcPvHaWg4G8b6+
	 lpbWbXn+CS0NifYjrgAf04JFtBgfO2I9ssa4DRHsTAQbQq+8jnHNm987SySdZt9dmx
	 CXoF4+C996TCrWwxCPQm67V4=
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490b8adf8b8so52965375e9.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 05:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781698078; x=1782302878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fc+WT2fkJNdUER4e5OAjVf1P3kXeLF/bOCJ1S03o4x4=;
        b=UHyf7ps+qiSLJrByNknmfrkWKiud7X2ptOtM/c0wv+0lCiC+Vg+tNorkcjejMOx+/C
         VG+NPkqUeeBoGh3WYLjQCU4GGU8Vu0voXdmy+oBBbNfPwJjsEHa88xUuq95pc5UhtPIC
         V/hJFwwEj/IOMm0Ztls0Bk0Fpxfb06SvWarMsf38oEy+eno8TiH+xxRVWpgpr9kMOsNA
         f2/J29mBQGFtccQSk137p4xN8toLG/ZW+jwc5yxmsjB29Vf5Ut0kTtsaa2OYA4KWC8Pj
         83p1Cp4RXVdCjZmekCg4fEwJVYcDKRjnxHkWugKnAElO2sFdhmY9deIxS2sUUG50b8YX
         WiSg==
X-Forwarded-Encrypted: i=1; AFNElJ+X0z8z5aT/MKeKd74qDCM85NYtk5Gybu7pecPU032iDHFRBAdk+xOKfRFFR9RdBkX263pPqbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeP55688q4NzgM9yfR05ZR25TuTXN+9clHLwCnRoRQECi9gh89
	XvIgq+WMF8kNNFo/y1k85TGe+9JrcOvboWjPr/rhhh5yOXWgkSQ/h08N5cx6QcE3ftYVR3O4Rvg
	kjaFrtRQ2nbMM0FSPEhslXdfk2d0X+TGyl72C1aR7B0c8lfV8mF//waowYa3vZbenVEOkOjwfZ1
	xN+iqW4g==
X-Gm-Gg: Acq92OEipPHg/yr6Uu0bBbcBo9BhKHtxjp4FpH8H3fU3zoi1NSvy5vZB0yoo6LHmj+r
	L9MZNwFm0IIkNBuaJ9NpFMaGjWRZcrnCCL+KuWbI1tN0YBlCwG6ymHsS0Mqsw1qPE2xGVLHHzKe
	0U1WNu38vKurHuDThmGgOOO3NxcP8CcoFJIa94C4BEj38UripkPsrVk9lndR4HJcLN+1WRymdST
	8xZk/pVz47aOLqrTzjKwq5f8pnQsZX5mfXF4omWUoUwlF3rYhv5+W0prbKGYjSthX+kjc4aYhfE
	jK1S2GjBdq/WNVS+e7bSI4jd29jRU/zKwJn8Wngr2qJmRsa6zz+hs5xoWSxvhM75+AX+8gmLDK5
	WQX2B0A/NIXVKbmEeSzjH///2D1VP7YrZk775JV2EDQ3orKBTFsbtlcVD
X-Received: by 2002:a05:600c:e547:10b0:492:2ffd:8f8 with SMTP id 5b1f17b1804b1-492333acb7emr47358865e9.15.1781698078146;
        Wed, 17 Jun 2026 05:07:58 -0700 (PDT)
X-Received: by 2002:a05:600c:e547:10b0:492:2ffd:8f8 with SMTP id 5b1f17b1804b1-492333acb7emr47358405e9.15.1781698077696;
        Wed, 17 Jun 2026 05:07:57 -0700 (PDT)
Received: from localhost.localdomain (77-236-28-43.static.play.pl. [77.236.28.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a4601esm167617515e9.1.2026.06.17.05.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 05:07:57 -0700 (PDT)
From: Robert Malz <robert.malz@canonical.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: [PATCH iwl v3] ice: retry reading NVM if admin queue returns EBUSY
Date: Wed, 17 Jun 2026 14:07:53 +0200
Message-Id: <20260617120753.1785565-1-robert.malz@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300159-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[robert.malz@canonical.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robert.malz@canonical.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[canonical.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:email,canonical.com:mid,canonical.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE6EE699898

When the admin queue command to read NVM returns EBUSY, the driver
currently treats it as a fatal error and aborts the entire read
operation. This can cause spurious NVM read failures during periods of
high firmware activity.

Add retry logic to ice_read_flat_nvm() that handles EBUSY responses
from the admin queue. When an EBUSY error is encountered, release the
NVM resource lock, wait for ICE_SQ_SEND_DELAY_TIME_MS, re-acquire it,
and retry the failed read. The retry is attempted up to
ICE_SQ_SEND_MAX_EXECUTE times before giving up.

Code was extracted from OOT ice driver 1.15.4 release. Additional
change was made to reset last_cmd in case of retry to make sure that
all commands are retried properly.

Fixes: e94509906d6b ("ice: create function to read a section of the NVM and Shadow RAM")
Signed-off-by: Robert Malz <robert.malz@canonical.com>
---
Changes in v2:
- change ICE_AQ_RC_EBUSY -> LIBIE_AQ_RC_EBUSY
Changes in v3:
- resending to comply with the netdev 24-hour rule. No code changes since v2.

 drivers/net/ethernet/intel/ice/ice_nvm.c | 25 +++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index 7e187a804dfa..b3120605d66f 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -67,6 +67,7 @@ ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u32 *length, u8 *data,
 {
 	u32 inlen = *length;
 	u32 bytes_read = 0;
+	int retry_cnt = 0;
 	bool last_cmd;
 	int status;
 
@@ -96,11 +97,25 @@ ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u32 *length, u8 *data,
 					 offset, read_size,
 					 data + bytes_read, last_cmd,
 					 read_shadow_ram, NULL);
-		if (status)
-			break;
-
-		bytes_read += read_size;
-		offset += read_size;
+		if (status) {
+			if (hw->adminq.sq_last_status != LIBIE_AQ_RC_EBUSY ||
+			    retry_cnt > ICE_SQ_SEND_MAX_EXECUTE)
+				break;
+			ice_debug(hw, ICE_DBG_NVM,
+				  "NVM read EBUSY error, retry %d\n",
+				  retry_cnt + 1);
+			last_cmd = false;
+			ice_release_nvm(hw);
+			msleep(ICE_SQ_SEND_DELAY_TIME_MS);
+			status = ice_acquire_nvm(hw, ICE_RES_READ);
+			if (status)
+				break;
+			retry_cnt++;
+		} else {
+			bytes_read += read_size;
+			offset += read_size;
+			retry_cnt = 0;
+		}
 	} while (!last_cmd);
 
 	*length = bytes_read;
-- 
2.34.1


