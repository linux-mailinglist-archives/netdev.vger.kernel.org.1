Return-Path: <netdev+bounces-223928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C85B7D838
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235D82A44B2
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 09:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907782DBF75;
	Wed, 17 Sep 2025 09:58:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B9630C341
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103100; cv=none; b=QwSuWzE1C0KvskwwE7UdfRg9k5lrxE+sfUNsWxwYi6CUxKo5chP0nuu81EdLjdOvssEqhrGk4naj6lB77njfMr+eNCAIh6XT5fxbvFtgkkpIP9iNzuS9iiYOQg92cvxuXra2yjmYWbMyhvnnWLwAfRtd5IsysgjJqOOb0hhhwmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103100; c=relaxed/simple;
	bh=GFL2k0Aq7ajO2IortbD5EkQeYs+1xr2kSrErJCu6IYk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jyQGQUncOjh9D1CD/UVlNuqbPJex5Jx/FlC9bb4VdsbgrzGrcTDd2AFXcG/Ce1Q/NHNqiV9yfGkZv3YZZ6ctViHm/1OR4662UAC4yDMXaomXyNbhpkWZOZuDKlHaOkfU4mRjLKbvjbs+Q/RtWsFo6VaVhpwI1Yq+aSamyqp7kZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62733e779bbso9701021a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 02:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103097; x=1758707897;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0/8ZVsNDprKIGoj9wUI/3lHS5dn8vmXry8dEtai42g=;
        b=SZ0Gkq0lDJfmeBbbfqFn85WXucKPe1uw7g8ECGl7AY034QcA0MRqu8rGpHa7OKTQWz
         aOgcse8u5p3L2dlNwP2zqPm1n5xeVZbipV9fQ+HWCWXIDQVmM2QrsBoEjPNwScabt2o7
         7bwvu1Xq6iCVIHvj8xZrzt2n4D+YiEygkzoJqq5eEYv99/TTch1LZZ2rRfoMxCuqtYTX
         abJPF5e9H4GeXn+8WAI1NLj0oHtqUbRHFOhEePZniufIK1NTt2hYGmdpfheE3lsqV3+r
         zuNzchYqUrI7WRZ7n91aNBfMeMB2Z1iqqMnWCp/x91jEDn1Vdi8RTve82kCqw3OBGhG1
         NaVw==
X-Gm-Message-State: AOJu0YyobRCUE/w9V0628RkFCYtP7Wh6GHXwfo3Eoju1/MW82DBsYL80
	PbLyZJ7mlVJS4N+6cIeivH4V26Hl1cGM+uM9LVERGcK1c0m+Cmay5MVz
X-Gm-Gg: ASbGnctGVeXrTT0r1qAo5oLRCXzTI90o3IJRkEQEKygR0sqqKQRKwnNx9+PmIye1kbx
	zDjfJzwo6osLgEO2M+LmmM08W1osv85ZO9TBBAwZ7N2unAXMq5uy2MKJ2MZKNc0mEdBf0z72DJa
	DygEfwUuB3zxN0AmVvCeaKwCDBEQKW0Vke8Ti9qbZEwjEVjs7QYjbMfF7tmP8AUcr7WNF6vDgAJ
	vye70LYyBCZsG8LfD6A9p2zE1KBVnxIKGG44KYmg+7MpfFLEfTyiYSMmy6pvPm2q9b9j0PjdnrZ
	Y3CXgV7PzDXRFQ0A+gD5hv5gVoRAfM52IC5xe58Yhm0k61O/2rTsrZ+VThqNmkBCGL5XwcN1PXH
	B9kP1gcY1OQWG
X-Google-Smtp-Source: AGHT+IElZ2/i6RqS03tpS0EA27+fg9kNKS6fSfi4gvP2vuWek+0vFMBPenYgKlsAPonbd2hhubTx0Q==
X-Received: by 2002:a05:6402:4488:b0:628:6af4:595 with SMTP id 4fb4d7f45d1cf-62f844615ffmr1581732a12.20.1758103096518;
        Wed, 17 Sep 2025 02:58:16 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f136cead7sm8461746a12.36.2025.09.17.02.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:58:15 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v4 0/8] net: ethtool: add dedicated GRXRINGS
 driver callbacks
Date: Wed, 17 Sep 2025 02:58:07 -0700
Message-Id: <20250917-gxrings-v4-0-dae520e2e1cb@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADCGymgC/2XOywqDMBCF4VcJs3ZKHG/VVd+jdJHLqNnEkkiwi
 O9ekFItXQ/ff2aFyMFxhE6sEDi56CYPnSgzAWZUfmB0FjoBJKmSraxwWILzQ0RFbIiYSbGBTMA
 zcO+WvXQHzzN6XmZ4ZAJGF+cpvPaJlO/3T6391lKOEuuipCv1slZVebOsnfKXKQx7JNEJ5nRAQ
 omFaVQttWbW/R8szvD4PxUoUfe2yRurjVL2B27b9ga/yebcGwEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3063; i=leitao@debian.org;
 h=from:subject:message-id; bh=GFL2k0Aq7ajO2IortbD5EkQeYs+1xr2kSrErJCu6IYk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoyoY2wfQwf3KaeYWACy9Jml/rw2P8JOeMPtbhG
 3ZDwJBM9y2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMqGNgAKCRA1o5Of/Hh3
 bdRrEACZX8KCKhgFbfWIy7yfpohCMJ1qPQVdET7m9jgALZPOMT+kD8RoJzt+e8MpFMnPctjH+sT
 +S6lAykehMjHgZrJcS7sTID8C4yyfrtuafk30JXkJCl8kONpmk2gdMzHS98bMy2l5T0Ti6LPi0m
 KxLVgYkFnANf3ndxdaWgIPQmblC861jX/l+WQLiKwj5cX+9FNhXkBdwUAu+g+eIyLOAhkRzly/Z
 mU0o/IXklAmMimUpH6SiLiEUiyOlMYrcTQTHp9TY7RXqQj2LZYlj1155SzbGF05lhySkIcuuUuX
 XYld9bqv+5uUZRRJtCU3cGNEeZIrxKvlPZSMaZkAsF9ezX164nStAwFurqobu6BUUtl2svDBiNa
 EIIZ76SpqJtPaPDcaR/rWCoiY8lT1IcQBBltHfmVC+dkUVfeBgEssGHmLMJmmRUcTAnBwGzf/de
 lVZ/rWd0E46pzBZQ+PJ/d0ujbi3AmFcTv9xmDtcFBu5wT6v9MHUaNvU2dtI/gYBPxXENVkF232v
 9bh24Lm1x6wfeKWoJpCjqtk3wNil5XrYaRfKTqGZIaue3bHQnYseCrPwambXmwrF6hcDV3dZghh
 ilb/kqjUjBAa3dhI5S9myMoHRGCo9hbWoViv9IabaP1kzcbzYvubaHlk9K8rslBOxTu42lcTZMn
 xkkJA/t90pnhnpA==
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
Changes in v4:
- Moved ethtool_get_rx_ring_count() to ethtool/common file (Jakub)
- Keep the check for !ops->get_rxnfc only in ethtool_get_rx_ring_count() (Jakub)
- Link to v3: https://lore.kernel.org/r/20250915-gxrings-v3-0-bfd717dbcaad@debian.org

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

 drivers/net/virtio_net.c | 15 +++--------
 include/linux/ethtool.h  |  2 ++
 net/ethtool/common.c     | 20 ++++++++++++++
 net/ethtool/common.h     |  2 ++
 net/ethtool/ioctl.c      | 69 +++++++++++++++++++++++++++++++++---------------
 net/ethtool/rss.c        | 15 +++++------
 6 files changed, 82 insertions(+), 41 deletions(-)
---
base-commit: 5e87fdc37f8dc619549d49ba5c951b369ce7c136
change-id: 20250905-gxrings-a2ec22ee2aec

Best regards,
--  
Breno Leitao <leitao@debian.org>


