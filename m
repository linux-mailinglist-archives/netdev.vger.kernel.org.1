Return-Path: <netdev+bounces-176109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B16A68D20
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 13:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04CBE425934
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331461B95B;
	Wed, 19 Mar 2025 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xv6s8BpW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5F6134BD
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742388329; cv=none; b=Ee0oFrDdEoZ4UDFEMza1z7P4rlGnuXkt/Jtm6J/IQVv5oIkKpOssvAZVeQ14Lvgb/HpLi1xqYte8RQyCX6m7+/z83BxhPEucOHnfgMjxOR2gtcO+kAe1wkeg6qBGf0TPhbxlXVxg3MkGyEmb0TC3txmO7xS5iY5F8JHjc8J0TRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742388329; c=relaxed/simple;
	bh=odcCNVJoc2TFr8XGzBm1WeeVdSjny3t5o4LeJlzmN8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LnMFkgN1GRirmttbBc4VgmmInZC+e9y0zCR5r2cNKNKGPFkBJHKS2ps/VCeUKrB9w2pOZWMOSMPtYnxubU2P7YgCw8FWBgiXF+UO9uZAIqdZ2qX48n3dIwzgCruEQdMxhyqpey/8clRRiw5g15zwWG8L0ZrjJybXe/3of4hHzI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xv6s8BpW; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-399676b7c41so2032655f8f.3
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 05:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742388326; x=1742993126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KwVvaTSQg0cgueTUJAziqZWj3gCtuIU78IMBkap79ro=;
        b=Xv6s8BpWpZmyGfeskDb81btl+wT/XBfOpBbm30TihmAadljtqEnDWCTo+zlDrV+ha2
         hQL1K3VXNbNUrfO3akuIDLPsZEc8zBhJRD/1yiaUDA7GkRRzLup+4/br1ZeHHp3Lv/3B
         MKkzIpQQ6LabBPWserJjrhz4gFLc1IyxjDSuzWEtpVxilIuvYfbIL/xXe5pXFLnhu01D
         R7fpEMxZ4zo+aIbr2UJLmYgL0TJf/bwD+KGVLbDovfJn199QYxLvgB1j8VQvNUnskLkZ
         LJK9OmTXP7ryJNLVYFWF8cTUWnI7SRguocRyNovFFaBsNyCw4OVjVP4D66LtvwFZ32Op
         GtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742388326; x=1742993126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwVvaTSQg0cgueTUJAziqZWj3gCtuIU78IMBkap79ro=;
        b=gmhIRzuXqNPQlq4Vl8+2zQyYAnCRucmJljSbZpQ4azNu3RLAFntp+ne/R7/6jdNUtT
         F7tK22duaJiEVIPissBTTjs4jFYkpxUOutcVlML3fEBhWbiy2lYpGZ2XbQg77V3TUEQ7
         eN+sw2WD3rVR8iwcQoKTau0u6YN1NgMrZocR66NZW+e0pzsvyCzMwclUDNwzHIqvJoHL
         HlqV/Y9AD7NNLS0obUfHjoX8WIcZQDBvsjwpiRTkr2+xJ9kUdHNI4xN//2ZCKA/Ij1Jx
         tsQwV5xReU7jeQ1FQCA6NYOz/cpY0Ru6PHdKNmO1yBo/q7P6JJll2Q3QRmKxlCpIxTO1
         idBA==
X-Forwarded-Encrypted: i=1; AJvYcCVMEzd+sOBz4uX9Sr1Zvrk7qV7NmSmjw2m2S1Gn2oJ2Kr3R/1jIqo89plnMzzbzI5CaG0LDVWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOs+zWKvBOAbfeFyL/DJZtvVSSqGAQE5c5bR6faKgpsM6zoQfk
	hUgmVUo2Z54HQOoE2T414DzvtwpU5OzHzE497HXFJnFirNFi01aQ
X-Gm-Gg: ASbGncsu4ZzKrWHtWOjiFlL5SXbLmNCN9OOkAgCkTkrf4QvS+u48RFD/K0eX3hPiBi1
	NhwLkQeA5NLFupgO5LE9CThAGfVSrF2EOEYl4MW3w8Um+okOpjn5wG/xxYi8YCHQe2NpYGo8nix
	hYJ5hx2iud2OyIQBSWknmH+IQt2vu7NvxbhW/aQIP9BKY4IT6AtPO5SESF6H67no2gwBiYqKYOK
	zaQ56dIRKppWOyuls8xXTA0oguMIOkeeB27ACRv6vwKQ+msBuHS7RfjXmnXEU/0pPY8qaf9UktK
	mE46eDZlgxDcDQ8NhUdZWr43ZpwgpEG3ASkjQFQ=
X-Google-Smtp-Source: AGHT+IGyopJnJgl7LADp7iqpx7XgjKKx8IGttRb8mAnKKp+CA5ySo25qSK1GTIcb1jyBV2dLfviq/w==
X-Received: by 2002:a05:6000:1fa3:b0:390:fd7c:98be with SMTP id ffacd0b85a97d-399739c1969mr2571705f8f.19.1742388325321;
        Wed, 19 Mar 2025 05:45:25 -0700 (PDT)
Received: from localhost ([185.56.83.83])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395c83b6a32sm21244048f8f.33.2025.03.19.05.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 05:45:25 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
X-Google-Original-From: Maxim Mikityanskiy <maxim@isovalent.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH net] net/mlx5e: Fix ethtool -N flow-type ip4 to RSS context
Date: Wed, 19 Mar 2025 14:45:08 +0200
Message-ID: <20250319124508.3979818-1-maxim@isovalent.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There commands can be used to add an RSS context and steer some traffic
into it:

    # ethtool -X eth0 context new
    New RSS context is 1
    # ethtool -N eth0 flow-type ip4 dst-ip 1.1.1.1 context 1
    Added rule with ID 1023

However, the second command fails with EINVAL on mlx5e:

    # ethtool -N eth0 flow-type ip4 dst-ip 1.1.1.1 context 1
    rmgr: Cannot insert RX class rule: Invalid argument
    Cannot insert classification rule

It happens when flow_get_tirn calls flow_type_to_traffic_type with
flow_type = IP_USER_FLOW or IPV6_USER_FLOW. That function only handles
IPV4_FLOW and IPV6_FLOW cases, but unlike all other cases which are
common for hash and spec, IPv4 and IPv6 defines different contants for
hash and for spec:

    #define	TCP_V4_FLOW	0x01	/* hash or spec (tcp_ip4_spec) */
    #define	UDP_V4_FLOW	0x02	/* hash or spec (udp_ip4_spec) */
    ...
    #define	IPV4_USER_FLOW	0x0d	/* spec only (usr_ip4_spec) */
    #define	IP_USER_FLOW	IPV4_USER_FLOW
    #define	IPV6_USER_FLOW	0x0e	/* spec only (usr_ip6_spec; nfc only) */
    #define	IPV4_FLOW	0x10	/* hash only */
    #define	IPV6_FLOW	0x11	/* hash only */

Extend the switch in flow_type_to_traffic_type to support both, which
fixes the failing ethtool -N command with flow-type ip4 or ip6.

Fixes: 248d3b4c9a39 ("net/mlx5e: Support flow classification into RSS contexts")
Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
index 773624bb2c5d..d68230a7b9f4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
@@ -884,8 +884,10 @@ static int flow_type_to_traffic_type(u32 flow_type)
 	case ESP_V6_FLOW:
 		return MLX5_TT_IPV6_IPSEC_ESP;
 	case IPV4_FLOW:
+	case IP_USER_FLOW:
 		return MLX5_TT_IPV4;
 	case IPV6_FLOW:
+	case IPV6_USER_FLOW:
 		return MLX5_TT_IPV6;
 	default:
 		return -EINVAL;
-- 
2.48.1


