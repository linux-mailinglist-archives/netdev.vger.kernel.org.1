Return-Path: <netdev+bounces-209268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DF1B0EDB9
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22D4965634
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C81A27D782;
	Wed, 23 Jul 2025 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="aX5Qiwi3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489AB1F4161
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260882; cv=none; b=djmNHZOg+PD1q6+OToURIGqqC33AEo/bnaSw4Cs36AF+Fi/cMybHPeGvb6HMQ+qToUIBUNxs9fg5S5XjPBTcQ9sMuTBKiYMHCCBQt9jvHHVsD8Ut9+wE8GX7BTH79KYUHCJZHB67fQbH7JzUfgSjU+i0ru+tXrqH43JrP1MUtPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260882; c=relaxed/simple;
	bh=+rLNi8hdwE7eAXck7vZuEushjpC3w1nCuid/aY7jHnc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LrGRENjamdZ7vKHponTrPXgguNgpiCA4Tvs4qncpj0DvJd1p/Ps4+JzCONtFIbhwTH/sODQvvTdZbt9cpOlSvwqG97ZS9XobzJlWOxrppvYYLOtgeuZzRd1yEczNbmoqhlKYt70j6xwDMerli60edmQgcp2v240c0YzJfzEu65k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=aX5Qiwi3; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso11114533a12.2
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 01:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1753260878; x=1753865678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qo1JjA/ZHOZHQaFQYL9U7DcUFDkVhvHL8/LrZDqAz9g=;
        b=aX5Qiwi3pNAqmSX2UpW8BJt93PNHNwx1IJQZbZdzi0pkOUPiw4NxNWggzfx1F48fL6
         /O06uPPNbLsf4sWB0WJCoqbMBpxCiyijCfbJ2jdBnRf3HjqhPbY3dKY4es8T7CIkLQz8
         x9a9K4fWbtu6JNKBjQDHPpqNACnUba0ZOrKGZ6if6b0zgwO4wKO50K4coXEtYNvveBuM
         7nlZqkvCSoVB9867rNGi9tnB0UvhaBeCniW+T1Xbvxbx24XhNLtfbbu9lncHZ/3QfLpX
         jptqEnLQQg2LKUI+uV/4Tl9wz4ZwsGaSd2oWx2ZIGPoTl10Wu0v+LsUdJV5Pcy+dR19x
         sn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753260878; x=1753865678;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qo1JjA/ZHOZHQaFQYL9U7DcUFDkVhvHL8/LrZDqAz9g=;
        b=tYSBlYjd1WhAwrlRzM8mAayOALlywMk67s5I2g6UT92eyFpCArhorBAwthiKsZtlBO
         FDTR1OkUA1J/5lvKJnULdWUAp/yXedSptXqYHsCvrcXn3WOnhqdRSco98cZj4THNCF+u
         S337tOX3Uk7XRQ4L847SpaeJy1J8PCcIKBMgksEJrepW1xAORxySWPnQ5Vro/xVskrCA
         z04Xl4vaQsZ/iiwec9xt3Y3YJi7PRAMr04J/Y2s+U5sr8eAKHZpIXuf2IDbIbIP3lZ/w
         1bvGlVQdpyjjLfnggsc6Oc2C6FyKFnEStjELzKdPEcS7fODNeqHd7zWSFFrOQdM2ykU/
         rcNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJtebDG0XKYWb1fori7eBRcUa2RWNbuHDfk5NWQ1nWWtTLedEcbxaf7k0UhMRWfQjcsTnf8uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydhQTaFFLq+o4jeXvhZmg4tD73/XrAvsXognnJzpLL1rAlDCxQ
	3ROEETszMB+2V/hu4udwpzm+EJZmt8rSfVqCUaubTXPspA3wA1U70pWk2778y+zTcQ==
X-Gm-Gg: ASbGnctH+jOf0cbcOAI3GNw5IzolGaGeXdMYJg/UfSRZSUP682ydiL9K9pmrmTfZPtj
	JmcymEuMJ+fgmgQifQd1r/pPDijsUvmIP/sM/udFmktXWZIReeeLD9FdUWIVIZMsdZLD69AD7kd
	1yf2RC0FsPR9ToFMXqbcgQoLePgm3RmBarmfWoIQ6qRViwTymX13HAXx/9u9SKYaFynd3Irpf+5
	Y4rLt2DoB/ZQtXkbwu7XiiPled5uIhrcp1k04ocLmixmS4tfCTqR7olJ6+H3nU5gdHrEV5rpP4v
	827zArwdQpBrboQF55xQys0NUqAzvx6eh4lRaXzRjU78UvMuqGlyVYO/kXe88tMfxNlUHt2xRWf
	Yx0jrBHWEU0cducd/HbO8uWVY
X-Google-Smtp-Source: AGHT+IGnmMk+0kiIX3NqiPRuuUf1SFPcGJGD6KepEiqMgcI2JDIyFsHCFHhAddW2P9MLUPMB6KmmXw==
X-Received: by 2002:a05:6402:3492:b0:613:50d2:8bbc with SMTP id 4fb4d7f45d1cf-6149b5d46d9mr1851549a12.33.1753260878447;
        Wed, 23 Jul 2025 01:54:38 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612f15f596dsm6415041a12.51.2025.07.23.01.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 01:54:38 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <6d05300d-e5d7-409e-8b78-a7c3da21ed32@jacekk.info>
Date: Wed, 23 Jul 2025 10:54:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH iwl-next v3 2/5] e1000e: drop unnecessary constant casts to
 u16
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

Additionally replace E1000_MNG_VLAN_NONE with resulting value
rather than casting -1 to u16.

Signed-off-by: Jacek Kowalski <jacek@jacekk.info>
Suggested-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/e1000e/e1000.h   | 2 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c | 2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c  | 4 ++--
 drivers/net/ethernet/intel/e1000e/nvm.c     | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index 952898151565..018e61aea787 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -64,7 +64,7 @@ struct e1000_info;
 #define AUTO_ALL_MODES			0
 #define E1000_EEPROM_APME		0x0400
 
-#define E1000_MNG_VLAN_NONE		(-1)
+#define E1000_MNG_VLAN_NONE		0xFFFF
 
 #define DEFAULT_JUMBO			9234
 
diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index c0bbb12eed2e..06482ad50508 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -959,7 +959,7 @@ static int e1000_eeprom_test(struct e1000_adapter *adapter, u64 *data)
 	}
 
 	/* If Checksum is not Correct return error else test passed */
-	if ((checksum != (u16)NVM_SUM) && !(*data))
+	if (checksum != NVM_SUM && !(*data))
 		*data = 2;
 
 	return *data;
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 7719e15813ee..58cfc63e95ac 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -2761,7 +2761,7 @@ static void e1000e_vlan_filter_disable(struct e1000_adapter *adapter)
 		rctl &= ~(E1000_RCTL_VFE | E1000_RCTL_CFIEN);
 		ew32(RCTL, rctl);
 
-		if (adapter->mng_vlan_id != (u16)E1000_MNG_VLAN_NONE) {
+		if (adapter->mng_vlan_id != E1000_MNG_VLAN_NONE) {
 			e1000_vlan_rx_kill_vid(netdev, htons(ETH_P_8021Q),
 					       adapter->mng_vlan_id);
 			adapter->mng_vlan_id = E1000_MNG_VLAN_NONE;
@@ -2828,7 +2828,7 @@ static void e1000_update_mng_vlan(struct e1000_adapter *adapter)
 		adapter->mng_vlan_id = vid;
 	}
 
-	if ((old_vid != (u16)E1000_MNG_VLAN_NONE) && (vid != old_vid))
+	if (old_vid != E1000_MNG_VLAN_NONE && vid != old_vid)
 		e1000_vlan_rx_kill_vid(netdev, htons(ETH_P_8021Q), old_vid);
 }
 
diff --git a/drivers/net/ethernet/intel/e1000e/nvm.c b/drivers/net/ethernet/intel/e1000e/nvm.c
index 16369e6d245a..4bde1c9de1b9 100644
--- a/drivers/net/ethernet/intel/e1000e/nvm.c
+++ b/drivers/net/ethernet/intel/e1000e/nvm.c
@@ -564,7 +564,7 @@ s32 e1000e_validate_nvm_checksum_generic(struct e1000_hw *hw)
 		return 0;
 	}
 
-	if (checksum != (u16)NVM_SUM) {
+	if (checksum != NVM_SUM) {
 		e_dbg("NVM Checksum Invalid\n");
 		return -E1000_ERR_NVM;
 	}
@@ -594,7 +594,7 @@ s32 e1000e_update_nvm_checksum_generic(struct e1000_hw *hw)
 		}
 		checksum += nvm_data;
 	}
-	checksum = (u16)NVM_SUM - checksum;
+	checksum = NVM_SUM - checksum;
 	ret_val = e1000_write_nvm(hw, NVM_CHECKSUM_REG, 1, &checksum);
 	if (ret_val)
 		e_dbg("NVM Write Error while updating checksum.\n");
-- 
2.47.2


