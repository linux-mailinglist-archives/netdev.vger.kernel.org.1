Return-Path: <netdev+bounces-268693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAecDI+QuWk5KQIAu9opvQ
	(envelope-from <netdev+bounces-268693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 18:34:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C30562AFCC8
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 18:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBA7932A7CE1
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FE13F65E2;
	Tue, 17 Mar 2026 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMU3P94N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AThsAt3P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46FC30CDA2
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767311; cv=none; b=KiFBLD59BAyj0LOnVttYtEa7Bd6VyFXCLvbd0zdS0MQWk6fCnkaPrkiqyTAgFtoc8pER1++mnVcDJ8DZYh80ywrZ+zMFej70i7fLgNfNDKAhWDGTExSS6bBFF7sa0e9j2AVjIx0uS06aTMQzSa6+VLwCmO4TrEWJZzIkVEKE9v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767311; c=relaxed/simple;
	bh=Cl18mNxUP5/bRBVZCuzVj9R40Tfgfrhg5fIB2SMj7HU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PAUL+dKPiEG5z28SFi2J8WaF8TJBaJu3dQc+yDtGVedfN7q+twyO56bSLuRJbQg6EbkdcACExCKFqLxykjKPKsi0Hy9BanzyEOEYhPH1+PmGq+sdgtwfr9nkyb2/51MwkRUjixXwbqeAhJQ3O1j2RV5RhoGnoRbcdTI9WMC29AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eMU3P94N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AThsAt3P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773767308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oJBO5JTzkZ/XCNG2Npc9UYXPxYusEGLvMeFVyAlhea4=;
	b=eMU3P94Nxe6JUH3SNSn+oym6FuhNImyMNQan7v6uv2I9qshYURS4gSaB59COm76XcV8cPJ
	zySganA4G5ZN00RNnZaHR28m7aXEaWZcCS8mV45LlqSW+Bw0UeN8eI8X3P79Io/QyI2Uj8
	lYagZmsd5PEH3AvKhXBgjJE5kQljM1c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-MqEqub3DOCSJIAoQxu-gHA-1; Tue, 17 Mar 2026 13:08:27 -0400
X-MC-Unique: MqEqub3DOCSJIAoQxu-gHA-1
X-Mimecast-MFC-AGG-ID: MqEqub3DOCSJIAoQxu-gHA_1773767306
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so44947905e9.3
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773767306; x=1774372106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oJBO5JTzkZ/XCNG2Npc9UYXPxYusEGLvMeFVyAlhea4=;
        b=AThsAt3PFEo8i1VGYKOKLWibRBGIsZjTnKhMD6cITlE+zAtDmWiPf9pbq51Ft+ut+d
         VJY3JnAtvJDWCVRSMYNV2l53M3Mp5rVNUkINr2S45j99wFwGETTyF2mt8UzNkot7BOtq
         JJ0Doe8anfq9jizFtSJZ7DJ2Ds+dlUcMxeYgL+4C9TQeOcvv+qdqbAQ/uLfOHVprJ7ps
         /2l08zP5ee4U/xUaq4gsAh3S3eiXrwI5LhzZUjw3LTlahVg4xFDgwpMS1Mty1otfOgQJ
         yXX7z6UTmMKzskIC6Zf5xp1xGUXPzRnfahAhaCCfqgwpRyc/J6Dfz1SPXlSvCzkpfqRU
         xYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773767306; x=1774372106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJBO5JTzkZ/XCNG2Npc9UYXPxYusEGLvMeFVyAlhea4=;
        b=k0eNDmT1+/Z0Z2Sk+2Nisz8DtLOKYcVdybZPrLhxNzqlaiulRrGYMRKJo7bm4DVVOt
         HYUTeWIsaQRTjjNbghKkid54WNLsEV9pjCsGjjioMoP8cQAKXJK/q3SAZBFqif2wuZ8O
         hfk0jlKvmCfOlL7l8rsbBw+CtruanhUuemuc7Dhx7SaDklLIdLPlW8s29MAFrwYLnpl7
         siB/D2pCIUs9X0lJXe1uNS/8RlSr5d7giLTON4XSnt7jguReT0Xk5GT3hp4u1Ob2sBb8
         2A5xKrNyhtS5JS7HREXxui18a1tFPWLb1ypOIoHZSeFewtpGsUT6LRZ8C6E28x7Ak4qm
         ZYzw==
X-Gm-Message-State: AOJu0Yy5PqCM4/6zQDtpdwJ8ULbJGmtf/6TWiOXH2Fz4f4aRhqHKrqbs
	CBxpbRv+R+OXhKDYk4XF7xRP8fA67qtqukfcQDXuHkAwbtm2wDftBo7H4xtDM/wJ2Wo5N507tGY
	MMAL1GS7PTtWZK7b4mw0j6jkmb34x/8NdOG7RCllvAYzjQV4NA2YKqc9iEbQR8Lwtu2CbVjXQdj
	UCVX4pc2Ow2D1iEKVnmZvwJ+TYRfClL/1mtkQDTOwO
X-Gm-Gg: ATEYQzysLVF+wU/CezvcHLbDhgUcjIHVyf9QqA58dR4JxjMp44R5zOQ1AzCVLYrcs74
	91JjmHXcwaAaYkqibk2WBdCBGEZ6W3v75OmeeyHBhx3zTudYuBEdeercotQEBU61ye7NeUQI6nP
	ahCSsunypifHZ07fuYqONClP/iQsVyyDxpIAdUfCzfBQdMTP9eQCHqjarn4h03Skx2mN8l4TH7u
	VPeN3lwAfkGQtlrgWvLtKcrvceEyICCGxIbwpA58nS0C2coqmesVvv1gw9AQBCO7rA93sjVh5R4
	3McrG8kJQF3F8ARkksS5lRFA76rTD8sXCvPERj5gAec/+BZNvRz9whSkpwu88JcpjhNW9mqdc/G
	G4mLu1pqEHuRd/ysot0S3BuDSUMpF+E16Pw==
X-Received: by 2002:a05:600c:6995:b0:483:badb:618b with SMTP id 5b1f17b1804b1-486f4463574mr4540485e9.24.1773767305764;
        Tue, 17 Mar 2026 10:08:25 -0700 (PDT)
X-Received: by 2002:a05:600c:6995:b0:483:badb:618b with SMTP id 5b1f17b1804b1-486f4463574mr4539945e9.24.1773767305277;
        Tue, 17 Mar 2026 10:08:25 -0700 (PDT)
Received: from fedora.redhat.com ([216.128.14.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f45d7068sm2881345e9.1.2026.03.17.10.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 10:08:24 -0700 (PDT)
From: mheib@redhat.com
To: netdev@vger.kernel.org
Cc: mohamed@pensando.io,
	brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sln@onemain.com,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH net] ionic: fix persistent MAC address override on PF
Date: Tue, 17 Mar 2026 19:08:06 +0200
Message-ID: <20260317170806.35390-1-mheib@redhat.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-268693-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mheib@redhat.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C30562AFCC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mohammad Heib <mheib@redhat.com>

The use of IONIC_CMD_LIF_SETATTR in the MAC address update path causes
the ionic firmware to update the LIF's identity in its persistent state.
Since the firmware state is maintained across host warm boots and driver
reloads, any MAC change on the Physical Function (PF) becomes "sticky.

This is problematic because it causes ethtool -P to report the
user-configured MAC as the permanent factory address, which breaks
system management tools that rely on a stable hardware identity.

While Virtual Functions (VFs) need this hardware-level programming to
properly handle MAC assignments in guest environments, the PF should
maintain standard transient behavior. This patch gates the
ionic_program_mac call using is_virtfn so that PF MAC changes remain
local to the netdev filters and do not overwrite the firmware's
permanent identity block.

Fixes: 19058be7c48c ("ionic: VF initial random MAC address if no assigned mac")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 8d040e611d5a..637e635bbf03 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -1719,13 +1719,18 @@ static int ionic_set_mac_address(struct net_device *netdev, void *sa)
 	if (ether_addr_equal(netdev->dev_addr, mac))
 		return 0;
 
-	err = ionic_program_mac(lif, mac);
-	if (err < 0)
-		return err;
+	/* Only program macs for virtual functions to avoid losing the permanent
+	 * Mac across warm reset/reboot.
+	 */
+	if (lif->ionic->pdev->is_virtfn) {
+		err = ionic_program_mac(lif, mac);
+		if (err < 0)
+			return err;
 
-	if (err > 0)
-		netdev_dbg(netdev, "%s: SET and GET ATTR Mac are not equal-due to old FW running\n",
-			   __func__);
+		if (err > 0)
+			netdev_dbg(netdev, "%s: SET and GET ATTR Mac are not equal-due to old FW running\n",
+				   __func__);
+	}
 
 	err = eth_prepare_mac_addr_change(netdev, addr);
 	if (err)
-- 
2.53.0


