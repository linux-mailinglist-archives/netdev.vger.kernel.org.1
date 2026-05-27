Return-Path: <netdev+bounces-292309-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMkjKH/4FmrUywcAu9opvQ
	(envelope-from <netdev+bounces-292309-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:58:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 486725E5713
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A0573038F5E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 13:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4E7421F1B;
	Wed, 27 May 2026 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Za8sVtpN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9090E4218AE;
	Wed, 27 May 2026 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890076; cv=none; b=itp/GUpyZEjF7MkiZh5olf96wZp9mI+th0KR2Y/VRY0Jj+1fylf4W1+gUOV5/Lcwkm3S2mdsHSSeelC5ByhTajldfgU3Z7kELi8SzHLm0v7IYkLf2OxTf/qGsnix4fz5Ua54qz289twF08dvDBTvOuvEQ66+uY5ltkTMGyNReq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890076; c=relaxed/simple;
	bh=fK1nAKr7+30b/vQc2CBpGjbhUC9xsssoUNWmQ8uQrQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ewuu1O7gnM9afQDsg0X7C1GJp9izewr5ih3y3xxgz89xrPp2afCkO7DzxXPb8cmGQ2+9owuPI2QcrjORwKroAVfxfG5DMhkOcUTWoiT+Ls7eWxuu9UwSZ3AWUA4fL6mOpQLDH4pPmp1bT7XVE78DOwkawywqPrP2GqBm2dZEAp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Za8sVtpN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A761F00A3D;
	Wed, 27 May 2026 13:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779890074;
	bh=0gmJLrBDFO3dtJ/TE0yy5dxjGSaWCHkjmIKTQNev58I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Za8sVtpNxG5G6vgwKJ5EJLV88z12rO+NegxjWMFchH1Ni5Lq1/UK/ziiHz5y34RSU
	 bCFt9N5y5+r4Req+mDBxjWrpCsRhUX/ckcs+ZaZ1oM7fJoOBr49EoY96qLl1R63ClO
	 VmtBifMYtwA+zMUcj19KRtCTPiCD5Twib8HvdV2Yzou0WHadTG27Pv9jIL4GleSGP7
	 xuekMK50bHEVn9pjl2WxLxuDNV0lw07W32CI4NO+wVwDMQl25ouqets22dcmOln74C
	 sPl2rnUXJhfZHyq5nKV1Z+rJEpoBfz9mFrdx+TeJrGcmvUVXZ3M2PNhwX5Ot5J0Vhl
	 ZQcyem5uTpuWw==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Christian Brauner <brauner@kernel.org>,
	Krishna Kumar <krikku@gmail.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 1/5] net: add dev->bql flag to allow BQL sysfs for IFF_NO_QUEUE devices
Date: Wed, 27 May 2026 15:54:12 +0200
Message-ID: <20260527135418.1166665-2-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527135418.1166665-1-hawk@kernel.org>
References: <20260527135418.1166665-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-292309-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,tu-berlin.de,lunn.ch,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,fomichev.me,gmail.com,linux.dev,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tu-berlin.de:email]
X-Rspamd-Queue-Id: 486725E5713
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jesper Dangaard Brouer <hawk@kernel.org>

Virtual devices with IFF_NO_QUEUE or lltx are excluded from BQL sysfs
by netdev_uses_bql(), since they traditionally lack real hardware
queues. However, some virtual devices like veth implement a real
ptr_ring FIFO with NAPI processing and benefit from BQL to limit
in-flight bytes and reduce latency.

Add a per-device 'bql' bitfield boolean in the priv_flags_slow section
of struct net_device. When set, it overrides the IFF_NO_QUEUE/lltx
exclusion and exposes BQL sysfs entries (/sys/class/net/<dev>/queues/
tx-<n>/byte_queue_limits/). The flag is still gated on CONFIG_BQL.

This allows drivers that use BQL despite being IFF_NO_QUEUE to opt in
to sysfs visibility for monitoring and debugging.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
Tested-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
---
 Documentation/networking/net_cachelines/net_device.rst | 1 +
 include/linux/netdevice.h                              | 2 ++
 net/core/net-sysfs.c                                   | 8 +++++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 7b3392553fd6..62df1e09656b 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -170,6 +170,7 @@ unsigned_long:1                     see_all_hwtstamp_requests
 unsigned_long:1                     change_proto_down
 unsigned_long:1                     netns_immutable
 unsigned_long:1                     fcoe_mtu
+unsigned_long:1                     bql                                                                 netdev_uses_bql(net-sysfs.c)
 struct list_head                    net_notifier_list
 struct macsec_ops*                  macsec_ops
 struct udp_tunnel_nic_info*         udp_tunnel_nic_info
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index bf3dd9b2c1a7..6b02e82d9625 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2077,6 +2077,7 @@ enum netdev_reg_state {
  *	@change_proto_down: device supports setting carrier via IFLA_PROTO_DOWN
  *	@netns_immutable: interface can't change network namespaces
  *	@fcoe_mtu:	device supports maximum FCoE MTU, 2158 bytes
+ *	@bql:		device uses BQL (DQL sysfs) despite having IFF_NO_QUEUE
  *
  *	@net_notifier_list:	List of per-net netdev notifier block
  *				that follow this device when it is moved
@@ -2491,6 +2492,7 @@ struct net_device {
 	unsigned long		change_proto_down:1;
 	unsigned long		netns_immutable:1;
 	unsigned long		fcoe_mtu:1;
+	unsigned long		bql:1;
 
 	struct list_head	net_notifier_list;
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 3318b5666e43..82833e5dae03 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1945,10 +1945,16 @@ static const struct kobj_type netdev_queue_ktype = {
 
 static bool netdev_uses_bql(const struct net_device *dev)
 {
+	if (!IS_ENABLED(CONFIG_BQL))
+		return false;
+
+	if (dev->bql)
+		return true;
+
 	if (dev->lltx || (dev->priv_flags & IFF_NO_QUEUE))
 		return false;
 
-	return IS_ENABLED(CONFIG_BQL);
+	return true;
 }
 
 static int netdev_queue_add_kobject(struct net_device *dev, int index)
-- 
2.43.0


