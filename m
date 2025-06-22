Return-Path: <netdev+bounces-200100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FFCAE32F3
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 01:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0057416F445
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 23:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D355214A0B7;
	Sun, 22 Jun 2025 23:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKKH9x45"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFCC6136;
	Sun, 22 Jun 2025 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750633507; cv=none; b=Og/8CMn8LGrLaHDj/CpzMZtp420ubMMlktoX+Y4P5Do9uKu3sRlZi50jhoHc5qf497MVmxClySaT9RHI6UWQlKbSNyZO72bXwhZqIRGY7b3gcbD6jPNjkcH4uvExPkd18h1Zq2mHF6541+rq/fhh+X7ur+Yyw9LEmaWhQPlgHHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750633507; c=relaxed/simple;
	bh=5HaHmqv+P4SRKqzXBjXeuA0vZp8q7hXULmBQXltKzVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ociipFWH4Ow+7Kbved/J/vNUsEIbxZV1Eb7d1MOXnBjEh+YhNVsCwtjKneazzhE7/FjFRcWAi/hjs0fpgjGt3Ti8akykDEIrQt2Uz9v/L3zJagMaTTMaNFsy5qNSFu1FctpVokCuftEmF6bP0ILFOth840+am0u0XJAlRBEiGRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKKH9x45; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7490acf57b9so1734767b3a.2;
        Sun, 22 Jun 2025 16:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750633506; x=1751238306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+8WiigqwKQpH8MPpBrzVD32bylw5zlv3hORq0Em6I+o=;
        b=MKKH9x45x22YqlySoGEGOY2dHsRhN6aD52VQasMWOnuhsfpgWQRASlvBZGmQ3sXu7K
         t26qdDFgeD2/FMF7YX35CFuQaK/JJG6uRS07FwPp9fnsCe1J147c8dxvViHmFY4Re2Lj
         YSDvxoj29o0iRpZWh/1sMeA7TE7ByDCMpeBg8ygTfhLmhuXjstE4SIzHO4sOnwKN6wYi
         +MXy+HcBgeUjPPlMaMnVp+5BVj2nB6TDLthAfQHtkMcSZZyBUw1t4plPDUprpWuoSFJq
         5ysnXkLRXIrvYvdkFgHjuBZFifGeMCzGo5XQxizRUKe0TBapwhuhlKg7/1d60EaqXKEx
         xfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750633506; x=1751238306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8WiigqwKQpH8MPpBrzVD32bylw5zlv3hORq0Em6I+o=;
        b=f7jvMabOkVnKtbzef20j4HNK3Zw5F59dbqIVHYcRpPWvkJK8M9ocvmZI2EDk+wYtmM
         eqv1PQ1kPQ4AnqTCQkclTJNL//y7SC2nJKkhYpcYXQgxNu7RCEQ/tysEYIFg0g9T7+G5
         H1vSJq1sWM6yy9l+ZnQK5BsHkY7z1r0RJZgTnoweLhq0j/P/YWhhvUvrIvrUBf0dWIcZ
         9U5yHK6S6Ncuj2BIj9vToVEZYbq3/0+/2Fh227JaYH1T9pTybfrqw0beswmFrZNSzGwa
         KmFdetiXbXLx5T0/YcB+4pbtKvm+EHIJDZPc9RK5+sr6EHVScGMqaIheHlhdaPF1LRNT
         FCpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH4ZitsuiCvB4fB4fY6rLrsKKMpKkglzZfbdPjh0PkM4vbS2MlWORL1BuvuaXkNTjJ+wZQAVuEpgURLSI=@vger.kernel.org, AJvYcCWmiUjF0cliA0JaKbm9oTFnT9nxFe0YDkVlK9kroj1e7Ly0ZZUAq5V6Z5bfjQ2LM1DYCLTdWlQb@vger.kernel.org
X-Gm-Message-State: AOJu0YyCyly8kc/PIkSi5wcgGXyh3rdjPhCgT2j69wW/PHUZj5r9bTH/
	VcwUIbLKxMIzcT7HDeOnBtPr9W+jQmqKagG9DOF+0PgiiRFScNGDSSdQ
X-Gm-Gg: ASbGnctgOwzzYkA79tirVQ+2xyqCaJyDMucy7paesQD8PMOLfKxs/FdZoH4LA/f5cTV
	GdF8ZBRfvQN9mEo3mEaRlqvSAGvs6DqlMBsX+9rfFIYLmV/Gbwr22/YmY5e2W+LX2fzFT/QzXF8
	BrdLYUcAcVk0gbX9z6KA6kzAGYcDT7P0XrN4sna0SaogkVi8iSM3pZQ8MatTc3b7U10QxS5swfi
	ka4KtZxpn1U3oN0iLknBUgtHjUzntxWBBuJiONOb1B29XttXtuOpUjOqfbachplWMSLY6RQTBUO
	F552zgwwV39WMnHosJCKb3gRs96o9XuXkCldUmMPMT37O7xy9D6HZ0JXic36IWH9kA==
X-Google-Smtp-Source: AGHT+IHUcLsFTnc4IKgX2LAMTM4wZvSfI8akkpBXsSxMVdgI357MCO6JAckwHvL6TwGWY3Y7ZGrKdw==
X-Received: by 2002:a05:6a00:1804:b0:73c:b86:b47f with SMTP id d2e1a72fcca58-7490d6636a8mr16373023b3a.4.1750633505645;
        Sun, 22 Jun 2025 16:05:05 -0700 (PDT)
Received: from io.local ([159.196.197.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a46b569sm6656212b3a.20.2025.06.22.16.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 16:05:05 -0700 (PDT)
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Ivan Vecera <ivecera@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>
Cc: Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] i40e: Match VF MAC deletion behaviour with OOT driver
Date: Mon, 23 Jun 2025 09:04:41 +1000
Message-Id: <39898c5f9a1d6172aa346ad96a831a899a58ec54.1750633468.git.jamie.bainbridge@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the PF is processing an AQ message to delete a VF's MACs from the
MAC filter, the Linux kernel driver checks if the PF set the MAC and if
the VF is trusted. However, the out-of-tree driver has intentionally
removed the check for VF trust with OOT driver version 2.26.8.

This results in an undesirable behaviour difference between the OOT
driver and the Linux driver, where if a trusted VF with a PF-set MAC
sets itself down (which sends an AQ message to delete the VF's MAC
filters) then the VF MAC is erased from the interface with the Linux
kernel driver but not with the OOT driver.

This results in the VF losing its PF-set MAC which should not happen.

Change the Linux kernel driver and comment to match the OOT behaviour.

Fixes: ea2a1cfc3b201 ("i40e: Fix VF MAC filter removal")
Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 88e6bef69342c2e65d8d5b2d7df5ac2cc32ee3d9..45ccbb1cdda0a33527852096ee9759fc19db3a5d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3137,10 +3137,10 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_vf *vf, u8 *msg)
 		const u8 *addr = al->list[i].addr;
 
 		/* Allow to delete VF primary MAC only if it was not set
-		 * administratively by PF or if VF is trusted.
+		 * administratively by PF.
 		 */
 		if (ether_addr_equal(addr, vf->default_lan_addr.addr)) {
-			if (i40e_can_vf_change_mac(vf))
+			if (!vf->pf_set_mac)
 				was_unimac_deleted = true;
 			else
 				continue;
-- 
2.39.5


