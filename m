Return-Path: <netdev+bounces-258017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMKiJzGUimlvMAAAu9opvQ
	(envelope-from <netdev+bounces-258017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 03:13:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F0297116326
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 03:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 938673008CBF
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 02:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39F22D73B9;
	Tue, 10 Feb 2026 02:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD3EAKkN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EBE2D1913
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 02:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770689578; cv=none; b=jIPnbSkI6QkbgEWUsOjbXbs54yufLbiLiMQd+k89U+xDNiELBDKWdBKmvl1/r+oiVOQgakGDsGbYOKwgruTAcz4I9Ia/rhCI5KBsy2Ghc0xpxsxE4SVqBMRK32D5hisNsTSPgFVWr3M5aQSXfBgGVAtb6p06JrykBHCNyc3orjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770689578; c=relaxed/simple;
	bh=/CNu3or6IvmW6a+NEI6b/c1pNPuTW2PtNIWZgOO9Mfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O0SeomvMb5lvedkhG/N0mzWfP0HSx7sX2dn1AKRwAXaM4arSelLla1lpSfi8ZlnJ5MRXQ9acRGOdyKPMUbUtY5FSUCHfqyU0iyjjvEpyhiPTWc1TZp4bOHakGJCAn2zZYJoNnt40w97YqDNDznJmEuyv2zloLV9qeAekGRWl2O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kD3EAKkN; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2b785801c93so8999627eec.0
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 18:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770689576; x=1771294376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JS7YM6T2z4NTuWOeAxUIARMzj225fodPnkXEYUrFD10=;
        b=kD3EAKkNFHRxlmaZd7MT3V5uNxPdPBu0Yr/+LInwcpKVM10xZ8YCIxt/A+7cF88hvO
         EDX4X2sBHTxQ93F9xXwPj7lM5dae8qY+ixk2ZUNhC5MVewsIB4UCzecOym9nvbeNtzcc
         8XR/M81kLBOfQ9kl4PwYjQ3lVPZgFZDkD52e6nt51QD/k+0+EfWb7n2U1iUdr5v7awC4
         fruc9SWnqgJSojNoKJiv6HuL9kmUFSasQHvpHkdfOVTAQT+qV2KD8HKJIxLysMO91D7W
         64PVBRe0tBrniqKl9Ey1Q2Q/SGqaVeM5mT02ZXpfU8tDifi2vVedfvSjQk4nJqza/vs4
         nI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770689576; x=1771294376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JS7YM6T2z4NTuWOeAxUIARMzj225fodPnkXEYUrFD10=;
        b=k2uLnaDtSP5Vzhmw3/j3xoF/9Eq3TGmPWIUrDZyHYjmdUOuBn1Vf1twaiPd1uADvFq
         bOLWok5SO2Zdwfw7IoxcvOUZ39vbzn9RzHcYmuiQorytBOgiOJLTqWqslfjS3udrlUM1
         tyoMQWVX0mLLZxXLAaAdFEPRHTuHnH1nFnYMR2kOSWnWJ6utABPGbw61al/9ljoibMk8
         T8NzvqYqY2+Pb+rUbsE3BPRD5ZfmXUAMpGi+TG2ptmajazi/zLoUuV9doJjc/5A58kpG
         QWfqKCBgiuVOrq+je6TyeAM6wQwwGQQmyFRsRJ8HEkzTNQ9eKEl/Ooi/Ey3Srj386M4d
         Ei+A==
X-Gm-Message-State: AOJu0YwKaPRsS9U/i+dBZSlqnpe5miAtB85ig/HI3eZyRdHHOf6MmtR6
	jH+IPg9F8O+yleplUZ1dhP0NIlKvfyUTMqql+quyOGNkEpAW7YIm99Sh8EmSgdCe
X-Gm-Gg: AZuq6aK8S1HscmRJ+YY9y9y8iBWPRUACEnF2oqMYEV6NCwNj7s6GJGKSthRt3YDbmDI
	PgHGGCiYDxhbsHHJJg95RJhlSl2m3+u5h8WWSmqAL6Bihdg2T23abq7brMDGewO+ufsx6RPfnJB
	fTrJXdUvtW0I4qY9YpByf8oPfMGVzKMY2NVvSop6kDk9NzhDRqY/eJbklVkWRgvEy6aVlGkOBBB
	qjZoXEEqiSS8XuhZ7YCu2NBkyJsxL9R0cy30Cbvu3AlVj2s+ngPYlihQt3LIPR7sh9JCVcgRDxo
	NwLtdnpfi4K/Yf0utfyHue7cR2USI6Kb0qAKz2W35GqYDqaT9z2a/iV4BsPiNAOgR12KdEy/ojL
	XzESRlsxvbpC5E5N+l2PclJuN148tpvhLGwfH6YMSt6hQXhnghaWiekPsPCircIgeNqUPFI5Syk
	QArEqJy5UhItkMnPVIiFe0yGb9uBNC/X23VPkUtMseOx4XIv1ABTnJqGOzCZmUiMExGWg3qTKpY
	CHp2IIkLvwL5I7UMS297MWO4Lkj9afVOlseebOsrwpL5s998lt6gax3whqmgmsx5y3NBC7LLoQn
	ZUKYgpE1YglWKyFNnQ==
X-Received: by 2002:a05:7300:e80a:b0:2ae:5d3b:e1ba with SMTP id 5a478bee46e88-2b856836f6fmr5038313eec.23.1770689576354;
        Mon, 09 Feb 2026 18:12:56 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba81eab184sm1472747eec.1.2026.02.09.18.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 18:12:56 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Yakovlev <stas.yakovlev@gmail.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alice Michael <alice.michael@intel.com>
Subject: [PATCH v2] net: intel: fix PCI device ID conflict between i40e and ipw2200
Date: Mon,  9 Feb 2026 18:12:34 -0800
Message-ID: <20260210021235.16315-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,sipsolutions.net,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-258017-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0297116326
X-Rspamd-Action: no action

The ID 8086:104f is matched by both i40e and ipw2200. The same device
ID should not be in more than one driver, because in that case, which
driver is used is unpredictable. Fix this by taking advantage of the
fact that i40e devices use PCI_CLASS_NETWORK_ETHERNET and ipw2200
devices use PCI_CLASS_NETWORK_OTHER to differentiate the devices.

Fixes: 2e45d3f4677a ("i40e: Add support for X710 B/P & SFP+ cards")
Cc: stable@vger.kernel.org
Acked-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
Changes from v1:
Rebase on latest mainline instead of net-next

 drivers/net/ethernet/intel/i40e/i40e_main.c  | 8 +++++++-
 drivers/net/wireless/intel/ipw2x00/ipw2200.c | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d3bc3207054f..02de186dcc8f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -75,7 +75,13 @@ static const struct pci_device_id i40e_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T4), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T_BC), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_SFP), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_B), 0},
+	/*
+	 * This ID conflicts with ipw2200, but the devices can be differentiated
+	 * because i40e devices use PCI_CLASS_NETWORK_ETHERNET and ipw2200
+	 * devices use PCI_CLASS_NETWORK_OTHER.
+	 */
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, I40E_DEV_ID_10G_B),
+		PCI_CLASS_NETWORK_ETHERNET << 8, 0xffff00, 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_KX_X722), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_QSFP_X722), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_SFP_X722), 0},
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index 09035a77e775..b0e769da9415 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -11387,7 +11387,13 @@ static const struct pci_device_id card_ids[] = {
 	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2754, 0, 0, 0},
 	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2761, 0, 0, 0},
 	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2762, 0, 0, 0},
-	{PCI_VDEVICE(INTEL, 0x104f), 0},
+	/*
+	 * This ID conflicts with i40e, but the devices can be differentiated
+	 * because i40e devices use PCI_CLASS_NETWORK_ETHERNET and ipw2200
+	 * devices use PCI_CLASS_NETWORK_OTHER.
+	 */
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x104f),
+		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, 0},
 	{PCI_VDEVICE(INTEL, 0x4220), 0},	/* BG */
 	{PCI_VDEVICE(INTEL, 0x4221), 0},	/* BG */
 	{PCI_VDEVICE(INTEL, 0x4223), 0},	/* ABG */
-- 
2.43.0


