Return-Path: <netdev+bounces-202211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7ACAECB79
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 07:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 313983B43A9
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 05:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF411C5D53;
	Sun, 29 Jun 2025 05:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnSXKexx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AE01F92A
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 05:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751176475; cv=none; b=XEVh/r8en3ZY/ByGCIX/TztE0HI/MmC499mU0R2gyWjMoIglU79pc5dI0Sm+jsti87g5M6z6Us/9+VdtYjkL0c77OEtcM4sU5hhm4Ye0Cj0+xZBucz8OhVvh7+eOhCsMJwmD6iLvaVecNBgoLoznCzQZ4zigX3AdDY4NxONDMKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751176475; c=relaxed/simple;
	bh=acRO77bmGgaltNrloiJVwPAJzzJZa7ZshYnMyoKmwUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PoNkvZaKSxn24ag/vbs5X7SqWaeIIV+LzyOSKMnkPiPjiRCCh2D8405YMpkHULmgXCsZlVYJO2IvWmh54cXCiv9R/6bCEP5vPVLR9z3/gvWspN86KzZHnprpoW++jaXTb05JVCDQMZYBPViyDdeewjPCjWGNH9eYDjBQUNRSG5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnSXKexx; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b2fd091f826so3117002a12.1
        for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 22:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751176472; x=1751781272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZM7xZ6DHY+WfrWlrzC9MhyQMj+5i/LhY63UoQQGbUpU=;
        b=nnSXKexxtJQGOjkoyrevGVhWQYflTe+HlECYPSEDj6SZ9Pa/hCYqgc37ZTnezNiAuB
         Og3wVEbMmnerJRbP6vBWH4Pup6cpq0gRrj+m8n0Opj+XDa7NB62EiZHVNCAZPlSX4jpi
         yfmX58apmCyt014JS8hfKz6ON+4K8qA2nlCB/vT5WXYv8LvDuOrvMBTXLdQWlmOSkY/i
         zwgLMDexEkHBKOtcpe+Q+CCysNFGqLnlA3VRXSR05u3QG4+Rtz6WrjJOjrs8C/jWYwH9
         cZ9Jv/ihrCenHjGyXMCiGvjm+dgHA1Kf+jm042gjWroGN96Ek6wu1Kewy0cylhAwI8Rf
         ANxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751176472; x=1751781272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZM7xZ6DHY+WfrWlrzC9MhyQMj+5i/LhY63UoQQGbUpU=;
        b=rsPOkmN/ASeAkRHi+3Fpu2oMPjlMSRRXgbefdNUhx7aW7dUh5CO3HNmAh2rVM3Mb8a
         3BJV1J1wYyyXhy4iMyH7NgkS9fCbHu5KI9jfOi6uTigemCj0ssczNQuCieoH98ObLBNG
         pWizxgpLYNnBHq2FJyU2xeNmsUHNZsg/pMmh/iLedjJKiHWZiQpBjYIJADAaYebCF6ZZ
         CLZt9DZh/jYsWkvKoKEZymzfsR5XS/vyRfQJ6Vp8NaPZemBCK8dR9am/OsQW7mEDaMgz
         o0apc0JrTLyzfDPJsaRYgEEx7SwqJRUeSuIKyDmUGbMvRzORHd1HFY922AFumnDlUTTQ
         aDXA==
X-Gm-Message-State: AOJu0Yzhvw1kc0N999zHTsKnMfoZvBUePfWgMkpsmda9z3WNou2znWlz
	qwIWjilIrMzYI3qSnS5GH/H86AVPm3UW8zhQhncOr/cZI5QH4qBlhnc+mf3ZD0xqqZM=
X-Gm-Gg: ASbGnctMY48z3nevIfrsRsxCDYMRmY+t+rZpwgZ93u5yse8xfUoVo3AG13oP2dQkIN2
	WdpGcpd3PNWoRBvuUb6qNkX7aoN2PCe+K2hlIz+ipBR4aXrtA5dpQCV9D7uw5UWnVRhAWl3T1q7
	PsW2UtL6nD8XNJynH2IZonVXcQVer+VjnSXe2iaeMiTj9fLFZwxprFXu5DC4DrD7wA4UsY1IS21
	M9F9P+AwnHqScdGK1Vb8/+BOXIWe5MsU2sdPGCfDvVnwFTmJF3/8J8SUo2u7gXpzUVDIIi5KJW/
	IDq3kzRu7SG0tWyuymkkxoAOdff8M8cdgYc9D17rNEFkyctafqkzHm2xGADzg3wnrwTGk5ArIQ=
	=
X-Google-Smtp-Source: AGHT+IFiWcZgwmidMSylItrnMnXJQ7ccbjNL3ueUAETsON3wPFWI1hiESx20H9ohf11nThhotIPptg==
X-Received: by 2002:a17:90b:55d0:b0:311:482a:f956 with SMTP id 98e67ed59e1d1-316d69bf0cbmr18474486a91.5.1751176472206;
        Sat, 28 Jun 2025 22:54:32 -0700 (PDT)
Received: from dustpuppy.laguna.lan ([47.156.206.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f539e6b5sm10054237a91.13.2025.06.28.22.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 22:54:31 -0700 (PDT)
From: Eric Work <work.eric@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Work <work.eric@gmail.com>,
	Igor Russkikh <irusskikh@marvell.com>,
	Mark Starovoitov <mstarovoitov@marvell.com>,
	Dmitry Bogdanov <dbogdanov@marvell.com>,
	Pavel Belous <pbelous@marvell.com>,
	Nikita Danilov <ndanilov@marvell.com>
Subject: [PATCH net-next] net: atlantic: add set_power to fw_ops for atl2 to fix wol
Date: Sat, 28 Jun 2025 22:15:28 -0700
Message-ID: <20250629051535.5172-1-work.eric@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aquantia AQC113(C) using ATL2FW doesn't properly prepare the NIC for
enabling wake-on-lan. The FW operation `set_power` was only implemented
for `hw_atl` and not `hw_atl2`. Implement the `set_power` functionality
for `hw_atl2`.

Tested with both AQC113 and AQC113C devices. Confirmed you can shutdown
the system and wake from S5 using magic packets. NIC was previously
powered off when entering S5. If the NIC was configured for WOL by the
Windows driver, loading the atlantic driver would disable WOL.

Partially cherry-picks changes from commit,
https://github.com/Aquantia/AQtion/commit/37bd5cc

Attributing original authors from Marvell for the referenced commit.

Closes: https://github.com/Aquantia/AQtion/issues/70
Co-developed-by: Igor Russkikh <irusskikh@marvell.com>
Co-developed-by: Mark Starovoitov <mstarovoitov@marvell.com>
Co-developed-by: Dmitry Bogdanov <dbogdanov@marvell.com>
Co-developed-by: Pavel Belous <pbelous@marvell.com>
Co-developed-by: Nikita Danilov <ndanilov@marvell.com>
Signed-off-by: Eric Work <work.eric@gmail.com>
---

Notes:
    The changes within this patch were originally written by developers from
    Marvell (formerly Aquantia) as mentioned in the patch trailer using
    Co-developed-by. Adding the `set_power` function for ATL2FW was one of
    many changes that were released as part of the v2.4.7 update for the
    vendor atlantic driver. I have only copied the functions necessary to
    enable WoL and modified the required functions to work with the upstream
    Linux kernel and followed netdev conventions (reverse xmas).
    
    The latest driver from Marvell can be obtained from the following page,
    https://www.marvell.com/support/downloads.html, resulting in the link,
    https://www.marvell.com/content/dam/marvell/en/drivers/07-18-24_Marvell_Linux_2.5.12.zip
    
    An earlier version of the driver was published by Aquantia on GitHub at
    https://github.com/aquantia/AQtion. The community has been using this
    GitHub project to discuss issues with the atlantic driver (even those
    not present in the GitHub repo), including the lack of WoL support in
    the upstream Linux kernel.

 .../net/ethernet/aquantia/atlantic/aq_hw.h    |  2 +
 .../atlantic/hw_atl2/hw_atl2_utils_fw.c       | 39 +++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
index 42c0efc1b455..4e66fd9b2ab1 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_hw.h
@@ -113,6 +113,8 @@ struct aq_stats_s {
 #define AQ_HW_POWER_STATE_D0   0U
 #define AQ_HW_POWER_STATE_D3   3U
 
+#define	AQ_FW_WAKE_ON_LINK_RTPM BIT(10)
+
 #define AQ_HW_FLAG_STARTED     0x00000004U
 #define AQ_HW_FLAG_STOPPING    0x00000008U
 #define AQ_HW_FLAG_RESETTING   0x00000010U
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
index 52e2070a4a2f..7370e3f76b62 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_utils_fw.c
@@ -462,6 +462,44 @@ static int aq_a2_fw_get_mac_temp(struct aq_hw_s *self, int *temp)
 	return aq_a2_fw_get_phy_temp(self, temp);
 }
 
+static int aq_a2_fw_set_wol_params(struct aq_hw_s *self, const u8 *mac, u32 wol)
+{
+	struct mac_address_aligned_s mac_address;
+	struct link_control_s link_control;
+	struct wake_on_lan_s wake_on_lan;
+
+	memcpy(mac_address.aligned.mac_address, mac, ETH_ALEN);
+	hw_atl2_shared_buffer_write(self, mac_address, mac_address);
+
+	memset(&wake_on_lan, 0, sizeof(wake_on_lan));
+
+	if (wol & WAKE_MAGIC)
+		wake_on_lan.wake_on_magic_packet = 1U;
+
+	if (wol & (WAKE_PHY | AQ_FW_WAKE_ON_LINK_RTPM))
+		wake_on_lan.wake_on_link_up = 1U;
+
+	hw_atl2_shared_buffer_write(self, sleep_proxy, wake_on_lan);
+
+	hw_atl2_shared_buffer_get(self, link_control, link_control);
+	link_control.mode = AQ_HOST_MODE_SLEEP_PROXY;
+	hw_atl2_shared_buffer_write(self, link_control, link_control);
+
+	return hw_atl2_shared_buffer_finish_ack(self);
+}
+
+static int aq_a2_fw_set_power(struct aq_hw_s *self, unsigned int power_state,
+			      const u8 *mac)
+{
+	u32 wol = self->aq_nic_cfg->wol;
+	int err = 0;
+
+	if (wol)
+		err = aq_a2_fw_set_wol_params(self, mac, wol);
+
+	return err;
+}
+
 static int aq_a2_fw_set_eee_rate(struct aq_hw_s *self, u32 speed)
 {
 	struct link_options_s link_options;
@@ -605,6 +643,7 @@ const struct aq_fw_ops aq_a2_fw_ops = {
 	.set_state          = aq_a2_fw_set_state,
 	.update_link_status = aq_a2_fw_update_link_status,
 	.update_stats       = aq_a2_fw_update_stats,
+	.set_power          = aq_a2_fw_set_power,
 	.get_mac_temp       = aq_a2_fw_get_mac_temp,
 	.get_phy_temp       = aq_a2_fw_get_phy_temp,
 	.set_eee_rate       = aq_a2_fw_set_eee_rate,
-- 
2.49.0


