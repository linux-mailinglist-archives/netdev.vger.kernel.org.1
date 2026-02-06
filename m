Return-Path: <netdev+bounces-257598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCVcM64MhmkRJQQAu9opvQ
	(envelope-from <netdev+bounces-257598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:45:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52777FFDD8
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 16:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30ACA3063AD0
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 15:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD602E285C;
	Fri,  6 Feb 2026 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKSQ2m4V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769622E0910
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770392575; cv=none; b=dhXldIXcQ9gbBGklzTuLt0L26SESpwPc1tEkPW4CQzR+4zKDGkujNvsx4Bkjv/TekqoZ2ksHfHJlyt7wpHwPpRIcU9GHFV0lUMSsW8etunLF8Fg6/Jl8n0KdJcAvwZefC0+cS2gcruSj3fGCKln8YiNvEG73zrTZekS76+qrkYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770392575; c=relaxed/simple;
	bh=gUufKabp52w0cEl5iOG80SMMxhThKKEKi0gMp23tmE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0EjsXyQn4IIFtxJ/874g40C+rMcLnPbWA7TGbIbgiKvlKGt3zTa0tEZacpDP14f9xCYKU3zAniuDfURjnJBMMQJqYRqZkSb6AExtFdPCzXrrgIUdYpswA7xP4D/rYXs0Hn446uPpn6XQhDtdN7pBQxBP1oitz+qxccZrG88c4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKSQ2m4V; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8947e6ffd30so9128116d6.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 07:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770392574; x=1770997374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hD+rNwMUIX3Jn1r3ZokuEe2+nahxokzufdjdWGwdbJ8=;
        b=KKSQ2m4Vk2O+3T5D8NefaV3JLXBxD6SlNcEIWrswlrOQnWw/PdQsy7V3l/NrFZFcW3
         HXAsa6mgWeYCc62GUL709AoLVTBdZkRYkbJ0s/0mFowyKtgOKHtKDQyRLfnRzCDxa92p
         +EKEHaG2gSbh9BO/4orCWQwVwu40adugrUBxnllEtx9MUTc+Oyi4jO2kSW8UOublYS7y
         PxlYdPXUCGomUbxGJy7vsvjewH/OWSipUWY4bKgDR6luzVWkrguxfcS1F0FvNIUogBkm
         oYfdPdaABSq/7+b3yfSh6P8AmZAZ8xW8IOGBD3m/Iqn+NEnuDc2Sqvvh/ZcwPRVRxnIG
         TOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770392574; x=1770997374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hD+rNwMUIX3Jn1r3ZokuEe2+nahxokzufdjdWGwdbJ8=;
        b=GufL6CIl5X3VfozpDyyDCh8GiAzJG9WSijI70nk3TSIS+KZ7pYCpduxHOmkxKuXTt9
         Qgs79pp2cESM/ztxoXw73ctscNk7ko6xxP2PvhaTc9Q8C6riB0iQZprZ6HQqS3T8NajQ
         ChUDz/j1WPVZ5/fVVLaIg/HhUO1zvXvDdD1aEr4ms/jID1sjno/2jU0vvhHsg9nxcB2Y
         //hnbVNBW+QkT3ZM/RArkwHGYYiqou1OvdWISIitzO64P4i1SNaT9FtAHchtF9MJkfpk
         ivJ9nCzilFofDmBNavpA36EYO9uF7MwjUR9iy1FjjmRPQLuJQVdw8MaeM2jP6lozb5e4
         5JAg==
X-Gm-Message-State: AOJu0YxMqwxIMabQkdUlU/d1LSyghfv5iReK5OhQckoBhY5ncSV61roR
	3hkwcTNRZrdR+rSBf4i30jfjzBsqjuxw9S9F2teEbQerEpL89f9SVuoN
X-Gm-Gg: AZuq6aIXQOExBZ3xx0EFZpC9hXOUTu9fP981L2KCg7O+A01/zff26CvaBsuRRhyQVfW
	/iHkMEsv+JhNA/T+WXonoI4T/ph1AW6abDEqObMXewg4fnZdoobff7Kwb8d0q3lHmWXxw5opJOF
	TBo4fV44IDZgFVMAOxCRHciCiHQUfyaX9gBSx3DcrnjkXKoWPATnAmlk7dAGoDpR5ma6NpipsLy
	JYkFDSQIPBdHN/QpNkduU2gsTYjzmFK4SD/EMresmJNfhxZ00sb4FSGmB9J/B6kqtNjP2igCEyG
	sa7ExDoihgf9AJnYS4GH9XoOEqYGTyBL6SomyZeduB/ARNDlBly5wFAIHIT2vJKKaof6Ti5rvfK
	fZ/Esf7LsqlkPR7102nGflKrJUuQ2egdDmV1ytse1EYtMfsHOi6YXlfl6n4EKs2bisxA+2zNNP8
	SpvBh3G/xIEbzHIr1UYlDpmsaROjzgTIXnO6rZz4lkQWV/
X-Received: by 2002:a05:6214:9b4:b0:895:47ee:2b86 with SMTP id 6a1803df08f44-89547ee2d22mr1370846d6.67.1770392574372;
        Fri, 06 Feb 2026 07:42:54 -0800 (PST)
Received: from PF5YBGDS.localdomain ([163.114.130.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9eea0c0sm181499185a.42.2026.02.06.07.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:42:54 -0800 (PST)
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
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v12 5/5] eth fbnic: Add mailbox self test
Date: Fri,  6 Feb 2026 10:42:45 -0500
Message-ID: <20260206154246.814-6-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206154246.814-1-mike.marciniszyn@gmail.com>
References: <20260206154246.814-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257598-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,intel.com,gmail.com,trager.us,linaro.org,kylinos.cn,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 52777FFDD8
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
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 15 +++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 92 +++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  3 +
 3 files changed, 110 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index b0c8d1b069e2..251de64baa5a 100644
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
@@ -1525,11 +1527,24 @@ static int fbnic_ethtool_msix_test(struct net_device *netdev, u64 *data)
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
index 1f0b6350bef4..0fb8dc9091ca 100644
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
@@ -1787,6 +1840,45 @@ void fbnic_mbx_flush_tx(struct fbnic_dev *fbd)
 	} while (time_is_after_jiffies(timeout));
 }

+int fbnic_fw_mbx_self_test(struct fbnic_dev *fbd)
+{
+	struct fbnic_fw_completion *cmpl;
+	int err;
+
+	/* Skip test if FW interface is not present */
+	if (!fbnic_fw_present(fbd))
+		return 10;
+
+	cmpl = fbnic_fw_alloc_cmpl(FBNIC_TLV_MSG_ID_TEST);
+	if (!cmpl)
+		return 20;
+
+	/* Load a test message onto the FW mailbox interface
+	 * and arm the completion.
+	 */
+	err = fbnic_fw_xmit_test_msg(fbd, cmpl);
+	if (err) {
+		err = 30;
+		goto exit_free;
+	}
+
+	/* Verify we received a message back */
+	if (!fbnic_mbx_wait_for_cmpl(cmpl)) {
+		err = 40;
+		goto exit_cleanup;
+	}
+
+	/* Verify there were no parsing errors */
+	if (cmpl->result)
+		err = 50;
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
index 8f7218900562..054d8f104486 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
@@ -104,6 +104,9 @@ void fbnic_mbx_clear_cmpl(struct fbnic_dev *fbd,
 void fbnic_mbx_poll(struct fbnic_dev *fbd);
 int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd);
 void fbnic_mbx_flush_tx(struct fbnic_dev *fbd);
+int fbnic_fw_mbx_self_test(struct fbnic_dev *fbd);
+int fbnic_fw_xmit_test_msg(struct fbnic_dev *fbd,
+			   struct fbnic_fw_completion *c);
 int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership);
 int fbnic_fw_init_heartbeat(struct fbnic_dev *fbd, bool poll);
 void fbnic_fw_check_heartbeat(struct fbnic_dev *fbd);
--
2.43.0


