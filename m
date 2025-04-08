Return-Path: <netdev+bounces-180512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2117AA8195D
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C2497B2BDE
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 23:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFCD218ABD;
	Tue,  8 Apr 2025 23:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCjNzuJJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523B315A8
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 23:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744155081; cv=none; b=QK5+uMlMLYbZaYsL/YGC0RgDGbGqAQVMfu6Xs1tMc1rc+lRQjG4cfKrYN3Ho6Ji2teN2bPJr4MfdklFKuUed9tCHod7mc/F8+lDGYJtp0m+Rc4CCu4II9m1+Wv4tDp7Dt0ahkMgefmoKGCaINvVT+Z2kb03wrHKuEPwXNcJn8Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744155081; c=relaxed/simple;
	bh=YCRBAgEr1OqSNF3/6zbuUwRQ8zW8L6qOLVlwShyVooA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JiX8AS7u6t0dgiIq5zYCzd1p9B8W/jCLOF8FTC45eHhLMML1k2TrCfrYEQ6oLhdiK00S0GWJGkIeoDdPsILelgfq/Nmtxurqd+mUesIW58D43xbzDegIpCmMA/FMvkIGkOxJRuqGWqIWbCattQdLc5SD/ofDhZTqJo0D5bj6AWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCjNzuJJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43690d4605dso41918905e9.0
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 16:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744155077; x=1744759877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ows4oTqmiN2OktRiuaSZg2zuOzJP+kImnUZLyOPmAp8=;
        b=mCjNzuJJ2u+JdY9uQmN3+h0R0++0s3lYEuOTXhczRtULsWUY9g7weCxeOZd9cjocUM
         lMZgih00RvPLQLcsucAAI3/2FPx9kBa+148G6ay3Lb70rXrMxfkK2BGW7ru2/de8rGKg
         ImkanDe3vlnRSChAPNw4UpeyuRa8PDRNWRUIiufpFtfy30L+WJalIIN9EN1BooUYmSjw
         3L63YIV4/klVHyOg5L0W/0LSQ9cv7HLf6DPnNxcSQaaGkRORRONcy/5gzhmDYHGCouZr
         i2uZxg1QhbuNSqZ7oI4JFkDeqw7QCRDssdqS0vcn5P6MpQE3wzZvU/x54DasJ/ml95G7
         +tpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744155077; x=1744759877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ows4oTqmiN2OktRiuaSZg2zuOzJP+kImnUZLyOPmAp8=;
        b=DtDmjL9LgY8qeMMelc8t9v/MnrSfv3ksFmPNfdhhjHzqZzHj31cbWlhh/wvaSWBLqY
         aJgqe8Prxo4PG9WQvGVRX1areVToVwL/8fGYq3XG5oacQqJU81Ub1BNinjfCPoplHqky
         DGbPF6R/BHeQnIFaq+GqwpI3+zRfyxhaVKTafFwNLUiOZ3b+PGZivt2eqcT3kUnixVIh
         iUv3rtaplF9Q6sBtHCxLxlvLamAEcgFUMywgkyh091EI4Pw9q2pNzNyVl6qbrJ5Zf3rG
         DF+Ou3Q6Ptw3pnQxp+bzT4bkYMN0UIvptXfe9/D1j+IpdcyAyk0qc7/OShZquyR7IGB+
         rQGg==
X-Forwarded-Encrypted: i=1; AJvYcCWy7JJq1QdYr2kT57GnncEzYc5peq59wg6vStwMi0ZFlAxX7zNEkX9bw8capntZdnaybV+Jf9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxricipOHB4p6XSNK5qPSGIwOk0oAnzM5QIWAPpGnJ9tO48i62N
	+eGGGZo6ODns0C19ZpeRWJgkBhH7iMTVaku6/tsasMnQ4CVlVNsR
X-Gm-Gg: ASbGncsWFML6bG8KV6Rn5SCIGK02XCDTRIC7gUs3kg66PXCsydB1eNFUqktcCVvPY9G
	2QAdAw2DwgIKcNOqg1N+9vmvr9+n6pFWivn+b1+RJFDaCMTLkqVRqfujrMLc1pbo/CHiEHAPXGO
	93tXj6j3r40sTjg1tcFZ6dD/48Z3KaPGd/GqCM+jL4ApCzK9imDkNnRcS6xweaAOiBuaKhWPpgF
	e3X7Bn0rg+jMMrqF+aCd3OsGE9U3EWesyoX6Cf9cWK8gS1kySlU2ZcnottBwr2MkBc9fvKXP0XI
	siSgGgcKd/bIy5BtiPyeqdBhVCHiboot0m3KYBzKAI+izNC8y5XW892Px6PP0NwgMgdlPA==
X-Google-Smtp-Source: AGHT+IHky4RZECkzCa51MFyrpIp89rq4mX1V/aGu5m3X9ghmiTgQd/lhFzqE5IrVQpoVB/VHmSEj7Q==
X-Received: by 2002:a05:600c:4443:b0:43d:2230:303b with SMTP id 5b1f17b1804b1-43f1ff3b39fmr3168495e9.20.1744155077423;
        Tue, 08 Apr 2025 16:31:17 -0700 (PDT)
Received: from localhost.localdomain ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d75ac6d66sm9934565f8f.14.2025.04.08.16.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 16:31:16 -0700 (PDT)
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>,
	Muhammad Nuzaihan <zaihan@unrealasia.net>,
	Qiang Yu <quic_qianyu@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Johan Hovold <johan@kernel.org>
Subject: [RFC PATCH 0/6] net: wwan: add NMEA port type support
Date: Wed,  9 Apr 2025 02:31:12 +0300
Message-ID: <20250408233118.21452-1-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.45.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series introduces a long discussed NMEA port type support for the
WWAN subsystem. There are two goals. From the WWAN driver perspective,
NMEA exported as any other port type (e.g. AT, MBIM, QMI, etc.). From
user space software perspective, the exported chardev belongs to the
GNSS class what makes it easy to distinguish desired port and the WWAN
device common to both NMEA and control (AT, MBIM, etc.) ports makes it
easy to locate a control port for the GNSS receiver activation.

Done by exporting the NMEA port via the GNSS subsystem with the WWAN
core acting as proxy between the WWAN modem driver and the GNSS
subsystem.

The series starts from a cleanup patch. Then two patches prepares the
WWAN core for the proxy style operation. Followed by a patch introding a
new WWNA port type, integration with the GNSS subsystem and demux. The
series ends with a couple of patches that introduce emulated EMEA port
to the WWAN HW simulator.

The series is the product of the discussion with Loic about the pros and
cons of possible models and implementation. Also Muhammad and Slark did
a great job defining the problem, sharing the code and pushing me to
finish the implementation. Many thanks.

Comments are welcomed.

CC: Slark Xiao <slark_xiao@163.com>
CC: Muhammad Nuzaihan <zaihan@unrealasia.net>
CC: Qiang Yu <quic_qianyu@quicinc.com>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Johan Hovold <johan@kernel.org>

Sergey Ryazanov (6):
  net: wwan: core: remove unused port_id field
  net: wwan: core: split port creation and registration
  net: wwan: core: split port unregister and stop
  net: wwan: add NMEA port support
  net: wwan: hwsim: refactor to support more port types
  net: wwan: hwsim: support NMEA port emulation

 drivers/net/wwan/Kconfig      |   1 +
 drivers/net/wwan/wwan_core.c  | 260 ++++++++++++++++++++++++++++------
 drivers/net/wwan/wwan_hwsim.c | 201 +++++++++++++++++++++-----
 include/linux/wwan.h          |   2 +
 4 files changed, 389 insertions(+), 75 deletions(-)

-- 
2.45.3


