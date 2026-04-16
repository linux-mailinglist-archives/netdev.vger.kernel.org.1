Return-Path: <netdev+bounces-279123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IF+Jogx4WlGqQAAu9opvQ
	(envelope-from <netdev+bounces-279123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:59:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7675413EE5
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0640C30F84FD
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C9B34AB17;
	Thu, 16 Apr 2026 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqJs241V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2813491C9
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365845; cv=none; b=Uf21j252UzU5bnD6m5ESybplBNrRB5etAUt49n9KYIhzwaJDZi+ItUbwZ14b8+VeSFNbWg8BGKMByu167QEZsC1F0f4qXNiQ6r1Pll22eZOzwc7La+cg8H5obKOrly7KmFrDU5m6j9OJErQuqSPeTLsmpldibQhK8VBLmISnieY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365845; c=relaxed/simple;
	bh=o09WtNxu5Zi8a0iPWHJi+lGKxIT2tfrnM7MeAojXDEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPFQ3Pw+A7txpIe/PAzDqv8PSJCZB1cwrXoaDqlC/1kzo04WA9TzdzriAEhYx1jmHQZh18Oq3g371w9Dwakh2AoBTHNrXWeeH9toQLQ9jXaI6wHAt4AN0Lj9mCmEYaAPMTIMY91LDEVD2zkJL6ISbnDhUik6BdIUBzsrF8No49w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqJs241V; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7dbcd92eda5so6046518a34.2
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776365843; x=1776970643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mg6drz+QVpKB5/V38R1gb2bDU9OtbCKCHb/PPel8U0=;
        b=dqJs241Vq2tYL1GnQnjtM3i16Y0coSD7vTPJtmsOidAvv9DH7zVyTzECGKNBiHvREO
         06ZXW3QaMkf+ImIYHdxBZtdMmaWtfDwM8b7sHJ1yn2SPIBgnWJonD3rHZEY/d/p2K5ZB
         ZilXQIjtERcH92vT+9cDDdu/mz6Tuw3k2PuUPUrrCNlIrYB5QqXBkiw90Ov5/fknoQdU
         aEhnDrc/uu7ll1ZfQYRfuh9B9EfyJaEZfuA+/1h/AWGMhg3Qi0HPeDmQ8ygEPJKf8hbA
         zLp6iB21jnAg0j6ZM+QvjYVWxsR7ti/yxnIovz91mu4/ufYJ3GtLjKS68NhH+50WOhW9
         t5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776365843; x=1776970643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7mg6drz+QVpKB5/V38R1gb2bDU9OtbCKCHb/PPel8U0=;
        b=M25sp/PLjgZ1tlR9kLYa6KXEZvM8K234fYbcNYQE9R8z78IyjfGfgxpNp6Eyl2Aqct
         sCekNxUbcSy+sxddUsaqjkBAOGXsKMbu7lR2eHHv4CcHNKqFnF4p6+lZSU/G27dkxzbN
         DNCEHz+SoG6g9TWmzoqH9WT/3+fkzdi+Jj54ViIKKIQlPeu+jJtvTcP7xaMxeBvKjCbr
         CEeQnAiAHCdR6zILaVKluNMRlbJC15/tMV+XQJCjp+4udcFqMqUAEz+nMu67dr8yRDwH
         tgM4dvZ3AcRR9h+waYgPEpw/nnYSYDQY+xXQo3ynXv4Ryk5sU1iB1Lv4ZX7lg4cqzc6Y
         vPqA==
X-Gm-Message-State: AOJu0YwBwHsWy/Q4kJ9q0DA8ohwB3XcZL0IZETTaUUvGvIIHKj3PSlur
	9WvZczaJ0I8Mt0xrBR1CL7eY3O3kCXjS5vrq5QZEWpnVL1JMKW4g4wol9lE8tfqu
X-Gm-Gg: AeBDievMYBVLA8h/pCEiS1W0JDA7QIO7lx56r7mYIg7+27BfwU+fvgEXxYPomF55+c2
	lgaDI/lZPYTl4qk53L7Ebd6vAG022oD8yWkoivuj5q4j6mPP2iMyjpzl7OZYMHu1YB3peMWBFFa
	vRxnrPgWCwJAMJZ+roO7dRzy8+uotm8bVrMePgMdoPxnA0SicqlKjl+6Mpgs3qLwUAUWwan53j6
	Spbb23wGYJVrhIRwQno4kr6R1mb6cLGp1WD9PcwCsbAxhZ7mOihKiPQxjpg3QFY8eMLiaguY02c
	9n0d7OKxEA3/Sog7lbbvepqO+oIJAHTg6/rTR2PffNX2Dy/KqL4TjIEjCt6ZxNWKLaUpWLKJQ52
	pQZcrvdrfUYqeKUEFNcwfql+cMWHjnRJfPp+hnLwZ3ZFEbD4d/Dk2t+2SbHFDTEWRDdxbtgSi2L
	WP2iU5PAyDCjo4wRITfQgKtFCFN+zk
X-Received: by 2002:a05:6820:1993:b0:681:4d35:3fa4 with SMTP id 006d021491bc7-69461a9219cmr231682eaf.21.1776365842974;
        Thu, 16 Apr 2026 11:57:22 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:74::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42666bcb7afsm4563033fac.7.2026.04.16.11.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:57:22 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v8 09/15] iavf: convert to ndo_set_rx_mode_async
Date: Thu, 16 Apr 2026 11:57:06 -0700
Message-ID: <20260416185712.2155425-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260416185712.2155425-1-sdf@fomichev.me>
References: <20260416185712.2155425-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279123-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:mid,fomichev.me:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7675413EE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert iavf from ndo_set_rx_mode to ndo_set_rx_mode_async.
iavf_set_rx_mode now takes explicit uc/mc list parameters and
uses __hw_addr_sync_dev on the snapshots instead of __dev_uc_sync
and __dev_mc_sync.

The iavf_configure internal caller passes the real lists directly.

Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index dad001abc908..3c1465cf0515 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1150,14 +1150,18 @@ bool iavf_promiscuous_mode_changed(struct iavf_adapter *adapter)
 /**
  * iavf_set_rx_mode - NDO callback to set the netdev filters
  * @netdev: network interface device structure
+ * @uc: snapshot of uc address list
+ * @mc: snapshot of mc address list
  **/
-static void iavf_set_rx_mode(struct net_device *netdev)
+static void iavf_set_rx_mode(struct net_device *netdev,
+			     struct netdev_hw_addr_list *uc,
+			     struct netdev_hw_addr_list *mc)
 {
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
-	__dev_uc_sync(netdev, iavf_addr_sync, iavf_addr_unsync);
-	__dev_mc_sync(netdev, iavf_addr_sync, iavf_addr_unsync);
+	__hw_addr_sync_dev(uc, netdev, iavf_addr_sync, iavf_addr_unsync);
+	__hw_addr_sync_dev(mc, netdev, iavf_addr_sync, iavf_addr_unsync);
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
 	spin_lock_bh(&adapter->current_netdev_promisc_flags_lock);
@@ -1210,7 +1214,9 @@ static void iavf_configure(struct iavf_adapter *adapter)
 	struct net_device *netdev = adapter->netdev;
 	int i;
 
-	iavf_set_rx_mode(netdev);
+	netif_addr_lock_bh(netdev);
+	iavf_set_rx_mode(netdev, &netdev->uc, &netdev->mc);
+	netif_addr_unlock_bh(netdev);
 
 	iavf_configure_tx(adapter);
 	iavf_configure_rx(adapter);
@@ -5153,7 +5159,7 @@ static const struct net_device_ops iavf_netdev_ops = {
 	.ndo_open		= iavf_open,
 	.ndo_stop		= iavf_close,
 	.ndo_start_xmit		= iavf_xmit_frame,
-	.ndo_set_rx_mode	= iavf_set_rx_mode,
+	.ndo_set_rx_mode_async	= iavf_set_rx_mode,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address	= iavf_set_mac,
 	.ndo_change_mtu		= iavf_change_mtu,
-- 
2.52.0


