Return-Path: <netdev+bounces-292107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKM5GkmRFmrqnQcAu9opvQ
	(envelope-from <netdev+bounces-292107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:38:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C895DFEC4
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0233C30580A5
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 06:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ED93783BA;
	Wed, 27 May 2026 06:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqAK+My2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341333793D2
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 06:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863421; cv=none; b=fklNZ1PiQrQyEHfpki66j8W1sxk/lhkYFwvWoXoVeu9sJ+b8mTJqdzdD1jGjk6v/N8J0C42Ahy9cq0OaMyO2SGQXtLo/toZFcEzllT4xulCzeh9oH9GJ0umq5rCBc/18GuNobhCJhbB6Wycovx8y5RaEGOopvdQm2pX/wntqvJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863421; c=relaxed/simple;
	bh=p7/YfuXYML0GE4AZtwU3HzJPFaMOz2OWNoEyKifn68o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eDwYVEUai1LcCjwwColjNwKb7uP0i2jm583eWc94Y1hdYSzupnv3dTY7kpy7+qx/QZDSosu6HQRKIPCsrwGuK8RS7mtXqu2Cltvr22C4mowpdZ8BWdB0e3v6db2eF/S3tZPA8xZSwq6lnteN6kVqUPCK2EwvaQBuUk+FrUKprhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sqAK+My2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b45cb89f7eso76642375ad.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 23:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779863419; x=1780468219; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tEobivHhAFBg6wC9f9EbG7ESxRYSJIwSn6CaqEsSQp4=;
        b=sqAK+My2CVRzpB1onphYBlWzh7jW1pM3RJQGmAh0xLe9niE7o9V2VCadeQcOF4MmO0
         n5n2IWCJIfCr8INwbYSdMalud8tzdCw87ERgIUvr6gRWLhoipWq2wTLga74jIm2Bxry5
         FJTegKoy3K9D+2sdpOiYFa9XrqFrWXZ05IVBX8HyN/KnBhdYpVluApZljDCPeHUxJtVZ
         V3QWuOfG+dyNfXc0NtPEywSDsadq0p+nUy4Zre+YaAWEzDw9rXfTMtJrpJ5ujb2R6cjF
         G6M8s51eHs7MECgpYr0qR3XJMsCxABxyMvCw4W6a0uqegLj7GdM/pMkPxbzdpvpSHN+H
         iELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779863419; x=1780468219;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEobivHhAFBg6wC9f9EbG7ESxRYSJIwSn6CaqEsSQp4=;
        b=PZhgypBgnGKmsK1B0kqeRiMLChHFkpVeez1xd95M7K2VSlDl5BbfuiQE6itJCtXCqy
         yCUSnzzWTrg0SrBztPeuzWbijSLvjFvmBLHkuOekR5jzqPGU2fOGtH0ZNTra8yTDq8ip
         4qeipTolc97r0MeBqNSee/MwY884LYeC8CbL26EWenoi5caVL5W6tSSzfKSnHM6XkgtO
         nC1iDHC99YPC/LBF4Dxa+ZA9nM0k3ecSc7n303iZr3ePPAHHMsoHrGVAFiJC2qE6WDTD
         3NBNpTlkrS76VI+l7oyOzT/NTeIc44dvyUT6XZmlCT5v6Mt4oJjqdnbqUPWTzEB0Jl4h
         B9+A==
X-Gm-Message-State: AOJu0YyQZeS1oVqtuGYVqwPFBlLbqYhlpPqLGDppfFWFOaglJv/QnC0s
	6UrZFyYTG9OeGkJireeCgI3KaOmLCQSAD49RwRJOvM9rzWf34WCLUHut
X-Gm-Gg: Acq92OHSCfqS93JBwNZ1NE0bxwrsu6xkSlINgU2DkhrMsq1xuEOHHF85E+Zgwm56JKu
	DewK2m/0Pzq8/lHs6Rq9psmSk9dmQQEOJpazrIRv5i7naRze0SIscbQtBME+9zYlPvUzC9rClOn
	3RRxcYimk5Q+mFZPSYUBtegW95grGEhizRzztC3Rd68Rp3bh3SIUevjpN5Q/L4AUIVtjA3UZx9C
	o6h1sF0khxdvh4mQdBAMUjTeIHWmwkM/PXkMPMwxbFKWOKzT6a9aOZaZ4HD/mDfCiFbj/cnwTMa
	ytgz9SAW26HBpBXlldxRlw0AEJHR4hc+GYpzGQXjme/Hv+W6y+XvnBTcVXv4fT6T35pb3dnXsg1
	HlMuXk8lMupK+xB7KAH80Rd6JBongULx2684+hx18V2X32zA+kc7CjRzl/++osppniMFrk/yvJN
	2XA9Q3Jl2QTtbhkWl4zCpYxEkXNVs++0EoHOlMSyWYoJeAmR1OhTvMNASMQPRcAEA=
X-Received: by 2002:a17:903:2f4c:b0:2ba:9e1c:7cbb with SMTP id d9443c01a7336-2beb063361dmr238682865ad.34.1779863419441;
        Tue, 26 May 2026 23:30:19 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695f3dsm142687515ad.1.2026.05.26.23.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 23:30:18 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 27 May 2026 14:31:51 +0800
Subject: [PATCH net-next] net: ftgmac100: assign interface name from device
 tree alias
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-addethalias-v1-1-24f5bd2d03cd@gmail.com>
X-B4-Tracking: v=1; b=H4sIANaPFmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyNz3cSUlNSSjMSczMRi3RQj01SjNEMLCzNLcyWgjoKi1LTMCrBp0bG
 1tQBZKaunXQAAAA==
X-Change-ID: 20260527-addethalias-d25e2f188697
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2788;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=p7/YfuXYML0GE4AZtwU3HzJPFaMOz2OWNoEyKifn68o=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqFo/YNh2d6Tx7VB2f+NqSa/SZNKW9+/KBcQdVX
 GwukRe1DRGJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCahaP2AAKCRClg0K3CVbE
 ge/jB/479gWYjoWaD/rNB0GN1/9VOXkCBKt/b42bJGbnDh3MJXcXfHv/It15pJGoq3svZ4xZfj3
 3k8Cp2RVvhOD3/SQALEaq/SG36Up4tw3AH0dSEgSIh55gn6FBQkIT2PiueyZv9WjUM56vSzdtbb
 OQ/0ZaHnlRDJGkJHPQUIv+ghRnUVnK1b/Vn1H/AEr7Dg1Fz9DDpvHfWu4oMSUElI96r6p+7nVYm
 VOr7cQ+/IvR2aAnhO0zJCk95Wfey7gb6CqAzikRRbXVLOMyFEViZMH57PsCNblW1JnYIABsCGu4
 cpvz4HLx8jqO8AjEm7gHJ++Y1P5sZ0nc9Nv9qK5Xv9fGWiCC
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292107-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kylehsieh1995@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B8C895DFEC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, the ftgmac100 driver relies on the probe order to assign network
interface names (e.g., eth0, eth1).

This patch allows the driver to fetch the "ethernet" alias ID from the
device tree via of_alias_get_id() and assign it to netdev->name before
registering the netdev.

This provides a standard and robust way to achieve deterministic interface
naming (e.g., ethernet0 -> eth0) directly from the device tree, preventing
potential userspace race conditions during network setup.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
Hi all,

This patch series introduces deterministic interface naming for the 
ftgmac100 driver by utilizing device tree aliases.

Background:
Currently, ftgmac100 assigns interface names strictly based on probe order. 
On platforms like the ASPEED AST2600, this often leads to naming collisions 
(e.g., mac2 and mac3 defaulting to eth0 and eth1). 

While userspace tools like systemd-udevd are typically responsible for 
renaming, we encounter a severe race condition on BMC systems: the NCSI 
driver frequently brings the management interface UP before udev can rename 
it, resulting in the kernel locking the name and rejecting the rename 
request.

Solution:
By parsing the "ethernet" alias from the device tree during probe, the 
driver can now assign the correct name out-of-the-box, completely 
bypassing the userspace race condition.

Testing:
- Tested on ASPEED AST2600 BMC.
- Verified that device tree aliases (ethernet0 = &mac3, ethernet1 = &mac2) 
  are correctly applied at probe time.

Please review and consider for inclusion.

Thanks,
Kyle Hsieh
---
 drivers/net/ethernet/faraday/ftgmac100.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 6d2fe5c2f390..e058a10500ee 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1949,6 +1949,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	struct ftgmac100 *priv;
 	struct device_node *np;
 	int err = 0;
+	int alias_id;
 
 	np = pdev->dev.of_node;
 	if (np) {
@@ -1973,6 +1974,11 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	if (!netdev)
 		return -ENOMEM;
 
+	/* Assign interface name based on DTS alias (e.g., ethernet0 -> eth0) */
+	alias_id = of_alias_get_id(pdev->dev.of_node, "ethernet");
+	if (alias_id >= 0)
+		snprintf(netdev->name, IFNAMSIZ, "eth%d", alias_id);
+
 	SET_NETDEV_DEV(netdev, &pdev->dev);
 
 	netdev->ethtool_ops = &ftgmac100_ethtool_ops;

---
base-commit: eb3f4b7426cfd2b79d65b7d37155480b32259a11
change-id: 20260527-addethalias-d25e2f188697

Best regards,
-- 
Kyle Hsieh <kylehsieh1995@gmail.com>


