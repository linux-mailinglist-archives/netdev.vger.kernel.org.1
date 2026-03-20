Return-Path: <netdev+bounces-270083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIRyABjIvWkrBgMAu9opvQ
	(envelope-from <netdev+bounces-270083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:20:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0382E1B38
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61A3A30045BD
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D19236921E;
	Fri, 20 Mar 2026 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="G/b4w5rh"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A60364EA3;
	Fri, 20 Mar 2026 22:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774045128; cv=none; b=QFzyd1nrCZt1j7lEG3X4nNPWkE91Z7OthhfwclacEJfxvIkwPcr0/nVcHqwTn8XAqhpRiFuayiUCQybhdryq296Od9sDp6J4/4hxwQInICHA2TX6j8ko0AGNlpld7piU1VQDsiNS8UdfEw6f9DbVsB1RubQsW1kDU6gP9MULqhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774045128; c=relaxed/simple;
	bh=YRypZZ29Ss+2RHgdffn3znNy9naBam2zNlG0ujLenV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlV1SkRrNHT8SDhHjSsv+VUCuKf4SO/cKkkn/MrLWLJS3iSQPaeASVphCIsQiHrlbriCBZyXyHNJv6F2m82zWSyAwX9kfzuGWMsMsAqvL1QsZyaI6jyVphlg/lGqYuVhZ2t5a0+ebuHchrrVvImS2NC4w8XE7JLwnqLiwy1/bR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=G/b4w5rh; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=YsRtSo/aZPHyFnK7pcUnUVH9J+hcaRR8LhCohySh/EE=; b=G/b4w5rhiJIhnuOjvjfhNZnCo1
	0tMVrVmDCRp6Uv2VdA1Pc+5n4JbqgP3te7HFM1Js/gmcNac4lYtzPz/8e/vzLm842/SdXFBGiaISx
	LOUCv/8paxD3Ok++hyvn1ffFg2FMT/7rHax0agQxnhCT5ljw4bWkn9Foaj6aJnN+ICeFM6IfJmPD+
	gAef0cueOZPBaKukydWulHW9c7xIwOmLBDzFN0ztViaIqPJJr/o2i97EqN8ZBDHcODjRupEoQxHJW
	unc75wVMox0sfhi7GqlbKYgw684uw4I+aJ+EiOVCtU/Pq6eXHQjpSVl1x88wJQx8PASpOZm2xeVXz
	+PVXGtow==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w3iAf-000Gz5-0f;
	Fri, 20 Mar 2026 23:18:21 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	dw@davidwei.uk,
	toke@redhat.com,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: [PATCH net-next v9 04/14] net, ethtool: Disallow leased real rxqs to be resized
Date: Fri, 20 Mar 2026 23:18:04 +0100
Message-ID: <20260320221814.236775-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320221814.236775-1-daniel@iogearbox.net>
References: <20260320221814.236775-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27946/Fri Mar 20 07:24:31 2026)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270083-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid,blackwall.org:email,davidwei.uk:email,fomichev.me:email]
X-Rspamd-Queue-Id: 6A0382E1B38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Similar to AF_XDP, do not allow queues in a physical netdev to be
resized by ethtool -L when they are leased. Cover channel resize
paths (both netlink and ioctl) to reject resizing when the queues
would be affected.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/channels.c | 12 +++++++-----
 net/ethtool/ioctl.c    |  9 +++++----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/ethtool/channels.c b/net/ethtool/channels.c
index ca4f80282448..797d2a08c515 100644
--- a/net/ethtool/channels.c
+++ b/net/ethtool/channels.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include <net/xdp_sock_drv.h>
+#include <net/netdev_queues.h>
 
 #include "netlink.h"
 #include "common.h"
@@ -169,14 +169,16 @@ ethnl_set_channels(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (ret)
 		return ret;
 
-	/* Disabling channels, query zero-copy AF_XDP sockets */
+	/* ensure channels are not busy at the moment */
 	from_channel = channels.combined_count +
 		       min(channels.rx_count, channels.tx_count);
-	for (i = from_channel; i < old_total; i++)
-		if (xsk_get_pool_from_qid(dev, i)) {
-			GENL_SET_ERR_MSG(info, "requested channel counts are too low for existing zerocopy AF_XDP sockets");
+	for (i = from_channel; i < old_total; i++) {
+		if (netdev_queue_busy(dev, i, NULL)) {
+			GENL_SET_ERR_MSG(info,
+					 "requested channel counts are too low due to busy queues (AF_XDP or queue leasing)");
 			return -EINVAL;
 		}
+	}
 
 	ret = dev->ethtool_ops->set_channels(dev, &channels);
 	return ret < 0 ? ret : 1;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index ff4b4780d6af..dde45e1839ec 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -27,12 +27,13 @@
 #include <linux/net.h>
 #include <linux/pm_runtime.h>
 #include <linux/utsname.h>
+#include <linux/ethtool_netlink.h>
 #include <net/devlink.h>
 #include <net/ipv6.h>
-#include <net/xdp_sock_drv.h>
 #include <net/flow_offload.h>
 #include <net/netdev_lock.h>
-#include <linux/ethtool_netlink.h>
+#include <net/netdev_queues.h>
+
 #include "common.h"
 
 /* State held across locks and calls for commands which have devlink fallback */
@@ -2282,12 +2283,12 @@ static noinline_for_stack int ethtool_set_channels(struct net_device *dev,
 	if (ret)
 		return ret;
 
-	/* Disabling channels, query zero-copy AF_XDP sockets */
+	/* Disabling channels, query busy queues (AF_XDP, queue leasing) */
 	from_channel = channels.combined_count +
 		min(channels.rx_count, channels.tx_count);
 	to_channel = curr.combined_count + max(curr.rx_count, curr.tx_count);
 	for (i = from_channel; i < to_channel; i++)
-		if (xsk_get_pool_from_qid(dev, i))
+		if (netdev_queue_busy(dev, i, NULL))
 			return -EINVAL;
 
 	ret = dev->ethtool_ops->set_channels(dev, &channels);
-- 
2.43.0


