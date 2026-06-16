Return-Path: <netdev+bounces-299804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KJsWIXEqMWo9dAUAu9opvQ
	(envelope-from <netdev+bounces-299804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:50:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D600868E79E
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:50:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b=Rbw2tc4D;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299804-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299804-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=canonical.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3763B305246A
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 10:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66633DA5C3;
	Tue, 16 Jun 2026 10:45:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DF33B71B0
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 10:45:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781606742; cv=none; b=JqJkNDyshxKkYypqmKD6fIoDBZpFUysv7/wx05zBQ/9Wa3jlDbEtI1twr6DxlMKwaAqPQLmflCKhRd31csmwSvlPNpBLxOCYR58+R3jRYN3Ju9R+t02w5fdZ78Imz3ufcMYy/2qcu0vM8sVKqzJ1wyGHHUkxUK7DPJ2pDRxoIZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781606742; c=relaxed/simple;
	bh=/d1vWxDeThWy8hZbscFynHtU5LIPHyGKCGr/ORJnJbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mz9DA4XrGD38HKZYdnP5u0HX8fabbg3PKIEJUZjFoThAVawa/LX3FWQgbPlyQ/esuNH+Cu6ZUic0lU9rZwgI3j2WLTOt61ZSk03q99VWngzamDC40yEZbH+uwFNYUgtBm0OM4SkJcBFBd4YPUoUMfgrSsRZmgVvkFCbEYoAQ7ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Rbw2tc4D; arc=none smtp.client-ip=185.125.188.122
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C1C1E3F2D2
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 10:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781606731;
	bh=ZMRFP/cIVcQkBD7AO9h8BoH0UYB8ekkkeuemaA4KQl0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=Rbw2tc4DIlXsF9zn2gwPFYzTtd/7SGn12gLirtZrJL5ihJ61tFxZmRbVmTH4KkGyy
	 KUDM9XF1azoKaXhTinJyX1o9sk28BOzhHTKk5UEs6cSvSITXN5dN547t0Shb9f5YJh
	 o5AvXLeD/fa7LmDtzO8jbvQ65Wdp+ytINv8sm6q0WE+S1izugLq2oBfcAFgiY/WjcX
	 X9Ch+4i5I8lVn6EdyZDxVMDfm7kPYSpRPugn214SmJNoAm/9VhsB7qWG345MLBM5Ld
	 NsN/VLbAmhlW2EQV2LW0/PnHUzEQighPmFzuk1iyacFVCliX1VQqqtezZ2RzdbH6LN
	 arb5YKkivGg5GSQmoQPjh5HXYEIUuLcrKD8Ydg/keUBosUQRT9ir5cXdlmgiHc7Z+A
	 HAR4tcmvKHExEzWODmiJJM3MZjrYFcJrB/Cja5g831iUOE4ndtbau/pkT+TSdMbFgL
	 erRV/oFizzFhuFMM5kE4UnCIajAFaeINzqbNETWQqqB9EjzHxA5891a9UHoph5Zyz/
	 Nczv9Tbx3vt0tcryZbRdTmexRnxvuHnl0CFlbGSZAJtmYLKrhBQ4nt5wAauvt5AUBW
	 mRYWqVNR3mtJOBz92C3u89ASwOz2kJb0Mm1qQLRjZkcd+PnZfjvmQV7f2pdD26n7wE
	 BXinWt7LAkUnobYmBR7T0YMA=
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490ab3f6e55so25531545e9.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 03:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781606731; x=1782211531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMRFP/cIVcQkBD7AO9h8BoH0UYB8ekkkeuemaA4KQl0=;
        b=aBTEdlg2xLtCiERlQJbcZGSp3uCTVwnLvXWY8YoIvU+wYI96l890+JJI1q0fyDPQM+
         pzgFu4S44uBN9yfmxsFToZVObfBjhdK91JVfk2DxIXG9z5ZBDE7ORNn4kbGW0Koz1GwS
         vHNWxAWwRabuxNypiYtC4jWiEE6x19YjFQLrza0XuBubXsHUou0zH9dkUMyLHHjypinT
         2o6zUbitda/FeNx1DeuTRFpAY4XiYL1f6bgeovOiEYmeD+6jmVK8QFHzDm9LhIVvWO7I
         n366v2bPg+/K43B0fXHIWANvhGBQpyZmdk20RLNzz1f3aEE506BKAxl/sOlEesPIx1Kz
         nq0A==
X-Forwarded-Encrypted: i=1; AFNElJ/J3m7S/FVtVFaXOgeHuwXtE02bJgBu4yLnHz1wifrSiQt2rDKKOS3r9FXcNe4LH1hMnH5SaGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiTME1JcFQBSbYJo4sLYUkcr6A+UG0jDwOXT57HW1zOHQuMuGV
	+Bchyk6cxaPEEq2dqs+Eu3tebJqELcT+AaV4xBClrD/oKe9rI5VnY9qpNHzMcNjb6pR5jC1RFOD
	U09XPNuj6iWrafUMM677hfM8zU9k2O3HS94TTxWS8uGCSMw4j2q63eCs3DKRsSMo2rkCorDg2pQ
	==
X-Gm-Gg: Acq92OFuaIKrrTpeyBWsqeQczBLOOkuupyAPVWcdRBmf1HvPkkgzM1mXm8d/zupph/0
	/wTUAjKFB+Xko12M9dRA/ZJ+JZjwXV05Ud/iC6MGZ9hbLKdPC2tUAmPaSSDVuTbE9Xy2IJXsfTq
	3BuA5gAR06LGewZdzz6RblJ2bdNjrYiSjcDLZHKB95tAX9CeB0FFUDGIKqv3w/xl1g+QgVMM8hi
	Hst7HpsulxYUOruUU167ektFz3GJmooyvl5t2Di4bPI2HnH17DyGoHheQhZh9JUSTYln/v3TAat
	jFOH4JXGrBR/DRSWGOuaMKe+c3q5CoWMzr5bNrVhDJXiXRjjWezbQsgKJtWcyrmqEzTcbbcKbDR
	OqtsxUwTXFgxKvCASBD5e3nJigoH5OTjOzuwNsgc386gpI9qlnobIdNXNJIp1eaU023o=
X-Received: by 2002:a05:600c:b43:b0:490:3d62:f5df with SMTP id 5b1f17b1804b1-4922ff9b6c4mr37502695e9.30.1781606731101;
        Tue, 16 Jun 2026 03:45:31 -0700 (PDT)
X-Received: by 2002:a05:600c:b43:b0:490:3d62:f5df with SMTP id 5b1f17b1804b1-4922ff9b6c4mr37502225e9.30.1781606730460;
        Tue, 16 Jun 2026 03:45:30 -0700 (PDT)
Received: from localhost.localdomain (77-236-28-43.static.play.pl. [77.236.28.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa47da9sm82502645e9.5.2026.06.16.03.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:45:30 -0700 (PDT)
From: Robert Malz <robert.malz@canonical.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: [PATCH] ice: retry reading NVM if admin queue returns EBUSY
Date: Tue, 16 Jun 2026 12:45:21 +0200
Message-Id: <20260616104521.1545053-1-robert.malz@canonical.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299804-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,canonical.com:dkim,canonical.com:email,canonical.com:mid,canonical.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D600868E79E

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
 drivers/net/ethernet/intel/ice/ice_nvm.c | 25 +++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index 7e187a804dfa..cbe21ef9d18e 100644
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
+			if (hw->adminq.sq_last_status != ICE_AQ_RC_EBUSY ||
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


