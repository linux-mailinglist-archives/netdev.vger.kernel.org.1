Return-Path: <netdev+bounces-278147-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNFfAiMp3WmVaQkAu9opvQ
	(envelope-from <netdev+bounces-278147-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:34:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A2E3F18B2
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECC6330BB43C
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888C234BA5B;
	Mon, 13 Apr 2026 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeuC76o+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A52A349AF3
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100304; cv=none; b=WSi6vX8F3dMPOn3YRypI5zev05XZ7DtNBW+NV1nso+AY6Bdb5xjW8q7IIR8tF3s1Cne7V6H9tHf/VpQR7ctZhnE2V2qHFTWx/VDQZ/pJFfYeA/KWcRTyAldO22GgE9J32ItdB6T7JUQs5hpTJ8w8tVbUIadiADz+bh9fJEaWOPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100304; c=relaxed/simple;
	bh=o09WtNxu5Zi8a0iPWHJi+lGKxIT2tfrnM7MeAojXDEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGmTcEYoZyUNTl74pBCPjmjp/B3Ru/e+i97Fc9SwKkm0m5vKrQMxZ8j6Qn3iT+6V/QxFIkS5RcIeALcsQ61HX4YRC0ijr6brUCbcXK1aFNRF2lXdG0qT8r73MJhwbjeCdpQ251iB3kSFVtXHBTwW9BPOHwtW0RBr14YW83TZnhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeuC76o+; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7dbec19732eso4308236a34.3
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776100302; x=1776705102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mg6drz+QVpKB5/V38R1gb2bDU9OtbCKCHb/PPel8U0=;
        b=VeuC76o+BvN/KLD8RkgwccgVUh69ySsdRZ2+T7glRh5Mujvx0F3nfyz0WJCTjMRXLv
         8/B6UJHcsXdbmQlkjiwtP9VoWAP9sQtrQnN/dXFD4/sajSo3Kr5fYAojJ9qA2bG8smCK
         oERP6kgMds0zUQWz1pLm+gss7fLC5DiAn07cPfEurkYZhkzzclEt2uPmprttL8fd7WEF
         LojvsHy67FVLhZ1Cae0ea+h3CFCf12oMeMukKVtbwzHCLVYTEgd4gac2VvgPKstxGFbX
         eoxp/fHt68KsqMcS10IktpCWkhd0CQGHPqJd5yXwjQ7wZTwHrUtuXVavYkvv16dq9nnr
         OgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776100302; x=1776705102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7mg6drz+QVpKB5/V38R1gb2bDU9OtbCKCHb/PPel8U0=;
        b=ByswS7hQtNbfF15cwaGX0rI/Ted4DxiPIpaGVmGIc0FQtCyyKxdrYXYZ1lX5jLp2np
         Vhrwiez74T3DezL5m5RnkEnVbdrD2sZwnwijerkZkQsJ5szafNdr+BOTNe2gOBdamjm7
         inqNxyujTzOwAMcVQFflLcpwI7oDbPvjtpo47TUfFNBRdx9FjflivAYytdY6wCHw+sAP
         pVO2ZBQlE90OBO1J1xy4kR1vaLDfL5rC2q4dcRKWD/+50WrHK5lxZSmW7uBoEN1fumQF
         JCj23fOFd5+3amvfc/WliIkOzh5ALShNZzMYb8X9aV2vrHoaqeG2LlRy0rjHwwu9pMw9
         Z0lg==
X-Gm-Message-State: AOJu0YxU8HalZKlx85JrlYCTH8QAb1ESp86iISkIeTv/yEHPWgg2jl2p
	susZBLKRah8KR7iZ0E+3TNw88zRB4PgQJVkXZKLNeYFNP7QJ0qVgxK76F5GjPGR3
X-Gm-Gg: AeBDieuRMMC+JxKV6tU5zoC1a9tz6ydJWKKZjEDFSls9uD7014X6inBq0fdf+Fh4RDR
	jfrUX8dZoUVx/4rUrXjnAVybL/FsaUoJbTvbmWIDHpt48nQMwX0cAdOKeHRwYstlvLwcdaktUJ7
	1lisD4b4v+cUEq+yySeoy/nb3RtWTL4s9G4q02zG6nopTludwKC/Rz0lqqfg53SC13Oss/FesUr
	1qRoOL4aSRwzVg8OHQzxUHxhoNvceYkgAovH5qQ/XUOZkG7MGibyUwkhDmqOsozjKL6lxB1z/BL
	TTHEkIc1uMY0aVDqXzqaut8qOrIeffCNZ9NqqTXsO5dWFzoCggLzAutVnkajFSOiavY+1LdarfM
	xW1Buryo0umkLLYz+VsfSvI090hAnJIQoTznroV3+JLQjACaUDZtx266B4N/5hgkEIsh+CDCehX
	oiFspMnC2k2wUvzC82
X-Received: by 2002:a05:6830:34a3:b0:7d7:d510:4bf9 with SMTP id 46e09a7af769-7dc27e160b2mr9293838a34.12.1776100301964;
        Mon, 13 Apr 2026 10:11:41 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:7::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc2660fd06sm8939344a34.11.2026.04.13.10.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 10:11:41 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v7 09/15] iavf: convert to ndo_set_rx_mode_async
Date: Mon, 13 Apr 2026 10:11:25 -0700
Message-ID: <20260413171131.550126-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413171131.550126-1-sdf@fomichev.me>
References: <20260413171131.550126-1-sdf@fomichev.me>
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
	TAGGED_FROM(0.00)[bounces-278147-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: 61A2E3F18B2
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


