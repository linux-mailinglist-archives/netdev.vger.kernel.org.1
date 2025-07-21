Return-Path: <netdev+bounces-208481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBAAB0BB4C
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 05:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174001897569
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 03:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D4F1F4165;
	Mon, 21 Jul 2025 03:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nErx9aXJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A93D2C181
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 03:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753067789; cv=none; b=LUMyl2M+iS1XwPJzkvAum77sKUfq27iTuX7iVJVv21MZ9NImSpcurY90KkVjcgE/CYBPEGzTlVj/lH76Ik7C4OpwIyzOAGfnYThFh51ZNsIIIq4AMrCLK8T6YKln6S+3LTjCCIP7ipGPGXI++eELGGF7ude0i0fF4mLoqysZaV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753067789; c=relaxed/simple;
	bh=MnuQvC8PQvA/eEiExI3rTnVFJWnM5zyyCEenFw/flB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a1utYcqfJcrqFL6FRUFGQZRbX1TrPXfaKqBCXuMcietQ+y4MwnKij3/Esey97Jt8T4isywRqwlMoecxADJYEE9DhnFgpzZY9CUZSCO4VkSPF2jUn7HLwMTAFSCvsm0uq/xI/+BlmP8/GwWptxMxs4izbzBoZMd99Q21U8yjlqCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nErx9aXJ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b34a71d9208so2514525a12.3
        for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 20:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753067787; x=1753672587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KB8p34NelKganShyiMEfH6Xe0mjmPI6uy1GcLjOfqyc=;
        b=nErx9aXJB0KISyryD/WPD4nSipG2N2x0QcqBHVbtvrGvo5BluU5TDARHeMSiXUl9B2
         rIN4MWs9bxs2nu9u8oVY70YbkfGhpDK1dMpRb27gqM0Aq/TmV6glFD5i7Hr3FnZuFLUM
         eF/N7SVZXSUGgfGy6cj++DGdj5tdQmW7+L1nV2aVmR4QeBFY/mkR9O0PEtizZ+KXDjJi
         AHgVVFFsFudAA+uRXxusESXpk1M66LPX5EYxTrVOj/Q6UC3l/D5a5AmPFbaEc6SlBPRB
         xYaIQS6AWZ59DBAQXNicBsSC2JQnRY9BhkXQdco0TtwSp1FsQvNbg25tYLaDz708WdMp
         +PAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753067787; x=1753672587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KB8p34NelKganShyiMEfH6Xe0mjmPI6uy1GcLjOfqyc=;
        b=Od/3jm4bpgD9Id6YK35FgPMTdBA6BfyOG3xaLDidF/uHv4lP257uDxV4+U7+weKvYf
         ylKpi3mOkhSaMLC5MzjXOuEarVlzG0kV+63IYP5HHn008eFKaOh9tZe0TwDc86A/1EDe
         Tto1gbomONIDIcV3yJyvmgENJrUBPHNkmEuRnReBRqWA0INGeHuJ4ZQJz43iIY1PXGE8
         mBUz8KLJbLM59o4qVpT2SZcHDCsJfsjOQgUxA4ynEbUuRtrMAAfC+xoeXt1ynP99MWud
         RFLF76aM87N30vhRk5d0//MhO1/3ZkTIrhEz3opyLYvHpyUMr4VvsTXPERL+OW+I3hbE
         l48A==
X-Gm-Message-State: AOJu0YxJgJvx7fgZD1QxUqWc6aDOOmD3Nzy9P2j2I5JW0eIRitDj+hRf
	wMIK7iGf0HN127/5OtunHucugEjIJ6MT4fd/WtuMef8BZ26iQgBi+yY/lf516tGifwE=
X-Gm-Gg: ASbGncufE2jWK4lLce7pGy2XvbwlyF5MhMHumTGdhgYcvl4mCcmmXkwux93njAUBouQ
	/wr20MrJKpI3WcJUdVPLdXEDwNyJFdyowd0UEim0eXoqkTLnTquoQtwZWffXE8d75rGTMA+k+kX
	Bd/4UoESOu+6WpTD4F6hFwga4l7EuDge3/tC0L7FnJfXL7k977yfVD1wbwmPSaRtkzrSWYownyX
	A4bjk0guRDxdimKNRpltWD5e9px95VbjUpLVeCzO4+5rWG17KNEnQYxInnuzcwQeSGq2vOCV3B6
	lCHluudr4lnpXIu0cOj/FjYz1yfODK+qKyF079O8wEa9LwJ7OpUKvUNSjUFPXuo2QSqFzQzzOmJ
	zuHcsT4Ah+4svt1W3FH8MhGm9T1N4a4iCaNJJ0jUYNiSrmvidohRjYQ==
X-Google-Smtp-Source: AGHT+IGO5pKUteUta9bno95k4QkyMSkbKE1f0Pc2RgTq0+vn7wEIxl2sJO5+y7tfaQMzM6d/wB2ysQ==
X-Received: by 2002:a17:903:1448:b0:236:6f43:7047 with SMTP id d9443c01a7336-23e2566b02cmr240992525ad.9.1753067787323;
        Sun, 20 Jul 2025 20:16:27 -0700 (PDT)
Received: from krishna-laptop.localdomain.com ([115.110.204.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6eef80sm47899725ad.181.2025.07.20.20.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 20:16:26 -0700 (PDT)
From: Krishna Kumar <krikku@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	tom@herbertland.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	atenart@kernel.org,
	jdamato@fastly.com,
	krishna.ku@flipkart.com,
	krikku@gmail.com
Subject: [PATCH v5 net-next 0/2] net: RPS table overwrite prevention and flow_id caching
Date: Mon, 21 Jul 2025 08:46:07 +0530
Message-ID: <20250721031609.132217-1-krikku@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series splits the previous RPS patch [1] into two patches for
net-next following reviewer feedback. It also addresses a kernel test
robot warning by ensuring rps_flow_is_active() is defined only when
aRFS is enabled. I tested v3 with four builds and reboots: two for
[PATCH 1/2] with aRFS enabled/disabled, and two for [PATCH 2/2].
There are no code changes in v4 and v5, only documentation, etc.

The first patch prevents RPS table overwrite for active flows thereby
improving aRFS stability.

The second patch caches hash & flow_id in get_rps_cpu() to avoid
recalculating it in set_rps_cpu() (this patch depends on the first).

[1] https://lore.kernel.org/netdev/20250708081516.53048-1-krikku@gmail.com/
[2] https://lore.kernel.org/netdev/20250717064554.3e4d9993@kernel.org/

Signed-off-by: Krishna Kumar <krikku@gmail.com>
---
v5: Same v4 patch sent with a change in documentation style for "return".
v4: Same v3 patch sent as a new thread instead of a continuation.
v3: Wrapped rps_flow_is_active() in #ifdef CONFIG_RFS_ACCEL to fix
    unused function warning reported by kernel test robot.
v2: Split original patch into two: RPS table overwrite prevention and hash/
    flow_id caching.

Krishna Kumar (2):
  net: Prevent RPS table overwrite for active flows
  net: Cache hash and flow_id to avoid recalculation

 include/net/rps.h    |  5 ++-
 net/core/dev.c       | 89 ++++++++++++++++++++++++++++++++++++++------
 net/core/net-sysfs.c |  4 +-
 3 files changed, 84 insertions(+), 14 deletions(-)

-- 
2.43.0


