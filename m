Return-Path: <netdev+bounces-226490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F6ABA1024
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 20:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A30057B2B31
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 18:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928C7315D51;
	Thu, 25 Sep 2025 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxgN/ttP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71642E6CC4
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824851; cv=none; b=GE5oFXe+ioEBICKwZchavZHA+fqQp6pgsTHsUo7uMYWsNclm8RxTLxYCAGHzzbg/AGWpvQx/K85QCFoUWzH2Q+dojcvV/qxWoT1Roogsff00Siqvv4OyTm3uPCfPWRqU8nQTRGbpeNKzn1KLUcEGjVhqBfsjhHPtnl/XZkGbOPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824851; c=relaxed/simple;
	bh=DUTkLmi0EzVTJ+AWe0OBq6K1RWiww/CFFXpG8VhXD98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AcJymv84ViuqlEF7k7aFsSodmbPOzwG+D6jm6m2i+4fHNnQjmmQXFHF31roWzxZNAO0kVQY/9nkZk8wCjKrvQ7fbwyKKIr146Pe7rC8UE+xbyVOLlTD3v73CEr2nQ0mbc5/Xj+GOxJtEJEaQV0gGFHZXogFlbToQjXB43DBmE74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxgN/ttP; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b2fcfef5600so209878566b.3
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 11:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758824848; x=1759429648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JUT3SSvYenMhly8OZvczbE2TebLsubXvIlDVrfxllSg=;
        b=FxgN/ttPspWAZrp8ToX5a0XEFE6SsAsIsul994FKHjuLgXbghDJ8NHVC9LTAIAIMdU
         JRJk63KBujPDz1w0aT6COB6PuZP67pdMKVoy95QeD8vw+0sngRJXtvUks9MDPDhx8MZ0
         D79/pJoHnlTVADVpTW4hOnbc0OFcBN0Id9wt0ucli3kd7LTjD4SD8rZiUmEzOM+YFJXk
         lUc6HUfgtRyd5jZratOH3z2u+8jWFtoHsA7rYWi6APzUV5zL50AOk4jAKO1bPPc1M+7x
         RvAHdG7rzX12+zmCjEfFIjb042oEHjDhYlv4Ie8MWstM99PHdcTRrl/6DXK5n3R72Kki
         h/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758824848; x=1759429648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUT3SSvYenMhly8OZvczbE2TebLsubXvIlDVrfxllSg=;
        b=jY8IVgdlhMmRiRTgNr7qnyOyixvsObi4dYlLzE0BxbBpKtrysy5FTHZg3ezTj4PT3T
         gVFAbV1m7ibTGOFIB2HWGeHImKHwk+7kbb+RREAia6WyAyyVp0rNZTxWsz87uPNrSGOo
         QMSqfUb2p2fdmkhTa3zGVydmoZBoSc4TCf8uJCLsFvp5V1gX24uZhotVLO68ecyu49DE
         J86k47bfqntUB8e/Cmk3X9QWboiKX/kSW8UvUumbiyqeejCiOCiz/AUkTbqqFI5hqvS2
         UgsoKNGcnpygqV2aqwIrtJLr9xQgJtzJeUN9miWrXrVyjW2QfkP+LG5kPU4jSv3CJgZs
         S4Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXFLkUwVG5wCGVXxc74uVJEIGsgTBdKgCEMFdlgD2d55yhxR3yKl4rPcjHBqRnn4yD/Rb5oYts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ucpp5a8hVk9XEw+EwLCQw1blzdHzADPKP2RcR5F5U/BzyVdh
	Dz+QmOT87cl+npQFm1WsNZwybS9pZFQLrMd9w4uyiO+OloA2mHuWph9H
X-Gm-Gg: ASbGncvw4Omerr4HEPZE0pDpd/EBmWXvNUot55RVZj90KLNiWM725cdapSh/qV6yAt7
	8N0Nc+JPxA4bejfv+iXxdRqLVX3TjqSNFyHU/eU2kTZ7i42UX2GJw6/6gJGmDbEeUFiodD1p0bs
	cs+wp9Qq67UoaFwHN/bN0rdEPCSFK39nKdDBL8hxWFW7OCijV96KsQQb8ZyqeBjYRd0CO+SQhKa
	xL6XzAQd0uzzV6eZUEc+cxmdu6P3y+68O4jVAlJolOUdENoyqfQDw1APjaqaz87+4ObxVFrViNp
	ns0tjmyvqFMxtOQKkVbmc3JF2W6liDherL1o+Jed9U7YKzMgmJTbl2V7OxorcdGIUAP86gaj3uN
	VeijUR2RcZcEsT7cA6ccYv8HPEeTH/VabCxMHyNXiexSvaB0IazSwK/wISEOYYG0ihfMQPh0kqS
	+GyoMKd8elM2pvxRBL/A==
X-Google-Smtp-Source: AGHT+IHGcH8Urk+2NZXPjBGTGYafzBqvtygm/aKjINig6LQec5XVExiMK3tDXWVjaGovy9FXplx0/A==
X-Received: by 2002:a17:907:25c1:b0:b2d:b5d3:962f with SMTP id a640c23a62f3a-b34bb418b41mr435432766b.44.1758824847493;
        Thu, 25 Sep 2025 11:27:27 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3650969sm1572902a12.19.2025.09.25.11.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:27:26 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v4 nf-next 0/2] flow offload teardown when layer 2 roaming
Date: Thu, 25 Sep 2025 20:26:21 +0200
Message-ID: <20250925182623.114045-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch-set can be reviewed separately from my submissions concerning
the bridge-fastpath.

In case of a bridge in the forward-fastpath or bridge-fastpath the fdb is
used to create the tuple. In case of roaming at layer 2 level, for example
802.11r, the destination device is changed in the fdb. The destination
device of a direct transmitting tuple is no longer valid and traffic is
send to the wrong destination. Also the hardware offloaded fastpath is not
valid anymore.

This flowentry needs to be torn down asap.

Changes in v4:
- Removed patch "don't follow fastpath when marked teardown".
- Use a work queue to process the event.

Changes in v3:
- static nf_flow_table_switchdev_nb.

Changes in v2:
- Unchanged, only tags RFC net-next to PATCH nf-next.

Eric Woudstra (2):
  netfilter: flow: Add bridge_vid member
  netfilter: nf_flow_table_core: teardown direct xmit when destination
    changed

 include/net/netfilter/nf_flow_table.h |  2 +
 net/netfilter/nf_flow_table_core.c    | 89 +++++++++++++++++++++++++++
 net/netfilter/nft_flow_offload.c      |  3 +
 3 files changed, 94 insertions(+)

-- 
2.50.0


