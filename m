Return-Path: <netdev+bounces-250835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DE6D394CA
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 13:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 396923002D40
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 12:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839FA32A3DE;
	Sun, 18 Jan 2026 12:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ins++WRl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EAC32A3EB
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768738191; cv=none; b=kEmsN2dJI9wIIwHU1ZKQWhmF6KLYiQM2XillzW8J1hTN8H1QkPV6WrbppC6Sb9DD1FW5grXEY91Q/tVhFbsw/QP4vOm8K2hBs70lHV+RtmWJRtgLm51j4ifm/UhC9rOYoy3AQvu7ZtM4Lhh5RQvcSKa+tGZd9caR7mu8gcs2f1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768738191; c=relaxed/simple;
	bh=oIapkYs3xDFoevrWEZZ3AVCEJUqTZBSkVtZ85yZms3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qyg8RDfEGs8XN3zwY8rZGcodmlxzK+bPb7+60tFPlGBwHw6xs3nLnrTGM7KV24kNoCF7HghGUKvXt0bYqIHDSFfgzwy02KekMq0vW9IxtjaW8CiPb13YALRS0ODhKBYLG3s7YLOTWKgNy+w1cHUUUjKKlm1cMthdpHu0usyylQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ins++WRl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-480142406b3so16046235e9.1
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 04:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768738188; x=1769342988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gwp+QKiOKKp+AXua/S36PO6UojBYyN4K9i+b9F3mXRk=;
        b=ins++WRlCD6xsf0SmfmxsAA2m+21Xi+0IbzwukykSod5oveDLNTdCM/tIoqEH0o5ip
         JZjy5JygbXyY0pwNt3IKshQjb9x06CJQL4XwXt4U43AcBmk87TpQrep+UvHdroHSWM4S
         Mwumus0/Q3ouzMua6moI7g7/siFlZXpGDi+CAfSjlBk1Q5AqZpDjBzU7JtbtdFEjImLb
         zYHDwfszLHxSPQjwbq5DOqeTB+ULJuUu1Zm/WbUELk+daMTe6XjnrAITrHQbkc7UgACy
         JFocTKfIYiOSHY/ZdJMWsE2lCIB1i0wti+yHBUT0rfEFPlP4lx/BZtekt9VYbdlkuI5N
         gwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768738188; x=1769342988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwp+QKiOKKp+AXua/S36PO6UojBYyN4K9i+b9F3mXRk=;
        b=hjPvs6cJ+c5BDf9YXkg5ijZo8BsBlI0PXlr+yem+fKw9yuEa2hx7mI80l3UbZ37qvY
         eHqERp8HvndScki6A2s1e0eojJr2VWABjbIYuTGippa4JDAQZ+dV5/FeKeUctBjhovzV
         XPudl2+3y095twLrhMJx/aUViXuLpDm4QdXenf2oIAfa/CGMBgiCJSfp9vuue2yXdO8t
         dQLUM/haN0z3B69o1CflrBurRnskAUjtXGDzgFU5c4l43TXjZy281AAM+Jnw9AcvV2kI
         XdSa74Vr6k7GY+XEPfjKCXxK7pVDnrTLeDtkD3xHgZhA8c83DQI/+9utJe5Ac3GANTW/
         6Njg==
X-Gm-Message-State: AOJu0YyamJSSfn7VK/G7S3nCxZLW3Q56/iBOZYrxWOUtRpayIcpX9swF
	elmwli1Z33sQEGToilcMuP8G/NKqRwF3jX80VfOopjxgLiYukOmnjwtjVDfJT8+pXwo=
X-Gm-Gg: AY/fxX68kiC/QTRQQY1ZFRkhrj6OTHa/41aPZQkfVrKUA/6dgB1DMCqbnr2RgDZ/aZH
	UJq2IZprNF4DVPnoyVIc89ttLCXY+tCyC4VfM/it8mp7mZNTIuRBUu2I+9xGOOb5Tv306I88vd1
	+yHQiidCdzLjQVRTh0NeSbMc4l9PPE5mwC3FtGlr7M7AzIsXiEpzhA8t7dSlpVe7jCsVX+Fv1In
	lt9ljEP1ss9PNb7Z8oBYMSvOndP6r+MDCqXss1dIEhJ6xYL7MdJtNPCXXSPLdcNfg6zQ5+I7RFh
	kiUgPFqFaItMipaQqoUQnR5Q+93i1eqYFV3Rv8QDfUB/3SaOEfEdtij5unVI8uokNM/d1x+UQEt
	tofa0E0EG4XoWHHAdyD/QvPz/40y2uryE9ESudFZoqiBmIYLSpwfQD3gRLZaG6nxvWVsP+s4CbM
	tJp7/p0c+ahusH5ZrfRwGfyysT
X-Received: by 2002:a05:600c:4e50:b0:47e:e2ec:9947 with SMTP id 5b1f17b1804b1-4801e34dfdamr97759745e9.33.1768738188121;
        Sun, 18 Jan 2026 04:09:48 -0800 (PST)
Received: from Arch-Spectre.dur.ac.uk ([129.234.0.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e886829sm138661265e9.8.2026.01.18.04.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 04:09:47 -0800 (PST)
From: Yicong Hui <yiconghui@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Yicong Hui <yiconghui@gmail.com>
Subject: [PATCH net-next v2 0/3] Fix typos in network driver code comments
Date: Sun, 18 Jan 2026 12:09:58 +0000
Message-ID: <20260118121001.136806-1-yiconghui@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix various minor typos and mispellings in 3 different driver
subdirectories in drivers/net/ethernet

---
v2:
* Separate patch into patch-set of 3 separated by subdirectory
* Fix all typos in the subdirectory rather than just "Software"
* Sent to net-next rather than net

v1:https://lore.kernel.org/all/aV0tI5nFOd_yQirr@horms.kernel.org/t/#u

Yicong Hui (3):
  net/benet: Fix typos in driver code comments
  net/micrel: Fix typos in micrel driver code comments
  net/xen-netback: Fix mispelling of "Software" as "Softare"

 drivers/net/ethernet/emulex/benet/be.h         |  8 ++++----
 drivers/net/ethernet/emulex/benet/be_cmds.c    |  6 +++---
 drivers/net/ethernet/emulex/benet/be_cmds.h    |  6 +++---
 drivers/net/ethernet/emulex/benet/be_ethtool.c |  6 +++---
 drivers/net/ethernet/emulex/benet/be_hw.h      |  6 +++---
 drivers/net/ethernet/emulex/benet/be_main.c    | 16 ++++++++--------
 drivers/net/ethernet/micrel/ks8842.c           |  4 ++--
 drivers/net/ethernet/micrel/ks8851_common.c    |  2 +-
 drivers/net/ethernet/micrel/ks8851_spi.c       |  4 ++--
 drivers/net/ethernet/micrel/ksz884x.c          |  4 ++--
 drivers/net/xen-netback/hash.c                 |  2 +-
 11 files changed, 32 insertions(+), 32 deletions(-)

-- 
2.52.0


