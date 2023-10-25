Return-Path: <netdev+bounces-44135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E857D6898
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 12:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE4628196F
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 10:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DC91C6A8;
	Wed, 25 Oct 2023 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPOiH6Su"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BA7266B7
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 10:33:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A4A10A
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 03:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698230004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2obM353U2q7nBxBXksZTD973gP47Z5kgDxArhlBI2WA=;
	b=YPOiH6SuHEHVe0JgzIySUQdwEOfgpaNqYuJBWv3JAMh5jLghyiWtuYqWcVWh/w2muBpHSf
	FNBfRf126uQuvouT35JbW1+WKw5T46dLhbul5JMeNz0VtILHZBZj840ULQKT4eeFfCPXfr
	4QFNETlzs6E721voEm1lNaVYm4g+CKk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-orxzERDcMC2y-zJWoJvrbA-1; Wed, 25 Oct 2023 06:33:19 -0400
X-MC-Unique: orxzERDcMC2y-zJWoJvrbA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03BE9857CE9;
	Wed, 25 Oct 2023 10:33:19 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 825B11121319;
	Wed, 25 Oct 2023 10:33:17 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next 1/2] i40e: Remove VF MAC types
Date: Wed, 25 Oct 2023 12:33:14 +0200
Message-ID: <20231025103315.1149589-2-ivecera@redhat.com>
In-Reply-To: <20231025103315.1149589-1-ivecera@redhat.com>
References: <20231025103315.1149589-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

The i40e_hw.mac.type cannot to be equal to I40E_MAC_VF or
I40E_MAC_X722_VF so remove helper i40e_is_vf(), simplify
i40e_adminq_init_regs() and remove enums for these VF MAC types.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c | 33 ++++++-------------
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  8 -----
 2 files changed, 10 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 29fc46abf690..896c43905309 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -17,29 +17,16 @@ static void i40e_resume_aq(struct i40e_hw *hw);
 static void i40e_adminq_init_regs(struct i40e_hw *hw)
 {
 	/* set head and tail registers in our local struct */
-	if (i40e_is_vf(hw)) {
-		hw->aq.asq.tail = I40E_VF_ATQT1;
-		hw->aq.asq.head = I40E_VF_ATQH1;
-		hw->aq.asq.len  = I40E_VF_ATQLEN1;
-		hw->aq.asq.bal  = I40E_VF_ATQBAL1;
-		hw->aq.asq.bah  = I40E_VF_ATQBAH1;
-		hw->aq.arq.tail = I40E_VF_ARQT1;
-		hw->aq.arq.head = I40E_VF_ARQH1;
-		hw->aq.arq.len  = I40E_VF_ARQLEN1;
-		hw->aq.arq.bal  = I40E_VF_ARQBAL1;
-		hw->aq.arq.bah  = I40E_VF_ARQBAH1;
-	} else {
-		hw->aq.asq.tail = I40E_PF_ATQT;
-		hw->aq.asq.head = I40E_PF_ATQH;
-		hw->aq.asq.len  = I40E_PF_ATQLEN;
-		hw->aq.asq.bal  = I40E_PF_ATQBAL;
-		hw->aq.asq.bah  = I40E_PF_ATQBAH;
-		hw->aq.arq.tail = I40E_PF_ARQT;
-		hw->aq.arq.head = I40E_PF_ARQH;
-		hw->aq.arq.len  = I40E_PF_ARQLEN;
-		hw->aq.arq.bal  = I40E_PF_ARQBAL;
-		hw->aq.arq.bah  = I40E_PF_ARQBAH;
-	}
+	hw->aq.asq.tail = I40E_PF_ATQT;
+	hw->aq.asq.head = I40E_PF_ATQH;
+	hw->aq.asq.len  = I40E_PF_ATQLEN;
+	hw->aq.asq.bal  = I40E_PF_ATQBAL;
+	hw->aq.asq.bah  = I40E_PF_ATQBAH;
+	hw->aq.arq.tail = I40E_PF_ARQT;
+	hw->aq.arq.head = I40E_PF_ARQH;
+	hw->aq.arq.len  = I40E_PF_ARQLEN;
+	hw->aq.arq.bal  = I40E_PF_ARQBAL;
+	hw->aq.arq.bah  = I40E_PF_ARQBAH;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 9fda0cb6bdbe..7eaf8b013125 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -64,9 +64,7 @@ typedef void (*I40E_ADMINQ_CALLBACK)(struct i40e_hw *, struct i40e_aq_desc *);
 enum i40e_mac_type {
 	I40E_MAC_UNKNOWN = 0,
 	I40E_MAC_XL710,
-	I40E_MAC_VF,
 	I40E_MAC_X722,
-	I40E_MAC_X722_VF,
 	I40E_MAC_GENERIC,
 };
 
@@ -588,12 +586,6 @@ struct i40e_hw {
 	char err_str[16];
 };
 
-static inline bool i40e_is_vf(struct i40e_hw *hw)
-{
-	return (hw->mac.type == I40E_MAC_VF ||
-		hw->mac.type == I40E_MAC_X722_VF);
-}
-
 /**
  * i40e_is_aq_api_ver_ge
  * @hw: pointer to i40e_hw structure
-- 
2.41.0


