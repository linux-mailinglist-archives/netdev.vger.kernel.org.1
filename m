Return-Path: <netdev+bounces-147559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA6D9DA317
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 08:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6FC28404B
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 07:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB17A14E2C2;
	Wed, 27 Nov 2024 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="UU3TESXZ"
X-Original-To: netdev@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D352C149C69;
	Wed, 27 Nov 2024 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732692490; cv=none; b=F1WIKTp+60DSJ83oShlJrp8+iwh6uloSk5CduPJ4lt7eBt5nLSHGh+fzLOTo0D6aLE7XHS8/lyNbeOwWlZs0gwOqWsvnSyspnVR0ytVNfeaxEFmWELRXPEwDlAbunVVyQhgMbhq6sQSjrukYYk9sQE8oHsMA0F6w7jbl+akuSPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732692490; c=relaxed/simple;
	bh=tKKvytTE+A8VvklgrImhY5WZD/1xcekyxjYQ+QNvTVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=H7x7m4ovTPJo1lteQDS1iukO5KIs4QwwP7ut0X0BRMovKAlag7pR/nbucyAgqS8KNPU9gNd+JQCYU2CE+SAVSES1vk9F23X0tZFn6+00f0sF9DWwC2/ZKnBKbGhoqlYtqabQdRCbOubjZMRoHYZgQXLTR+VTUbbbRUufTcIHFu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=UU3TESXZ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732692479;
	bh=tKKvytTE+A8VvklgrImhY5WZD/1xcekyxjYQ+QNvTVw=;
	h=From:Date:Subject:To:Cc:From;
	b=UU3TESXZGsEE9PyWIYxWunmDSE0PEWIsSROfayB6MJCXDLtR6b8uk4vMYnlb2Uoig
	 nET0cugGNOIzq8K6RZvAFBYoD2cbSz7XF/QLLW0tVhE85KC92oy3OYB/FRz0q0BkMg
	 tND4RGFpl3HdiMJN74yMfpCZmFUcbXyZbu8A8Zhg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 27 Nov 2024 08:27:57 +0100
Subject: [PATCH] ptp: kvm: Return EOPNOTSUPP instead of ENODEV from
 kvm_arch_ptp_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-kvm_ptp-eopnotsuppp-v1-1-dfae48de972c@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAPzJRmcC/x3MQQqAIBBA0avErBN0CIquEhGVUw2RDloSRHdPW
 r7F/w9ECkwR2uKBQIkje5dhygLmbXQrKbbZgBorY7BWezoGOUWRF+fPeImIslpj3VjESRvIpQR
 a+P6vXf++HxXeK+NlAAAA
X-Change-ID: 20241127-kvm_ptp-eopnotsuppp-d00278d22b01
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732692479; l=1408;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=tKKvytTE+A8VvklgrImhY5WZD/1xcekyxjYQ+QNvTVw=;
 b=FdFJEu4/lwFZYM2mUS4mAfNWM+GdS+8ZvQ9sTgV8WVjzsIIIjDGYIJvYiGZXCgXr4m/Av6db7
 4Zt/iT7318gDGUNxy730Ve9279fZS/z9+ebMIax6pnNHipmVRXLwsmK
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The caller ptp_kvm_init() expects EOPNOTSUPP in case KVMCLOCK is not
available and not ENODEV.
Adapt the returned error code to avoid spurious errors in the kernel log:

"fail to initialize ptp_kvm"

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/ptp/ptp_kvm_x86.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_kvm_x86.c b/drivers/ptp/ptp_kvm_x86.c
index 617c8d6706d3d00f7167fbf7e5b624ced29a206d..6cea4fe39bcfe46ba3b54b0815d3a3d034d415ea 100644
--- a/drivers/ptp/ptp_kvm_x86.c
+++ b/drivers/ptp/ptp_kvm_x86.c
@@ -26,7 +26,7 @@ int kvm_arch_ptp_init(void)
 	long ret;
 
 	if (!kvm_para_available())
-		return -ENODEV;
+		return -EOPNOTSUPP;
 
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 		p = alloc_page(GFP_KERNEL | __GFP_ZERO);
@@ -46,14 +46,14 @@ int kvm_arch_ptp_init(void)
 
 	clock_pair_gpa = slow_virt_to_phys(clock_pair);
 	if (!pvclock_get_pvti_cpu0_va()) {
-		ret = -ENODEV;
+		ret = -EOPNOTSUPP;
 		goto err;
 	}
 
 	ret = kvm_hypercall2(KVM_HC_CLOCK_PAIRING, clock_pair_gpa,
 			     KVM_CLOCK_PAIRING_WALLCLOCK);
 	if (ret == -KVM_ENOSYS) {
-		ret = -ENODEV;
+		ret = -EOPNOTSUPP;
 		goto err;
 	}
 

---
base-commit: aaf20f870da056752f6386693cc0d8e25421ef35
change-id: 20241127-kvm_ptp-eopnotsuppp-d00278d22b01

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


