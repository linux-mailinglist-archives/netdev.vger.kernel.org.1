Return-Path: <netdev+bounces-220425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32491B45F9A
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 19:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE055E077E
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 17:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F74F306B3C;
	Fri,  5 Sep 2025 17:07:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD6631D736;
	Fri,  5 Sep 2025 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092055; cv=none; b=lgFStWZf6xtmUprrgD/tqO3yvTsg4kY2//qbJrFhxUOXXs9W3VE20blh3VFIEbd43ctX9HVTHGumF/Pdmh+XtTkm0GGxFMn1dAEwxYivQp6+rhGi3cIXsE1zLbQvfgUcpzW4Nlo2CgEiYvAN3uwtSa7UiW7p34R+hXGL907dxsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092055; c=relaxed/simple;
	bh=0EOcrMhcWueCDh5l6OK0C0E4vXhFTYGM7kPjerjhzxY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UWqLm3DPwfm0GGjgidGvdVUbc3MDWGPe0J/teZzjXMyz7Yjdlno/BFH08ejyzXUXuKcErj3BDeFOTTK7F4RMHxgf2CQwopsRyqJZnq+yE+AosuPJ3XtndLAmuQZx37fRRLYiuP3JDRyjIaRlbLXg3MBVpUFHACULzO9S9tzrpHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61cd3748c6dso4651008a12.3;
        Fri, 05 Sep 2025 10:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092052; x=1757696852;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RY8BMBAiVlca/JISqNcGIbo3OoAJnUqb7CifAzyf/sE=;
        b=gOABGlws74FBUl04sVRPcc3pZModJTRHX4BHoPqgj8u3rQrO68pI+d6vrSTEoVsioH
         pQBNEy+YDuG6Y0HCp3/hZNoku2MEPEfQSQx1YsHTcl5FE2xvPlJly17QpDiyrIKJPhrV
         Vmf6YyI2/vB4ljvOfB383nrW596Jt6AnVYu/pPwj8HS3QSI3iWrvInrCsZIR11gZwvyx
         OyMJOPFZW09lMjb+SZV54fiQ7VM9Wc+0tesXeO/r58PLHVZjTqN4QzYGTNP1GUzDVe5v
         N/uBrnh90u5+qxgU/sSXDBcAjh6g294BtN7x6AtBIDR5A4kOBtNFfGP46sZVQd6Wgh55
         jIwA==
X-Forwarded-Encrypted: i=1; AJvYcCWTcHdrGmM0m6KE7tjvkdIIljIsJKncYzT7TjFpnoQxxc3uzRk7B32i5rLnXr1lkmwxV4PTX3Tga80bV+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMI+YaCty/uS1HZQBnZ8agYfLbBuvqkN7q76vAALKu/Rz25ZDV
	ueC0Q6vUyMazgeDkedj4KueqZ0TSOUodDYtolbBf/B2obUn1mSa4FfiY
X-Gm-Gg: ASbGncu0cVQWUu+ewvixMHDoY5AOYae5ZfevQ86WAC5K+UcvM8Cixj/ahW6Ye6qgyR7
	A/m7x5Et4Ls/5YwqsMruqCVi+Zu86olQVRzrH+Y9jAt8yVpWbmYkl+uh5et6Hd5k8fPt3xsYr9q
	u58EN6L0VRd2po6EGoTrZ6wgRe1KLHm9RF5PTvZwtUph/sMpI3gQvdf0fla6ESKLHp707lLwLyE
	Ll55M65DEZjBGYd2Oh07wnkNCd3OgaEiNnLY9fLg5py3/afxWqEZPUoh0GBWb9QkfqkJF1MVgQc
	E1OR0pvKKP4vZlKLhKoWJ3NXGk4alq9d15t2XFJrVRXY56TWQouSfjK/ld10/aczWuzucR9mw6I
	AgS3ubaP/VDFc
X-Google-Smtp-Source: AGHT+IHfWCGweo3JIBsmVcJNnns1yTxokeaOdlaOGQrwOC09kQZgu7y2+K/7jaIJ+9khoHwUaLyDZg==
X-Received: by 2002:a05:6402:2686:b0:61f:167:7749 with SMTP id 4fb4d7f45d1cf-61f01677a43mr6571017a12.5.1757092051806;
        Fri, 05 Sep 2025 10:07:31 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61edb0fdf1dsm6807813a12.18.2025.09.05.10.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:07:31 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH RFC net-next 0/7] net: ethtool: add dedicated GRXRINGS
 driver callbacks
Date: Fri, 05 Sep 2025 10:07:19 -0700
Message-Id: <20250905-gxrings-v1-0-984fc471f28f@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMcYu2gC/x3MQQrCMBAF0KsMf91AHOii2QoewK24CPE3zmaUp
 Eig9O4F3wHejs5m7Eiyo/Fn3T6OJJdJUN7ZK4O9kAQadY5LnEMdzbz2kJVFldTMgknwbVxt/Kc
 H7rerOLfgHBuex3ECSDko8mcAAAA=
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
 jdamato@fastly.com, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1697; i=leitao@debian.org;
 h=from:subject:message-id; bh=0EOcrMhcWueCDh5l6OK0C0E4vXhFTYGM7kPjerjhzxY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBouxjRK8DZPSlVWGynPj5+x4GgWL0TvS2RRj5/8
 w4Oo5LUkPaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLsY0QAKCRA1o5Of/Hh3
 bZa1D/wKUVjeI3P6noz6Fn3DYFnwz6ieLI5dzmURluZwQXX9jPIJTPb6sAgb9fiJLpxWavDtuJ0
 RwsHbzH72e4kBaGMRX/TT0WIsFmaKxYUJF8d+anSWr45RQey6P7r63QD+tZdYlYIq1RoX543Vbs
 7gxM/s3HVIYZc7tCDDbtTzf2lob9AZT1yEtzsXHz5H2b6pb8hLpq02exdZGqb4ia982ApBZzH/g
 9wj03iujc6mSXskf92wEnTZn1sVU3Pzqq0qm9lI6MacGj6TrwfIJBjrw0KskBPeSAqDYzevtuIf
 hd1HxSL28cm5554JZgadApVIkuAIuA7CYmvg/hN2FsW67HJgSMkYQi9K7xkHqlEKwLxJ4ZLuVay
 PAakhPI/diyAw/duDwIaok6vMwF6L9f8UFSLZzWrC5Dg9lfpH/8/IAkqEq6V0AtW1P4+Z78d/TK
 8E7C9H03fFylNT/8DIaG/gGe4ZsOlhQNb3tMnMCaGKfv4h0Auqa4smiHcxpO9n7R7oeaCl5gIIs
 eaUP1oyO/I5869ra7sry7lE2iyRHtDOxc1NiHHHSa0J5m/5jVaLl5eFXn5Z/5GeKVw65VeyTzWt
 HU53KyrUajCapscT0z/MOa3i+46Zr2GToAWpjKxaYFDlwXgcSdfwh/g2zQuBd9cc+/gikGPQKgh
 C0SjL4nyRTIvMew==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patchset introduces a new dedicated ethtool_ops callback,
.get_rxrings, which enables drivers to provide the number of RX rings
directly, improving efficiency and clarity in RX ring queries and RSS
configuration.

Number of drivers no implement .get_rxnfc just to report the ring count,
so, having a proper callback makes sense and simplify .get_rxnfc.

This has been suggested by Jakub, and follow the same idea as RXFH
driver callbacks [1].

This also port virtio_net to this new callback. Once there is consensus
on this approach, I can start moving the drivers to this new callback.

Link: https://lore.kernel.org/all/20250611145949.2674086-1-kuba@kernel.org/ [1]

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (7):
      net: ethtool: pass the num of RX rings directly to ethtool_copy_validate_indir
      net: ethtool: add support for ETHTOOL_GRXRINGS ioctl
      net: ethtool: remove the duplicated handling from ethtool_get_rxrings
      net: ethtool: add get_rxrings callback to optimize RX ring queries
      net: ethtool: update set_rxfh to use get_num_rxrings helper
      net: ethtool: update set_rxfh_indir to use get_num_rxrings helper
      net: virtio_net: add get_rxrings ethtool callback for RX ring queries

 drivers/net/virtio_net.c | 15 ++--------
 include/linux/ethtool.h  |  1 +
 net/ethtool/ioctl.c      | 75 ++++++++++++++++++++++++++++++++++++++----------
 3 files changed, 64 insertions(+), 27 deletions(-)
---
base-commit: 16c610162d1f1c332209de1c91ffb09b659bb65d
change-id: 20250905-gxrings-a2ec22ee2aec

Best regards,
--  
Breno Leitao <leitao@debian.org>


