Return-Path: <netdev+bounces-210918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 597B2B1575F
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 04:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75EC18A71B8
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 02:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E4615853B;
	Wed, 30 Jul 2025 02:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwyJuPUs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587CB2E36E0;
	Wed, 30 Jul 2025 02:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753841035; cv=none; b=GpMF2u/Oae6kv+NJD5EYcVJfpkjzieefx9zhRqbYbiIittD80JnIlqPzreuxJVbB20vHQ1Qb7gUQcQn0nZD99aQTxqdRRCOu/WjjQA27R6SJQjzVNa735P3LHH6EK+09Iobaj1xXw6EJvazFcFtaTIX6DaAyBfBP6R5omP4+QCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753841035; c=relaxed/simple;
	bh=xXaIo7AxqKyMj8+bQXMWwWo6Bngw5W0l2zetx+mtex4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H8D/4U7AbBWbUJ88fYB7xyVJm+2ug9N0JhMDKWlvrNHMB0Ix0FfBNDgcujpiOCgpAQ2CqJJaPD43q+72P/PoTN0+ExODpnB4jbplCIrDQn1VTcuIFTVhJ5VcobGSrKVBhE8S8RfkryrrxechCx9ie8E8nMVP2XFCPMTZuu8dE58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwyJuPUs; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23ffa7b3b30so34075695ad.1;
        Tue, 29 Jul 2025 19:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753841034; x=1754445834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wQMR5/06QpJsbjVrOYuYgkz+PqIxopAOx9Ark4KmgWM=;
        b=gwyJuPUsgCV6mOT6B7/7qcsZY/K5osfaqCTb+VTcLOPPVyyDyLq8TWfzs536EJijjp
         mSkDbM/7K3GiQUTw71/k6QzTlVlfPvmTKbbyd8axzoW4CuCAOxFYbRhTTPLdd+ajDc5I
         mD1Vm33i9wgoak2YK/v/2U6xJdU4zN5XKVvpchwxps38jMZ5AVfN4EMRy8s4AK3L6zKm
         2tuxbmAryV0zeqV5av++bQnXCUgCvjNepwGssQMlir6sr8+kLRk3Z8ZVAHwOSsS3RIQK
         O516sE4nvrRb5+GOIjOQbAu0NlK1UBsNICB5iTMViIp2DbNaqHUoa+0HkRpwC41jaLoQ
         nwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753841034; x=1754445834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQMR5/06QpJsbjVrOYuYgkz+PqIxopAOx9Ark4KmgWM=;
        b=IP+yF/aHNOFtWnGsnSqEvqO4vPn0DZ37B85ZGCE3Cv/upYO2gxRWXr+lhUWbdDUpWs
         fXxQE9reoi0poWNgWdaF8GeKD4t2IUkk6DXMedAsJHufINuCsv36Gg0Kn1tn81XPB3wN
         DT/1VESxyFc7EyeTuRs3QgsmnmBNwvQLdMceC6V2J16IKuklJRZP/p3CQMTFiUlRxH8R
         uf2KUpnA8r5Qi7HE81eOXWqLxMGpAqZKXnvcziEmQ4EUOA6DFohwN04+Z4A+ILUjXhzZ
         djxVlO46PjZQZmFa+SAnztrMtUplGUYPNOo1mnP4Wua+7o8+9MIIX+h8PWYT97MHu/XH
         eVcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHiJODhn5zmYTbBDK7KqoIq/p/9uNhgenHBHQYOLaarxDmfqs58gtMdpnFX2EaUIlw3ng/IMtvtYaXS4M=@vger.kernel.org, AJvYcCWa64A4StAm0sul3ba8cUrk4u2v8wE/tO30Pwj/3aXeEtoj3kVg+R4kWuagTM0JM2quG5OGpAWu@vger.kernel.org
X-Gm-Message-State: AOJu0YxwbRVU0N6/t+8+9GiW+WqedVptamfU9gm8x5WylVvmlS/1KvyP
	SlD+Nq/uhBuRrMmTX+jPJNoU83cA+VD+nTAmbHTHhJwhT/kATLXbGTU0
X-Gm-Gg: ASbGncvebC9BDRMiEKQqre0mwaNULwNKYJFz+fJ8UP8+Q9MyfUBe4kfukg8blkw6pKA
	BgOTkSayAH9n77PAIxb96041p2HSDPtpz2qI6w3uvtV6rLv/0iO/vMrZHqREEclfczJF+DFMwig
	Dmafr/w53rUXiU+s4uT6xaMJAN6EWB2DyINTkP5BVhXIIv5i/OxiVR0rT11kL7sle9+4Rq1nWPu
	IgFmRjfOTzGflPoSJqd2CAIgPri5UkkqyaLT4SaFpRPm0/wbeUCMYbJSJsi4quCe2QL+DG7Ui/L
	Ee/Wcam+NqrMBfVZW8Cy6XeQW+1CEmE6dTmlMmhHXegVX4Jrvf+FSvzzdQOIKyYC0UVdafOGl+K
	SZlmuPs8OfvKHEhmBpISWtQp3Sz8WRkfVGZyM2wQN
X-Google-Smtp-Source: AGHT+IFd1qYOnAKt5uSZC0A7/VYniEyztNYcrTCYpdi6eTZWPOegcNnrpele9y2FdxS4XMOL33NnJw==
X-Received: by 2002:a17:903:240c:b0:240:3ef:e17d with SMTP id d9443c01a7336-24096b3551bmr19479975ad.40.1753841033546;
        Tue, 29 Jul 2025 19:03:53 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ff71916f0sm70349845ad.147.2025.07.29.19.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 19:03:53 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: noltari@gmail.com,
	jonas.gorski@gmail.com,
	Kyle Hendry <kylehendrydev@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: dsa: b53: mmap: Add bcm63268 GPHY power control
Date: Tue, 29 Jul 2025 19:03:34 -0700
Message-ID: <20250730020338.15569-1-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gpio controller on the bcm63268 has a register for 
controlling the gigabit phy power. These patches disable
low power mode when enabling the gphy port.

This is based on an earlier patch series here:
https://lore.kernel.org/netdev/20250306053105.41677-1-kylehendrydev@gmail.com/

I have created a new series since many of the changes
were included in the ephy control patches:
https://lore.kernel.org/netdev/20250724035300.20497-1-kylehendrydev@gmail.com/

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>

Kyle Hendry (2):
  net: dsa: b53: mmap: Add gphy port to phy info for bcm63268
  net: dsa: b53: mmap: Implement bcm63268 gphy power control

 drivers/net/dsa/b53/b53_mmap.c | 35 ++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

-- 
2.43.0


