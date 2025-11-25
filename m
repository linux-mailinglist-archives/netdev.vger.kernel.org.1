Return-Path: <netdev+bounces-241485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F17C846C9
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E2BA4E8B93
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEE02DCC05;
	Tue, 25 Nov 2025 10:19:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E437729B22F
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065996; cv=none; b=EJqDGfeKUiM7q/RWS4ZeYEaJy+jAkcrlxYEdnMyOdN8l2rsCMg/RC7ZmN3G/L8iajJuG2gTs8P88OIJ9dwudeIdojNebpIjC1K3DGy6CRJPmRJmG/fmsn3sK6mTzA7/0ZA8UNOPgHcj5xUYqY5umTlwdRz9Wm2Iqk3gfhVbQRNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065996; c=relaxed/simple;
	bh=MAklqc7o8W4o7BQ9XilDPW96ctceBdYcX5JX7qTSmaI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Bszcni3WJkiyT2PrLJg4xSvOY5g6dNb+qZ3NJSM06w2imkPLIVjqBLmzgopxSttE7wa1tUWNUVW2a0R46zj1XdF4IbdK+SET9FzVvnws76bJm5XCpXvl8L5aKVRyenIVXJNMtUrDVz8wbEl7eUw1p5ygKbN83iwcdoeRQZiNX2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c6d3676455so1555041a34.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 02:19:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764065994; x=1764670794;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g05kT9Gmx4BSPfCDDhwHBvTwhk82htkq5Gbuhokl7ss=;
        b=eP9Pc2GuJqkTg5zUIpFYy+k6OpjP7dFg4w5VgpZUsEJuTUnRQ9THWRycuZrd1lzAuX
         8ShloA5FBrnOguk52YGZKEIoO6Zy8DHQS4P8MVQkApfgtfnDwEz9N9/8A195sCDK6MIJ
         ST9qTDl42/95DZVdlX0oHbn6iWp6OnlHGPH4ASQmblLxrdW+xMvcfuI1FrS9SktoF2dJ
         JbQI07sWB2AzmnrbLuxaUvxV+nWdyRzKU8eQY9Vq4NsqFBTgw8NBYr+JAQvlPBwkbmEZ
         rr27ywDOK+jX+q8EH+cdbB+kN9XIrrbK4ltj9h0eH1x4YC8qccMjej2knnN6P+4iCDx+
         s3wA==
X-Forwarded-Encrypted: i=1; AJvYcCV7gzW4/1BVLvzxP8BhQyw0J468huVfgiJg4uwPzdOdjrRv/zEVLMCH8b4mdmrPw88v5QWM+Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVk5lBw8kmnpEhkdDkjQhGWNRBQjg0adqFZz+pk0rWpJEYtkzY
	CjMpeJUhj8mKnYxxSM0p7NfCaEI2VajScvvsV3sqdElVcjmm16ZXRcLMK0aQlQ==
X-Gm-Gg: ASbGncuekhArGx0+lhq7jG6oJyPsHUG9+ovfCn34T+IKcLbz1GZOV/2RhkBE0EASSBf
	JPzTBqudpV6Ff27Cln7RONUM6cnXdZAlTXI8WrR4Yw5E+vujX1yHbXxa9oD95sSADjRV3dZLNjW
	7tGLieZE7dfmkkKehhdz6/5A/dgJ+XY4b7YUyV1kJfMFvnpKy3SVIRHjyg2KFzwGpiojbGxE5MU
	ft42VHMNFrHYuzGsaHM9UjL0LYO04Ae2dmQzuWSccL1/SgpH/y4sj1sj2dedqx/dccioO6IU6k6
	DGCUlfkAa/6491HIuD7f/Sgqxp6i7580z7CQYUoN4n/C0nPJNxxvsT8ma5SdGp7uPnzsYJqbG4f
	+kekmkyUMkjo96Nsr/C9mmouT6bbbEHCBZXwOUbfoRo4OUqqAcWycBlrtRV960f7O76IZgFHarp
	80cT4SDgaBiRiPu/DjHnESrfk=
X-Google-Smtp-Source: AGHT+IHE4V5NTuOH8bbG/N9yxpgJpQLuSzv999Cg20Cgl2Ybtbyoy0Lt5iA2XiS4xWaVp3UAcyOR0g==
X-Received: by 2002:a05:6830:6f26:b0:7c7:2cff:64f9 with SMTP id 46e09a7af769-7c7990ae617mr4940120a34.35.1764065993715;
        Tue, 25 Nov 2025 02:19:53 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:9::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c78d30618bsm6179067a34.5.2025.11.25.02.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 02:19:53 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/8] net: intel: migrate to
 .get_rx_ring_count() ethtool callback
Date: Tue, 25 Nov 2025 02:19:43 -0800
Message-Id: <20251125-gxring_intel-v2-0-f55cd022d28b@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL+CJWkC/23NQQqDMBBG4auEf22KCSlGV72HSIk6jQNlLEkQi
 3j3guuuH3zvQKbElNGpA4k2zrwKOmUrhWkJEknzjE7B1vZujHU67oklPlkKvTWZ0LrJeTc2HpX
 CJ9GL94vrIVS00F4wVAoL57Km7/XZzNX/k5vRtfbtSMbPNjTOPWYaOchtTRHDeZ4/h8Dy4bMAA
 AA=
X-Change-ID: 20251124-gxring_intel-e1a94c484b78
To: aleksander.lobakin@intel.com, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2064; i=leitao@debian.org;
 h=from:subject:message-id; bh=MAklqc7o8W4o7BQ9XilDPW96ctceBdYcX5JX7qTSmaI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpJYLIaPqouI9ytd/UViXR2Dorx9/9aetyjxiCK
 Qp7jdOgUfeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSWCyAAKCRA1o5Of/Hh3
 bXyeD/9PiSEeVEYV1m7oMxhwLCvTl0K/ZsAcmd0PwNw2d+qzad/RAZ9lhzwLLJfgNVT5HNRdmzK
 ZyLzpV5WJR/CYQ/gzj3cHM4nCUd1mewPG0/YHfKLeG+o9yWRXcrNeYzny4CaGLNI5jRkDFq11tf
 KP5HS7+FIr6SJBuZwg40qZ+M/Xq/iD+K5G+uop45RKvQBQUbrVgZoFWzwKeq+g5Hx+0x8b7uFzl
 SOEX906Y4FyLjU41IwgkB1Ci9km8b/H1VnGnuyPJz+zLRGXgC4t+Qrf40MZwSoI4madc+7KNirx
 cBXsToz0cN/aWMB06YFbnBTWv+OAR59AIVabuvbtQ8t0zDFgp5jlL4g3ZKBm/jCLEGeLg9UWHlH
 YmJ85Rzkck+v4+Hun3zg2a+3SeskcX/JOZLFjZzL/eLWcdTAUjrinJ8s1wLSLQwAlRLIwx6knmf
 Q+ZuNhqz27RM3wbQpNV/CncccIP/sQEpVuHwgmSxhfkbC7D/LXhqbB0CjVRYtEVlXb9vrQnTRBr
 kmUDW/PIc3HSnnQpQbHaxaZrIjSJEjzTloupY9WTjyBqYl+WAB/f1eHe4thzHmRNrD0lc3dMnbd
 TpeBH+zI3loVE8HfBGfMzj1Vkr2I/hntJFPIruBp0lnk2xbImcHHIEoTjsDEmqk185rSlMkGg+A
 tJyhni01PqZGdtQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This series migrates Intel network drivers to use the new .get_rx_ring_count()
ethtool callback introduced in commit 84eaf4359c36 ("net: ethtool: add
get_rx_ring_count callback to optimize RX ring queries").

The new callback simplifies the .get_rxnfc() implementation by removing
ETHTOOL_GRXRINGS handling and moving it to a dedicated callback. This provides
a cleaner separation of concerns and aligns these drivers with the modern
ethtool API.

The series updates the following Intel drivers:
  - idpf
  - igb
  - igc
  - ixgbevf
  - fm10k

PS: These changes were compile-tested only.

---
Changes in v2:
- Fixed the kdoc for the new functions (Jakub)
- Fixed a typo in a git summary (Aleksandr Loktionov)
- Appended the SoB in all the patches
- Link to v1: https://patch.msgid.link/20251124-gxring_intel-v1-0-89be18d2a744@debian.org

---
Breno Leitao (8):
      i40e: extract GRXRINGS from .get_rxnfc
      iavf: extract GRXRINGS from .get_rxnfc
      ice: extract GRXRINGS from .get_rxnfc
      idpf: extract GRXRINGS from .get_rxnfc
      igb: extract GRXRINGS from .get_rxnfc
      igc: extract GRXRINGS from .get_rxnfc
      ixgbevf: extract GRXRINGS from .get_rxnfc
      fm10k: extract GRXRINGS from .get_rxnfc

 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 17 +++--------------
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c   | 19 +++++++++++++++----
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c   | 18 ++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_ethtool.c     | 19 +++++++++++++++----
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c   | 23 ++++++++++++++++++++---
 drivers/net/ethernet/intel/igb/igb_ethtool.c     | 12 ++++++++----
 drivers/net/ethernet/intel/igc/igc_ethtool.c     | 11 ++++++++---
 drivers/net/ethernet/intel/ixgbevf/ethtool.c     | 14 +++-----------
 8 files changed, 86 insertions(+), 47 deletions(-)
---
base-commit: e05021a829b834fecbd42b173e55382416571b2c
change-id: 20251124-gxring_intel-e1a94c484b78

Best regards,
--  
Breno Leitao <leitao@debian.org>


