Return-Path: <netdev+bounces-254601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPiuEzkVe2n5BAIAu9opvQ
	(envelope-from <netdev+bounces-254601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:07:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA8AAD1C1
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B01BF301BA68
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830F337B3F5;
	Thu, 29 Jan 2026 08:07:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE5623F26A
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674037; cv=none; b=PhQDMOG/fXGxqpmWTtTpDIfTK2eW8Vq4Bap1a2PLnUpgFs4fKZRBd05sFt93aR3PozETdoFd6sqw2K/x4mwa7/2q/bvZvzobZ6Hdv7v/utgTUmIFNRfueONiPSoAB7IuDnwapBSGZjL3bO4hbvEGd43qO9cCsJLDllsxqBSyjqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674037; c=relaxed/simple;
	bh=IEEjBD/NyjWngjnunYXQwYzStvzoWAGQ7tdtpUapPpY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VevDGm9XILGpwX107GEbcJwSC9aoXK+Xjbih3slHxAxaWy+RGtsdRAClDwmJsxWhWYMbHGus07YsNpQA3RUmezK9Z+bcbCbo5LGY3FhLCLvtsJAo58G8Y3ohkpXlT4lQos82MNv10zsIqhb63d9xi4rD8IrJAR2D0ibKiX/Y7L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1vlN3J-0006b0-BT; Thu, 29 Jan 2026 09:06:57 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH RFC v2 0/2] virtio-net: add flow filter for receive
 timestamps
Date: Thu, 29 Jan 2026 09:06:40 +0100
Message-Id: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABAVe2kC/42NTQ6CMBCFr0Jm7RjaoqIrExMP4NawgHaA2bRNW
 xsM4e42nMDl+/veCpECU4RbtUKgzJGdLUIeKtBzbydCNkWDrKUSUrSYz3jB5DxrzBwSO7SU0Ce
 PyoylNOhmbAyUvQ808rKz3/B6PqAr5swxufDd/7LYoz/QWWCNutdXOUjTnpS8e7LTJwVneTkag
 m7bth97kcHOzAAAAA==
X-Change-ID: 20231218-v6-7-topic-virtio-net-ptp-3df023bc4f4d
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[redhat.com,linux.alibaba.com,davemloft.net,google.com,kernel.org,gmail.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254601-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s.trumtrar@pengutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CAA8AAD1C1
X-Rspamd-Action: no action

This series tries to pick up the work on the virtio-net timestamping
feature from Willem de Bruijn.

Original series
    Message-Id: 20210208185558.995292-1-willemdebruijn.kernel@gmail.com
    Subject: [PATCH RFC v2 0/4] virtio-net: add tx-hash, rx-tstamp,
    tx-tstamp and tx-time
    From: Willem de Bruijn <willemb@google.com>

    RFC for four new features to the virtio network device:

    1. pass tx flow state to host, for routing + telemetry
    2. pass rx tstamp to guest, for better RTT estimation
    3. pass tx tstamp to guest, idem
    3. pass tx delivery time to host, for accurate pacing

    All would introduce an extension to the virtio spec.

The changes in this series are to the driver side. For the changes to qemu see:
    https://github.com/strumtrar/qemu/tree/v10.2.0/virtio-rx-stamps    

Currently only virtio-net is supported. Performance was tested with
pktgen which doesn't show a decrease in transfer speeds.

As these patches are now mostly different from the initial patchset, I removed
the Signed-off-bys from Willem, so he mustn't be ashamed of what his work evolved to ;)

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Changes in v2:
- rework patches to use flow filter instead of feature flag
- Link to v1: https://lore.kernel.org/r/20231218-v6-7-topic-virtio-net-ptp-v1-0-cac92b2d8532@pengutronix.de

---
Steffen Trumtrar (2):
      tun: support rx-tstamp
      virtio-net: support receive timestamp

 drivers/net/tun.c               |  30 +++++----
 drivers/net/virtio_net.c        | 136 ++++++++++++++++++++++++++++++++++++----
 include/uapi/linux/virtio_net.h |   9 +++
 3 files changed, 151 insertions(+), 24 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20231218-v6-7-topic-virtio-net-ptp-3df023bc4f4d

Best regards,
-- 
Steffen Trumtrar <s.trumtrar@pengutronix.de>


