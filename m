Return-Path: <netdev+bounces-246800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C797CF1365
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 19:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A0773011420
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 18:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8168288C86;
	Sun,  4 Jan 2026 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHXbcN5B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDEF72610
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 18:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767552122; cv=none; b=IlLbK0NXW0kIEpx26vIDhMHScfVXdJKyZTB0PI2fHiqSoSVXNuDP4TiFOmdvuCKXV14IOS7IDY+H9321yVYDRmctcZzkLhUHrLz/jZotJ4fKpeDv6aM9g6KwaV3DkYuLCGaI7T1XS1yeORiPmt7O24CJUXbRWMH8I+v/WhdQymM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767552122; c=relaxed/simple;
	bh=2IR9K9fFwUyb3vK1T1dQvAvM/jN1tGrfN72mQMj/cpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NDoFdCpC44zPAgUU7Cw1E67M75JgbAamAG15Lb01XNEGnvls9cQamolI/Rn6EG4rKMU8/x8uSCsso8rYua4sIi4antxjqDLhcQwTUT2Znrf+k2r4qPVjHm3pSxwph/fIpJTQIParTgHiaomCsS28eCa7Ejhs9mQE6e5ENKfvn7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHXbcN5B; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34c902f6845so18926356a91.2
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 10:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767552121; x=1768156921; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZJpugnwNeH6pltmuI9tKkzaUCo5szMqMArK7fNoASs=;
        b=jHXbcN5BfSHJn4YS2srysffTX6KMaF/yndSGIRWKdjzIbxTbFSnYtpmOdWdjjrQAgs
         SIlhy/0CJq4syO8pdMKtVPi+RezG8PHvxpkgVElsRsLR289Qe5fYO0JpaJJ6X/2KuPxG
         xxpKJyCNL9fG7vCU2/YBYyU/cPtcp0tEHq45tRYgd/bT0WSxfV+vILlrjhV1/9DXGaZu
         B8axy1cRtRA2G4B/I7yyH9ra7UXj+jNfglKNAjpUi4uBfdBERd3SG2w4c0Vfem82Wwt7
         ONBIfSlgGUYugZUq1s8SZLs9htaa1ODiZmoPHQDr2K1+1lEjxxolCRW7jO8oCVbBT1Qw
         qERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767552121; x=1768156921;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+ZJpugnwNeH6pltmuI9tKkzaUCo5szMqMArK7fNoASs=;
        b=RrEzWympKlSEmqK6MIM7lL60WMQvxFYtoBS0QjwaQJM0D08hyTKTa3NPLCA3nqDBw+
         j8x39Iet1FZMeMtJSWo6LSvW4aIMWMxnzkHIQ1CRKWR4LTjRNjZMfUotRokY0Zy9PdXg
         BTMwtMTrm1V+svo5gcRYDIllewD/N5I7A0iPpt5WYbvamKl3fjC283KpAaMGaAI1CgLU
         D0f40ZWFS+ZtsYcTqKYfxb6rLxUrY1uMEuMSqiTKEJcwAnCenHxMMdxlMI/lrzFvKXZD
         Spe3a9EuK9Fhif8bbMPyWdBSdp2TT10RmAOE5iwDA9TJggtGMu+3KnZoQrCB0jpWG8/x
         xb0g==
X-Gm-Message-State: AOJu0YwX2ruLyjPpPsIAZ+ODzcikFWubkw2oBBNXM0FohJeeVm0/5AE3
	JzqKRfnD/ZQ7Idtysj0ulTTtRm3TRz6P1CIOG4vT1qftaV6JOe0UzbO+
X-Gm-Gg: AY/fxX74ZpAXdBEFpmNXXJum6zwX30Frc3x+aVWkDyRAJVIkpFb4Xh6xm22lWFskPYZ
	wA3WcDUMys80n7JzqBBTdXIgVGVouVEsnUHrAyAY0KIFk8J3Vzi1KoCobrEFmREoz/OxaCIhezU
	PMXesXevs2P+KRrQVeBajL7vNSBO/6p2kylCBYlgeK0pZZ/UZ6aCimrVcFNE2I3AY0l9rjr9r5W
	v4Yi83a3ZrJOkWd6P7wUSrk2m1xBLuJR0/8qve8INC3DB9wZfgxAKG+kPdrUdS389LrQ3F3hDK2
	949MvRlD4RrES/5CPbKl+TWLCZ+I9tshKOenXUkoskdKLENkK79qj3YyWKL6tMk7ubdvq4kjlsj
	QkXmUTSkxvmpaTo6FdPD32BMKGeI6osRxU6V5P3/VHtqQ9IwC/mLGIQLlPnVkBuuaNjzLGzuuSr
	HCAvUmTnJQyaP1JQbp
X-Google-Smtp-Source: AGHT+IFgDO13laBgR4LGNEYbaTLIFrlJZEzUic2bWc2F0XYpOVbwq5tHYtyBT4UbpixuVU/XuYD9zg==
X-Received: by 2002:a05:701b:208a:b0:11d:f81b:b212 with SMTP id a92af1059eb24-121722b27edmr35673494c88.17.1767552120496;
        Sun, 04 Jan 2026 10:42:00 -0800 (PST)
Received: from [192.168.15.94] ([179.181.255.35])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254c734sm170975553c88.13.2026.01.04.10.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 10:41:59 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 04 Jan 2026 18:41:14 +0000
Subject: [PATCH net-next v9 4/6] netconsole: clear dev_name for devices
 bound by mac
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260104-netcons-retrigger-v9-4-38aa643d2283@gmail.com>
References: <20260104-netcons-retrigger-v9-0-38aa643d2283@gmail.com>
In-Reply-To: <20260104-netcons-retrigger-v9-0-38aa643d2283@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767552086; l=1518;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=2IR9K9fFwUyb3vK1T1dQvAvM/jN1tGrfN72mQMj/cpo=;
 b=HHavGEkPJ8xbid2UCwSa5wsmGmUarwYg/Ad0iqOlkjCOIfK6OXlsEqlCquKnMu2uLZkvF5k82
 KjqfTUYkqz6DFl0o+9FlBaLmWTrXO83gFkEGDI5/Lfde1OTihiC74hS
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

This patch makes sure netconsole clears dev_name for devices bound by mac
in order to allow calling setup_netpoll on targets that have previously
been cleaned up (in order to support resuming deactivated targets).

This is required as netpoll_setup populates dev_name even when devices are
matched via mac address. The cleanup is done inside netconsole as bound
by mac is a netconsole concept.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 7a1e5559fc0d..02a3463e8d24 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -242,6 +242,12 @@ static void populate_configfs_item(struct netconsole_target *nt,
 }
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
+/* Check if the target was bound by mac address. */
+static bool bound_by_mac(struct netconsole_target *nt)
+{
+	return is_valid_ether_addr(nt->np.dev_mac);
+}
+
 /* Allocate and initialize with defaults.
  * Note that these targets get their config_item fields zeroed-out.
  */
@@ -284,6 +290,8 @@ static void netconsole_process_cleanups_core(void)
 		/* all entries in the cleanup_list needs to be disabled */
 		WARN_ON_ONCE(nt->state == STATE_ENABLED);
 		do_netpoll_cleanup(&nt->np);
+		if (bound_by_mac(nt))
+			memset(&nt->np.dev_name, 0, IFNAMSIZ);
 		/* moved the cleaned target to target_list. Need to hold both
 		 * locks
 		 */

-- 
2.52.0


