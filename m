Return-Path: <netdev+bounces-249818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D38D0D1E905
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 12:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E54EF305D446
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 11:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E565C396B65;
	Wed, 14 Jan 2026 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imHo/hfD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08F4395DBF
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768391383; cv=none; b=mB3xS7amDq9Mnb0QfkHq/11IUE4IquqVOWPmzyhBjlkM2NP+qouMvMW4tbiAfypdiWcbJIBzXq/IjpdAWWCgAea9hj1nnNCwGA6anr8Td2qA6N86GD6WOuILVzKb+5Pw/71KbB5X+fvHyXt2MThoCOKc5t3YBMrRLt7zkWEpRoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768391383; c=relaxed/simple;
	bh=O1eZe5FAnr1YRgtrNN3URFFLz+R7l8GeROfDh01JaZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZMF9I/QCWL2Yy8VqBAbMVS/DfwlI/ch5vGUfaQE88DeW9CdTngsncyJ+oZsSVN0HLXd6RYrdqflErp4b2aigcbJXH5L4uqqeo32e9mPAUpr78/W2WrKLyNMz2XBTUeuZfY6M8WGPaavCvyeAIFSkyK+mqonL8yiB/vcTmtRgv7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imHo/hfD; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81ed3e6b8e3so2180792b3a.2
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 03:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768391382; x=1768996182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vUXiprZTx4CSbzOP/eMeB0U8/iitbK/Q5Q/P+2AtyCc=;
        b=imHo/hfDqy78hhRGusOkoTHCczHuJjnXhqx1XbT3PBwj6WMS9PQzVZRTew0Ja9TwG3
         iksZI5XblKLm/8OQNi6qAiOwaZzbcydibAVki3LmG6emeXoXr2Z8VHoZ63kniLSKBrz3
         G9HgPuaVLwo0oG/eEMYhqrZKOlQ5voDdphFY5ELuJqamo68RfVf7z6k0GscJSLpfGCRz
         McZnYwRZaH7g2TaJokRszz8Is5gk4pQvf9IVpWAVn2M4vkBysXwzyCh66ZPM9UUF4STm
         jGzavx2x6cCJydGdF6sOH3Pn0RImkDBhiyBRqZZiQOmwC66i1ZcsS7LGJL4jIWghD5Qd
         uPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768391382; x=1768996182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUXiprZTx4CSbzOP/eMeB0U8/iitbK/Q5Q/P+2AtyCc=;
        b=t6MVgSEvwhfCT+dGv6kkt3s9oa8LeupjRhH3doZXADlSDYTrIT7D4HLvtt+/SrAqLp
         3akummNndiMrgZSyZaF6mRNnCjKArYm90gdO/cwY66832iNugoreiYnAEiFo6sFrj6FK
         tqupeh/F1oJGwKkvh0+3oJa4rLVc+vef1sInoB9ODwN8hQorMNWzjeoguwouK67bcgpZ
         EtAti+tdfHwN5FJTi863Rb4BbRETHxThSQ7rsN8ErGo5hRCUiva3vW8vrKg2EpajHUu5
         p0qYGT3ECSJxjH+BIGfoY0nYvKvvp+g19MNBou/dphvO0DYCOYZhUgv4v4ql3gdabAnR
         SVIw==
X-Gm-Message-State: AOJu0YxqsuINhqtDuKBhpGGUlsxetnF8+x5P7MczqA+1VDSRpwATWEI6
	Y1n9i0aSIv8ggtlVHzkX7bQMBLfwlP23uE71W+8yGQVcTbl/EDXSBHEvHxpoxw==
X-Gm-Gg: AY/fxX6ZjOMN3/OP24QA3nUXJxu2/fltiFf3ccn0xdbibv+mhfj0uK+OEx1vPX3zCBN
	/UCJJZCXO1hX4QPC+iY6180vFBA3VZEsH1ViDoyPR1crb4eUQODnAqLdk26LoASbS/OoiZRmIrU
	7Fao11qrsUL2cTF3N15CaKF3nIr2K1sk+HiAGcidKjZgXh7KQ7ejTWkJ4xfhyD78VteXL8BrP1i
	1xl2vyIw7+6jjVaPr30BsSurC0Vb7zvzntdLIEphV8jT17lFcDDKI3salOz0/TyiFsn8Xy+/VbO
	FuyOBRlNxaivXQvb14AiqkmyXCDDcmXf4bHtclRnoRodGrbFWT4UxIJ+66YPkc9HNNvlBJlJHXc
	Hw9EVhx1KxCf+4sF9phm3bzTMzgVjG62GFRAXib1ITqmwUiOmHtf98zOGOX38pQy9LnnINSdJxT
	K+n34fOzjE/hnsyiP6o8k+MaIJKwb6SZPHydVKphhUhwPVx2QNhS/wSQ==
X-Received: by 2002:a05:6a20:7f9d:b0:35e:5a46:2d68 with SMTP id adf61e73a8af0-38bed0b5ce4mr2456454637.9.1768391381776;
        Wed, 14 Jan 2026 03:49:41 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28f678sm22632123a12.3.2026.01.14.03.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:49:41 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 0/2] net: dsa: yt921x: Fix MIB overflow wraparound routine
Date: Wed, 14 Jan 2026 19:47:40 +0800
Message-ID: <20260114114745.213252-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix warning reported by static checker.

v4: https://lore.kernel.org/r/20260108004309.4087448-1-mmyangfl@gmail.com
  - add missing u64_stats_init
v3: https://lore.kernel.org/r/20260105020905.3522484-1-mmyangfl@gmail.com
  - use u64_stats_t
  - fix calculations of rx_frames/tx_frames
v2: https://lore.kernel.org/r/20251025171314.1939608-1-mmyangfl@gmail.com
  - run tests and fix MIB parsing in 510026a39849
  - no major changes between versions
v1: https://lore.kernel.org/r/20251024084918.1353031-1-mmyangfl@gmail.com
  - take suggestion from David Laight
  - protect MIB stats with a lock

David Yang (2):
  net: dsa: yt921x: Fix MIB overflow wraparound routine
  net: dsa: yt921x: Use u64_stats_t for MIB stats

 drivers/net/dsa/yt921x.c | 258 +++++++++++++++++++++++----------------
 drivers/net/dsa/yt921x.h | 108 ++++++++--------
 2 files changed, 212 insertions(+), 154 deletions(-)

--
2.51.0

