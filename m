Return-Path: <netdev+bounces-265126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIh3MIcFrGkxjAEAu9opvQ
	(envelope-from <netdev+bounces-265126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 12:01:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDA122B480
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 12:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78140306EC87
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 10:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B981356A23;
	Sat,  7 Mar 2026 10:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UveXsbBq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E0F34F49C
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772881142; cv=none; b=NTCv83h9PvQVDa0SqpaNXlwryhAyRvzD1B3JG3v+bf7zzhJF27NtLavQ/w48WFzei0xSndUViSHvJvjCSgmTCB1FGruvIWvtbssB3gYtABOBYAa53ANibJof3CoVI6pIoT11u4XJCeXJhS2FvC+hv70GEGOdf4qPUYmwIx+wNXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772881142; c=relaxed/simple;
	bh=FDd2xI8Jd7D9gB0fKiSlbyHiTNXBNZ0++jcrlUyV+Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5bDH5V5nJf+F0VJEA/wbBB0sXmEUBfV4wkceBgnLh3MgdAUfQxoDfxiWvPWuJuIj5O2WF82qKZAH9UHAvsAkyP1bd/96pSLOGswk7X0gzkBz2pn2hEhVslcCrNveCrVzJORkoYGdMdez6ZkpRwTqeGMfPXqjixk2y0Na3wehZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UveXsbBq; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cd78a4ce8dso54171985a.3
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 02:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772881137; x=1773485937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWqt7jbBjf5NmoQedgg0t/HNcW4ltoXPePYOrcGOf0c=;
        b=UveXsbBq9n1AIxvHpcbSZcWpFZMk6sJRt8LK9yjHXD75E84Xjq3GksYdQi/KF1fG/j
         yx00sIhZRJP3XI0QRdYq4FfziQuGYc7IhQpCP1UvD4vsqPkDgwaKkO/SAK6Illwbl9GD
         f34by7Qrap9P6RY8zy8t7O1zHj009hp3ghTitE559Ecrizplq5GVIWJRVRl9opOnRNA+
         P5+U6QEz3tpuqaFlocG2Yzn8NEUZGPSCFT3fNy3BlejUpWoKYlfEZcwas+NPS0LlDJ/a
         Yc5fP/K7TEZOTsnGSM7DsFdVKcP1RiCb49gtnyEYFcUiPBBTNBIkmn2JMF64EMrLE25R
         Zemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772881137; x=1773485937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YWqt7jbBjf5NmoQedgg0t/HNcW4ltoXPePYOrcGOf0c=;
        b=qf4EezBFecCxAXYCzP8gO8ilNi7mG8rgTPRzFwb0Rc/vDzNOW5ZhX3EanwzHhSwBQm
         Sk9T2M6gTZeLDQGlCgrmdFLBbWC0D0UpTXdIiuD9Vi9ZTRVHA9RqvT6da57sNBZxd0o4
         pEUmyrdFiDqzsbGcqN2V8DEI8KlCXqE5bPZ9yu2gIfjP1/daXedFggC+HGaDYC71b9Ip
         /229JhQ5uiDmQl3DtY+VYKX8AsJFHyd77OD3wSBqFehpBudSEKPFjfn0vt+vYCp0MoF2
         V9aiyh4mUcwIIwMZ3jjV57qRUCwiYVUmMMSUNKGz42PGdh5KSAQy+0Wr1SNHZLnc+9Yc
         2N8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1Ba7cxho8Ff8SkuLkvsVEhIqasV9cbZciTO3ynl2bLuL0NYAaZSZT7tVDgCLbEK7sTXpkKts=@vger.kernel.org
X-Gm-Message-State: AOJu0YypQJR+w4i/o6dZ2LLdQwF8EEeRs93RGDXZNeI/ccJJGZThMwMV
	y8NJaOCOfaM1fZXPvFOmhfresFkYi63ES+2PVXn9ACXrD4vXK10U0Zfh
X-Gm-Gg: ATEYQzwAV4zhjuI+gebMvHlLNTcwLGXQ6PIkemUC7HxoTM1wybgXveIiW77QPubj1se
	qet7Cl9RmZzVYMqyhcKuarLgaFaoOjitNQIryysx6NozfQsm2lrX1Oc9WrVYLUpfBAwoZp9iyEv
	fkbBhpcBVfASxb0TO/OzZhXi+zRiN9BBC5POH13ki/AoslSa/YddC5ImH0WLLcm+AXjx7gZu+ZC
	CqpjAFNQ8Pp4aMYzzYOSe9puoq2GDIc+NHV/uC+EuuEIIr2TGq+34zeNF8vLe7ujxclK8w7W7lA
	0bZdZKJ4xMmS4kxehXFNYK9fjhMvqnnzNMDunZ3WXuDEAo1f7cHje0lfQ+8QXXVd0zFO9yLbehG
	KeFzde2iygJSFhvrT7Z6FaapX7X60lDRFTkDZYxlEKJuDySwA6ZNdFCkA1aZAxmqRFEFfaLq6/W
	G9wVJ7JNMXQCouV98WzhvS4pyRCQjc5ymgPOzgyBaxWnk9F13cFFe6deL6DP7rfEPxKdc=
X-Received: by 2002:a05:620a:2549:b0:89f:8bb8:c103 with SMTP id af79cd13be357-8cd6d4b4f11mr640784885a.49.1772881137186;
        Sat, 07 Mar 2026 02:58:57 -0800 (PST)
Received: from PF5YBGDS.localdomain ([163.114.130.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd6f4a2fdasm293278485a.17.2026.03.07.02.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:58:56 -0800 (PST)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Lee Trager <lee@trager.us>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 5/5] eth fbnic: Add mailbox self test
Date: Sat,  7 Mar 2026 05:58:47 -0500
Message-ID: <20260307105847.1438-6-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260307105847.1438-1-mike.marciniszyn@gmail.com>
References: <20260307105847.1438-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5DDA122B480
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265126-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,intel.com,gmail.com,trager.us,linaro.org,kylinos.cn,fomichev.me];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

The mailbox self test ensures the interface to and from
the firmware is healthy by sending a test message and
fielding the response from the firmware.

This patch uses the new completion API [1][2] that allocates a
completion structure, binds the completion to the TEST
message, and uses a new FW parsing routine that wraps the
completion processing around the TLV parser.

Link: https://patch.msgid.link/20250516164804.741348-1-lee@trager.us [1]
Link: https://patch.msgid.link/20260115003353.4150771-6-mohsin.bashr@gmail.com [2]

Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
v2 - add enum for test return codes
v3 - no changes
v4 - no changes

 drivers/net/ethernet/meta/fbnic/fbnic.h       |  14 ++-
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  15 +++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 100 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  27 +++++
 3 files changed, 142 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index b5012601b102..f14de2366854 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -129,11 +129,13 @@ static const struct fbnic_stat fbnic_gstrings_xdp_stats[] = {
 enum fbnic_self_test_results {
 	TEST_REG = 0,
 	TEST_MSIX,
+	TEST_MBX,
 };
 
 static const char fbnic_gstrings_self_test[][ETH_GSTRING_LEN] = {
 	[TEST_REG]	= "Register test (offline)",
 	[TEST_MSIX]	= "MSI-X Interrupt test (offline)",
+	[TEST_MBX]      = "FW mailbox test (on/offline)",
 };
 
 #define FBNIC_TEST_LEN ARRAY_SIZE(fbnic_gstrings_self_test)
@@ -1528,11 +1530,24 @@ static int fbnic_ethtool_msix_test(struct net_device *netdev, u64 *data)
 	return !!*data;
 }
 
+static int fbnic_ethtool_mbx_self_test(struct net_device *netdev, u64 *data)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_dev *fbd = fbn->fbd;
+
+	*data = fbnic_fw_mbx_self_test(fbd);
+
+	return !!*data;
+}
+
 static void fbnic_self_test(struct net_device *netdev,
 			    struct ethtool_test *eth_test, u64 *data)
 {
 	bool if_running = netif_running(netdev);
 
+	if (fbnic_ethtool_mbx_self_test(netdev, &data[TEST_MBX]))
+		eth_test->flags |= ETH_TEST_FL_FAILED;
+
 	if (!(eth_test->flags & ETH_TEST_FL_OFFLINE)) {
 		data[TEST_REG] = 0;
 		data[TEST_MSIX] = 0;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 1f0b6350bef4..c2bad51bdde6 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -378,6 +378,37 @@ fbnic_fw_get_cmpl_by_type(struct fbnic_dev *fbd, u32 msg_type)
 	return cmpl_data;
 }
 
+/**
+ * fbnic_fw_xmit_test_msg - Create and transmit a test message to FW mailbox
+ * @fbd: FBNIC device structure
+ * @cmpl: fw completion struct
+ *
+ * Return: zero on success, negative value on failure
+ *
+ * Generates a single page mailbox test message and places it in the Tx
+ * mailbox queue. Expectation is that the FW will validate that the nested
+ * value matches the external values, and then will echo them back to us.
+ *
+ * Also sets a completion slot for use in the completion wait calls when
+ * the cmpl arg is non-NULL.
+ */
+int fbnic_fw_xmit_test_msg(struct fbnic_dev *fbd,
+			   struct fbnic_fw_completion *cmpl)
+{
+	struct fbnic_tlv_msg *test_msg;
+	int err;
+
+	test_msg = fbnic_tlv_test_create(fbd);
+	if (!test_msg)
+		return -ENOMEM;
+
+	err = fbnic_mbx_map_req_w_cmpl(fbd, test_msg, cmpl);
+	if (err)
+		free_page((unsigned long)test_msg);
+
+	return err;
+}
+
 /**
  * fbnic_fw_xmit_simple_msg - Transmit a simple single TLV message w/o data
  * @fbd: FBNIC device structure
@@ -1556,7 +1587,29 @@ int fbnic_fw_xmit_send_logs(struct fbnic_dev *fbd, bool enable,
 	return err;
 }
 
+static int
+fbnic_fw_parser_test(void *opaque, struct fbnic_tlv_msg **results)
+{
+	struct fbnic_fw_completion *cmpl;
+	struct fbnic_dev *fbd = opaque;
+	int err;
+
+	/* find cmpl */
+	cmpl = fbnic_fw_get_cmpl_by_type(fbd, FBNIC_TLV_MSG_ID_TEST);
+	if (!cmpl)
+		return -ENOSPC;
+
+	err = fbnic_tlv_parser_test(opaque, results);
+
+	cmpl->result = err;
+	complete(&cmpl->done);
+	fbnic_fw_put_cmpl(cmpl);
+
+	return err;
+}
+
 static const struct fbnic_tlv_parser fbnic_fw_tlv_parser[] = {
+	FBNIC_TLV_PARSER(TEST, fbnic_tlv_test_index, fbnic_fw_parser_test),
 	FBNIC_TLV_PARSER(FW_CAP_RESP, fbnic_fw_cap_resp_index,
 			 fbnic_fw_parse_cap_resp),
 	FBNIC_TLV_PARSER(OWNERSHIP_RESP, fbnic_ownership_resp_index,
@@ -1787,6 +1840,53 @@ void fbnic_mbx_flush_tx(struct fbnic_dev *fbd)
 	} while (time_is_after_jiffies(timeout));
 }
 
+/**
+ * fbnic_fw_mbx_self_test() - verify firmware interface
+ * @fbd: device to test
+ *
+ * This function tests the interfaces to/from the firmware.
+ *
+ * Return: See enum fbnic_fw_self_test_codes
+ **/
+enum fbnic_fw_self_test_codes fbnic_fw_mbx_self_test(struct fbnic_dev *fbd)
+{
+	enum fbnic_fw_self_test_codes err;
+	struct fbnic_fw_completion *cmpl;
+
+	/* Skip test if FW interface is not present */
+	if (!fbnic_fw_present(fbd))
+		return FBNIC_TEST_FW_NO_FIRMWARE;
+
+	cmpl = fbnic_fw_alloc_cmpl(FBNIC_TLV_MSG_ID_TEST);
+	if (!cmpl)
+		return FBNIC_TEST_FW_NO_CMPL;
+
+	/* Load a test message onto the FW mailbox interface
+	 * and arm the completion.
+	 */
+	err = fbnic_fw_xmit_test_msg(fbd, cmpl);
+	if (err) {
+		err = FBNIC_TEST_FW_NO_XMIT;
+		goto exit_free;
+	}
+
+	/* Verify we received a message back */
+	if (!fbnic_mbx_wait_for_cmpl(cmpl)) {
+		err = FBNIC_TEST_FW_NO_MSG;
+		goto exit_cleanup;
+	}
+
+	/* Verify there were no parsing errors */
+	if (cmpl->result)
+		err = FBNIC_TEST_FW_PARSE;
+exit_cleanup:
+	fbnic_mbx_clear_cmpl(fbd, cmpl);
+exit_free:
+	fbnic_fw_put_cmpl(cmpl);
+
+	return err;
+}
+
 int fbnic_fw_xmit_rpc_macda_sync(struct fbnic_dev *fbd)
 {
 	struct fbnic_tlv_msg *mac_array;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
index 8f7218900562..d84723e4cfa3 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -104,6 +104,33 @@ void fbnic_mbx_clear_cmpl(struct fbnic_dev *fbd,
 void fbnic_mbx_poll(struct fbnic_dev *fbd);
 int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd);
 void fbnic_mbx_flush_tx(struct fbnic_dev *fbd);
+
+/**
+ * enum fbnic_fw_self_test_codes - return codes from self test routines
+ *
+ * These are the codes returned from the self test routines and
+ * stored in the test result array indexed by the specific
+ * test name.
+ *
+ * @FBNIC_TEST_FW_SUCCESS: test success
+ * @FBNIC_TEST_FW_NO_FIRMWARE: FW interface not present
+ * @FBNIC_TEST_FW_NO_CMPL: No completion available
+ * @FBNIC_TEST_FW_NO_XMIT: Could not xmit message
+ * @FBNIC_TEST_FW_NO_MSG: no message returned
+ * @FBNIC_TEST_FW_PARSE: returned message had parsing error
+ */
+enum fbnic_fw_self_test_codes {
+	FBNIC_TEST_FW_SUCCESS = 0,
+	FBNIC_TEST_FW_NO_FIRMWARE = 10,
+	FBNIC_TEST_FW_NO_CMPL = 20,
+	FBNIC_TEST_FW_NO_XMIT = 30,
+	FBNIC_TEST_FW_NO_MSG = 40,
+	FBNIC_TEST_FW_PARSE = 50,
+};
+
+enum fbnic_fw_self_test_codes fbnic_fw_mbx_self_test(struct fbnic_dev *fbd);
+int fbnic_fw_xmit_test_msg(struct fbnic_dev *fbd,
+			   struct fbnic_fw_completion *c);
 int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership);
 int fbnic_fw_init_heartbeat(struct fbnic_dev *fbd, bool poll);
 void fbnic_fw_check_heartbeat(struct fbnic_dev *fbd);
-- 
2.43.0


