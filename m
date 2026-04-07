Return-Path: <netdev+bounces-276088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIfKM9Y11Wlv2wcAu9opvQ
	(envelope-from <netdev+bounces-276088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:50:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E373B20B7
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F008D302E0FF
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 16:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D5B3CF694;
	Tue,  7 Apr 2026 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6RfnGXW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C940B3CE497
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580597; cv=none; b=O6Nl2H7XGJOP3TvyrSu2gKhn2hcRsbWFADIR5549IrvIadHliLhMv1v3GxuWH9kydime6qOehiOln0oyVwiDJjsAFvQLargr9VGhXsELErw7QK82LHp/waLlGYKCkybMd8/JASVBdxM6zC4D1ZanQjElx+09rxx4QBs0PdoW6l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580597; c=relaxed/simple;
	bh=vlaZpXscWUZ3B05OE1majSMSg9sMzDiqX6C22P6IGgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dDlNDgZLdAFzqykX4j77p8b0D+aiakRviOSWdhtfj9OKWWxpqipE9bkbmSjzGsXoUzikjGI19xsDQ5ejdnsH5xZhpls09Ff1k2Au2w+YcpXPG+QR6VCpgatbu7TpAR1hcdDsCSfy+ujvTSlT4gd0fjREbjc24w2POdZptijKe+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6RfnGXW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b25cf1b5f0so34767635ad.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775580596; x=1776185396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EUCVU3vJIe9dfiNXrQ/I9OAV/ScAJcuKICE2xaQxYn8=;
        b=T6RfnGXW6NEC4RkguSTFVOdpeoAmAcGRW4MJ1Sgu+lgKUt5lbqy1jZ3TgulGyNLbNc
         GSjLCG4jyWqtVkLUmVy0bj6XJRaMP8V1fYcEOHztIYWBrVEfx3ee/X/h8kvjb/Cz4RVH
         7D1XKBqw5paEmD14ix0E3A5baabuhEsdOUT46GKDUOkqOnl0w12LVTIgrXb8nNPBsxeb
         UMhaatyl9yzs3/aFZqFtn+KcHyhBr83lUQCBWwst/H/ee9BodQEsNBBF0aYeWFqfP6Fm
         wNaPDpgNZGsGFChKUxi16lwhR0dE/jA9okyrRo3H07BkC+Ws+LX7R+gt7rkQcpVjADm0
         hmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775580596; x=1776185396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUCVU3vJIe9dfiNXrQ/I9OAV/ScAJcuKICE2xaQxYn8=;
        b=NTYGqh/LCgKVlgh3i7Jhs9ziAeOd7MSoya/mPZinzDGn0JRHmQ1umXOdxvYCb0t3zO
         JbPRsUIfF+n842x841libDL00AMbexkWFz2vXQ2NP96KcLSP1vZPz1UY8qTWwztVuN7j
         xwIwx0Dfpg3cfV/Ew0my/Tj1t9LL91Q9e7dJ0eeYj6374hyiD3SQcFvsbisXPs5KvKuY
         bunkYn3CpvVG1JDXJrXszsGdSE7BFzRgxxVb5ULGtSw1Zz4hiTf4SERftProB1iFxWHF
         /rfjUrmfPGVlOznM/72d+TLB3sd3xt1ISg4A0GuXYSY+WwEJfD1dVFx7pKJ/8E/EBgWZ
         Nj0g==
X-Forwarded-Encrypted: i=1; AJvYcCVNUcCh52Z4nvq8W3h5RoecferLkrV21dycD6dyUTiAqsL9xO4q6uZfqFyaXk+JEF/jPQfAdZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu/Rc1M0CumtjUjUTMT3G1JbPoO0/zmZ9oxoEQYIlVyMgE7p/M
	wRds0Ug5QizuAR0eHD0xBfvTRoHkqMkiN0JIqi2/tttWKkEbxfoC/Phe
X-Gm-Gg: AeBDietyQtjVpidZY7s/omAxCxeDZZCibbUUKrJoGP/oZ5NNHVO3Sp+dI4RarqlI+ef
	jiyCAYp6m8pEYQ3euIUd5iqpMjtxatdSy4cvRhCEqRycCSFw/+mut2yRF/gbcnFqinOzsykQ7QD
	hgFupED5FQKvfvH9NH0w3h7crVuxvlrwcPpOSRWuLFdRKTXA5wfFZbV39fv0M6RVahkZH2jipSO
	Wu3dLbuAipesto3SHhLeQLEwtV0kNuzzfMQLXzueV0oNrR+lolJWqR152pVwBgfkxUMGpNF6spy
	g/G7TGzWZioeYILzQ6eb4eAXJzTzjkBzdxKqPj7PDuKJFDwm7kYsb/3LcIoC6+kMmFhjylPNTsa
	1hWg3WI1flTSKfN9n08ip325zYJgB0rAo4CndTqg4RZ/eFMaD0Gr1Gi1kwQmHQWsYer0KLKRJly
	2YTCukeWsUrrMIC/de9zSPCaMvXGHG
X-Received: by 2002:a17:902:f70f:b0:2b0:61c2:8e7a with SMTP id d9443c01a7336-2b28178afb9mr197013165ad.25.1775580596074;
        Tue, 07 Apr 2026 09:49:56 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497af31sm173287125ad.52.2026.04.07.09.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:49:55 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Petr Machata <petrm@nvidia.com>,
	David Wei <dw@davidwei.uk>,
	Chris J Arges <carges@cloudflare.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Dimitri Daskalakis <daskald@meta.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 0/2] Add selftests for ntuple (NFC) rules
Date: Tue,  7 Apr 2026 09:49:52 -0700
Message-ID: <20260407164954.2977820-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276088-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dimitridaskalakis1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: 63E373B20B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dimitri Daskalakis <daskald@meta.com>

Thoroughly testing a device's NFC implementation can be tedious. The more
features a device supports, the more combinations to validate.

This series aims to ease that burden, validating the most common NFC rule
combinations.

Dimitri Daskalakis (2):
  selftests: drv-net: Add ntuple (NFC) flow steering test
  selftests: drv-net: ntuple: Add dst-ip, src-port, dst-port fields

 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/ntuple.py        | 162 ++++++++++++++++++
 2 files changed, 163 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/ntuple.py

-- 
2.52.0


