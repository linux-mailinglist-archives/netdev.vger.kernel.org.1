Return-Path: <netdev+bounces-270455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP9CL/ASwWnVQQQAu9opvQ
	(envelope-from <netdev+bounces-270455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:16:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AA22EFD5D
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CB68300611D
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71A43876C7;
	Mon, 23 Mar 2026 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAEixcdk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7933736A023
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774260973; cv=none; b=VQGo6r28Z8v0U/9GjGOHADoSFcEnvnnhsQ+SWWfb5CsthlDiyEBXz7EaL9f90WJQOfxZlBhBkp/mMgjaXmYAwZbEg7yeO/htDYiYqQMO5ihv06tB9+k9Nfd7XNUI+5sA4QJ97ASH7mfZvceSH5qbSkcL93QrwjF1qSJeRsYV7DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774260973; c=relaxed/simple;
	bh=iJ85DA1JAGPOTovRJuHEycTXAZM42PEA30qXqkvPVwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uL9SCbGMR4hXWIR+AZPth8IiCXAGznx1zn+B8sVIA8RfOuQjr/+NARz1jRZ+OSlnahrQ3NZemEMh5yA08fElx4K9ZcKP/BtxQ3MNg0Q7yHMjY1vKYgYsFKFBgajaqoGCIgxOCoWZwjAO2MAFCbM0rbkDaQs3ouE37JVYRHZKt5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OAEixcdk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774260971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R1kpFgmjio88lonaduhh+r5O9wW+Z9HoaBGiKIQgUdw=;
	b=OAEixcdkJNweFQDVQP4DRFu2U8iiDbe9e/NwioCc86RfwgSKU0oZaxrT97Led2KCyNantJ
	RQZbcMMKOLBMYKg5OUQqgj7q+6nS+4t1/1si1YJSbSHhWNn20u0ZsttC22+scfBGu3eJHs
	iQYipYglAR8Detk9vZqHiYsb+6CmoZE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-wdN1LF3gNVqkea8eo8dASQ-1; Mon,
 23 Mar 2026 06:16:08 -0400
X-MC-Unique: wdN1LF3gNVqkea8eo8dASQ-1
X-Mimecast-MFC-AGG-ID: wdN1LF3gNVqkea8eo8dASQ_1774260966
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B866C19560AA;
	Mon, 23 Mar 2026 10:16:05 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.45.224.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 46FF81954102;
	Mon, 23 Mar 2026 10:16:01 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net v2] iavf: fix wrong VLAN mask for legacy Rx descriptors L2TAG2
Date: Mon, 23 Mar 2026 11:15:58 +0100
Message-ID: <20260323101558.1477593-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270455-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62AA22EFD5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The IAVF_RXD_LEGACY_L2TAG2_M mask was incorrectly defined as
GENMASK_ULL(63, 32), extracting 32 bits from qw2 instead of the
16-bit VLAN tag. In the legacy Rx descriptor layout, the 2nd L2TAG2
(VLAN tag) occupies bits 63:48 of qw2, not 63:32.

The oversized mask causes FIELD_GET to return a 32-bit value where the
actual VLAN tag sits in bits 31:16. When this value is passed to
iavf_receive_skb() as a u16 parameter, it gets truncated to the lower
16 bits (which contain the 1st L2TAG2, typically zero). As a result,
__vlan_hwaccel_put_tag() is never called and software VLAN interfaces
on VFs receive no traffic.

This affects VFs behind ice PF (VIRTCHNL VLAN v2) when the PF
advertises VLAN stripping into L2TAG2_2 and legacy descriptors are
used.

The flex descriptor path already uses the correct mask
(IAVF_RXD_FLEX_L2TAG2_2_M = GENMASK_ULL(63, 48)).

Reproducer:
 1. Create 2 VFs on ice PF (echo 2 > sriov_numvfs)
 2. Disable spoofchk on both VFs
 3. Move each VF into a separate network namespace
 4. On each VF: create VLAN interface (e.g. vlan 198), assign IP,
    bring up
 5. Set rx-vlan-offload OFF on both VFs
 6. Ping between VLAN interfaces -> expect PASS
    (VLAN tag stays in packet data, kernel matches in-band)
 7. Set rx-vlan-offload ON on both VFs
 8. Ping between VLAN interfaces -> expect FAIL if bug present
    (HW strips VLAN tag into descriptor L2TAG2 field, wrong mask
    extracts bits 47:32 instead of 63:48, truncated to u16 -> zero,
    __vlan_hwaccel_put_tag() never called, packet delivered to parent
    interface, not VLAN interface)

The reproducer requires legacy Rx descriptors. On modern ice + iavf
with full PTP support, flex descriptors are always negotiated and the
buggy legacy path is never reached. Flex descriptors require all of:
 - CONFIG_PTP_1588_CLOCK enabled
 - VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC granted by PF
 - PTP capabilities negotiated (VIRTCHNL_VF_CAP_PTP)
 - VIRTCHNL_1588_PTP_CAP_RX_TSTAMP supported
 - VIRTCHNL_RXDID_2_FLEX_SQ_NIC present in DDP profile

If any condition is not met, iavf_select_rx_desc_format() falls back
to legacy descriptors (RXDID=1) and the wrong L2TAG2 mask is hit.

Fixes: 2dc8e7c36d80 ("iavf: refactor iavf_clean_rx_irq to support legacy and flex descriptors")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v2: added reproducer steps and flex descriptor requirements to commit
    message (Paul)
---
 drivers/net/ethernet/intel/iavf/iavf_type.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_type.h b/drivers/net/ethernet/intel/iavf/iavf_type.h
index 1d8cf29cb65ac5..5bb1de1cfd33b1 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_type.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_type.h
@@ -277,7 +277,7 @@ struct iavf_rx_desc {
 /* L2 Tag 2 Presence */
 #define IAVF_RXD_LEGACY_L2TAG2P_M		BIT(0)
 /* Stripped S-TAG VLAN from the receive packet */
-#define IAVF_RXD_LEGACY_L2TAG2_M		GENMASK_ULL(63, 32)
+#define IAVF_RXD_LEGACY_L2TAG2_M		GENMASK_ULL(63, 48)
 /* Stripped S-TAG VLAN from the receive packet */
 #define IAVF_RXD_FLEX_L2TAG2_2_M		GENMASK_ULL(63, 48)
 /* The packet is a UDP tunneled packet */
-- 
2.52.0


