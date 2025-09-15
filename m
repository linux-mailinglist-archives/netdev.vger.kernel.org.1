Return-Path: <netdev+bounces-222990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A35AFB57710
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D98F3A5BA1
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66F12FE07D;
	Mon, 15 Sep 2025 10:47:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0387F2FB998
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933261; cv=none; b=Aj0Yc/EbkuiR9wQmFHZoZKQoglq3xrEyH3c3wsPcrhdmaXwmcDyOOfSsCjqmpTlow0uYFUA5FqkSAo70R7FlypZ9zFruCRw4Z9BEb8NP9z/xe6vr0zKR3StayA0QcBQMy7hbWB3NyTjuZ1lCQlXeOZHa5yAOs62tK3r3H7/H8MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933261; c=relaxed/simple;
	bh=FtZR8dFldPy1RuaNntESwgcsBNyTo98zgEi4p5KB27w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M6fwsJU3hR55H5kUZ+OBM59BA9naUwGfzjK4AaLGqjNURI7RISZm2H+/aNr9kxymBiQpGLdditwnBTYtpC03IHrw/NuXvS9exJ+dy4Iq61MewkKlowcrW7nsPNLBjSwRE2Jrf1DfaYT8vWF3Q1vYJw+18nPVFV9QVaKDi8U6e+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso8120618a12.3
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933258; x=1758538058;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5i+aeXUTUwkFP24pZXIgtLwZ4MmQQUiLZKdFo7RuhVE=;
        b=E+6qujDAh/SRnDCME9GYvUt2YmUFWNJ+c6dzv7dLjtbfKc0gx1u4k0P5phxY7zBNcQ
         16y7hIGzbONuzp+yEQ9BCYK+f3XnKNK1drERJJ+Z21/sUS0at6jA97j7YjxMjdiv2GJj
         LARkHxilxN5yPECzXQOuO307oDYd7EVx+aWQFbLMKMNcZJ5UEdVdtIZ9qF6x0wryNSJP
         FMuTPQRZqdH9ogU/+nW6lYljxNulLm7ceLr9TcgpgbLb41Rf2lsYzvagfeyfJ1cipBRM
         15JxHcMgwDDtCzzvAgbtjuAquiUrLXODRMFalILQQkolKdsiinkpSq9zMuekhGLW5YxH
         JpHA==
X-Gm-Message-State: AOJu0YzSwUQc5wi4eWq9xnxICuJ57IAIrImmXuiFv3YORCss1a3/6PI1
	PXqB+SmjNfla/6Zl7UzVQFaCASd5eGUwMsH9x4EBA5c32WPSKKYqjCyl
X-Gm-Gg: ASbGncs7RKLk1IHFlwbwRx0gNdLyRJ6ZbpLUFIfQ9GbpPiLp2NEK/AUHtojIGYjqdQI
	c1+xFj7gGkuzK9w55cttXp9FkpPIpcWowZSm0wzrTLV35YQ9L+sw/PGCkun029PKgzNmyMCtf//
	wDhqSJvwIqns9ETF6HoCnXJ968EcoEj4kthFH/MF/q48x8E57NsW5Ch/qOxAdwVHQsenKgj3Cmz
	xTIRPgqDzKBDHO3/z58z+3GkkiZksv7RGJSiPAIbYOJkQVo1U3lLhB0fYwd+T8ZNjInFZykf66V
	Tfa5DgNsoeweuAnX6sPJTzDwNLk9mVOO7uYrxnDgvWfEwLVWehMgN3FUovRK6Yhn/Cgtr4YR+gZ
	1kOxATesecsBU6g==
X-Google-Smtp-Source: AGHT+IHZw351OahB9qpqYDiJ9xfQky2jTs5UL8nDOi+G7moUMafcJPtFqs78cPQMSXYcowTOaURa/w==
X-Received: by 2002:a05:6402:1ec7:b0:62c:26cd:c919 with SMTP id 4fb4d7f45d1cf-62ed82b9655mr14152868a12.22.1757933258217;
        Mon, 15 Sep 2025 03:47:38 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f38abc083sm2123233a12.50.2025.09.15.03.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:47:37 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v3 0/8] net: ethtool: add dedicated GRXRINGS
 driver callbacks
Date: Mon, 15 Sep 2025 03:47:25 -0700
Message-Id: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL3ux2gC/1XNywqDMBCF4VcJs3ZKHC+trvoepYskjjqbWBIJF
 vHdC6H0sj7839khchCO0KsdAieJsnjoVVUocLPxE6MM0CsgTY3udIPTFsRPEQ2xI2Imww4KBY/
 Ao2xZuoHnFT1vK9wLBbPEdQnPfJHKvL+17qOlEjW2VU0XGnVrmvo6sBXjT0uYMpLoJyzpGxJqr
 NzZtNpaZjv+hcdxvAD6XSfH4gAAAA==
X-Change-ID: 20250905-gxrings-a2ec22ee2aec
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 Lei Yang <leiyang@redhat.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2757; i=leitao@debian.org;
 h=from:subject:message-id; bh=FtZR8dFldPy1RuaNntESwgcsBNyTo98zgEi4p5KB27w=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBox+7HirfQaeDf5m28Ma+aXf52p+Qtm5IBGtD8z
 pKG7Y2FNT+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMfuxwAKCRA1o5Of/Hh3
 bZpTD/0THZuj7I15KmgVCbSxEZI6L3IvZudFf69KcoButC9jDJUT2rq5B2tEpzA5KmXQupu/OTV
 puF4/TxOLCIpQz1YTFWKfTGkIvLLI/W+PKj/WuTr0jZLaOyeIMQUD/MWgkfqFI4SnwOCVxwL0E9
 Oebpl+3E8VYL80bn/qbD/PLyReL570i7hr4aR8+EVQLdXTDKx8P8mgR5wf3lD3HKIIfxuOiA824
 /3n4nAJQQ0DgUp/8uzpdp2Smn1Xo9Ff+4aAnQHeM5gjE3xwWtK8976c3phPmjyOM3X2haMdzd0X
 Wyc/9GxREn4/xZxAzR6waHQaxXksfUKgyO2wyuUa37v6Cig8P62MaX1nH4up7DvuAwRSYtcKgWK
 pNm5y0tbKHNckbT6HPKwq+csPshCm+fAwmHj0SNAjoBTYVbGZxj6Cuc/WXyX0CejGbu3UGBh8nK
 Slx87562CA1Hazm9fXjEsOE331nAEY6sXdn9Lc1q0Wvb5TpF9wUusMDR8IvNt/3NS5Aqa64hjac
 NfjXrmWTZYKLJvBRvi3XPrIOCBEqK2MH3LTNw/O0XSBDKy6YE7yI5Nw7O1B/cWItxQkgnkGf5T1
 BMOroaUdXtqE32pJvw7F0kk0AO12akrEGXG8Z6O1J1xMJggBT5e4ycF7aUGb8O66a2C8y8mDuUZ
 y+tWuPLSlIV0fzA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patchset introduces a new dedicated ethtool_ops callback,
.get_rx_ring_count, which enables drivers to provide the number of RX
rings directly, improving efficiency and clarity in RX ring queries and
RSS configuration.

Number of drivers implements .get_rxnfc callback just to report the ring
count, so, having a proper callback makes sense and simplify .get_rxnfc
(in some cases remove it completely).

This has been suggested by Jakub, and follow the same idea as RXFH
driver callbacks [1].

This also port virtio_net to this new callback. Once there is consensus
on this approach, I can start moving the drivers to this new callback.

Link: https://lore.kernel.org/all/20250611145949.2674086-1-kuba@kernel.org/ [1]

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Tested-by: Lei Yang <leiyang@redhat.com>
---
Changes in v3:
- Make ethtool_get_rx_ring_count() non static and use it in rss_set_prep_indir()
- Check return function of ethtool_get_rx_ring_count() in
  ethtool_get_rx_ring_count() (Jakub)
- Link to v2: https://lore.kernel.org/r/20250912-gxrings-v2-0-3c7a60bbeebf@debian.org

Changes in v2:
- rename get_num_rxrings() to ethtool_get_rx_ring_count() (Jakub)
- initialize struct ethtool_rxnfc() (Jakub)
- Link to v1: https://lore.kernel.org/r/20250909-gxrings-v1-0-634282f06a54@debian.org
---
Changes v1 from RFC:
- Renaming and changing the return type of .get_rxrings() callback (Jakub)
- Add the docstring format for the new callback (Simon)
- Remove the unecessary WARN_ONCE() (Jakub)
- Link to RFC: https://lore.kernel.org/r/20250905-gxrings-v1-0-984fc471f28f@debian.org

---
Breno Leitao (8):
      net: ethtool: pass the num of RX rings directly to ethtool_copy_validate_indir
      net: ethtool: add support for ETHTOOL_GRXRINGS ioctl
      net: ethtool: remove the duplicated handling from ethtool_get_rxrings
      net: ethtool: add get_rx_ring_count callback to optimize RX ring queries
      net: ethtool: update set_rxfh to use ethtool_get_rx_ring_count helper
      net: ethtool: update set_rxfh_indir to use ethtool_get_rx_ring_count helper
      net: ethtool: use the new helper in rss_set_prep_indir()
      net: virtio_net: add get_rxrings ethtool callback for RX ring queries

 drivers/net/virtio_net.c | 15 ++-------
 include/linux/ethtool.h  |  2 ++
 net/ethtool/common.h     |  2 ++
 net/ethtool/ioctl.c      | 88 ++++++++++++++++++++++++++++++++++++++----------
 net/ethtool/rss.c        | 15 ++++-----
 5 files changed, 84 insertions(+), 38 deletions(-)
---
base-commit: 5b5ba63a54cc7cb050fa734dbf495ffd63f9cbf7
change-id: 20250905-gxrings-a2ec22ee2aec

Best regards,
--  
Breno Leitao <leitao@debian.org>


