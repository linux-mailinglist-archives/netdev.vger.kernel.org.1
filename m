Return-Path: <netdev+bounces-271101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ0FHIKhwmm3fQQAu9opvQ
	(envelope-from <netdev+bounces-271101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:36:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E71A30A41E
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD382306E632
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDF73FF8AD;
	Tue, 24 Mar 2026 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CDEpGlWZ"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26CF3FE365
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774362933; cv=none; b=PqbrQp0Q9bmZLWmFFIqOqko/6C9C5gur2YaTsvURb0xE0EixMXoXokA+ik+u4m5GMSBRPQaNC97du2rhwkaPyWQo4LPTwpXN7zUjk645wa/VTrjSVfOV/6lFqPsosXe0oGgjiR4idKFPSZBURaToPjSCYWnQ2nJU2vUeAEIqk+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774362933; c=relaxed/simple;
	bh=/jljxnOLNg2AHRSw8dBEkP5R54o65pi8/FGgJD0ZF2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxYnJutSxJC/XVxFhSdPUzMrF4jZkcB5zN9vlO6215dY3xZszkm0IV71sXWZpbrdLRPYGtr0TCYGh1H1pskY6RI0xTG4b/L9ztoIHj89lyvYkQK4mo1l6pkH0K17uI4s1xhEELhxcmXKIkethDQyKidf99zFNTOWkEtuxfN7QE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CDEpGlWZ; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774362929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JsfdeQJgNjPfFiX1IeXG3ukvlqw4gMRgg97K1ZPW8yY=;
	b=CDEpGlWZ0m4kyF1QSKgZ8n1jRa5ZTq07EozDUTxEXw/mfly5OOyd7Y35bXCiwI/ejQvL6d
	adZC9V3kY/SQb91IGfH8o6NS94067/RXutS1dTVKURhgzuOy4xlDVibuutT97zM3mVIkn0
	g+6SDLMqfCS1Pf31kx9De30UGzSBGjo=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	fmaurer@redhat.com,
	liuhangbin@gmail.com,
	bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH net-next v1 2/4] net: hsr: fix VLAN add unwind on slave errors
Date: Tue, 24 Mar 2026 15:35:01 +0100
Message-ID: <20260324143503.187642-3-luka.gejak@linux.dev>
In-Reply-To: <20260324143503.187642-1-luka.gejak@linux.dev>
References: <20260324143503.187642-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,linutronix.de,vger.kernel.org,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271101-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 2E71A30A41E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

When vlan_vid_add() fails for a secondary slave, the error path calls
vlan_vid_del() on the failing port instead of the peer slave that had
already succeeded. This results in asymmetric VLAN state across the HSR
pair.

Fix this by ensuring the cleanup path targets the previously
programmed slave device when the second slave fails to add the VID.

Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 net/hsr/hsr_device.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 5c3eca2235ce..6185f9f2630f 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -534,6 +534,8 @@ static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
 {
 	bool is_slave_a_added = false;
 	bool is_slave_b_added = false;
+	struct net_device *slave_a_dev = NULL;
+	struct net_device *slave_b_dev = NULL;
 	struct hsr_port *port;
 	struct hsr_priv *hsr;
 	int ret = 0;
@@ -552,11 +554,12 @@ static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
 				/* clean up Slave-B */
 				netdev_err(dev, "add vid failed for Slave-A\n");
 				if (is_slave_b_added)
-					vlan_vid_del(port->dev, proto, vid);
+					vlan_vid_del(slave_b_dev, proto, vid);
 				return ret;
 			}
 
 			is_slave_a_added = true;
+			slave_a_dev = port->dev;
 			break;
 
 		case HSR_PT_SLAVE_B:
@@ -564,11 +567,12 @@ static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
 				/* clean up Slave-A */
 				netdev_err(dev, "add vid failed for Slave-B\n");
 				if (is_slave_a_added)
-					vlan_vid_del(port->dev, proto, vid);
+					vlan_vid_del(slave_a_dev, proto, vid);
 				return ret;
 			}
 
 			is_slave_b_added = true;
+			slave_b_dev = port->dev;
 			break;
 		default:
 			break;
-- 
2.53.0


