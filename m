Return-Path: <netdev+bounces-251791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGPmFBGCcGktYAAAu9opvQ
	(envelope-from <netdev+bounces-251791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:36:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D3752E2C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A79FA701C28
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 07:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0EC4418CB;
	Wed, 21 Jan 2026 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZrWDQfs4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5828142848D
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768980966; cv=none; b=c+XyK9F/S0vXAwnJVPgIUz+Jd2w+9Iifc6E3FoHpl07HA43FOxH2lMy57CGLc91FFqq5a8SHfFRn9zV4z0TnyiV/JhvB6c1LSOwG0jb0vaFWtRDnM+HzbVbjXdHfdnGJkM9368Wt0KPVKdTeQUNcIlhCo2AsdTstjBge2TiG7HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768980966; c=relaxed/simple;
	bh=nL6sr6Ekrqcih+FjUGdb919SiseL/nETfdZ1kimdsR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PS1KY+le2Aef5jd3XJ6OAqvvuRZlEGx+3b38hORn3ZwQeBRVxvjPZ/ORjabLohtgWsPUO8CQccDoiz0ItPQ/N7iYHkCc9iCRtg7Zn5Z3xRSn/hQ3C6nXLe1+gI1Jlyod3BWmHo/jwTi2tsLsTMFtoPk5Gx+m84J+iB0riCLJ3mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZrWDQfs4; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-81ed3e6b8e3so3018518b3a.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 23:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768980964; x=1769585764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPRVbPwF+wXnXIym+qvc8QVBDwbNyNX7SjLMFiSMDaA=;
        b=IcXI+j1/sIJ2umLesAgPDvV3nLmwbUod++WBMD9g9apnKZq7COwjjJsRR95GO5h6B+
         fYVWHl4cv+aOTLHNH76WHHlWrqnbi8A25w7nXswhGIBwT/6BfBPiEM3SdY5dHiHHVDwo
         6J4OwSkCwKcQVvsTffpcx2nu+GsPFYz9Jl8OgqdbjZbXUXjQIJvqBamST9EN638OXYET
         6CNMQjpSoFkhYHVDpp9tTFj6fkAJG3L2cNeSPr29Wdv7mYkW5z/bxDrmJsdzHE35j59y
         fJp15Wq+ip6y3k3sRxi6qphZrQCZrArwcy0L1MsTIUFKnU1Vuginm3WfIlwlLtbdXGwV
         dJ6g==
X-Gm-Message-State: AOJu0Yyd8iuCxG2W5Lu927ub3PpsjwZIeVvzzcccmeUueid1hK/1gX7T
	4moN2v60nHZ3YXTYCHzBitZK8lepupQv7+5ZxwFtO0iykqm8euPHqllmNNpNGpPPYBUFo4yudTl
	a8+h8p8EHaOcAqWJMoxE5Dps9H2nR/BQFIrVh/yhs82H870CNUXUOkfZcYo414xZgJtcIvWmxq0
	qMjZ5ZrmeKt9bxhfbh4vYH+K1TEUggRiRc4W5DYgtWG8GwAbHnx4qT8pw3NLCzhl4yqomH3Lzva
	X0duGy51xLM
X-Gm-Gg: AZuq6aLdbE2tOQM2ZIIaEUHN2lo11SPbuz6374bAkHICZ1zdCUYFLtbA4pVIpF39Pf6
	j4C+G9/7f4gcH6sBe9oMipK9zN6tmN+8amJDVDbhFP06JKoQzLywhRUyQlrzt8d382YtlQXH9S5
	Em4p/ME3F7tbi4t/3W3ToWmuUKvPPxI7+NqZzgM/PaX2Le1t1bdaJnhsS47iKwtO21DWrmbhSTd
	ZKpk7NRobbuyalBEZ0O4Wb9OtkDw0ITqsPtC/4MEtM4K2x/XgkBgJs1gAzK4UzII5frQABVm46z
	hHq4VX8Cz4Q9ruTmi/NLwydAUTI6KaWdXXcY77EOhWItCbvFqNnQzaKifezdxM3bfL8FPgREOMh
	4Sji5wG6xs7RAiwnkCAn1WeWXxvh9AXyorc9D5hVNhvgE0UEGMDDVLSwecypM/IKg57HbjBtWoE
	VfDYSclSwkd8PYOrc1jnp4ylhPG/Ig7hUg8MtkJvmIfumsVg==
X-Received: by 2002:a05:6a21:820e:b0:35d:58d3:2904 with SMTP id adf61e73a8af0-38e00c22388mr14570517637.31.1768980964405;
        Tue, 20 Jan 2026 23:36:04 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c5edf314670sm913469a12.13.2026.01.20.23.36.04
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2026 23:36:04 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-89467edcd21so56895996d6.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 23:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768980963; x=1769585763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPRVbPwF+wXnXIym+qvc8QVBDwbNyNX7SjLMFiSMDaA=;
        b=ZrWDQfs4mx3KruX54fLgv0qIZKL4h8LrHqMvrmC/BVDEZHc065oEYm6raK0I3O8Jq7
         7z6n3s4ll6LY0XZjdEFVwtxDQopMAePgpQLSarqQw3ZKkRd97Lnk2KWT3Pk3xGr4AX76
         PPXzmYiLtdMM5Q6Nwd2Xmbgg8eQ2IqhMJWugg=
X-Received: by 2002:a05:6214:29c2:b0:893:348e:4126 with SMTP id 6a1803df08f44-8942e52179fmr267877006d6.61.1768980963212;
        Tue, 20 Jan 2026 23:36:03 -0800 (PST)
X-Received: by 2002:a05:6214:29c2:b0:893:348e:4126 with SMTP id 6a1803df08f44-8942e52179fmr267876746d6.61.1768980962761;
        Tue, 20 Jan 2026 23:36:02 -0800 (PST)
Received: from lvnvda4076.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894592ba642sm51439736d6.57.2026.01.20.23.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 23:36:02 -0800 (PST)
From: Kiran Kella <kiran.kella@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jayakrishnan.udayavarma@broadcom.com,
	ajit.khaparde@broadcom.com,
	akhilesh.samineni@broadcom.com,
	Kiran Kella <kiran.kella@broadcom.com>
Subject: [net-next 1/2] psp: Support for transmit on logical device when the underlying transport device supports PSP.
Date: Tue, 20 Jan 2026 23:35:16 -0800
Message-ID: <20260121073517.3323332-2-kiran.kella@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260121073517.3323332-1-kiran.kella@broadcom.com>
References: <20260121073517.3323332-1-kiran.kella@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251791-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[kiran.kella@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DMARC_POLICY_ALLOW(0.00)[broadcom.com,reject];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B3D3752E2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is achieved by propagating the psp_dev from the lower device
to the upper devices in the device stack via a netdevice notifier.
The lowest device owns the psp_dev pointer while the upper devices
just borrow the pointer. When the lower device is unlinked, the
borrowed pointer is cleared in the upper device.
Assumption being that psp_dev is set on the lowest device before
any upper devices stack are linked on that lowest device at a
later point of time.

In case of bond devices:
- If an upper device has multiple lower devices, the psp_dev is
not propogated as it would be ambiguous which slave will be used
for transmission.
- If a bond device transitions from having one slave device to
multiple slaves, any previously borrowed psp_dev pointer is
cleared to avoid ambiguity.

Signed-off-by: Kiran Kella <kiran.kella@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
---
 net/psp/psp_main.c | 114 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index a8534124f626..0bff50c9314d 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -313,10 +313,124 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8 generation, bool strip_icv)
 }
 EXPORT_SYMBOL(psp_dev_rcv);
 
+/**
+ * psp_netdevice_event() - Handle netdevice events for PSP device propagation
+ * @nb:		notifier block
+ * @event:	netdevice event
+ * @ptr:	netdevice notifier info
+ *
+ * Propagates psp_dev pointer from lower devices to upper devices when
+ * upper devices are created (e.g., VLAN subinterfaces).
+ */
+static int psp_netdevice_event(struct notifier_block *nb,
+			       unsigned long event, void *ptr)
+{
+	struct netdev_notifier_changeupper_info *info;
+	struct net_device *dev, *upper_dev;
+	struct psp_dev *psd;
+
+	if (event != NETDEV_CHANGEUPPER)
+		return NOTIFY_DONE;
+
+	info = ptr;
+	dev = netdev_notifier_info_to_dev(ptr);
+	upper_dev = info->upper_dev;
+
+	if (info->linking) {
+		bool has_multiple_lowers = false;
+		struct list_head *iter;
+
+		/* Lower device is being linked to an upper device.
+		 * Propagate psp_dev from the immediate lower device to the
+		 * upper device. The immediate lower device would have already
+		 * got the psp_dev pointer set in a previous notification (or
+		 * owns it if it's the lowest device),
+		 * Upper devices just borrow the pointer.
+		 *
+		 * However, if the upper device has multiple lower devices,
+		 * don't propagate psp_dev as it would be ambiguous
+		 * which slave will be used for transmission (eg., bond device).
+		 * If the upper device already has psp_dev set and is getting
+		 * a second lower device, clear the psp_dev.
+		 */
+
+		rcu_read_lock();
+		iter = &upper_dev->adj_list.lower;
+		/* Check if there's a second lower device */
+		if (netdev_next_lower_dev_rcu(upper_dev, &iter))
+			if (netdev_next_lower_dev_rcu(upper_dev, &iter))
+				has_multiple_lowers = true;
+
+		/* If upper device now has multiple lower devices, clear psp_dev
+		 * if it was previously set (from when it had only one slave).
+		 */
+		if (has_multiple_lowers) {
+			psd = rcu_dereference(upper_dev->psp_dev);
+			rcu_read_unlock();
+			if (psd)
+				rcu_assign_pointer(upper_dev->psp_dev, NULL);
+
+			return NOTIFY_DONE;
+		}
+
+		/* Get psp_dev from the immediate lower device */
+		psd = rcu_dereference(dev->psp_dev);
+		rcu_read_unlock();
+
+		/* Propagate psp_dev to upper device if found */
+		if (psd)
+			rcu_assign_pointer(upper_dev->psp_dev, psd);
+	} else {
+		struct net_device *remaining_lower = NULL;
+		bool has_single_lower = false;
+		struct list_head *iter;
+
+		/* Lower device is being unlinked from an upper device.
+		 * After unlinking, check if the upper device now has exactly
+		 * one lower device remaining. If so, propagate psp_dev from
+		 * that remaining lower device to the upper device.
+		 */
+
+		rcu_read_lock();
+		iter = &upper_dev->adj_list.lower;
+		remaining_lower = netdev_next_lower_dev_rcu(upper_dev, &iter);
+		/* Check if there's a second lower device */
+		if (remaining_lower)
+			if (!netdev_next_lower_dev_rcu(upper_dev, &iter))
+				has_single_lower = true;
+
+		if (has_single_lower) {
+			/* Upper device now has exactly one lower device.
+			 * Propagate psp_dev from the remaining lower device.
+			 */
+			psd = rcu_dereference(remaining_lower->psp_dev);
+			rcu_read_unlock();
+			if (psd)
+				rcu_assign_pointer(upper_dev->psp_dev, psd);
+		} else {
+			/* Upper device has zero or multiple lower devices.
+			 * Clear psp_dev if it was previously set.
+			 */
+			psd = rcu_dereference(upper_dev->psp_dev);
+			rcu_read_unlock();
+			if (psd)
+				rcu_assign_pointer(upper_dev->psp_dev, NULL);
+		}
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block psp_netdevice_notifier = {
+	.notifier_call = psp_netdevice_event,
+};
+
 static int __init psp_init(void)
 {
 	mutex_init(&psp_devs_lock);
 
+	register_netdevice_notifier(&psp_netdevice_notifier);
+
 	return genl_register_family(&psp_nl_family);
 }
 
-- 
2.45.4


