Return-Path: <netdev+bounces-172148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312C0A50522
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9630F3A8D8E
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042AC1A83E7;
	Wed,  5 Mar 2025 16:37:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1101A841A
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192670; cv=none; b=rFvRqrDE5o/Sew2YabZbeEfWoWqOojHGp5eW+rqmiNhBij4hC7xEFeS0J+/fX7nnkwBcAUR04TG/tStdTRZMVEzw2io3oV346BxyD8KIG4n9BJIMiCefAVyWz8aJ0CVDDlB9ZjR3Dz1vq1cXtrRJ661q9ugf9C9UJlgmPUtC5Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192670; c=relaxed/simple;
	bh=NToPj7EjvzJWfeYXb3Qzc07O3/IaICkq8S2irPN5HWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNcBEbC5+UbkhePqRgxIsAb815ZqQXaoqn1FQeGEgiAG+gEiJHlWvc9r4lb20Qj8iRytyOwh3EcavUNjBSJg+OMG5V2BdyJcFSZOTuwnsj9jdcdDHBgAaiICz+AC/bJTzK4OZ/x3ERI6CjR6M2086swF0JHDXlKF+yTxEB6ElzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223a7065ff8so15786515ad.0
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 08:37:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741192669; x=1741797469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FD5eaKfT2cUHoX+NlKxBWsrL3lfnAkuQeyKwMYK8+c=;
        b=ZWwUPQ8qX8LlOlfhMLuB1hadD2NPtsk+eaPMYhkqiULRORUWBoFv3dNzy0YSlW2A3I
         km6G0TzyTCfb8BfK7WDcVK/laWl8SGwnmbldka2D3HV7oZPuduFWWEg69w67o1g5BhSp
         FsEp/B41ER+E9fl+yHikw2xvA9W9y4ywiDrIi0misJqSdPSzqFOghJxQHeR+o1Lhefma
         BP7WHz9VCK5AaFwKvcrcyl8IBXP4K/IRp1SwJkr3ww0e3K9G2DK9WE7+AqHMaTdAum/y
         DPDY0rrrkxD/Pig3vItZSv3RmC/iSh6OemASAXhVMIv57rsjbH8JeLxcyow3CCZ2pYGO
         4BEw==
X-Gm-Message-State: AOJu0Yzx5TmH0seelsZlq9cZxp+ECP0JNhwzyuWjBd35T9mp06s6Ro7p
	9iiDKSjOuQzlc0nCdoTDr5AmA2bgd3BCqAWpkhcqbpxrb4U39PBe1BTt
X-Gm-Gg: ASbGncuVS6iiqInNOym3IcIqI+yDW+TgfmPUuQJv3oDvDOXTb6I/sCkwr3ThTCZ4hsb
	94Im3J5ckTFEtxJ7/EAiZ3KijhwvAeXPiHp1F413gzVxc+R+q5nBCCdi1cgYik81laQ1xp+OfOd
	XPTvIgv/4DEGgCutn1URAk9He62UXyRMk8qxmtnlFDk7FbXQCmqDO6+MYlU6hwUkwexQ1PX8O9q
	v75PuzI2HLa8rlfNE7exg4HV5PpCptvBEZ808T+4H0tVuQfsI5hhqLuqA02RDg0MmmtSQ0UqlYc
	S4ecgIE/GDjIlFABTvQiBOZcVU2gKPBFLwDomsuu1xfG
X-Google-Smtp-Source: AGHT+IGXEa4aO1c/MkzosB3IIKfl3gMT/y93amMaOP7R+rVD6vggKb7VhOsMbAKJOSdZWZDSvgJG/A==
X-Received: by 2002:a17:903:f86:b0:21f:859a:9eab with SMTP id d9443c01a7336-223f1d260fbmr54243215ad.37.1741192668711;
        Wed, 05 Mar 2025 08:37:48 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22403cd8d66sm4792755ad.72.2025.03.05.08.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:37:48 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v10 12/14] net: add option to request netdev instance lock
Date: Wed,  5 Mar 2025 08:37:30 -0800
Message-ID: <20250305163732.2766420-13-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305163732.2766420-1-sdf@fomichev.me>
References: <20250305163732.2766420-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently only the drivers that implement shaper or queue APIs
are grabbing instance lock. Add an explicit opt-in for the
drivers that want to grab the lock without implementing the above
APIs.

There is a 3-byte hole after @up, use it:

        /* --- cacheline 47 boundary (3008 bytes) --- */
        u32                        napi_defer_hard_irqs; /*  3008     4 */
        bool                       up;                   /*  3012     1 */

        /* XXX 3 bytes hole, try to pack */

        struct mutex               lock;                 /*  3016   144 */

        /* XXX last struct has 1 hole */

Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/linux/netdevice.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f3e6e6f27e22..adf201617b72 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2485,6 +2485,12 @@ struct net_device {
 	 */
 	bool			up;
 
+	/**
+	 * @request_ops_lock: request the core to run all @netdev_ops and
+	 * @ethtool_ops under the @lock.
+	 */
+	bool			request_ops_lock;
+
 	/**
 	 * @lock: netdev-scope lock, protects a small selection of fields.
 	 * Should always be taken using netdev_lock() / netdev_unlock() helpers.
@@ -2774,7 +2780,7 @@ static inline void netdev_assert_locked_or_invisible(struct net_device *dev)
 
 static inline bool netdev_need_ops_lock(struct net_device *dev)
 {
-	bool ret = !!dev->queue_mgmt_ops;
+	bool ret = dev->request_ops_lock || !!dev->queue_mgmt_ops;
 
 #if IS_ENABLED(CONFIG_NET_SHAPER)
 	ret |= !!dev->netdev_ops->net_shaper_ops;
-- 
2.48.1


