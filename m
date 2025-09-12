Return-Path: <netdev+bounces-222651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEAEB55441
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 17:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328883BC444
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A12319877;
	Fri, 12 Sep 2025 15:59:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DC030C602
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692771; cv=none; b=giD/CSs/txnFShexB72mADneSvNs7bNpcS14XtHJdoginEOFdNT3s2gPuXXTJ4yC99CR7Ou6wasiGr1goeV88dzLcpZixbkUMqHFCkU/snWcanFprtXvcPzFz5jSzCsLYbUdB0pZ7zyg8p4NofA0aiPowpjZCFuRBJeBAQfkw60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692771; c=relaxed/simple;
	bh=N/IbfzYztm6rjlvOxD8pgVODM7w/tTKYDjq4WFCFiKU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XgOTaE8ORlsTNlzpMMHIps+mF8zQ6UU+k3sTIruaW/rOpfoBjIRFLrJg78uwcHefTTK8IEvokX5eFQ/sADLgx4pC3/yQfyDdUuH/biavbC1xL8xQxQLoh8LN8iDrVvEkDJx44L3qeBfcaBMm8d26I6yFTzs8k/7i07Ntr4p3HGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62ee43b5e96so1065545a12.1
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 08:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692768; x=1758297568;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4EvLF922o6xh90k0jchOOI1hJMbi5YioNq3mzLJ5T5Y=;
        b=kpAjSYgvSD1fhVwWEr796aglOoKb2dFmtf/fp9KCuONZ6m5SZngBQ4NwSiP4akh+lu
         z0T6N6u334w6G9kW4bt7mc1bKlxjaIF4pJkHHvKLWbNVsH33o0IpRn1ooi9lEj/p/bKD
         dS4SuENgxbc884In4OjSMGTAnq5OuTymvHUC+4dZNS0HdezLWSV8E+Sv1G5J/yNBnIEv
         yNOMREKNSZgFpCsX34u7JcgDiCGccWGVI1/KcvOXBToWTSuN37UcnXhbJ+GNuChYJZ13
         GAJJmS7u7jd3RE0e1wfsvBcNBEc0JHXRUNLokSsJCb4mAgJRPhmupqP3v3D0X3vi+KrB
         ymPw==
X-Gm-Message-State: AOJu0Yxd9tOg2uZSnAQA/0OIzJh5cRyVlSfpa4GbGNK9Gvi4YvxKbTEK
	wecuCATxQ6ejcjh2PRk5vbt5tNmWQjSC4FTUqKvnxYdq6i4Xlxl/aaF3
X-Gm-Gg: ASbGnct5gLSsSkPD8jLWUFBHmY0W9BVKpAE1QYbJj6CIcSYhAOCDWAF6yhB3vrprRGV
	I13BBSEgApHYWIHZX0zUKzh8kI9oNrE7xrLucpOIPWvTVpHTD9iSPxU3Z0iWuj7T7xv6jUrTBJg
	vAML/qAdqPF26xayeXopeVQAmtBgok55rMFp79TgYLFd0DdXIdl78GLmis5ngoc24R/L/ButrG1
	4w9WZzOu2naTq6d9gd+fPdelG/zqGp0xood5u+adgjDOJ5zZ9NZ51LPx0A9ZnQP1TNYaT7i5ziO
	Jp8cL/U08TPHYIBChRm6511Ztz69G1coBSxhjHu+NuC5/5xrNgL9dl9JV4XPDtqUSJw7nhprxCh
	j3umZMlWsMGWfN6eVoiRWCt4=
X-Google-Smtp-Source: AGHT+IF7nXKfppCZg0T1oDeoByPuGMm7/AxQ/s4l0lUlv1p/sNnpirQWVObNtStv6YhQ7tnpMLjRBA==
X-Received: by 2002:a17:907:6e93:b0:b04:6045:f7ed with SMTP id a640c23a62f3a-b07c353f09cmr340005766b.10.1757692767750;
        Fri, 12 Sep 2025 08:59:27 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da268sm391595466b.10.2025.09.12.08.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:59:27 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/7] net: ethtool: add dedicated GRXRINGS
 driver callbacks
Date: Fri, 12 Sep 2025 08:59:09 -0700
Message-Id: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE5DxGgC/42NQQ6CMBAAv9LsmZqyFgRO/sN4qGVb9lJMSxoM4
 e8G4gHjxfNkZhZIFJkSdGKBSJkTjwE6gYUAO5jgSXIPnQBUWKlWVdLPkYNP0iBZRCI0ZKEQ8Iz
 keN5LNwg0yUDzBPdCwMBpGuNrX+Ry5z+1XEol20Y7qy+lw8Zde3qwCacx+q3+EdpvoT5rbNCp2
 lT6KGzXjMfTv+K6rm942q9+EwEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2331; i=leitao@debian.org;
 h=from:subject:message-id; bh=N/IbfzYztm6rjlvOxD8pgVODM7w/tTKYDjq4WFCFiKU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoxENdao+OCMI/V6R3A03GZZi2wJ2qZih+VI3HD
 OQAz4Oj/teJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMRDXQAKCRA1o5Of/Hh3
 be4aD/4677eIqWjN+GaivFYOB2waQlJAdd5PtEqvoyZKzCciN2ZLwUv+CL3k+BAHdaTzo9ZMCLT
 VQOiK9vGWvS9zMoS0c+FbVzUle4Cc3QDLo3KnnY4CwTZ1cN3Moo+ZwI1RvXLvFzLPu8P4ROjCG8
 CE/JHoN90fusHc3X6hSHgzA4GyQvSQOGwU7EW6LYbdeKn/kA98CbgXEK0fJZ+jJ0dGJf9bpmO4O
 rS/Ko4VuvV9NqhHSIo2bVLc1c/JmGffxuPnPL3HOLOG8Wf4uu94ORR2l16wZjY0/j3coblw6fqD
 ISCD4jZo1OQcrGxhFCia/5sD5Sx1k/L6OWczduJWiIOMYwz3ttBD/bZKUX5WKod22ML7XBMqRJ9
 F5LSpqLdQ3Uet+TcpM2FycBnx9+0rAducmnxTMygeTdkc5teBTkXAXDH6Z1SL2Kp9Q45wPYaqad
 Vb5pWwznlWWIotZRFnIRtC1i2W+pdASKa3OLHBuT4yjCRggJ+AdSYFtFkwtwFipukrEYpoQeFzg
 xZ+lzTU68F+iGvT1zmq1zlCerOpG5W3JIM6Y7P89z2N8+0xaWVf4mugimFjg7YIghhSwAhNTglE
 rqpue1RtBDxjV6Js1Z84KmjPwafCdWs94F+rd9lNz0s09ZmCGeY9erBMGPOGfR5L3hRi5edoraQ
 nkmjP+G5wvxICMw==
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
Breno Leitao (7):
      net: ethtool: pass the num of RX rings directly to ethtool_copy_validate_indir
      net: ethtool: add support for ETHTOOL_GRXRINGS ioctl
      net: ethtool: remove the duplicated handling from ethtool_get_rxrings
      net: ethtool: add get_rx_ring_count callback to optimize RX ring queries
      net: ethtool: update set_rxfh to use ethtool_get_rx_ring_count helper
      net: ethtool: update set_rxfh_indir to use ethtool_get_rx_ring_count helper
      net: virtio_net: add get_rxrings ethtool callback for RX ring queries

 drivers/net/virtio_net.c | 15 ++-------
 include/linux/ethtool.h  |  2 ++
 net/ethtool/ioctl.c      | 81 +++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 68 insertions(+), 30 deletions(-)
---
base-commit: 1f24a240974589ce42f70502ccb3ff3f5189d69a
change-id: 20250905-gxrings-a2ec22ee2aec

Best regards,
--  
Breno Leitao <leitao@debian.org>


