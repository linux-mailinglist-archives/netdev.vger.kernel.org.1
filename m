Return-Path: <netdev+bounces-260660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PMDF84YnmmcTQQAu9opvQ
	(envelope-from <netdev+bounces-260660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 22:31:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BA918CCC4
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 22:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16093303A101
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 21:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05D633E346;
	Tue, 24 Feb 2026 21:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGHAp1VY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF8B33DEDD;
	Tue, 24 Feb 2026 21:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771968701; cv=none; b=uun8bTMk0Vy376tIc1sAC9vFCw4PL3yWCxl+PH04767d0xL/WY7u4s8grjzsKo+190ZzIV6qElL2l/Pqx/a+xovesj9UXQBUmMxA0XngIyp8mecJUq/gwl/gewQdm8WrQUQDMnPTn0iZCk5zQsh2LNXJhAJ33sSaMYm4hnbOrYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771968701; c=relaxed/simple;
	bh=YIlxGwPr5hMd/xYC92n77YTEg4ZxfpXED5MmFXnriGA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LgoLwXMs+ix978Q7k/9wpcrPXePuxz26lx4DXfRGvvbvfcyjVQvqP6TI1G7zbr9umKJuPa9mXS8A+ebKdIWF+YRP/w8LP3HRUoBBD8sE0DkFwzYhaaGQNzqFxR5CC9TsiskaILe//z81agNC6c4Jzy7zMLmyMxMeCyimZeyeO5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGHAp1VY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A998BC116D0;
	Tue, 24 Feb 2026 21:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771968701;
	bh=YIlxGwPr5hMd/xYC92n77YTEg4ZxfpXED5MmFXnriGA=;
	h=Date:From:To:Cc:Subject:From;
	b=AGHAp1VYfEp8JV0mtoHFu/TlxSn1frOQtTrUcFQKzGqTe0q7YGXqPbrN44SgKLePx
	 zVmCQqhQki+nTDHMfT4GRqwGhBnYYNN0DWenHLjJV13eYD8RJ6jniJIe8vaDGKqXMa
	 H61sSnNocbGNbxoJ8v9IoJJP+n+tOY0Dm7xoK7yFHc5mkvnBk4HiLsv+9wYJF7128/
	 NjFIIYz4sypjpOAPUXrdXGVK6wbh2V7KIVfHZgDcRy1vMLuBmxZeeNAuxT7BnhDkbz
	 qs2csCdBhnDHI6Q0V7nPM6RwNKOcKkgsLnhVgMci4d4vnkrkaU8qNAbGZNV+JT42xX
	 UEuAQy5VyxfBg==
Date: Tue, 24 Feb 2026 15:31:08 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] Bluetooth: hci.h: Avoid a couple
 -Wflex-array-member-not-at-end warnings
Message-ID: <aZ1FrL8qvvKuktBF@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260660-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gustavoars@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0BA918CCC4
X-Rspamd-Action: no action

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

struct hci_std_codecs and struct hci_std_codecs_v2 are flexible
structures, this is structures that contain a flexible-array member
(__u8 codec[]; and struct hci_std_codec_v2 codec[];, correspondingly.)

Since struct hci_rp_read_local_supported_codecs and struct
hci_rp_read_local_supported_codecs_v2 are defined by hardware, we
create the new struct hci_std_codecs_hdr and struct hci_std_codecs_v2_hdr
types, and use them to replace the object types causing trouble in
struct hci_rp_read_local_supported_codecs and struct
hci_rp_read_local_supported_codecs_v2, namely struct hci_std_codecs
std_codecs; and struct hci_std_codecs_v2_hdr std_codecs;.

Also, once -fms-extensions is enabled, we can use transparent struct
members in both struct hci_std_codecs and struct hci_std_codecs_v2_hdr.

Notice that the newly created types does not contain the flex-array
member `codec`, which is the object causing the -Wfamnae warnings.

After these changes, the size of struct hci_rp_read_local_supported_codecs
and struct hci_rp_read_local_supported_codecs_v2, along with their
member's offsets remain the same, hence the memory layouts don't
change:

Before changes:
struct hci_rp_read_local_supported_codecs {
        __u8                       status;               /*     0     1 */
        struct hci_std_codecs      std_codecs;           /*     1     1 */
        struct hci_vnd_codecs      vnd_codecs;           /*     2     1 */

        /* size: 3, cachelines: 1, members: 3 */
        /* last cacheline: 3 bytes */
} __attribute__((__packed__));

struct hci_rp_read_local_supported_codecs_v2 {
        __u8                       status;               /*     0     1 */
        struct hci_std_codecs_v2   std_codecs;           /*     1     1 */
        struct hci_vnd_codecs_v2   vendor_codecs;        /*     2     1 */

        /* size: 3, cachelines: 1, members: 3 */
        /* last cacheline: 3 bytes */
} __attribute__((__packed__));

After changes:
struct hci_rp_read_local_supported_codecs {
	__u8                       status;               /*     0     1 */
	struct hci_std_codecs_hdr  std_codecs;           /*     1     1 */
	struct hci_vnd_codecs      vnd_codecs;           /*     2     1 */

	/* size: 3, cachelines: 1, members: 3 */
	/* last cacheline: 3 bytes */
} __attribute__((__packed__));

struct hci_rp_read_local_supported_codecs_v2 {
	__u8                       status;               /*     0     1 */
	struct hci_std_codecs_v2_hdr std_codecs;         /*     1     1 */
	struct hci_vnd_codecs_v2   vendor_codecs;        /*     2     1 */

	/* size: 3, cachelines: 1, members: 3 */
	/* last cacheline: 3 bytes */
} __attribute__((__packed__));

With these changes fix the following warnings:

include/net/bluetooth/hci.h:1490:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/net/bluetooth/hci.h:1525:34: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/net/bluetooth/hci.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 89ad9470fa71..572b1c620c5d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1468,8 +1468,12 @@ struct hci_rp_read_data_block_size {
 } __packed;
 
 #define HCI_OP_READ_LOCAL_CODECS	0x100b
-struct hci_std_codecs {
+struct hci_std_codecs_hdr {
 	__u8	num;
+} __packed;
+
+struct hci_std_codecs {
+	struct hci_std_codecs_hdr;
 	__u8	codec[];
 } __packed;
 
@@ -1487,7 +1491,7 @@ struct hci_vnd_codecs {
 
 struct hci_rp_read_local_supported_codecs {
 	__u8	status;
-	struct hci_std_codecs std_codecs;
+	struct hci_std_codecs_hdr std_codecs;
 	struct hci_vnd_codecs vnd_codecs;
 } __packed;
 
@@ -1504,8 +1508,12 @@ struct hci_std_codec_v2 {
 	__u8	transport;
 } __packed;
 
-struct hci_std_codecs_v2 {
+struct hci_std_codecs_v2_hdr {
 	__u8	num;
+} __packed;
+
+struct hci_std_codecs_v2 {
+	struct hci_std_codecs_v2_hdr;
 	struct hci_std_codec_v2 codec[];
 } __packed;
 
@@ -1522,7 +1530,7 @@ struct hci_vnd_codecs_v2 {
 
 struct hci_rp_read_local_supported_codecs_v2 {
 	__u8	status;
-	struct hci_std_codecs_v2 std_codecs;
+	struct hci_std_codecs_v2_hdr std_codecs;
 	struct hci_vnd_codecs_v2 vendor_codecs;
 } __packed;
 
-- 
2.43.0


