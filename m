Return-Path: <netdev+bounces-219199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2745AB4071B
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 16:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1020E5E3281
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3975D321F32;
	Tue,  2 Sep 2025 14:36:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF3C320A34;
	Tue,  2 Sep 2025 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823807; cv=none; b=i6LJBG32fOsJZ9cUkBclX06gfCfl5HV6cLn5lGRdcv5YfiUmrQZUSW4l+xuoJczDT7IE1Svejcyl0oqWJ8bc9IBxf4ydb9kfpnLjwiUn7UA5QWAHSHtanPhaDynBR5max5SwHrHw1hPJmtCId6kArO6FRnwprJvil1MXG90sXm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823807; c=relaxed/simple;
	bh=VBwcVcv+GCCiU4bFHJtfDPxN0YsJ0jWc7OZVxkfIJtg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iJiZStpcTsurFGL5C2wMDU7N1B579yfMKy0/tes+XqVY0h/hvECIWrxXolL3x0Td1UfqIcOlUUC3uBJ4JzaArJQI6YJF3nFZAuy/Hvw7bPSlSMB11bAEfIu7HVyIZHVqVWJnkU0viCH/QYEviC1yfXOiM946wgYVj+Qz2zLWXN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61e4254271dso3971715a12.2;
        Tue, 02 Sep 2025 07:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756823803; x=1757428603;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+WxHSChZ9uRZ+pEZAY2pQJEcjFUMcbon+dgiXnsMb8=;
        b=BG/XdIBGpkYmAcYG5kSdAX2E/Lv2yskd4sy2CAdj2c+rpemtqEim2QS2cv5IFXA2Yt
         b10z9wnEyQQ2P6Tu6vP4y9BhwtPjsgqKrHSgvM+7L0bzmKmtLrtFBC84NsWHnTUXsj8K
         RpT3mmKMxWioBWU6WRswHylqb37duhxDBWVZxxSB6f1k40vA2+1yQYYjYbGX/405NTpW
         RdyHz+K8Y03/oc3Z3De8jDorFMATjg8ZpA3ueRKm64sTvbnsOzdBu9tTRLZBLDOdHfuX
         AV37VwTSPXAcFamuCW10ceuUvODjWZxNZ2NcSt4uHayr10V1k1ikb3IE60wtVPblX+85
         1X8w==
X-Forwarded-Encrypted: i=1; AJvYcCVXtLtdPmYLw7lcyQcbt/PtBwoXejmc8049jnPsC/9tGLCGdWgngBuHeRBbspbpAwCh2Xi6hIWXKxNoqE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlBYr9AYIIE++o+a+ph3AKkji372TpEi5T5f+f0nrlmuRcHTrO
	7qDercIFISCTFLy1i5BfoVwRTvgmBt1qtslURRZPYRnK4o/hXPxwyWyy
X-Gm-Gg: ASbGncu3WNuF2nAZx/iXBzJU0+g7mjGHcWpreSdqEIZ3PwpZWShyrtV6OgvoTWupkTG
	jfWGXpETRiuH/VhaPENiUmgDdMLupw4xSdOugUtG/PGK8PvCol79oDesfnr/WQCVnFxPPVq/Kgc
	FgJ9PAObV+51Hmamx6ESN05nXKqeTxo1qnK5/XEjg7ySXDk3HxtpXVF0whBHpIPTwJpaTdAbsJb
	+8HskOHI3PnzpNVq0jcP0wWhFNB0xslITGDB1pzQg0cWSwlbdqbf7EVr+CutG8ntMipJDf7MfuB
	P+xO8a/Yi71m6JrbVNFI/YC/9LuVn6489CLfY+O+HGWJQCOaRDKhoNu1z8zWA0VskzKlf3b4+So
	ovNuX9g4QK1CrBdYMKbVk8xjIN4+AiPA=
X-Google-Smtp-Source: AGHT+IFaM9Cd1TN5RI9Q3pKmnGos4LhWt+mLuo031EIBB/SqZWcNMGXZWBh0z3APg1UJjHEAsEau0g==
X-Received: by 2002:a17:907:8689:b0:b04:3783:7fc9 with SMTP id a640c23a62f3a-b043783a21emr643357666b.60.1756823803140;
        Tue, 02 Sep 2025 07:36:43 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b042c7b3671sm508316766b.42.2025.09.02.07.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:36:42 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH 0/7] netpoll: Untangle netpoll and netconsole
Date: Tue, 02 Sep 2025 07:36:22 -0700
Message-Id: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOcAt2gC/x3MWwqDMBAF0K0M99tAHpZqtiIi0o52IIySqAji3
 oWeBZwLhbNwQaQLmQ8psigiuYrw+Y06s5EvIsFb/7Kt9UZ5W5eUhl23UefEwxEMt1Pt3o0LoWZ
 UhDXzJOd/7fr7fgAloAj2ZQAAAA==
X-Change-ID: 20250902-netpoll_untangle_v3-e9f41781334e
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, kernel-team@meta.com, efault@gmx.de, 
 calvin@wbinvd.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3487; i=leitao@debian.org;
 h=from:subject:message-id; bh=VBwcVcv+GCCiU4bFHJtfDPxN0YsJ0jWc7OZVxkfIJtg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBotwD59qKE6RT8PRbYyPbTM85HAKSAqTcygvP6H
 kUI4KCL8JmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLcA+QAKCRA1o5Of/Hh3
 bWO/D/4o6kbG/uH2OVl2XcF7yJ80HXV86ylwPkwdOQEIXfYtrYDgv+6UQoIZbxfpCaZMDvMcw2+
 3Y58x8+I3Pk1VfJQLLIi6/2dGWNVnNJ3Tqjg3X7pvteZ8IiZrVnSKb/u0JqCYdiFvItPNGOCEwz
 qHc4LusgshSe08bdF33AZSOD9oYAHyf26aZO89csweqba7hNLATCnCLxqaa2KZdQwCyzL5x81cW
 i5PEFlmUFlvJ0Rb4ZWvd1YSBwP6jDfkmdJsfHm4dsX2bSwgQv9Dkmic3IEJSufE8Ejy4Dd0v4vM
 rlqeOsQfZmOQaqYNyRknjHkPmZmLlBVN35+6t7DBZB039WsQxsHORjVHzhBT8IBMWq5G4nILysI
 65cwdDkpWoaAgtf1/itoGniqYDUjQtHGFihD0Mx9IOBiXZdKdHkQ9fXS8FykaMiHqk5x5cB8cDM
 nsyY4+P9rsobVQGqkzbzIeQPtZuIL6RM/g+917Mf6RtenOCwblIXe6W8S+7RL/UKVq8x3/MV2vJ
 plNjoXHVvexOh5cUhWAgn/iFUd85HlfRRMHQz9m1IAwISdsxboEF+eL1e7X9w04VkugqZL8dLvR
 /0LElYHPEZFYtx9vJLYpl2RCirsRpCmxwSAO+2CSIxcLUgFPtctMHH1qmg5XoIfRW4wiqsCwwsr
 vgeN5oQiXWaAJBw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patch series refactors the netpoll and netconsole subsystems to achieve
better separation of concerns and improved code modularity. The main goal is
to move netconsole-specific functionality out of the generic netpoll core,
making netpoll a cleaner, more focused transmission-only interface.

Current problems:
   * SKB pool is only used by netconsole, but, available in all netpoll
     instances, wasting memory.
   * Given, netpoll populates the SKB and send the package for
     netconsole, there is no way to have a fine grained lock, to protect
     only the SKB population (specifically the netconsole target ->buf).
   * In the future (when netconsole supports nbcon), the SKB will be
     populated and the TX deferred, which is impossible in the current
     configuration.

Key architectural changes:

1. SKB Pool Management Migration: Move all SKB pool management from netpoll
   core to netconsole driver, since netconsole is the sole user of this
   functionality. This reduces memory overhead for other netpoll users.

2. UDP Packet Construction Separation: Move UDP/IP packet preparation logic
   from netpoll to netconsole, making netpoll purely SKB transmission-focused.

3. Function Splitting: Split netpoll_send_udp() into separate preparation
   (netpoll_prepare_skb) and transmission (netpoll_send_skb) operations for
   better modularity and locking strategies.

4. Cleanup Consolidation: Move netpoll_cleanup() implementation to
   netconsole since it's the only caller, centralizing cleanup logic.

5. Enable netconsole to support nbcon, as being discussed in [1].
  * I have a PoC[2] for migrating netconsole to nbcon, which depends on
    this chage.

The series maintains full backward compatibility, and shouldn't have any
visible change for the user.

Link: https://lore.kernel.org/all/tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx/ [1]
Link: https://lore.kernel.org/all/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt/ [2]

To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Clark Williams <clrkwllms@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev
Cc: kernel-team@meta.com
Cc: efault@gmx.de
Cc: calvin@wbinvd.org

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (7):
      netconsole: Split UDP message building and sending operations
      netpoll: move prepare skb functions to netconsole
      netpoll: Move netpoll_cleanup implementation to netconsole
      netpoll: Export zap_completion_queue
      netpoll: Move SKBs pool to netconsole side
      netpoll: Move find_skb() to netconsole and make it static
      netpoll: Flush skb_pool as part of netconsole cleanup

 drivers/net/netconsole.c | 273 +++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/netpoll.h  |   2 +-
 net/core/netpoll.c       | 248 +-----------------------------------------
 3 files changed, 268 insertions(+), 255 deletions(-)
---
base-commit: 2fd4161d0d2547650d9559d57fc67b4e0a26a9e3
change-id: 20250902-netpoll_untangle_v3-e9f41781334e

Best regards,
--  
Breno Leitao <leitao@debian.org>


