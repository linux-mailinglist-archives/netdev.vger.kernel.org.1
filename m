Return-Path: <netdev+bounces-238941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D64C617E4
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 16:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EBF283596FF
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 15:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0A630C62B;
	Sun, 16 Nov 2025 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQJ8AMob"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5C13C1F
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763308627; cv=none; b=dPMNvTjour3/gXNcFSE4VAK5lClHLPY+vN4ct5CRxz51vERBhlO4IPHBOUJJ692a1NSncaH4VQTxqOCStaPBl6zfsp51Di4/GsNg22nwh2V9qAI9UfuQGftqn9qd9Zsf5T4OzET+S0cc08DEaYzMkVmw5un1FPlkZkQ07uc4/yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763308627; c=relaxed/simple;
	bh=ufCbvxIRBVQHCzUSRhXUdWL2YVW5ycqhQc1EXb99qW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YRNCA+UI3EfuvMYrqRO/ATg+F6ZtFSXjxqBdcTRq34tXmM9sM70dJg3rEjPTZ8JOTDDZxgSbKwlUJLFVRQ3zneBqzwhKCNBUaSVp0fWXcpX/wZozOl1qg1R6ov6KON8eHQpX75RlOpAMRJCQuhFAByr5IJXpI/8+Vszro7SX8CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQJ8AMob; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b9387df58cso4740534b3a.3
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 07:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763308624; x=1763913424; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+K9MAxb4ZBBa8U7x004Sm9bCoWfglzoRMNcWRH1ZAc=;
        b=JQJ8AMobBU7f8PU3aj6iVS2Cqyoi/eAX6SxA7yabzfcqg/6Y+zjHPN7RDEI6V+RCCH
         dyT0ync1+AiDIDrvFk+ymgfCbYxoNkwQ3LtmL4iQ9y78yuXqYcD3lztNevdt16QTuDdP
         D5BuvlU+1M4cgrZC2XO79fx3h9fFFljD3qtOwoViXpFFfQU5JCxbrlzOmfNHKBPbbaD6
         JJHI2XBDDXruOpDYgjjYXAd6yHULeFca7jk9168joIepezt9SZyhW0pmzhwK2soSKbUk
         /PjyxBCU3GV+08U/qQNEG4fgZ/UNsW7v4BDIbM8VPFzbpi/JogcaRPLbh1YfdrzlCA1i
         itKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763308624; x=1763913424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R+K9MAxb4ZBBa8U7x004Sm9bCoWfglzoRMNcWRH1ZAc=;
        b=H7cAIKelnwm2MqJ0JHI6xRL3J5i6n/Cx6YxjTEG9xwPAUW2htYOxiOwNXI7QqmR4A6
         6qUdE/1g5SbS03Fwfv/QGyu1WGqAPVcTL0OqNjojUFBfk81Vspv4w9tcIBb87gYZZchu
         79Tw5SpYPwfEX0OnKS5QAc+uTYkWageJz3n42oHbMkbeWd9973ge1HJ7rUr2bwR1sI5h
         PPK20i9S4W2+8sluriNaDr0ichfND4nmT+hY4iepC14yAzY74wvQpB6+4gAa8/W1oQeH
         QLXsHA6FuHWrnSeOTwblM21hYvGrCeQGE1Htl8KijvDTDIGuBbdVMzNA7vawVRX0dHTZ
         E1yw==
X-Forwarded-Encrypted: i=1; AJvYcCUkKk5lFobuaHKiRjpSqh6PdR4XR3u/H9fe2jhtemPGyC6C9X9Bq8P0yzk3NLHwA+qtnbiUqVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySlvxR9nKVh1dsE3f6dRjyfgbkWB3O5wssZDQI2qyIg/8wqplU
	nkB7ux2z5gXqJDl/fE24DTJITeSKvCVNBzeDHX1Hc0mQxKEFGeKl6aBX
X-Gm-Gg: ASbGncuGqsAHEwSEYRvpwD9VZe+bFRw1KpDH3BYEGKgfeLdi5S49A6m1Uhsv91C8mrc
	TTTYPCP3Mh3Q9ilZCcS2uVI/PcFO/uF2NusPiW202XJvQgEDn2TP/CDpo10nByIrRfEsSyDzzhQ
	Q31G1qP0zSQeAlaJTyZj0ksTpXlc+jM4BTO4MD/x9WWvYdmTyjuCLNXy6e3Vk3l1hihGpoPKNOj
	0Ql8SWiJqkHThTIV0s9KIalTTp2uI091vK4K5zHqPYBIrCB82PS+IOwxbYpwSRHthgcabzDW762
	AhK9Mq/ltMY0V1N1TtZCU9z1edoq+CQQj8NklNKIH5qA+xltmQAvH1V1xcMO2bpJAm3+s5AFblG
	NV3jqc03WzuS1sbfPr2h4ibp6egv7coSikU3cVcWVPYsxvAFs3R+dY7xt6jmpCDrkE6FIXBIfRx
	jSJTKupcSeaZss11+PO2Q=
X-Google-Smtp-Source: AGHT+IEBONigJXUH6CJN+6b8wVtJBo3FEOVEJ//SL5EdSu5yo0atK7Q9DdGnua5zoxWDyWpCtDj7FQ==
X-Received: by 2002:a05:6a00:4fcf:b0:7b9:d7c2:fdf6 with SMTP id d2e1a72fcca58-7ba3b89ed15mr12770157b3a.24.1763308624240;
        Sun, 16 Nov 2025 07:57:04 -0800 (PST)
Received: from aheev.home ([106.215.173.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924ae6943sm10677038b3a.6.2025.11.16.07.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 07:57:03 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Sun, 16 Nov 2025 21:26:48 +0530
Subject: [PATCH RFT net-next 1/2] ice: remove __free usage in ice_flow
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251116-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-1-0ddc81be6a4c@gmail.com>
References: <20251116-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-0-0ddc81be6a4c@gmail.com>
In-Reply-To: <20251116-aheev-fix-free-uninitialized-ptrs-ethernet-intel-v1-0-0ddc81be6a4c@gmail.com>
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
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDIlv7hsWbJ8z5+NfBeCFsRmXr8eKFP1Xzd55veX3yav9
 t7w19WitqOUhUGMi0FWTJGFUVTKT2+T1IS4w0nfYOawMoEMYeDiFICJ2DYxMnzIq9Ey0A2copeu
 KZkZxzi7rnD2sfVTnplmCtxcGMTTdZrhfxJnvwKX7/75Hl9XnLUtd+Jec07pl2Lk1zT1tjWibC6
 FDAA=
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


