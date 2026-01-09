Return-Path: <netdev+bounces-248564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B9CD0BB91
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 18:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F2C23011455
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 17:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268E936657D;
	Fri,  9 Jan 2026 17:42:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA65E246BC5
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767980534; cv=none; b=G2YdvDjxLaSLRIcDJn69kL7Bz6JVlVgRy+YOc8iQlH2il5ef8SF1zXAjOcaLSJPZA7kfC+mAeM5aMSh+pCaBiPVH7/mvg+dWetssVz2TM+FrGp7dHpXXpypnIxde34Sboj/otXaBISCUDrynmNCLNCwtLr+2Vsa/KYsB7pyCbRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767980534; c=relaxed/simple;
	bh=iS/52xHmm00yvA4f+3LhpkCCrsPwwsLXrVVp0nSmqpA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MyjnlR+qA1S+ySrWg9zSuSUm9JHVybIvCrd6RdYCkcn5QdHABVZPrfNFLnD9U+9UD4XLEveedpqi2BkRYpcvrsPOBMCvgQIHwGDWHg0O7foGf5fyq5SKAAZ3nXM33oXkdE0Q5gXCYvksLvZAaIBIn6iS2HzBS9yfJG3bRat0t8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7ce508ae418so2034915a34.0
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 09:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767980530; x=1768585330;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIk/zcTt1v1RxeM200f6XCEkXUaz+o3JMFGX/86Qckw=;
        b=APvV+x0/aNG/tXUIpY6QP2CTWPsVjRFOri3J22xVAaylbVvOCglEs+TnshYuMtr0AY
         DJxGBR4rIA8oz5pX9QuqUsBsmOHJEaBC3rtk08xfwYfxZDYjw41u0H6b1y/VAvd3dYa5
         NNzTkb9zXKluZn8Pkda7kwpTwFEkcZGDsTLbd82WRO6CsTKgociEQH51NxUuHY413Q7/
         xvO/HQ8IKwnsAorh7pqpFtUT5L0Kkdvd+HvvquCPqwQARqFvameAy7b+UuG54MYbUDkZ
         ojcI3xbenD2y0aXG6yhxNGVYn+YAx87dYlEdLAcgSkfnCW+vMdBfWySDtI0SiVmarR2M
         WlLA==
X-Gm-Message-State: AOJu0Yw+588VMmkVqvUVD7DVs6nutPs0CIpYdnH2mSPohRLPpwu2XIUM
	rFHVgcHvPgA6lv0OXngUZx+LWhHSeSc54yX9yQH88quRWiAxTfkfxlomqJVW2w==
X-Gm-Gg: AY/fxX6J0MUkQr9QsLy1R4+XKv+GvdC1i9GkYG4iDDYmRuZt3R11TDHiSKq/EUNIUTv
	sl8Il+TDdMlaKqjX7f6RMgCZZ6H5H3VUsuDq5ebBzwRoAGCgbEQBDA5t/3aQKYeLBqDl2nr5B84
	C+VVoGWhFPRGpC8TAomgG9rWihfL2gmLclOBd9xfGPBS9qAcJOsSmesYQU7laxmoJdu5gNvsaF6
	iVM3S6qesVqSu6MIRbYYYlR1FpC7fJB/LOB9T7xrAzl452mb7497p6SF9hRiAqbMyy1uyfEl+FJ
	OqnSehioTgkapPojnQX8MZ0Dg6Kgwe9m9VCm03aooqB8eWtXJtZ0K4yilimO7zscE2inNPHYoDD
	nQaLI6HNsWBShrIOQ+LiYD/JRNttJsQpcRmpdRBnbCV3Jq72jDXZgPqaLjaW8i8iePH6Wkxpzlj
	5d9w==
X-Google-Smtp-Source: AGHT+IEKCJHwa+HaPVVS9NS0renPKMozV5am67tRA/nlQ95KMjo12CkdVwAzEZkDyZnG3zL+MRotVg==
X-Received: by 2002:a05:6830:4c0b:b0:7bf:6c53:b558 with SMTP id 46e09a7af769-7ce508a9b53mr6979824a34.5.1767980530587;
        Fri, 09 Jan 2026 09:42:10 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:57::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478ede38sm7613741a34.26.2026.01.09.09.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 09:42:10 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/8] net: convert drivers to .get_rx_ring_count()
Date: Fri, 09 Jan 2026 09:40:51 -0800
Message-Id: <20260109-grxring_big_v1-v1-0-a0f77f732006@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKQ9YWkC/02NwQ7CIBAFf4XsuSTQlFr4FdM0BRdcD6hAmyZN/
 92oxHh+82Z2yJgIMxi2Q8KVMt0jGCYbBu46x4CcLmAYtKLthRSah7QlimGyFKZV8k5Z5Wd/6gd
 soWHwSOhp+wjPELHwiFuB8bvkxd7QlbevsgmfC2Uq9fBLGlaDw3+Qa2W1Es5r31mzShiP4wUwl
 gcCwgAAAA==
X-Change-ID: 20260109-grxring_big_v1-45b5faf768e2
To: Sunil Goutham <sgoutham@marvell.com>, 
 Geetha sowjanya <gakula@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Cai Huoqing <cai.huoqing@linux.dev>, Christian Benvenuti <benve@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>, 
 Dimitris Michailidis <dmichail@fungible.com>, 
 Manish Chopra <manishc@marvell.com>, Jian Shen <shenjian15@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, Jijie Shao <shaojijie@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1930; i=leitao@debian.org;
 h=from:subject:message-id; bh=iS/52xHmm00yvA4f+3LhpkCCrsPwwsLXrVVp0nSmqpA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpYT3wC0EEPXP0eZuMnbdZvULy9ZM30/7XaTDT5
 mXyawVGC2iJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaWE98AAKCRA1o5Of/Hh3
 bV2cD/4mA/pXu8DDFJHphL6tpfJUOrsd8UUACUtfHMiKbU5QABwVNPV3GMCeyWe0gLkJExze7Op
 0N13N6A2Nr0oNhlzOTtKEJ5lCVq2v/HI45vg/KM0pMnxqleyPDc1NIVU2sLXsvgZ4bDs1N2K0bS
 aySyoDy6E6R/BhM4h0xZc+Xm5GmPmJYrKBbWQnczoz17HSlVzBkbf0BhzrKR0KgP63aiKAV3Hnn
 BeWV1S5BsICIhgcMCj6XYwfq5bBW0tSHmhm0nJ7JIFQlrQ+Y2BDGgD6/vnre2lgC4z4y4dlvWdo
 X1lDIdUZsYom/qJG4chxMxPbNZMQQbiny+HImbQxvt8Nt4jCuGD34C2e4PbqKddoxxTqI1tY70T
 QUG9AatiMeoigR556bJtfHjSUR72qhD1baGjxRj75YP5ghr6RDEVXJR8ty5zEbOQXIZxawB/nS2
 CjipX9CNGiomnXlsyUjWeZaeTyQ9qw+6G7uVFvfJc7bwQLV0bJFtO36fGX+NSNRxi05QES4kHf1
 NJoj8D39ktxXweHYQ4ffv3B7eTD3y3wGFCERQ6PaVOBF57gYFPKu1ftdehpakh92xO4qjbU0Fma
 HqZSbpVjCq3nRQv1uzB/rD9SQwR0u8QrG26cJ6dT2+zZu5/G7zgcVnzDN9/3Cbbrx6JfEzBYsfc
 C7fYJEL5YtM+VMw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

This simplifies the RX ring count retrieval and aligns the following
drivers with the new ethtool API for querying RX ring parameters.
  * hns3
  * hns
  * qede
  * niu
  * funeth
  * enic
  * hinic
  * octeontx2

PS: all of these change were compile-tested only.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (8):
      net: octeontx2: convert to use .get_rx_ring_count
      net: hinic: convert to use .get_rx_ring_count
      net: enic: convert to use .get_rx_ring_count
      net: funeth: convert to use .get_rx_ring_count
      net: niu: convert to use .get_rx_ring_count
      net: qede: convert to use .get_rx_ring_count
      net: hns: convert to use .get_rx_ring_count
      net: hns3: convert to use .get_rx_ring_count

 drivers/net/ethernet/cisco/enic/enic_ethtool.c        | 11 ++++++++---
 drivers/net/ethernet/fungible/funeth/funeth_ethtool.c | 14 +++-----------
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c      | 16 +++-------------
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c    | 12 +++++++++---
 drivers/net/ethernet/huawei/hinic/hinic_ethtool.c     | 19 ++++---------------
 .../net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 13 +++++++++----
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c       | 12 +++++++++---
 drivers/net/ethernet/sun/niu.c                        | 11 ++++++++---
 8 files changed, 53 insertions(+), 55 deletions(-)
---
base-commit: 6ed2b32038ec31450d0d82c8bda5d6c4826b9355
change-id: 20260109-grxring_big_v1-45b5faf768e2
prerequisite-change-id: 20260108-grxring_big-95b950cf9f4b:v1

Best regards,
--  
Breno Leitao <leitao@debian.org>


