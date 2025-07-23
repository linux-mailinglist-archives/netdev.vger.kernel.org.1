Return-Path: <netdev+bounces-209269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A441DB0EDBC
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB92E174CD9
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F9F1F4161;
	Wed, 23 Jul 2025 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="Vudu0XRU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493ADAD23
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260909; cv=none; b=EhL6pXRUAtjQhK+zOh6OeWSAbjZkgwsWzP6US2PMmC+8G32r+Kk0NhQYtJt621CWncysZKwre2yXT1cgTcrYZEai/rer2HJPwNuZwt/8lFjc4ZOZ+b4fKZXK+aDPMqwhVeuRMikidDaBj0MKCD1fzR3sfUI71uZxidF/28CvBGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260909; c=relaxed/simple;
	bh=CGjuH11JYYhfgU3mhLJqmXMykU2e1KvTRMZc7rkMEic=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iUxH0MxaxRpux/9Ygl9gYMVEJPL0z4fHMJFQ3Njz6uL+lpV5leXWjmsGcsRbGyWoPqre7oF/BhqF8yM59lzAZgzOYKM/fVn5m1XFeJcXrpsjlM6a//TZaZCWKPKCGTLYuRtR+oaJMzCuK5tD/XCwtaOXsxVo/EUMkufNz8PFgqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=Vudu0XRU; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso11027341a12.0
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 01:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1753260905; x=1753865705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OO3hkZCI/hl9D2rt5NQeL5ZTj0MVc7ns0plUwyPF45U=;
        b=Vudu0XRU9XY4bKraUNiUPiVwixcRX3ZdkVMKRH4lhIi65N7A87cTk7rIAnaOld7uYW
         nBjIC+NIWnXCFncDznYeSe3UshpSjPgsqah6Gu1DFhHmDdrP04wIKhEcpvDVU7vvTq+F
         +LoEaSYUWOaPakhsL9eieROqTC6GWU6XokhROzYU2AWqzaDbMn6LB6IJGfxK4GXsy3qX
         YPX6xhjk8QrwjN7MMmUQ4+cDaqOkVH8AA2DaZHxJhJ8ugIL0YpGD6cV4anQZkDprLsv0
         4rT0d9I+nZgZeE5J9uFIpey82HKdTZvJdOUDha8z8ld08YUseobXnhgYLOX9ZYc0FzvC
         zU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753260905; x=1753865705;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OO3hkZCI/hl9D2rt5NQeL5ZTj0MVc7ns0plUwyPF45U=;
        b=GwRwOWEL3913iMV73fMoTn90o/+iO9+BRcQ5STVDa1UHso8uScdlaUiWAbn8uqdNXR
         5fNbWlnwtBrglC3pJPTBQHy+cFoezt5npU2fxNtyjEbCfO9BHuTpDtfZ5LHzK/8TjPJ5
         n/UBOvONQ1iEtQ10pTSHoL7DpmO6qIdBqUFOtLPwuQxjiT5/zRHmEh7wV1xLulP1lyCT
         rqsqCGDstxubZx7aIKtQSz8oKicfaVqms7r2uSSSwPGAdjZcEo5Md7Y+Q1TcVmCqCt3a
         NyBNXPpNdwrIaNZeMtfbRi3aie+5tEzEsq2c23HtCn76DdeF0aUSKLKMnb/0dIAs1yFm
         jLKg==
X-Forwarded-Encrypted: i=1; AJvYcCXWtRyCAPv+n60HYzNyMUD/v2scj7rz8APfID/ZZgsmoW1Rfw0bHb4TYnr3/hSQgC6lNSJvsu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcAbETTPhz33OqzCzD0QteKd8AErE966/LubmGgH5VqL3Fwo0r
	iTEOrWIg7iglTgsLfVDuzWv+8ZbqEae2ew6fVGAHvZmHSpnXXJV3Bw+5vArVLmgUjw==
X-Gm-Gg: ASbGncupNrqF5yz3qDkCdTvi52oeU1fbd099mW98Q7UFJPkV9+FC2oQa+HNFIl1gan5
	iZVvf1DL6FWt2obWBVDLl9XXXNuHFEb0srqYh/YOMlqdp/vovGjXkyVBtXfuGTol2GsQXGprs8G
	gHW+geysT6kmqzNfrNhJXfP5lodPdnd71NJITBqFRarnhNbu/Jndg7RDnpGCFfq9oG07c0SpR5W
	JVuuUcbIk7PjRo4hdFh9IE8f2VnJ/TzvxwTAELeSv97RbY3rPyuwSf9kkn4BkkzaelLfCBCK2N+
	mTrle0EchE6IQqWdal3wUcvuUax94vd9SEbWBhtTup2NFX7QglsuIvbaeuCmGfXVG5htNix+7iE
	9ASJB0iXMg1XyehlhKIghKST9
X-Google-Smtp-Source: AGHT+IHugY9AzEC6chudp2ZjRD4/AKt/gWnSYmnh8PGoxNyHRfQxVx5J4iw534Ri7XEBn9ICeBaNoQ==
X-Received: by 2002:a17:907:6d0e:b0:ae3:69a8:8da4 with SMTP id a640c23a62f3a-af2f66d4f13mr173312266b.9.1753260905321;
        Wed, 23 Jul 2025 01:55:05 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79d6c6sm1015408366b.32.2025.07.23.01.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 01:55:04 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <e16d5318-3e5c-4a4a-a629-ba221a5f04c5@jacekk.info>
Date: Wed, 23 Jul 2025 10:55:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH iwl-next v3 3/5] igb: drop unnecessary constant casts to u16
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <2f87d6e9-9eb6-4532-8a1d-c88e91aac563@jacekk.info>
Content-Language: en-US
In-Reply-To: <2f87d6e9-9eb6-4532-8a1d-c88e91aac563@jacekk.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Remove unnecessary casts of constant values to u16.
C's integer promotion rules make them ints no matter what.

Additionally replace IGB_MNG_VLAN_NONE with resulting value
rather than casting -1 to u16.

Signed-off-by: Jacek Kowalski <jacek@jacekk.info>
Suggested-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/igb/e1000_82575.c | 4 ++--
 drivers/net/ethernet/intel/igb/e1000_i210.c  | 2 +-
 drivers/net/ethernet/intel/igb/e1000_nvm.c   | 4 ++--
 drivers/net/ethernet/intel/igb/igb.h         | 2 +-
 drivers/net/ethernet/intel/igb/igb_main.c    | 3 +--
 5 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
index 64dfc362d1dc..44a85ad749a4 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -2372,7 +2372,7 @@ static s32 igb_validate_nvm_checksum_with_offset(struct e1000_hw *hw,
 		checksum += nvm_data;
 	}
 
-	if (checksum != (u16) NVM_SUM) {
+	if (checksum != NVM_SUM) {
 		hw_dbg("NVM Checksum Invalid\n");
 		ret_val = -E1000_ERR_NVM;
 		goto out;
@@ -2406,7 +2406,7 @@ static s32 igb_update_nvm_checksum_with_offset(struct e1000_hw *hw, u16 offset)
 		}
 		checksum += nvm_data;
 	}
-	checksum = (u16) NVM_SUM - checksum;
+	checksum = NVM_SUM - checksum;
 	ret_val = hw->nvm.ops.write(hw, (NVM_CHECKSUM_REG + offset), 1,
 				&checksum);
 	if (ret_val)
diff --git a/drivers/net/ethernet/intel/igb/e1000_i210.c b/drivers/net/ethernet/intel/igb/e1000_i210.c
index 503b239868e8..9db29b231d6a 100644
--- a/drivers/net/ethernet/intel/igb/e1000_i210.c
+++ b/drivers/net/ethernet/intel/igb/e1000_i210.c
@@ -602,7 +602,7 @@ static s32 igb_update_nvm_checksum_i210(struct e1000_hw *hw)
 			}
 			checksum += nvm_data;
 		}
-		checksum = (u16) NVM_SUM - checksum;
+		checksum = NVM_SUM - checksum;
 		ret_val = igb_write_nvm_srwr(hw, NVM_CHECKSUM_REG, 1,
 						&checksum);
 		if (ret_val) {
diff --git a/drivers/net/ethernet/intel/igb/e1000_nvm.c b/drivers/net/ethernet/intel/igb/e1000_nvm.c
index 2dcd64d6dec3..c8638502c2be 100644
--- a/drivers/net/ethernet/intel/igb/e1000_nvm.c
+++ b/drivers/net/ethernet/intel/igb/e1000_nvm.c
@@ -636,7 +636,7 @@ s32 igb_validate_nvm_checksum(struct e1000_hw *hw)
 		checksum += nvm_data;
 	}
 
-	if (checksum != (u16) NVM_SUM) {
+	if (checksum != NVM_SUM) {
 		hw_dbg("NVM Checksum Invalid\n");
 		ret_val = -E1000_ERR_NVM;
 		goto out;
@@ -668,7 +668,7 @@ s32 igb_update_nvm_checksum(struct e1000_hw *hw)
 		}
 		checksum += nvm_data;
 	}
-	checksum = (u16) NVM_SUM - checksum;
+	checksum = NVM_SUM - checksum;
 	ret_val = hw->nvm.ops.write(hw, NVM_CHECKSUM_REG, 1, &checksum);
 	if (ret_val)
 		hw_dbg("NVM Write Error while updating checksum.\n");
diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index c3f4f7cd264e..0fff1df81b7b 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -217,7 +217,7 @@ static inline int igb_skb_pad(void)
 #define IGB_MASTER_SLAVE	e1000_ms_hw_default
 #endif
 
-#define IGB_MNG_VLAN_NONE	-1
+#define IGB_MNG_VLAN_NONE	0xFFFF
 
 enum igb_tx_flags {
 	/* cmd_type flags */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index a9a7a94ae61e..5e63d7f6a568 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1531,8 +1531,7 @@ static void igb_update_mng_vlan(struct igb_adapter *adapter)
 		adapter->mng_vlan_id = IGB_MNG_VLAN_NONE;
 	}
 
-	if ((old_vid != (u16)IGB_MNG_VLAN_NONE) &&
-	    (vid != old_vid) &&
+	if (old_vid != IGB_MNG_VLAN_NONE && vid != old_vid &&
 	    !test_bit(old_vid, adapter->active_vlans)) {
 		/* remove VID from filter table */
 		igb_vfta_set(hw, vid, pf_id, false, true);
-- 
2.47.2


