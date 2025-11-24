Return-Path: <netdev+bounces-241101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9E2C7F39F
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 08:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 959CB3427F8
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 07:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C952E8E0B;
	Mon, 24 Nov 2025 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8KGulUx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DD22EA490
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 07:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763970056; cv=none; b=bRPbjzqQ2RhUH3PSM6trN2ST0GqtP/hnpvdnena2YP+jMNlL09oYIy4SMZO2SGvSdtsdcYruLqgsr+8dAbdl7P4QIROrgHOWofCZ3MntgD+sY3z6b6oOWTyvqVdfTOEDpGXS3bszNd7L9LdP2pHE/aVJgEqDvCpPCUEyhEhJBbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763970056; c=relaxed/simple;
	bh=ufCbvxIRBVQHCzUSRhXUdWL2YVW5ycqhQc1EXb99qW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fw2F/NZJKEbd9Gsu1wUOTx+LFxYBAiJJbYVxESA0R0pMK+ngo0UruL5GkcbZxdqcabWTe6ixf89ChJkq1GsM9bvyOWHpsEcxFszTmy5cn5GT2yTycmuxR57A78EvuKuxo5UjuZAX+KSkAH5HvoNP3wYlBtY7/JxhGbAneg3VeMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8KGulUx; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b80fed1505so4518210b3a.3
        for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 23:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763970054; x=1764574854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+K9MAxb4ZBBa8U7x004Sm9bCoWfglzoRMNcWRH1ZAc=;
        b=l8KGulUx7MjlHjMos/qgnBHgPA8K7nTPU3wmGqlkx9ygstXS2OhAD2g73wmJYLnOD8
         QcmO4X6IpNMJMXKNLKOYiaPGRMuLAXlQEDah89teGY1YbJyMgMgljnacdeDJjTheq+li
         j7dDTBX6WHI0gcs0s9IHGi4Wm4aK3r+PgjH2KqGevJyIXR+S+4aQTmhm9oiFycTG062f
         B628nvA5/v+iLeqp9hRX4uaF2EzgWEcrWrvtuhz/BihOcVk86lEEPeY+KwLF+lVkl5HQ
         j6u+lHvpJaNxQUjr4tE/2e0IBKAXwogc/UIIBEA3UygOKZ8COJX2K++sXJwFBb4153fZ
         zi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763970054; x=1764574854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R+K9MAxb4ZBBa8U7x004Sm9bCoWfglzoRMNcWRH1ZAc=;
        b=qnXQQY2GoVuO+vs2zbZVd+FfN9sA99jAQ8Rblsh61rucagXsuhQRPpbVcOEARkNeDU
         BpONBc/kGeLWIYRd04PaUM157IE7B7o3Pu84TogJUzZj3lEx0lL+G1zfqCMpKRyqlRwF
         KKDhqOm3gXm/+O9JJW1OvYLJMd0BXjgjWQMja2W0sBtUXi/1dqGOm8aG8t1qFgY1Y84f
         LeJ12h0kY6FKtb6ycgSR1wHHox5lxYHD7xo89IZ/IhS2HQwuaxVJZEAkeMk/PH/wH/94
         iblyhBbQ5KmsGNvCy87wCzLoiaFRFrkrRG9EIP+rRze+p5yLHZNjD5m5PKL5PDx/zTG4
         Xtvw==
X-Forwarded-Encrypted: i=1; AJvYcCUogsOocrM6HNZrea6V5H5FX2UABPglQY9e4EFGzhmOfyr3oZfRUIlvDV3YZGjCoSuWcKoUQes=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPrcynh/CAuZVBM8/HoT4kIm1DxC/jiZBkMoVnPxFAA0DZAlrh
	LAuvF0CmEVdqaxlrhkCPMFYqi5gLN8HAqZAL9JB4/TRsrVwupZKafb7gXSQUjg==
X-Gm-Gg: ASbGncuv1DJw7/CcXk+/qMjR1hpbjp+v8kFTvX2xadXu+l/vuBBMXLIFqlaThTPVEgR
	eB6a7RlzTR9o+JXfqs+w+7gUDcer15yWjj4cI5PUKNcLUy3WnKnFKTTxTsTNbirlzOLuXh76G6s
	j9LTANpwyPhcclUGxBt0OtzO2A+8DfAGeVQNsk1Myxb14H0khRzrmo3GRxRxo/a1LWGcYQ0AeFB
	LSbdNRIQgZ8eOLzVKguKpB96iM7Ss/rGx5SoD/HYm6Kh1NVNGV6zB05nE4gF37quxhPW26T6B8k
	Zl+8JAvQSDOF83xW7GAapqaG530/JZkiyJyHx/qtFbSMUFiaCLsSAAXpFNl7ThkR9ja9J/hVHmE
	u3L/QhYNvd50SzXCdjvSdQi+ywXjNmH7kFhj1r1xE0K8J/6+cu6D7UQXw3EcylgClmn0vY2nLRE
	sKlmiKkTdaMs14V0Zqgb8=
X-Google-Smtp-Source: AGHT+IEPYnRgpYVEveCbU01kGtjxHAKa5FApKeCv+NruF3NYPEK3DWUd1nec9k94JoygcajJ+fMyFg==
X-Received: by 2002:a05:6a20:729e:b0:35d:5d40:6d65 with SMTP id adf61e73a8af0-3614eaf5281mr12077444637.5.1763970054294;
        Sun, 23 Nov 2025 23:40:54 -0800 (PST)
Received: from aheev.home ([2401:4900:8fce:eb65:99e9:53c:32e6:4996])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f024b4aesm13410818b3a.33.2025.11.23.23.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 23:40:53 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Mon, 24 Nov 2025 13:10:41 +0530
Subject: [PATCH RESEND RFT net-next 1/2] ice: remove __free usage in
 ice_flow
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-1-a03fcd1937c0@gmail.com>
References: <20251124-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-0-a03fcd1937c0@gmail.com>
In-Reply-To: <20251124-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-0-a03fcd1937c0@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ally Heev <allyheev@gmail.com>, 
 Simon Horman <horms@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1688; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=ufCbvxIRBVQHCzUSRhXUdWL2YVW5ycqhQc1EXb99qW8=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDJVuH+fLT8i4MiarX3V2Zfz45EtZhER13qC9RZ2f5gsf
 8Im5cfGjlIWBjEuBlkxRRZGUSk/vU1SE+IOJ32DmcPKBDKEgYtTACaiIMfwV6h4w7q5V16Ixuxm
 UhHxm80bEcQcUJAZGNYclnRZxP/0W0aGQ4tnBK49Nfv1myveZsyHYvm2Hlml7uQwOWOpUkzB7a+
 LOAE=
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

usage of cleanup attributes is discouraged in net [1], achieve cleanup
using goto

Suggested-by: Simon Horman <horms@kernel.org>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
Signed-off-by: Ally Heev <allyheev@gmail.com>

[1] https://docs.kernel.org/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

Signed-off-by: Ally Heev <allyheev@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_flow.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index 6d5c939dc8a515c252cd2b77d155b69fa264ee92..dd62f5f14d60401d6a24cb9f86664425db1532d0 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -1573,7 +1573,7 @@ ice_flow_set_parser_prof(struct ice_hw *hw, u16 dest_vsi, u16 fdir_vsi,
 			 struct ice_parser_profile *prof, enum ice_block blk)
 {
 	u64 id = find_first_bit(prof->ptypes, ICE_FLOW_PTYPE_MAX);
-	struct ice_flow_prof_params *params __free(kfree);
+	struct ice_flow_prof_params *params = NULL;
 	u8 fv_words = hw->blk[blk].es.fvw;
 	int status;
 	int i, idx;
@@ -1621,12 +1621,14 @@ ice_flow_set_parser_prof(struct ice_hw *hw, u16 dest_vsi, u16 fdir_vsi,
 			      params->attr, params->attr_cnt,
 			      params->es, params->mask, false, false);
 	if (status)
-		return status;
+		goto out;
 
 	status = ice_flow_assoc_fdir_prof(hw, blk, dest_vsi, fdir_vsi, id);
 	if (status)
 		ice_rem_prof(hw, blk, id);
 
+out:
+	kfree(params);
 	return status;
 }
 

-- 
2.47.3


