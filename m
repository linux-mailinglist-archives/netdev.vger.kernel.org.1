Return-Path: <netdev+bounces-140881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ACD9B88BC
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3C81C20D5A
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A263A75809;
	Fri,  1 Nov 2024 01:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCEq/Hwt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1FA12B73;
	Fri,  1 Nov 2024 01:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730425444; cv=none; b=RSBw6ByZ9zT5SyvLWosNbMRPtd3eZcdTfSTuERjfkZTZPaPyuTbTxf30uKjYcvDu6PrHiOICsovPKBDbpD8K5BDxNFMY63MdUgb3u9TKTsxSJb2VPMz42m12l6L9RGL8JrywxYUWTjtKNojFIzmDtwHkfs2OScZcobMEQOWf/o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730425444; c=relaxed/simple;
	bh=W6gXAaoCm199UUG0nqy2s1n22CXojiOKE5NETmpuAtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oq3dhFd84zGvpE55ri/HbYDPXXIvINHetYZEbiKZ3KxXL5/yKDtyaGMXmXnLYhJgv4zAGGiDvKjo558OctuAyyg/9NpBxBCMtJ1tX5XtJAtJVUCNtAPlBWtU9n5nNSF1y00qDlw/jWM8DRVEZoL5jEHPAydG9IBtlA4htuMQf7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCEq/Hwt; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ebc52deca0so794560eaf.3;
        Thu, 31 Oct 2024 18:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730425438; x=1731030238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CbOKOQ6cXn7wwdr6Ntm3B7T5w6pad7a2v3ZbayC5AN8=;
        b=aCEq/HwtArcF1ehP+eqeHE6a0FoQBa6H5HPRpL/VHtVweom2gxOfEBnus2mwWrzsNy
         dLxF/tELEpjOJzT9DmtgeDggs8to43paLTN/ivg5mLmZR4F1tHVgAoxsJhsQIavxmUtB
         kwhoNPL3xh0zcsPy18wUYarNOQjn+R07PNi3aAIrpSoYNsa3i+Ojv7OCAu+cyJ6/MPIt
         oWRLvOievouHUZ2RN5dolc5YsYpWAAGoxzBLNdOkRl5t0EApmiUgndiHJmYcqf4KoPZD
         ElRjkiyMFMfnO1a+JP2f9H0pAp2J1HY4TmF3frvTtHayIGsuI4gx/hEXiupIBqLbVpCE
         noFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730425438; x=1731030238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbOKOQ6cXn7wwdr6Ntm3B7T5w6pad7a2v3ZbayC5AN8=;
        b=MkEoGP45Uq9Z5MvXSjHyRSsvHxEHWxxFRuKXnzUMUT2kPwTvNDOs/SjlHME+Oc44sX
         ZqKjn205wGp9NFFAChXYm2qm0NK6nhzdAqMFm8G30mJEmSernAW+eSjw3bOb4pHG1PiH
         Ghi0bJB65pQiKBVEjy/LNIJcS2BR7u0e7YbH8WlzNp6Unly3d14kwrUiQrVZJdHh5Qdk
         ZFeSRYBkGz3/+dx+FWqIz+/K3XandU2P/1vss8fWz5WEEYTCHayjqf+Yrf+myVOXD/VQ
         NffnRSiTcdrj2EAuDkGrh0/o7f8PefFR9ah0b2XxPlo1frL85IGFXATDpyjaDLkskm/m
         OtUw==
X-Forwarded-Encrypted: i=1; AJvYcCUO2sHM/PQDh96tlS0syGXB9V1chpqYimdWqzgsAQH5wJQzd6PZf4LAn8YBp2u+b3Lcd6bADQG3@vger.kernel.org, AJvYcCVC0v/P8tQtugAdIkwtXP3ziwHrQMYXL47cnI/+oICB1bwffAVOSI40IGZtgLTRdlt9sj+AXemtwUhT@vger.kernel.org, AJvYcCVvez3Rpu0BEVupSpWlsB8pfXhzCZp7JZq8s/jvw3/VcvR2GVByEADOx+k1Xdumx2+40vV/R2CBogQ3O0Po@vger.kernel.org
X-Gm-Message-State: AOJu0YzEYAM1db/WF9kuixmV7x8f481RXBkpjar46Ejmg7lM+/SzhQm8
	BxzBntoNAxMzxcHlW46kI3FwPlGYaEoG42ftjA/caswlhzt3ZPfO
X-Google-Smtp-Source: AGHT+IG2sb4YVVz0VFvLk0SRUEvu5cS8s5UH9lKMcZltZ6rlJph6ABKzjSAYEOkurbMSWKYOqwCwCw==
X-Received: by 2002:a05:6870:c8d:b0:288:6ce7:6d6b with SMTP id 586e51a60fabf-2949ed34d30mr1772814fac.5.1730425437875;
        Thu, 31 Oct 2024 18:43:57 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ed422sm1773674b3a.77.2024.10.31.18.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 18:43:57 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH RFC net-next 0/3] riscv: sophgo: Add ethernet support for SG2044
Date: Fri,  1 Nov 2024 09:43:24 +0800
Message-ID: <20241101014327.513732-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ethernet controller of SG2044 is Synopsys DesignWare IP with
custom clock. Add glue layer for it.

Since v2, these patch depends on that following patch that provides
helper function to compute rgmii clock, and this patch are marked as RFC:
https://lore.kernel.org/netdev/20241028-upstream_s32cc_gmac-v4-4-03618f10e3e2@oss.nxp.com/

Changed from v2:
- https://lore.kernel.org/netdev/20241025011000.244350-1-inochiama@gmail.com/
1. patch 1: merge the first and the second bindings patch to show the all
            compatible change.
2. patch 2: use of_device_compatible_match helper function to perform check.
2. patch 3: remove unused include and sort the left.
3. patch 3: fix wrong variable usage in sophgo_dwmac_fix_mac_speed
4. patch 3: drop unused variable in the patch.

Changed from v1:
- https://lore.kernel.org/netdev/20241021103617.653386-1-inochiama@gmail.com/
1. patch 2: remove sophgo,syscon as this mac delay is resolved.
2. patch 2: apply all the properties unconditionally.
3. patch 4: remove sophgo,syscon code as this mac delay is resolved.
4. patch 4: use the helper function to compute rgmii clock.
5. patch 4: use remove instead of remove_new for the platform driver.


Inochi Amaoto (3):
  dt-bindings: net: Add support for Sophgo SG2044 dwmac
  net: stmmac: platform: Add snps,dwmac-5.30a IP compatible string
  net: stmmac: Add glue layer for Sophgo SG2044 SoC

 .../devicetree/bindings/net/snps,dwmac.yaml   |   4 +
 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 124 ++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 105 +++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  17 ++-
 6 files changed, 257 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c

--
2.47.0


