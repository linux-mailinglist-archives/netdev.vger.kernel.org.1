Return-Path: <netdev+bounces-213527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D58CFB25852
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 02:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893689A331C
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 00:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352022FF674;
	Thu, 14 Aug 2025 00:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8pkZMLh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C7C2FF670;
	Thu, 14 Aug 2025 00:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755131143; cv=none; b=eE6QnGpy1sgm93H4VbhjkeNx4c7UPzezku0OveLDFHmNCSGJvm4EIsEb+EXrRc1eD9xos9nwurQGjtdfb1x8LNtx5LIWSzKHC+yVyseYEnVA5pS+gISoT8Rd01l96Aujjjg1jiALx5tR2qDXZvVJ1mKUf0teuXnv3112G9l82uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755131143; c=relaxed/simple;
	bh=xXaIo7AxqKyMj8+bQXMWwWo6Bngw5W0l2zetx+mtex4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L1T7tu3zQX7GmtkU4bza0IZEVX0xDLyPbO/6Eau0c/giUbRgfkMvsL06Nl7e4+Q4kxLSlzKMak+ybPkmWb7dTNGHHq7gCqScPz3HP0Eau/njmqup3gLwl8yLqpz6AYXI4CnZ3u7I7bPekqfdcGaB/x1QjofxyGrNCZbrNhXm+mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8pkZMLh; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2eabf7a6so372306b3a.2;
        Wed, 13 Aug 2025 17:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755131141; x=1755735941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wQMR5/06QpJsbjVrOYuYgkz+PqIxopAOx9Ark4KmgWM=;
        b=O8pkZMLhnuZYJkUhmj9WLENIBlt6zJPGDsUv/ecFo0R9I4ixDilCKNoTz8jIP0yAkc
         LhedlT1McZMEtNu0DD9WEnzczfnYHCUXifUN31t79RukDUS74dqWR8tcXyOiT9a8uDOC
         q6GRMMS9DdahAJ39cA5H/ILInuEZXDjvwtL/54xCpf/BHvZi1yQEZvJW+xAWXicNWJv/
         McsWDjRB+/KZi3eDrMlHxkgWYoygZ1tOsT1TPBca9fCuwRBNyGiXfsbqqGQaX7mrY0zJ
         jDzBuP8oP75LLua5aD2NFt7X0bY/Oqt339GKcQXcHnG5FZJRVuA6WoqMFxkA+47DxRcG
         Ob0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755131141; x=1755735941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQMR5/06QpJsbjVrOYuYgkz+PqIxopAOx9Ark4KmgWM=;
        b=KHgfyPCOUccpdPoSqYNYStI0z/knQUfbJmpeBZ/R5HnDu0UbHcjQ0geA3VrClsdQFw
         29FxX3o0yGcp4W0np+C9rmdZeA2UHzLO1Q3wiwK+mcI1CHCrrlmupIogqkUOe/ldVCV2
         d/tLCh+ib3xdP0HoyyI+UXN0TjY5ut+UKFrVSpbaVmPItHdWVDkPOfNTHHz/Aq68uync
         8M88nm4SaSRGDEqFjMvStIT7H2NrojltLLuOq031cC7Vf6rlF6tPR750VJ0qiHMVClF2
         tcvMBHMYINTMkvuAdbfrjs3+gLAsOWpOKvvQLmlteadrfuIvOfTHnDdc9sBILPvQfKhM
         9azA==
X-Forwarded-Encrypted: i=1; AJvYcCW6+kDlm53VpHfKI/hXxCcDihF47LNIVboxfODIio70lJmd3A/qAsznY+MJgY4dn1rgm8OCZKjVPvyi0VY=@vger.kernel.org, AJvYcCXtO+8CVS58Ap7LhiJcpAtPJyoMqg2u6eEZhLCUdPycE+OEM5qQNyWjNPdd5INHNf6XOLWu9JQh@vger.kernel.org
X-Gm-Message-State: AOJu0Yye10lte+Ov49+qJFLgqdsQsnwCnscXSdvoS3LFpQm90xm520Rw
	ZKUiAA/ft7L9Ev1mwFlk3ZOeslHEqLQi/2xZMOcHKMdhHXUib24FMA92
X-Gm-Gg: ASbGncuM0cLqNravYThtY7a7TB2TDr2lMzXwzYCi/ENfjHe5ubE685qd/29uu1s1asa
	A93khhVnrbFzcmGhCJ68a58wfSfOgnuvPicCqw715yjmJclyZweWqgIeF80j0R3atMenXBEOai6
	JS1thuVJanUiWUCU360k2tbW+gP4N5d8z5HQrTPeOfimvDhG1wTyeoEpDDQcpDy0XlX69OYR7J2
	otjUIIqEKV3lfYeVDpI2hTrYIXbAlAL+qThWtjUbv0/RpS58P5lPzNIVmmbBdmKujjv1vAOFPl3
	fBiCY5v/fpQgjYYz7+ADcZl2SaC+PrlVPAmlmkpXjQdgWRbAdo1yQoX6hca8k01onBo3GR4A5/j
	ZUuPJAgN+Mughlpf3ZUIhZGcPKpBAWtWh7nkYWtWq6DsTb2G9Xg==
X-Google-Smtp-Source: AGHT+IFvgCKSqINpN5d58vfoBKl0mqKeDGdc0UaBw30bRNxGvgvV+os3IYYFpP4LjIz8Inf4Vfeiwg==
X-Received: by 2002:a05:6a00:13a2:b0:76b:f3da:f91f with SMTP id d2e1a72fcca58-76e2fb00ba3mr1798553b3a.16.1755131140898;
        Wed, 13 Aug 2025 17:25:40 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbce84sm33224424b3a.71.2025.08.13.17.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 17:25:40 -0700 (PDT)
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
Subject: [PATCH RESEND net-next 0/2] net: dsa: b53: mmap: Add bcm63268 GPHY power control
Date: Wed, 13 Aug 2025 17:25:26 -0700
Message-ID: <20250814002530.5866-1-kylehendrydev@gmail.com>
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


