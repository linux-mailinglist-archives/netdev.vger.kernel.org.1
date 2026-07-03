Return-Path: <netdev+bounces-304486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hmoIEyCUR2ocbgAAu9opvQ
	(envelope-from <netdev+bounces-304486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:51:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E16701708
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:51:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b=Adr3wxXs;
	dmarc=pass (policy=reject) header.from=canonical.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304486-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304486-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF6CC31CF9D8
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 10:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6739C3E5578;
	Fri,  3 Jul 2026 10:33:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74DD3E316D
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 10:33:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783074828; cv=none; b=g9ns+uJSyHqyjqEdTnYFxkJmjDc4p3POZprGjxEeEe/jbDxt5iR5zXsKjnO2I4e/o0INNDkCWI/qUz6Q0Qw+kUm/nBtYlVMNDP/rdzOtcQOMIFLhN0sderqxC04kEcWRSUeDVAzEgC5rx3lADq9QZYxqtZRPVxaH21sulSj0pcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783074828; c=relaxed/simple;
	bh=5walwYgdz+FXyJFC5ZFyjYw3FJMGXz4pT6iGuhHKpyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VH3wEgDicSV2cH2aSjHfngdF2Y/zm+V73uauiesuBfnlTVP4c3UR/iM5J63fcQ+uAIRoYOfIOecdyWCWL1WWOuAS2RmzrJtzybwYNeWRVV5ic9r8RofzQujzuymEpdTWYDkc1VM5NnhLO29MVCvo0nL2jkI/kFzUC63oH0Tti7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Adr3wxXs; arc=none smtp.client-ip=185.125.188.122
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 511763F1C0
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 10:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1783074817;
	bh=baVj67qvtniy6b+eW//3NKKeNSe13i7J3dl8qPlTepA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=Adr3wxXsfddLoio5iQhdR47jCXRJeV0zflnES7w9SkqH3r9R+DoJ4YTyYqXQW0bfT
	 RwRDjIRAedd+hPbphkO/ahdLNtIAB1L331LrzHxKnio5QkyYoqdHFVkFPA/ZCqP+QE
	 9MR6RfRmkrVoV9AulesVCvVfeIkazxHll5Q4NOSDaLQ4WHrE+VX+IPpelL/TSSvq8m
	 A//C9ZbK9HM/dZkxUnd68qjzKVhAxxrdrpKkJxuRsptrpHQxsgcpgGwyRZWLDUtesY
	 n58QHYMJjQ2vC96xvoy6GjrZciwevWluSfWhAPQqJHwuQUrsuUuDI5rrs1nq2iYZqV
	 gKVoqam3lHUaQeUSv27IFoumtdQ9OX4cTB5bLvfL7MdPCDyF89tbCZwR76x/yb4DN4
	 hQji+tfLHOKEuW2KgmPIMcW1jVc6JYewWPH3pYtQTfAihuEjCW7m1YtWwECnc31R3V
	 wYGZggyhJNmqIsmMONny6wTTl8vI++X742Aoaaz6UEwpLuD8JIEXPVtNQ2YgH3avW8
	 mfnfqnikUIcrW82ecOMftJGM3vXjKeBOEKAGTFTd4sjYWOa1u7b8uPNyZsCQMadNnF
	 XMyogMWbPVpED2PwhIz8YOpWjQVSFYQEhujyaQpu7nxswMOPSnYU99eN8mkgiW1pvQ
	 +mqhjAvGU4AX2yZ8+0z3t5zU=
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47416fc1674so393395f8f.3
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 03:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783074817; x=1783679617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=baVj67qvtniy6b+eW//3NKKeNSe13i7J3dl8qPlTepA=;
        b=EWJ2CBPvAjf/L18zXvk3b3JE5v9sE+Ax12uGEc4rkgdWcNrcCIaxnH+s1PLS/HXwsl
         QdGiKUXoNUTT4yPyTYBSkYF2RNoO2RdMXhMPvl2ZVnpPSPy3yd60MAwG1ZutFSoSGo24
         kHM5+zh13vuEEHMM+Y1itlIGFerqh/QxyEjLb/5kt9cnB8eC+hPtb3RxH+BUMAzSK/Ni
         4MQVx/OxYQ/2zNd4FRI+d4OfKUK/7QzgqwxE2FzuhpdMGnJXPbSeub9Z4HPqE4CKNQZf
         JYJk/SqnR1Upr92dHkLRr4DmYTpy2BusNak3uZ2ZXh0MgE/xL6njkzALhrCQaXsI4xoi
         cObw==
X-Forwarded-Encrypted: i=1; AHgh+RoTQOa/8MN3QyjjBIHkZAMKH9JaoG1VGE3zdYNsaoCBckA2yRiNQ3AnKKMJpPNctszMpqU1ABo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkVGN8d/xt/l7iywd9NGTPF4rsyVjaR/O9tgMYG8P5mLyfqsd7
	p4EHyAGXtGv58e5tDPjnYZy5HrpmO3iao71SKEvIMUbIi45JC3NNObAIP9xOX8ZisonpVtO4kTS
	PyK/C512F4LUy0a1u9qyHwbg7incasxSCJRhPvotRPijdCSp3IH2XSeE+neD4ceVyFdL8MRVAxA
	==
X-Gm-Gg: AfdE7cl4aBUf5jQGC20Zq8QvnVajlEuhTKZZuNoA4wPTHTisUhHduMubMJqUMnaGs60
	l3gnl/dLi2nzqE1wJla+I7iehzwCpR45uMoxvAGUCqqGa/MnKdZMk4CYcLt/MBuza3Zcx1xw6JN
	asoW9VEa5Ap/+gnwEAcUZ3bYTJu37EWC3Hzrs6ZqZwvGdiUsDUNW1g3NvqAX27jLdWVxSQ4FpPn
	Rj//jSXonC6RW77SXjLlJOFQRNrZHxHxvFMdR+v9Y2kFB6U8cfdqkQMRQzm6IWqQ/8mch/eelQ2
	Lb1V9Z/1ILKaJnu4N8ptlKgxAliT0YqGrhPtq/Fehpsn2Cm+iBy2xRj9rI2YJ88AggNu8Bqk+6E
	Y4xOy3hM/AS9VA3KeUjtwz12tX5o81YPurTBw0WdYgLmnk9DUT6kJUJF7
X-Received: by 2002:a5d:4488:0:b0:461:cd9e:2368 with SMTP id ffacd0b85a97d-477afbcc1cbmr10672794f8f.27.1783074816724;
        Fri, 03 Jul 2026 03:33:36 -0700 (PDT)
X-Received: by 2002:a5d:4488:0:b0:461:cd9e:2368 with SMTP id ffacd0b85a97d-477afbcc1cbmr10672768f8f.27.1783074816185;
        Fri, 03 Jul 2026 03:33:36 -0700 (PDT)
Received: from localhost.localdomain (77-236-28-43.static.play.pl. [77.236.28.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db3dbb79sm16482623f8f.2.2026.07.03.03.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:33:35 -0700 (PDT)
From: Robert Malz <robert.malz@canonical.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jesse Brandeburg <jbrandeb@kernel.org>
Cc: Robert Malz <robert.malz@canonical.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl] ice: acquire NVM lock around each flash read
Date: Fri,  3 Jul 2026 12:32:44 +0200
Message-Id: <20260703103245.374800-1-robert.malz@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[robert.malz@canonical.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-304486-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:aleksander.lobakin@intel.com,m:jacob.e.keller@intel.com,m:jbrandeb@kernel.org,m:robert.malz@canonical.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robert.malz@canonical.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,canonical.com:from_mime,canonical.com:email,canonical.com:mid,canonical.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82E16701708

FW caps the NVM read lock at a maximum of 3000ms regardless of the timeout
requested via ice_acquire_nvm(). ice_read_flat_nvm() splits a read into
multiple ice_aq_read_nvm() commands, one per 4KB sector, all issued under a
single lock taken by the caller. Reading a large region can exceed 3000ms,
so FW reclaims the lock mid-read and the remaining commands might fail.

Move the lock acquire/release into ice_read_flat_nvm() so it brackets each
individual ice_aq_read_nvm() command, ensuring the lock is never held
across more than one FW read. ice_release_nvm() issues its own AQ command
and would overwrite sq_last_status, so the read's AQ error is preserved
across the release for callers such as ice_discover_flash_size() that
inspect it.

Callers that previously took the lock around ice_read_flat_nvm(),
ice_read_sr_word() or ice_read_flash_module() now call them without it.
The per-block locking in ice_devlink_nvm_snapshot() is now redundant
and dropped.

Fixes: e94509906d6b ("ice: create function to read a section of the NVM and Shadow RAM")
Signed-off-by: Robert Malz <robert.malz@canonical.com>
---
 .../net/ethernet/intel/ice/devlink/devlink.c  | 21 -------
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 11 +---
 drivers/net/ethernet/intel/ice/ice_nvm.c      | 58 ++++++++++---------
 3 files changed, 32 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 22b7d8e6bd9e..7c7fe3d2e9d9 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1891,26 +1891,15 @@ static int ice_devlink_nvm_snapshot(struct devlink *devlink,
 	for (i = 0; i < num_blks; i++) {
 		u32 read_sz = min_t(u32, ICE_DEVLINK_READ_BLK_SIZE, left);
 
-		status = ice_acquire_nvm(hw, ICE_RES_READ);
-		if (status) {
-			dev_dbg(dev, "ice_acquire_nvm failed, err %d aq_err %d\n",
-				status, hw->adminq.sq_last_status);
-			NL_SET_ERR_MSG_MOD(extack, "Failed to acquire NVM semaphore");
-			vfree(nvm_data);
-			return -EIO;
-		}
-
 		status = ice_read_flat_nvm(hw, i * ICE_DEVLINK_READ_BLK_SIZE,
 					   &read_sz, tmp, read_shadow_ram);
 		if (status) {
 			dev_dbg(dev, "ice_read_flat_nvm failed after reading %u bytes, err %d aq_err %d\n",
 				read_sz, status, hw->adminq.sq_last_status);
 			NL_SET_ERR_MSG_MOD(extack, "Failed to read NVM contents");
-			ice_release_nvm(hw);
 			vfree(nvm_data);
 			return -EIO;
 		}
-		ice_release_nvm(hw);
 
 		tmp += read_sz;
 		left -= read_sz;
@@ -1966,24 +1955,14 @@ static int ice_devlink_nvm_read(struct devlink *devlink,
 		return -ERANGE;
 	}
 
-	status = ice_acquire_nvm(hw, ICE_RES_READ);
-	if (status) {
-		dev_dbg(dev, "ice_acquire_nvm failed, err %d aq_err %d\n",
-			status, hw->adminq.sq_last_status);
-		NL_SET_ERR_MSG_MOD(extack, "Failed to acquire NVM semaphore");
-		return -EIO;
-	}
-
 	status = ice_read_flat_nvm(hw, (u32)offset, &size, data,
 				   read_shadow_ram);
 	if (status) {
 		dev_dbg(dev, "ice_read_flat_nvm failed after reading %u bytes, err %d aq_err %d\n",
 			size, status, hw->adminq.sq_last_status);
 		NL_SET_ERR_MSG_MOD(extack, "Failed to read NVM contents");
-		ice_release_nvm(hw);
 		return -EIO;
 	}
-	ice_release_nvm(hw);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 49371b065845..ddeca39d822b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -869,24 +869,15 @@ ice_get_eeprom(struct net_device *netdev, struct ethtool_eeprom *eeprom,
 	if (!buf)
 		return -ENOMEM;
 
-	ret = ice_acquire_nvm(hw, ICE_RES_READ);
-	if (ret) {
-		dev_err(dev, "ice_acquire_nvm failed, err %d aq_err %s\n",
-			ret, libie_aq_str(hw->adminq.sq_last_status));
-		goto out;
-	}
-
 	ret = ice_read_flat_nvm(hw, eeprom->offset, &eeprom->len, buf,
 				false);
 	if (ret) {
 		dev_err(dev, "ice_read_flat_nvm failed, err %d aq_err %s\n",
 			ret, libie_aq_str(hw->adminq.sq_last_status));
-		goto release;
+		goto out;
 	}
 
 	memcpy(bytes, buf, eeprom->len);
-release:
-	ice_release_nvm(hw);
 out:
 	kfree(buf);
 	return ret;
diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index 7e187a804dfa..cb1541844242 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -58,6 +58,11 @@ int ice_aq_read_nvm(struct ice_hw *hw, u16 module_typeid, u32 offset,
  * breaks read requests across Shadow RAM sectors and ensures that no single
  * read request exceeds the maximum 4KB read for a single AdminQ command.
  *
+ * FW caps the read lock at a maximum of 3000ms, so a read spanning multiple
+ * 4KB sectors cannot be done under a single lock without FW reclaiming it
+ * mid-read. The NVM lock is therefore acquired and released around each AQ
+ * read, so this function must be called without the lock held.
+ *
  * Returns a status code on failure. Note that the data pointer may be
  * partially updated if some reads succeed before a failure.
  */
@@ -65,6 +70,7 @@ int
 ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u32 *length, u8 *data,
 		  bool read_shadow_ram)
 {
+	enum libie_aq_err aq_err;
 	u32 inlen = *length;
 	u32 bytes_read = 0;
 	bool last_cmd;
@@ -92,12 +98,28 @@ ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u32 *length, u8 *data,
 
 		last_cmd = !(bytes_read + read_size < inlen);
 
+		status = ice_acquire_nvm(hw, ICE_RES_READ);
+		if (status)
+			break;
+
 		status = ice_aq_read_nvm(hw, ICE_AQC_NVM_START_POINT,
 					 offset, read_size,
 					 data + bytes_read, last_cmd,
 					 read_shadow_ram, NULL);
-		if (status)
+		if (status) {
+			/* ice_release_nvm() issues an AQ command that would
+			 * overwrite sq_last_status, which some callers
+			 * inspect after a failed read. Preserve the read's
+			 * AQ error across the release.
+			 */
+			aq_err = hw->adminq.sq_last_status;
+
+			ice_release_nvm(hw);
+			hw->adminq.sq_last_status = aq_err;
 			break;
+		}
+
+		ice_release_nvm(hw);
 
 		bytes_read += read_size;
 		offset += read_size;
@@ -330,14 +352,8 @@ ice_read_flash_module(struct ice_hw *hw, enum ice_bank_select bank, u16 module,
 		return -EINVAL;
 	}
 
-	status = ice_acquire_nvm(hw, ICE_RES_READ);
-	if (status)
-		return status;
-
 	status = ice_read_flat_nvm(hw, start + offset, &length, data, false);
 
-	ice_release_nvm(hw);
-
 	return status;
 }
 
@@ -419,24 +435,19 @@ ice_read_netlist_module(struct ice_hw *hw, enum ice_bank_select bank, u32 offset
 }
 
 /**
- * ice_read_sr_word - Reads Shadow RAM word and acquire NVM if necessary
+ * ice_read_sr_word - Reads Shadow RAM word
  * @hw: pointer to the HW structure
  * @offset: offset of the Shadow RAM word to read (0x000000 - 0x001FFF)
  * @data: word read from the Shadow RAM
  *
- * Reads one 16 bit word from the Shadow RAM using the ice_read_sr_word_aq.
+ * Reads one 16 bit word from the Shadow RAM using ice_read_sr_word_aq.
+ *
+ * The NVM lock is acquired and released internally by ice_read_flat_nvm()
+ * around the FW read, so this function must be called without the lock held.
  */
 int ice_read_sr_word(struct ice_hw *hw, u16 offset, u16 *data)
 {
-	int status;
-
-	status = ice_acquire_nvm(hw, ICE_RES_READ);
-	if (!status) {
-		status = ice_read_sr_word_aq(hw, offset, data);
-		ice_release_nvm(hw);
-	}
-
-	return status;
+	return ice_read_sr_word_aq(hw, offset, data);
 }
 
 /**
@@ -856,11 +867,7 @@ int ice_get_inactive_netlist_ver(struct ice_hw *hw, struct ice_netlist_info *net
 static int ice_discover_flash_size(struct ice_hw *hw)
 {
 	u32 min_size = 0, max_size = ICE_AQC_NVM_MAX_OFFSET + 1;
-	int status;
-
-	status = ice_acquire_nvm(hw, ICE_RES_READ);
-	if (status)
-		return status;
+	int status = 0;
 
 	while ((max_size - min_size) > 1) {
 		u32 offset = (max_size + min_size) / 2;
@@ -880,7 +887,7 @@ static int ice_discover_flash_size(struct ice_hw *hw)
 			min_size = offset;
 		} else {
 			/* an unexpected error occurred */
-			goto err_read_flat_nvm;
+			return status;
 		}
 	}
 
@@ -888,9 +895,6 @@ static int ice_discover_flash_size(struct ice_hw *hw)
 
 	hw->flash.flash_size = max_size;
 
-err_read_flat_nvm:
-	ice_release_nvm(hw);
-
 	return status;
 }
 
-- 
2.34.1


