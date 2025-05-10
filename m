Return-Path: <netdev+bounces-189473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3595EAB23FD
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 15:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADEE83BB49D
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 13:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A7E1F12FC;
	Sat, 10 May 2025 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKeqKHMZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4134B18E02A
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746884903; cv=none; b=uVI8BuG+MdbAgB/fr479Ztp3Uk9eMvUoN+0kxS18sPWXj4lwZQEvDgpbbjkJGqj5v7n8gqUWdQZloCUmQDZbXP1Wsd2vNGEivK2UfZ6JDIDbDjbZpOxQkhjy2wFniV/selNRx6Z/UI52nAfWl9yG4ALdZFw0Xsl364SozHhVYxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746884903; c=relaxed/simple;
	bh=f5wX8wBuQfgI9sHKaBcJXmL8nSXfNVcECDtfBMfe9hs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k/5F4JnmRfs3+ONkW4ciBzp3gIhIp52BfQDRwASOFufJBrndcBr7Db+Oj2fgtluIMIK9XqhUYq/5tacYfR9VcByyNm36COlS/vcS6/ms993MKsZpuK99BTjJknIQ4VcMVCqjktyiRT1sjjjnR431cnaaZ8eE6hZcG0s6YDGRPTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKeqKHMZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so3154265b3a.1
        for <netdev@vger.kernel.org>; Sat, 10 May 2025 06:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746884901; x=1747489701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XjT9QsFvecWPH6K1hTzMR7uGrHCdBy3p8DiOT7+COxQ=;
        b=kKeqKHMZXK4ehtslJU63wHVVteStA88qBPayC9h5xst+1SwfSArL+1cgGW+vZ1rnmL
         /A5yA4rXaISic9cLpXKISZrJNp0E0BK96S9KcYWm/Zmf8eSFKsL3C2kCrDama0StCJVv
         PrSZfTb2QU8f1zXTMYMmOgGVAXaKO6agJ/CAjEoWC+NoizecYGqJ6jmXG/J1zjUXjZcG
         U2UIi1RxiUXEfXGyl33BPpSyP1ok5CB4foE1Ho+SIg08jHZt7klE0yHuTNJ5f3899d4o
         z2dlk8qVnkg0I5SUudtO5ILL5cC+0ID2fjQeuUjaxxNtpZdo3ygbXHj0IqEhtKVwaxLe
         pTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746884901; x=1747489701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XjT9QsFvecWPH6K1hTzMR7uGrHCdBy3p8DiOT7+COxQ=;
        b=fOLrxZvpP/Zqzy7KEPQFFMshqpYTBymxRGWrE2QluYsBWlfGQfJUmOvOq+kC9uUG29
         6DHRmR3AswRhJqUWpn2a3gpoLfEN7My7b2/sIcMjF9bhAzbePEW+ebgSnxYzJfmr0RC+
         mLnn7Nbm2UhAWR+zuuRwOMuU8ZPLAfx4+1bIZdFXLYSbuup3K7klBaiY0cb0axfM0pGi
         VA/TtNUsMfeEMCHWym31jUX9qZ1MuiaZEiwIbIVa8/0Gqt2q2+8RSX8KGAAJwQA6LU/1
         RXRysaek40BSP1pYmDoB74/JZjRuvxLRd/9A9Tr6ZBXP308vlmCmRwSNvxbs6l6tv+Wd
         Cl9w==
X-Forwarded-Encrypted: i=1; AJvYcCX12NXFBIv2BM6cMZtYsN80iR7DnpGavhYoHrjBh016FPW7Xt6IicGrOf4K6wokbMY1Q0+3ISU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy91A8yWinG45OrOVYPlv+ULxCV4T3GdYxme+k2cng4hlLgLIRM
	asLzGYdH7uKIyYchoRzzTuqoXZ44LIyW6sRG02UnGBlhlOoMSg2H
X-Gm-Gg: ASbGnctyB4ohUWPf5fonUVw4AyzOshmR7fQnYMkfKc28NJI8SjIPkIkQxMGQF1GFyI6
	hESoq5qEUVY3ETUW8kCGK0XZx+URFfv31xvoYTFxFL4/nhzOpxfcqagDc8LS0eUmSA9kDqcj1CL
	fgje1Uz5OgaTLjCv90eMIZcSN4hfFlWGxrJ8kAhtaZJsaBxmGcweT3bNb95HecDYBcfF4fYYs4s
	6mmS64gQIHLwI206Ak62mgJP/pv4gtl+6JEZl26n0C4iMt58C9fV9G8g9gJa2sLnwWOEj76IXK5
	3fNAP/VbwI21NtBjPWHwsGN6CooZo7hPLAYnT3J8tvN4rL/M28fslLlpVwxLxenKvxqejk1q0LK
	DJNLut3Cxx0C1Eg==
X-Google-Smtp-Source: AGHT+IEc5T1ipEW5XJX6iIwkxNHd2PzUnYMkA+7BJtGOAqm+kaFIn6p3BLGSLH7znczlRZNQEbyR3A==
X-Received: by 2002:a05:6a00:2d0b:b0:737:6d4b:f5f8 with SMTP id d2e1a72fcca58-7423c01f8a3mr9192135b3a.17.1746884901458;
        Sat, 10 May 2025 06:48:21 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7423773939fsm3360424b3a.62.2025.05.10.06.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 06:48:21 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	irusskikh@marvell.com,
	bharat@chelsio.com,
	ayush.sawal@chelsio.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 0/3] misc drivers' sw timestamp changes
Date: Sat, 10 May 2025 21:48:09 +0800
Message-Id: <20250510134812.48199-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This series modified three outstanding drivers among more than 100 drivers
because the software timestamp generation is too early. The idea of this
series is derived from the brief talk[1] with Willem. In conclusion, this
series makes the generation of software timestamp near/before kicking the
doorbell for drivers.

[1]: https://lore.kernel.org/all/681b9d2210879_1f6aad294bc@willemb.c.googlers.com.notmuch/

V2
Link: https://lore.kernel.org/all/20250508033328.12507-1-kerneljasonxing@gmail.com/
1. remove lan966x patch since it breaks PHY timestamping.
2. move skb_tx_timestamp() earlier than before in cxgb4_eth_xmit() to
avoid skb being orphaned/consumed.
3. revise the commit log.


Jason Xing (3):
  net: atlantic: generate software timestamp just before the doorbell
  net: cxgb4: generate software timestamp just before the doorbell
  net: stmmac: generate software timestamp just before the doorbell

 drivers/net/ethernet/aquantia/atlantic/aq_main.c           | 1 -
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c            | 2 ++
 drivers/net/ethernet/chelsio/cxgb4/sge.c                   | 5 +++--
 .../net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c          | 7 ++-----
 5 files changed, 8 insertions(+), 9 deletions(-)

-- 
2.43.5


