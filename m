Return-Path: <netdev+bounces-241263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C26C820FB
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B663C3A714B
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5985E3176E4;
	Mon, 24 Nov 2025 18:19:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829742BEC3A
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008353; cv=none; b=kVx6oJeAZiVpna6ZS4S+lEXXeO33I1sSfwuQ+zOaF0Cef5NGEYt5uWCVnNgkmBG8o5XoQl3zZ+f3zaj6NDxBjb/eYgAx39qiMqg7D/kb9808psxPFnvalXzYCuaw0zpTmsy9Oe6HYM7JFiDJkhwyxrywRmDMlqkUwgKASaug3Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008353; c=relaxed/simple;
	bh=DQb/k2j72kq3h6DefjrDlkyB8NhxV1RHIqAAE20HbAw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YyXhMvCcV7APJ7bS8o6V+KfM6iDUseF9HQkRko6Ys/pq7IbGontatqPC7PT+zJjVYxnwQEgIR81yzEvNn4kQGWOmVD/lXKu9QBdrVdk1rWGGh2plulFeaezoNG+OvtqQP4PhvqwQRC6XMMXZ1nAcM4x4jH3kC6B1WN3D+qU1My8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-656d9230cf2so2177762eaf.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 10:19:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764008350; x=1764613150;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrBYJv3jpcXtBLif6gwGlufqp80XQnYmUSZ0wjLcnKs=;
        b=VI/1urFiH7JMu/5YYBQ5BKi10KW6+rBBbyestP9e2bBTlMHaTulcE3qzbWhxX8iNbA
         l9JsU2pEoembWzjTf6Db95qhFj091M43IzXlp+wCil68p9q9MTGsF5J7TxdumPFBSTg8
         p5Nm4pilAR4nxowhokNCcRcI0sd5WB1+S83hdmGzG0Lome5w/BJTyYembZf1+V/1IfE7
         FxPxX6uMVse5YEWw5fKGZofftc3k/iAmSqMOV1P/cio8GEE06Bq7vr1blVmNs9qHmY6M
         DS7vW8AJk/VQa7bJHCKJudH1KLUnu9YmwnAcEKfYx3yzBoBCZmkIADdKIIkt+KbeTAir
         A2Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUgQNrCShDWdHxJDj0oLTNQ7sfIYiCPWVp0bPxY3tOcImtcBxMvleb2hUs3SdWI55y5nH9EqqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwXSi9EsapqCO6aaI6k93mu1puJXQPPBsmUdX+im4hv/YJ9TL/
	kurruLYJ2NZTGt0MZFjCZaoewN8HTV1M0a+7ODLMVckP0MZ8a9NKDR7K
X-Gm-Gg: ASbGncspdeUsuayLl2G0Z9ELHCmyt0jEHtR/t/eVw5zIzUHTPVID5q2exsfLOyUG43B
	jc13NnLE66WLl0tcJfuU1mxwa2zvxB3UhqhmoJtdSlLRkqfwxZSNMLvUAkbCxlxkV30qGO/gL/0
	W9NJi9mrlBsIkWgA8uy/4hOYdnxBeIq38edL+5S8Emdfc8G1YxyPsuFeyt1OMQK9ThvKVct8GXj
	C27CPN4nJsc0sXsmA0VxyoIs+5DuST95fM7FrBYRGkVlgvLneIT7gNesuIEKZCq0mOpIr/3qeYh
	iGpT7UCjVJ7PCpvQlFxH/fvZqiTjDH2QZ6+Gm2F054f2dOjF9+Pd9NADHYnqhKULV8EKdIVuOZX
	Z6ju3DI+DiFkqUZbyQ+t8UYVM8yrgYqsYa+0eR1S/hJa/5PxUCPCBNtUiGiCsHT+vbRcXJcBzr7
	uHCCXHq/KrubpL12fuetxUw5Q=
X-Google-Smtp-Source: AGHT+IHN2guu0lOJRAchvtzZtXVImuKk1r8c5bUrPHuOn465etORV5ArmjggyAzYO0W8Q8OTyoelgg==
X-Received: by 2002:a05:6820:c307:20b0:638:3df8:c802 with SMTP id 006d021491bc7-6579253dda5mr3493925eaf.5.1764008350405;
        Mon, 24 Nov 2025 10:19:10 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:3::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65782a38448sm3744154eaf.1.2025.11.24.10.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 10:19:09 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/8] net: intel: migrate to .get_rx_ring_count()
 ethtool callback
Date: Mon, 24 Nov 2025 10:19:04 -0800
Message-Id: <20251124-gxring_intel-v1-0-89be18d2a744@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJihJGkC/x3MUQrCMBAFwKss77sBE1KsuYqI1PqMC7JKEkqg9
 O5C5wCzobIoK5JsKFy16teQxA+C5T1bptMnkiCcwuh9iC73opbvao0fRz9f4hKn+DhPGAS/wpf
 2o7vC2JyxN9z2/Q9J/rrXaAAAAA==
X-Change-ID: 20251124-gxring_intel-e1a94c484b78
To: aleksander.lobakin@intel.com, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: michal.swiatkowski@linux.intel.com, michal.kubiak@intel.com, 
 maciej.fijalkowski@intel.com, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1808; i=leitao@debian.org;
 h=from:subject:message-id; bh=DQb/k2j72kq3h6DefjrDlkyB8NhxV1RHIqAAE20HbAw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpJKGcss5h66lWxzY/HzxdBVjCPRVyagLYFOqiR
 zR9KyrwA3mJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSShnAAKCRA1o5Of/Hh3
 bdWgD/9JmS+66OvWT6Zd4MHRTn9lgAAgOOgDJrBSJIvkn4dOS+Y2rm5z34h2DG2HxQTxnOWYSn6
 YKQn1uYrJ33e+cLLtvpSp1nq3IZ4KpcZziV6zXSb2sBHP/PuOlxcS/YvZ9V7W0mAhOl61RXXhGT
 tP5nkaQ7Z+3JKZAp/7HqSj+heRsuGRCdOOzRhvpy1vNUFTg+F+uk+6dFxB1fEnmoDnD44jVp68z
 TSGjqW9rbCK7mGFkox6mvc6Shl/0Sy5ldCRqt3CfrheqgmLRsUDfnG+tpgKYG53XHC07qQl1upS
 CSwOU5b5Lpb+WQTBqxq7jf/uWbg5JjYEUmp+dFb72AUEy+iVKeqipFe8xWIYxFnEFzzB+xRyRqt
 BBiLSjnDQOOI34oux2c0hF/tVKyWrZcfgxfRHV+e6n8UsRvwinmheXMtFiLebogsCx7ybxtSO40
 7994JL+AVGMKnajwBFpXIjr08mRyJE5UeR09PzuK7iYQatmKlJsBgywpiEkR02KfG9C3FOuAq6L
 r7zStRwaKJYTx2WzxlDRxJjI9Hgt1flz5xis6dgCEjc/19weGOmq4aTF7dwkPMGiMkk2dFe16zw
 Z5OCO0tZ3nYjPGumTYv73ap1wEIj0vWYTMF3If4HJ1MTm4ZRTCWp5XEIy7oPHBS6VcWjWXkQWvu
 VtY9n2v0FfY9vkw==
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


