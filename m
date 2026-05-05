Return-Path: <netdev+bounces-284383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLd2CK3q+WkLFQMAu9opvQ
	(envelope-from <netdev+bounces-284383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:03:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BD14CE1EF
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BEB96306CDB6
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 12:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEBA43C079;
	Tue,  5 May 2026 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5/k1qMH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7EE43C058
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985486; cv=none; b=pyzkjbses6WO00slV19bnZeVScccML1yrHgLVcGGUGOtmLsd49ied3cqvQhrTzTkXobLA/m1yeHJV+MAowPDBsQCPknzIWm4JfDnfthEGR05F0ESF3L1/Wr+dpwFiSTmOVDKIZfDasvbc3naEykEhjzv9nGYKT0VxNUgsylo4x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985486; c=relaxed/simple;
	bh=+gwFIFStVkuWTBdiFxJ+lTruD2IPMsw2PE3zAIXb89Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BzFeWbiljNhEIdhXYQQfheMIK5KiuDveyZXZcEFpK0jDD9ardoxmd60WEg67t4cQvKZRP39gCjpaI830Aiz8EUjDN72zwrNZi/YGDI39e9aLvgMveP6kb47Ckprg+/srIKv+7AK91XLFv86O8fK0ZK+Cvzz5sOZ8gWk6YrJoIi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5/k1qMH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777985484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5gCXSEYEFFiXV2aitnRBv60G+WOwVgrtKEBYklKh8rs=;
	b=V5/k1qMH0wOgb9QLPL36azYaUNNWA5VB4KKCRBwb2aEu/p7MumsiX0rzE3zuYDc/hMruMB
	LuLfN5YE0eBq5kmHFW16ACOI01ZlVC0FCEV8GE/Lr1jgEm3WMIscR2YUXnEO1JUT8gpZJe
	2lgpLDP7HFnpomn+exYnGHX56Qal/l8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-TLuPElacP1GjBmZ2M8C3eQ-1; Tue,
 05 May 2026 08:51:18 -0400
X-MC-Unique: TLuPElacP1GjBmZ2M8C3eQ-1
X-Mimecast-MFC-AGG-ID: TLuPElacP1GjBmZ2M8C3eQ_1777985476
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63FA51800347;
	Tue,  5 May 2026 12:51:16 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.49.137])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C161030001A1;
	Tue,  5 May 2026 12:51:11 +0000 (UTC)
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
	Simon Horman <horms@kernel.org>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net v2] ice: fix missing priority callbacks for U.FL DPLL pins
Date: Tue,  5 May 2026 14:51:08 +0200
Message-ID: <20260505125108.2019998-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 18BD14CE1EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284383-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mpg.de:email]

The U.FL2 input pin advertises DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE
in its capability mask, but ice_dpll_pin_ufl_ops does not provide
.prio_get and .prio_set callbacks. As a result the DPLL subsystem
cannot report or accept priority for U.FL pins: pin-get omits the prio
field on U.FL2 and pin-set with prio is rejected as invalid, even
though the capability is present. This prevents user space from using
priority to select or disable U.FL2 as a DPLL input source.

Reproducer with iproute2 (dpll command):

  # dpll pin show board-label U.FL2
  pin id 16:
    module-name ice
    board-label U.FL2
    type ext
    capabilities priority-can-change|state-can-change
    parent-device:
      id 0 direction input state selectable phase-offset 0
    /* note: no "prio" between "direction" and "state",
       even though priority-can-change is advertised */

  # dpll pin set id 16 parent-device 0 prio 5
  RTNETLINK answers: Operation not supported

After the fix the prio field is reported by pin show and pin set with
prio is accepted on U.FL2.

Add the missing .prio_get and .prio_set callbacks to
ice_dpll_pin_ufl_ops, reusing ice_dpll_sw_input_prio_{get,set}. The
same ops struct is shared by U.FL1 and U.FL2: U.FL2 (input) delegates
to the backing hardware input pin, while U.FL1 (output) does not
advertise DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE so the dpll core
capability gate never invokes prio_set for it, and prio_get reports
the OUTPUT sentinel (ICE_DPLL_PIN_PRIO_OUTPUT) on the output side
exactly like the SMA path does today.

Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Petr Oros <poros@redhat.com>
---
v2:
- describe the userspace reproducer (dpll pin show / dpll pin set)
  in the commit message, suggested by Paul Menzel
- collect Reviewed-by tags from v1

v1: https://lore.kernel.org/all/20260504121603.1702674-1-poros@redhat.com/
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 27b460926baced..be72a076f7a15c 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -2628,6 +2628,8 @@ static const struct dpll_pin_ops ice_dpll_pin_ufl_ops = {
 	.state_on_dpll_set = ice_dpll_ufl_pin_state_set,
 	.state_on_dpll_get = ice_dpll_sw_pin_state_get,
 	.direction_get = ice_dpll_pin_sw_direction_get,
+	.prio_get = ice_dpll_sw_input_prio_get,
+	.prio_set = ice_dpll_sw_input_prio_set,
 	.frequency_get = ice_dpll_sw_pin_frequency_get,
 	.frequency_set = ice_dpll_sw_pin_frequency_set,
 	.esync_set = ice_dpll_sw_esync_set,
-- 
2.53.0


