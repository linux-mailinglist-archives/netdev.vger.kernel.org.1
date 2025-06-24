Return-Path: <netdev+bounces-200876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F369EAE7327
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 01:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C712E1BC285F
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316F726A0FD;
	Tue, 24 Jun 2025 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/lOJUr+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C3A307496;
	Tue, 24 Jun 2025 23:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807782; cv=none; b=HQLiZ6fiKuUVs4xS0nwnpg13pLpZUzUbh53K6lSKHaSHVCMQdrbf5tHKbO/qtTI55tJq9xi9U8iCxINQ022XxZGa9YEYIhMVhNvyQJxEFHZawY4vG+aA1rWvrgZqGlnD+z5q+Z19SLM8EfPQpgx1bkahRgAhqF7l6hfW2xf6U8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807782; c=relaxed/simple;
	bh=xR1VxE1d3RNG0sLv7RMcv3K5Qbpf5L5T+lS6bx5Hmgk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W39WZr12tBd/U7jSbta6Ci6iewcMlYRbO2jn3UAcrOm7oas0epm4MZfjpJNOpwurKe5A+Y4Fisb/5sVBJCWjFYbEidWLksxM9vqDr7UCC/MNfg4roZTMBNz7OqCjxcgQgKcRLLv+us53yoJyJLZJaoNxiWENXWjMZ/j+RGBq/gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/lOJUr+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2360ff7ac1bso9401685ad.3;
        Tue, 24 Jun 2025 16:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750807780; x=1751412580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n6fm/H9Stdspnutu+TLyawJSiAgcj1Gfpx7qEAHQgQE=;
        b=J/lOJUr+qAKL3nc4Kmy7nDI3freJmEBPKGKbItWlETYPh0NG2DY6noWd2/RpezIseX
         l5ViOqA31R2dQsIzaNOLeKU0y4SFgdIYD4pXSV0dJpqDGfhteXVK1a7M5tTsbxQbscxT
         VMoFiFV9V2rir3ankgxkPa5n30bfxycAayeANUZO4NXdCrHh8XnfQfdouDpRV9unTAy1
         u1LK9bkRw9LS7Y4M8Ht/sAOt3WU5iiu8H8LPPANExd/8ZhKvp07ORx0VP2SjW4vW5nux
         ahxTJCjQEzVBS9EwxKvaqOq1FZhafdZemwQaw7PDpC3lv6KCiWM1mShacfSdYKoQBfbi
         XmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750807780; x=1751412580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n6fm/H9Stdspnutu+TLyawJSiAgcj1Gfpx7qEAHQgQE=;
        b=Wu6R3cVbdVmQ2utfU1sbk5zhiwEbzD9ku9fjQpEtWLVB4qMxQWucWlfzIWJFJ0QB99
         bBHU0FSW0dV3ZYKgrxvdoYx9mFnSQBLaxmZ06cE3pRdinhKdiIOqDosmaBUwXgUj96K4
         7CT9h6kuFFyYKCPDYx5bQJvpqB28YjR6zhBjP2dAElAzNtVWWO+KoHWaiBpahV7MaGXg
         dOi/9XxQrDwmOybbwR3tkF9TyPc0AbNAT+Gc2tsHNM15VAsXyyHDYcuMIImmtyJoQ/J0
         VgkA5X2i2l0UqMGFpgWcQxa9ZmJIWq3geNjEGEjGByLrdlW6kiWPNOSo5LkeOrOopiqN
         ibOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqeNCn5M23oKt9a8zRZkifIhJDsJhkyP6JS0iizwQO3d3xsY8Sq5I7I+vg0cRKp88/sqBXzF7h@vger.kernel.org, AJvYcCXA7CpgpogGGnfMNmDTpyYGSQrMHVQKV00YIVp/EQacqubdJ3G//2E20GG1M3/7krldWKcGfkJELdRHD2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg59jjB7z3qVfM6ab6cS5V3BiaH3hxNF9+seO2XKk90Rx0X2We
	ciATm7hIZh+m8kT1L9CpAPxE3+aoVNdyY7dEUCa1zljxE+GIqRQUILrN
X-Gm-Gg: ASbGncvlZ/lVqj6bel9/hlhnZ2cyO2S6lVnOeObyNzGrHvELYjG0ZLixBj19oyN4dxv
	8PeUPGEaVXt04Ui+AQUGOv/vjCfFX4CIRnzi1KpAbzM8c4eHnNW+i01pyPxqdytm/Q8KXpvoNZ0
	MNa2z3vdqfEeNYd1xgpWVwDx/7axIzs4C0FPoIBfac2IYVe47vOM3xyIUvYymVDGlwgVoVwl7ge
	QpmtIxvTCzYDBSbPbJ3F1jb8BvLcF8+HaYSkWNAuW4X9Lo5RGE1JC4xtzRYQe0WjFK5/nBy1eYg
	YhvBeywXHn2XBSAwW2ZsyHmu9sTeokuk4s9pAPfkGk3rIPPMuTwuiUzkm8WuHpXtHg==
X-Google-Smtp-Source: AGHT+IEurEcCEzFHGYcLfmTMbllSIDe2jA403j16rnCUXO3D2XMiCx7Vj1ahivKWJW0hYGsPajBJ2A==
X-Received: by 2002:a17:903:17cb:b0:234:a139:1206 with SMTP id d9443c01a7336-238247833d9mr17774705ad.40.1750807779696;
        Tue, 24 Jun 2025 16:29:39 -0700 (PDT)
Received: from io.local ([159.196.197.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83959dasm121584645ad.2.2025.06.24.16.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 16:29:39 -0700 (PDT)
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
To: Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Ivan Vecera <ivecera@redhat.com>
Cc: Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net] i40e: When removing VF MAC filters, only check PF-set MAC
Date: Wed, 25 Jun 2025 09:29:18 +1000
Message-Id: <c856f16e6ab37286733174c0fcf12bc72b677096.1750807588.git.jamie.bainbridge@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the PF is processing an Admin Queue message to delete a VF's MACs
from the MAC filter, we currently check if the PF set the MAC and if
the VF is trusted.

This results in undesirable behaviour, where if a trusted VF with a
PF-set MAC sets itself down (which sends an AQ message to delete the
VF's MAC filters) then the VF MAC is erased from the interface.

This results in the VF losing its PF-set MAC which should not happen.

There is no need to check for trust at all, because an untrusted VF
cannot change its own MAC. The only check needed is whether the PF set
the MAC. If the PF set the MAC, then don't erase the MAC on link-down.

Resolve this by changing the deletion check only for PF-set MAC.

(the out-of-tree driver has also intentionally removed the check for VF
trust here with OOT driver version 2.26.8, this changes the Linux kernel
driver behaviour and comment to match the OOT driver behaviour)

Fixes: ea2a1cfc3b201 ("i40e: Fix VF MAC filter removal")
Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
---
v2: Reword commit message as suggested by Simon Horman.
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


