Return-Path: <netdev+bounces-122721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ADD9624FB
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05BA28380C
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 10:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E36416B3BD;
	Wed, 28 Aug 2024 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/DutOg2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B53916087B
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841185; cv=none; b=uocZNNc75CUIjPdgThChk1zKETjAUVImvBT1xi9VCmJiESmjeJ9nXPrpE8rODnAUA+PtJ8UmwJD9jiNWazFhTRJQX5crF2v8o80uXnRtnAbZbk7pHm4cpqOgQ0eJE19kzJYRW/M0SdJgsUDifbH9rHb4NbZg12Pm8+/jvkKL5oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841185; c=relaxed/simple;
	bh=DgI8dxSKx5La/d4smDIiOi+WFg0QN4hwnQJMJfsvZvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l179FnISP6yi6VwooWoikqP2T/4GlM1ci/d+to4rKddIosCOUs43upN6Ku0Nw2VK+WKGLSoKE1IBlMNG5I7wvPYWxjw58Xhu90fo28K7nUWantjIy7o3DqlZ8ZXfb9MRwEcDacNIY6mQJ2+v/2ybNIxoy30/DU9rjJ4ZdRcBDSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/DutOg2; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7cd9e4f550dso2101842a12.0
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 03:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724841183; x=1725445983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sabd59darPAGdKpnoPWFVVFHSmOGMe8cr//Afa6wvII=;
        b=Z/DutOg2rATZl30AW/YVNz7hNmV/V4oQVYmRa2ToVVqgi16sJKoSxc1Y+aNHritA2G
         3z/wp3hdKlNmGrgjZNNg9UeSP0a6sSjpLEmTcqwVA+rqYV++PFA2VwOFxwiRaL7GbMCL
         tV1Up+iN2p8Y4ZVo380UA2seKtN0c+M8EtIDoJzyem0tk33MUOk/9jHIU5xdoY1e/DOv
         9GGydrjwVYYIt+KOg0kVz9FGjDopKS1y9DeOB5LSMgi36Lzsj4KqWZOeugM+H5VNxeI1
         VjzR6oM9qcWFr6n88D/EJN2sQ1G/xaOZlufE0bv3FaPzU7BnutEGYG2a449f8/oKPhjT
         33IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724841183; x=1725445983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sabd59darPAGdKpnoPWFVVFHSmOGMe8cr//Afa6wvII=;
        b=pAtF5kQH0Rp2CuBACSXiwX/FVLmE5z/lFWdJa73oEOHIg/0SdPQtvwu1WrLlIRKcnY
         P1w0QrY14PeYzVXnn41vZtJSkW1HpoGQ1x8Q3bSczGruKx4aqDc9STyGb6JOYfnQ7nWt
         hj9L98Xhs+kp9Oo7udSmwAc/Un8na4rlWoDnRzw2TVTqt0Fn5BJjlbMCjRkncTT6c5r/
         wteCSb3ZqUePpEc/1XECHBcewiszdDnkPxALqgpQ413HwW+4ICRwNJQsXC3Jd5eMdd5z
         5Tn/LhCh7a37Xw9huToOXGs7A0S9ukIwWo0gBbR+gVCMXrXtYQUaq9+LULov5CpEPTNa
         jcKg==
X-Gm-Message-State: AOJu0YzoEjH4LgDOYbRm9M6Cc0Tu5Ni5vIF2BdpU1W73iW4GlcYNRZ85
	h9PpTYEtKkBNcQo75+EgiusIPwFhd8h3fQTPTR7eKwlcCM7hW0D3dvVLhRiuPyRayA==
X-Google-Smtp-Source: AGHT+IH/R9vOPDTRsSvVP+7AXpJ6/JmRpwSiQmkjKUtutaWkXisKOXhwwQ3lzekqJy5X7SnaVfnqgw==
X-Received: by 2002:a05:6a20:9f95:b0:1c8:b849:c6b9 with SMTP id adf61e73a8af0-1cc8a21a007mr16619137637.43.1724841182463;
        Wed, 28 Aug 2024 03:33:02 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855ddaeesm96298835ad.124.2024.08.28.03.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 03:33:01 -0700 (PDT)
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
Subject: [PATCHv5 net-next 0/3] Bonding: support new xfrm state offload functions
Date: Wed, 28 Aug 2024 18:32:51 +0800
Message-ID: <20240828103254.2359215-1-liuhangbin@gmail.com>
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

v5: Rebase to latest net-next, update function doc (Jakub Kicinski)
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

 drivers/net/bonding/bond_main.c | 100 +++++++++++++++++++++++++++-----
 1 file changed, 87 insertions(+), 13 deletions(-)

-- 
2.45.0


