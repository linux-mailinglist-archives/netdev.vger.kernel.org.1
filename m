Return-Path: <netdev+bounces-277462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CO1JDAa2WnfmAgAu9opvQ
	(envelope-from <netdev+bounces-277462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:41:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 070553D987B
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 17:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43F9F302E7ED
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 15:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19F43D332F;
	Fri, 10 Apr 2026 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/Rq+v4x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1B93CFF7F
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835362; cv=none; b=XYDK2Nm2Qh4Gd0CvkWyyrr97rfSvpT98TJ2IazLeTpMEl28ViQTui1Wp0oSh2MKeaVEHl1dRyg6//1RMhK9pE4wFvLVRkI/Sag7XRNInQqP6Wzv2Mj1XS1HGLKo0XD40ZOJiWyE8BNrA8VR/f9MZ5Kco2WNmM1ZWbuYANVo9EVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835362; c=relaxed/simple;
	bh=4Bh7d/3GixBwoUaqRnW98B60FTug76WcCUBGyN9XulQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GRQRJ3d4VlZ2kHR7OlM9ATf5huqdXZ9WKZqoF6nK1VxwvwmuZEWWPjfqpWmVpNDEeUDnROmkgTfq36RWZN71uGh3Hq8eg58Vkez93jg82h05i9ZMxt8mrlD+DrkcLBUfwfo0JuZkpwa8i9Jk6NQ+ogphsTftlrbmRFvJg++KnBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/Rq+v4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90000C19424;
	Fri, 10 Apr 2026 15:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775835362;
	bh=4Bh7d/3GixBwoUaqRnW98B60FTug76WcCUBGyN9XulQ=;
	h=From:To:Cc:Subject:Date:From;
	b=b/Rq+v4xECW8ojgD5kpexZ6vwawgNQ9IbtxCdV2C9JUtB6oo9q34lUruJEJ3WUPL5
	 W9xwOU1IkDI+QokNvvFjNwHdHfQBlRXo6o/8Twvu4vKFF9r0hzDjCEQ48pux8MQWqt
	 md4AUbF0i2s3ybR8qCa3ceBNTGGMAI5PdoQHFOsQjXopWIfQfnm7Ag/IKcpMpLHymh
	 HJS/fDx/uMTTy0VxkoUmpJiox86zKypOY8Pmpu1RKtPALPziBZgV24+bMvwrzRGL2r
	 Wdsdvbqmuyn7WKAiRhInKXSR9vrWWz+BTGjg9cXCcSJqiFo6uPFaC6bw6l152tCaST
	 ziHT3TDmpsNEQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	dw@davidwei.uk,
	skhawaja@google.com,
	bestswngs@gmail.com,
	razor@blackwall.org,
	daniel@iogearbox.net
Subject: [PATCH net-next] net: fix reference tracker mismanagement in netdev_put_lock()
Date: Fri, 10 Apr 2026 08:36:00 -0700
Message-ID: <20260410153600.1984522-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,davidwei.uk,gmail.com,blackwall.org,iogearbox.net];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-277462-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iogearbox.net:email,davidwei.uk:email,blackwall.org:email]
X-Rspamd-Queue-Id: 070553D987B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dev_put() releases a reference which didn't have a tracker.
References without a tracker are accounted in the tracking
code as "no_tracker". We can't free the tracker and then
call dev_put(). The references themselves will be fine
but the tracking code will think it's a double-release:

  refcount_t: decrement hit 0; leaking memory.

IOW commit under fixes confused dev_put() (release never tracked
reference) with __dev_put() (just release the reference, skipping
the reference tracking infra).

Since __netdev_put_lock() uses dev_put() we can't feed a previously
tracked netdev ref into it. Let's flip things around.
netdev_put(dev, NULL) is the same as dev_put(dev) so make
netdev_put_lock() the real function and have __netdev_put_lock()
feed it a NULL tracker for all the cases that were untracked.

Fixes: d04686d9bc86 ("net: Implement netdev_nl_queue_create_doit")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: dw@davidwei.uk
CC: skhawaja@google.com
CC: bestswngs@gmail.com
CC: razor@blackwall.org
CC: daniel@iogearbox.net
---
 net/core/dev.h |  8 +++++++-
 net/core/dev.c | 16 +++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/core/dev.h b/net/core/dev.h
index 376bac4a82da..628bdaebf0ca 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -31,9 +31,15 @@ struct napi_struct *
 netdev_napi_by_id_lock(struct net *net, unsigned int napi_id);
 struct net_device *dev_get_by_napi_id(unsigned int napi_id);
 
-struct net_device *__netdev_put_lock(struct net_device *dev, struct net *net);
 struct net_device *netdev_put_lock(struct net_device *dev, struct net *net,
 				   netdevice_tracker *tracker);
+
+static inline struct net_device *
+__netdev_put_lock(struct net_device *dev, struct net *net)
+{
+	return netdev_put_lock(dev, net, NULL);
+}
+
 struct net_device *
 netdev_xa_find_lock(struct net *net, struct net_device *dev,
 		    unsigned long *index);
diff --git a/net/core/dev.c b/net/core/dev.c
index e7bc95cbd1fa..4a82983e8616 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1060,16 +1060,18 @@ struct net_device *dev_get_by_napi_id(unsigned int napi_id)
  * This helper is intended for locking net_device after it has been looked up
  * using a lockless lookup helper. Lock prevents the instance from going away.
  */
-struct net_device *__netdev_put_lock(struct net_device *dev, struct net *net)
+struct net_device *
+netdev_put_lock(struct net_device *dev, struct net *net,
+		netdevice_tracker *tracker)
 {
 	netdev_lock(dev);
 	if (dev->reg_state > NETREG_REGISTERED ||
 	    dev->moving_ns || !net_eq(dev_net(dev), net)) {
 		netdev_unlock(dev);
-		dev_put(dev);
+		netdev_put(dev, tracker);
 		return NULL;
 	}
-	dev_put(dev);
+	netdev_put(dev, tracker);
 	return dev;
 }
 
@@ -1121,14 +1123,6 @@ netdev_get_by_index_lock_ops_compat(struct net *net, int ifindex)
 	return __netdev_put_lock_ops_compat(dev, net);
 }
 
-struct net_device *
-netdev_put_lock(struct net_device *dev, struct net *net,
-		netdevice_tracker *tracker)
-{
-	netdev_tracker_free(dev, tracker);
-	return __netdev_put_lock(dev, net);
-}
-
 struct net_device *
 netdev_xa_find_lock(struct net *net, struct net_device *dev,
 		    unsigned long *index)
-- 
2.53.0


