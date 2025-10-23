Return-Path: <netdev+bounces-232088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC23C00B20
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69D2A501E78
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAA030DD1D;
	Thu, 23 Oct 2025 11:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTH3qzor"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E6C30AAC9
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218491; cv=none; b=FOiwkoO2T8ZWC1KMtGctiyJhva7s6WhPxjEW8pXxPCXoLR0yjTGOuiT2aIKvexqTsgKtqhMA/X44EdoaGu0xQBcuAHLTZ/RcX5J5472nr18lN3UdBBIS7XsqshgbwmCWlagasfC9Tb8GegP94Yx6eC9GzWv05AkGDglT7bGyqh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218491; c=relaxed/simple;
	bh=GRKxdnG6EAwEEwZaN9kIsS0ShqlDa1LWlfGj40dNoY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ICiIWdW9vVx0MESygobkur1oi306ltm4AM+vlQXHSlTAuvONQvH1Gj7/EgGeRMESIsXtg52TbNWSf/nQUTA1/EiVFHxty8/nGoSvZmbHD0KS6Qyjrs7XF4dqvuLoPWbC71QXvWc+oGClR9HBO/PFnz38/DlysE9u0VAc6+bSGzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTH3qzor; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-290ab379d48so6665625ad.2
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 04:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761218487; x=1761823287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vlgvmBPLgehoAq+qXl2/qSo9ZfDpQHfJlMq911IhmcY=;
        b=ZTH3qzorLlyhg44IF0SOwB0byWrHK8kkx+CksB6NauiL5t/ela9vS6vR6OK4wsstYo
         H3xVVad1c+6FYVg6ufgtgpHpIMufPOTfJ9FHSs3IG/vIu2QLfVpMBuz8RHWWDH3B6XLj
         GAQ4GrOmkc9j/CLj61mG9HyL5Lqanl8mnen3mJUMfY8uuS/BRlvxpb/fAA5XzS5A8DzQ
         Z86KK9/+pBGDcemyD5CmY8fQOqxK6xxUW0yYqgMAmpLaNPfg1mz7GC3wbW+dlEDQ/oEF
         wPMeVTkTIuQ106PxEL66EkYoMqEpqo88kcN1r9Sik0X6NMKZKaBVgAp3Q5k72mtXJ8JR
         xwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761218487; x=1761823287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlgvmBPLgehoAq+qXl2/qSo9ZfDpQHfJlMq911IhmcY=;
        b=WD4SPa/rifJ1C10rgtvQqB+9wRihfdXhE85NWt4NWBeZxO+70EYOR+tfoI7EbgNIMr
         C8hkPAWtrT1u+sxzYxUHt6cH/viOKATM6GYmkeqMLaqELf1/WPt+m/lqPWxN4SQ/SLx7
         JdVykP8Wi3XoscffagUUf8yaMuq0JaiMzPeKFhKtibYgbOuZ0WGxVRTLKUpleozuCSek
         l6ayqCIjUClkuQzb/YqGGVoG2g0LM/gn/FhT0d9LxEIydpBZSyFeL1BKfsthxsJcA1B2
         3wdYmUV1jRhqDdReMV6OfEFYf/ID8WdcfJzPowbiuUG2EJmyM0jtoUe0d31wekMaktpA
         uOnw==
X-Gm-Message-State: AOJu0YwKLIQ6489KckWffvjdp1bUe1rzk3KldS9bzK8T9mKUtW0T6V6I
	ND8/3fOXKwRW/zYgniK1Twv8lPyKuSKGSKcoCHcMkyVIiWByCpUCbUIb
X-Gm-Gg: ASbGncssNy/xX2iO3qTydzbbWqjLWs83WdYHKOYON497ko4av/dKSFRUps8xquU4Hzs
	slKHGOHAr8VEXybzkpFZGK5jXzZLTxk3B/L95nsdP5JpdA8AT6tn0Bky8PrENP8zvguUnUJ+093
	XcNv9TTUgoHGKR0QveHFIYfSynVlPEpgsyYwJqpWnqjjL6kV8fWL8VMvTh/XfVg70ikmVMId/hE
	spUx4a9irZ4MSQFT+ltucTdWcbrZ6svV1z4nEpgYZrVi3e1BPf8gM+tftvol8MdWOPFZYsfZFrV
	qdrUlzsqVpeBC+OnzW3kxWm0nXRxIPTdTSHKVClrV5UTK60bOI4hqqEyrHs5C5vjd9kOyu2d+7B
	AK/WHYMMA9m8DWMiZ644Nh/6Hhi/NvZb4TuARJ10bPA1d1c1cBvQLLxIxlA8XJCXXK/eq04YG0V
	AQ0KHemTzO1HUnGaEwVg0=
X-Google-Smtp-Source: AGHT+IFqM1qThq8uRjoxvPG6LNB2Te+R9PY3nw4Tc7SvEuUzlsBFl9YlVcL0VToRy2HrIgcsKyGcVA==
X-Received: by 2002:a17:902:d503:b0:290:91b0:def4 with SMTP id d9443c01a7336-290ca21635emr336955825ad.29.1761218487485;
        Thu, 23 Oct 2025 04:21:27 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:ef2:36b5:9454:6fa:e888])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dded613sm20226885ad.37.2025.10.23.04.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:21:26 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v3 0/2] net: ravb: Fix SoC-specific configuration
Date: Thu, 23 Oct 2025 12:21:09 +0100
Message-ID: <20251023112111.215198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This series addresses several issues in the Renesas Ethernet AVB (ravb)
driver related to SoC-specific resource configuration.

The series includes the following changes:

- Make DBAT entry count configurable per SoC
The number of descriptor base address table (DBAT) entries is not uniform
across all SoCs. Pass this information via the hardware info structure and
allocate resources accordingly.

- Allocate correct number of queues based on SoC support
Use the per-SoC configuration to determine whether a network control queue
is available, and allocate queues dynamically to match the SoC's
capability.

Note, these patches were posted previously [0] as fixes but based on the
discussion there, I've reworked them based on feedback from Jakub and
dropped the fixes tag and Cc to stable, hence sending them for net-next.

[0] https://lore.kernel.org/all/20251017151830.171062-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (2):
  net: ravb: Make DBAT entry count configurable per-SoC
  net: ravb: Allocate correct number of queues based on SoC support

 drivers/net/ethernet/renesas/ravb.h      |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c | 16 +++++++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.43.0


