Return-Path: <netdev+bounces-245865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7F4CD972D
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 14:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F555301CE45
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 13:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855E533A9D7;
	Tue, 23 Dec 2025 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+6w+dOm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BA13242C0
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766496891; cv=none; b=Q4i8tt2eaaDhra8+bknRAroXMMPGt6VqfsM6ephvOLgPXcsn4mWkcfghKSZzoYbcCeZiDgx/abiYvRHED9MT8zeEAKYTjEnW3QTV+BlLpFrdauJJbz6umIy9va0gNFIgBe8wUi6bd4XWW++PTTL4a7JJ48a0Z/cgQNXhm9Vj7uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766496891; c=relaxed/simple;
	bh=CZqk6MmYHeQUSq8mYl5U8PsglTnA4thlLjh4fvyNm/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cE1t4r0U4M7Mk3bbM9ueFPlyJ0emGa/asnpr3M/1FpL+ZDR2vf2Kjpyya/0KEcCNlx6+UdVpHXvEJeMbehVPWlidvbrO+CLW0q+4zcm1UuJ89ZaC2YMS6N6fzMaF/2AyzE9gZGFH8YYVOAfnI8pBCmY6M2votrVTkQ9Hc8RfMEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+6w+dOm; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fbc305552so4108319f8f.0
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 05:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766496888; x=1767101688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=40oiWTX60m12RVZSNEAZLu+5MlV2CfxapQqsCAtpWsk=;
        b=R+6w+dOmcK3p0Wsu5WmR5SXCBuRr0iju8j2IpLXOPlwYE35HEJME0mfGLF9LOp9rHg
         lxBk8XcrXwxqAoR77zvA2F/di9juhZd9pEyR783DQqbwjr4OFhMEpkl1LHarc9eKWkq5
         x/tSSb7GW2Xggr9qgu2VpsgajRawUoFhSj9lOpy0fDlbTiO6AND2N1URNSp93KQI+exZ
         IvFSu4RA6iug7bdpa6f6zLvL1cl42M33lcIFNqmFJttrnq2RU3DvRueeECrcgLrQ0UK9
         dK7SYTiuo/7AcjrbpVBAWUyc5d/FUJKXLLg2dXVEAqb+AyAuR5jiM3MSSSFVoITSyECf
         zJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766496888; x=1767101688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40oiWTX60m12RVZSNEAZLu+5MlV2CfxapQqsCAtpWsk=;
        b=UVz/9cHqRXaU7kjhntha1x9NXLDbjaobGBekq1YUB0YNRlQX1BAdN2Kh9p7uUiE2V6
         IYKUFuUtMWlie80WM6N3zc/0FUuAwgOPIr7tY3L8+iwV8n4r3Rwi2pAmIour7VyZ0uLA
         SlrVFDi5QkIoSnYkL2uRsPbLbKxddPEAw88L7cgdFBJcR/VHusbNhyb9CBhIMrC6lX0t
         03Rsb6ulvWUC0+LtXNK99ji+V3F+1cFV+utjCXXPPoKYrdlrDB5PNXHh8Q+/yvsgSCgy
         T+LdxvFm2xXuQ2M5GfUNJxUeL4mhAWExGXwce894G9ozB29sALnAAzrbTHIOTe7A0eYk
         9vhA==
X-Gm-Message-State: AOJu0YxjIHV3S1DBa5KSZA+KbogJH6shC6J07mkPyuh4HNmv7ZjWogOk
	9AtHDtb1vfuLOQgFePeKsFJfWMFZ7kupUfhxH73bgjM92bqUuAM7eEKR
X-Gm-Gg: AY/fxX7hHp1B4flTE5FApYhJplsiGshaflbZ4BNjzY1kk/b2SUFV4G7g7wqUqJ3rZtx
	sLFPI6RSP42BwUg60W6jfeblMPe/ehqkVyvRF3I5VJivdBIyAQG6E3J73sQ2QFv2pP9rgR5jM3c
	25sO30XCZRGmZ3eLUOkn7v6fx/GqQC0lD4Wl/kuu8ge4+yxXb3qfzcSo5PkkK2F8pSRL7KLn5Kw
	Xob283GRKGz0IP4hyXoIRJBg12WgqbNgOVaFLizKXjIere6GWB43ztv69YdqaDTyqG5fEGa6xYQ
	KpnTsbD2ds2v4bvXaskJ89WX+KXtetARS8XC8+YLiE3YcMniuLFxfdMmV8AiJ6EE3tODfr3Km7u
	9XMxeX6o8DjXyxpx0tgK3RsgcIKEYqr3C3zcc/OYLEU4pqXSiSRp3TycqZ5QiD2LGsY4i82itnh
	Cf1cWKVoEdadFebIVU8kCqIS8cwg==
X-Google-Smtp-Source: AGHT+IHpg4k7RzFhoxht4Ev45xMmOxxP/JrZaMWX7+5dTHV9/RixTIOglRJWKnokOLcwuWaQ2ahUHg==
X-Received: by 2002:adf:f403:0:b0:432:5bac:391c with SMTP id ffacd0b85a97d-4325bac39dfmr8420724f8f.52.1766496888057;
        Tue, 23 Dec 2025 05:34:48 -0800 (PST)
Received: from eichest-laptop.lan ([2a02:168:af72:0:db87:3fd:1ea8:b6eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1af2bsm27843964f8f.1.2025.12.23.05.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 05:34:47 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	eichest@gmail.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH v1 0/2] Convert the Micrel bindings to DT schema
Date: Tue, 23 Dec 2025 14:33:38 +0100
Message-ID: <20251223133446.22401-1-eichest@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the device tree bindings for the Micrel PHYs and switches to DT
schema. This version is based on the following discussion:
https://lore.kernel.org/all/20251212084657.29239-1-eichest@gmail.com/
I tried to address the comments made there.

I moved coma-mode-gpios to the micrel,gigabit.yaml binding, as it is a
property for a gigabit PHY only.

I split this series from the MAC/PHY related changes because they are
now not related anymore.

@Andrew Lunn: I kept you as maintainer, please let me know if you don't
agree on.

Stefan Eichenberger (2):
  dt-bindings: net: micrel: Convert to DT schema
  dt-bindings: net: micrel: Convert micrel-ksz90x1.txt to DT schema

 .../bindings/net/micrel,gigabit.yaml          | 176 ++++++++++++++
 .../bindings/net/micrel-ksz90x1.txt           | 228 ------------------
 .../devicetree/bindings/net/micrel.txt        |  57 -----
 .../devicetree/bindings/net/micrel.yaml       | 132 ++++++++++
 4 files changed, 308 insertions(+), 285 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/micrel,gigabit.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
 delete mode 100644 Documentation/devicetree/bindings/net/micrel.txt
 create mode 100644 Documentation/devicetree/bindings/net/micrel.yaml

-- 
2.51.0


