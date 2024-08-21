Return-Path: <netdev+bounces-120502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E48959A02
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31A1EB24508
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 11:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69361188A3A;
	Wed, 21 Aug 2024 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaxGXfLv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CC115FA92
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724237414; cv=none; b=EOOXsNki7HQWiNMaUV0lBgZDH5lWjA2qfi18WbdNIt5iq7l2824GBHj7KsTcsrP98Ow3OvD41iEGiuaMVFQzzwJHrlQ3jTCoA5ahrhbRijPVIvNVH7dCEfpfEHKVaG/W/r+v4Me+gXsmYYAY6NIrDtyAkid8nlL11uNBePcYark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724237414; c=relaxed/simple;
	bh=8A/yDlYUuLem+jt0fQ7OOU1ocp5mmvbf7igItTc6j1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d6rkW6Qb3zHHwYefQtKhgcUR6HAxTqj4NqzaDLJ+wGrN+77oSebwZqXL2uFgpyvBTsB6wKRanurY4kJ2W9wfJGQoA+JMlS5N4/S9QlnSFLD2WdBk8BU9ww58sNgG116e70nXDNdXlm08Y+/BUfaVyWnhT3+clJ2lPPMn6ylAoCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaxGXfLv; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-27020fca39aso3815465fac.0
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 03:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724237412; x=1724842212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZNcml2j6cMLK8UYTALoSOK/S3cE3NXupQBO9ck/clk=;
        b=VaxGXfLvacJwz5xmmyCRuRsfO+97Pc++62Mrp4czY6EnbIfnwrEZAVisG1eBjdTp+N
         UJWmMOQUQd6HCABnj6eWNlvtYfEHSb0iprQg2+GhQr0blN/k1OR3YQ0TU8e/9Mgh9Ll1
         Lf7d6yWmogqttPuh0KIUsj6UYj5DJoPzd9IJnx7Blq+zzeIOj5JHohULkYU2ptoV1IU7
         2nEZB3cqfpJUW9KpDZ/vDl0xWUf6vw8yEv2ZYEyrw6WPT2v3fHUH6ZgqObgUxIXI3Kix
         L3DFiKOpaotpDBPX8I5uVJbpqh7TtLnayg50jFmDeV5uUu1ZoaRVMc6JBcTovd51Wg6a
         baUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724237412; x=1724842212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZNcml2j6cMLK8UYTALoSOK/S3cE3NXupQBO9ck/clk=;
        b=FTxtmekGHAZbu03luiHayJ/QHSTPQx1ALnrhQVM6mqsdsVkchDQYzvdCkrDkj+Sfc2
         N6RPgmwu9qeVRJ+VuVcP50Cz3WAy+6YOU1LDdwbzn7JoPCfxi9uKK8Z0XndOlxmQ7l4A
         eW0xLS49vziq4VsvOWVCx0VmpfFSB7qZftam7SN2DxhgO8k/ACjv6wgQPSL3RJwwx1l6
         UFub4gvK4yw+hddAj/CJ9bJ7purGWIbcSTSfWlLt/MP6kwDPxwUuuOZcR9iflVQk4W2x
         U+WANUJ7GXK/zhF7/rrtTTm4CIPhdZOmqNF4lTWT8AUdHO6tcIEfjw/QancYypDbgFKB
         cOfw==
X-Gm-Message-State: AOJu0YxILzeLN3hvGTGbJnud+FmxV9Q8leJDxbxXc89rMMKGsMuP+3k6
	kSh7JOQjkkeqAclA0taELXx2I8ljyqLD+3Y2Ayl81t0RZIHfAfGF29Li7kdGyoA=
X-Google-Smtp-Source: AGHT+IHnIpDNm32KNpeHiLtPi8l7iYiNu54tWwfyhu4u3ejNEpg4rd/gpHWN0wwi6VnZLlO6zFMS3Q==
X-Received: by 2002:a05:6870:b294:b0:251:2755:5a33 with SMTP id 586e51a60fabf-2738be2f33dmr1800668fac.39.1724237411524;
        Wed, 21 Aug 2024 03:50:11 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add6db6sm9652521b3a.20.2024.08.21.03.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 03:50:11 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net-next 0/3] Bonding: support new xfrm state offload functions
Date: Wed, 21 Aug 2024 18:50:00 +0800
Message-ID: <20240821105003.547460-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 2 new xfrm state offload functions xdo_dev_state_advance_esn and
xdo_dev_state_update_stats for bonding. The xdo_dev_state_free will be
added by Jianbo's patchset [1]. I will add the bonding xfrm policy offload
in future.

v4: Ratelimit pr_warn (Sabrina Dubroca)
v3: Re-format bond_ipsec_dev, use slave_warn instead of WARN_ON (Nikolay Aleksandrov)
    Fix bond_ipsec_dev defination, add *. (Simon Horman, kernel test robot)
    Fix "real" typo (kernel test robot)
v2: Add a function to process the common device checking (Nikolay Aleksandrov)
    Remove unused variable (Simon Horman)
v1: lore.kernel.org/netdev/20240816035518.203704-1-liuhangbin@gmail.com

Hangbin Liu (3):
  bonding: add common function to check ipsec device
  bonding: Add ESN support to IPSec HW offload
  bonding: support xfrm state update

 drivers/net/bonding/bond_main.c | 97 ++++++++++++++++++++++++++++-----
 1 file changed, 84 insertions(+), 13 deletions(-)

-- 
2.45.0


