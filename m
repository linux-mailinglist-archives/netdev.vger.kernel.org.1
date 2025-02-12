Return-Path: <netdev+bounces-165627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DB9A32DD4
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F162D162673
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 17:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230612586C6;
	Wed, 12 Feb 2025 17:47:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEFF256C70;
	Wed, 12 Feb 2025 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382462; cv=none; b=Zh0QigoPOJ2naod1w/DlRp/16GAdrgUeIp4JrgGFDWbXNiI+EMODk5pgjJoO4BAc3gzeiDOCD6LlnYlyB9Q+NFwwWRGxPCeQUAcj42VLFuRebt8iyx/NLQRQzaVEyDj1GTUpVSDmyjZIORncfw4p5yta0eKhNWZThpy8+ho4nUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382462; c=relaxed/simple;
	bh=ucsm6sBSBsAgH7j0WZaNAqkfAINXI0ndAlQASzkfYXw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bzJumYOiBNrpug5k94AySIlH9TXKqSuFXNOPmbsFKUjTTOcemkRS7lacWZ2i/CbUsuqwFnFNBnXmySOtAUYKd+KzAbzs45aGBIB96z2BK2WG8xLGguSPK6JFglCpYuXABp6kaBmIArZJu9LRP6pBV4MMKCmb1+k9gZDgoiW4py8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab7e9254bb6so7293166b.1;
        Wed, 12 Feb 2025 09:47:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739382458; x=1739987258;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8R6SEYjUrW1in7V0EGXb9bOA/jMJDxBdUk3K+qnY1I=;
        b=BLbsKTu0Vp6eeEMBV/CFuV6Xd4I1oGhf4ojuniOH0XNI4/cp/+2g0Xwt01D9bAJGom
         zHw6Ww9573FuhvfVgC2HiM1+b2DKsvDzJFWln68j0ArSEQ/UDGPqwwm9U8uGSKVwaM3t
         hE2n0Mqj8P5SPsBlMRXzH6WAt8MeHkunh/bwJ5W6wCm/A4nVu45P5L/VJtgztdsNEhVv
         vYNpwPNje3Q4/jXYUdImr2AGHuvs2xcPnBZVgDxjSG+lbAy7pKAN3ROcGmJp+mK4Ae2x
         t8PU6xqWQrg/I7EwVzB0ZxBfo/juMuhwulNhuGaQifPHBMgzU20nAp7qDn97j658k+/P
         ogdw==
X-Forwarded-Encrypted: i=1; AJvYcCVjyDmUvSB4z9B/orNVSRxDyY/HefCBY1/v/ZzcctqDZ7CpQnKpNDT4vvJ0HccalW1y+gDTie0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuvlB1UpiqWIvq4cgCFdylWO8hVbTGgE8R2wEyAoIC7bqaDJDb
	bjEXKJkpCZwt5ZJkC7BqFMcLZCr7SPyoZYAoPRP/z/ORDmVk4Qux
X-Gm-Gg: ASbGnctkALkLpeuA7TeM6RB8LBG3Gbqr/ykIioaM2EQVsBkFPrySzHNk7YYPRpgAg7w
	prOT8roInLKgKFxuGUCUdnSGKgmdui6QrBAejjIv656hrxK6VXgd4pWLG4FGzp7KNvuTNFFxSMQ
	SJ17072yKbE+UD/0sb3uh+1BbsSU9wu0uBHi6gQ5bqgsXw3kB7jioSpzny/bXkt8CwWR5fc2P1z
	hzSb1hb0fmaCTU2oEfqspL4/8P8QKK8+75QDTyjRCS1LujsdMRgDYiIU5eH1TtJIB+095APEnmX
	hSAvKg==
X-Google-Smtp-Source: AGHT+IG9LHBsJ17Owfwx71M/3TSTvaJ19msX1xru9qKG8OHNDp4WJ8qLHyrzAIG6fuCZb/bjBfNQKw==
X-Received: by 2002:a17:907:72d2:b0:ab2:ffcb:edb4 with SMTP id a640c23a62f3a-ab7f33d9d34mr337981066b.25.1739382458033;
        Wed, 12 Feb 2025 09:47:38 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7c4a50e73sm633936366b.36.2025.02.12.09.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:47:37 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v3 0/3] net: core: improvements to device lookup
 by hardware address.
Date: Wed, 12 Feb 2025 09:47:23 -0800
Message-Id: <20250212-arm_fix_selftest-v3-0-72596cb77e44@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKzerGcC/4WOywqDMBQFfyXctSlJfEVX/Y9SJI+rDbSxJEEs4
 r8XXVlo6fowM2eBiMFhhJYsEHBy0Y0eWpJnBMxN+QGps9ASEEyUTLCaqvDoejd3Ee99wpgoomi
 sNnmuWAUZgWfA3s278gIeE/U4J7hmBG4upjG89tbE9/23duKUU2YrRM0K0TR4tqid8qcxDFvmD
 1nIuuTSit5ycyS3H5M4tDn7YhCUUa1koUttSmnkh2Fd1zdIKxTBNwEAAA==
X-Change-ID: 20250207-arm_fix_selftest-ee29dbc33a06
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kuniyu@amazon.co.jp, 
 ushankar@purestorage.com, kernel-team@meta.com, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1821; i=leitao@debian.org;
 h=from:subject:message-id; bh=ucsm6sBSBsAgH7j0WZaNAqkfAINXI0ndAlQASzkfYXw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnrN647ffaRfYdvi93rNjAPSbQqJSAi5Ch7aN8/
 lMtbtXAjpqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6zeuAAKCRA1o5Of/Hh3
 bTMgD/4mU845Zu9P5ShPRHE4FDDrN+aH7oVRrzz4ZApMqp/4ShbnaYQhnLEpNEUe0DdZM2e3b2Q
 cA4+v9NjlFwvvMJIAedQOcJD6gvDfiZP4fziioyKZdYRiRndAESUaKCgDrfKnpbU21rxakVTBLX
 pLiSyi+fn2U3y0xwgcuxYf6ctpQBT5PzBxFiUncxcpvFFlXg6HMVjDFjybCVIyCB+kNGEXuTi8t
 pANftrg4P1MadiadMNuqvtXKWvF1WSIhe73crjNdOee/nm+qA6G/zFsZjIL9BJaPXhJSfjyfWpm
 puhfeRs/zNBK6jaz8QRD4n8PewTamMTILnfQWJH62T0xTQxyaIZGY664N2nE8ntdeRBExDypVBw
 MgmHU1eZGkiJ77eMXviZtWp9OPelqmBiX+QsFDMZeUK9BjUG8jUMR3iP/D2Hc5bqSDXdISSIPUF
 OoyIw4V9Srul5rhBNGm/t978K4808Mvn1OdI1mZDKX5t8Yt3+cgHuZhC+TIh3vmoyn77k3ZS13C
 ZAPxfsNSl4XZ2PdETvjqh38aQEuroKc6gRTSejJcnTvMl4pAeV/AH8kbUAuP2mpMpWpiHdMPiV8
 FqJ2G72t7H2JAD3W1gwMhzio5ZOqxHj8kv3wJ6TEZImf5VZq4RjP7AgeIjiw51kcQLJSH/y+Cmj
 zNkWEUR8pz+KHDg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The first patch adds missing documentation for the return value of
dev_getbyhwaddr_rcu(), fixing a warning reported by NIPA. The kdoc
comment now properly specifies that the function returns either a
pointer to net_device or NULL when no matching device is found.

The second patch adds a new dev_getbyhwaddr() helper function for
finding devices by hardware address when the RTNL lock is held. This
prevents PROVE_LOCKING warnings that occurred when RTNL was held but the
RCU read lock wasn't. The common address comparison logic is extracted
into dev_comp_addr() to avoid code duplication.

The third part coverts arp_req_set_public() to the new helper.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
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
Breno Leitao (3):
      net: document return value of dev_getbyhwaddr_rcu()
      net: Add dev_getbyhwaddr_rtnl() helper
      arp: switch to dev_getbyhwaddr() in arp_req_set_public()

 include/linux/netdevice.h |  2 ++
 net/core/dev.c            | 38 ++++++++++++++++++++++++++++++++++----
 net/ipv4/arp.c            |  2 +-
 3 files changed, 37 insertions(+), 5 deletions(-)
---
base-commit: 4e41231249f4083a095085ff86e317e29313c2c3
change-id: 20250207-arm_fix_selftest-ee29dbc33a06

Best regards,
-- 
Breno Leitao <leitao@debian.org>


