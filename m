Return-Path: <netdev+bounces-293681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAD4N5NjHWpHaAkAu9opvQ
	(envelope-from <netdev+bounces-293681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:48:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AB961DD80
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0C1430087ED
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 10:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C178B39B975;
	Mon,  1 Jun 2026 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uUKi/xO0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="L//zFvX/"
X-Original-To: netdev@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C2934678E;
	Mon,  1 Jun 2026 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310928; cv=none; b=CST/qlN4lKA8rj9GR4UAEoOR70yhPUpwvwi3z4h+sbkHPW68b3X8k3ak9KhJzWPE3DCUsnl2up5GJFtCqzqZUZfVjIdypEuhHELVzX+d8KfXbfhvt3gCvC+0k/1bVywbTzBCmi2XXmoDnZXykPKgVA5Pvn4nahI4UTZQNjx4MHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310928; c=relaxed/simple;
	bh=MIpS+FQSsenc9gYHxlEeSq+uYkS+P2ViO0J4kH5OrJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GjUyZjpzrn53zrNszyFDIXf3VRmjl/Nxn+7IOnYkPIuoKuG+imHpJXfwxrf8t0Hr/9EqwW4pJMjrE4TXxRCXk6I0v95CewqbgFiffbSBZ6i/QQJvgvBsk996DDiCCrz/WSAISBeLfruOqrtfjvbqCJOFsd+vf0jZVI+xUVcliVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=uUKi/xO0; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=L//zFvX/; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4gTVtb52bcz9sPn;
	Mon,  1 Jun 2026 12:43:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780310615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jwNkKrSaO1VdLBnK2BDf0Nq86weYabakK4KTS5UaytU=;
	b=uUKi/xO03cS9opA5+CjGJ46YdsYvFVafB/c4bA1FUAzOkfVFUOujwyssbgYTe26CSDnR/P
	r0VCRVXDNx4QAvs3oDN9dQqmSDvLT3WLDCegdjPM+zJ2onSsDQMo39nofiXxDSy+BHExKN
	2F51f4nNJy7525mV4NWnKZ6mJXsbuQCXeNFEb9cTLkKVZ9zuzRb3Z9mmpUn8kWs40ECkev
	CZj5APCNwzc030UtHqWgbEC1tm/v2YntACz2/X0JxdQvTcDCiV1BqUbNnLqSxR468W4dGS
	OGcWqT6HmN1r9CKqO+KMVhsGo1pVAxzNHgaWALzb53dumjU3F5Mzrn2be1g2Eg==
From: Qing Ming <a0yami@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780310614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jwNkKrSaO1VdLBnK2BDf0Nq86weYabakK4KTS5UaytU=;
	b=L//zFvX/6jXgs1sNI3S0kWvJsFaqVtO0VGS2XKbEQSZ6Wuw4L+JOPnF8EYUTPZLZgfxNOG
	IVnQiMdMWWxoyTP/TcNPxBW8XF7TI1ixWder5fGjcgjpAlgnpTgD90yBswVKlsQC89D3+d
	16IRUgacH43yEaIKTJjAWfZhvhoJKdT936eDwfOmEXR6XmNde1sL2l257LmVaIEeDOSci3
	hvaXxjTCRzuhOZMyuencUjSx+S/0hw5pFzFJETucEWcgVn9ixf8q8hYj7xFwCBtGIVcrkO
	/hgB0FpTA1f1LCNuiHQuI+l+CKy1pGCkmmqdPMUojrEyRbuKE9gD01aj2fc/cQ==
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Shirley <xma@us.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qing Ming <a0yami@mailbox.org>
Subject: [PATCH net] vhost/net: complete zerocopy ubufs only once
Date: Mon,  1 Jun 2026 18:43:00 +0800
Message-ID: <20260601104300.197210-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9cdff043130c0e47f0b
X-MBO-RS-META: rficd44fz5imjeeqwe3h79341x7uofr8
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293681-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a0yami@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mailbox.org:email,mailbox.org:mid,mailbox.org:dkim]
X-Rspamd-Queue-Id: A4AB961DD80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

vhost-net initializes one ubuf_info per outstanding zerocopy TX
descriptor and hands it to the backend socket.  The networking stack may
then clone a zerocopy skb before all skb references are released.  For
example, batman-adv fragmentation reaches skb_split(), which calls
skb_zerocopy_clone() and increments the same ubuf_info refcount.

vhost_zerocopy_complete() currently treats every ubuf callback as a
completed vhost descriptor.  It dereferences ubuf->ctx, writes the
descriptor completion state, and drops the vhost_net_ubuf_ref even when
the callback only releases a cloned skb reference.  A backend reset can
therefore wait for and free the vhost_net_ubuf_ref while another cloned
skb still carries the same ubuf_info.  A later completion then
dereferences the freed ubufs pointer.

KASAN reports the stale completion as:

  BUG: KASAN: slab-use-after-free in vhost_zerocopy_complete+0x1d7/0x1f0
  BUG: KASAN: slab-use-after-free in vhost_zerocopy_complete+0x101/0x1f0
  vhost_zerocopy_complete
  skb_copy_ubufs
  __dev_forward_skb2
  veth_xmit

The freed object was allocated from vhost_net_ioctl() while setting the
backend and freed through kfree_rcu()/kvfree_rcu_bulk after backend
removal, while delayed skb completion still reached
vhost_zerocopy_complete().

Honor the generic ubuf_info refcount before touching vhost state, and run
the vhost descriptor completion only for the final ubuf reference.  This
matches the msg_zerocopy_complete() ownership rule for cloned zerocopy
skbs.

Fixes: bab632d69ee4 ("vhost: vhost TX zero-copy support")
Signed-off-by: Qing Ming <a0yami@mailbox.org>
---
 drivers/vhost/net.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index c6536cad9c4f..b9af63fb6306 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -390,13 +390,20 @@ static void vhost_zerocopy_signal_used(struct vhost_net *net,
 static void vhost_zerocopy_complete(struct sk_buff *skb,
 				    struct ubuf_info *ubuf_base, bool success)
 {
-	struct ubuf_info_msgzc *ubuf = uarg_to_msgzc(ubuf_base);
-	struct vhost_net_ubuf_ref *ubufs = ubuf->ctx;
-	struct vhost_virtqueue *vq = ubufs->vq;
+	struct ubuf_info_msgzc *ubuf;
+	struct vhost_net_ubuf_ref *ubufs;
+	struct vhost_virtqueue *vq;
 	int cnt;
 
-	rcu_read_lock_bh();
+	/* Only the final cloned skb reference completes the vhost descriptor. */
+	if (!refcount_dec_and_test(&ubuf_base->refcnt))
+		return;
+
+	ubuf = uarg_to_msgzc(ubuf_base);
+	ubufs = ubuf->ctx;
+	vq = ubufs->vq;
 
+	rcu_read_lock_bh();
 	/* set len to mark this desc buffers done DMA */
 	vq->heads[ubuf->desc].len = success ?
 		VHOST_DMA_DONE_LEN : VHOST_DMA_FAILED_LEN;
-- 
2.53.0


