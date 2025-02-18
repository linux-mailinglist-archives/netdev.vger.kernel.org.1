Return-Path: <netdev+bounces-167351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F27A39DF3
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85649166085
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB22B269CFA;
	Tue, 18 Feb 2025 13:49:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1869A269CF4;
	Tue, 18 Feb 2025 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739886588; cv=none; b=JPpAruy/GvlnnBxRxT64vAtsyW2utFhLEOhdj9/BX1RirQAy34ZAhMEm2X3ze2/MDjBCS3giA+0C4xakDWf2nsQxxysc/gCbUA/vfGB2SDU5IWK4i8SA/7j4QS2CjMsT/yBVj9gLhfWpCkzzIBQM80iLdkKzShdgIC0mRQ5S42c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739886588; c=relaxed/simple;
	bh=s+UEwubtSRLUAx56HP8sZOyMWqKCHwMhyIyz4gFD178=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LFrseLGCfKqXHMWVE+MG3ycCa9KvVE32LPiolb5gPJxfOvTdVd/hNTLemkuhnZMy93WxDpJV7gFpi61UUCI6f7cuOpODPpnoFTdNa2n4Amjry6dP2EqC8Jg273m8omL/vDGCsVmLstaRoT5GOs0z4kUAQxwNQGqRZqYZZnhWH8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abbb12bea54so234303066b.0;
        Tue, 18 Feb 2025 05:49:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739886585; x=1740491385;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Smp8AXskfPVpWUutFPlJyHkilL6BJh15L6PDj+Zvuf0=;
        b=GiJgPQnJnCi7AJeDwM3C3wEWzLX3lCOu/CNPeNty9xQxmZlWURCq4r6DyHiU7gUtY/
         50rKN0oeyUm+ewRuFysItPHrSvVAvCWu31PRHtn2Fp3HCBDQI5Z8j6nVW2uU6adt5EP9
         xBizg6pdD/czdKX+L9UraAYyTTFqDetkuafRssYQ1TukYp4XUJQiM/GE+8MaRNUh+hv1
         R8Sh3ay/sDkDw6oPG+gEhOqHTml3KmJ6VbjiTF4WGccTSwIskVCcbqFHgXjA0t8h85Rv
         e8HX8+7WrEYquu5Nj/g2/YvytyLGvTL0aVcDQpCyHFTDpmXDCDbcMkAYDkVyBByUhFua
         saIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnAskTM82zPmwP63kF4HRMm7PaQEbB9A1xGJaU/Gdj3ot3lyp3SUdd3FjvnwOE102Odz33C30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+HfBB+J47ZlqIHhpD/sgaPJNph2vsVvFJVY7BhKAFxi470cmN
	mDDc6NXOxK/POF23PVfyLt4Iu8jyQ51zRRQokhTNabibE2LLyCJy
X-Gm-Gg: ASbGncs31MuWC98KbNawFxb1fRMOVBAK3dCDWEiWftdx9C9YcL7npbmrJNX+VeIa7eC
	NDOCblmqkO9WQPjCaHegvgWoBBJkLxFl1EcIfr8vRyJVv7M4CjGLs1WspDqO2YprdVIBiauElpI
	6mMNNWM/z0XfW68OWLHz+d7mIl35g+OwOe4xQmVox9Z/maHJcege0uo39PeFIWVnq7JH3lOUYVn
	nVfmJZFdogpn5If+iZjbsCmebG+F0aJwayrj4T2zQ3J8T0po+yXP9odr08YRh/HoVgjRyHrvHhx
	1sU=
X-Google-Smtp-Source: AGHT+IFtIZJWXZU0uGb306U4nEoqHhrs2nB+/nGaP4JLKqOw97xIq/CTGPIBABu+T3G/eo2Q9zhjUg==
X-Received: by 2002:a17:906:710d:b0:abb:a3a5:a175 with SMTP id a640c23a62f3a-abba3a5a325mr643651566b.57.1739886583496;
        Tue, 18 Feb 2025 05:49:43 -0800 (PST)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb7c76b0cfsm616522766b.28.2025.02.18.05.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 05:49:42 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net v5 0/2] net: core: improvements to device lookup by
 hardware address.
Date: Tue, 18 Feb 2025 05:49:29 -0800
Message-Id: <20250218-arm_fix_selftest-v5-0-d3d6892db9e1@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOmPtGcC/4XOTWrDMBCG4auIWXuKNJYs26veo5Sgn3EiaO0iG
 ZMQfPcQr1zi0vXwPe/coXBOXKAXd8i8pJKmEXphKgHh4sYzY4rQCyBJRpK06PL3aUjXU+GvYeY
 yIzN10Ye6drKBSsBP5iFdN/IDRp7hsxJwSWWe8m3LLGo7/S0uChXK2DB7qanr+D2yT258m/L5W
 fhnqVtrVBtpiCrsl88/Ftq1lTwQCCV612pvfDBtaF+Eei/QgVCjREuma4K3lrV+EfReqA8EjRK
 psUob6lwThl/Cuq4PrjQwGbYBAAA=
X-Change-ID: 20250207-arm_fix_selftest-ee29dbc33a06
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Eric Dumazet <eric.dumazet@gmail.com>, Breno Leitao <leitao@debian.org>, 
 kuniyu@amazon.com, ushankar@purestorage.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2058; i=leitao@debian.org;
 h=from:subject:message-id; bh=s+UEwubtSRLUAx56HP8sZOyMWqKCHwMhyIyz4gFD178=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBntI/1evO0YCjbOEhcm6RY+luo5y0jhCT7yiHg0
 g/GhCahLU6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ7SP9QAKCRA1o5Of/Hh3
 bcoRD/0Z9ODAI/QPX196F9Y+tgiDRdkh7a9aUYcbEmgPdL6PpdLM8eBpW4iVBrG9u0ci26NsdKv
 rNnYIDmFJzSgRqJurgt1Hp+TSbS9t2NBQlAXZT26JJizW7qZYpFKfUvmexCRoOcjDdt2JyCD+5N
 5qenGQ7QcPhJQiupGbXheCTS7l6bfRUXPU1vKSgCoIeurMtdrnumdP8CFCjOMx2VUuxiyw3F+Gq
 ilImHG2mKyYmDGQImfIPeGgfip0IuH6zHgSu3fvfAbhRfSFF/3F+d6NjhMGF3Hhjmrg/6nOkBcH
 jbhr/y2KcVtTJVUuDfzo13XdW8UXk2G8Y+fS4Fha3yfcdDyrPS6DflAeHIKfo9GrjU8j6e+3WAi
 D2RVY/pBoRKckVzv+HI2tb3Bc9P1s0nNSPcS7Y/393DU0+5UrJJhUPI1tJa56txDttqpNVjdr4j
 EmMa915NL57ltbdKZr6d7w0LFAEVmDJ3tcDo45PGWo5GQGqi4huEm7Fc4NPZ6vWV9MC/QAPeApm
 z+VzNY5YFC4nOQC6D9c0s4kvQyBSOn57IAbS1uxhcK+E/2TIkhO3ukfXpiGMGzR5Lvrujs0qxTV
 /8r7pwQGX5Id4bSda4I/u1VEs25T2AJrZ57EEZvXCdtMA4fIcIGvlHRHLcrwYgg6oQI4ul6NsNJ
 JHbRoN8+nDDCSZg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The first patch adds a new dev_getbyhwaddr() helper function for
finding devices by hardware address when the rtnl lock is held. This
prevents PROVE_LOCKING warnings that occurred when rtnl lock was held
but the RCU read lock wasn't. The common address comparison logic is
extracted into dev_comp_addr() to avoid code duplication.

The second coverts arp_req_set_public() to the new helper.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v5:
- Change the function name from dev_comp_addr() to dev_addr_cmp()
  (Jakub).
- Fix the kerneldoc function name.
- Link to v4: https://lore.kernel.org/r/20250213-arm_fix_selftest-v4-0-26714529a6cf@debian.org

Changes in v4:
- Split the patchset in two, and now targeting `net` instead of
  `net-next` (Kuniyuki Iwashima)
- Identended the kernel-doc in the new way. The other functions will
  come in a separate patchset. (Kuniyuki Iwashima)
- Link to v3: https://lore.kernel.org/r/20250212-arm_fix_selftest-v3-0-72596cb77e44@debian.org

Changes in v3:
- Fixed the cover letter (Kuniyuki Iwashima)
- Added a third patch converting arp_req_set_public() to the new helper
  (Kuniyuki Iwashima)
- Link to v2:
  https://lore.kernel.org/r/20250210-arm_fix_selftest-v2-0-ba84b5bc58c8@debian.org

Changes in v2:
- Fixed the documentation (Jakub)
- Renamed the function from dev_getbyhwaddr_rtnl() to dev_getbyhwaddr()
  (Jakub)
- Exported the function in the header (Jakub)
- Link to v1: https://lore.kernel.org/r/20250207-arm_fix_selftest-v1-1-487518d2fd1c@debian.org

---
Breno Leitao (2):
      net: Add non-RCU dev_getbyhwaddr() helper
      arp: switch to dev_getbyhwaddr() in arp_req_set_public()

 include/linux/netdevice.h |  2 ++
 net/core/dev.c            | 37 ++++++++++++++++++++++++++++++++++---
 net/ipv4/arp.c            |  2 +-
 3 files changed, 37 insertions(+), 4 deletions(-)
---
base-commit: 0469b410c888414c3505d8d2b5814eb372404638
change-id: 20250207-arm_fix_selftest-ee29dbc33a06

Best regards,
-- 
Breno Leitao <leitao@debian.org>


