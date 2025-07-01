Return-Path: <netdev+bounces-202881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39482AEF84C
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC8C4A763B
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAC72749F6;
	Tue,  1 Jul 2025 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ck7JKnL2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C15273D7E;
	Tue,  1 Jul 2025 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372589; cv=none; b=gYBkPqKpHifEVz3Kku9vBlYbPQoBk2BIu1D4rySpQr+GoCuMm3SOtJyrUw0YFuDmuZH0CbfgX1T1XPFob56JI84vK48CS3U2mOB6MrcaRsh+duzGJ6Hm8DrWpbBeDTIH9EHeBBOTnIfMua2AMwePBBvcBTA1enm69QJlRtA25bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372589; c=relaxed/simple;
	bh=I07NkhytVT3vjKtgU8JtRK5xwzfDuVb4MvGSttIHb8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fWpVV8bUIY/9gZIT4f9bKNoXgWmlTfm7ltGDS+G6byKGexZclAhXUDLwM0e+KMYIgDZaKNNn73mi4FAoWIf5amjbirx7tz0xaikk2kyPaBw4Bzp4YqJuQzVVHDtIK0fdgo0+WUdALUNlwyXfahZamUnrIM0rS50ZSsI0FOUdcjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ck7JKnL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3BBC4CEEB;
	Tue,  1 Jul 2025 12:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751372588;
	bh=I07NkhytVT3vjKtgU8JtRK5xwzfDuVb4MvGSttIHb8w=;
	h=From:To:Cc:Subject:Date:From;
	b=ck7JKnL2W2dDD80xo9Y9b4D26oDKRtcla4rp1cuJkKgNuXrBe5W365nDeLbZVRTsV
	 bwfkKBBX5vMam2fuhLe588ELWxmqtPX0b3Bif35t+vWsyBGc4654DIXEHTtQS/Bi8q
	 6aotE3+dHVCxa45cBexYmuJKDVhvr9Zd5oBYNqno=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: HarshaVardhana S A <harshavardhana.sa@broadcom.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH net] vsock/vmci: Clear the vmci transport packet properly when initializing it
Date: Tue,  1 Jul 2025 14:22:54 +0200
Message-ID: <20250701122254.2397440-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HarshaVardhana S A <harshavardhana.sa@broadcom.com>

In vmci_transport_packet_init memset the vmci_transport_packet before
populating the fields to avoid any uninitialised data being left in the
structure.

Cc: Bryan Tan <bryan-bt.tan@broadcom.com>
Cc: Vishnu Dasa <vishnu.dasa@broadcom.com>
Cc: Broadcom internal kernel review list
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org
Cc: stable <stable@kernel.org>
Signed-off-by: HarshaVardhana S A <harshavardhana.sa@broadcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Tweaked from original version by rewording the text and adding a blank
line and correctly sending it to the proper people for inclusion in net.

 net/vmw_vsock/vmci_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index b370070194fa..7eccd6708d66 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -119,6 +119,8 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
 			   u16 proto,
 			   struct vmci_handle handle)
 {
+	memset(pkt, 0, sizeof(*pkt));
+
 	/* We register the stream control handler as an any cid handle so we
 	 * must always send from a source address of VMADDR_CID_ANY
 	 */
@@ -131,8 +133,6 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
 	pkt->type = type;
 	pkt->src_port = src->svm_port;
 	pkt->dst_port = dst->svm_port;
-	memset(&pkt->proto, 0, sizeof(pkt->proto));
-	memset(&pkt->_reserved2, 0, sizeof(pkt->_reserved2));
 
 	switch (pkt->type) {
 	case VMCI_TRANSPORT_PACKET_TYPE_INVALID:
-- 
2.50.0


