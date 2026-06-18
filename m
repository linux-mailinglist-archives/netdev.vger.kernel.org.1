Return-Path: <netdev+bounces-300337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A9dlDFyfM2p4EQYAu9opvQ
	(envelope-from <netdev+bounces-300337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:33:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8CE69E1A0
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 09:33:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UBtbXkSU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300337-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300337-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=canonical.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5770330046AE
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 07:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDC23D0BFB;
	Thu, 18 Jun 2026 07:33:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32143CF678
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 07:33:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768022; cv=none; b=e1MSkNJn3FTa/UgheJddlneQxojN3EWHAi2E+rYIWZcL8/HjGAnKXZix8DvlNxzYqCkT6YdffXztLriyB9eBYsbEhr9lcJHeR5y+zHy1dPKwRFlVXN15mEgAhpPYBghfF4byy0dGKlWHLFSFEl4diI5ffD6q/2ONjG+4GOUa+fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768022; c=relaxed/simple;
	bh=gcsJ20YSTpvib9SkO84UdoVBX4pGd5du2v0O1QUk+I8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q2UZHyJMQWAwAdn9ao5cSyEBdc8KSbnq32iFhTEEfiS3D/JNu6l4JcBCGkL+b/PXGKzZvp3IHdeQFr0cj/4NWfeQDlO9AAUNBXm8zzVA7RAmWg7ewfF4Fd047re9XGCtcj7z7hLj4VOCk13efjykCbFuU/SBu+h2lFrI9Jl1c4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBtbXkSU; arc=none smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8453bcf7276so280438b3a.2
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 00:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781768019; x=1782372819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2ThiB77d7N7pxREshEF4WAMO6IHWL1PWSzLqjBsAI7o=;
        b=UBtbXkSUB6347f7loMXh4B4yqj/SGb07AmQ3gdi+UBW4+CoAiEpKXGgQArVUzROLUo
         cBmZs9SnTqf3JowmAHxKe0fQtIYjUffaNulzurB+lrSJehb80d/odKISLwUJCdEN9LWy
         C/BjPbaKJ8eLnGcrr4Ze/aVlqEhhfM61pbw+SRNPSCwWgNQb4R/RUhC0jNxtrzYAn8iC
         s6AwTIGmN6+7RvHdmoQj6TzIOHjUA1qot12L0DNCclXKzG++Hy9jOH6wn4C/6YySEXEo
         LOQQtVb6lvYFegJE37DRcrNIgwL3PYKV0UUHSN1cAs+q4/S0ldvnwDpHNJGNF+p8iFNR
         cGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781768019; x=1782372819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ThiB77d7N7pxREshEF4WAMO6IHWL1PWSzLqjBsAI7o=;
        b=DLWvj37j3wfukL5itZo/tl3d9HlMDHcCy134ZIZWdB5tOIsLaaDav+rEZ2vfHLqDIF
         Yasiq7GtW5960cxNdlonW7fqCpeMFTsy1/Bqeimea8zN5yuJFDFPDO6S7O45teMuW+96
         IE8n1+SmtSrOAps7QmQAu4ayoMDROgT3URGRRmd+ZtkMX7LtOmXKflYbSQ5cm8OKwJca
         J6HekAQL/CLmriParV+LOqq62dBYljiARvrrmJ8VuDCRSy43TPadzpiZSHpOL/kGQ5MY
         svtWHH07Gqa9m3vb9YafX5745d2s3Htt+v/PVpe1f5+K6HNP9NWdlVkdIGF6yfUF2HTg
         4ddQ==
X-Forwarded-Encrypted: i=1; AFNElJ8vhVksWMZtuE8qZUfHMEqVUvtofXtr9ux9GKSy/5HJC79yQvwcimEQ9lVI+BUY/ptmZ7YkenA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDoMDGtpW1BYBYW2iSye7nZqf31IpRJ71qi9Gtv6Cjw8MU1XQT
	FV/4m1joWUFxqss7vrWu8FU5Wj6jBVxwwpmMWnP0ZU6q7fc1t4ofbvbc
X-Gm-Gg: Acq92OFxhRnh1f/l9NTuUamKDrUcijLr8FNnVKrgUlh/exnI3t4Yx58A1ht40NaLcxQ
	ywWGABg3nL3UFBrQTw15wcN6i24GtBlU3DMakidGekrlbbbDrWN62GlGzAeZ5peVsjGAw3vjeKG
	zxjEByEY9S40mMRUnVWLqo4Fuwr6HJlHo+emNNb2l7XuRjUImlx0f4Ukg+ss++5MWgy9fcJgKE3
	9V/k6nVv7P76i7LqvxHRQPn6J/NvcG/BmNq1hC0q8Z4/5xxp55b96Gra6Gki4zY5vCsRDGZw/gB
	MvW8l+f8Dkg/dOUD2qyevUZnYVI80Y8kWHXNbi7B7D5s5+U2V37umi/Ycl3V3oohuxqbtQkFF8p
	5CPHJz7+4MO/keD6VKu5v1E1TcMuvwdKcem/gbwGTgiYcwZpWgznCxP3JipGtMUsD6uVjWKossR
	nv3+yUDdNvg42/rq7BYMvZrt47/FadjQRmn4kRfc5CFz/FN72jPQSxv9YaYEK25Acr1CPy
X-Received: by 2002:a05:6a00:3318:b0:842:655d:1232 with SMTP id d2e1a72fcca58-8452414d108mr7957295b3a.0.1781768018779;
        Thu, 18 Jun 2026 00:33:38 -0700 (PDT)
Received: from acelan-Precision-5480 (211-75-139-220.hinet-ip.hinet.net. [211.75.139.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434a934a97sm18630390b3a.0.2026.06.18.00.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 00:33:37 -0700 (PDT)
Sender: AceLan Kao <acelan@gmail.com>
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] igc: Wait for MAC passthrough after reset
Date: Thu, 18 Jun 2026 15:33:22 +0800
Message-ID: <20260618073324.1843310-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.34 / 15.00];
	DMARC_POLICY_REJECT(2.00)[canonical.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300337-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[acelan.kao@canonical.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[acelan.kao@canonical.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C8CE69E1A0

Some systems support MAC passthrough for dock Ethernet controllers by
having firmware rewrite the receive address registers after the controller
reset completes.

igc resets the controller before reading RAL0/RAH0, so that reset can
restore the controller native MAC address temporarily. If the driver reads
the registers immediately, it can race the firmware rewrite and keep the
native dock MAC instead of the host passthrough MAC.

For LMVP devices, poll RAL0/RAH0 after reset and before reading the MAC
address. Stop once the address registers change to another valid Ethernet
address, allowing firmware a bounded window to complete the passthrough
update.

Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 48 +++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2c9e2dfd8499..fa9752ed8bc5 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -11,6 +11,7 @@
 #include <net/pkt_sched.h>
 #include <linux/bpf_trace.h>
 #include <net/xdp_sock_drv.h>
+#include <linux/etherdevice.h>
 #include <linux/pci.h>
 #include <linux/mdio.h>
 
@@ -69,6 +70,52 @@ static const struct pci_device_id igc_pci_tbl[] = {
 
 MODULE_DEVICE_TABLE(pci, igc_pci_tbl);
 
+static void igc_read_rar0(struct igc_hw *hw, u8 *addr, u32 *ral, u32 *rah)
+{
+	*ral = rd32(IGC_RAL(0));
+	*rah = rd32(IGC_RAH(0));
+
+	addr[0] = *ral & 0xff;
+	addr[1] = (*ral >> 8) & 0xff;
+	addr[2] = (*ral >> 16) & 0xff;
+	addr[3] = (*ral >> 24) & 0xff;
+	addr[4] = *rah & 0xff;
+	addr[5] = (*rah >> 8) & 0xff;
+}
+
+static bool igc_is_lmvp_device(struct pci_dev *pdev)
+{
+	switch (pdev->device) {
+	case IGC_DEV_ID_I225_LMVP:
+	case IGC_DEV_ID_I226_LMVP:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void igc_wait_for_lmvp_mac_passthrough(struct pci_dev *pdev,
+					      struct igc_hw *hw)
+{
+	u8 addr[ETH_ALEN] __aligned(2);
+	u32 orig_ral, orig_rah;
+	u32 ral, rah;
+	int i;
+
+	if (!igc_is_lmvp_device(pdev))
+		return;
+
+	igc_read_rar0(hw, addr, &orig_ral, &orig_rah);
+
+	for (i = 0; i < 100; i++) {
+		msleep(100);
+		igc_read_rar0(hw, addr, &ral, &rah);
+		if ((ral != orig_ral || rah != orig_rah) &&
+		    is_valid_ether_addr(addr))
+			return;
+	}
+}
+
 enum latency_range {
 	lowest_latency = 0,
 	low_latency = 1,
@@ -7259,6 +7306,7 @@ static int igc_probe(struct pci_dev *pdev,
 	 * known good starting state
 	 */
 	hw->mac.ops.reset_hw(hw);
+	igc_wait_for_lmvp_mac_passthrough(pdev, hw);
 
 	if (igc_get_flash_presence_i225(hw)) {
 		if (hw->nvm.ops.validate(hw) < 0) {
-- 
2.53.0


