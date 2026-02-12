Return-Path: <netdev+bounces-258416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI0zHiiHjWkZ3wAAu9opvQ
	(envelope-from <netdev+bounces-258416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 08:54:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B2D12B0B8
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 08:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC775315BDA6
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 07:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAECB28CF66;
	Thu, 12 Feb 2026 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwzYWy6B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD3B42A96
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770882812; cv=none; b=EWpB0TvDttfNApXDaZHL/qRTDylUwc2+ycupZsDxkSQbeOrcJKbL4qo2pY25SOR29fPyYAhN5hlcrg9wrVTGEW8wwNmAaXb7zUFCS9EYF6O59Wsf0TdYkUhH2NwxFfnU67EX4r83Iw/U86d8mdyAsOSapRNIu8Mat7/2i2YJ1bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770882812; c=relaxed/simple;
	bh=GvQnxXNeWahoRp5JUqw3arKlLbqhbzq091ctHZRucIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9bcNjEtfVPx/2juwRcYgxspZGixv5NBakJ2qhtQ30fTww4kbrrQow08dp44i5GErVuzW7Vd5WKQw9+MCOZlLFG5AYU6I5JVeIqkpyx8HGjnKREP3WZilzuvFHHtEzCwKrg17qQVX/qt0ELcU71csHVROV4bkv1eB2BPd2ANnA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TwzYWy6B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770882810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ut8Fsw1R4tT50gfU2dQi99Xi0AipmBKvrl6DGwx0NTU=;
	b=TwzYWy6Bad6QGZMRrLCWtJw37c4AcZnQwwIW+Ki1ElP0W9yISa4LuJt4hcKAtBvoIlTYYF
	puzAEcbPTD2xFCPkIr588ByXrsD8jQs7zVHU20Qrg1F+2UcDptI4DnDnPGa4N0va3yadX+
	JiWOL6Az1PKKaD65An9PJLtNczMiLeY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-g6NO0SaEPuKom6REr-TJUA-1; Thu,
 12 Feb 2026 02:53:27 -0500
X-MC-Unique: g6NO0SaEPuKom6REr-TJUA-1
X-Mimecast-MFC-AGG-ID: g6NO0SaEPuKom6REr-TJUA_1770882805
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2DE118003F5;
	Thu, 12 Feb 2026 07:53:24 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.184])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B34A1956095;
	Thu, 12 Feb 2026 07:53:19 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net 1/2] ice: fix inverted ready check for VF representors
Date: Thu, 12 Feb 2026 08:53:10 +0100
Message-ID: <a76096058dd9b6d0cccaa5c2c699458351d02cec.1770882260.git.poros@redhat.com>
In-Reply-To: <cover.1770882260.git.poros@redhat.com>
References: <cover.1770882260.git.poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258416-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2B2D12B0B8
X-Rspamd-Action: no action

Commit 0f00a897c9fcbd ("ice: check if SF is ready in ethtool ops")
refactored the VF readiness check into a generic repr->ops.ready()
callback but implemented ice_repr_ready_vf() with inverted logic:

  return !ice_check_vf_ready_for_cfg(repr->vf);

ice_check_vf_ready_for_cfg() returns 0 on success, so the negation
makes ready() return non-zero when the VF is ready. All callers treat
non-zero as "not ready, skip", causing ndo_get_stats64, get_drvinfo,
get_strings and get_ethtool_stats to always bail out in switchdev mode.

Remove the erroneous negation. The SF variant ice_repr_ready_sf() is
already correct (returns !active, i.e. non-zero when not active).

Fixes: 0f00a897c9fcbd ("ice: check if SF is ready in ethtool ops")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_repr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index cb08746556a670..2a84f656405828 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -315,7 +315,7 @@ ice_repr_reg_netdev(struct net_device *netdev, const struct net_device_ops *ops)
 
 static int ice_repr_ready_vf(struct ice_repr *repr)
 {
-	return !ice_check_vf_ready_for_cfg(repr->vf);
+	return ice_check_vf_ready_for_cfg(repr->vf);
 }
 
 static int ice_repr_ready_sf(struct ice_repr *repr)
-- 
2.52.0


