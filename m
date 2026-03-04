Return-Path: <netdev+bounces-263829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDYZO55AqGl6rQAAu9opvQ
	(envelope-from <netdev+bounces-263829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 15:24:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B140B20158E
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 15:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B11273030A34
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 14:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F183AE19B;
	Wed,  4 Mar 2026 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ViWHG+Ho";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wNg/uc0k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ViWHG+Ho";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wNg/uc0k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BD43A8727
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633396; cv=none; b=Uxw5oGQBDgCQoG7TiiFUqZuKb0Adqj9creS7drHxzZFslyjBbIgL9qrEC+AZUOqa9n0nhh96nFM2UKsjOplGWUFZtzp1hbFXNu31RjLJUufis9z/YcfiRlbEL7286xa5uySFtuUegHMgl9dYhA6pTtloeIs4Pr0gBncRGaZYNGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633396; c=relaxed/simple;
	bh=LJccn07B1ARVmWAuCYEpESF/joPF5+OpAXg5j2Y8UCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NRlOnv42K2iQOZO4oTS6bdSlqOmXJXttg2hqKhM92f9oMQOWeBkddDsrLC7gKkagPxT1HF7EBd47xRZold2hDk7bqOEZF95+W1cjD+J9tqOxcjwvIpJEmpDjL1OsbiX7bJy9t4mQSjJQi8Ay1lKTMH/qIJxKsZpIgeTdeKHJyOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ViWHG+Ho; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wNg/uc0k; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ViWHG+Ho; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wNg/uc0k; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2AB295BDF8;
	Wed,  4 Mar 2026 14:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772633393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jnJ3Lkx9H1zFQpXQ4xMxXhC0k2VsAy7z2c9kCNd5Yz0=;
	b=ViWHG+HooGUx1lu4W5y2jddePpvBfDkt/5/z7DLgukUjYnbPRObBkzq3cnRZChz0RaAyhl
	pj7xeGsxzesyvK5hLyKjw57qNGS0JsSi7D6X5e6/IZh34vhtv7k7AuCRBqxjPLvnp6Qh9l
	2anebbPomo+ej0jWznali8O7r0sQsOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772633393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jnJ3Lkx9H1zFQpXQ4xMxXhC0k2VsAy7z2c9kCNd5Yz0=;
	b=wNg/uc0kb3wikpnpJT8WJLlGlLDlu57rImRI3XHyVC7PDMm2jM7iGslY/1bzQyEbsWT5qK
	ZiMRg/RY27X/G1DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772633393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jnJ3Lkx9H1zFQpXQ4xMxXhC0k2VsAy7z2c9kCNd5Yz0=;
	b=ViWHG+HooGUx1lu4W5y2jddePpvBfDkt/5/z7DLgukUjYnbPRObBkzq3cnRZChz0RaAyhl
	pj7xeGsxzesyvK5hLyKjw57qNGS0JsSi7D6X5e6/IZh34vhtv7k7AuCRBqxjPLvnp6Qh9l
	2anebbPomo+ej0jWznali8O7r0sQsOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772633393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jnJ3Lkx9H1zFQpXQ4xMxXhC0k2VsAy7z2c9kCNd5Yz0=;
	b=wNg/uc0kb3wikpnpJT8WJLlGlLDlu57rImRI3XHyVC7PDMm2jM7iGslY/1bzQyEbsWT5qK
	ZiMRg/RY27X/G1DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E9433EA69;
	Wed,  4 Mar 2026 14:09:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6yUHHDA9qGlafQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 04 Mar 2026 14:09:52 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: chopps@labn.net,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	herbert@gondor.apana.org.au,
	steffen.klassert@secunet.com,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Hao Long <me@imlonghao.com>
Subject: [PATCH ipsec v2] xfrm: iptfs: fix skb_put() panic on non-linear skb during reassembly
Date: Wed,  4 Mar 2026 15:09:35 +0100
Message-ID: <20260304140935.19783-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B140B20158E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263829-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,imlonghao.com:email]
X-Rspamd-Action: no action

In iptfs_reassem_cont(), IP-TFS attempts to append data to the new inner
packet 'newskb' that is being reassembled. First a zero-copy approach is
tried if it succeeds then newskb becomes non-linear.

When a subsequent fragment in the same datagram does not meet the
fast-path conditions, a memory copy is performed. It calls skb_put() to
append the data and as newskb is non-linear it triggers
SKB_LINEAR_ASSERT check.

 Oops: invalid opcode: 0000 [#1] SMP NOPTI
 [...]
 RIP: 0010:skb_put+0x3c/0x40
 [...]
 Call Trace:
  <IRQ>
  iptfs_reassem_cont+0x1ab/0x5e0 [xfrm_iptfs]
  iptfs_input_ordered+0x2af/0x380 [xfrm_iptfs]
  iptfs_input+0x122/0x3e0 [xfrm_iptfs]
  xfrm_input+0x91e/0x1a50
  xfrm4_esp_rcv+0x3a/0x110
  ip_protocol_deliver_rcu+0x1d7/0x1f0
  ip_local_deliver_finish+0xbe/0x1e0
  __netif_receive_skb_core.constprop.0+0xb56/0x1120
  __netif_receive_skb_list_core+0x133/0x2b0
  netif_receive_skb_list_internal+0x1ff/0x3f0
  napi_complete_done+0x81/0x220
  virtnet_poll+0x9d6/0x116e [virtio_net]
  __napi_poll.constprop.0+0x2b/0x270
  net_rx_action+0x162/0x360
  handle_softirqs+0xdc/0x510
  __irq_exit_rcu+0xe7/0x110
  irq_exit_rcu+0xe/0x20
  common_interrupt+0x85/0xa0
  </IRQ>
  <TASK>

Fix this by checking if the skb is non-linear. If it is, linearize it by
calling skb_linearize(). As the initial allocation of newskb originally
reserved enough tailroom for the entire reassembled packet we do not
need to check if we have enough tailroom or extend it.

Fixes: 5f2b6a909574 ("xfrm: iptfs: add skb-fragment sharing code")
Reported-by: Hao Long <me@imlonghao.com>
Closes: https://lore.kernel.org/netdev/DGRCO9SL0T5U.JTINSHJQ9KPK@imlonghao.com/
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: adjusted fixes tag and dropped skb_is_nonlinear() as skb_linearize()
is enough.
---
 net/xfrm/xfrm_iptfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 050a82101ca5..c96bec84bfa6 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -901,6 +901,12 @@ static u32 iptfs_reassem_cont(struct xfrm_iptfs_data *xtfs, u64 seq,
 	    iptfs_skb_can_add_frags(newskb, fragwalk, data, copylen)) {
 		iptfs_skb_add_frags(newskb, fragwalk, data, copylen);
 	} else {
+		if (skb_linearize(newskb)) {
+			XFRM_INC_STATS(xs_net(xtfs->x),
+				       LINUX_MIB_XFRMINBUFFERERROR);
+			goto abandon;
+		}
+
 		/* copy fragment data into newskb */
 		if (skb_copy_seq_read(st, data, skb_put(newskb, copylen),
 				      copylen)) {
-- 
2.53.0


